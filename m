Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06773B3C15
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 11:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781694450; cv=none; b=QmaFqyT/+mO3mhPTaIsjvak5CSVHpn9I77vTDRD2VY+hCW03RQSSqPZI5JR/BhaBW8W3yw2XkmEbXVSHEDuRy58KK+wKvlGoD5qo7UJTxA4wOGckYwj3ZmkI/ZzJBpx6leHpHVE+skPEtBx6dX4z5dGNmRDLiOQVyuaaFnUhDAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781694450; c=relaxed/simple;
	bh=0w1s3YLkG+jtkr8qUvyuwkEbPb4RqLlVdDbqa6f/WtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lugpKgAKOzpuZ0ypFnMtNdhc40VZNqoOygewN5vC+UXEM+S5PcPCeIy7wKC1HZP0nvkCo2CH3RZRZMGqShtjJNdNFhMEhzZC2KqpAwoquJBCe4sxZOqSMTrY1Ttnz2mT7lnk/fyGpUnuZiD8th3d1jxhpttN1VpiiSFXbmEO4To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Fa9eQQyv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SdIr35rL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Fa9eQQyv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SdIr35rL"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65H8VZiY2190769
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 11:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6y9ccpxsi5yOvGDb95mPzv4201ZnlOndGkxveCSQBy0=; b=Fa9eQQyvT6/fYXwB
	Ar+yBsfOHuqXmBX4aG8koDP+IythKcL/6cfa7fu3WMrzIInJ9RcM4lKHqD0dLDLI
	+JL6ZvNuMNUyQhciqAr/rSoGRYY7JebGbS6VKOmEVPk5WnW4FFDL5cjCWd90mmm/
	ZkXBfi1ugupurheaOBQQW1THX2em/BBmtq9koxZHCHJdgx0dZRtUOtcPRsBv8FwF
	edu9Ceccm3HmBnTXjuYd4fCwuKhN15nypCOQ/0hRS1O/UdTGm1N1Hm35E0jUhWX7
	wuEzbEZKdW2XqTRqXOwjeibedBVNvfOcZCK9+zlRwuxSrr0e5KhuYy5NEkvUIxhI
	r5AEVg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueesjtt2-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 11:07:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-36d99629fd6so8880264a91.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 04:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781694447; x=1782299247; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6y9ccpxsi5yOvGDb95mPzv4201ZnlOndGkxveCSQBy0=;
        b=SdIr35rLxMt9RbQLIcY9PpvJ2TYbotzQT5yVXJEBBWJ6ItwG9yHV4nyq8xUVeGbNyY
         YBmJzmKfYYbNRHeMEIk+mnoem5QdJHiK3yAM02qfXxKi7AMQMk7uwvBh3m0rP51EPnz3
         M+p87L1TPJShs5MrMzoLu2cfYjtVs9ub45SP2LCKwTa+QkNVqU2OFE3dwAf92ZH2FCys
         UzWwvaPxFmc4Nez7SpBnYh+NFoumrIWspA6bzFPP47WdMdPHT+XunkDCYoQg1OGH8jk+
         fttPEmSRnrt2rFoyb/9fMBpKkLrXfGt/gDeJjtwfEYWfGJSWOCy95xgorGgiz9URLlaq
         LplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781694447; x=1782299247;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6y9ccpxsi5yOvGDb95mPzv4201ZnlOndGkxveCSQBy0=;
        b=WGAs7Ra8G4A1KqRQlwkRmVNYHUieJUO5KiD357cJbW9B6oNDD4HzRa9Ewf6dTTbisp
         5/RLcYg4jIWEtBrZyGVAlxgJkW4z2Zclbxm8vJcVUi4+IT469omx69+BhoGMSmTAwjKP
         fphzQvAG2kSoxunoKuTxBjIzYolXIL0+8nqEGYbEB7ZGs7m9l0Uwq9ye9MzSr8jRgdbd
         M4XJvp22dElyU9PmXIThE8RPmE0WjWDBIYeY6dl64eCj5YXmhxdV9ypU5Yv3JzGM+Iqh
         DziXlEIkS4oeqaDZET3SB84mMmcV0ziCZ6tK4IcXSKyzUYQaG4J2zKdrRzkrmAKllb0A
         DCMw==
X-Forwarded-Encrypted: i=1; AFNElJ/2rwjdC2Sfwjp0KvwogVlibYcBxAX1UeOVfLPJMqeflbAg8iaatdl0rtntggrK9LgNQaqPcEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtNU8o7WGG5aN9ZOUstCwDJEAUO9xByI6TMB1nJTePfAD7Y7J+
	01BlTFlHfRZAX0DL0YkcNZIyk/iEPxU3Xu5Q3o8XxPUW6kZYI7u2IWs4ny2pppFfrnUWu4lNwJe
	VR9ELa30yfU+5rqoyMkMI5ItBn2LC+r5+rw7MlzeVtHfsjXw1G8G0wIrLQR1tkPSlfVY=
X-Gm-Gg: AfdE7ck9PAh9mQDCRK886kb9k9XTUg6bwmz1Hz0d0ku++HBLeiqZ9Cc/zZn/2RMHJS8
	f5pgeoCh9Gh0VGtA7wBGFBohPmrqV9fXcUg6ffpHBzpriub8LEEVLEXWbzPjmKP8L1sYL18hcqU
	OJh8G76c3seBtV3JbEATEcyyy1PVcF5OhAu9nV0givDzqkUcT+14L0S8hOl2mwjwcG9Aoof4vSc
	XPBGTV/5QViaGOLpvqrWB2VaZD+IYfpwEv3xLiJnWVgAy1tzlqf0D+PZvfFrdL5+5gn1MOYVEVd
	PBrWRuGBMDCP/tRn2W6jfWEtnIXAxeCIJQkS9UhLd6MmLKVjGTwoMw4Hxa+zMM5qfynFnndB+Hn
	shulvh+ObzeW4JpB18nA9rAEgGxlt1hf5Ysw7UoyASyR4LxfBYbKwnWjVkBFXvL0wyZq7IZ+NAM
	mKL2CY3A==
X-Received: by 2002:a17:90b:5807:b0:36d:ae6a:22f4 with SMTP id 98e67ed59e1d1-37c9e9c8c7emr2943103a91.15.1781694446548;
        Wed, 17 Jun 2026 04:07:26 -0700 (PDT)
X-Received: by 2002:a17:90b:5807:b0:36d:ae6a:22f4 with SMTP id 98e67ed59e1d1-37c9e9c8c7emr2943065a91.15.1781694445993;
        Wed, 17 Jun 2026 04:07:25 -0700 (PDT)
Received: from CHUNKAID2.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c5228eb5bsm5577639a91.12.2026.06.17.04.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 04:07:25 -0700 (PDT)
From: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 19:07:14 +0800
Subject: [PATCH v2 2/2] rpmsg: glink: smem: Add WARN_ON_ONCE for FIFO index
 invariants
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-rpmsg-improvements-v2-2-477d4eb569dc@oss.qualcomm.com>
References: <20260617-rpmsg-improvements-v2-0-477d4eb569dc@oss.qualcomm.com>
In-Reply-To: <20260617-rpmsg-improvements-v2-0-477d4eb569dc@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, chris.lew@oss.qualcomm.com,
        tony.truong@oss.qualcomm.com,
        Chunkai Deng <chunkai.deng@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781694436; l=2286;
 i=chunkai.deng@oss.qualcomm.com; s=20260512; h=from:subject:message-id;
 bh=0w1s3YLkG+jtkr8qUvyuwkEbPb4RqLlVdDbqa6f/WtY=;
 b=WB/PBn5QAVqwzjusrIFk4JTnZj1Sveo89mv10F/gfaxNm4YfnActQH8YKmaaD9fOueq+gIZnq
 OyweneaLAq7DDrQDG/d0MuzitO8Momdu9vFuncqVhyfApANi7TTYMeG
X-Developer-Key: i=chunkai.deng@oss.qualcomm.com; a=ed25519;
 pk=NfifEElkZxgJ0ghUBxNu1RTaEqtoCGYDb0k5UzIRXOY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDEwNCBTYWx0ZWRfX05v5YLnjNroF
 VTvCOkkgFEX3jOuiQYC6aViva+DhPyQo8Dn4oZ3O16w/aUNoSh0Uw92PRV8VJXvOaMCoZRdSYQN
 K8bsbkAAI4DSLmgUj9aipDRg4KRIcRF58SRQiriwZ8oraPb/9vSEvZFxLorSmqttBLKVEf54wUL
 76AxB7Oq8XL9a901k0bbA1uo39wHJtCq66kqoQ+IoqnHCXnbO0udqTcmNtWkG12HPo2A3PABrt6
 Xwu4xlkIh023UnKax0Cyrmo3OSFMLR/c+midtU21JPNZvpnD2OsBZQs7vImyjOA+FBkpeCLn7sq
 uKX7HuN3wOamoZ/n+ekn/D9m4R7wT14oyeCOYx58F/VKNP7Y9WDG2xM4nYgtJHs3RkIvBNVZuEN
 jHxQb8mJYNW/gd3Do9/s7P2fMRv9MvcGM9uJn7Glz4sbscoQlfm9XxBJPL5xpd3p8C3EfGYR+il
 x64qsXaqxy/nM5IEU3Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDEwNCBTYWx0ZWRfX3j4cQNNg6LUd
 cnt8fKKpjEevZBNBT1NrmKzO1EsblPITrQY64vU5v2cyQHoMrgFmKtGw70+l1+Trt9YZlhX2L+3
 xoA9skFwWY+FPdu7SAokmee4b0KLKwU=
X-Proofpoint-ORIG-GUID: hhyxGdss1-kXAgfSBy_AamxGHy7Nox8U
X-Proofpoint-GUID: hhyxGdss1-kXAgfSBy_AamxGHy7Nox8U
X-Authority-Analysis: v=2.4 cv=ePojSnp1 c=1 sm=1 tr=0 ts=6a327fef cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SdC2vBNBQt3qShdCGKMA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1011 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170104

The FIFO read/write helpers assume the head and tail indices stay within
[0, pipe->native.length) and use them directly as offsets into the
mapped FIFO region. If that invariant is ever broken, the subsequent
memcpy or memcpy_fromio would access memory outside the FIFO.

Add WARN_ON_ONCE checks in these helpers so a broken invariant is
caught and reported once, and the out-of-bounds access is skipped
instead of proceeding silently.

Fixes: caf989c350e8 ("rpmsg: glink: Introduce glink smem based transport")
Cc: stable@vger.kernel.org
Signed-off-by: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
---
 drivers/rpmsg/qcom_glink_smem.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
index edab912557ac..42ad315d7910 100644
--- a/drivers/rpmsg/qcom_glink_smem.c
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -86,9 +86,14 @@ static size_t glink_smem_rx_avail(struct qcom_glink_pipe *np)
 	tail = le32_to_cpu(*pipe->tail);
 
 	if (head < tail)
-		return pipe->native.length - tail + head;
+		len = pipe->native.length - tail + head;
 	else
-		return head - tail;
+		len = head - tail;
+
+	if (WARN_ON_ONCE(len > pipe->native.length))
+		len = 0;
+
+	return len;
 }
 
 static void glink_smem_rx_peek(struct qcom_glink_pipe *np,
@@ -103,6 +108,9 @@ static void glink_smem_rx_peek(struct qcom_glink_pipe *np,
 	if (tail >= pipe->native.length)
 		tail -= pipe->native.length;
 
+	if (WARN_ON_ONCE(tail >= pipe->native.length))
+		return;
+
 	len = min_t(size_t, count, pipe->native.length - tail);
 	if (len)
 		memcpy_fromio(data, pipe->fifo + tail, len);
@@ -141,6 +149,9 @@ static size_t glink_smem_tx_avail(struct qcom_glink_pipe *np)
 	else
 		avail = tail - head;
 
+	if (WARN_ON_ONCE(avail > pipe->native.length))
+		avail = 0;
+
 	if (avail < (FIFO_FULL_RESERVE + TX_BLOCKED_CMD_RESERVE))
 		avail = 0;
 	else
@@ -155,6 +166,9 @@ static unsigned int glink_smem_tx_write_one(struct glink_smem_pipe *pipe,
 {
 	size_t len;
 
+	if (WARN_ON_ONCE(head >= pipe->native.length))
+		return head;
+
 	len = min_t(size_t, count, pipe->native.length - head);
 	if (len)
 		memcpy(pipe->fifo + head, data, len);

-- 
2.34.1

