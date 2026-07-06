Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E742BE7A7
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 13:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346061; cv=none; b=LZmOi2hueH9HFTmjEm0f2FC7XpF7DQ2aACDp4RbYuQK9OUZIIbamJl9t6DoJRcthLJw3ES0xJF42ORn9LokHQpBaclNQXqgFb9+/cpsOBQBfxernNNBRbWyVH/2dYrQYVgXmNUsHIeF3GdJN/87+tYhmyQI54qPew+ON7XxOXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346061; c=relaxed/simple;
	bh=gaVQmxW4odSZxZIF7KtMg6KBYyDP5vW8dy/ZepTvgfU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FPFpYHtRJd23Fmb57Q8V+wtu/YCvqtLvL3WqereLC5LOC92b9/BBFkQJsif7zeVSZql/XleZjPqkEtLPPOPC4V+JOJnFUp4gpUYmb644Z84JVmqVUFXlMyIiwExdOBzwefAXYeA4FIiUE9S7Vat4KZcCKKNBQCx7Y9UA06IZUvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Rr9WdsZE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Jldqv3Gh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Rr9WdsZE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Jldqv3Gh"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxEOZ395308
	for <stable@vger.kernel.org>; Mon, 6 Jul 2026 13:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	600H1VFIQ0xguAuNOlb1Z+pl8+ujHpSJ/obydsyo3D0=; b=Rr9WdsZEfGyIRtTQ
	du0EeQ4ltr1A54CEGgqfgFZNK2GyiMKJX76YDfVbTiohqkB1o89rgxnasVsl7XMP
	PgyQ1OisuNteazD6BWwvl3xnq9jSzRU2vZAHlndUOE1Tq0a/KYARiG4+FwadSbbS
	l4YbNQNOGQtl5VDxuTH+BisTxAGoXq9l+B4uhFSDcrUR+tmnvaA4Fh7lMnlvxwNz
	Vi3VvQ/dotWplvPbJylNncjLEYjcLPVbxqrFCAnymqa/Ij2NjvSwyJOQJNtDgVMG
	h5O6PFPSyLxHWhGyi1u1rp3OsH9Xm/OR1ePjcc8S82qlKsWm3rEb3wku00wjNWNh
	TIDgsw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f89qph17u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 06 Jul 2026 13:54:14 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e55721a8cso313416885a.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783346054; x=1783950854; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=600H1VFIQ0xguAuNOlb1Z+pl8+ujHpSJ/obydsyo3D0=;
        b=Jldqv3Gh8HfkIZohvvwk5pJCmlk1y6gRpCi8zb8FU9UbJo4oe8qyNszbmePpCNIH3J
         UhAoCPI0fbQeAsUMeE5IH2fYXeqmlbaCfsjZrc4YdN8YaQRCGIEE2sY3z+nP+GERTXfx
         xdvrZ9xx9NV9DBQnaVVWdMzbJjPs+5lXiQmBFoK+KxAXlbs0tZkdDeGku6RRUf6oWWzH
         JADxdgsxY4Ym+3h37vs11V9WBXNb/oJ/6tEDmt48eT+NePUKZ4xZu67QCmsQbBA4tBq9
         VkjD+SUT8hIMM/SZ3uXU/zfmNrybcDa4Iwp0E0xpb+71aXLT1c8GumskrekFzX1qB6zy
         MuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783346054; x=1783950854;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=600H1VFIQ0xguAuNOlb1Z+pl8+ujHpSJ/obydsyo3D0=;
        b=AtFxuv+2WNodEjCPGv0od60/PUzGmkIjgWv6vkHppPEKKcaZmD7rjPL4o2s2k1MBZk
         yjAYLWd+eV+mZOyvMla+MGq5rqJMinJJRm33sQkDsbaFg/GSt6X4spLtIHvDzdCy26/B
         Z2lML8MYCytCa216dmu0sJQijSoyZJbvUjKx5l1L4HvrZmY8+Ig80iRq7EzVzVEObXCT
         GqmUwCJ/GdEj42DNt8YJUmBiF6ATjUbtw1gu19XqROxuJZQm+4MJqBney9UqymV6Q2ry
         3i7yV9AkB9MYaCgBOxTNYDPIIwwPqsD8i3eSiaYO9J1GhGaylkkyzUrxMXCMvVtx6cSp
         pPXw==
X-Forwarded-Encrypted: i=1; AHgh+RoEUFhoXCl17xyHYrkHBj4xCX9RvLlpIrCYeh95UB0YNoO/OEiYRWEZGKZjeJ6hcqqEMAdnAkw=@vger.kernel.org
X-Gm-Message-State: AOJu0YylSUM62wTkk5ph6pFK5CI0aXXQVaPKoGESRXb83Gyrh96ajYVJ
	Vza/Qqhkzzsg06DZ8tFlLdjavLH+agFod/IH8HXNAAmZR0zcfaWdPu/kVV4wqUnwjdnC5J9B0v4
	ERlPqv4qno6s4/Yj8AROyRSyfxAOuCQ9odvQTfb0jZzIY1N6z+cg4mBl2zPM=
X-Gm-Gg: AfdE7clxHBzwT44+HuXHfsWmucfYiaaUsiu+hHHfDh1WHAx4mlP/0/vLKpQSozt8K2K
	tcPVn1pWvkZoBcQHz0g0uUqOe/Dke9/KwNevinvyrptzWZSl2+dZBywOhmXzk1/1yleSeW2bexb
	rWw5lmK1i/meGGoK1MVYIirz+HYOQh7SBT8vPPNh9rUr+/+Jp8OFxzB6TEgdEm0hYbacOjeSlOu
	CJymF0TZeKVtTmf5O8OsDrMjg3Upwf1Lh47O7N/2CfIE2UF5OsVpydaEZyKrITl4KZiCBVLvNd+
	rxHH+Utt2Yy8rGE/cOJvpAEFHCYXfQzE9IoqeOo4i4tir5Eeqnls1sRwRaSDs3HMV5pl39gDnXU
	imyy4jzfOrAMiOSrk0jwN0v9XV2GPMxnRUdQ1zhgn
X-Received: by 2002:a05:620a:294a:b0:915:ab83:6952 with SMTP id af79cd13be357-92ebb4e1e8cmr95164385a.16.1783346053473;
        Mon, 06 Jul 2026 06:54:13 -0700 (PDT)
X-Received: by 2002:a05:620a:294a:b0:915:ab83:6952 with SMTP id af79cd13be357-92ebb4e1e8cmr95159985a.16.1783346053014;
        Mon, 06 Jul 2026 06:54:13 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63ba971sm619805145e9.13.2026.07.06.06.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:54:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 15:53:52 +0200
Subject: [PATCH v5 1/7] crypto: qce - Fix HMAC self-test failures for empty
 messages
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-qce-fix-self-tests-v5-1-86f461ff1829@oss.qualcomm.com>
References: <20260706-qce-fix-self-tests-v5-0-86f461ff1829@oss.qualcomm.com>
In-Reply-To: <20260706-qce-fix-self-tests-v5-0-86f461ff1829@oss.qualcomm.com>
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2454;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=gaVQmxW4odSZxZIF7KtMg6KBYyDP5vW8dy/ZepTvgfU=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS7N5rXFvVZszOs4rKlHWZNuj2npfq0TJqoO80
 Q0KfZGeoz+JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakuzeQAKCRAFnS7L/zaE
 wwo1EACAUvL25XRLezRo8/JjfMnU6W8A3UX3us8rftAn1Mlx9GtoE3n/I2g1Scyg6tg9qEpRmZA
 6uJszR3IvpPM/ibMqGGT6jUYppQE3jwjzfRmbXgB6HaCKV8MWwm63XIcpkrHH6M8OmY+mq3WAUb
 InaCU/dICTdXjs/n28/mxXrG3SwUqfPQ9jBgeOw6VQLlZdo034PF0D+CkNmRFivyX1IwN2RJXui
 t4vzGZphjRzGBb1TAZLEFiFEg4BmqmQFOHOS0VQh201tXKKRUHMjGj+fGyAe5ZMJJjiqwx7aqK2
 44T1YUG4vXlgP3tLcHJ+r/TEjRh9XDgzJULqSW1C4Sf4MVDPHEOIfq1Ic9R7K4zExC5K/L1mHMV
 DGHu488flw/h/RrEZ5ctS28+iKDnEfx8sDy9qcuTCyL3MnlxFVZmYJdhfS71bSO3Idm9UATzTIv
 vXPEjzq/buapDlOHaEUx6CW3yjCpEF+fwyDDYOEQT+O444nJfjnkrEdyGGzB+piWfBA232mukot
 uayJ1o6pe2oFw3xvquTlsWlRHbgJHqli3NsN51GL2c89q674+FdHng+PWjyI1/GtCEEoUu6PYFk
 r5fWxPLPi56YnMLlR9HmSgU3OHQ0lN7h7vk5WHji11ooR2D1h3hC6tsz/GK7sYnPfEqYhrp3YFg
 FuhpKXiAE/5VLGQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=c6qbhx9l c=1 sm=1 tr=0 ts=6a4bb386 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=OgKJrOtnYjB2pLVqIKkA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: bZQLbgyrAYvbhjuNuiCKH_sbDGvhDBrY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX4NP3Tg16ax7+
 bF9++tT0g3bVuF5Mz/8gV24ZJiVnR+aD2or6EZAEjoj7fuWV5+m7w9h80Hj/7AzCQ3zX+vmZc8T
 88hv2eXWCD2hNKyh4J88V3Pgqru5ZLhAuHjv4VaYrkwhwal8qeAK+J0LlfepYT/T+93O/uA3lHm
 DBfrWeO04e7pN+XdZkbduvQUQTLqzZA8OKMiw9OYNIeBCpBGN6mD7SDQVBMoVuwqdPo18kphz+S
 KCtcJnAlphNIbv9tEFr5alTp4/e9nSZVHpn15lvkAlEZJ373a8P5m/o4vQpxWM+TlRJI/4PdzFO
 nH3ZFYC99HuIP+TuR0mFz2IC++vk2H1uqKqF3zXHICUaeKl92whWHmj5fqxRPspkVYA9fKKw1du
 B6DG0B4y3jj3g3BZ2+bCCVlGy41opO73c6+1nAoOowclm/zcYBZGRCUOFEmUi8MOv2xsadz4j9g
 6dLdw3MGGmwl/5EG7Bw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX9zPnhs1fMpm3
 P16TTfzqyLb3048UocSuImwnDZJcK9MmPXJV/CCPYPwb/FxM1nGGEURRaIrbPoBCWFgfYgrpM1J
 zW9cEbzp6tTGoI3j6T2ENYlryFKuN9k=
X-Proofpoint-GUID: bZQLbgyrAYvbhjuNuiCKH_sbDGvhDBrY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607060141

BAM DMA cannot process zero-length transfers. For plain hashes this is
handled by returning the precomputed hash of the empty message
(tmpl->hash_zero), but for keyed HMAC the result depends on the key and
cannot be a constant. As a result, hmac(sha256) produced an incorrect
digest for an empty message and the crypto self-tests failed.

Use the preallocated fallback ahash for the HMAC transforms to compute
the digest whenever the message is empty (in both the .final() and
.digest() paths).

Cc: stable@vger.kernel.org
Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/sha.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index 0a3f88aaf5169ea7b47a549bbc10ea87d3ae7a2b..03b58a83e540802e88fbf1394108da35188b68bc 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -270,6 +270,25 @@ static int qce_ahash_update(struct ahash_request *req)
 	return qce->async_req_enqueue(tmpl->qce, &req->base);
 }
 
+/*
+ * BAM DMA cannot handle zero-length transfers. For plain hashes the result of
+ * an empty message is a known constant (hash_zero), for keyed HMAC it depends
+ * on the key, so compute it with the software fallback.
+ */
+static int qce_ahash_hmac_zero(struct ahash_request *req)
+{
+	HASH_FBREQ_ON_STACK(fbreq, req);
+	struct scatterlist sg;
+	int ret;
+
+	sg_init_one(&sg, NULL, 0);
+	ahash_request_set_crypt(fbreq, &sg, req->result, 0);
+	ret = crypto_ahash_digest(fbreq);
+	HASH_REQUEST_ZERO(fbreq);
+
+	return ret;
+}
+
 static int qce_ahash_final(struct ahash_request *req)
 {
 	struct qce_sha_reqctx *rctx = ahash_request_ctx_dma(req);
@@ -280,6 +299,8 @@ static int qce_ahash_final(struct ahash_request *req)
 		if (tmpl->hash_zero)
 			memcpy(req->result, tmpl->hash_zero,
 					tmpl->alg.ahash.halg.digestsize);
+		else if (IS_SHA_HMAC(rctx->flags))
+			return qce_ahash_hmac_zero(req);
 		return 0;
 	}
 
@@ -317,6 +338,8 @@ static int qce_ahash_digest(struct ahash_request *req)
 		if (tmpl->hash_zero)
 			memcpy(req->result, tmpl->hash_zero,
 					tmpl->alg.ahash.halg.digestsize);
+		else if (IS_SHA_HMAC(rctx->flags))
+			return qce_ahash_hmac_zero(req);
 		return 0;
 	}
 

-- 
2.47.3

