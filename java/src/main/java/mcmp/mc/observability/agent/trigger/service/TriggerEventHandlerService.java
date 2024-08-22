package mcmp.mc.observability.agent.trigger.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import mcmp.mc.observability.agent.common.exception.ResultCodeException;
import mcmp.mc.observability.agent.monitoring.enums.ResultCode;
import mcmp.mc.observability.agent.trigger.mapper.TriggerHistoryMapper;
import mcmp.mc.observability.agent.trigger.mapper.TriggerPolicyMapper;
import mcmp.mc.observability.agent.trigger.mapper.TriggerTargetMapper;
import mcmp.mc.observability.agent.trigger.model.KapacitorAlertInfo;
import mcmp.mc.observability.agent.trigger.model.TriggerHistoryInfo;
import mcmp.mc.observability.agent.trigger.model.TriggerPolicyInfo;
import mcmp.mc.observability.agent.trigger.model.TriggerTargetInfo;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
@RequiredArgsConstructor
public class TriggerEventHandlerService {

    private final TriggerPolicyMapper triggerPolicyMapper;
    private final TriggerTargetMapper triggerTargetMapper;
    private final TriggerHistoryMapper triggerHistoryMapper;

    public void checkTriggerTarget(KapacitorAlertInfo kapacitorAlertInfo) {
        try {
            System.out.println(kapacitorAlertInfo);
            Long policySeq = Long.valueOf(kapacitorAlertInfo.getId());

            TriggerPolicyInfo triggerPolicyInfo = triggerPolicyMapper.getDetail(policySeq);
            if (triggerPolicyInfo == null)
                throw new ResultCodeException(ResultCode.NOT_FOUND_DATA, "Trigger Policy is not exist. PolicySeq : {}", policySeq);

            List<TriggerTargetInfo> triggerTargetInfoList = triggerTargetMapper.getListByPolicySeq(policySeq);
            if(CollectionUtils.isEmpty(triggerTargetInfoList)) {
                log.info("There are no matching trigger targets");
                return;
            }

            List<KapacitorAlertInfo.DataInfo.SeriesInfo> seriesInfos = kapacitorAlertInfo.getData().getSeries();
            if (CollectionUtils.isEmpty(seriesInfos)) {
                log.info("There are no metric datas");
                return;
            }

            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'");
            Map<String, Object> params = new HashMap<>();
            params.put("policySeq", policySeq);

            for(KapacitorAlertInfo.DataInfo.SeriesInfo seriesInfo : seriesInfos) {
                String targetId = String.valueOf(seriesInfo.getTags().get("id"));
                String nsId = String.valueOf(seriesInfo.getTags().get("nsId"));
                params.put("targetId", targetId);
                params.put("nsId", nsId);
                TriggerTargetInfo triggerTargetInfo = triggerTargetMapper.getTargetDetail(params);
                if(triggerTargetInfo == null)
                    continue;

                try {
                    Date parsedDate = dateFormat.parse(kapacitorAlertInfo.getTime());
                    Timestamp timestamp = new Timestamp(parsedDate.getTime());
                    TriggerHistoryInfo historyInfo = TriggerHistoryInfo.builder()
                            .policySeq(policySeq)
                            .targetSeq(triggerTargetInfo.getSeq())
                            .targetId(targetId)
                            .nsId(nsId)
                            .name(triggerTargetInfo.getName())
                            .metric(seriesInfo.getName())
                            .data(seriesInfo.toString())
                            .level(kapacitorAlertInfo.getLevel())
                            .occurTime(String.valueOf(timestamp))
                            .build();

                    triggerHistoryMapper.createHistory(historyInfo);

                } catch (Exception e) {
                    log.error("Failed to record trigger event history. Error : {}", e.getMessage());
                }

            }
        } catch (Exception e) {
            log.error("Failed to ");
        }
    }
}
