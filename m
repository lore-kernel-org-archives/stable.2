Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5569C54A7D2
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790081882; cv=none; b=V1Nm193U2FkMqProuxI5Xo1lfh/8siB+CpeBPAEIYZoijDyL2D9PZbrKcNkVpJ1V5eA891UarhVghYMW6/Zr+8R8ChEiGH65lmLOr2tCUosU6whq3+SggdJgBuBXZootCIm8mE4sVG83Ke8tKbWdtcj7eBPItRMB7c0Efv7qwOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790081882; c=relaxed/simple;
	bh=xpzz3JdgUksau+y+CL1E9ypCHi86QMcAsuNeCRSZCro=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UqiFNbHMAmuLaGfWE7TheyC+ObyNaEZ9rcL8pNzGlJMJp3Sp4hF3M2kvLbCtDNc6zg89M+92hRoOTqEKZxwxEr/jLR3x8QGk9w8RCIeJa2MbmVAtX4kKAj5y52kAr0tS493GxmbK60oND/P+wCC0KT5trRj4MFvlwYThDGTqz6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=A7S0LnbJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=AAkehvk2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="A7S0LnbJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AAkehvk2"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MBPYPL3487091
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:57:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MTwCsTzyd4T9CksymXrEcufF/ORaYOZ8beQnrYavCQg=; b=A7S0LnbJqrZQCsBd
	ebge7ty1+utj9ebWRFfDwhLsA5oUhxUo6wQQmNOrAXNvHoOM+MJj1QNC1CN7UTUZ
	9ylxigLOhYYw/mm9uB1jUwwqkj6XiaHkeiOlV+CY7KcE48mfK0e7MckYdf/rHt31
	6bzh5UwdlaEt62v8xEWsYBfd8K00j3pCDWTQdJC70RCIIEkjh/xbf0buWScFrIZi
	/M5lQGYFsB3TfihZma9JoS7koj7kSpkGb9K+g2frOkpvdQrWklWtFG5Uz0uARA1R
	1D3WDchwd+B50/vUoHgnPT3LAv2B83qXBx+V3j/B0Q49CL+hsu9ZnYsQwWJpQsmz
	F3MVrg==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gudw0jyex-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:57:59 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5c82fe2ba8aso5015980e0c.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 05:57:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790081879; x=1790686679; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MTwCsTzyd4T9CksymXrEcufF/ORaYOZ8beQnrYavCQg=;
        b=AAkehvk2Enxand96HQ7ejxsDQYAMMxn2t9eolz+C/jJlknAQrvTalWBMUw14Vw2fE7
         6+hhBWiZzPwbPzEx9rBCrvW67IgQuZXZ7FJWRyLahCfOdv+rsx4q60x4pF5oA4phmgZD
         l35pGJdcrtDRX0MOmJGjPvVQjqxS+JeidyTfMmUcZolRCSNQwsZwGkPmzy2ABDVCUQxp
         Q2sESOUoP/K+1mWZWEl3G0bV0PgFS30/QSEDyTBIpkWBGbKFxogKIRoJgYsad472SFDg
         qD+aS7RyHlDmhjU9/Wsux2mWlFM2GKsjlyjcGCAaJRCqEhmzeF9jP7BHBMHu5Df92P8p
         6+HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790081879; x=1790686679;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MTwCsTzyd4T9CksymXrEcufF/ORaYOZ8beQnrYavCQg=;
        b=C1BWouycSdh2RNhbKDMfAYYty+f3C8FrUGuBZSjgZ9hMWVOhm6mhzzGcGvd3v0NT/+
         xp8asje12CvLhnmbiXNp6mzGuKFpKXD5Zr+o98P1P2R/421WT/eS+ImRmv9Ji1eJWyBQ
         Y9Zmp7tPMnaeUk33SEOo9JVd4qtXGbbhpJawCEreh0ofHOKlOo52ya3Q3F4BdcHtjHlU
         gD2yQGDKUbgtFgh7aU1PhpQrs2OPpTJdhBMURMHgVPP1QdXf+0kB/Cf/e40zoqa+xcFi
         e2hAtJIdOM7V5KF1YL5BVG66EXBemKOAzaRBRQsARkLeqlfBiXR1EJ21w9AVKEafjX0f
         LiQw==
X-Forwarded-Encrypted: i=1; AKwUvByZYvYZrV2PkLmsoppMmk05/p1N9dHds4wYRL5QclF5Jhu7+d8RlaPB0XXkpnjKk26Kb0vjE+0=@vger.kernel.org
X-Gm-Message-State: AFuF++nA6fiCkZNxgBrKqGhBgiq+x/YyIOtVeCVfSUNCo+/MPz0XH0UN
	JNMVc8N8sg0S/Y22yC2TbtxrONksQ8oozCYMU3V8/Ie7ESHnaI93jKFR+u9KOvVMj6HxalAmqjS
	wlc/LzWIFFzcH6Aan5NmjPJGlpouzHr/K8JPlHQVVM19H2dHXpmg/VzutlxA=
X-Gm-Gg: AYBFou2esFpmz4fCcjui2YMVWXXQObYLia51JgnA3f8ssRTez9D3rTAd6JHofibeu42
	7TOLKYu/IiIO1qgnia/n124B0PtR5Iydp7ZtoLGROrv6sIWGlyojqzvIJ8sO62Mhp0hCUlkSvFT
	gz7XHFQy4QcsvOonN+HjwAzVPjAn2valoPZae87spKiijtRq/Sf03RLuwYSu3FF6/qlqHA0Wpti
	Jj1lpH3App0TCv49ns+MhcgMR/ruiiBHJf+/OI0s3ZqCQdPTMoDW6/qQjc18GrjxmAkLRHGKoeI
	Zi1ee/YKvCOsx5+XPO8IiyHpS+gMCcc9fdXxii7zmeBUoseSRXtbiJrPGyULV9wh8ML/wvLeeWN
	jUiCEAMD6q2UxQ6Hk3HhMcYINx7M=
X-Received: by 2002:a05:6122:3c46:b0:5c6:8480:35c8 with SMTP id 71dfb90a1353d-5c9b58e1207mr8032630e0c.8.1790081878537;
        Tue, 22 Sep 2026 05:57:58 -0700 (PDT)
X-Received: by 2002:a05:6122:3c46:b0:5c6:8480:35c8 with SMTP id 71dfb90a1353d-5c9b58e1207mr8032590e0c.8.1790081878172;
        Tue, 22 Sep 2026 05:57:58 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:5105:ff9:e148:c440])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaa4537b5dsm1097669a12.30.2026.09.22.05.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 05:57:57 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 14:57:21 +0200
Subject: [PATCH v9 06/14] crypto: qce - Fix xts-aes-qce for weak keys
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-qce-fix-self-tests-v9-6-b1aa742e79af@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4152;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=8CYB8IJJEyolqYr1f3j4TcjRobX2+UHINpIZrcnUD6c=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqsns79xTCzjsoUaCQdInS9yny4yM8oZvrB+7LM
 fs/mLigT52JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCarJ7OwAKCRAFnS7L/zaE
 w5kuD/9XpHCtabaTYp8HVBinHS02yg8pWr1tPG4/7/gST795uYvSOngLVmc8EsKahbAwXRb9mF6
 RApIGlZFZDVPLhOpGwj4nqe8nLdrp29W5Fh3n7ygCFXjYeVuJOwpwtNJYr4UbVHuftgPagk765d
 uTWq+ZClxIJ2+gY8aANEmgzqtZVMnFsEbbDJuHXefXRAtOG0ixzc4msDYJ3xuQn5GRcaZd/C+tF
 MuyTmPUE6/z9FC8iWAr3cqTxifBhc1tIi/IfBGbsB6jXF5pwvv8kkcSMgbP5WPd+39gtMZMW9w1
 G1f7Dj4PZFdj+bKwXuNDkb0YYr6MEFH5dI4RZjyS1x4d/q5g9yHrPlJQQNUjrajaPCDfLADrxxc
 m4yF2zxT2yFy6HBtvBk8hInZgewyjXkdagNZm6NHd1p+qMOrelQNkL6XL8+hM5AZV2G0xBCboH5
 28J793ob6srJf5joqKE7Xl40N5/DI0ncJJWwypEQ/8Pur3755KgQW3QZza56Z3mI4kXM8bx3P2x
 4AvzCAvPbJBUXZ8xLw28eOt8KbRU+lGeAkXELy3IPVzBr/npvp5l7v0fZCcNfEitnIUS4WaqPuc
 h+/ff1anc926PdK6GBejthayOX/zFMOOndZr9KxiGkxMO1sbvvCJ9Ap1GjBJ6ZwlWrvZz+/v4Dx
 KgW8pl+duP5WNdg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: Gy4PhyoC2PfO4jl2hLjthyxwNGU8TKDg
X-Proofpoint-GUID: Gy4PhyoC2PfO4jl2hLjthyxwNGU8TKDg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDE4NyBTYWx0ZWRfX8X+VfNA9P6ZH
 uCL8w5c35tI3a1VgE/eRSVPHiq9Ml9IBIgsB8bZ1PDl+dnzl/hjxHQ5/jdCm/SH67wNprUhmfMn
 3s9IB2p+iEK2dtyOHRJ0T4hUYyr/1fqvbqJz77bVfUbGDRsos3bpwS/NyfA/JZ6HLdQ32+s8jVz
 EXQb6Usd5iDSofCM+PlgyBPkrevd53hErOWxid8BvozjQjTbX4bbAdiKhptwIaUXkmA3aJC5Quu
 MscwHxVQE1YIFdpuB9YjC8ChGL4E9HcN/WCij9wuNR+r87sC2X4ys3ifbnp4DJiATLSEM35gDcF
 Y+bTX5LyWCUovdCegHQA1GCwI84+n2efGr6DhcKljf9XOiGjKRLmA7/mWWXoEO3914M4LaH0SsR
 BJq6eNGd6qTYBQpNwy0Tc3g4hAE/GwQCwpZ2UDWQ6GsVC4conPW2Mapr0E2SrZuOSMQ07Mw0WNO
 MVdO6jws0IVBbLno1gw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDE4NyBTYWx0ZWRfXzP4my1klCTe3
 onlPHmxZfD6WLP0DT0Lb3zFuwnqYdJ8Uz1QapJw/ToLC/u3eU13RDAZe+AufMLD0Y4lN4xQxn8c
 e63IFsFgTmwnOIAiKi/eOJUd2g06eaI=
X-Authority-Analysis: v=2.4 cv=TvFzFzXh c=1 sm=1 tr=0 ts=6ab27b57 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=tpKvEUOkdOp8HkJiz7sA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220187

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
 drivers/crypto/qce/skcipher.c | 18 ++++++++++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

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
index dcf2c6ebd588fc74c759820807b08000b274a501..7abc1d7b1cf0403c456f3b3ce1f28820839a5473 100644
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
@@ -261,6 +265,7 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	 * needed in all versions of CE)
 	 * AES-CTR with a partial final block (the CE stalls waiting for a full
 	 * block of input).
+	 * AES-XTS with key1 == key2 (not supported by the CE).
 	 * A payload fragmented across more than one scatterlist entry (the CE
 	 * stalls waiting for input in that case too).
 	 */
@@ -270,6 +275,7 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	    (IS_XTS(rctx->flags) && ((req->cryptlen <= aes_sw_max_len) ||
 	    (req->cryptlen > QCE_SECTOR_SIZE &&
 	    req->cryptlen % QCE_SECTOR_SIZE))) ||
+	    (IS_XTS(rctx->flags) && ctx->use_fallback) ||
 	    sg_nents_for_len(req->src, req->cryptlen) > 1 ||
 	    sg_nents_for_len(req->dst, req->cryptlen) > 1)) {
 		skcipher_request_set_tfm(&rctx->fallback_req, ctx->fallback);

-- 
2.47.3

