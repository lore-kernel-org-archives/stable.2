Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907BD3B38A9
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134317; cv=none; b=KmU6gjTbXbF0ta61hLxZ/EwiNf1S8/gNFLgPyi+wnwE1p2GQ1HwRUYBG7E/ng2bnH5vuI4dlC105Vm9GxeDWQysZqlMo81F8six0oEz98dNBMNuqcs5LSmnCQFwSvyvjskgg4nZt8Bk6+Z4uiZzGpsO/Xtemm+/P+8Ia8A8l+5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134317; c=relaxed/simple;
	bh=9/13CghT8FUQYhvJkIMfRdaeEEFUpDm37ejb6o7zYGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CsyfDUjye2omBIKZ23ax2J8oSaQhatb+45qgfVDSpXX7/tW7A0WxYjLKnemwhAJfeMbNJatyxphViFJG1gZu6krz3ZJ9/LQ8USaVclXfs0q0PMdN4WTAvZTFj/Ce+ucwaJQK2yHPqkleXidXwzTXtS6Pk/vGeitZa7BGpQbzxms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=IPb+uo6G; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GfPrICT+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="IPb+uo6G";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GfPrICT+"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDGwDf1095423
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:18:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	fnoPkC2GxOfpsWV0NzbQHKvX8CiuSzxebCt7oRE9BIM=; b=IPb+uo6GI16w99hQ
	fHW2TrtLjKX/fVWztx57XD6gdstVZ7ZXWfBzJRquyCv/s+sdvUdSLu9vc//4v88p
	ouA1uPEwxL9dHLab7/b7ArzDV9n1efs92GUPGvH6RK/V9xPnzIelcDpodqzJ/d8H
	vtdsbM7+S6nvH7tYQbngXVyrdmYVebm5lvtRpecxMKMsPotpQuKHyr7QEEL7Wr4/
	M8Mc2uOXLB0/ijLRjBlEFf4cA02thJm8xlEtjAoQCSB1AALO05uJnNjfrQ+a9ex1
	l89jDr/LZPMSwOI8ckdXaEBvULADKV1l/bsirHC1H9IAnBJfdHAobo4gojBT8ZAN
	pDkzmQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewj6h6pek-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:18:34 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-72d089b28e8so1006443137.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 06:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782134314; x=1782739114; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fnoPkC2GxOfpsWV0NzbQHKvX8CiuSzxebCt7oRE9BIM=;
        b=GfPrICT+D40VMU2mN3vb26p4qryVU6QHN+byPTb+XSZMg/l/I2/nr9hjqWhbAa2pz9
         yFAv6YuVRmSpTiedfWxTYq8/nsYcPSvIZPO94pp0K7iHIZlPJbM/hj4y8lAQ+ZE5A67v
         IXuS3QUo1YscgpynZG0w8+Cd9Fe7ed8EJViyU1sSZZwk8IzvyrHPfr0wWBkg7tlCORW9
         z4NpwVl3STx48ysOzx1mCGBTX/VJLsezJQVIYxI1FUQt8H2IMDtNIkhdoaBMDBcJqWJl
         MtYUfh6SI7LWlGltYKMzOQncXIIPknm32emuooHVIHG7shDEZ2uoHKuNfp4NeB5G08JH
         x74A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782134314; x=1782739114;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fnoPkC2GxOfpsWV0NzbQHKvX8CiuSzxebCt7oRE9BIM=;
        b=UngoGNt4Fq2KxW6rdRQ3MG8AWRkck9SyECylT0eND6xfNwlODmrsKat3Jgijxyg8bH
         0cmVljFOHxx5aAL12Z6LPW4nRSA10fIG17qwzrlwQsOjqzTUpNS+4ArWwA5jUCFsqjIm
         H/f9wvefrmjU3Om8Gsiua/grW/PzwGebWGnnXPvrpulFuGjbc/Msj9SiryxR2uhrblZd
         vZb2yZ95yPwrgHVIGWzrTgg9DhbZ2KXUZj3FMwbCWzhXTYGDgn2uTUUHzXYmENZci/Jc
         S2vRW+oGYnR+jpFRQ8YuaCcWZheoYiVbeI+D1DXhzzEQK9uzw//Y46ehtE5EdkyL+Umh
         725w==
X-Forwarded-Encrypted: i=1; AFNElJ9Waga33BJRq2Fuph98QaVu1e1+sBhUlDlKrDX+ONIa+kSIIJtszWSXnCXemMKB6B0hatmTFOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAysHRv9j01SYmRF3qHb173atvBwVYGjarHO4f8PY51H3m0g/c
	pTQIn9E8n/Vfk3hiO+6+O2/Tze+WSyAb8d2W6RKnKHMPFLv2i1vzZ8w4VdaOtvX7p2dFBHJnllR
	tJIUENZmuhhoev6fdv5IsXiAmCMCmvo1iLJ8N/xWuaUvdzDHsGasQzXH6A5k=
X-Gm-Gg: AfdE7clmqq0shYhCsjC3rIUqeyf/a7f903UJxaFsxv5sEBIbmdfZZpiSo9JlLtOQVdh
	StVptFYzuKxAuu4EzKK7HscxlqoEvU5dgBza8+BL/kULDJZjGcX6t/EgbXfPkQEF3rWzseJbUPm
	DDQ34YdRczWN3QK6mLt5Ma06PC/l2s5vjsQrU8dpfns1mp+owIg2fZiqYX4gpqps9triTAhgglb
	PA5uVe6dQP1pWTxx3Rl1kK3IjP7VpWqZTC5Ylqabk0rraYoyqharNytdmD6L/KczQo8IWPu9mVk
	pNeP3HTGmc6oR7hiwa5IBXrsk0P4eztBXOqw/xDU/TsA/ugN8leeDCzI5yEr4RdUciJU163U7sV
	ueoYd+BjlaBE/gftCEW0mCdcLjsqz4ulKtPQ40KgF
X-Received: by 2002:a05:6102:1622:b0:728:4383:c831 with SMTP id ada2fe7eead31-72a1d634920mr6736248137.10.1782134313871;
        Mon, 22 Jun 2026 06:18:33 -0700 (PDT)
X-Received: by 2002:a05:6102:1622:b0:728:4383:c831 with SMTP id ada2fe7eead31-72a1d634920mr6736221137.10.1782134313271;
        Mon, 22 Jun 2026 06:18:33 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:dea2:c31b:2872:1bd1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd30078sm294083835e9.7.2026.06.22.06.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:18:32 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 15:18:10 +0200
Subject: [PATCH v4 2/8] crypto: qce - Fix HMAC self-test failures for empty
 messages
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-qce-fix-self-tests-v4-2-4f82ffa716c6@oss.qualcomm.com>
References: <20260622-qce-fix-self-tests-v4-0-4f82ffa716c6@oss.qualcomm.com>
In-Reply-To: <20260622-qce-fix-self-tests-v4-0-4f82ffa716c6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5679;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=9/13CghT8FUQYhvJkIMfRdaeEEFUpDm37ejb6o7zYGk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqOTYcrgYNNRo2vnWpL+O5zYRoZ21faltuUsACO
 K6MsYd8vyCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCajk2HAAKCRAFnS7L/zaE
 w5+GEACKCvApmJGwQG9zedV5phOxVMmVgoa4r0sqeSooXr1rmXObQTno+ME6/E4VMxUnz+FjR1L
 aO1qgcgOc56gd/i89/sJbiuSlB3InVdt76JOJKSFHdzoXPyXGStiH+9pr8jhbHX6j+i8KBl6GYB
 rT/Yi7zC3dsktyC5J5yiEIVUmF9Jrunqp585s0qFVYKgrBtTcf2fE/e7WySEBG4b9tH/+neInct
 FOO/0mutCjOOgZD+qNlTMKUFv1sYYBPxDLeg/1G7cACgtKFaHtKS3BEKg8euUg/pMIXw6/27mLv
 upXda56G5kWah5msrzm+MM8TV0RLFhx+cy8POaqgOaWcr+LYVioFQBW/PjBysEdxhr2Dc9W34b6
 wNcrVNcI7TAkl+Ttf0D1wgfccaY00D184OUHT3U94gVUWiLnRBOr5ok8G7PUSeGtpvbBqU88xj8
 oHpeEOmCHXGc5Ir8h8TX7jI/FYR0dZPwbxJhMAF1+E8UprA5x42yrKnUf3jtcaAb/GIJpNoW7X8
 L37K9rSlVM/rkFkhdK7QHczcRobGSifrL5UEhk0rBWTlCHQeuhP6MBXqhLIb/wE5pVmN6wPfSxp
 koTlcUVppexYE5xW5wO5U9keKDfmgrv6hzgqud+MapEbaqZy4I5VERUfqQ2VOqol8MdxQ0Pjq8x
 EyAYmps4rXdV8CQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDEzMSBTYWx0ZWRfX4fNZgLCvCiEm
 jfnLk5EGK16exp4O6aF0iYMz7bayn+KffjJqtDbkOnEiUbujCSqvf6BVtJvTnF8yNyxg8e8lXgC
 fRRp4iOQdSSQfXUfqe1gFRlks2lLWcvTz+OAdBbt43ioHV73Rx1SHnCrUtDfja2tqvJC+Ys+1JN
 FInxy72twW1CI4k0ewV9CWVtVe0eUk/dG5BwZNDxgjPghxweMpTqKjtghksN/+IXZFDS1c/yRLl
 8Damm3nffhX+/WPeue86YoN1nCAihbO9soLLbZps2JPY7wf/pZo2S/8m1U+P9ED1J3P7NOhHG2/
 sdGlc8mNMVGnLEPHZX1Y7dDoPyBN9mNR/7sSuJydIoGbZ2QRoH+x4LL1LN6x0iPy02L47+6ywmy
 1Lnx1LcxFgAiBScE7O6Fw6wADJMjWaxnHaHUC9p9rG9dYYRzMtmBY8snkt4xp2saBgNh/Lljeqy
 cMQ2IvKf3bGnUS5deZQ==
X-Proofpoint-ORIG-GUID: NJjVD3fvZr_bcWQ_TJzD_spAZLFk3Jsy
X-Authority-Analysis: v=2.4 cv=E7P9Y6dl c=1 sm=1 tr=0 ts=6a39362a cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=p9FZT9qupOX1he3wxJcA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDEzMSBTYWx0ZWRfX4brR2XgM6Yw8
 0lrpaod9f83yl/yerthcp3iUvQ1oqK7JNCdfGwpax+ihU3rAVb9lXl40XQ1eXRjoVb/jy5D3HxA
 rFcz6owK9QaYxWYckNXU0v2ayo7B64E=
X-Proofpoint-GUID: NJjVD3fvZr_bcWQ_TJzD_spAZLFk3Jsy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 impostorscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606220131

BAM DMA cannot process zero-length transfers. For plain hashes this is
handled by returning the precomputed hash of the empty message
(tmpl->hash_zero), but for keyed HMAC the result depends on the key and
cannot be a constant. As a result, hmac(sha256) produced an incorrect
digest for an empty message and the crypto self-tests failed.

Allocate a software fallback ahash for the HMAC transforms and use it to
compute the digest whenever the message is empty (in both the .final()
and .digest() paths). The fallback is allocated in a dedicated cra_init
for the HMAC algorithms and is excluded from matching the crypto engine's
own algorithm to avoid recursion. It is kept keyed in sync with the
hardware transform in .setkey().

Cc: stable@vger.kernel.org
Fixes: ec8f5d8f6f76 ("crypto: qce - Qualcomm crypto engine driver")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/sha.c | 84 +++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/crypto/qce/sha.h |  1 +
 2 files changed, 84 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index 0a3f88aaf5169ea7b47a549bbc10ea87d3ae7a2b..d4d0bf88dea6bf1c58ee103cdccbbbfc266110e1 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -270,6 +270,36 @@ static int qce_ahash_update(struct ahash_request *req)
 	return qce->async_req_enqueue(tmpl->qce, &req->base);
 }
 
+/*
+ * BAM DMA cannot handle zero-length transfers. For plain hashes the result of
+ * an empty message is a known constant (hash_zero), for keyed HMAC it depends
+ * on the key, so compute it with the software fallback.
+ */
+static int qce_ahash_hmac_zero(struct ahash_request *req)
+{
+	struct crypto_ahash *tfm = crypto_ahash_reqtfm(req);
+	struct qce_sha_ctx *ctx = crypto_tfm_ctx(crypto_ahash_tfm(tfm));
+	struct ahash_request *subreq;
+	struct crypto_wait wait;
+	struct scatterlist sg;
+	int ret;
+
+	subreq = ahash_request_alloc(ctx->fallback, GFP_ATOMIC);
+	if (!subreq)
+		return -ENOMEM;
+
+	crypto_init_wait(&wait);
+	ahash_request_set_callback(subreq, CRYPTO_TFM_REQ_MAY_BACKLOG,
+				   crypto_req_done, &wait);
+	sg_init_one(&sg, NULL, 0);
+	ahash_request_set_crypt(subreq, &sg, req->result, 0);
+
+	ret = crypto_wait_req(crypto_ahash_digest(subreq), &wait);
+
+	ahash_request_free(subreq);
+	return ret;
+}
+
 static int qce_ahash_final(struct ahash_request *req)
 {
 	struct qce_sha_reqctx *rctx = ahash_request_ctx_dma(req);
@@ -280,6 +310,8 @@ static int qce_ahash_final(struct ahash_request *req)
 		if (tmpl->hash_zero)
 			memcpy(req->result, tmpl->hash_zero,
 					tmpl->alg.ahash.halg.digestsize);
+		else if (IS_SHA_HMAC(rctx->flags))
+			return qce_ahash_hmac_zero(req);
 		return 0;
 	}
 
@@ -317,6 +349,8 @@ static int qce_ahash_digest(struct ahash_request *req)
 		if (tmpl->hash_zero)
 			memcpy(req->result, tmpl->hash_zero,
 					tmpl->alg.ahash.halg.digestsize);
+		else if (IS_SHA_HMAC(rctx->flags))
+			return qce_ahash_hmac_zero(req);
 		return 0;
 	}
 
@@ -340,6 +374,17 @@ static int qce_ahash_hmac_setkey(struct crypto_ahash *tfm, const u8 *key,
 	blocksize = crypto_tfm_alg_blocksize(crypto_ahash_tfm(tfm));
 	memset(ctx->authkey, 0, sizeof(ctx->authkey));
 
+	/*
+	 * Keep the software fallback keyed in sync - it is used for empty
+	 * messages, which the DMA engine cannot process.
+	 */
+	crypto_ahash_clear_flags(ctx->fallback, CRYPTO_TFM_REQ_MASK);
+	crypto_ahash_set_flags(ctx->fallback,
+			       crypto_ahash_get_flags(tfm) & CRYPTO_TFM_REQ_MASK);
+	ret = crypto_ahash_setkey(ctx->fallback, key, keylen);
+	if (ret)
+		return ret;
+
 	if (keylen <= blocksize) {
 		memcpy(ctx->authkey, key, keylen);
 		return 0;
@@ -395,6 +440,36 @@ static int qce_ahash_cra_init(struct crypto_tfm *tfm)
 	return 0;
 }
 
+static int qce_ahash_hmac_cra_init(struct crypto_tfm *tfm)
+{
+	struct qce_sha_ctx *ctx = crypto_tfm_ctx(tfm);
+	struct crypto_ahash *fallback;
+	int ret;
+
+	ret = qce_ahash_cra_init(tfm);
+	if (ret)
+		return ret;
+
+	/*
+	 * The fallback is used to compute HMACs of empty messages, which the
+	 * DMA engine cannot process.
+	 */
+	fallback = crypto_alloc_ahash(crypto_tfm_alg_name(tfm), 0,
+				      CRYPTO_ALG_NEED_FALLBACK);
+	if (IS_ERR(fallback))
+		return PTR_ERR(fallback);
+
+	ctx->fallback = fallback;
+	return 0;
+}
+
+static void qce_ahash_hmac_cra_exit(struct crypto_tfm *tfm)
+{
+	struct qce_sha_ctx *ctx = crypto_tfm_ctx(tfm);
+
+	crypto_free_ahash(ctx->fallback);
+}
+
 struct qce_ahash_def {
 	unsigned long flags;
 	const char *name;
@@ -462,7 +537,14 @@ static int qce_ahash_register_one(const struct qce_ahash_def *def,
 	base->cra_ctxsize = sizeof(struct qce_sha_ctx);
 	base->cra_alignmask = 0;
 	base->cra_module = THIS_MODULE;
-	base->cra_init = qce_ahash_cra_init;
+
+	if (IS_SHA_HMAC(def->flags)) {
+		base->cra_flags |= CRYPTO_ALG_NEED_FALLBACK;
+		base->cra_init = qce_ahash_hmac_cra_init;
+		base->cra_exit = qce_ahash_hmac_cra_exit;
+	} else {
+		base->cra_init = qce_ahash_cra_init;
+	}
 
 	strscpy(base->cra_name, def->name);
 	strscpy(base->cra_driver_name, def->drv_name);
diff --git a/drivers/crypto/qce/sha.h b/drivers/crypto/qce/sha.h
index cb822fc334dc187cf1c66e2a332822a596ebcef3..2fa173ff2b2ec4031710ab6e3b14c28b04e0a746 100644
--- a/drivers/crypto/qce/sha.h
+++ b/drivers/crypto/qce/sha.h
@@ -17,6 +17,7 @@
 
 struct qce_sha_ctx {
 	u8 authkey[QCE_SHA_MAX_BLOCKSIZE];
+	struct crypto_ahash *fallback;
 };
 
 /**

-- 
2.47.3

