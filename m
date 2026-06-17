Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86E84A33E8
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711426; cv=none; b=hhHBZKzbChukNRI775xjVE3a26u3JaBv6m3lz8KtDbrEj1UF/PNtJ9Xzvk51uR+gsGdbQL6pnaRss84yD1tuo6Ex98NZy5+R0914t/HCY1dKKBw0ZXUHvD4OkYGAXSW6QWL6m/kMUzr2U6P98LJZOckNN77DkKLreQw25JZOsz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711426; c=relaxed/simple;
	bh=2QD1at917VHfOQZ1FFL8/A7RYZ001LMVPGzvMxVSjrY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=toqqsgfYHVDzOyiah8R29LwN0GiGQUD5TSZ4xxTbWDRTu4VCJdbZwhVRrIVDLjlPtw2C8ekxG6PNr/YSGF53qLuIXpnAse+ZB74Lx4N8GnlLa9BOfFnvErYCWK3ja8/36GYhcc+2PzJmDKe543lJyRt0KG41OEfS6c+tbC1WUm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LTZ2r4Av; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TaUOiNkm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LTZ2r4Av";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TaUOiNkm"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HFPTYJ3157276
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:50:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0i/236+32Uviug69CXy7TUPGH2NTZVCBU7yo4A1KEOY=; b=LTZ2r4AvufypMFpk
	xZX6YZSfae+BjjucKLzygZCvSDO0/cg0KZEV1lFTn8W18eug7+peXZfLwnnBLn/B
	hhOLOCBhxvFEU7b17bh2ZCW2qvFptQLBifjq9H6eN8ZYvp022bW9MZNWTyRZlzuk
	tl4TswKAcND0fdQ/WU0d2Io3HUpSSoNJy8s62Hyri5vBZbUht/0uebyjV9K62f8o
	SXfWZ0e/l4YM0CEuN00io3EQW+iPmJZ0d607MuTvXZWZPFAlIgAO4hzrn/lAWBD+
	xyx90u3AOD2HRyeDkffZ8cM2v+X/PfA3GI/rNz8GUX4DXU3pfEuEj5NTjq6tdf1b
	zJx2Yw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueerc2uu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:50:06 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-9638fe9399dso2528883241.3
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 08:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781711406; x=1782316206; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0i/236+32Uviug69CXy7TUPGH2NTZVCBU7yo4A1KEOY=;
        b=TaUOiNkmkZtNDz4s/ddWsj9nxlQjhGyC+CxPCZ2ta+Lfoov3RMHsqmSOv7VuA/REaL
         dU1CfaMz8H3DrW3CMk/zgewjzlSk2/CXrs5JwbCMeJ3DTOX5souKC0f562Hv0zM5f091
         zeJpcEDP6Vv2hNPFzLI3HSpowIdE5QTq9U2ype+3RC742Yh9ehJE4kIagrZBOQe3OHB3
         xci2v5IQ+RAv6hNTurEVbc2zg3oQqqz4D+7j9PsZ/4YJiP/2TcIxCsOwxWzZTCCA0hrE
         le8BkshQN2nYs7jWEEzmI3QtK/s74+asjxhFRohnzyAxfPnxlLKcmpvNUdZ6aWGtNDrJ
         CEvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781711406; x=1782316206;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0i/236+32Uviug69CXy7TUPGH2NTZVCBU7yo4A1KEOY=;
        b=kX+wZL3BEAxia0fCWiKpsFK/y5QMheccFMUEOAF0AT32An4GcIY+HmrniBWcNzwmjM
         Xm9LiEEedMX8AnGDfD3UYB6sz694QMq/8ig/Iw0k5EmV2srKHMTF5oEsG78nyRhy4bD/
         CH9+zcJNf0yLnzBTOEaZYGCTqtza+h94lAr+sOb5AAzADXxBzMtSqrCevpbUorMpe0hQ
         RZPW7FCIsPHVDhjbNoGj69g+AH74DpRo+UeS8J802H+bXIzv3raBspddVC2vFlqjt914
         5ivonT/5OO0vd1X43DTrvRzqcazsEd/2E20k1RyPh1M6TQKLQIfPrGdrMVf2/Q138aNh
         ayOg==
X-Forwarded-Encrypted: i=1; AFNElJ9BlxikMUlXby7XH5crRXQh80r1hO8ocBdgo9ndj5aEpuo2xOk23A5aRUiksVIlANK8OHjERi4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkKoCVHgQ8BxP1bjNCXU3hoe9iWukWt6C1LqvgZ+unG6Z6TMut
	3+BNR8WNH7wQUarL2af8ko//ocCYnqw4jB25xF0vtb/JtkzZnkrdImsLBtO6iBZCjtDTkaKy4h9
	i481ZaSOq8u5yqPuqmwVM/uNjMVEuYao5lJ0eB9qsjqrQu2QWshkc9Tc2A38=
X-Gm-Gg: AfdE7clXHSLudDpwjzLJsXPSvwQbBkN+cDrqLhmR+DOpc0aW1vbX6qi93ac75nWWUXT
	D6kjZNQjbX3P72oNo1ZXZrh3lxUs9s3gR+Y6WQ50KG8M2KAcgfEU18U6cRA/zRXnREpuj8DQoiE
	u/y5W1R3TsnFSFJ6ybnKVcimttORFGxRqVKmMJVwcdxylTSxqjK2isCVvRcDZw4ggKOT+1t1g1L
	/jNtDNkXNUahVvqCKCUwz0S66qv5OEJodu70eAtpevJWJWEur4SAgzT4Iw+W3rGcqjnmFCMr51x
	aMi0VTF88Hw+1AYjZ2/cAXlbvfK9SQMztlOnt9eMzM/9FjDsOQTSX2nn+/q7GS58JCvQubyl8Bs
	+c9pJav86mw9njjULYH9oxMzVCg47WMscBux8YrEk
X-Received: by 2002:a05:6102:15a9:b0:633:3040:ca5d with SMTP id ada2fe7eead31-7245da81133mr2503885137.9.1781711405600;
        Wed, 17 Jun 2026 08:50:05 -0700 (PDT)
X-Received: by 2002:a05:6102:15a9:b0:633:3040:ca5d with SMTP id ada2fe7eead31-7245da81133mr2503851137.9.1781711405091;
        Wed, 17 Jun 2026 08:50:05 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:c856:25e5:e249:5e0f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa8b423sm168913195e9.11.2026.06.17.08.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:50:04 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 17:49:35 +0200
Subject: [PATCH v3 6/8] crypto: qce - Fix xts-aes-qce for weak keys
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-qce-fix-self-tests-v3-6-ecc2b4dedcfd@oss.qualcomm.com>
References: <20260617-qce-fix-self-tests-v3-0-ecc2b4dedcfd@oss.qualcomm.com>
In-Reply-To: <20260617-qce-fix-self-tests-v3-0-ecc2b4dedcfd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4074;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Z6ypwKanEzjNE5ILHL6Sr+FU2/1s8+CILGLtPtABFCM=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqMsIbgbJRyM1SL7/IRyPeLefrTlVeUZKYxcUpq
 T+60xv4kl6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCajLCGwAKCRAFnS7L/zaE
 w5iDD/4wFpsj7SRMnRJGvw2fPaGz4bGVZ64y2nkitN8T6RNjmoLN4XgGSklIpcGOKb1Ng349zDg
 CZ6PHTcap9Xqa5jBzsdrBQzd/TDWDUeWJJ+WbX768EF2f11oszyg8n/rfiff1jrdDluFmFA17Y9
 r2UzDtXL8nZietQyPkPF4WqRrgs5VtKFuqUTRlJyBL0RNAOADnWFU8HPhNdAQ2rFZub0mbItNGQ
 XmBEFvEYAyrXB7WZEFmqbMTd8ug5pHnyQRT/V83AUewlHSk3e0sm7ETdurprKIcHaij8hpniO+8
 uN+I16dNkFYFfEfDlkoP0BukQLRmhwU6LjYnlaiLzl+6mbiJUwpouAmioiGn7TYTtI01FerMLkU
 ozOP8wBzH42CzrMcVOF7DHxt8v4M14HtASQEseJ2uA3VHiuv70MbozR5enqTCYlb43p7+4k7YoS
 XoEkJ3P5QNfjycLXJ5wE0RACUgrxOs2Ys6oEg0Bo62SFxbChriUTg/YKx9T/82zRqnU3xtzsyIx
 E6gPwtIAHjlWDeDp7CzHqi+sdvPZwiQglG9CxxmlGdWTI1PJmponCcybu0ahZ/BuLeTiAd9+56K
 ekLf5ax0jr3taF4PhBGqjkZbxZX9AeqyGBuu6K3vBNIiev0Kx8RRDNH1e2FTCz8iPXQ0UBACycZ
 pkU+F1a4uNYHKhA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1MSBTYWx0ZWRfX2p6M6LfwiU7x
 oWCCEqrn6NhUZCVE86+Cdz4noCnZ6VoRoyLiHrsL0rDtB0CgOwvRfZ4cBqXFSDTPNzewn5rbR9z
 JGCsVWK1Cz2Qj2Ed/5taJN8aVHWR4Ag=
X-Proofpoint-GUID: k62EwfecBXqTAMuWT_-YsFZO-2sPTfPb
X-Authority-Analysis: v=2.4 cv=d4fFDxjE c=1 sm=1 tr=0 ts=6a32c22e cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=tpKvEUOkdOp8HkJiz7sA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1MSBTYWx0ZWRfXwaZI7fK3Vvw3
 DdHz9ChROokZGl4ybqYYJ5C3demUxwdE/CWnQJgms49Ts7QQhw8o3BqnvKo242FNBChYjYE4eJ/
 RpOlKsa8hcNUndFfpiOBGlrXVA8zrP9oXhZGV/Qp046cpyjsScKZYLutA5BHf+dQbCaRr5/Mvdi
 XjjER2jUbOxaDj4bLSnd6sBlqSCUZIFT/EPgh549iHpWV/Xv4S/uP/x6FI1R+OtLM6PaaHH885y
 IsHbNjApLbPD8vPCWphzsjVOAKlERfeFhLq1ynIxYo6qqjRYOsGeAdgHgpKynPE4pNqWomFvbM/
 uX9kM35CottOZwbuQh6neDTtuMeCgDidtUGVlle39RS2RwDPfmhRjzv+Fs2pVEK0BcVFD6ZZJcM
 piAv0kCtlJUWHsZokcS1DZzAjwPdIIB2K/ibsODWyzZoB0uz8ijCtMdsreghKXXE8JEUmTQUp/p
 iLwIC6jAVdVnCrjIvzg==
X-Proofpoint-ORIG-GUID: k62EwfecBXqTAMuWT_-YsFZO-2sPTfPb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606170151

From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

The QCE hardware does not support AES XTS mode when key1 and key2 are
equal. The driver was handling this by unconditionally rejecting the
keys with -ENOKEY(-126), regardless of whether FIPS mode is active or
the FORBID_WEAK_KEYS flag is set.
[    5.599170] alg: skcipher: xts-aes-qce setkey failed on test vector 0; expected_error=0, actual_error=-126, flags=0x1
[    5.599184] alg: self-tests for xts(aes) using xts-aes-qce failed (rc=-126)

In general for weak keys,
- If FIPS mode is active or FORBID_WEAK_KEYS is set: return -EINVAL.
- In non-FIPS mode, Accept the key and encrypt successfully.

Since QCE was returning -ENOKEY for non-FIPS mode whereas the
expectation is to encrypt content and return success, the selftest saw a
mismatch and failed.

There are two problems in QCE behavior:
  * -ENOKEY is returned instead of -EINVAL for the FIPS/weak-key
    rejection case.
  * key1 == key2 is rejected even in non-FIPS mode

Fix xts-aes-qce behavior by using generic helper xts_verify_key() to
reject keys early with -EINVAL for FIPS mode active(or FORBID_WEAK_KEYS
set). For non-FIPS mode, since QCE hardware cannot accept the keys, use
software fallback mechanism to encrypt the data.

Cc: stable@vger.kernel.org
Fixes: f0d078dd6c49 ("crypto: qce - Return unsupported if key1 and key 2 are same for AES XTS algorithm")
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/cipher.h   |  1 +
 drivers/crypto/qce/skcipher.c | 20 +++++++++++++-------
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/qce/cipher.h b/drivers/crypto/qce/cipher.h
index 850f257d00f3aca0397adc1f703aea690c754d60..daea07551118d444d2f749588bdfe2ae2c6c553f 100644
--- a/drivers/crypto/qce/cipher.h
+++ b/drivers/crypto/qce/cipher.h
@@ -14,6 +14,7 @@
 struct qce_cipher_ctx {
 	u8 enc_key[QCE_MAX_KEY_SIZE];
 	unsigned int enc_keylen;
+	bool use_fallback;
 	struct crypto_skcipher *fallback;
 };
 
diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 118a6878a76b1e86534f60e5d2058b99a689302e..9c1ce69adab8309737e15a50826505898340bcd9 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -12,6 +12,7 @@
 #include <linux/errno.h>
 #include <crypto/aes.h>
 #include <crypto/internal/skcipher.h>
+#include <crypto/xts.h>
 
 #include "cipher.h"
 
@@ -194,14 +195,17 @@ static int qce_skcipher_setkey(struct crypto_skcipher *ablk, const u8 *key,
 	if (!key || !keylen)
 		return -EINVAL;
 
-	/*
-	 * AES XTS key1 = key2 not supported by crypto engine.
-	 * Revisit to request a fallback cipher in this case.
-	 */
 	if (IS_XTS(flags)) {
+		ret = xts_verify_key(ablk, key, keylen);
+		if (ret)
+			return ret;
 		__keylen = keylen >> 1;
-		if (!memcmp(key, key + __keylen, __keylen))
-			return -ENOKEY;
+		/*
+		 * QCE does not support key1 == key2 for XTS.
+		 * Use fallback cipher in this case.
+		 */
+		ctx->use_fallback = !crypto_memneq(key, key + __keylen,
+						       __keylen);
 	} else {
 		__keylen = keylen;
 	}
@@ -262,13 +266,15 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	 * needed in all versions of CE)
 	 * AES-CTR with a partial final block (the CE stalls waiting for a full
 	 * block of input).
+	 * AES-XTS with key1 == key2 (not supported by the CE).
 	 */
 	if (IS_AES(rctx->flags) &&
 	    ((keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_256) ||
 	    (IS_CTR(rctx->flags) && !IS_ALIGNED(req->cryptlen, AES_BLOCK_SIZE)) ||
 	    (IS_XTS(rctx->flags) && ((req->cryptlen <= aes_sw_max_len) ||
 	    (req->cryptlen > QCE_SECTOR_SIZE &&
-	    req->cryptlen % QCE_SECTOR_SIZE))))) {
+	    req->cryptlen % QCE_SECTOR_SIZE))) ||
+	    (IS_XTS(rctx->flags) && ctx->use_fallback))) {
 		skcipher_request_set_tfm(&rctx->fallback_req, ctx->fallback);
 		skcipher_request_set_callback(&rctx->fallback_req,
 					      req->base.flags,

-- 
2.47.3

