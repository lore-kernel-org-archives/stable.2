Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D4AD3EC802
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337456; cv=none; b=G9tsddCUNVoat/w4+3c83uyEkOaLZS0tuxMvSmbmz/BvxweCuKq/vYnr4DHznn98N4Bcx22jhrTNx3e0rJqw/fO/bQ3yfFusMLXR8KyJ232lfaV1HY5K2Wef33zYM59YmwgwpnZgVpcfJR74/FuMkykmJFLGpLetmBG2S/3bn14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337456; c=relaxed/simple;
	bh=803aKFp4OIVkBMAz9uIg9d52Sa77+YG12xq68K7Ds84=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LmJDch5Vgu5yLv+kW0dEvr/3tcVfh71fVEOL/IRt4v73zc22zxpPBPcCAtyvNWsjGMz+hB+k+UOavhw+/ifLfyUuR+sX0eqnDo3dl5lRtIRJG4yCPJnPwcobCM3qKDRtXM/Po3wFNX+umDG83e5a7UXWB9+PWLQhmh8/rnu+s4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TYrJOUh0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZgPqLf9P; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TYrJOUh0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZgPqLf9P"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TF3JJc2195030
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yEZ73+K9ogR
	hH77NTh4PryNihcnQiKlvrThl3BlnmkM=; b=TYrJOUh0ZejOT59fzi7dhj8O4D7
	VD8NKb7EC3CTlMnlnOBL3oKuwbVsim30PxxHxE3VclGwgOn7E6RlRCbmnJXCG2Yx
	9trjS8c3unU47VVj5c09ykniLES9qcY31QKW539KDNEEx8aSsKYDy8JgbXyBoH50
	ZHxSfCdvc36NEj8qlZGGYzEERJw+cjepYx0XgraXz1OKeMIU6plXOv2lA9aEB/Bc
	V3KUi02GfA79aNWrdW0tHKNx2Kdgd1SL7SY4hBziY487fdciwUi4bfByrq+MnXp6
	GTiuH2iZvEn6eMOJ6+pfL6s/p9ON3aQRj0v3R42ruFEj4MFDghRUXMWSaTA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqkfm84a6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 15:04:14 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-74ab80df960so922135137.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 08:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785337453; x=1785942253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=yEZ73+K9ogRhH77NTh4PryNihcnQiKlvrThl3BlnmkM=;
        b=ZgPqLf9PhEi45HUM8dQMYR9KJNzdJsltpAXqzjPXSa76uqwer8bLWjfoWbY3GXw2+X
         qWTZ3MwLDVtLGiV8NW8Z+XWsmKqOUwF0G8HeSDyF6cl76+Xw3mgcKA8YFp2pTgRjh8vR
         sqibYt0Etd6D/uLRN3x4oZwVrvFlgu/2BIsR0Jb64b2/BiPfsdsHuSs5vdZRHHvpU0r1
         WrVPWEOga3kUp5rabCKCLjPbRDj9RXx0VmG1u7rExdutzUXT9QZtHXWbykAaInOri93W
         hPKvpLiSssEWm7Cg1sMeno2MWaS1fFxD0y9KmM08sKeAxbWLS5oiIkcOvj+loEGYjrwm
         zSpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785337454; x=1785942254;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yEZ73+K9ogRhH77NTh4PryNihcnQiKlvrThl3BlnmkM=;
        b=hQ1wqmKL9c182XLxbMyf+6ObxdBLrbltdxWcKdmE/+yq94IpL+aP6UmeKbKyHO+lFn
         C85e5TNgSfk5hwl13T7ZGWiLnFDCcOmQg/Bp8LvWkFLa8pqObBQD6FxMA3Padls1aJTC
         ra7wBM5Vbu2fmxWBV4EZ4NJQ+cwC81+bdK0tZa8gQQQfjiPcRFoL9Kc+2WylSeRHnQJF
         KNM3HAaVIP+aDZNalEHtCmACbuY6G/+VPava/7iaB1V5LXirEClOjN5YIeLZfYTdBqXE
         ZFaiukgBnOL4Dxux7K3wyNwSjnFQTVJ5cSL2jczVrV5eyvnix9bHKufCck5ijPe1lofw
         bGFA==
X-Gm-Message-State: AOJu0Yzg9ATU6f8hEmXcG333T1t9FowpNIS0bVu0SwFMpw20FiPxgkPY
	f6pKisxOHsr2yf2sTjt4yDIsBz2eJyXFpMDzfQC6rKi3Dw7taw9YXc89ruYbo/+OeXzBMX1YNO0
	2xxAUVz+4jwfUClVp6kHzr236rI5x8RXPhx2NYuIj2HM6uxLFoVEv2frV7h4y326OXh5ElA==
X-Gm-Gg: AR+sD11NZUX0qZP634k1CTWUfoh+/6x+KyGqC0ldkaznPOzt7mlNakPWmo5Xju15l+A
	HFJq7gdBXl56hgRuJWKiZnSlnO7ayME+//ZoR6ntvUmy0srnNU45x8NR092PkdYojiRjoO8gY2s
	TVjm6iPP/Qqk/f4NLvbeVOqApluhzGQywwRxu4a8e/tsk3WpCtZxuKzzLcojF3UJpRPjdOK6z7r
	bSCposVPoZ4yX+TWsjrzHfprLuh+DOVuhZWnsDAkNEfXd9ETpy39wLWhXyaMlofvcgR0ItJQSS+
	eIY2ReOgjS0N3wanzJpJ7spfSFanaEWEGdPWOk7U0tzh+K6xnMxlwa8N7jZ5pnVZiaC0lPByKHb
	k5jgNaPS6hs4DBuq8uffBTp/BClEpaIdN97BYurUN
X-Received: by 2002:a05:6102:3911:b0:73f:63c5:f54e with SMTP id ada2fe7eead31-754a31c5c69mr3263009137.29.1785337452946;
        Wed, 29 Jul 2026 08:04:12 -0700 (PDT)
X-Received: by 2002:a05:6102:3911:b0:73f:63c5:f54e with SMTP id ada2fe7eead31-754a31c5c69mr3262936137.29.1785337452288;
        Wed, 29 Jul 2026 08:04:12 -0700 (PDT)
Received: from hu-yabdulra-ams.qualcomm.com ([212.136.9.4])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1f8401ad2fsm125138966b.60.2026.07.29.08.04.11
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 08:04:11 -0700 (PDT)
From: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y] net: qrtr: ns: Raise node count limit to 512
Date: Wed, 29 Jul 2026 17:04:11 +0200
Message-ID: <20260729150411.3885823-1-youssef.abdulrahman@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026072918-magnifier-fleshy-5147@gregkh>
References: <2026072918-magnifier-fleshy-5147@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=D6p37PRj c=1 sm=1 tr=0 ts=6a6a166e cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=dNlqnMcrdpbb+gQrTujlOQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=xbQBGh1BD93CNvSBCI4A:9
 a=crWF4MFLhNY0qMRaF8an:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: 5nkljazA5KNcXj5j6hqpFLsOxLODf4l0
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfX96XtQiajf5B1
 kfDyO+UVW/jlszIh0EM00wYaBi1AL90b4xoqJxSUHrjAg9ghr4tMFuGlcybLvXBXe11jmf+CByw
 C5YJ+H2CUlyvfjggxvTcF0TtUuDF3wc=
X-Proofpoint-ORIG-GUID: 5nkljazA5KNcXj5j6hqpFLsOxLODf4l0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMSBTYWx0ZWRfXzKM779qv7u87
 yCJ5uw2Tm/n68e0yy/K/SwrAy0INTI08lzmPaSH/WknOg1Ekb/Op7Xhge234IWW8B9Qvggqpw4T
 1DtDFka+5hKQ7+ftQ878A+s118qhQGxXwssEaBKsTSku9P9etruySNhQ4i41rfcVKvlJ7lwf/NK
 NP74SfbKC5BaolPklZcC9FuIDIdeyxGVTvFdP+z9Xi3NYzkqNcEurik9llVxFvBOkuSmVQdCYgP
 UlHmpIBqp1OaQ8Da0umQRE4DG1jhwiSPXUgh6h8YaD5UjMAdQMewrR9WNTsp6okmZ7qvWWXZwVA
 5rE0YvweFE0XpJ98DKkZkDTOqnioxlClrOD3hGWh2hHfVNUVvD5ZZ0A9nlzT9KGqgAE+kDz9ieX
 Lqrx+3Jdh5l8nhhMjqctsp6LKZSDDN931WCArs8h9JvT8hY59gb8IFEgaTjXyjDz9IEfslnMtZM
 aW24eUZgxD/sIV5PXzg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290121

The current node limit of 64 breaks the functionality for a number of AI200
deployments that have up to 384 nodes. Raise the limit to 512.

Fixes: 27d5e84e810b ("net: qrtr: ns: Limit the total number of nodes")
Cc: stable@vger.kernel.org
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Link: https://patch.msgid.link/20260713145901.212396-1-youssef.abdulrahman@oss.qualcomm.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
(cherry picked from commit ff194cffd586cbd4cc49eccb002c65f2a902a277)
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
---
 net/qrtr/ns.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/qrtr/ns.c b/net/qrtr/ns.c
index a10e8de4f7e1..e8e3ba1b3b82 100644
--- a/net/qrtr/ns.c
+++ b/net/qrtr/ns.c
@@ -85,9 +85,9 @@ struct qrtr_node {
 /* Max nodes limit is chosen based on the current platform requirements.
  * If the requirement changes in the future, this value can be increased.
  */
-#define QRTR_NS_MAX_NODES   64
+#define QRTR_NS_MAX_NODES   512
 
-static u8 node_count;
+static u16 node_count;
 
 static struct qrtr_node *node_get(unsigned int node_id)
 {
-- 
2.43.0

