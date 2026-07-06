Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B388C303CAE
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346387; cv=none; b=W3V1NZCEDcpIRZ/3Uw0q4Mxcz0217aVuDbL/ScgJja6X2LBtlgiqc9H7HEsINS34X6eACJo6mJDBr7fDqlQOUdnMnTaKVoLtlswHx/uXNY0FTkbeeNQI1k4RtlD2B2ayb66zPIDNGHBurL3h3N2h6wIeHISBqGHx6VWOOr27slo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346387; c=relaxed/simple;
	bh=awXQ/brJfB9B4O7BSeRN3xqg4Q8yglcr7LBVBZ0rKKk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQzE/qSGhUMzkUnDiFjVNg52NA++vxn0y3GwkLqU3p7D+M7gKIWbBmw2KALg6B5d9TMRY3Bl9IJFtPr1lWzGUYBIU3dp6PWwWWQkDzzWZhTJarauYm46rb3+77ugv2vY78nMdFm4MTASsS9xk3NEWsIjkqbKpZGwUGPuybW6kYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EWy8DPUV; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=B68VJSng; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EWy8DPUV";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="B68VJSng"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxHmd174776
	for <stable@vger.kernel.org>; Mon, 6 Jul 2026 13:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	WSPAKkfSBcG7L+ITRQk41ncN8ei+Eb7mybQoEJRwyog=; b=EWy8DPUVmPeZazej
	8UxWkOZoD3IZYB62rbTYIZ2WAKxhuHfZgsn+pvJ+64c1afzVVVZ3rTfpZ4iMdLi6
	M3ufR8LJeKr5W9ljNVYzOkQRfJ3s3Pu8I6zRiBbr6WxNtcQG32cGGYxGO9EUJIJ1
	iEwi2q+0wLwMJ1j/Z5IzEzHotDVYxRQN/btIBnnD2l94nVJ20oioNiMlA1d0nJQT
	vvp4Fz4mnRtc6Ufr3twJFwKUkbFhGAFHw6/ATrOoEo/qjIc0XoJrSoyelDjXdWXK
	qyWooHeGO4PLmaBLsf87SrSBKF9t2Jrtn5F7hW7iDMaDKgXNwoIPi/lmVYVsTLgb
	AZJkHA==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxsm2k-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 06 Jul 2026 13:59:45 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-495b8b30310so3516912b6e.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 06:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783346385; x=1783951185; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WSPAKkfSBcG7L+ITRQk41ncN8ei+Eb7mybQoEJRwyog=;
        b=B68VJSngPTGTUclBVv9aPWG3bv4uXOjr7PODQixETfVYVSZq9qaDgj+scW8A4GpacY
         2hZtc7s2G0E6vw7UkEZeqw2Ugd8HdAEgCt1lAH73YKAbKgW6ahGBK+7isBOqIBSERZvc
         xk/tfkDcfQLFSURs9BXa3+Vm4eDbBBPZL5yRjuEQDF7iN5KYZP9UL+1hELzACnAEKd3X
         ucohAGGxOHAJ9zIPvDdQ2UciRdp7hEdZk/chbPledAOy3IfexBlMJY5PmwX4nc5dvQN9
         0Kq4djSbi0V6ihiWshpqk+El04tAPdU1SdXMdlltZqHvKH/d4CpxGCKcAKUHB7jF9B3A
         IC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783346385; x=1783951185;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WSPAKkfSBcG7L+ITRQk41ncN8ei+Eb7mybQoEJRwyog=;
        b=n1mJTD28BYofOOLNI27j55jARR0YNXIhjYHNNz1hN+SiMMgE1f0zy9mVKqascZ2Q+f
         z5/sJm7QDVfHBL7NVk+utNlSlgeDao6XlLSagOIshaW11v8iBzUtD72oL2e+M5iIX6Xk
         DTvrr/nE+MOMBhce+xBrA/glB2Urie2g/fXAOZV37Wd1hUJCPU5ftcjTiNrEpKrZb6bS
         t3PeDZIeTCeZM0eeniXExpjlf1QItJ1XP+nA1AvpYW1bjHIOY3pVxB7RbClOO8QDj+GK
         Zv1cei1r+LNLn9Lp0Hn3ze1IA8I7Ct/R9jJmKueUPmha1Y3dmOaEJeJnL0t+YeBK9jEb
         z90A==
X-Forwarded-Encrypted: i=1; AFNElJ8qaMatysnxsUNiSAbt022AbtHV+X0l2LnyunTizKNvOCZ+t8hImeNZ+tauDfVLUlbmOHQsr6o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcgdoiD7eCMwEj2+8S8vnVR0Jeq9TRkwfktr0K/wCAhOFP550v
	IEbCbPxacenfTi8PcuMwuy4a3AEypJM+wHGQ9igl0KtCLMowSbA+YiyLvrj8CrFdrGyPZu5uYYW
	DxZcvTNk3g7O7XvctquS3LlNTFyr2xWOvXYHexjJFknqWV+Wqa+mXCO8EvFGrWiRNhFo=
X-Gm-Gg: AfdE7cl/GckGU6Zg/FwZPPwmPr4Lq4wrXeF7sAo3eQQJVqtOzen/5QfQoONpmsavFL1
	ztg+EsqoDtIahSLVWmz/tFWR/5QN/PoI0IsC2N3Pn4/dQBiSqp+4IE1LZCmly8hEtqbW0F6XjnE
	nvB0xmVEE4oU1vPJtOC1MDS9skYDYEo6XsOCSIfF/DOqAu8y+MepPbbVJA8cDVAF4Q6ddBubh7s
	4vHWKQUmqgKvKe8REb7X4jWuCpLpVQ9pM4BSJ+CupRXAhESy8WNju2BJ0ARyU1SoTmmoWEw/u3a
	vsvv55zz+jTWudYRVBPuqud/1JxQIWOCDwULzqocVR2nZ4sewxwIyalIwx/l3e9gTXIoJ7pn1u9
	Xslq8yP+OaV/GYEirvThsba+Xfjg7yh3+GluQVXSq
X-Received: by 2002:a05:6808:d4f:b0:489:6b4c:d779 with SMTP id 5614622812f47-49fde0e0d3amr364080b6e.20.1783346384922;
        Mon, 06 Jul 2026 06:59:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4542:b0:91c:ac0a:690b with SMTP id af79cd13be357-92ebb54cd97mr89390485a.17.1783346059650;
        Mon, 06 Jul 2026 06:54:19 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63ba971sm619805145e9.13.2026.07.06.06.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:54:19 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 15:53:56 +0200
Subject: [PATCH v5 5/7] crypto: qce - Fix xts-aes-qce for weak keys
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-qce-fix-self-tests-v5-5-86f461ff1829@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4133;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=mUG51visYbQ+wh2a+16DhppioDJ/WPq+z6OvDSGkWVw=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS7N+9xWGOvh8J6nnK2keRqxOiduOyABq0mfnf
 8snoBaHSxuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakuzfgAKCRAFnS7L/zaE
 w52HD/4rcLQieogmFpH0mB5/k22vmWi+cWveC2sn4J9RwSUWydqUfnN6lZ35u/p3xzhzxzzYf1p
 QjXT3R5e44oUW4ERo6UAzEAkM48LxMESeW2OxT1KBY43NO2nFA2nqnbeAotnSsYNzISLR7xRQx5
 GYuX5VihbOpP9NH7sc7+qSV33LQRu/FPEhKbVUnrHD5zDgToHZ4isD1DoWI3k+855LZ6uFpcauB
 XSgIEUq9SI6CC0undGv0eFXjorKSql+X/i/CQgeI91/IrojI2DNY7C7NzqxSw3ltEbAcYGFx2VL
 vh5Z6pWcYoyQl7h6IFfWvBZUxr/XMMJ8KJNNsk7UFPnz3H4z0Ih9CqcoC3VKaA3Hv15bbgsVM0+
 Eoq9XE102p7BO1LNLlWXVO5ut79AEqklvHNjNMBTu5RqPI6T+/V2nSGBqzeJkPgkMuFoFMyTfUl
 qDGLmIposhnFIIb+wMQKtJd3IkXlgdC+GTrr9gqclcHuA8/Vax5DyT57d8kA3XDWpA9RH70tZsf
 OtyQRhOnHe0LlEZwZkcUJaXHSzSeuPjzhpc2cu9dmcv7EpA2nSkRa3QyQhwKrczR3QOjlo5V91S
 qFRvec72HGQSHVNWGa16PEq1eKkrf0Wvy4SH80ffNc/+G56Rjdq1EFuoYKeSZ5q70caeIDehoHd
 z7qRXe2s9UX9kKQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: dZ67Q_kX_6QMzQwViAQ_BWMOVNmMu4MR
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4bb4d1 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=tpKvEUOkdOp8HkJiz7sA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MiBTYWx0ZWRfXze0tjR9eOfCq
 qqrUyACFAGGK/D65JufcyNarEfEw+c9MNcyEQbkSVafRkkp/YPFb6c1H/HkOlaXE3ah1Ymwxr/T
 tdni3kHCtqbABPQw9FC+Np08gXdunoU=
X-Proofpoint-GUID: dZ67Q_kX_6QMzQwViAQ_BWMOVNmMu4MR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MiBTYWx0ZWRfX71q3O/IbwUdE
 BIIPUg4Ss3LkENr5KBZG/DmQEcZzRPy18qbbjjp2C4W4aWiB6mgmor/eqEHZk8Pj/dDpoXIjek7
 EyZjRdwExCRi1cLbQ80yDNaWqfbi/m3sB+HpD+RrnOfr6W1Z0x6xUsSvU1EYNFvsmVhNgVJ0dwP
 5QD0xteHnrwXzhoQwnTSbYz/yGqzMOt058minZISAj+nrP7jh2c3Jpx6Gb5EKXJRlGIH7kSsUkD
 5LKeNPxv5qC1hTqA1BFilEoy1S7V3oMw7SJhokxbYXtmj7U58ZG3q3PDHRvLIfTu+IY/zcpoQCo
 ipmJepCnoPrex+MbEdSofkiyJpKM3ubZEpyLL9sm511o/TjPOEoUYa1WYDbSfZ7ecn/2+RMbJgK
 1vystiSU8FBn2FKcK+9Ebwf/USwusUcgOYPmLeTjiHqaKFdEjJobw/luY81aoQmW7F4OgYGrB2v
 EgLYc99Glfp3kF2ZEdQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060142

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
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
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
index 54ff013e24317cd4d7a0dcde88cef8268db784c9..6d5784760673074179eef47a1faadfab898a76f9 100644
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

