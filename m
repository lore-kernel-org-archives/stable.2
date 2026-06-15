Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BF340F8C5
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538642; cv=none; b=hQQXhBiPFiuyKLZc/KWSBhY2wM5ietFiX0QbgqVHBh8jiNEg7SoaKbOxHkxvoi53zEmZwcP94E1L1XRPUu/L6Ugel8a8jsqmrMhgVnvf30E9tQ4v/hnw8elhgIT4OoCqeal4HOvn9JXYIdykbrekpXd7WV3IXXouWOeB3bzkSp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538642; c=relaxed/simple;
	bh=KvKsD1oCE0rkeeerl1Qkrj3anJH4Nry20STguSSstzI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qkB0rIOx3l1FgQ0qiJX0DRt+HyMBoUlm90rQ5KWnS38xmPKibXT+S5miQ0lNPcELxB2xVRLVPV1e24UWvj7RerWSVQTZJDxa/k3m4BBtOzF2ws3GSykercxnDwGJOdxSd3AkEaGMyHlTw+TD7QVXaeEHs/kM3tbexsN5jq+RbOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lhrRmHAh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EJOPHw86; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lhrRmHAh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EJOPHw86"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFhMkh446931
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	G7SbATcVMiFsT79EwQb59/1DavxNWK+xOjZVrckBY18=; b=lhrRmHAhiUuqgROK
	u1glkEfRucS/f8D4qHnrz9V6rdnIna2/QX8H6oY+byq51LEn4lV/KohIDux0IIw8
	unv5wyN4qIj5dpN9GICGdYHCsPoEDX4vWX7llsf0Ej06BPOGP3yOJf8gl4o7hkZq
	wF1mtwS+OeLFQyJFEQcmdUXCEmYrVvty7+W+LgUQxte6oBCbezzTakSDZv2U+01Z
	N1zyoMVRC0BT7KrghIYBGiqC2Cen23/LgOuc+duH3ZzUday+VbzQf0iQ6ikIYsPd
	jGhsZJkfr0G5pA2llcvKLW6glGEbI/AexfgXauvn5pzFg343sihAqYIebvAytw+4
	YeieLw==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etew0hjcm-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:40 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6cfe512e871so1418659137.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 08:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781538639; x=1782143439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G7SbATcVMiFsT79EwQb59/1DavxNWK+xOjZVrckBY18=;
        b=EJOPHw86MxVlkegRerHO3a4xggw57pmpeOGt22DzrOg7LYAduN27zZ5KZK/aUemJTB
         N3HNbCcUSgrywXGxqY1nLxthIiOboOHFtZ6UIj8RAvZLcA9+9STpNReRu9zIPmya0nAc
         8cUkC0mJFECow4aL6MnE35ay6sihbveHUbqa4+upLfyO9vg/Yr/KLfJJLsTrvTTi+kER
         2iEW26QHNuNqTfn0LHhQyfswv+P2bHUJkuYH77lnxgFd35UcUQ3RPZsm2LMtuY1QBKqC
         xGlKA8yn9SfMz6+hjegX+XdQjo2uuVsL/ZuAqkJ85jD/rUwdqcFOVtHoTBhMqtPoQsyA
         fRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781538639; x=1782143439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=G7SbATcVMiFsT79EwQb59/1DavxNWK+xOjZVrckBY18=;
        b=WwuCy1MKrA5XlMm2gKfsNMTNavzx2XnkJQjtt5AEyOU9MrRq6s547r7y882TLMu+Wt
         RjEUDB66TroobjkYXiKVki/JCFX8NF5X72OpXhrNtBwo26K2nB7Ht0Z110eYIQa+A6gC
         myOkv0OXN/v9BUiVeWEs0MOxBAhnE9hvJ+FsyVlhhRIss99QBXpRUByKmwmXM1sY4wLo
         Iqt6JC1oavsfl3aCaWeL+k/0cIZTumvxI0u+Pj5utvtDv4FhZ4bpYDkkhVh7qWFZGdru
         yeUes++F3NuzPwH9D7Yd0sDnFVDtl+T/fZELjrNCrzuHH04tBT96f5xXT3F8ee4fYVAl
         6imQ==
X-Forwarded-Encrypted: i=1; AFNElJ9E+JjNI/z9nmq4QV0vk8eBBLMkIIFmfOaQNQHLZDvfxoSksm+8lJf8f+OnhKf5V2TXnwmnNY0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw78lWVvPFFFiCidQRQ5qUp19oBH558YXikDqe6HRCAwPwZyiMR
	mSH05OspjN5RkrHPwkGQN/rcIBuhluqhPQzey1nsNGPRxiXMG60AYDhY9xewHOyG5MNuTpx3ldB
	7QeRcQx+lWTWoOLI3l8B9qtgR0MB0sXDCf6PiSx2ZDL9zN5wCCSplhFIZ56g=
X-Gm-Gg: Acq92OEcIGIVDemxkk/03t1MKMDli/1qo241+BIRv3/Sok/mDzKtbx4bOeVPU072Lkn
	mqftuLLLIMxiQfui3PGBOSdA5QWAqF9xJWVo4rPOKWwVCVBq+xgpIQWZJqhCPVhWpxR0ESEweJY
	Z7InYc9/3Jtvgw7VtxnTYqVyc+kO/bGu+jxzhSGPAmP44oa1Qkmp23FRhidBFTBnrZ3TKEribG5
	iEWFk+cGvtHtT3Rw4+P3mNt9FBiZ9aqoi6yKjIDJ/mQtr1XcsNrgdJ+DkDLDfkYXtnMMYCI/Cpi
	jqUC/hHEPYT1t/+LDjlOOovRftjhH9kpLx4Sf73IR+sLmXAN0mFrxlMgxLd5rsFG9H/ULylpU0x
	Ir55b8d0rvX+cgMUFxSh2kcvRlaUvFr/49RjfNWihvseFnKQNrBs=
X-Received: by 2002:a05:6102:2c85:b0:612:c135:1b77 with SMTP id ada2fe7eead31-71e88df2b42mr7328468137.27.1781538639323;
        Mon, 15 Jun 2026 08:50:39 -0700 (PDT)
X-Received: by 2002:a05:6102:2c85:b0:612:c135:1b77 with SMTP id ada2fe7eead31-71e88df2b42mr7328430137.27.1781538638884;
        Mon, 15 Jun 2026 08:50:38 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:7fe3:eaf0:5a0b:2610])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f450sm38643032f8f.10.2026.06.15.08.50.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:50:36 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 17:49:59 +0200
Subject: [PATCH v2 8/8] crypto: qce - Use fallback for CCM with a
 fragmented payload
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-qce-fix-self-tests-v2-8-dc911f1aad42@oss.qualcomm.com>
References: <20260615-qce-fix-self-tests-v2-0-dc911f1aad42@oss.qualcomm.com>
In-Reply-To: <20260615-qce-fix-self-tests-v2-0-dc911f1aad42@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2849;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=KvKsD1oCE0rkeeerl1Qkrj3anJH4Nry20STguSSstzI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqMB80S9JUjxQh1fbW6vsL+klslVG3uBeVlD5ko
 2GTT+AMYLqJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCajAfNAAKCRAFnS7L/zaE
 w9yeD/4oOa+p/BCe7oqls3ipN23ye/CvvP+Hm0YAu/ZnFZ2vYC7CcspnA3KW+BV9CHwth+IDCJC
 WCHAkLVLSWXgkx7Wjg8PxsTccW2uzP32pO5VHclJN+BVxfcYHKOmYZ+oQ5l8SXUFfaq6uMc2cdx
 qpK1EKvCb7900lxcJyVDaWXaz4npFoLCZgAc6pk9QLqlXPF4gkLlEUGwftkILomWdijPP0ZNANj
 SmcRyyo3+1GOXGGw+5775DnK0MWKJzwR4OlrJIwkI5gldeeu7FBt6zahvVXY1f6FCrvPXsvMoyZ
 WP+qZTXfgfiCdsX8oni5ZD8fKJ5Sf1BDBnboqLN58KpGXKxgXEDGASIVCvz/txwq9IY0FBk1SKv
 cf7kMtmIVpPwKlmP40MGqSa/JFvlnT3eapot85VGEXgH+DYt6+by+L+aH/Es2O/u9j4p2BbIXM+
 oirhMjpuGz2/4fWMIHQ0eOyH0Z+27dY5F2lGW7diddEWyiFapPZl+2NcQyHpYDgxj8YpsU0HA/G
 E9oeHikId3AG6kaewRpyhVfu0g063eSo3z6gT9yLpfuZunlSKLpV9N5wzfQCrllNG4mU6H1SeRU
 W1U9xCXAg5H8m8OWvx+lbQtSBvIpHmsPozwG73vAst8wVvHqLXdmZw3KDt94j3yUC4CDhfwvvvu
 qLcpMFQBWlGKy8Q==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE2NyBTYWx0ZWRfX0RHOxQy3lBiK
 Az5waaEZ7F2OgvlTmEdyFpVCnRk6eLIB2v/4K610Hojw9Z9zYck0KsJ38MS3/MYONByySw6vgGk
 fJ2mqW0Y5nxQF7jQjneWMKS0hWQuMsE=
X-Authority-Analysis: v=2.4 cv=QLlYgALL c=1 sm=1 tr=0 ts=6a301f50 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=phyxH6jkQibGXiXynFEA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE2NyBTYWx0ZWRfXwaqKPNFaKLYz
 lHtexAqplN4uaq8HRdTIHeb9JTGVnFZxqN9Q7KwJnuCv3vkh1J98ALatHX0D/GQDBD7GJQGxqHl
 Y03tZ9ZmkGOpHCcANBjhBb2TxdFqlnyD5eGoJxltz0inlwDM2S0Ot7lAAVKAsdPYou93RAm15Ne
 28bGo/lJyX503fl3UHc+H2X4fPjJD+84HyUL40sm5EHTbTCoMUMG7XWvrAqybTMM1e2qd/RjwzG
 QZEasAoxt4xnt1YhYQpMq9BLkXRcHkSGQmNa6tuGjwYQvVxcEQbFYdaT8jHR7Mu92ivhouYBAae
 x0RizhN4Me7XsUlUh5+X92vP3N8Z8/mMok/nrAvqZlbWakA3JV8rv1VQI/taYUtOYP8Bxakfw/x
 nkQr/YCyD6UENCXbtwF1Pc00Pr4TqQ7QDWzJiqlD6AAEh+6AUsqr6bbMGyMagWF0rMpURxQyBMB
 kZcpt8q442rZpdmKq3Q==
X-Proofpoint-GUID: 1ZUaG3mpYD1lkF9Qp8Xa1RufEC4nxaxI
X-Proofpoint-ORIG-GUID: 1ZUaG3mpYD1lkF9Qp8Xa1RufEC4nxaxI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 impostorscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150167

The crypto engine reliably processes CCM only when the message payload
is a single contiguous buffer. The associated data is already linearized
into a bounce buffer before being submitted, but when the payload itself
is split across multiple scatterlist entries the engine stalls waiting
for input and the request fails with a hardware operation error. This
was uncovered by the crypto self-tests, which feed the algorithms
randomly fragmented buffers.

Detect a payload that spans more than one scatterlist entry (in either
the source or the destination, skipping past the associated data) and
route the request to the software fallback.

Cc: stable@vger.kernel.org
Fixes: 9363efb4181c ("crypto: qce - Add support for AEAD algorithms")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/aead.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 46d3e3eb53b271e2ce755847bbcc83f81b9bda7e..2f4bb4fcd8265a0f7c2f568dfb8915b8c6b8ecee 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -500,7 +500,8 @@ static int qce_aead_crypt(struct aead_request *req, int encrypt)
 	struct qce_aead_reqctx *rctx = aead_request_ctx_dma(req);
 	struct qce_aead_ctx *ctx = crypto_aead_ctx(tfm);
 	struct qce_alg_template *tmpl = to_aead_tmpl(tfm);
-	unsigned int blocksize = crypto_aead_blocksize(tfm);
+	unsigned int blocksize = crypto_aead_blocksize(tfm), authsize;
+	struct scatterlist __sg[2], *msg_sg;
 
 	rctx->flags  = tmpl->alg_flags;
 	rctx->flags |= encrypt ? QCE_ENCRYPT : QCE_DECRYPT;
@@ -524,6 +525,27 @@ static int qce_aead_crypt(struct aead_request *req, int encrypt)
 	if (IS_CCM(rctx->flags) && !IS_ALIGNED(rctx->cryptlen, AES_BLOCK_SIZE))
 		ctx->need_fallback = true;
 
+	/*
+	 * The CE reliably processes CCM only when the message payload is a
+	 * single contiguous buffer. The associated data is linearized into a
+	 * bounce buffer before being handed to the engine, but a fragmented
+	 * payload makes the engine stall waiting for input, so route those
+	 * requests to the fallback.
+	 */
+	if (IS_CCM(rctx->flags) && rctx->cryptlen) {
+		authsize = ctx->authsize;
+
+		msg_sg = scatterwalk_ffwd(__sg, req->src, req->assoclen);
+		if (sg_nents_for_len(msg_sg, rctx->cryptlen +
+				     (encrypt ? 0 : authsize)) > 1)
+			ctx->need_fallback = true;
+
+		msg_sg = scatterwalk_ffwd(__sg, req->dst, req->assoclen);
+		if (sg_nents_for_len(msg_sg, rctx->cryptlen +
+				     (encrypt ? authsize : 0)) > 1)
+			ctx->need_fallback = true;
+	}
+
 	/* If fallback is needed, schedule and exit */
 	if (ctx->need_fallback) {
 		/* Reset need_fallback in case the same ctx is used for another transaction */

-- 
2.47.3

