Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7606D44AB78;
	Mon,  7 Sep 2026 10:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788775970; cv=none; b=hteCkMmh32D9TW8BCbUWNBPtC+RJAI4ni9jstOh8bPu6DfPr4o2dj9XNhsdLk1sruW6qqSkgpU2J764gBKFcjR+VZrssMkEEPqcH57XAoHtwoGMwzLS1K8pTm+T/smvwpApMek8n95GXiGFWhYQzOiCPvPJUxE8Xpo6vTu0zxm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788775970; c=relaxed/simple;
	bh=iG1YcUQXguvYFhfk76p+QLGZLI3Fkzl4LJTDLvB5C2o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gvIuOFcLH31C6xZ7AAyE4LarFV4IZ30xYIfxWwYGu0NLXxPnQ+cNQuOJHbFXjfUk+GD3Fp8vxsm9eklzDIUkQuOUrjbm4PVUE+1w5OgOY8lCnsJTFFg9J/y377eui+NIcKUHHsrEUwS1xmICrmHHjP27DZDgvrUcC98nZfHZJWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bKK0zb+m; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bKK0zb+m"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6879bX95319013;
	Mon, 7 Sep 2026 10:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=9BQN5ajOj31
	45/7qryj6JpHn4XKmNmimxxuCcpJdRoQ=; b=bKK0zb+mN0jPEkfzCavIJzC0vIF
	jueKHkYykQr/K8iizYdsUCnlaQbvXtxNstd/crhLymZ8A37Vrb7u2GGuSG7XUDn8
	DfxlM3Y0e9bCej5xD1m/2pt1LRo6tDP0wpU+beAmVo/jBr+aSxyCubIwefjLRi/n
	a7HMqIZJCJ09qv/fmtdslJi0HyzjH4SfWZYjY2YmV/CGgpUVxPr6rDFR3ibtj8K4
	0qLJmHK2mXkTDmhWsiFflYPfwKdEyPd3Do+bTwSpkjM8NgJEJV0BN6NGo61Mv+b2
	yU73UyDyM65kHnCRFrnWxyxU3nAvapS2DzxoSShv2pcdLW/1jG44Yj3YeEQ==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ghfwjj6u3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 10:12:46 +0000 (GMT)
Received: from pps.filterd (apblrppmta02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.11/8.18.1.11) with ESMTP id 687AChQX3440591;
	Mon, 7 Sep 2026 10:12:43 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-sarar-hyd.qualcomm.com [10.147.241.63])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 687ACheK3440584
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 07 Sep 2026 10:12:43 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 4160332)
	id 790CA62F; Mon,  7 Sep 2026 15:42:42 +0530 (+0530)
From: Saranya R <saranya.r@oss.qualcomm.com>
To: Thinh.Nguyen@synopsys.com
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        stable@vger.kernel.org, Saranya R <saranya.r@oss.qualcomm.com>
Subject: [PATCH v2] usb: dwc3: gadget: Fix spurious suspend event during HS link training
Date: Mon,  7 Sep 2026 15:42:36 +0530
Message-Id: <20260907101236.1543438-1-saranya.r@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260903110947.2761354-1-saranya.r@oss.qualcomm.com>
References: <20260903110947.2761354-1-saranya.r@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Reinject: loops=2 maxloops=12
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA3MDExMSBTYWx0ZWRfXxUMMmyVapZIT
 mTfk/QDHu2TePk37f+2llmXMxYhH7uvhY/j9+xc4Lx8jAIcho5LvdThEUwUAzbqNZnkF1gL9R4e
 IgqI4pbQhIAo1wMvyDdnEMf/mUWDnBE=
X-Authority-Analysis: v=2.4 cv=NanWEWD4 c=1 sm=1 tr=0 ts=6a9e8e1e cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8 a=dUsWMgTqjhcbN1arKrgA:9
X-Proofpoint-GUID: g3GQeh8TaD6EwFlypO45Gxd7ZhOqyGpQ
X-Proofpoint-ORIG-GUID: g3GQeh8TaD6EwFlypO45Gxd7ZhOqyGpQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA3MDExMSBTYWx0ZWRfX9qCqeGmQb9v1
 kZeERdyrTn6OEN51vdI/mcFkoK4plywvJmqMHHzgS2v+YFvr/dNFKNE8iFgflgc1OelyCR8ZIwe
 DsnWDGDwtDOx6x3JVm1aogCdhnSJRhrJKxxNiweTH9JMwrsNoytZk+eSnLmGHXDbi8FS5IGtKIu
 Spj4/KoUpFMUGvKxQS0GscLDD1u7ze5njXV2T6xCaCLSiQxSAJWeuyLmtDQLAOkPNS7uHsbRF95
 yKhGXZ7CGDbubHyw885HHe6voDdSpYQ00AZrj7VCruolWI49RZQGaxOK5FBX3eK5LCOHFQMBexd
 B1sqz/r/FcbxNVbff7ZuBCU42gSXNFYjiibYfgaj7CypNvMDdhzK0Fv3092avgbXagMFzUciBFr
 D0DXP9YXBc2ZUOLf9ORgByvVjp5gV0BPpqXrT1/w2obkCTcBY3ynlbzdYO59qH1GCPRhCBzZbfs
 nJyvaaTp4A0NECLJP7Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-07_02,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 spamscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609070111

During HS link training, a spurious DWC3_DEVICE_EVENT_SUSPEND carrying
link state U3 is fired before CONNECT_DONE completes enumeration. At
this point gadget->speed is USB_SPEED_UNKNOWN since CONNECT_DONE has
not yet run. Calling dwc3_gadget_suspend_interrupt() here triggers an
unwanted composite_suspend, causing the charger framework to drop
current to 2mA and then ramp back to 500mA on every USB connection.

Fix this by skipping suspend event processing when gadget->speed is
USB_SPEED_UNKNOWN. This precisely targets the pre-enumeration window
without affecting genuine suspend events: a real suspend at ADDRESS
state (required for BC1.2 compliance) only arrives after CONNECT_DONE
sets gadget->speed to the negotiated speed, so gadget->speed is no
longer UNKNOWN at that point.

Signed-off-by: Saranya R <saranya.r@oss.qualcomm.com>
---

v2: remove Fixes tag and add cc stable
This issue observed on 6.12 kernel.

---
 drivers/usb/dwc3/gadget.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fa944856f956..a3a59d9d92ef 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4540,8 +4540,18 @@ static void dwc3_gadget_interrupt(struct dwc3 *dwc,
 		break;
 	case DWC3_DEVICE_EVENT_SUSPEND:
 		/* It changed to be suspend event for version 2.30a and above */
-		if (!DWC3_VER_IS_PRIOR(DWC3, 230A))
-			dwc3_gadget_suspend_interrupt(dwc, event->event_info);
+		if (!DWC3_VER_IS_PRIOR(DWC3, 230A)) {
+			/*
+			 * A spurious U3 suspend event is fired during HS link
+			 * training before CONNECT_DONE sets the gadget speed.
+			 * Ignore it at that point to avoid triggering an unwanted
+			 * composite_suspend. A genuine suspend at ADDRESS state
+			 * (required for BC1.2 compliance) only arrives after
+			 * CONNECT_DONE, so gadget->speed is no longer UNKNOWN then.
+			 */
+			if (dwc->gadget->speed != USB_SPEED_UNKNOWN)
+				dwc3_gadget_suspend_interrupt(dwc, event->event_info);
+		}
 		break;
 	case DWC3_DEVICE_EVENT_SOF:
 	case DWC3_DEVICE_EVENT_ERRATIC_ERROR:
-- 
2.34.1

