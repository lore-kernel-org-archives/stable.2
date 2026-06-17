Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6D04A33F2
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711427; cv=none; b=tdQUbuMcnYNs+UAsRVCXTq+FPumsxptx9+ncTbp2NLz7Ahw+WF4rJk7ZVECOJLqLwf/nTpc2bKLkxDw5vH0VhC9QZUZZF+PEyJjjB7sPFAmk9V/PS7sxLKXXc7438eIRoSGzv+aU/pRhFjxDHsbSj75Jptk94oY280Gc6oOqUl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711427; c=relaxed/simple;
	bh=+jSSnKBCewKu2gGq3nZqT1p+QKl0eV9583wFNZZdHdE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SKgaJJKlP8rofKP4/Uev+H/K8N8OcqpUn4PtlyibreKq6P0AN2ePzpuF7yflkEThY+D/UOgEmlgGwPy7VnUOe3xCyrlJE8kpeAMUHZN8Uw7DJ2DxLlJ6qjograF9HpNJEGPPkzjXvhXQwa6Xesti4saqe8Tbj4dfyBMPneFv7U0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N/HxbGBx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=W61lymsm; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N/HxbGBx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="W61lymsm"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HFOljX2590451
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MqQoQ693d9+FFoh/y5iAKv5cizC/RsqLEfYPTEBH9Ps=; b=N/HxbGBxaZtXlncN
	V5Lo+6q2kYo3H/7NbfIUhXWwknGbz+itmlYIrsRr6Lmf71m/LzMh1IJNg1OCS66Q
	5+EitSgGZTZeqnzIqTkgB6VX7FKHjIbuose2Byyndy+ktVSuJyLpc6yPPkzs7duM
	Q0xo4nXhOxh4g0NK4CwbQiGwNLGfbiw90mD3QFE7TXv78fieX+x2p9oapeYLcgkY
	fetqd64Qa2l6tPuU/NJx/U4nxeLyXFmNTwCknRzKnhqvmzgnzt4pUPdaNKCAZKeJ
	ff3dGcrbryUjIMmWE24opK6UdcjmDaNUG12rF22luod6Jq7stz5KbupPu9Lqb/vm
	/50Ksw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueer3yv0-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 15:50:09 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-963d7e5ac77so2532038241.2
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 08:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781711408; x=1782316208; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MqQoQ693d9+FFoh/y5iAKv5cizC/RsqLEfYPTEBH9Ps=;
        b=W61lymsmpNxwBkr1S0LIG75Lztf73FUTd+2lz7whiiALXlqu6pK0HZAX/l+ZIAOCHx
         eXkkhShWw4JamoSYCHHVvVyUnEemQRolwH0m9U+U+5/b1aAiWwm6BPGsIGPD/2x6MxAN
         Y2NDHwcE79iHhpKQb2VAn4iGJoIfRwtow03OSi83cvAJmDumdu5KV+q8tczWL89V4zU1
         Htu1UsFReL/QnMqcWB0UDLU84alX7cqOlfGXIg89ZABDoqzjRG2+4f63TkDi+9zqhjmD
         /DvItOAy1ZuKmk29Qr/TnboonAQDXH7tfuEVFrtB8nH6yK3C+tnWBOSJTkRLPVFW250M
         T3wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781711408; x=1782316208;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MqQoQ693d9+FFoh/y5iAKv5cizC/RsqLEfYPTEBH9Ps=;
        b=WdLlo5wv4vokuTDGGj0V5uTOX4BMMMe523YuIoFh0QQYLMJ5VfA+jXkGKQTB79CCWU
         m+k/0B1ceqGB7mlNBd3H7bIEyRPNiBJBfGFJOxoMqFDw2ojdRSWyOwoqbaVihenPIlE4
         N1zkGGW5xbpdIUALafQ6LfKVeb1Iyar85K2JvMPRLbVi0A4mPi+QdXHWtLLRqjt/xpqz
         DO115xnQ0i/syBj8g0v/cljXryZ2/P57sax5H13mOHgBV/9+EK+YKqH6wMHHbJKosMXQ
         LEtSjsZSyuINXs5Ery1fn8p/EEwE8riQMThWuwejayFZQaG2SJ1c7601xSMUPXTeMTru
         Rl0Q==
X-Forwarded-Encrypted: i=1; AFNElJ/K3JHg1PNtWLgGaFVS1jv8RhNFau9KeVr/weROfh01wkNdNFPhD86IQX5uRMGO1MtKUSWrqd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH8Wy2EPCIkjp/UeAbuNQXSoUHCkGtzWy3Xj9MV9x+kVFvi5Lc
	zadmkTQiNJ0vnWMBNiUZF/eCSKDT09Xpj0iPAc1UXwimpTTWXEA3GJmOHIyjmaW7DlW8XRATy9A
	6sHHWhIipuY2TmlI1I5qJvaNyP3yZ040T/oXMUKqJMb/oQ/N0Yd7F2tRrINo=
X-Gm-Gg: AfdE7clDbdHlmVy0jk4Y/lk7R0zcs+SHHRtZguJ2UmV/XWxhe1nCPa1WUpNej4XQpCo
	kgl5ej8Yaei8U+jVlJYGR3F09/5+k66GcjmaVaKItJJE1Eh1ML2tmSa/Ja8UAQlgeiivZk77l4C
	zqn3QJp1cr+e2BBJxnTJJ1LaZJB2V6KdGeheZLMi1LziCcY3PFrz19a/LMFgXa9NjnzGqcwUayD
	U32KTsolDR7/AEq7jZBNMgjdD6X6M+6JSSLZC4JzF7pq0Z0kDAj6qqt9sP62FiLr0L2XE/apM2I
	ud4YmDZcohhRmnsLrpBSToCsdlR9PGR/E3ku5J8etkD3XBdYIzFRIJKgBYLXKC3vEySE64un/6Q
	rYomceHD6Bz/u585HI7Q1UQEHcCNzVquaYvdMVarP
X-Received: by 2002:a05:6102:b05:b0:632:88f6:d6ae with SMTP id ada2fe7eead31-7246ced958emr2598261137.22.1781711408300;
        Wed, 17 Jun 2026 08:50:08 -0700 (PDT)
X-Received: by 2002:a05:6102:b05:b0:632:88f6:d6ae with SMTP id ada2fe7eead31-7246ced958emr2598231137.22.1781711407892;
        Wed, 17 Jun 2026 08:50:07 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:c856:25e5:e249:5e0f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa8b423sm168913195e9.11.2026.06.17.08.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 08:50:07 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 17:49:36 +0200
Subject: [PATCH v3 7/8] crypto: qce - Use a fallback for CCM with a partial
 final block
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260617-qce-fix-self-tests-v3-7-ecc2b4dedcfd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1563;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=+jSSnKBCewKu2gGq3nZqT1p+QKl0eV9583wFNZZdHdE=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqMsIch8tpiBStthDAUU24QVMgye77JzbUAq5Op
 qWCBpfAnlmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCajLCHAAKCRAFnS7L/zaE
 w+39D/wM+9RDENz4MqxtM2MPVmtn6p2LDKcYrIUoafXXJuRjUfaefZrg7OUwKEMkF4IZjJ5R8fR
 LjOJlT3RcYLFe58nFc0SiC10sTCXBuZzJ/6vYWkRFw8SUsvr8dyBTCbD+MiOpQWTx8zU8+3wjbe
 YhXZ4kCYcYSnRlnJMLGuP0U+0cczoJCTm+x9NxYo4+HifutPKIloCdlXJSedI1xX5PKkUWiivlF
 ggUJ7/haBIpR4/t1s8lFNLa/25Ony0gJwCojf2sK1i9/At68oNXYnEMBMteZCmU9WQeszMVc2dk
 PJxKiC12gy2bm/jrEA7i+zCxClqUlfLk5KGCutTRGu5dltmvol8xd73aEB5aqx5sSAOy9jYZnvM
 /9fj2aRLKSg4rFWeCxff9Y3gTLM0SwIYE0p2gOJ6KLU+1XXGSsIx0KCT2f2TJNhiCg13hbu9Tfx
 SS9OHW2jrBo+k/2RA9qXUIsiSTgbprvpE5SNupDBrUoVnjuLEVoGOeDZ6D0+rbHBdW6Rqw2KXoU
 atEUfQ426HPuaF76wThsq6uO/o4FNZbpLPJva+SfRz0N25iFG0RrvVyP6F8Y6PqibELUc23zbh7
 3I3OUmWR5K+NlT6C80VzOCoJG0/TP31QRdpg2zsqO/9Qrt0qt6moKK/WyJtLsaTq9bVivnTcBVB
 sKu4nxWFnmb7gbQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: IPrFRmszZQNiyCj-NjN7EIYyhPiZ-OtS
X-Authority-Analysis: v=2.4 cv=Mr1iLWae c=1 sm=1 tr=0 ts=6a32c231 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dx2SfONCXZg6tt9xEGkA:9 a=QEXdDO2ut3YA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-GUID: IPrFRmszZQNiyCj-NjN7EIYyhPiZ-OtS
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE1MSBTYWx0ZWRfX0Za5LAH7iK9r
 t3rZGopR7oNg7s0MllQSh6/Pwf6KeoqYOBiI5yt1P50hzdNCDWHo/wJQyf4WG0Nxhx2XWToFbBx
 eci6BerWFNDEz69Vc9S707nMhNXI/i4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE1MSBTYWx0ZWRfX+DDJGQxhVih8
 CcMb7GMeJqtKzjK1CB+tNfEgNDtk1lLfrjEHeWmDJ2OxISdz44I1ztdE+4VNKzzqQcwogSJ4RYl
 4FZETHlMruc5yESd6fH9ir+MhJKy0MuB94p78iFn3PS6rDnbrYVZQlIzIeB5fu40EHhH+F7FLLu
 C9gzUAWtst8PI6NqpfVRAbdU8+oyoYqdtGL42pzLPY0PS/SMh97P2XN1PXCmITL94Im4LKL5Hls
 +lt9kMFuTHUpprFWXP5slrGb0LBYmsFoYxLr0oHmQEHWcBPtOrHiFs+vbozoOuHRJiieFE4GuUw
 UkPP9OXYmDxhSXN9lOo/grGcIR0UF3MQMIrM0VV2Hexagdvh8eSkqqJOrrxw1leF9gCYRt/S9xn
 MXQoo3IbXGiTFrbGdW794z2W3vZDo2cR3aOhdXZK19wwk7A/PyvggTq72IlFCMqDI1jw1vghIfH
 xzkOAxuy2HDmKWY669A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170151

CCM builds on AES-CTR for encryption, and the crypto engine stalls on a
partial final block just as it does for plain ctr(aes): a payload whose
length is not a multiple of the AES block size leaves the operation
incomplete and fails with a hardware operation error. This was caught by
the ccm(aes) crypto self-tests.

Force the software fallback for CCM requests whose message length is not
block aligned, reusing the driver's existing need_fallback mechanism.

Cc: stable@vger.kernel.org
Fixes: 9363efb4181c ("crypto: qce - Add support for AEAD algorithms")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/aead.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 336614a11377e0be246817da584296124f4de5d8..4fa018204cb628c112f64c45ff6c7407df73b945 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -514,6 +514,14 @@ static int qce_aead_crypt(struct aead_request *req, int encrypt)
 			ctx->need_fallback = true;
 	}
 
+	/*
+	 * CCM uses AES-CTR internally and the CE stalls on a partial final
+	 * block, so a payload that is not a multiple of the block size has to
+	 * be handled by the fallback.
+	 */
+	if (IS_CCM(rctx->flags) && !IS_ALIGNED(rctx->cryptlen, AES_BLOCK_SIZE))
+		ctx->need_fallback = true;
+
 	/* If fallback is needed, schedule and exit */
 	if (ctx->need_fallback) {
 		/* Reset need_fallback in case the same ctx is used for another transaction */

-- 
2.47.3

