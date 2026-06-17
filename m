Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B424A2E39
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711420; cv=none; b=FD2QWhQn/eDNPI1T0FDIV0pnjDH+/z4O8YuCiibUX9r4Ch5GqM8VX+ImdTehKeKjtDXBTOxc9nJfG6+Xiyj3dGGhPvULUDAfK/EGhtAh1Pev2az/dunuXeiRzhYmj55Gr7eLpCbZZokODS3JgHSA7FgxYsb1xhGUptEAyDsu9Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711420; c=relaxed/simple;
	bh=YiYddfFRcomI7t8tYpClLcoAljSpal/h2mq4K2cDM5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WwUgvCH0jRsJ6QoEyR80xV7eUjnEUCf6Jr006FCv83TuyqQxnrvuNW1NMKCdAjqWWguo2h/G24jMgRo9IXgMxJxwcaZBGISkC8f15ixC6u9l308eOFevzxu7pHaLKO7UCneqWZfRIHYA4UhcLCApkMgLwVNu59T/lONM/VdUphM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AebN8p87; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LfLsM8uE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AebN8p87";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LfLsM8uE"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HFPm343126491
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:50:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3rQd7KVwEFxeS6KtLGp+38aVdnF8Lr3UIX8ph6skqaM=; b=AebN8p87qUOC8F+D
	jArpuVFZ0zGpMEjcDAoOaBNH2MTJd8pRzY9RvrxqDnkyUDUBzkcxV9+pXEKO1rju
	CRAIB49Wk5Ffb8LL5jQTiF0RqXCP9xoMQY452b9+yD6TAM7BLj/flMfrAbdLfIT1
	RsMQr749w/4dpe52HdsclWWk5ZBuB1PiiAc8+3JeXcWwq041YDSSE/PvVS+1SBwL
	Qj9yjOG7Bb8kT3ckodxvfhvphn8XRCXpdySbEBpbwpL6cKWt8QKx2q7DP4FsDYj/
	tyRkDP1UdpIulpicnJHeZZkh3dv47SgzqefKRux3vm9llHsRtg0Nj79o9oj+Mrxu
	G6Gnjg==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com [209.85.217.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueesm2nu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:50:02 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id ada2fe7eead31-726ff8540e6so232161137.3
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 08:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781711402; x=1782316202; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rQd7KVwEFxeS6KtLGp+38aVdnF8Lr3UIX8ph6skqaM=;
        b=LfLsM8uE1391Finj0wCvttj5zBXwO+3WJiMK3OgmQYlZ7a5/fa+O+SEXhdxOWZFN5Z
         +jZav3adOdj7NS022HKufcuAMgTzwY6qmPCptDeHot/FNyV31wbNxEwN6fUbXKP2Q6ZA
         tsP2VW/5+x9NYyZx9f47GRpHQo93QxYUkt9qJWasKlGLUW3x7b7lDDxXfbiD4eViGkIQ
         T8Bd7v2w1Y9VKgJn23KJ2+naLRASOJIZa4KiJ3s9qja3mhiGvO20FTEnc+80J8DGlPxy
         3n2PevZ9Eg7rIRjM/MubXMIC/dVxCFyVCd0PcLRgA9iaMT26fPopZ0qV0rQNiTQyO0VX
         lWng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781711402; x=1782316202;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3rQd7KVwEFxeS6KtLGp+38aVdnF8Lr3UIX8ph6skqaM=;
        b=IlQzBxZI5KFyNOYeMa7UGnYsdJzNZNsZX1cgGqZb77viurPhGDjj/9pIzeTsbLtbEM
         w4gWs2hgjZuljXJ2UkQG0OJSQZedDX9F3GCoFsh6WEwYE6s3MzSQNqyPmNly5DNAd2D7
         jENTXdd2P5BcA/+0DFHkUSPpOnJMIoW4hpzAPc5Njpe5FSFaMEiCBf5e5oN6BDfzbbW8
         T8eeoYY9KDMyXh1zVn1KngS/2jUVsxVrrO/TW/5JdXwDHbfIpYJXiVFsjl8V8VWZSF5o
         itq77TIewWLNOwbXpnbnjjLPyUsZCHpB/Me97h5/tLuNtsBupUeVcTci2AP4wezBAWYV
         CixA==
X-Forwarded-Encrypted: i=1; AFNElJ/AJCKhJKxj6e8S2F4Raer4rvalXDsK0Iptq42Cg/a5FepdVMNUKpj/qrBEn7pxlyHPM8zPG2g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy236ToxAKKoIR5ERVSW3l1VdWJbLmEhDgA4ZOcLfL99Dd7A6CO
	lyFt1ceaYUTLEbCtGM7Ry8UPLcgROlqdi/RsOEYu3zJw/3kc1zRY3hNWvXdFREXIDh/dFe6mCHv
	TydNcsagqIKexVwQYTM7IsfZjYeTY9LuP1HzTxL6eBC2//JoV2cVkq2YK9Ac=
X-Gm-Gg: AfdE7cmd7wUK4CvrIHOoHuZKFlHOqDnlAimnf1zYG/vnr2hMSbHWqgzNtuy0Hc8yH7Q
	L1ql9UTeETA2Owp+RBRAAr7zb7YZIgb9gBtUe0uOEAQS8BPafod1FGkPrnM1oSXZexoxA76k9t4
	EjGTkF7h7TEFcO8T6iBjq097JPP4AdmKr9JdP7OXjOQ0XO1Wh1Bd/ol/uAHQVIxcmmVsopI7XNI
	WAaGx6VHi2sQEXTI6QyOIAaMQaitKh52/kzy45rIhJ2iERUaIVo5ZpHIxZtlFslDj2j/G78HIdx
	iI/7mxv6ngcWRqiLlvp+COYO5Vou8nIArRUaZ52sk2bT4kVDZTvg7zcl8DyVaLZWxutcuD4sJcK
	8ycWQg/Ll7BN3FMeu9wjuDgpe1y8UnnKPkoC3Nng0
X-Received: by 2002:a05:6102:4485:b0:608:94e3:bd89 with SMTP id ada2fe7eead31-727c4a9785amr23048137.1.1781711401575;
        Wed, 17 Jun 2026 08:50:01 -0700 (PDT)
X-Received: by 2002:a05:6102:4485:b0:608:94e3:bd89 with SMTP id ada2fe7eead31-727c4a9785amr22994137.1.1781711401046;
        Wed, 17 Jun 2026 08:50:01 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:c856:25e5:e249:5e0f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa8b423sm168913195e9.11.2026.06.17.08.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:49:59 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 17:49:33 +0200
Subject: [PATCH v3 4/8] crypto: qce - Fix CTR-AES for partial block
 requests
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-qce-fix-self-tests-v3-4-ecc2b4dedcfd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3240;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=9aUehWqDrOE94Ytvg0cUqYrxCF3sTZEZbyMZOkshb98=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqMsIZWaFdop4gRxQxjV4jFV8mK3CxAmVawDFqX
 Re0lyNxSfuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCajLCGQAKCRAFnS7L/zaE
 w86FD/4g6WxEvyQ0RMQbkAhrhnloiyeEsJij47lNWZwmM2S1TB/eQLGWcF50H8gTvAkisHiG+kw
 3+K/hO+KDhnncidlJpnQcNTS0ZuTSk0WPA1mFkGm4HMQrjBY4aWGHK8BZeRZP/mxIYQe1zTJrvY
 iW3DhBmdQBu2sc81VwYPhiW+R3YkLRgpWtNz5W+g8U2deg7Se22MDbZ6gBk85R6mjVz0N1kqhvN
 aAfIGmkuxGcAeCW+YdHNK373eE4GHL9Sl39KjR9z/6FN0t7R3SO+oc8jo1g+m5Y4QTyqM95+2FJ
 6BYRY5ZoHfmc3+k8+LP1js39DIh7foLQm6KrSlsaK2fcK9gtWWpePDwA2ba25ubJdiNsAPbN/g5
 5P5GoMs7sZdhSuZ1JsSgHw0nPke0ZEh+flwVguj/jFyEpq1C8yKVtyK5J3yjhFY/GYTa3AoD9o+
 st1nCphI1z7J4GMu7Xr0KcdsjF7UbxDOwWhfYhqR+py/djEfLNPlg7AKriRHy7ChCEYw6Vy5mpI
 5BvFNWgFSgA/O/Va6c0EgROa5jgT+HRuqK0xVAR9trdKwRDNVmR63nUHQJKz7DBkLGGBZ+56/7E
 f9AXt7eY6TYR+/TLubVlhlndfGlDSRMcdjsEc9/9wNuVgikq4cMS+TsDsfDF5xmAbBfpKYLkjfU
 KqjVUkdaQHoD0IQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1MSBTYWx0ZWRfXy3pYCsOEacJr
 PnAa6ULKni208XDrDajxz2LZGACl6Lg74zF2we2F/scxrn7ezxgIgPVMJfs1YAMZi7wDQFzG++h
 2IdgoWVqeKUN2kP1Thn+JNXjlf1ROy7idq6ySMgggDxFRXtEVe/635+rU01DwYt7PyUJVrpu4Zo
 ALmwwnvIXqXR4V0r4llylzDMZsGs0grQECJGmy+xs/r7oM0KNXNaQgqOAisUmokEdE+1o49hfOG
 6y88qQR5PNjxi5we0lDy8hZOxKR4GHU4QmxFoG/CL7GuppGn6z2vcl9v8hqk8mrjgcJHF+A/g9i
 hqrr8k9H+Yz7kXMVcx8e/Ttn5CN+O1UTKKwWh+ZYx+w/5lheTY71ew9r1gh/Lnf25P5357X6i9o
 F+xcQmn33A2PKH9skyPrXoGqZTrIJ5oazgxIfnubyEN5uHcc2vWx/NO3r7HpIUEgGGKatrifOI1
 83NaAZ1dSVjenThxbIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1MSBTYWx0ZWRfX6maZoFFBUDl3
 JoomnDBXX/Lw/EhK/bHHTHF1takFJm5niAUHXc0z31QcofjAVHy1BIPOlOnBfTU2ro4008nbU+3
 XxddcZPsB1k/ubuUnBi6MohyGRSCPrc=
X-Proofpoint-ORIG-GUID: i35oXEPolu9f7nvghZqh46pYPZi0r3jn
X-Proofpoint-GUID: i35oXEPolu9f7nvghZqh46pYPZi0r3jn
X-Authority-Analysis: v=2.4 cv=ePojSnp1 c=1 sm=1 tr=0 ts=6a32c22a cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=Y2NcAOke46LZopEJyX0A:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170151

From: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>

In CTR mode, the IV acts as the initial counter block.
APer NIST SP 800-38A, after a CTR mode operation the next unused counter
value is:

IV_next = IV_in + ceil(cryptlen / AES_BLOCK_SIZE)

The skcipher requires req->iv to hold this updated counter on
completion, ensuring chained requests produce correct results.

Referring to Crypto6.0 documentation, Section 2.2.5 says:
"The count value increments automatically once per block of data (in
AES, a block is 16 bytes) based on the value in the
CRYPTO_ENCR_CNTR_MASK registers."

QCE increments internal counter register once per full 16-byte block(for
ctr-aes) is processed. In case of partial request length, the hardware
uses the current counter to generate keystreams but does not increment
the counter register afterwards. So the counter value written in
CRYPTO_ENCR_CNTRn_IVn later once read by software is one less than the
expected value.

Crypto selftest framework capture this scenario with test vector
4 comprising of a 499-byte payload (31 full blocks + 3 partial bytes).
Error:
[    5.606169] alg: skcipher: ctr-aes-qce encryption test failed (wrong output IV) on test vector 4, cfg="in-place (one sglist)"
[    5.606176] 00000000: e7 82 1d b8 53 11 ac 47 e2 7d 18 d6 71 0c a7 61
[    5.606192] alg: self-tests for ctr(aes) using ctr-aes-qce failed (rc=-22)
Expected iv_out: 0x62 (iv_in + 32)
Obtained iv_out: 0x61 (iv_in + 31, partial block not counted)

To fix this, just increase the counter value for partial block requests
by 1 and for the full block size requests, don't take any action as
expected value is already returned by the hardware.

Cc: stable@vger.kernel.org
Fixes: 3e806a12d10a ("crypto: qce - update the skcipher IV")
Signed-off-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/skcipher.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 459c9ba6d0a5363da9f6ac8c69b6d3c1a4633f91..ace64a651f56ff478bb4966d74c9e762ade37ba3 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -33,6 +33,7 @@ static void qce_skcipher_done(void *data)
 	struct qce_device *qce = tmpl->qce;
 	struct qce_result_dump *result_buf = qce->dma.result_buf;
 	enum dma_data_direction dir_src, dir_dst;
+	unsigned int blocks;
 	u32 status;
 	int error;
 	bool diff_dst;
@@ -56,7 +57,21 @@ static void qce_skcipher_done(void *data)
 	if (error < 0)
 		dev_dbg(qce->dev, "skcipher operation error (%x)\n", status);
 
-	memcpy(rctx->iv, result_buf->encr_cntr_iv, rctx->ivsize);
+	if (IS_CTR(rctx->flags)) {
+		/*
+		 * QCE hardware does not increment the counter for a partial
+		 * final block. Increment it in software so that iv_out
+		 * reflects the correct next counter value expected by the CTR
+		 * mode.
+		 */
+		blocks = DIV_ROUND_UP(rctx->cryptlen, AES_BLOCK_SIZE);
+
+		while (blocks--)
+			crypto_inc(rctx->iv, rctx->ivsize);
+	} else {
+		memcpy(rctx->iv, result_buf->encr_cntr_iv, rctx->ivsize);
+	}
+
 	qce->async_req_done(tmpl->qce, error);
 }
 

-- 
2.47.3

