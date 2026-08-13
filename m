Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE50485CE7
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 15:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634103; cv=none; b=DmKMMqhGbwIiZYvT9MCRUKjF7Afth0zeDjh2cJFuR2DU1aHGOlz/4sYxjkZft3YS1YPBfxqqTXuaEDUcvBgDnoXqyHGcn8ZRXTgqJUJ8UVO2LB1NMwt7re/uHLlemglSxMG7vLQObWBgk6wJRotjCHjzQy6hA2zB2Hu5ZwZPhV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634103; c=relaxed/simple;
	bh=elW128aOH5J4nyGnJf/yqtTxEUc9WR6CRa7BhXSkiYo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kytUxH10CcfeqqTVwPIDtMpSZ6o+udzBxBDVSngXvRmP1T5MUdXsG+EpYEIp+zPWGIyRtGJH2mr/OG4KgAZosvMxA23mK9S2X7E9xn+klz+PEgL5pLrDwdeCoQqdMNz0bEM8a9z2qixwYvt+xDufPrPxiGBxgl12a3LTfjt3DfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=RMsGCaa6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JUU++2ev; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="RMsGCaa6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JUU++2ev"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCJq962359473
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 15:15:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=oGkhc3VcH9UfbYfwazrmmsuyDoSDIflf9JS
	7FTGpS7E=; b=RMsGCaa6bVLffMwrpzw3zK+DdAs5aaEQlFRrQuXb6y4N5clLt/k
	KVQ9wtgNuJYv49Ux0R9yls67L5plcYiz4bmOXjezNBoUijOl6flIVg8sBf6qZUMs
	K/10HkfhzjhnPSMcP6QoJtP4Vyya4MNSbCEvjTYXdeQJhW+evKr1Lv+bIvlOaR1W
	5G9LbvO5t8aKCzTURxyUb0LCfmPcYMkzXJraValXx2AUdyvTitvSQQ4uu/L8mIIo
	TLCBLBDLck0gdcxOV23x7HZaOYp7Ik79UysCvyf0eFszDWZoqNJZfDIDLPd6Mpf9
	HPw5njjH5K4OhEnj33rpajjqG1wv8zZtapQ==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com [209.85.128.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g1cb5h5rq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 13 Aug 2026 15:15:00 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id 00721157ae682-81eddfe28b4so25446037b3.3
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 08:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786634100; x=1787238900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oGkhc3VcH9UfbYfwazrmmsuyDoSDIflf9JS7FTGpS7E=;
        b=JUU++2ev3eybTlpSuRe21WbrLHZtq/dZW3U/OrQieZlIJ6cYt8C1dX4GrEfc4N8Wmd
         CEqfm2A6vsWvrFq7Q0Ac0OSLhlaxDhHt5Kz7mEowx1g7O0iatNMqpbkjCwv3Jk69kAJO
         vRY5WhyypejQMntSj1eOsP8mKgeXHZuH7n5BQdMtJHl8GSKnMrVWXZeACQPd/V2KtTVL
         t4FRefZ5Q1v3T+/E9ogHyKiMe7PT/3j5HfD/iWbj3kP9JIS6n3zjnUBCtAZg8xhZ+5ap
         4S+0cPzBT/g2teraYECRMyqjNRPjLb+ffgtX8ui+Ee57wF1Sk1bVH0pqlYfzmk83LyN6
         q3qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786634100; x=1787238900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oGkhc3VcH9UfbYfwazrmmsuyDoSDIflf9JS7FTGpS7E=;
        b=Tjp5BQAp0VYFK5lTXVwQ6SlCbfvTme85bB+Jjc8iI0bttrW/7PLHTdyAh96UI6EUpt
         Dlvb2YPnHOdfaGGJHelwnvXgLGuaLVHDpgsrb+NXAsF+9OL9Jokz/YJXwaGrUxNh3/Rr
         fO4ZS8DKo+Ibe9Wacy+x2Rra046bOsPNHih0JX/aUDktHrtQPpXktMI/d6vYFga1cvs6
         6Pl/6zl+CBl6abLcjS1SWrVn5y0c7uuJGjxent9E0H66SEo8tIpVH5UT21JbaD05FHZC
         IM/fuZ5O9UDXpav7n/7cGFmLD3DAaQBPEh7pGBmk836ibzri09E8DOpn/7du7ZBGXaRX
         6KtA==
X-Forwarded-Encrypted: i=1; AHgh+RocSwGvTflKLFEjrKQuta5krETXeCDgc2l/AexRpNK0x2nV60XiNDP6iFTRH/Q6SmuqRygIXUk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwcmTWIKob2X4YQ4QcrA+8JZaIOp0KA+9art0mkAgdsM9+8shI
	9YM/HlFGE09RShPA/WVNGjLfPmWRtsxIXGwzOJTl3QsHjkKV8XjFGlIKFYkvS2AELwdoQ/AI+Iu
	Wz5PxUthnE8qP6BIPCVPby57pu+x98IUqlekn6HqAm05usEL3LDAtGgVpayzslKUrFgs=
X-Gm-Gg: AR+sD10erTtcaeQeEUJURZlgbt/NBcifBW9NUmR9TyU+NV1nWjPuj7B7JIYLd2ljWV7
	WHLtCD92PesyGvA80+7pwOy8L+7uCCOvQU0xlP3tSt7Zvtk4q85PRxVYAAgEcBjv52i+b2cS3QZ
	v6IA2wVBhnbqF+xRU6tOW5smJ6V4LrcxeOI0xgXHg5aPPZYsPORP9f0cPMHmisHqaxsqQfHGmNC
	i6d7seaSVDKiNoi1Evw9jdow0pzNS6PRooGao+nMML7yCT6jNgVZlcaRRzKZg+dK5fNf0CW4VM7
	J4MYi5LBkV107lkfdPws8OErLQmEJtCRZK2tJ7n40wi1dM6uWQRc5y928WiQQqnA1uRZHPKZDtT
	WVd9cXkl9tjO8x6Yw+3FOZep9smFoFnSeztPosZ4sMIdr2qOyz5gBPA==
X-Received: by 2002:a05:690c:5706:b0:80c:5ce9:8f29 with SMTP id 00721157ae682-83474fa2f29mr24944787b3.22.1786634099632;
        Thu, 13 Aug 2026 08:14:59 -0700 (PDT)
X-Received: by 2002:a05:690c:5706:b0:80c:5ce9:8f29 with SMTP id 00721157ae682-83474fa2f29mr24944577b3.22.1786634099082;
        Thu, 13 Aug 2026 08:14:59 -0700 (PDT)
Received: from hu-eserrao-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836bbdb427dsm314987b3.11.2026.08.13.08.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 08:14:58 -0700 (PDT)
From: Elson Serrao <elson.serrao@oss.qualcomm.com>
To: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH v2] usb: dwc3: clear forceRM when issuing EndTransfer
Date: Thu, 13 Aug 2026 08:14:56 -0700
Message-Id: <20260813151456.867008-1-elson.serrao@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: GBFytfGRu1mjp_e3TZD8TMMzY5XmVk_1
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDEwOSBTYWx0ZWRfXz+ShR+OLQq9V
 8K3cbe+48yGdaXyqN3ETDbMKlsjCL9Kyt87C4DrIo2CuY5G4YVzmh+qCOvfWMiyp2jmPaRVAor8
 p0yC4hZJEEE1aDlYdFSRsU4GMHbMC7M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDEwOSBTYWx0ZWRfXws6viCT7uUV3
 oChfW3U1CZGt/X+Ik7/AAAHZZGonfurUWeB8uujtf2g6RUtZz8LwRSTpgsy8funaVpgPWOptiuo
 3LDnNE4RZHGJtBp8O4Qgfj/OwM6S0qhsIyISo1VDxj2Cc6FYgwxVTzEO4pOGTVdOzCio881KjTa
 HPPjXvSj86uGNKSnfgUR6JKLpDtLUXXOVLJ4UzmubZ+YVeerUvwvQz7hDNWOekHVDXXFnyu+4i5
 aLcS6d+/yNHDaEhxcN/nQvafSD3xzcurxVtPDCaXlFpYuIQG4/lmm5ANWt8zOE+Gji6YVgeIWK5
 jGvKK1LIKsWy7Lx+H4g8FAfGFWmko3GLYjAmvV0zSILhwTnOuDK6PF5hOAtVrtqdG5jXnJ2exuT
 EuuEGMhSayYxJhyhr+F49E8wDAmYIq99DKZ06+agFRzey9uBDuGA8rd1Td084o58e4oDRL90ZjG
 C3iZm1vHUV2AJGUqbsQ==
X-Authority-Analysis: v=2.4 cv=GoNyPE1C c=1 sm=1 tr=0 ts=6a7ddf74 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=o_ZYxRPx-Uo3p7AnxY4A:9 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-GUID: GBFytfGRu1mjp_e3TZD8TMMzY5XmVk_1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 adultscore=0 bulkscore=0
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130109

The forceRM bit of the DEPCMD register controls the behavior of the
EndTransfer command used to stop an active transfer. Older DWC3
programming guide revisions recommended setting forceRM=1 when
issuing EndTransfer. Newer programming guide revisions recommend
issuing EndTransfer with forceRM cleared.

With forceRM=1 on DWC_usb31 v2.00a and v2.10a controllers, a transfer
aborted through the ep_dequeue path was observed to remain active
after EndTransfer completion. A subsequent StartTransfer issued on the
same endpoint triggered writes associated with the aborted transfer.
This resulted in an SMMU fault because the transfer buffer had already
been unmapped during EndTransfer command-completion cleanup.

Using forceRM=0 eliminates the issue. Although older DWC3 programming
guide revisions recommended setting forceRM=1, no issues are known
from using forceRM=0. Clear forceRM when issuing EndTransfer to provide
consistent EndTransfer behavior and align with newer programming guide
recommendations.

Fixes: 1e43c86d84fb ("usb: dwc3: core: Add DWC31 version 2.00a controller")
Cc: stable@vger.kernel.org
Signed-off-by: Elson Serrao <elson.serrao@oss.qualcomm.com>
---
Changes in v2:
 - Clear forceRM unconditionally and document the programming guide
   recommendation (Thinh).
 - Link to v1: https://lore.kernel.org/all/20260806234035.1078704-1-elson.serrao@oss.qualcomm.com/
---
 drivers/usb/dwc3/ep0.c    |  2 +-
 drivers/usb/dwc3/gadget.c | 21 +++++++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/dwc3/ep0.c b/drivers/usb/dwc3/ep0.c
index bfe616194dfa..310b5ffb236a 100644
--- a/drivers/usb/dwc3/ep0.c
+++ b/drivers/usb/dwc3/ep0.c
@@ -304,7 +304,7 @@ void dwc3_ep0_out_start(struct dwc3 *dwc)
 
 		dwc3_ep->flags &= ~DWC3_EP_DELAY_STOP;
 		if (dwc->connected)
-			dwc3_stop_active_transfer(dwc3_ep, true, true);
+			dwc3_stop_active_transfer(dwc3_ep, false, true);
 		else
 			dwc3_remove_requests(dwc, dwc3_ep, -ESHUTDOWN);
 	}
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fa0f16ffafef..dad9866b908e 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -1004,7 +1004,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 			 * controller to generate an ERDY to initiate the
 			 * stream.
 			 */
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true);
 
 			/*
 			 * All stream eps will reinitiate stream on NoStream
@@ -1032,7 +1032,7 @@ void dwc3_remove_requests(struct dwc3 *dwc, struct dwc3_ep *dep, int status)
 {
 	struct dwc3_request		*req;
 
-	dwc3_stop_active_transfer(dep, true, false);
+	dwc3_stop_active_transfer(dep, false, false);
 
 	/* If endxfer is delayed, avoid unmapping requests */
 	if (dep->flags & DWC3_EP_DELAY_STOP)
@@ -1720,7 +1720,7 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		if (ret == -EAGAIN)
 			return ret;
 
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
 			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_DEQUEUED);
@@ -1757,6 +1757,11 @@ static int __dwc3_gadget_get_frame(struct dwc3 *dwc)
  * the controller won't update the TRB progress on command
  * completion. It also won't clear the HWO bit in the TRB.
  * The command will also not complete immediately in that case.
+ *
+ * Older programming guide revisions recommended setting ForceRM to 1
+ * when ending a transfer. Newer programming guide revisions now
+ * recommend keeping ForceRM cleared, and TRBs are properly updated
+ * on command completion.
  */
 static int __dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force, bool interrupt)
 {
@@ -1882,7 +1887,7 @@ static int dwc3_gadget_start_isoc_quirk(struct dwc3_ep *dep)
 		 * to wait for the next XferNotReady to test the command again
 		 */
 		if (cmd_status == 0) {
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true);
 			return 0;
 		}
 	}
@@ -2165,7 +2170,7 @@ static int dwc3_gadget_ep_dequeue(struct usb_ep *ep,
 			struct dwc3_request *t;
 
 			/* wait until it is processed */
-			dwc3_stop_active_transfer(dep, true, true);
+			dwc3_stop_active_transfer(dep, false, true);
 
 			/*
 			 * Remove any started request if the transfer is
@@ -2242,7 +2247,7 @@ int __dwc3_gadget_ep_set_halt(struct dwc3_ep *dep, int value, int protocol)
 			return 0;
 		}
 
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 
 		list_for_each_entry_safe(req, tmp, &dep->started_list, list)
 			dwc3_gadget_move_cancelled_request(req, DWC3_REQUEST_STATUS_STALLED);
@@ -3368,7 +3373,7 @@ static void dwc3_nostream_work(struct work_struct *work)
 		dwc3_send_gadget_generic_command(dwc, cmd, dep->number);
 	} else {
 		dep->flags |= DWC3_EP_DELAY_START;
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 		spin_unlock_irqrestore(&dwc->lock, flags);
 		return;
 	}
@@ -3725,7 +3730,7 @@ static bool dwc3_gadget_endpoint_trbs_complete(struct dwc3_ep *dep,
 	if (usb_endpoint_xfer_isoc(dep->endpoint.desc) &&
 		list_empty(&dep->started_list) &&
 		(list_empty(&dep->pending_list) || status == -EXDEV))
-		dwc3_stop_active_transfer(dep, true, true);
+		dwc3_stop_active_transfer(dep, false, true);
 	else if (dwc3_gadget_ep_should_continue(dep))
 		if (__dwc3_gadget_kick_transfer(dep) == 0)
 			no_started_trb = false;
-- 
2.34.1

