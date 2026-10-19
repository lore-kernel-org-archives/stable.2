Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99AE44D73BB
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 14:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792421202; cv=none; b=BnSea4Kk6lNH1z9TZwyFmtQhpL7S2f2Wxobm3+TR1xTucp/PmIZF/rU6xkOIPR5FWJXUTJWZ1Uj+AcEoj2Og3BfHkLDIDCUPWClYN6WeG3twcTpdfshy6QRBoUD9CoopeRV4Cv/dvrgaL12XYGIwV78BQ3yyFngN7NCCrkNRYE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792421202; c=relaxed/simple;
	bh=U5DsfYf7sqacran+tCtHIouVxuUoq1D9dzdVHWqqSzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GgoL2vVTTrenYCA8IfbcqQ/bLJyoO4ZIjOieRoVynY/XhRln+6jfV8HHo9DkhzMNIXyg6hhanZtL0XJukAb7XguUoHF3Ik2DngMHuRkGxpElsRuu20TT7AKAKpza7MDu25gUy39hAxfHfBZrAmo0UVBpn8SoXvQPAyQlyVcmh3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D3/nDk9d; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=RA9GJoHu; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D3/nDk9d";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="RA9GJoHu"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69JE0AuY3989995
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 14:46:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mNqW/OdrhkVgohP+EotV1nY1Qp7qskLwaN7gKePu5lo=; b=D3/nDk9drFO8V2Ub
	ekcw8fKLnZKLc8uIiIbCPbtbTAWyh/lp9MX/Ado9Fls7asV7kBJokAUMMlYgrjR6
	x+t/97QpG9vjQVEK74n9bjz8PGxsMHMqIY42uAwbWFOCK9750cizhxUYPCFztpHT
	sgE5ELjCW3Py1mWWtY/qL51lgth5MdYL7aU2JjVZosc9bLoi19Zbvk2+BiAepQOn
	tqwjKWZdVWiGgUafOF6mUE1B9hlIcoR2rYnFbKHwOTg8Vhsx8ZBF5ZRP3pDzLJdH
	xugFwFJa5qXITTpiyTW5VIlKFLaESM/VskbWxQ3HvUTt7ALtG4cRCQm+zIGx8luU
	0AObNQ==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com [209.85.217.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf3f9q57-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 14:46:37 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id ada2fe7eead31-7cc450e6dc2so1495409137.2
        for <stable@vger.kernel.org>; Mon, 19 Oct 2026 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792421197; x=1793025997; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mNqW/OdrhkVgohP+EotV1nY1Qp7qskLwaN7gKePu5lo=;
        b=RA9GJoHuWnzRLD9MwBy7ytG4CeQutO2UJbRYvpL92kFLqx5iaBa8YOHL1UR5rRKlNl
         NBGCTPZ7BGrwYCz1mb9fwSzXtdO7irXaezjBtcuuJx8iow/1VHdUUd2sUIKRFIEHU+F1
         A7jXGYCWwQTkHF/NrwqtOz6zcCrzbR98Wnld5MG87ajpH1RZlhsvI9RVrBuIW3kSMxUh
         Dksn8A6palArFQCY9mtcdAgK0jybeHyt/wPBa50qYCvXsNywkLu9BGb8PqiVSfJSkhS7
         mMmFCvRNjiDEEN+Yz2U9XbGAy7JSJJMBtZ3qV3RXBi+mAJHsbrta1W8pWKdh6uMb5AKO
         VpyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792421197; x=1793025997;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mNqW/OdrhkVgohP+EotV1nY1Qp7qskLwaN7gKePu5lo=;
        b=u4fNUqn0MubT5GXJKIp1m1qOjraQkcpDw5g5bZZPpvS4jC+UJk3V2NWcxx6X+k9anT
         r2C+8FRaZLJDeyebm0AHxX92dAoxqCgQ/A6awUEt093qgzZ6bJMWlLz3VUBpTQv2rFz4
         2Kp0hmW6hFKpU2oMgw//yHLE8NXDA/gPXknHzZoeqxqAV2NjjK8CZADEnxMr6eHOw9uw
         9bXnZskkuwJlALib18lbqBylpRyWYjylbl8e7PDIbLA6tXl153v3ozlGZY2z551O7q8/
         mf8KR18A5KhF4G1nT6z4HV+gH0+GUf1wu1IsqSvTrT63hVdmMoPPMYA+2tVQytLcR4zO
         Nwww==
X-Forwarded-Encrypted: i=1; AKwUvBwHL0sDLKQc9Gqy5BLiSyjtZpOKc+zptxEXIw3+4/q+Ggvk7+NMTcCObTwgbXWkrQZHM3qOZA8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLCSZy6OXIIXqmyRcYSkGTV+C7gbPq0jxC1u8feNPwMzenHdkvS
	T7o0kMFLLRiq6VdP6+IyNBTGXo0N5RFyeiTszdydx6Ef4W2Z1CvO/gQKLjUCR7Ahf2PlAI3fhz0
	8VWHc7wQA/VC0nxuSlnbXQDQuCk8plhZIRulrPq+TSH1wl8Y3X75pQBT12pQ=
X-Gm-Gg: AYBFou2pG6yhkSFSmsxiz44RXB6l3MaKRJmLx7HLtLwJajaZEK9BoDK3nMGcDhpQuw6
	RYUhtv0cQ0r71yCD4pbZfrMPuf49ZTSb2qeA/BcQ7JnKoauctmMVr+OeYbfnGKhhlRfyVtpUI8t
	YpxyzjcRU9AT6wc7YVOcgIge8gWoEy+ZsKienCphuqAqmlufhE1gCWkYLjvs227zfq3ImqO0zs4
	+BinmQELHgZgKbkRsft6E/QpZ1OPp1pY9ql0rlTKbIU8/fLJg0f/oJTGV8afHdXgd7XTPTiHEPU
	92AW1Hp1kjtPkgl80St+r3ixhDf0AosBBRZ7d3VKE9ktNW6hTotrZDK7GiGaLRJUtrXYk53e8vE
	sIa3N26hQjjB8G4iH/y/kBY8S7eAA
X-Received: by 2002:a05:6102:f9b:b0:7cc:22f0:830a with SMTP id ada2fe7eead31-7cc369050a7mr2611656137.8.1792421196396;
        Mon, 19 Oct 2026 07:46:36 -0700 (PDT)
X-Received: by 2002:a05:6102:f9b:b0:7cc:22f0:830a with SMTP id ada2fe7eead31-7cc369050a7mr2611634137.8.1792421195868;
        Mon, 19 Oct 2026 07:46:35 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1e7657d4dsm98504635e9.2.2026.10.19.07.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 07:46:34 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 16:46:07 +0200
Subject: [PATCH v12 3/4] crypto: qce - Use fallback for fragmented skcipher
 payloads
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-qce-fixes-skcipher-v12-3-046e6be9bd83@oss.qualcomm.com>
References: <20261019-qce-fixes-skcipher-v12-0-046e6be9bd83@oss.qualcomm.com>
In-Reply-To: <20261019-qce-fixes-skcipher-v12-0-046e6be9bd83@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3507;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=U5DsfYf7sqacran+tCtHIouVxuUoq1D9dzdVHWqqSzY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq1i1C+Ctu1Q1az9umj2q9CNbZHy6f58znek/dR
 vs/1hl5eZWJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCatYtQgAKCRAFnS7L/zaE
 w2U2D/45jfsdCHHyvv+xzQogWs5/obGHAP0eRXA/Hj5z+pyC6r/Rk4DIao3QfhNkyS1STT23j8c
 TFD6XgrWneQpmoTnmL+gkNMvCZ01zNN9NogFv2Bno1UYwa6HiHJTAGe+Cyz/6eACC4uYjwv1pSA
 M96J/1qJM5S56RVl5yCsaH09IgQuASu0qK7PMIoJbXzEv0NS/zAjxXzFlxpQYcZUS1iDvb/udUj
 W8i4UtR5XaI+CruB6OCM5P+Flq9l7vhZXZdSk5j5COj0okK7p8Hl7QieT5rlVMaufCBEfd3Ho1Z
 GmRZgCAduN/4eJ1Vft5Sl2GegE7GThVZQ8SrP9cNJ0kkedICoglUiZHSSpxTddY1KHSqJaTx1PH
 E8S6Y6ZngKk901GvPqSTPDj9oFo5WqsPerP9wZNtG+cvngG7k1Ib62SMCYy51jte/z7nEMTAFRT
 hkk8jsjgT3Fco/VRoZ3DRFALX4K/q4ST2fC4oYiYOM46HDinYwvJ6/pnt66WV9NT0Mgq8ZgqIE+
 5U3k4377gAScEnBHebwMkVl/H8eBKkFjkB7PH8tWk+p7bIaBqK9GgxvCpyrerGggMINJ7vRuV8y
 S34AEg0y+9uyP4GWesug48CTB+S40Nhxl29AtH/rDBumHNR52IQMigHibLjjmr4GUXDyBHpm7OA
 LWbpotcQ1ZjmQGQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: Y45IUS9de5iFshxfg1YqVOc-Qaf-QG-a
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX5m+DkdacgFSU
 hpGmhHYKDojfQ1ExIodK4xgw6vSU+KkdxNqtwhXQABPzNzC8LfRqMPFvFEK4RfmFow6Cc7Vp59T
 ac2updd3e5AoJ/2phdR2QnqnU5PCkrtGiGdefWqmRrwTnr2q2W2WRBJWn5qK9+1BMkdkiAH7qNH
 Xf1QYhJiOcA2rB+IWwuyMlVfrezpb/FdR2L+pacR6/lVnmFGXZwOsTmsD7tZVY2R0BYYJc7bWKF
 FjYnLMYGMgMSVWRAFSm8GMBZ2u8Vypn+oHec14YXJXFxUcQBtN++qoIuaOEGoMXpEQhEhzqjJFK
 3vwtgYcV60bY9ubTIdLXO4z7nj+VQ0+l8U4R0eIJczUDhsWM1DIzxOl+XtR94oO8NnrJSIIgceb
 MCtN5zrhV/DkJlHoEe3yHLedGP6QT8550lHAAa5vQk1iSqYVZ/ifkwWsFsNBI+NQdIOUIr/WibT
 Y5J4hCAbFDiW89GNiKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1OCBTYWx0ZWRfX/fsIeXSPGA8F
 YetbBPAWTjcGLOmPfJBSAv05vM8I0dZsLFs7wKdRBgk1qVYn/AghuPBCUMGILbeXWA6ubFvB98d
 nk+IJhtDayGE5R4uinav1MWMZLIoHWk=
X-Proofpoint-GUID: Y45IUS9de5iFshxfg1YqVOc-Qaf-QG-a
X-Authority-Analysis: v=2.4 cv=OaANnRTY c=1 sm=1 tr=0 ts=6ad62d4d cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=0H9NDlJ9gza-_DYZ0SQA:9 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0 clxscore=1015
 malwarescore=0 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190058

The crypto engine reliably processes AES requests only when the payload
is a single contiguous buffer. A payload split across multiple
scatterlist entries makes the engine stall waiting for input, failing
the request with a hardware operation error. This was uncovered by the
crypto self-tests, which feed the algorithms randomly fragmented
buffers.

Detect a payload that spans more than one scatterlist entry, in either
the source or the destination, and route the request to the software
fallback.

Cc: stable@vger.kernel.org
Fixes: 25b71d61d631 ("crypto: qce - Improve the conditions for requesting AES fallback cipher")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Tested-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/cipher.h   |  1 +
 drivers/crypto/qce/skcipher.c | 13 +++++++++++--
 2 files changed, 12 insertions(+), 2 deletions(-)

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
index 8d4cd1d08c0e9d78f044057ecb45e5aa8b9a40a3..6a8d642c40a36974231bc4aa2717a5378f17134c 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -215,7 +215,7 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	struct qce_cipher_reqctx *rctx = skcipher_request_ctx(req);
 	struct qce_alg_template *tmpl = to_cipher_tmpl(tfm);
 	unsigned int blocksize = crypto_skcipher_blocksize(tfm);
-	int keylen;
+	int keylen, src_nents, dst_nents;
 
 	rctx->flags = tmpl->alg_flags;
 	rctx->flags |= encrypt ? QCE_ENCRYPT : QCE_DECRYPT;
@@ -241,6 +241,11 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 		if (!IS_ALIGNED(req->cryptlen, blocksize))
 			return -EINVAL;
 
+	src_nents = sg_nents_for_len(req->src, req->cryptlen);
+	dst_nents = sg_nents_for_len(req->dst, req->cryptlen);
+	if (src_nents < 0 || dst_nents < 0)
+		return -EINVAL;
+
 	/*
 	 * Conditions for requesting a fallback cipher
 	 * AES-192 (not supported by crypto engine (CE))
@@ -250,13 +255,17 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	 * needed in all versions of CE)
 	 * AES-CTR with a partial final block (the CE stalls waiting for a full
 	 * block of input).
+	 * A payload fragmented across more than one scatterlist entry (the CE
+	 * stalls waiting for input in that case too).
 	 */
 	if (IS_AES(rctx->flags) &&
 	    ((keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_256) ||
 	    (IS_CTR(rctx->flags) && !IS_ALIGNED(req->cryptlen, AES_BLOCK_SIZE)) ||
 	    (IS_XTS(rctx->flags) && ((req->cryptlen <= aes_sw_max_len) ||
 	    (req->cryptlen > QCE_SECTOR_SIZE &&
-	    req->cryptlen % QCE_SECTOR_SIZE))))) {
+	    req->cryptlen % QCE_SECTOR_SIZE))) ||
+	    (IS_XTS(rctx->flags) && ctx->use_fallback) ||
+	    src_nents > 1 || dst_nents > 1)) {
 		skcipher_request_set_tfm(&rctx->fallback_req, ctx->fallback);
 		skcipher_request_set_callback(&rctx->fallback_req,
 					      req->base.flags,

-- 
2.47.3

