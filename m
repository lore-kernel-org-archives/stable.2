Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792555868;
	b=jRrUwc4ZeIoEKzuCQkBti3bmJtc+OZSLJOLM4jhJrBhXGaaYF+Tfx2GZDx+TXLNwvBth
	 uZpo2u3D1V0IlqKejGRpfmKkNG92ouxgJ0taTgwRUUUYNG/ruhhpJE4EDYvEAMkhbpTht
	 2I63nOfokdy5VsvvcORe8oP7nja1gf36U0E4B1q9u64ysrLH0Dx2cu7YxSWTAtsAH8lyW
	 pad+7QiDi9dU0ifkVhTozZERI6NyqKZ5MQzQK87zKGYNg3N+gGhk7UP2khQMVKo+W3yGQ
	 AnDWOypaqn3AXix45+R7JEoMU9HMtRaqJzXdwu9pxa2vxA8IZVzUA/tiDZxDBQxLmZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792555868;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zhuJnKWcj8cUHo/PEz1Va/bf1tnOQvpmNsWA1F5i0cs=;
	b=ht/AHh50LUhJpYUTjO8y+HneRqusbLuE5QLRgDPeewbjO4KMqoGNaiYwN2X8mhtSKnTL
	 CbAjFjUo5SeeMJRPKaBWrO5bRdIOEjiwV45lD/vqCVGCuu2AnOLLr3i2HNS3u+ggtuLVK
	 5IUhE2IivZ7XyGPUXOFrgaCpdmR9CVBbwn4YdUNUWJwxUywBoiw/lnD+iDtZmLBbeIbj0
	 w1dxhLPFLfBKr/QLO+gBGlgWMtD+jo5EKjbwUd6SYGXtlOlIdpq50nNcQ+skvh2sca9c7
	 Ons5Bd+ztDMDayFMTlBmYvH1bZDIp3xRvZbjVVi+FaIozqTm56rkHtbXFgOTNqRCnwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gk90BPHI;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W5ESlgtM;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F95606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 04:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74F95606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gk90BPHI;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=W5ESlgtM
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L2EvXg3469287
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 04:11:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=zhuJnKWcj8c
	UHo/PEz1Va/bf1tnOQvpmNsWA1F5i0cs=; b=gk90BPHIPojeGzVUtpXoQJ8fPSK
	uW171tR3eTqIBZrHbpUVJvjnKbpOQbRkKzancOWX7RE/QrR7Cyc1HVbY7LqK588D
	ZyqYfW8bNIm/wKruUfmMEGDxD8gEjS7I7iba/VQ3Xqrhxej4IYnCW/7p1t1ir+z/
	LR/sbwI0m0bsnTcR0l3+GFb6TINbVPvqNfZC5iKirvrXlIDlJxDIBJ3SaL7qSs/E
	pSvUEtCOtrLsy8a3ZIidPEOSeftQxzUxeiWhXUMOpDjvhWrkXuWDjOdKKcingH3l
	CLh5PY2Sgr/CGsUzWGVUB4/6jcRXI0cPz8XSk2UVrmliOFTgGQBk+GWAnDw==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7h2bfxt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 04:11:07 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id a92af1059eb24-155a75f91e1so873701c88.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 21:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792555867; x=1793160667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zhuJnKWcj8cUHo/PEz1Va/bf1tnOQvpmNsWA1F5i0cs=;
        b=W5ESlgtMrONpjJMsVy19YU7cjhfCbXxUh9awRGePlAnKTZMTvnLuznS1MUtuL1rxm1
         wo8616lBFpekGJYQ1pfjpWl+M1s7kL1YvSl+i35EeymTgO4o63tPx7CAiMFm+kI+T9eJ
         AStYbI9IzTNWzrnW6ywV+YQ2yxXQDtqaRmn9C7tKurTAaU0Wrqggtj5OE6cxVfuJn3bn
         Wfkkj7YCpdEDVT0hw4x3Lbd9W9DZjX6HDRapqcxpsjVE0sakwekKwAxlVtgqyV0Mp2ju
         tVMcbt/gT6GLCV/V7RMc/NAFoD/I8KLWPWkVcZGKPB8+95XvVao+1YA5g3ZCDH/rTNDb
         kkfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792555867; x=1793160667;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zhuJnKWcj8cUHo/PEz1Va/bf1tnOQvpmNsWA1F5i0cs=;
        b=iZGHimNMWCY2tASbhYVuqGZYOzykAtx6+vtvUvDThOvxuazZSGduS3t/2f3NBumgru
         KQpUQ/KeUl5ZcuiCpUt2vXqLHRmNFXeVc5HJBIyUVPXKLtL2igAh4Z2QiaP6WFnKRoDK
         rMxYS4VCotDtu2T59tFycdb4z55DgIzNcC0W7/a/BiWImFNs5m1nsdh1z5AvVyupDeMP
         9YojA+49ci6VJxtKaGrpO/SvgpQRjCtQw+yq3tmKYyn8NqcaP92zC1ow0TIUmPzaU04Z
         NROXeh/elgCfujc1XvRu59vgj1c/063SwJPQScYQvndUJNBU+4/KAapcT4x7Ub/d8XBT
         /JdA==
X-Forwarded-Encrypted: i=1; AKwUvBxdyA2bRcuq6a6UAGFE8+efYBNimG1c5bPu/ax1yHWNoYdzcTOXrPOiLvR4SKvjuVLLxbc9F1U=@vger.kernel.org
X-Gm-Message-State: AFq9FYImWreyKKZNy1wJbCosC5B775fSu6uXA4AiiIl7HGQ+EeunLj2u
	eswFAbcalzUqZA4D1efMNNqCZFfaRsrtg+4JAcTwg0cRUmuxpFnwh3gRK2Da0iy2eyKQceoTcI8
	18qbntiq7aTdI7V94VtpDiP/OBxJ04k1h/xuXqrb/Q3OM2DsUgfK3V67wCH4=
X-Gm-Gg: AYBFou3/C1FeA0Wzd/VI1ztNrzFx1aQpD4m369IxDrWjRi7iHoLEMkK3Y7JxUlfhiBL
	z5nGglaMdhrwOEUi9cT+ES2i9izhqhNs1Dw5s7/PWnnJMDLzIHP65/IN+EhAIC7GwKod4W/CtNN
	Oi0rXGsVE2J8CKB7oW+3YBpTOh9cM3QBIKmjyBCJrx+3bLRgWZ2+yn7i0477CYbGuBl/yRIyedE
	OsGhsfM8ieVs23pEXN6XOkyWwqKUv1oEPVlnHsYVnpw1YHjILf2JUoIJSO3EqAPWYIhwwW6hLx3
	sUOm2QLvPGbck+2gXI9NKf5IweNSJ6O/MLTF3DPaZH309yJNJQL8L/tK4abFuFpgRZcdHG5Ry9r
	mC2YzOU9Jt/2/zZqqkk4OGMkaimgAa86aKgwSBArMgEJvBN9UouNwDb+hhL8=
X-Received: by 2002:a05:701b:4584:b0:16f:1e21:7006 with SMTP id a92af1059eb24-18db7b92510mr4050322c88.1.1792555866919;
        Tue, 20 Oct 2026 21:11:06 -0700 (PDT)
X-Received: by 2002:a05:701b:4584:b0:16f:1e21:7006 with SMTP id a92af1059eb24-18db7b92510mr4050292c88.1.1792555866283;
        Tue, 20 Oct 2026 21:11:06 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1903e02901fsm2915427c88.22.2026.10.20.21.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 21:11:05 -0700 (PDT)
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
Subject: [PATCH v2 1/3] ASoC: qcom: q6apm: Fix unmap regions response handling
Date: Wed, 21 Oct 2026 12:10:42 +0800
Message-ID: <20261021041044.2080369-2-shengchao.guo@oss.qualcomm.com>
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
X-Proofpoint-GUID: QNrbKozCukz7sjo8SVpW2pRlw4_g6AX-
X-Proofpoint-ORIG-GUID: QNrbKozCukz7sjo8SVpW2pRlw4_g6AX-
X-Authority-Analysis: v=2.4 cv=EuJHPicA c=1 sm=1 tr=0 ts=6ad83b5b cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=RRt428QXv51Blb0ChN0A:9 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAxNiBTYWx0ZWRfX95lfYcI3NUpI
 JJUEUCQ3hK9HGF3qbxjRQJIcV1WeQkDuDRogGHI6MxOsIcxq5k2ZZc2C2VxTWkr5jJOnBS27lzj
 YwbUdgp1Pd9XkFJjDFgJUKwC+TCCTtw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAxNiBTYWx0ZWRfX/At3W3iEXYPg
 TmxHwWkD1pYgaJH8H70godIECBAKjOPE9Bo/330UEguOhddXSLvlcdbvyUuPQHpquE6V31oADmb
 Nk/F20DZHtfry3YhgRPGFHQZcRadZc21vlxolTdBwOfMcasBAOa+4LftOwbF1ugEH4UgA6HYkSd
 yVTlT5MwPK9XcThnethiDDT9HdyZXUSVJWVaibR3jwRbFkTjseEyq0HzODMNR1RVQOKFOENOzmE
 JPwgR6rLGZaLrhXeRgtEuom8Tq4/YgmwlYr+vDDG87266ps4ROdKvVwMfu9S6oPVY/Gyr4Bxm7Q
 Snm6zFMdtbvGCGguHWsQisXtojvXH900IbopG+CSvF/wXPB/YpJlxW8b2ITRS+41sYTXQJ5AJLs
 b2AdOnuBqt5OMP8FAJ16kecJdz3EEhOsHDsl1eMvmL5GKQ6cHCUNbyixWEF2JpjI0lVM/q3dxKU
 SxgJ3Kwrw/dnCPwTwbQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_01,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210016

The DSP acknowledges APM_CMD_SHARED_MEM_UNMAP_REGIONS with a
GPR_BASIC_RSP_RESULT packet whose payload carries the acknowledged
opcode and the status. apm_callback() stores hdr->opcode, i.e.
GPR_BASIC_RSP_RESULT itself, as the result opcode, so
audioreach_send_cmd_sync(), which waits for 0x0100100d, never sees a
match and gives up after five seconds even though the DSP has already
processed the command:

  qcom-apm gprsvc:service:2:1: CMD timeout for [100100d] opcode

Each mapped graph costs a five second stall on unmap, and the forced
status of 0 also hides real DSP failures from the caller.

Record the opcode and status from the response payload, like the other
basic-result commands do, and only drop the cached mapping handle when
the DSP reports success.

Fixes: 8ea6e25c8536 ("ASoC: qcom: q6apm: Add support for early buffer mapping on DSP")
Cc: stable@vger.kernel.org
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
---
 sound/soc/qcom/qdsp6/q6apm.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6apm.c b/sound/soc/qcom/qdsp6/q6apm.c
index b6b1ef6833b3..fa7f5dfca418 100644
--- a/sound/soc/qcom/qdsp6/q6apm.c
+++ b/sound/soc/qcom/qdsp6/q6apm.c
@@ -960,17 +960,16 @@ static int apm_callback(const struct gpr_resp_pkt *data, void *priv, int op)
 			wake_up(&apm->wait);
 			break;
 		case APM_CMD_SHARED_MEM_UNMAP_REGIONS:
-			apm->result.opcode = hdr->opcode;
-			apm->result.status = 0;
-			rsp = data->payload;
-
-			info = idr_find(&apm->graph_info_idr, hdr->token);
-			if (info)
-				info->mem_map_handle = 0;
-			else
+			apm->result.opcode = result->opcode;
+			apm->result.status = result->status;
+			if (result->status)
 				dev_err(dev, "Error (%d) Processing 0x%08x cmd\n", result->status,
 					result->opcode);
 
+			info = idr_find(&apm->graph_info_idr, hdr->token);
+			if (info && !result->status)
+				info->mem_map_handle = 0;
+
 			wake_up(&apm->wait);
 			break;
 		default:
-- 
2.43.0

