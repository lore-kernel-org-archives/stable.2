Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A30499F2D
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045327; cv=none; b=tQXh+4FHYk4mUOgja8NhCPuxp0X2/W32X031IbQDungIK3QzX3cKc00vXIOtKe9PzbIt2wmR7HcT4hjFk7zV9Ncy2cbPLQs0yl0OZuaoLLeLGzMkwLuFpV+lOW/bVXpxr/OyBfpccQDyfg8/ei+Aw9o4PZ5iaVl+7ihku6VRQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045327; c=relaxed/simple;
	bh=KW1xboFDIw7GUw5/K1L/QGR8hCZPAPAXS2iVODYVr6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fb8cmE4Gfl4nXmQc77cueJ/6Wr5nsqRQ1LXN4Z+sAbcTRb6QxOHXBfaYaoouBNrbv/OxrNDPaajU9UXUigWC5fpgt6qyefSXZ/W7TwV5fpOgPJuzi0N3JkpD5AHWJb+gDJURQKwl+l+DoZXmNDYrulVKk0/LQ4aw3HlQ2Nx6Ubc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PhSy16JG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ivqyK72h; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PhSy16JG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ivqyK72h"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AC7rFL1087169
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7EU+wkow0wdDIWrKXMXcNY/o+lSeS9qvjpj3PNv9N8s=; b=PhSy16JGud3aN7Ip
	AajNj3x+7TjwIXShzDgfhQFg/k2CkB/mpnV/gXBBxNPwU6i35orUQxTdOjbuqQYO
	w2kvHD+jsePLgSvADwNNRAenyh7SQxPCv5ghlsnuG3c+cDNWArWvPqiR3LExXItd
	5KAOkwYjjbQ6juGcQ/FmkVgJkdeYgD3WX5Y+/prmmgX5t3fNkFdE+ho8sax3dkIY
	x2YHFC+KIYzKuIyVLiroEluZN/20z8dtm9MGdVll8A4hZ1GAxena8bMcvMoTKK/t
	md7ZyLhd0BMrUfqqdUEQswhY+k/KchyKzgVk5J2OulkZgUC5UG7U5NcBGw/QaSdW
	cMRvPg==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyg3yxj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:02:03 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c7b0f8e40bso7496537e0c.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 06:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789045323; x=1789650123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7EU+wkow0wdDIWrKXMXcNY/o+lSeS9qvjpj3PNv9N8s=;
        b=ivqyK72hRUi2TL38yXbxFYyAt6M+0gqE1GTMJ9KcWCavNONmRkXaFoEbxrOWMxz3QP
         8TjvixPpT85hsl8O7dCGzemuMemNm0X4MrvvFjqkNby7s5Z2B9excy5+SpzrwT+mt0Sv
         TIokq5HqkIVBlD0ZIxdampfMm9u6lmTW0KSyJVvAMxExEUjBpPFBtC++qVNWAz+6tWo4
         ve0b17tMWHXpLmoshRKqboS/msVS1pFwDQ32aMKmhBRmJ2ReWJbgaGWG/KMmAzi7VN7x
         Wkr9iOddZUhxT3CNrhZ0oEkSHOqPGnKzwBz41Px8dpxP/fOMgkLR+hnRCnRG+wOMdJyH
         OjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789045323; x=1789650123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7EU+wkow0wdDIWrKXMXcNY/o+lSeS9qvjpj3PNv9N8s=;
        b=k5YleVGy/9l3Z1I2RQLJEkEJsaM8Ls+ii4j6bcMNYx7WjoCN7WgyXS5CiPQMFw5glj
         jBINQyue/M/CPfQ3j9Tiqbc8ln/YiNDIgiWzdFtyvnZMZaEA6zTwuj31EJbiBDh736UL
         wDNOVB0lbtTsldZko/kuVkvPGh86qsN5+hL92fJJO7uXmZgPhD84APbaEfKWEFN+FcEG
         lCNMJTt8ddeBOwcdYMyt27AuZ7jl9tib3DDe+u+4eDka//Qn8yP2cnq10UfXsmlIqhOv
         TP9WQon+s7HcPIB5yp0gc3MSh267BW4s52C+XTZoJz0wgQbcBzi5SLdWIEevwDue3TP8
         1SUg==
X-Forwarded-Encrypted: i=1; AKwUvBz7cx4K7iMsXc40qIO7TLnaY5Aa5xbMUvRPvFOsuy37vKtHEJbsOLiJHpHn1sYQEk/nsib4hoM=@vger.kernel.org
X-Gm-Message-State: AFuF++mUhOFkAOntIic+U1q/BaMVMLsQj7oGdm9HtlpImzIy0Lh66EUq
	GBVns5i86YFEIIVEvE+im4uxVuX5WSoMtUjwTLE09KFYbI/eGh8H/UoJuFJja5+tRwgVNlBioYj
	invMnmNEfenl4Rgn39P9YnUF/gZ8ZWsd44f/e6OOJne4TH6GSH1bD4CFBgZk=
X-Gm-Gg: AYBFou29aIIMgwIZg9ZxzvqU6+ctPZTROl0W0zZ1aRAzPrjgyFr2L3MjLKS5W8Theby
	qXL0L3lELxv//z/D5/CsQIwILdTebT7otYWZq+X3XDa638lGqWw/MTJcBWWK5Vv7wsX/sjmwu2s
	frprLZf2nh4kywXb2u3G9uCWB1SWnwxLpO9/8sIiOvI5UL9n5pqh02Nu7Lgrx2jVV070G7mtYlZ
	6YBtV2/KTXYpeOlvNpER048OklCtwweTN4ijO//584Huyu+Dgmg/bTCN688Z9m2oRZYSPBJeQHO
	9AFm8y8fz0ExzHxCqd4f6ftqzfo90bQlse7lq1ucFqeqT99/8Yq1BXx1SzvXONpvjKGvGp9qpFf
	1NOtjFnkEhzwpcHCV0NhiAzD0lwWV
X-Received: by 2002:a05:6122:881:b0:5c5:db2b:5baa with SMTP id 71dfb90a1353d-5c7ed7cba16mr23879176e0c.6.1789045295645;
        Thu, 10 Sep 2026 06:01:35 -0700 (PDT)
X-Received: by 2002:a05:6122:881:b0:5c5:db2b:5baa with SMTP id 71dfb90a1353d-5c7ed7cba16mr23876494e0c.6.1789045286926;
        Thu, 10 Sep 2026 06:01:26 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:c9b1:abfb:f300:5e98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c26204ecdbcsm831849866b.25.2026.09.10.06.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:01:26 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 15:00:47 +0200
Subject: [PATCH v7 06/12] crypto: qce - Fix xts-aes-qce for weak keys
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-qce-fix-self-tests-v7-6-cdbd2718af14@oss.qualcomm.com>
References: <20260910-qce-fix-self-tests-v7-0-cdbd2718af14@oss.qualcomm.com>
In-Reply-To: <20260910-qce-fix-self-tests-v7-0-cdbd2718af14@oss.qualcomm.com>
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4152;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=LHxn8qZQ7172JYTQczFIpOi+jAmwYv5eGxN5U2DeL2I=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqoqoPgcYYNiS9bUT7TKZOvXgiycY+xCV/pgRGj
 9yf2ltWAsKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaqKqDwAKCRAFnS7L/zaE
 w1sIEACsCiS++eDUogxIPE2LIXSNpcedycPtCM2m5ypQYo0berGKN7DnBkEt62W0a6zrMGKwx7w
 ifuQwMzYrEJHbkcA6siFI8kgNIn1ogCka5vvbHmLRmj7TCo4MGVaIJz2t7CE6rcBtH3lShR2mLQ
 EgD0VWSw0wEQcuAKBB8/MU28JXRDirKeIcuyqzmAt/Vv5JWnc0ETq9MwKs79e9VntK9D+XTgCCW
 Y0xNniIyWz2CC611h8tHPylhx2lNGJlMMhxZ/7sHQbqbgO9mXcUoWKnu180tse4Mv0HMXb+XkLJ
 c5+AK6dsKpMKMtSyL3cTjGiusL1HOzvpWdrDDOg4vQE3vX7wcgWffRjgTeJrTi8m3unLgVMYwA+
 HMB1urFNmPRWzzB4buwpHiPOyH1mpOBIa5aP5WXPI3YOUOOO2MiEeF2zM4x6Y1JCXs0v24VMkQU
 ao1dCjmNLy1ymqSwHt6Z+L38iGCQkoq5/3dbdRYA1jciT3jlfYcy7BGsv3iQqi7CXcqb0aFFxzj
 CO4F1om6lfNtEQ4WrLuOrxe4QKVbPC//oQwpHwnTfOLF5O8zrccrHxyY3AO3QuR9IQ60rwEN8Rx
 84UbgCqSTSNMy3/AQ7bFSz0poa6gU2aSqLEQRhg0zdu1DshnJIoCWUtNwTE90yKsA6POk5BqnSl
 QfT5+JYR3phTK9w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=Vu62kO2n c=1 sm=1 tr=0 ts=6aa2aa4b cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=tpKvEUOkdOp8HkJiz7sA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-GUID: xqkpSdsg4lOuAQjkF56gfL5VKuYN_fl3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE1NiBTYWx0ZWRfX9/vqRmBYDJvM
 QY91OfF6CI953kmneUH5vzkzekSZavjcuSf4Y8fm9wnBcSuHOY+BYwF+1eBxwjU+++7RX9SGoIk
 jeQF0DOdemmN6zd5wnSAQ2vyP67HWVSMUZyU3DWPb0ZyVm9570kEDrdFbx/Lh0EoJ8lUEiUMOAy
 OH32k5/1FnGliTGpvNyX6LTj+ct2nN12vYkRm3CYZLEmWQHE71y+VgXhPBtuPypw39/0O7PEXFR
 1ME04KgpkIVu8IcaZ5dG6Upt8w0WrKS42e1HYZzJTrnkcnRyn/7ufs46e4lLOMj+99UQPw0IaRZ
 OEbtPDfhwXCeyqmqUKz+kAJKlrC79d0Oms7YIi27XyEKPTh9cMlFgrfyTK8EaXQyUR/vIchDOQv
 Ce51PltRU5EF3ebQNHHJw7xdrjH1yyvN1cduwE6ODOih8Usplie2dsqgdYWeptPM/n8ZGkBgD2J
 PdJcrtYRS4OoZgP8jDQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE1NiBTYWx0ZWRfX7CDrIFzpmBGD
 4UTtl+fX5S3QtCsd8ceh5dAtHRLrCk67YKKp1HXnjfFMDzaIInuRnpuIPgDH2hn0cWAeFEL1y2Y
 gk9iQ7QgdGpHySn/s033yejyvCzLDp0=
X-Proofpoint-ORIG-GUID: xqkpSdsg4lOuAQjkF56gfL5VKuYN_fl3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 lowpriorityscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100156

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
index 4b7545e6aed220b7fb5af7dbf20ab47db5d1d180..35bd59656931c5f12614405490f1e254849b9eb5 100644
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

