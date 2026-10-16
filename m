Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E174AF66B
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 14:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792159925; cv=none; b=ZVGTltQQBKD0eqt2fcwGFqNi2ZdFAfmpIPfz5duWK4iIBCd7YMQQ5JjpfFxnT38AVlv5MHOGmbhOUw7z7kFpY9jVjTK/AxBaWm+aitNijsLDeK4TgNvLJzC+7Khzth/pQN29CuxfHidI+UdBWCCIj6aI3xTgxVQFqP+sJlDJZKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792159925; c=relaxed/simple;
	bh=10czG1yn2EOwOEpiuflfvi91l4e59NVnoKNaveNpS5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HD+ES1+rUu90KjcPfJ78i+GdHoFbV4jaUHkOM/uzF981jS8DFvp315VN94tf1pohrPXfDLzhKUF7Q4FNyKLxGolx9fFUZawOO/M5efpRwLxKaVnUPUH71HjJd0HFMe3X2R9i3p8gVMBHcRxJ9v6R1Dxzc0Gr8Xa9K45uGaqPzis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=miUr+MOe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VkwCa8va; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="miUr+MOe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VkwCa8va"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GE65Dw2302180
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 14:11:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	83Mt4HXkNxMhXoNbNZY+WQIFtNOuy89fZ73gqiGaArw=; b=miUr+MOeGDxLNRZo
	bSVEEIlH/j5o0h9OA//yltaV65RoGo0wgv00sUuJEyGXCEJ/zbtHTa8qf+K8nWxT
	oqNuOuAOBpFlsH6ZsFGeUU/M3/a3wNSLCxQT6jDRPB653OkBBr2kLB9leWFGLQah
	38hDVe+SHEB2PWuGSusBumTXxqr/1A2zu9mAL6nXhVCEWHZkpi3KH99X988ZY1mJ
	Z8txNjKmEzg3B5hGdUCZAROEuZjlXM1sEFlVDM87oWotornUpeP32eUAWeIH4RFx
	dCLh0j8DP5ugcl7VBeAGXhyoMGhyPg0Gbcx/hhiVQBGmz+DohvIZGrcBsuvNaX57
	btws1A==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb3sev2gf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 14:11:58 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93909014c85so1298708885a.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792159918; x=1792764718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=83Mt4HXkNxMhXoNbNZY+WQIFtNOuy89fZ73gqiGaArw=;
        b=VkwCa8vaEPX/IQ8KgrbJOxDsh9x2LfJmf5NkmwQUEH4/PvSfUaWRvnGaI2oFschBLv
         e9j+I+FJNhpPJkR/bZNBaS4eZicAwCPuLc+EI76oMjzBBJHJTCU1uqVii/lsVneGbup7
         ro506F/YB5iNHMWIHjS3HEXBTZg7bf9sh89uCLar5ayi5bZunTxT17yYYznfL/UwTVKo
         7eQIuTdliPXTbpmjUq11QHg90jEzBTmtLgWs1UsMgscPP3iOB677cA4OPRG2s13tMyEm
         F2EGFBpNs5j40UegNM2XDNYdUISz93SkJhKyfcO6SDwrDdA0Ov9VvarTVFYgk1vZmry2
         w5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792159918; x=1792764718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=83Mt4HXkNxMhXoNbNZY+WQIFtNOuy89fZ73gqiGaArw=;
        b=h61l8VfI+VcMTOL0rPM4MpVN8HiCYlHIJQAzBDq0Xu5fNEATmZ7eJf0YbBpzkF9qYD
         sAq/L8gDCGUxAoN4yLB4ZTSyohFt7jEK4vHQ0MHJ5aRSC967ePU09AsyUp3akutDpSnH
         lhpqwgDJsO0Xv4yGEoLOIlbU44yLF/8kwXyomejAxNMvt5yTNAg4r311ufrhYTVLNO6S
         IXW2Hy9PeBBLWDMRazPD74VCJXHFse1tXn23NQpfFW5jLtzxqiayZ6+40yo9RJoRpBqu
         iU/7FCxgy97t7VBlokzgMAonUb4pEbxWytNuNYVrVgn08+WcVeV6FUoBaRnCOE3a2P7w
         SVuA==
X-Forwarded-Encrypted: i=1; AKwUvBwbigcGDGFWodj7Pzuka/kapZDa0of0PE7jwFztLPBnPzd53MyVA8aEcITj1m2+TMPGrLm/IYE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJDJqhq+4r1hZr1XjrMHsDIh9nhgrL68sMur69w/ajRhsJm3Tys
	A0enzU7eUC76RoU7UjoNYrii4KIQv4w1wW6vZgpBL4UjBSBtNJrTLfHLLisUpMpnXNYGGFDKA7z
	EoiI2ivC5DV4I2OPtqVCQ0moaRJ6eqew+HeJ8P+F/UM73GNxJzpnYUv8IiQU=
X-Gm-Gg: AYBFou0pMJN8iKg6AG8voE6qWD2zCqddMyVS1lfMSsKUXNt1MystJAq2yGCGZ5DjRJk
	LhWp/4mb94ulrEmZ9tpU2TM6X9dRIZaytftgHzaKcVWSgzx3tezMsC6XCFTnVJ4hwQEop99FsN3
	N66FuZxYz6cwiwRsfyReXxLBERlNlWXtUON2rvExmM7Jc7vwe5GRJLqjKGy85qXatyZ/46NpMin
	5oKQkdPqcjNHdORR3O9NIoJsbfMnSesLqBCoWGSZ7xqkq9vlddNF06HuZ2tdixx5ZKQekpBMWUK
	utLnq6QAQX+6VEUFcnAS4bj+E8o+x7MYaLIwDMfI7ebBjksGaJc01lDArd+ivRPOmVPA9zlTwqn
	7xPOJ98o+1erbN8wwYKpnzTqwjoue
X-Received: by 2002:a05:620a:4102:b0:93e:c12c:f117 with SMTP id af79cd13be357-93ec12d0548mr3510766585a.67.1792159917592;
        Fri, 16 Oct 2026 07:11:57 -0700 (PDT)
X-Received: by 2002:a05:620a:4102:b0:93e:c12c:f117 with SMTP id af79cd13be357-93ec12d0548mr3510761085a.67.1792159917013;
        Fri, 16 Oct 2026 07:11:57 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd4f8babsm5760145f8f.33.2026.10.16.07.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:11:56 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 16:11:46 +0200
Subject: [PATCH v11 1/4] crypto: qce - Reject empty messages for AES-XTS
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-qce-fixes-skcipher-v11-1-d13ddfe609a4@oss.qualcomm.com>
References: <20261016-qce-fixes-skcipher-v11-0-d13ddfe609a4@oss.qualcomm.com>
In-Reply-To: <20261016-qce-fixes-skcipher-v11-0-d13ddfe609a4@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Russell King <linux@armlinux.org.uk>, Abel Vesa <abelvesa@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org, Pankaj Patil <pankaj.patil@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1548;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=10czG1yn2EOwOEpiuflfvi91l4e59NVnoKNaveNpS5Q=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq0jCntwqj4dA+B6RPFNzhijNp1ZzA3Fxh0I5iW
 8cO7uBd+AKJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatIwpwAKCRAFnS7L/zaE
 w3G7D/wMlPfcou3916MiaG2xWtwt20v4UjUldw8n3h08pu4GmAbT5nJkM5tYcERtsxLnwFHOh5q
 /OJT4yjwWTVMIdTZB8yDI8V9lBMOVBaQ52A773sbLit4mwN1PGQ2/NDiqx+jgmnIrXfbMZmffoF
 5Nbqgu0vw5/2UMJ8Xj0DQEWKvkQggLqIxNvO3KtWSmjpI0kWs9X0Q6AMHpy1vAe0V4N5aNIP+5m
 75NM6Kd3uKBhKyocUejhfTBRM/ndIiuNXR4kQJunFU0+sSUQQg/ZnJwhiwVlEdmPh0jxJL3Ks0h
 J7B3NUdDB2IdZ9Buk+RnPqPKERJEyy34pkT8lKURQ3SDNpfWJj7JHfWWJIbSufoP8x75ix3w11j
 gpNjCtLba7kyrcjgPuklDP4HNa/w1SMRHG2M4Avy1WIVqkUY9Vk4qGV174yGar+YXHiQNc38/uS
 Bla9pkeUpJ7OwE15D+rD2KpPnIaDDQoM+REljUdg3YESydnttEVCv3rt4fnPa5v3dHb9QOjSVRJ
 TNbMhy6EmDl3lPkEzTQuDpbJ2bYcAnVDVKUzKhOHM6vedfzR0k1adRUGS9A7WbZMabji8/XaV2a
 JDDOdmvSeY6rgaDYvQ7FB4165bq7Z2nF/estEJDabpLDDRi9xmJ2Ha53NGsgmGJyU8LxfcqFzwg
 IiAEocAQkBBchDw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: Uyt4lt_QZXFtTutKg340ZyoxW7mjOrFQ
X-Proofpoint-GUID: Uyt4lt_QZXFtTutKg340ZyoxW7mjOrFQ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NiBTYWx0ZWRfX3TjhAXsndNxT
 ogsLqkUfBWAu3H7yP+lOX2rJJOSYbknT1fWFZYaVWpoyii/tFzkhFNcEyZUJMS6KuQqdAhEN5HY
 PZwgyh5itqF/oH7LGMiKqIQXSowin+E=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NiBTYWx0ZWRfX5qwkl80FCmPO
 FMrcq56jD/oUnAnVpx/u4qmdY7dHT9NyhSQwYs99lBfxjtEx7SKc8wFrgqLSMH1AChjAIIQDq2v
 K9ip9CYN5gw0FrPN8dcDMC1Ri4KDF6wo/ZU242UdS7jykvEgmWxvqmiDUrdSexe/uvm6hcDK4r8
 eYTOx4GuOHwG4Co9uOCnm7QQl41tKlNkdSZCvPdIdHSPy0X2Nv5L3h981e6YUHd7WKCLq28k7+z
 WkeYTlV/HE8QDgW5qJr2aFgmWVq+wd1scYdSSRgCwFUMT5uPBpOJJEQ8I638BXP6MK1lpOsZL8H
 So317LHYm+mQnF6slW2Pi+0LABUwAvG0UXnIrxWbbI8vFI53XVf5w1/5IXXNjfVrOprhvseIJ8D
 D8gvycqErQaEjftBWuIV7YrVVz5IXy97sF+8BpXw8OTrZoMLVLNkktAa6B5A8z2T5l/2rCa6cEi
 EFgSdroUyRp8RLb369A==
X-Authority-Analysis: v=2.4 cv=Se1i5fRu c=1 sm=1 tr=0 ts=6ad230ae cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=kiYxeA6Iecqc4QeK3QQA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_02,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 phishscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160056

XTS is not defined for an empty plaintext: it requires at least one full
block of data. The driver treated a zero-length request as a successful
no-op, so the crypto self-tests "unexpectedly succeeded" when -EINVAL
was expected.

Return -EINVAL for empty XTS requests while keeping the no-op behavior
for the other ciphers, which the crypto engine simply cannot process due
to its DMA not supporting zero-length transfers.

Cc: stable@vger.kernel.org
Fixes: f08789462255 ("crypto: qce - Return error for zero length messages")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Tested-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/skcipher.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 03a3cec2bb90e8d8c17e491ca40ec740a003d1b4..f177062eb735148561f798d0d3e65265f3235da8 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -222,8 +222,12 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	keylen = IS_XTS(rctx->flags) ? ctx->enc_keylen >> 1 : ctx->enc_keylen;
 
 	/* CE does not handle 0 length messages */
-	if (!req->cryptlen)
+	if (!req->cryptlen) {
+		/* XTS requires at least one full block of data */
+		if (IS_XTS(rctx->flags))
+			return -EINVAL;
 		return 0;
+	}
 
 	/*
 	 * ECB and CBC algorithms require message lengths to be

-- 
2.47.3

