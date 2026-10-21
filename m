Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792555874;
	b=iq9f9J600wilxfzKCDDMhVCFm/EN7IwYi9CvB7+DJuKw1WXzSmJKXAd+kzau3RxsHfBb
	 bwu10KnNH0Iwe30h9Ng+TiqTt+S0fFtbXPTXBsdJ1CLLa3YRICWo+DO93EeXUI+ykoftJ
	 4+HAAbL17yAZdqZwnjPXLcV7yHzb1p1SFtKWiq12vhEoVYNzBmeEwwJr8MGjzzk5gipW1
	 Ow0kStZfx5WpVhqzaNJ9Q7AEZw4fAov6OaeE5eJXXBjuG8uvWBsmnMSOana3ywpIc2L72
	 td/Z0DuLc66F7sCwmeRpqoUYWVefpIMD0qXULAsUACXJOgM6Mj342EXKBP/ZnCQhtLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792555874;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=5zA0Rbfy8As1tn/Vj7thw7Vz3e4ADheFVIdzKIvos/I=;
	b=vdKa2kJmlaAjn06/YlJ2S2G8Lck06Ip0wERkwxuNfrAU4cesAP3SBPHkD9GKll49n156
	 4yvxoJtX8ewIHyx0ToQBcQFZ18nAAlNapy+w0/2NS7nJ+Cjvlrt/eYG5reHQvAYc6+YYb
	 tzaKHYifGQVy2rUutnt0/3xyaxBrnESKZFJauf+6HBDifHxke+S74UvpTHjVzWZuhOTD3
	 BtK82CRCSoqQihHfSQYy5WNakLB662xCgSVKHVEaM0YPpHgCO89Saxv39DiPuirZWvWQ6
	 Uc6N2fWDd+8VjhIPancZrYYhrHIuijB32QxNmxRGPxwOM7EOzOKj+2sYXxCImGAQX1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E81QFQEG;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iHqLKkw7;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4082D606A32F
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 04:11:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4082D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=E81QFQEG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=iHqLKkw7
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L2FUbA1957095
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 04:11:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=5zA0Rbfy8As
	1tn/Vj7thw7Vz3e4ADheFVIdzKIvos/I=; b=E81QFQEGf3F3YRiQIo+9COzUgEC
	NLj7QRd5rGi2pQ86kyUv1mWrL2/uPx0VQgJ07o1BTBTeYZt7RdCfCcv+1NtdXw24
	2ht8ndf6Tsbvvbu7aQ7dFJXz04GCcYB/zMKJuiksSFaFKONdOxReLgScYVVlwNAk
	asXCiFzBuzyhcKA+d9wW7lxzYQwhe2pRUd0e7ckZnhZG71h26FEvQHWlMtbU1ebC
	mIrhxFcsEjO+mpAEw2eIe9KciqkqRvxdZ2ovCKFapq4D8Xk3U/nmr3vcSYPkCYTS
	HUmFF9durhAdZbWoLvqNVy+jDMkXAyb39XlXhQ+wmnvV1plYsTLb5WzCCvw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7hvbcmv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 04:11:13 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-151ba226e1bso537913c88.0
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 21:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792555873; x=1793160673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5zA0Rbfy8As1tn/Vj7thw7Vz3e4ADheFVIdzKIvos/I=;
        b=iHqLKkw73mS5i2X3+3ClRxPDfb5wa8Qt4fccELVY84V/HpYWGFfqB+XjANy3xVAg9t
         3obk9nDqDoBdF34f/Iu1ROBpmqIAkrV96PeJ1CGLnPUGYdoDJ0ndhhxWMAErlJ/pxKuZ
         mbTwzMwBZzca1YFlfudt1NvvTfys6/0EJoaTlmxo+lCJ/QmTEbcK7kEeo7XKUjK6RliP
         NYqdoaNMmbr8WR5qRuGlgSL4F0SdFdi04M5JT7zCFKjJhY4pYNAnNAb58SEfkpp9g1h4
         YLku3m+guBFFxNFgfWux+ymxvIRcGKxBURIJqvgmV7qHgZYk4nm/DDt7o9M/GZAcaFGv
         V15Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792555873; x=1793160673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5zA0Rbfy8As1tn/Vj7thw7Vz3e4ADheFVIdzKIvos/I=;
        b=SeWjH2en0h/EdNE5l8H1q7235e9SGvfYob5i1P2YUAQW6ft2Xs7PirTq4AI2yserdE
         90g9TvtVBnZzjCgUTi4/hTSb699rv0eib1od2q2YNBujZXbdXfpYrTZ2JwEZ/pug2A6u
         YRH+968qvT+uErlImECTfOSFfYEujvRDMV51fqokssarpUpqQ71N8ZLkHV+rEv6LJ9Es
         VJaOMIYB7CDWHfOQGAifhlkcjo6kfm1xVC3O6hrWyZ+8oeI1NwWid+5+nafqo1GN66LR
         ukPIVoQoy44JkiYy6+P/HJX7P7djGy0P0/lWs8eN6AsRTT3+w9xIPzQo1pydqFyJJH4o
         eWSg==
X-Forwarded-Encrypted: i=1; AKwUvBzp0qpHjl1FBkel079bPygrUFdWc//L/Gtzk0lgKVNU62lIn/Dp4AAVAElSnIpPrfkLNZVcbe0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUWDg6pksVsU0ConBs50mOnvft6uftNooM3semrvvwiuCIL0qt
	WqZL3jGk0rME42yMzT1BAL7YzMMW+M/yTIXGrMmk+GxwPxicPptWUohVx/RxqP7iEDb3o+NNy46
	YHQx5rlr286uU9zYe33Tkwb6Pj7Qvr8zXki6lQT9lZ+JvtgfVtdQAgu+y01k=
X-Gm-Gg: AYBFou0aBxR8gIKnZhGmy/qS2uzBQgqiB/EdqyL41UmlvUt1sngjELv9sF22X5apHv+
	l6R4Agjntc430FIWujzNZurDbH1cigJy5ImV9RNMZbbAXmyj6B6kva4PRsbumeO9MLUYHS8OuUB
	8sHu/LWrj/StUp/vaIY7y+Nfy+kiALyyPxL6nlC+DJ5XnXaCieK4ddreFs4x5P4KzEZLUF5CawH
	pluJo6i9v+hAVagXkDxk9ngDnIjDxRPuMM1fRv78PLVvjx3FSHt51xxEiVBv2havV8e/RZV/KIE
	qc67kU1777JS0heNfjKBU/pHWVjNjeNRb8ZcpUnQoMAr8jhJ88nqdy17PbraipeoDgz/JfyyYhn
	+YadoB47uxiS71/Vu8+u1XB6orDtJAJHJlo7iaAz0jMIfaiJeEHTHo0vSJ3s=
X-Received: by 2002:a05:7022:2507:b0:151:ece6:b16b with SMTP id a92af1059eb24-190a4c1fa2emr1644391c88.7.1792555872575;
        Tue, 20 Oct 2026 21:11:12 -0700 (PDT)
X-Received: by 2002:a05:7022:2507:b0:151:ece6:b16b with SMTP id a92af1059eb24-190a4c1fa2emr1644271c88.7.1792555871045;
        Tue, 20 Oct 2026 21:11:11 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903e02901fsm2915427c88.22.2026.10.20.21.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 21:11:09 -0700 (PDT)
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Ajay Kumar Nandam <ajay.nandam@oss.qualcomm.com>,
        linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Shawn Guo <shengchao.guo@oss.qualcomm.com>, stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Subject: [PATCH v2 2/3] ASoC: qcom: q6apm: Clear the right handle on pos buffer unmap
Date: Wed, 21 Oct 2026 12:10:43 +0800
Message-ID: <20261021041044.2080369-3-shengchao.guo@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021041044.2080369-1-shengchao.guo@oss.qualcomm.com>
References: <20261021041044.2080369-1-shengchao.guo@oss.qualcomm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxNiBTYWx0ZWRfX1yKtdpqvfby2
 z0BUIIuu2jw/eBCUYDeKYD80QFGXqZbGtTvybf/SQAEP5pnpYhjR8plmXKQ/YAz8DQy7gCsHsKa
 fHDBN9gpv27kLLYNlkevMPAI3wYWIpoyXB/DahZwpMkjxvPTTNUORFkOS3zF4Lj5pMSyzV+fQcv
 ZlCtAxM/Gn+v3a/ds/bOdlVXqQXoya8u2u8DY/W5yCQ9976WX1G6InPSVmgeHYPiXph+jv5gyK7
 1F0OwMSUR8ZkFFREkEU+GOtbwer/0tyAvjkY1zl3Pw/TOaOx9Ow0DbOuaw75vJw/eT53p5qWVTt
 f46kXppqc7Y2lGbvG9WoI8TtEDcgxuLFQgPBKHRZ40FYIqeuySIgotEh6TnvZtp9vm4m+R4bF2b
 potJgPiRxGX5LVof/Uj7AKcB277YUPTcUgGPDjzqjzi/AVQxCi2mDO4/nHjzapQ4SCqSX3kwdWa
 pC5kvfiF95L/djpEPow==
X-Proofpoint-ORIG-GUID: uF1--CriZoICuerzbOZOzIzO423mx93n
X-Proofpoint-GUID: uF1--CriZoICuerzbOZOzIzO423mx93n
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxNiBTYWx0ZWRfXzjArq6BAydnP
 2uRPOYnNJ41NgmYsAsbXIA54GNm+bY/1rUxxGf7t9XCM126AywucKOKbDIFO5Xm+Jyc3IWt22D0
 jQs2L97pe73WyPdqAKbFJ1scyUcgMts=
X-Authority-Analysis: v=2.4 cv=NppE4MdJ c=1 sm=1 tr=0 ts=6ad83b61 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=RRt428QXv51Blb0ChN0A:9 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210016

Push/pull graphs map two shared-memory regions per graph, the circular
buffer and the position buffer, and keep a separate DSP handle for
each. The map path tags its token with APM_MMAP_TOKEN_MAP_TYPE_POS_BUF
so the response lands in the right handle, but the unmap path sends a
bare graph ID and the response handler always clears mem_map_handle.

Unmapping the position buffer therefore wipes the circular buffer's
handle and leaves pos_buf_mem_map_handle set. A subsequent unmap of the
circular buffer is skipped, leaking that DSP mapping, and a remap of
the position buffer is skipped because the stale handle looks valid.

Tag the unmap token the same way as the map token and decode it in the
response handler to clear the matching handle.

Fixes: 7c1ac23b178a ("ASoC: qcom: audioreach: Add support for shared memory push/pull modules")
Cc: stable@vger.kernel.org
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index fa7f5dfca418..0e5219a6513f 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -329,8 +329,9 @@ static int __q6apm_unmap_memory_fixed_region(struct device *dev, unsigned int gr
 	struct q6apm *apm = dev_get_drvdata(dev->parent);
 	struct audioreach_graph_info *info;
 	uint32_t mem_map_handle;
+	uint32_t pos_mask = is_pos_buf ? APM_MMAP_TOKEN_MAP_TYPE_POS_BUF : 0;
 	struct gpr_pkt *pkt __free(kfree) = audioreach_alloc_apm_cmd_pkt(sizeof(*cmd),
-						APM_CMD_SHARED_MEM_UNMAP_REGIONS, graph_id);
+					APM_CMD_SHARED_MEM_UNMAP_REGIONS, (graph_id | pos_mask));
 	if (IS_ERR(pkt))
 		return PTR_ERR(pkt);
 
@@ -966,9 +967,16 @@ static int apm_callback(const struct gpr_resp_pkt *data, void *priv, int op)
 				dev_err(dev, "Error (%d) Processing 0x%08x cmd\n", result->status,
 					result->opcode);
 
-			info = idr_find(&apm->graph_info_idr, hdr->token);
-			if (info && !result->status)
-				info->mem_map_handle = 0;
+			graph_id = hdr->token & APM_MMAP_TOKEN_GID_MASK;
+			is_pos_buf = hdr->token & APM_MMAP_TOKEN_MAP_TYPE_POS_BUF;
+
+			info = idr_find(&apm->graph_info_idr, graph_id);
+			if (info && !result->status) {
+				if (is_pos_buf)
+					info->pos_buf_mem_map_handle = 0;
+				else
+					info->mem_map_handle = 0;
+			}
 
 			wake_up(&apm->wait);
 			break;
-- 
2.43.0

