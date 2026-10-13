Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE00F47F770
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791885499; cv=none; b=ordMgbnLQusFei23uMo+XGPAhU4Qj+9tp5NK3Rx4UDUYQ/clq0vdsMyICF6If0/VqhpLR4sS/Lz+oEd2wm8hA0L4bfs5Ds1D45Udd1mtHL/1ky+415DHCAxZN/u210jxKwKBVkE4bb+mu4CGuHvXDcfZyCwMD09Ub2sbLHoY/U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791885499; c=relaxed/simple;
	bh=tEyC+0i3JYi+4o+oeZoSxb9j/TTBdIukaHcLIW/MMlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=i9jt/i1HLaE7ibcLaPMVON9JOmkSkgGLU3xU95zIOKERKKpga/5wbHjlQXUO33iRY42p3DV7M2qPP/5sjZtgxSLc/GcL1FlI5kxky+1yjz442+OkBxXDwCe2azLAJWLuudDm0VzBVCTcJzxM1RULjjXj5YPa0z9GMBCjyTRYiVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FMFoeXlS; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VjqGN0fR; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FMFoeXlS";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VjqGN0fR"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D944jH483080
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:58:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/VgdH68pAygOIbbHjawhqvf2/ukjbs3WFpFquZcEkEg=; b=FMFoeXlSMjKGktWS
	tHjdZ5H9dwDsfVuMMkXLFRapQmoc19rWNWWDLkVJiGYuNu8uJtUaJlrPKdwt3jl/
	WnCMXazdNMl1NKOEOa6dH7t+6erR6Nhx5RRcMZf6uX5z2xakV8UNocmmKZfscpZZ
	i6vRciBnMg9PR7sdwHWGCqAtk8BNwvbhV8Wt4Kb9+406q/P/uoh94fUh3axpgpF4
	GKzqEm7VncuWFaH/SIzNeydJ3nncIsXviaH8CPctU7oYwsunGGme54vOs5H/kJUP
	9VR9qG3T/bv8jufsWZ6ndqdxMjajWD4D28c2EMRCFRMCtIPt8+8UPXGaHugJs04E
	wMMMdQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h9hpg87gx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 09:58:14 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93ae8e7e546so583410785a.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791885494; x=1792490294; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/VgdH68pAygOIbbHjawhqvf2/ukjbs3WFpFquZcEkEg=;
        b=VjqGN0fRt0ZSPMMWGGaqJBNvBF6cbRMlHC3JA3zcaIF+kiqneh8quaMtE9Ygqfm4Y1
         IFMq+3bocVAbg84EHfWTbCej4OsDTzwNl5PXN8GOp9+XlCAULsKTvmCiWgkBpsPaB1Kd
         lr9QA4saUg0z1C32qtt2Pr5nPlj4d4/HeJL5KBf7L7vrYmYAPMms3PeufJ1lWeBg0q7T
         W0ufflXeKY+DNDn3tXIwxxFQPkgXrOIhzrE3ZloZ7CVBi66vZHs1ILVbWK/UzstlZV6b
         Jp5H45M3vRrPc0RASZjBfZ6FheV2p5ydnZ8Mb37ORqwsqE89fCBjQTUCumX6d0zDWZRl
         YCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791885494; x=1792490294;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/VgdH68pAygOIbbHjawhqvf2/ukjbs3WFpFquZcEkEg=;
        b=qtfItB8WdasTRf0jvoBNtTmOMq2r1a1gTx+mAVWIke1RYAIiCCOUJm+C160ZsLIsMB
         ZrgOzS7vbOS9szq7/Tt0PgmH39FISyVYhGhxlRazNuJ3G0L6FGLqAXaGOsQrY6l6QhIm
         Qb1GgRqGh8GpCKdA0Og/I0FDQ7gvViX40YDARhGhO9cCC292fZI4rg2MhnfbzqEbGMbM
         +aNXUtmACnvaEAKlnTgP+xRFZmqh1ZuTgZ5zxK9ijmaGOEIZKUqy5CHORO0qs/NcRaiO
         NOIOtexddrDMvtOulyyHG99SP4F1sQoW78tzCE7KOuATAoMYB667iWyi7QP+wPr6BHyW
         spDw==
X-Forwarded-Encrypted: i=1; AKwUvBz1JOCDwyNYIkt3fwBhvECC+M6NUGObxROfEA1iwj+lPOjx8lb3X1sw8/51+KcbCSr8GOhLBlw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKN7sWKrCHTavxymI0TNt/hJO841+Mqcorx045VrdXWO5YoYIVd
	raJ832W12NkfohiYOEV7kA/MRfWY2J+0GYPyc1zqwFE9SOjVjNYqJf7ZE/6MJ71ya75vQ6bCjdy
	r8lqz7fepy5PyC07cCF191qBVVsn284rfJkRG35x3c07sc/b4LZ8xk1eYwlo=
X-Gm-Gg: AYBFou2ACWa0TcRFuSK1MEW3wlOGMAyuKXNJsg31tTse59+NfP0XZTA+fV3LueNCevW
	UCoDE/UegH87FDuLfRW+//NF80SHWTK9d020OZqysD/3j7XCwNUKU4WuH0Xcjx34C7tfQuxX7D5
	nkC462KisOgYsfWmXxUfcfyUrQtdfrgdSheDh51XsjUPa4Zo0lAD+FAvq1GDcXgpJDlFFwHNPJe
	UwHVZEMDOUDhgpSptrMThp6DAsJh25+P8XasujxRhKz/uWBlW/BxFn5WKoze8YrDAHb2kNlxMOS
	ea72xJdKUH7uJRWfXPdTo+DbFidIGbhBipkpgbY+O7PPOseY5Pg/VtfFuXbDqQ1ARfRu8O06cxa
	lmQqAvTU1bSofcN51azTex2b7sR6M
X-Received: by 2002:a05:620a:a193:10b0:93e:e500:7f53 with SMTP id af79cd13be357-93ee500800bmr619288885a.65.1791885494390;
        Tue, 13 Oct 2026 02:58:14 -0700 (PDT)
X-Received: by 2002:a05:620a:a193:10b0:93e:e500:7f53 with SMTP id af79cd13be357-93ee500800bmr619287085a.65.1791885493956;
        Tue, 13 Oct 2026 02:58:13 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bb6beaesm209412025e9.0.2026.10.13.02.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 02:58:12 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 13 Oct 2026 11:57:34 +0200
Subject: [PATCH v10 05/14] crypto: qce - Use fallback for fragmented
 skcipher payloads
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261013-qce-fix-self-tests-v10-5-57162a38a554@oss.qualcomm.com>
References: <20261013-qce-fix-self-tests-v10-0-57162a38a554@oss.qualcomm.com>
In-Reply-To: <20261013-qce-fix-self-tests-v10-0-57162a38a554@oss.qualcomm.com>
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
        stable@vger.kernel.org, Pankaj Patil <pankaj.patil@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3055;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=tEyC+0i3JYi+4o+oeZoSxb9j/TTBdIukaHcLIW/MMlg=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqzgCeD6xBUFrJDXXdrUNd3BY0VxZzHne6oO5jJ
 NrUxltShHSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCas4AngAKCRAFnS7L/zaE
 wxdREAC5y98/3wrnRZghKq5EX5Swf6izweD8gFrBpKlmSbONDHjtsX+0ktTT88nFg3H2y3AbvZe
 8Yly1P/cFxH79JMEZVx3aL+/H5IKd4f5NgWTQ2DZU0dW9PgoXXhZuVqB/+AxDprSldIWmZ4RQGU
 aBu/UlIQhsbe4TJaIvxi4EAmaOWs0PMU/Kq8ZObuRi9ePo6cE7ansGm1WY8SlP5WP0RAfYxROrE
 9DtKFyJsQmpztDhXS1uJ2R0gnQZBHmqJQpvl28/Ge/+6GfFaYJLyuCtl9MHZ8bC1sVbjlwOCs7S
 1n4moC8t08AkRhC/20sjFsyOuBLvhF8MfYZcC6x6YtLo/KhwSPs+x6plYNLAegb/DpdOnjevord
 Ayw4zSg/8joy/KdDTJpn535mePMZwxFXMMdzf8UCoNUAooDAL8MB8a+J9/mR4qvOXYQhhE8Z15w
 3e+h6voQWdvQ+fY/pT8vfE6ANRfH5xfyU6BKJKqNATWJpb26rlkg+NZGOWPQQ4FGQbi43fdzJx/
 Zk25PKptJKn9JZ4UJc2Aev+CPZLb4mp8NmzVg/NUc1zpCTwPMwV1dGFXU0tGob6/0w2SRhlTAMr
 8VEiASrYO7HGrLY2evTUXI4idD6vzYYQwEK8IkC2C4nifrinWqQ9WH0NoLZPAKkbzGgqpe0tzpP
 DZ3Qxruykmm9kjg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: WS-cRZ4BAjeLqMfIPRbO0PLco6gYBvkO
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzOSBTYWx0ZWRfX9GdPvQOHZZw/
 qUx45ljYiLPA37l8rR/5NMDVM0fjsBzzeJ/NO/Wt1i3YJqyMk+V04xBZHDVBW58KT/Rdjl4C6P3
 pBippnNjOox+Au0x1LYZLmWlz1wyA5Q=
X-Proofpoint-ORIG-GUID: WS-cRZ4BAjeLqMfIPRbO0PLco6gYBvkO
X-Authority-Analysis: v=2.4 cv=Z4Z5j3RA c=1 sm=1 tr=0 ts=6ace00b7 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=2ArJjka39wvl4ErYtigA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzOSBTYWx0ZWRfX35pCVmynmv+G
 vhsvUJS69qQ6Z9h07zNo+57d2HIeg4b1TjzmYN9Hhy7PkQmChmnktozxIZc3SQ+rsEL9qWjZLxc
 xy5LIPUn7mv9cLvfQn28v4s1LRZWO98daA71dZbuDq8FFWJnFuN663AjoyuAfsSYH4yLrFo54X+
 JQz6V6b+6/HiTRx/ukKp5F+7DENLnc/Qh8mf1vR/m56zH9+93MvlcTyIj5iGVz97P0uhcZqgltE
 ArttyQwMNHQM16J5QWwhw3peOhIeY3t93DGs/PjU3fkgq0LYTGljpSFz0NyMuNT9NDQPy20X3eh
 aErIlvDAsoYYtOzQC7oC8JCsh8Cfmu/HXr7eWUKMCQOLZur+bonWXHFIDMAIQ9ICIPRjLCBwE6J
 UzBD0KFoMmoZb5YA/F29jZCY7hi0yVnnYbIPXirtxs+ClFMsFWbLjSJzAVBAeTBGo40qI4XEZdm
 ZkxTEs6G0Zj84To/k7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130039

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
 drivers/crypto/qce/skcipher.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 6c578bda8363c6656b61105e2c3c62b9ed55e7b4..9df0b7254c659e83e5a2c220dde853d587b3824f 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -223,7 +223,7 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	struct qce_cipher_reqctx *rctx = skcipher_request_ctx(req);
 	struct qce_alg_template *tmpl = to_cipher_tmpl(tfm);
 	unsigned int blocksize = crypto_skcipher_blocksize(tfm);
-	int keylen;
+	int keylen, src_nents, dst_nents;
 
 	rctx->flags = tmpl->alg_flags;
 	rctx->flags |= encrypt ? QCE_ENCRYPT : QCE_DECRYPT;
@@ -245,6 +245,11 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
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
@@ -254,13 +259,17 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
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

