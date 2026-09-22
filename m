Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EFC542EF3
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081868; cv=none; b=MhlhEeF+MvV2f4tK6Cl81nTjvYvuo+6QiIjeMwUF1uirGnkriUC9pUcFQ6FiieAM1EIt+8/oA/gyzKu/I9Kd9iD3/zzk/CfB3+8kBUykYw0iOeU++sRexhXP5b3/qEFdNYgF064tXGuBZdET88anGU+vnKCYNbaJAoiRGjjZdcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081868; c=relaxed/simple;
	bh=3F1JI29VdO48cQYdRWVbGd7NfSqBKkKmpU0CrEzeykE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=caGQd6+YuQ/axcyJCdeaasl2kuFcrpmLOXgKW2B5ETinnBPMIGzuUhRQFScT4QfYgXf/WfslveP8fNZQhF9hALVI/SONNjDr0zrNpvzYVICzp1CtqwBF3lU0RW6OsPibksi8fS5BT98n91fauKUjz9SsdpA1ejCwYZDNwgKLQos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I/AD1tNa; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=OUHTwVWB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I/AD1tNa";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OUHTwVWB"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBQ4LU3488472
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:57:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aBD7QfFK9h16ArzMKza718DmtrKmQM3BpDgAFXcDf8I=; b=I/AD1tNa/JBI8VeG
	lVwqwotsf+aEdfW2sYR7s0xajuHcjQOwuCdEb0xVEwCQT6B8Rpp8Gq8JOlbu0pUR
	qmT1J4og5T9j5urZBLmDpQXiMpzn6sTwtbVKf9ZXnJZY6xxMUQ3QwaZtc9BF4Xqt
	mNmJvHWPC0+xxCOGGmNbqMFPQIdfKT+B7ZqVAnV3ZDUhPuIWhUcayUsaMBgGAjCD
	rdwjvWCC7sZnA+nZHhU/Np3yzbOjkjRO6sRFPsKT0Tn+E1euBvX++NeaN7GuyO7M
	A+sN7bnFAJUZk86yR3ZZas3Zl35iRc4KLIJG/jPj0/YysHBLM+7tQDNr3jya14t2
	jVK6hg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gudw0jydn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:57:45 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c7d5444845so5891364e0c.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 05:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790081864; x=1790686664; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aBD7QfFK9h16ArzMKza718DmtrKmQM3BpDgAFXcDf8I=;
        b=OUHTwVWBbArW7LhOm6o3lNN5HpO85lutVq2TSarxZEt0QtHCzjt/tMqDn9EdYLcRgr
         RLAbV2cqvRMVwrXljQg3F9/zMyC6kzf+D71sg63ByuqAdIkgZa+iWl4TragVL16NQEZZ
         cKFvSY7qB/Six2Bo9bTWIoXcl7Jt77gLQPByiPxK04cd4U4CbVPdpqTp1JpcVcyW9uno
         xEphywU7LDGEEFt2yKZ3tVa4e2z+j6LXiDy4wEjN1FtUj+3eD/mzwwh8n5J0EBSDlKnt
         sP6ogfUK9DwihEhjO1SFoPCcjop+MpKFVlx94znxuI1s+PYddNB1gyivWH5Iyt6xfXlx
         FJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081864; x=1790686664;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aBD7QfFK9h16ArzMKza718DmtrKmQM3BpDgAFXcDf8I=;
        b=svft4UZETNPenzMsaseigyybbipDEB4X4nM4i9lrxQ6sxPsTYFVfIe8EeXNtC4ljU0
         AxcMqnMMfihjdColVwLoAUyJJp67XGUIscu7hsT8i5Ual+y2qHtjKEqqPe6CrPXOTH0g
         K4PAsAk+b+o6QkNXhyrQ7dgoiuKEXQ+HcfyoTF/5ESGcaLuPB6CEKFq+W2WrnyukS7iA
         HcgjJnmyQEo5rqvn+pQXrHYgtffuJcMS4VIsRa2T6PLmyGebaXf14BSSOqj6EkYkB/3E
         yyG95fkRI8UVYu/EfhEYLbd9BwyygryqLVal/iJxWzu0Pm2zYnAgRAn0ieU14bwHi3Jy
         ZgBQ==
X-Forwarded-Encrypted: i=1; AKwUvBwNxGh5wg/Ja10zWlGX0peaYkloWIrKKZPg5Vx+7mbOJJAS43szK87HUoGA9pEHJy1k3GzS9BQ=@vger.kernel.org
X-Gm-Message-State: AFuF++ma/2N4CCe5Lz+15tGFZCXs8yhBEe6ijbNLdZdZBWa865XS+z5C
	8RbayiRjvlBPnHRLJlrMQGo9jj0er3uzZq6+zfFHw2W8Q4ITTGi3Z/l3VOgBTcF+N2xGqji+AZs
	IiAc7c9FFUslMq0sx1yEIWJzXUHNZgRsAAen+x54Ll6/p8cxY7nqEJyqBShE=
X-Gm-Gg: AYBFou2X2a+46h2N8A0ZM21dbxk6bKA+fDu7lQeQKNZiv9rmugx2p+Q1xGQq0Yg2n8J
	irTg2Aus/2l5cMgvssNH+d1duSF+0lTl3Z3Nf+jMYe2oJa8rc8iDuaqLPyGmLHWaxg0b5X7MbCZ
	46rA4WmdRwKa+Swwc3l1GFfI+VkORmz0mZt/hOi6oDByihUL/T9mx4KhJcT/aUf3RI2O+oxvaBp
	Wj0/QjEpWlSVPNpfvz69HyEmCRrL7t8ljM2VgWPWN3bYw79CIzAwgi4qqU0mFvYPMKIyVIV1W+b
	TaAB1PqwlXcG7poPaGGYfupnGsVN9SxFUhP6t2CooxgzKGIV+jzmWVWf7CemthcraOu+TIMXGlP
	GstSPYaNPEdzSrA47u/pzgSuEqNM=
X-Received: by 2002:a05:6122:4b81:b0:5c5:db2b:5baa with SMTP id 71dfb90a1353d-5c9d8b32805mr4384483e0c.6.1790081864071;
        Tue, 22 Sep 2026 05:57:44 -0700 (PDT)
X-Received: by 2002:a05:6122:4b81:b0:5c5:db2b:5baa with SMTP id 71dfb90a1353d-5c9d8b32805mr4384429e0c.6.1790081863521;
        Tue, 22 Sep 2026 05:57:43 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5105:ff9:e148:c440])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaa4537b5dsm1097669a12.30.2026.09.22.05.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:57:42 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 14:57:16 +0200
Subject: [PATCH v9 01/14] crypto: qce - Fix HMAC self-test failures for
 empty messages
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-qce-fix-self-tests-v9-1-b1aa742e79af@oss.qualcomm.com>
References: <20260922-qce-fix-self-tests-v9-0-b1aa742e79af@oss.qualcomm.com>
In-Reply-To: <20260922-qce-fix-self-tests-v9-0-b1aa742e79af@oss.qualcomm.com>
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Russell King <linux@armlinux.org.uk>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5101;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=3F1JI29VdO48cQYdRWVbGd7NfSqBKkKmpU0CrEzeykE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqsns1ck69ODuwAokeedDTXMLw+9NKSg+NpRPX3
 UU7SCM3ZYyJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCarJ7NQAKCRAFnS7L/zaE
 wzQOD/0b36i5isTtX+zIy9vNiJDT/vmrlbvHAUkOtnMv1tcomEk2c8IDgfASNis5H3HWTo/SVbg
 66TlJuf37hneBEQpPK1KRyBcleoeNgsklm1I3E13T/lc3M59+/vG3w+wQSIdnipWZfWUscimJ91
 GpYGrjYs9ImcX/aqsdgT2+OLCE55fcAcEHCSLJHRa604uMuWnpkbw6y8TUTAnFLs+v5BWnSaB9D
 QRZ3WIQ/s2y/Y1mGsUv1hmU8z0Ih87ZiCiaXOdQLfc0pTpjJA4fehwpt0YkdWPTq09fTsFBSjKU
 dv4LQN/OpJLSAE8Pq+FoQMwy6udlMASmohBFlpKoDL+zqlFZ1ZJfrJaoTzw0dhNT5a0EQVFZVgs
 /fgCliZwkKIU8Tj0xbXzo//6PBCI5j5P91z4dmFhZYiqQ+JTVxW9r239CoU22UN3vUpuR8lQM+h
 Q/POQezol6pqLhalQt1IRIWGnazRi6thefyHYsvpkAV1tJ3Pww0FYyZvQOWA3S0AFy0+46E3Z1C
 JjUuekIsG4tJ5C9GahHu/vf01XnjefFwb1PYz1meYiV0ObimsOUdP3ma6s30jiU5qGQy9Db05U5
 iYFqohHt1DP4j78W7OJv7Zr1d6xjYSHuWJNjV2sKgBvBfmhm3rmGyEu2Dstib8Xux6cL7dGEi/N
 8XGTIwHhCtyPYog==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: LPPnh1Xhd4cEH7yBZD7vocjsGInyA2c3
X-Proofpoint-GUID: LPPnh1Xhd4cEH7yBZD7vocjsGInyA2c3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE4NyBTYWx0ZWRfX3N0Lq2cjuA55
 V65RQ8qTYSG/QekLNAL0rmlDzmivxaDDglSGi7lkrNReSC20jmRDff9vDJBc+g+o0ZoC4FkICSB
 7B6b7wE36eFJHnO2AsDCGqw60GJ8ZBK2XDjeD8Z+SJiuTsJ1E4njczTDwlXcQ3/Do2uFMqPGWyW
 KCHH7AxDpro4wtJBD70nhEhyI9cqY4OagQi/ljW0VUryHnyvNWwUHy66+ZYNXGnK+6MVnipuBJz
 5MCd4nI6ySa6ytZpVbHuHp06bkj56sD03xv780XYE4nY7BJ1Mdm4RrQgohNeCd6N6FhkoVb6QF/
 zHi2PuHtTOj/UNLPgNFR4rfQ+jcRgfC2ts8WU/jNrtNJd7UytJkweQ1nwtiSRBc1PKapjDp0Lks
 b0ib5iCqr7eAl4gc+5A1h4P0Pxpivm4bmbaeXBTOXRVLmd4u7MnNkmDIqIIU7X5UthFt2MNQrq3
 fkS3t8SyAxFzNkr3h5w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE4NyBTYWx0ZWRfX8EilQapPfGx/
 aVpKJM3mWudwbh+P90gfNlKS6E+Nz+wJo+B4ldgY05+zv+Lzjn0yPsrTFHsQXJrrqBqA2hSb59N
 h50MsG65yxRfbjS7NtyrmrDI+ZVKqzA=
X-Authority-Analysis: v=2.4 cv=TvFzFzXh c=1 sm=1 tr=0 ts=6ab27b49 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=7HxpRQPu5N1oW2hdKb0A:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220187

BAM DMA cannot process zero-length transfers, so the driver always holds
back at least one byte to submit to the engine and only ever finalizes
with an empty buffer when nothing is left to submit. For plain hashes
this was handled by returning the precomputed hash of the empty message
(tmpl->hash_zero), but HMAC's result depends on the key and cannot be
constant, so hmac(sha256) produced an incorrect digest for an empty
message and the crypto self-tests failed.

A zero pending buffer at finalization time does not necessarily mean the
message itself is empty, though: the caller can also reach it by
importing a state that already reflects some hashed data with nothing
currently buffered (crypto_ahash_import() followed directly by
finalization). Special-casing only a genuinely empty message would
silently compute the wrong result for an imported state in that
scenario.

Handle every zero-length finalization consistently through the software
fallback ahash instead. When nothing has been processed yet, let the
fallback compute the result from scratch using the key already propagated
to it via setkey(). Otherwise, reconstruct the fallback's running hash
state from the state kept by the driver and finalize from there,
accounting for the HMAC ipad block that the engine absorbs internally and
that never goes through update().

Cc: stable@vger.kernel.org
Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/common.h |  1 -
 drivers/crypto/qce/sha.c    | 58 +++++++++++++++++++++++++++++++++------------
 2 files changed, 43 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/qce/common.h b/drivers/crypto/qce/common.h
index 9cd2e6ed8bbb0f76e24be187d8ae7e2fe2f7b932..587d349da91d1faa2bed7cd488306d4358467b2d 100644
--- a/drivers/crypto/qce/common.h
+++ b/drivers/crypto/qce/common.h
@@ -82,7 +82,6 @@ struct qce_alg_template {
 		struct aead_alg aead;
 	} alg;
 	struct qce_device *qce;
-	const u8 *hash_zero;
 	const u32 digest_size;
 };
 
diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index b67d749db05f2b9823cd2f0953ef24f4f337df2c..8c12c072f4a9da2d97a51f29cf8ca22a6411063e 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -249,18 +249,53 @@ static int qce_ahash_update(struct ahash_request *req)
 	return qce->async_req_enqueue(tmpl->qce, &req->base);
 }
 
+/*
+ * BAM DMA cannot handle zero-length transfers, so the driver always holds
+ * back at least one byte to submit to the engine. A zero rctx->buflen at
+ * finalization time does not necessarily mean the message is empty: the
+ * caller may have imported a state that already reflects some hashed data
+ * with nothing currently buffered. Handle both cases through the software
+ * fallback: reconstruct the running state when there is one instead of
+ * assuming the message is empty.
+ */
+static int qce_ahash_finalize_zero(struct ahash_request *req)
+{
+	struct qce_sha_reqctx *rctx = ahash_request_ctx_dma(req);
+	HASH_FBREQ_ON_STACK(fbreq, req);
+	struct __sha256_ctx core;
+	struct scatterlist sg;
+	int ret;
+
+	sg_init_one(&sg, NULL, 0);
+	ahash_request_set_crypt(fbreq, &sg, req->result, 0);
+
+	if (rctx->first_blk) {
+		ret = crypto_ahash_init(fbreq) ?: crypto_ahash_finup(fbreq);
+	} else {
+		core = (struct __sha256_ctx){
+			.bytecount = rctx->count,
+		};
+
+		memcpy(&core.state, rctx->digest, sizeof(core.state));
+		if (IS_SHA_HMAC(rctx->flags))
+			core.bytecount += SHA256_BLOCK_SIZE;
+
+		ret = crypto_ahash_import_core(fbreq, &core) ?:
+		      crypto_ahash_finup(fbreq);
+	}
+
+	HASH_REQUEST_ZERO(fbreq);
+	return ret;
+}
+
 static int qce_ahash_final(struct ahash_request *req)
 {
 	struct qce_sha_reqctx *rctx = ahash_request_ctx_dma(req);
 	struct qce_alg_template *tmpl = to_ahash_tmpl(req->base.tfm);
 	struct qce_device *qce = tmpl->qce;
 
-	if (!rctx->buflen) {
-		if (tmpl->hash_zero)
-			memcpy(req->result, tmpl->hash_zero,
-					tmpl->alg.ahash.halg.digestsize);
-		return 0;
-	}
+	if (!rctx->buflen)
+		return qce_ahash_finalize_zero(req);
 
 	rctx->last_blk = true;
 
@@ -292,12 +327,8 @@ static int qce_ahash_digest(struct ahash_request *req)
 	rctx->first_blk = true;
 	rctx->last_blk = true;
 
-	if (!rctx->nbytes_orig) {
-		if (tmpl->hash_zero)
-			memcpy(req->result, tmpl->hash_zero,
-					tmpl->alg.ahash.halg.digestsize);
-		return 0;
-	}
+	if (!rctx->nbytes_orig)
+		return qce_ahash_finalize_zero(req);
 
 	return qce->async_req_enqueue(tmpl->qce, &req->base);
 }
@@ -431,9 +462,6 @@ static int qce_ahash_register_one(const struct qce_ahash_def *def,
 	alg->halg.digestsize = def->digestsize;
 	alg->halg.statesize = def->statesize;
 
-	if (IS_SHA256(def->flags))
-		tmpl->hash_zero = sha256_zero_message_hash;
-
 	base = &alg->halg.base;
 	base->cra_blocksize = def->blocksize;
 	base->cra_priority = 175;

-- 
2.47.3

