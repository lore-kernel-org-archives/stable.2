Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D6F424D48
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784554145; cv=none; b=gw4XhmN1s7GJ2abxZeC7SK+/U/AbWPKdZJXRb97b78uyhskKNZixy7uLjHuqEtjTf78LOCP6RDdt4bEAToBPvTI0mSkZFOyn0PgxsaX2jtssxUH87tKSPFJ9Gl3aq+fYG2o9bGdoezk9zAPSwy3ZQhAW+SteMFG2RWyXHm7AKBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784554145; c=relaxed/simple;
	bh=f1RJ74a76PW53KK+1xdt52Qum59vHAAPDpQ+wyRWZLE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=omVpzHmCthI1cvaoZzQLddObZBWQTmkKsa2Y7SrzE2mokRutftBxPZrcXeOvpULfPH3hWrjQWO7rPxJnOORcjEgwmz8GQWJMOq3fYjiDq9VZ8hyA8PHaUIpTNv6w6cHs1cCvULbi5gzintjxIA/7qJmDT49VhjR3Dnikv9MmHKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hxH3DvR/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LmzIRkB9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hxH3DvR/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LmzIRkB9"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KAvWBm2457810
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:29:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	tSAwREJ9fN+/n5hiVtWkjLEHl1v3XArrjXhPEVMyZvw=; b=hxH3DvR/TKs7tSd3
	LCfkDOwqsZppI/Wivpx2IqG3PwpCwSCdunjlAiuH+hH31zlkzMezp9u9/BClSVLc
	7ZeE+WEaqPgAdQzqWQdkbCSQPA8XD8GT6mYBeQjR3fnKaLu+eGUTRZJ+t/X39RCv
	w6+3iWSq36F72kwE3CNPU0PfqsLdhFDcMeRFfPl+nN/KeDI/3VVC+oCraDxBe17k
	DNFXTQDtatXmyEWswDTq5Pg3BYiq/WlVxkk1M6Nd1/OaedPRDYjc2VX2E4371sm1
	A31o2yYBO4mvach4I2CKTwaPbOiE9N7KVsDL47ojmSmY9cP1DXz3xq1eq9buzlwr
	xlQ0Ew==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhf0ksm63-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 13:29:03 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-848452dd146so14841858b3a.2
        for <stable@vger.kernel.org>; Mon, 20 Jul 2026 06:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784554142; x=1785158942; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tSAwREJ9fN+/n5hiVtWkjLEHl1v3XArrjXhPEVMyZvw=;
        b=LmzIRkB9QEhhYVolTZyA0BoO1e/KxyoaBHH6O0PfftbHX7PpVLST5I4edMIXWNDs40
         PGn+NT5fCSk6daAiEgOh0nuHfmWtQFYWEmltzDxngKw0J+q2fI8b2LZtIZ5k+WdltYJL
         CBTbkbY2JJabKtUltXYe+jkJquEeRKTFxlXFtfdOmlFuVf/SKNGNLmoi2sCuYqPfwPSG
         eMkkF4NZpYkJKZdaZ/mcc89zJHQOY7Nl1cODefU8z7R3k+esy87Hlafl6SVa5TpGvNj1
         lP1lalpBH1XTxQL4y0/GBxHf+98YqAWmDv3cu0NGIq4YopmAt/pOT1HyLZB/iF2VNsvY
         o1YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784554142; x=1785158942;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tSAwREJ9fN+/n5hiVtWkjLEHl1v3XArrjXhPEVMyZvw=;
        b=kU/TMzljT5BLSQlDCTspcRFmjy3EPXGQqMaw2BmhaeKRkP/SMgaZ94tK4dlJEUDHIg
         DgZgpihNdUMmLMj6bR1vG6GEW5otWNz7Q/y0A5WRCyjBUIeScbEz7SuDPAO7zpSDhF5+
         P/IDO0+FlwzXcz6iU4OAjuqBCdNN53NOwLUYf72k+1gmE4h0raoZ3SYxXZTWBOJUiA0+
         798/gRtrKsg60KSS9VMwCC58q4WYpnkGGP3HR39yrYhJVd2yVcg8715yDfbvbPaYvUfr
         7Bq6KOW4WC9JvFNlw4UyblChFtEdSEPI3sfo/giXIHYbtUNBlaE/KE4bWYVxZQQfUlo/
         jing==
X-Forwarded-Encrypted: i=1; AHgh+RqIRO76rutbo3gqKw6XElKvSHiXGowMuhk+BnrlHLL4g/hDiQ4w+ydeZh2Vjdue9m2q7OyDG3s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYo4I+Qq8wT1+JeNCc8vB7WlmfXpJGUEYvliYeJfOMd16g1euT
	bVrvo+Sngl8WogUdd077nY4Au8Knm37XQDQgufT6tBLKbT1dvXmAKPq4LLZyl5lmJzA2268AILo
	qoQuB8HFd+NmjWtpSWrrtQ4ze9TzZ+aaD6ThOl0G/hbqrdBzsQg9u7tU8Oss=
X-Gm-Gg: AfdE7ckkcTjJyvSpREBdOo/Ov9mb/fe509p0YiZ/hC0UGmLxFjMXlT2xTUpTPCzOTbn
	ay7q4EWw9qVIjMJdgafmwq5jU5a6GRGmTs6RT/LfP0MgyyTGEcW7v15yREEZlLcKzftpsUxdNeB
	rQ1u+pPw3zevfCOp9V+1cDyHwOoqLc2EFBXEsPLNr+SLU0hnqOoyChEYdPoi007Tc8QGI3BIjps
	+PrWor1R+2JSpOdt+fIAaWtttKBqs+OihipELqW4wfBcL+aZoDnVqvLSeFCeotOD4PI6nB5teUK
	Vqsr40cXrIP678wSqx0p3SHCgmyM+2nx7FQb3o7amBUKphViG6q0jmaPiOeAFMH09gCiF4zp64I
	DCmVCQFpFUXoXCCDNUXqg+xJAfYB+KZigPHAf+FbuZGtha6W9kdc2oWems4tuAhre5lqUT9Q=
X-Received: by 2002:a05:6a00:3cd3:b0:848:788a:e7f9 with SMTP id d2e1a72fcca58-84c292b4922mr14094466b3a.18.1784554141881;
        Mon, 20 Jul 2026 06:29:01 -0700 (PDT)
X-Received: by 2002:a05:6a00:3cd3:b0:848:788a:e7f9 with SMTP id d2e1a72fcca58-84c292b4922mr14094431b3a.18.1784554141294;
        Mon, 20 Jul 2026 06:29:01 -0700 (PDT)
Received: from CHUNKAID2.ap.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6e3e0sm5628822b3a.43.2026.07.20.06.28.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 06:29:01 -0700 (PDT)
From: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 21:25:53 +0800
Subject: [PATCH v3 2/2] rpmsg: glink: smem: Validate FIFO indices before
 use
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-rpmsg-improvements-v3-2-e7b6070186bd@oss.qualcomm.com>
References: <20260720-rpmsg-improvements-v3-0-e7b6070186bd@oss.qualcomm.com>
In-Reply-To: <20260720-rpmsg-improvements-v3-0-e7b6070186bd@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, chris.lew@oss.qualcomm.com,
        tony.truong@oss.qualcomm.com, dmitry.baryshkov@oss.qualcomm.com,
        Chunkai Deng <chunkai.deng@oss.qualcomm.com>, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784554132; l=3666;
 i=chunkai.deng@oss.qualcomm.com; s=20260512; h=from:subject:message-id;
 bh=f1RJ74a76PW53KK+1xdt52Qum59vHAAPDpQ+wyRWZLE=;
 b=nCxSZFKsWJ+VWDLc/mo34bGZi2uJ8GrpAYX2ilml05yN9poLI9eKKjCiD1aUKcHmNoyq6aMFx
 jpA14otxz5/DOcou81CLBHLzFm1o1aw9YWc7aFX2UoKnXwWxBeN1Jxk
X-Developer-Key: i=chunkai.deng@oss.qualcomm.com; a=ed25519;
 pk=NfifEElkZxgJ0ghUBxNu1RTaEqtoCGYDb0k5UzIRXOY=
X-Proofpoint-ORIG-GUID: Bh5_BkIseYcbdOd3cSXq3cAgJK8RQtyd
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE1MCBTYWx0ZWRfX1dbxWmKjDbHy
 pBfEt5IVU/Sn3mAp9aI7JHPHvrydhqaRUpLboT/jAREtBNarin6dvmkQ1aDUHbaHMjWHQV5sEZC
 bplL11hKNxuL0RqEsKSRtWXAxcfjgnQ=
X-Authority-Analysis: v=2.4 cv=G58s1dk5 c=1 sm=1 tr=0 ts=6a5e229f cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=q5iom6PKYtt-AqbUL74A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE1MCBTYWx0ZWRfX1VH0d0laXV1W
 Ye7TLA9ZntKNROPUzNyCtCCdhLdI7RaFk9SscFPklwMXPeCYLJp+apjKLa/l7IMajKH3h2CJ2Rv
 Tcl7RsOvawURtMxNnkJcUz3KvZUxJXKUW8rTTkE+VD60/FUWzijRClzEsZn5Amxxt8nQxCLXXoZ
 lmB3/nMquo6BFI6NkAXenPvT0UzYYQ80rF5HmYV7T/arZMbYLRL5Tk8XT6xT7BXYUuqkgZumtvb
 4te0yfZkjCwShrFoT5FGoZ4kZaNZN81okAxYjeETV93RNHyF8UKuKzWhfwff4qboYY+EB0EI/kQ
 0LbWttCK7qc5rCEN5BnIMZFPk6k66C2WFsmTLbHF1OEjpLDEi511rgEGiWGyEi8s0w12ELkXepm
 wgC3ngZLdwhq2DdsI8QMBuLd+ak5rQOoTN/XuNx7iufnPDLeFrMSFc1LflGqMWW1NuCQD525JqN
 B3W6KMitu34Q1Imb0ng==
X-Proofpoint-GUID: Bh5_BkIseYcbdOd3cSXq3cAgJK8RQtyd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_02,2026-07-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200150

The FIFO read/write helpers assume the head and tail indices stay within
[0, pipe->native.length) and use them directly as offsets into the
mapped FIFO region. If that invariant is ever broken, the subsequent
memcpy or memcpy_fromio would access memory outside the FIFO.

Validate the raw head and tail values (and, where applicable, the
caller-supplied offset/count) against pipe->native.length in the
avail/peek/write helpers. Checking the derived length or the
post-normalized index is not sufficient: two out-of-range indices can
still produce an in-range difference, and reducing a bad index modulo
the FIFO length hides the original invariant violation.

Fixes: caf989c350e8 ("rpmsg: glink: Introduce glink smem based transport")
Cc: stable@vger.kernel.org
Signed-off-by: Chunkai Deng <chunkai.deng@oss.qualcomm.com>
---
 drivers/rpmsg/qcom_glink_smem.c | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/rpmsg/qcom_glink_smem.c b/drivers/rpmsg/qcom_glink_smem.c
index edab912557ac..df3081855b02 100644
--- a/drivers/rpmsg/qcom_glink_smem.c
+++ b/drivers/rpmsg/qcom_glink_smem.c
@@ -85,6 +85,22 @@ static size_t glink_smem_rx_avail(struct qcom_glink_pipe *np)
 	head = le32_to_cpu(*pipe->head);
 	tail = le32_to_cpu(*pipe->tail);
 
+	/*
+	 * head is written by the remote peer via SMEM; tail is written
+	 * locally. Check the raw values, not a derived length: two
+	 * out-of-range indices can still produce an in-range difference,
+	 * and reducing a bad index modulo the FIFO length would hide the
+	 * invariant violation.
+	 */
+	if (unlikely(head >= pipe->native.length)) {
+		dev_warn_ratelimited(&smem->dev,
+				     "rx head out of range: head=%u length=%zu\n",
+				     head, pipe->native.length);
+		return 0;
+	}
+	if (WARN_ON_ONCE(tail >= pipe->native.length))
+		return 0;
+
 	if (head < tail)
 		return pipe->native.length - tail + head;
 	else
@@ -99,6 +115,11 @@ static void glink_smem_rx_peek(struct qcom_glink_pipe *np,
 	u32 tail;
 
 	tail = le32_to_cpu(*pipe->tail);
+	if (WARN_ON_ONCE(tail >= pipe->native.length))
+		return;
+	if (WARN_ON_ONCE(offset + count > pipe->native.length))
+		return;
+
 	tail += offset;
 	if (tail >= pipe->native.length)
 		tail -= pipe->native.length;
@@ -129,6 +150,7 @@ static void glink_smem_rx_advance(struct qcom_glink_pipe *np,
 static size_t glink_smem_tx_avail(struct qcom_glink_pipe *np)
 {
 	struct glink_smem_pipe *pipe = to_smem_pipe(np);
+	struct qcom_glink_smem *smem = pipe->smem;
 	u32 head;
 	u32 tail;
 	u32 avail;
@@ -136,6 +158,19 @@ static size_t glink_smem_tx_avail(struct qcom_glink_pipe *np)
 	head = le32_to_cpu(*pipe->head);
 	tail = le32_to_cpu(*pipe->tail);
 
+	/*
+	 * head is written locally; tail is written by the remote peer via
+	 * SMEM. Check the raw values, not a derived length.
+	 */
+	if (WARN_ON_ONCE(head >= pipe->native.length))
+		return 0;
+	if (unlikely(tail >= pipe->native.length)) {
+		dev_warn_ratelimited(&smem->dev,
+				     "tx tail out of range: tail=%u length=%zu\n",
+				     tail, pipe->native.length);
+		return 0;
+	}
+
 	if (tail <= head)
 		avail = pipe->native.length - head + tail;
 	else
@@ -177,6 +212,10 @@ static void glink_smem_tx_write(struct qcom_glink_pipe *glink_pipe,
 	unsigned int head;
 
 	head = le32_to_cpu(*pipe->head);
+	if (WARN_ON_ONCE(head >= pipe->native.length))
+		return;
+	if (WARN_ON_ONCE(hlen + dlen > pipe->native.length))
+		return;
 
 	head = glink_smem_tx_write_one(pipe, head, hdr, hlen);
 	head = glink_smem_tx_write_one(pipe, head, data, dlen);

-- 
2.34.1

