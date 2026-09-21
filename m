Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D284249E123
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995535; cv=none; b=WjSwCC5YBSBY14rP0PVDzKQD/dwEgapSL/hjJsUHGM20kxtyQl3F6qSgNRjx8DlrjjFJxX5sWUf2XyOfNtWTk0NCvUXxGzANTG+Ui7kpENiz78GegpfQVT3h1a39E931XJObIUxbCjPDn1hUzqnoconaKY4IyqBXdm7hrNagV68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995535; c=relaxed/simple;
	bh=KW1xboFDIw7GUw5/K1L/QGR8hCZPAPAXS2iVODYVr6I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7bfZwMA5oX3scIpojj89+v/GMxJW5layB9m3u15NPxyZ5q7/uLwiyXjpohIb0W2UwKUvyQc5bdcCb+kmT2lmPlHC1y1JCHv98pzbjmH6LF7NH44rae0nC4SSakP5AlDMsCYDJwlmUKX1dHoGCv4j21UJqlEVZJ0TtpI7CLKag0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mvzE3FyQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Wqo66AvW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mvzE3FyQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Wqo66AvW"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAeKMU1414493
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7EU+wkow0wdDIWrKXMXcNY/o+lSeS9qvjpj3PNv9N8s=; b=mvzE3FyQb5phIviS
	Lttt/eiAx5l5oZ+zXOp2Iqdy+/8PP6bDNk0FkDQcQUzcFAX0s/5EdUlm6YpY/VHl
	seXXzQ6TNY9+aOih+z71Teu4mHHe7y88AkgW+HMLY7KDSNOsw032CWP3xIeMniUD
	FPISZPyVvzR2D2aCVvireHFrc2GuDW02sAZ+VJlgtBJ7AOTCqruupi7tOwnCUjbb
	k8PSaPdRY9xm77g2qUe6zI3y/GNg2EqyCVvbafgkxZ1I9mig7n4jOuKIjbiboPAC
	ae6iNokv591RAjmaHLoqQG6jGFJjmoNrSvjVTPweDzFLuj6U5mo55cDsl7SZRO3I
	QJ0Aag==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu01d1abt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93be1861d2dso450445085a.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 05:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789995531; x=1790600331; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7EU+wkow0wdDIWrKXMXcNY/o+lSeS9qvjpj3PNv9N8s=;
        b=Wqo66AvWoCwBxvsKnjP77iP4gc7DDxxMH6s+EFARecB+K0v57ieDuX1uJP2PxS8Oag
         EDgh5NX2ml28UtIZpQfb1y3yo9VX3LxrY5s4YOORIL33pkPKQGdQzjr1zopGt+9wpeTM
         qAGGD1KojqNUowxL4RupDaLAxYz5JTZ4knDGPF555KbpX+skgIKCqNRfjcT2HwaOE/LR
         GhO3MNDKx/wfIVVRjYtur8SieiXtMEPFCk24osCLTTU78hMWEBymrBLuScAJ3gUKb+Xa
         7qAAPYEcow0FhcXiCPAs05S4O9IGUUF3C99aXs33R5y4lhr3zdm+vg/CDJBCWKMlbjrE
         723A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789995531; x=1790600331;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7EU+wkow0wdDIWrKXMXcNY/o+lSeS9qvjpj3PNv9N8s=;
        b=PAo+SoUtuLttFQN4VkRlHw58SXla7Sb4+fiF00Ltzle1U0BaeOvm0m2gIfPrC8Fxwy
         2GpbSuGyuxA/BMF7cSfI+3lrWhm1wn7ZtZUR1VVBDGW8OjribQXOa4bkk1XmGFTDK8ON
         qLzc8iahTgdw3mR2/1rTGPyBo49wSM6pCos74Q1xHw3QetvKssjLBBQxCu5DnM6XEpO+
         LsGqo92zDxbk5Ila2aCnb/oL3abo0WBdQNNqRrhrqYySNyR9Y9btehlqLaRFPNYyfU6U
         ZuvYj6p+oF4w9MF7qrx58BPC+T0GsDfPSzgfsj/4BPUTdqCu+ugmdIynqlRhreg2vAvJ
         EKFQ==
X-Forwarded-Encrypted: i=1; AKwUvBxZcWg0DVOhpLPN+g0UxH717Hmj1xv1qKj/FPmAPZ7rMr0D9HRUJ8QfvzgVRL5KkLdWEAU/oL8=@vger.kernel.org
X-Gm-Message-State: AFuF++lqrNCQ3CEvqj8c8t6lmhyurPB+P7aS9eCQV8jNheG3+/5qG9km
	4QyDPHx1I+n7QxMUzkCqSktJ1BHfGLIyu0yaNsdmIzF+wlVBj3zou+cGs49BxHbI5XuTiZskKUj
	EHysCXDrpjDXZSHnarUI5LfPP+tI07xJoUj4Ob42P20nEJuexvjwyD2KuFJw=
X-Gm-Gg: AYBFou1JteomeJy2LW7V3UCM/y5qzvHLgSrj7+qhiJZ9xyehyMkjfRPwLM9a3BT3N0U
	dteZ0yJQ12W1M2XdRG8cUdme/HDTj8hgabHOKcHcCta3tH9IrkYuos9N1R9EfoRrcDRiBl30Xip
	oTCc0ACwWmHLgWhaZTEDNvwCvbYHYoXt+hhpkqvovfTTu6giYRmZ7kB/ncdRxSIqP8iCRJ6thYz
	A0NRtTj1sJF54hIN4oR7PJskZ2OeNsKWEkWL8lVdEfZLwsbwjw7K+lBnhc4KgC4UinUlyYdocu6
	0qW3g5iUnlujnWB0aZS/i2W4qKfENCID6z341ESrNjRTao0si91woowBkiyCc8sOnTopXNMNrVR
	91Wf+TmfxJbjsJXQGtcJelK+aZ90=
X-Received: by 2002:a05:620a:2b8a:b0:939:feee:630 with SMTP id af79cd13be357-93c15da20ebmr47385185a.30.1789995531168;
        Mon, 21 Sep 2026 05:58:51 -0700 (PDT)
X-Received: by 2002:a05:620a:2b8a:b0:939:feee:630 with SMTP id af79cd13be357-93c15da20ebmr47380985a.30.1789995530752;
        Mon, 21 Sep 2026 05:58:50 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:d04:d483:faad:1e4e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a359037aasm320278766b.63.2026.09.21.05.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:58:49 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:58:15 +0200
Subject: [PATCH v8 06/14] crypto: qce - Fix xts-aes-qce for weak keys
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-qce-fix-self-tests-v8-6-107537869a72@oss.qualcomm.com>
References: <20260921-qce-fix-self-tests-v8-0-107537869a72@oss.qualcomm.com>
In-Reply-To: <20260921-qce-fix-self-tests-v8-0-107537869a72@oss.qualcomm.com>
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
 bh=LHxn8qZQ7172JYTQczFIpOi+jAmwYv5eGxN5U2DeL2I=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqsSnusXJ6mTA2dg++3IzzyqwVSxIsPDRSVAq4i
 1m3jU1alFKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCarEp7gAKCRAFnS7L/zaE
 w1aID/9ZmjDlAMsP0M5cpuf554DLhUGaE4Lowr2sd3k7pPhqfNfXWruy8SC1J6hISelxpyn6o1M
 taFwiXJ8fuSwuG+nO6Ft9ZCTltVrsLdCz0Sl8bgO3oXvqGFDJ620hBdlNLFckAGsJ/mRDHG2VKM
 9w5UpUVpehVIQx9K1ra+QBioFXjpk85MiOLHe/mHQbNGMn+PFc67dvJESO2CbyY0MIKydcawIrx
 sPz1Jv8/RW5tKQPxAH/Ij3I/NnG1d1Q5IgYxMP2FqMnTDejyLO9wyBPqpi0F76X7hPfaKUwbuqL
 YG2x3dVKOzgWBb08lI2zfcqya4BwYoMFlU1f5eeqzIKttRmNmqr2xFN4/Lx4np5hbeOZfG+waow
 tenwoWzlXp8DlclrFNn87Dec6O6/+FZ/opUhzulx61KoYGWRXPwnk+oU/QupOflQVu5b8vYWl8M
 yoia0TGCwKhbsbrenvXSIU5u7kA8A16aTqLqHVZbiip/X40P8/b4/zbth4cXFm5exYGVkD9GfST
 1FQUbtZ+noH2ykXe5aCkkoahNXxsVmvXz65eTNLOt+q/eNLAu8eAdntWYnKOaeD4M76jaVF/ekw
 rbypKAoQ7vRPz3soFJGlZSAlhTvK1xIIfh1ERCqsJJCylpShh7+08MWQpaCh5HNYq5/BAu9SaUW
 CJqgrqYKAc+D18g==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: wMmjPDo0ptTr51U52T5vWl3NwWQ67kTb
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4NyBTYWx0ZWRfX6DALUToyNDGy
 UvZTIKQ6kh2ckizlEw68yQhN7lktPDNnqjstYd5P/Z4fuVrwuTZqe/P6S3LBL4135wzPEXvDZXe
 +Ps5LbiEAEkq/28KGKBv92sgTog5pP8=
X-Proofpoint-GUID: wMmjPDo0ptTr51U52T5vWl3NwWQ67kTb
X-Authority-Analysis: v=2.4 cv=Ht7jiETS c=1 sm=1 tr=0 ts=6ab12a0b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=tpKvEUOkdOp8HkJiz7sA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4NyBTYWx0ZWRfX6wfmCAi8Iiaj
 O1ehfB/jtwgTT778CalVNZWD++Zmmyv11zZ4UMqKMWsz6LfsqWkSFnAEaWd/F6MOQjhvAd2lmMQ
 mQusGB+VmHTz5bPoUEz2IazxBLqn72UP3aIfNhQUOExgA1xvKptL+pOEPg0+E6RQ7EeluNJroIh
 +tkUNWzUAOpEhNxq08zcmp+bSn6suXiJE3KRwxd2rEgPND2ugRzDa3hCvHI5rFoBW7NzcboUveO
 cNCbSHX710JchUW4koHzR8KHmrXq3HWgq7pHKYYudN7GwQYHCUY48RF62yvKC/Alhs8Y2sFcK2Q
 4Hc+IMUV/K9F3V3onX3KqQ2a3EeyE7uJ54pEkRPkDozHgALqMRxT5dCyQ25Z5wQ2QF3b0n80zCr
 HCpuLKQXo8p2I6mYBnAoMS7aoeMkQLNSw1oO1brhk2t7EFxF94GAMwq2Dbyj+CUUwfVelfUAkpN
 yo0jQQrMepz+gn3+Jow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 adultscore=0 impostorscore=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609210187

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

