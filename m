Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133043B635B
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782134328; cv=none; b=a3ShstyAs0CpQR1QXNbydjVS76lXLAjmOEsgUbRjFgGrq0DzKWBT9mu4e/GA3Isk/2luBketi/HPU52+rXafJM4TuLh8I5nj3c2EOrGTvwInndqVOpdUhsN8hYeqOmrHT6H65ElhIUMKl2Qf3Xno4l032gKEs6s4lts19rRZ3gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782134328; c=relaxed/simple;
	bh=Ejq3GCF3ALDtojefcexMkYFTMI2wVEXKIrBlhj81Swc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BWQEGChqLs4pYWa56MUoOzBJUF8bAVhyf78/gyP8ydTY+WVqfV1kRD4Ed27IWWhyXvxFfbOOv8GwCAe9nSWUcjxnQlr4C0bwtuqWpidWukSjlWccmvgnq8jsk1aFXKyLEGpUnwKSEHjkPuHUkUwSylU9L+/v6m6hLvjwZA0Jw80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Db+8sPSk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=K0oucX7t; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Db+8sPSk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K0oucX7t"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDGj8k1261788
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EagaE396zMSCowVPFT/Lv2P0BLvUgaUxoxYWM76TMv4=; b=Db+8sPSkIIyDME5t
	prFz529aRKIixWWmfWO4AUCTvL4DGzP7pNHyy6hI66MF+3qxNaNJGdbmj73t1DLB
	Wzv/KLar0GdtgOaw1Yg45kNX5HX8K91zbKbpRaXHbJHzBDAiwpGEZtHYitDUkUuM
	hsmJiGQk/RbGwgcFh9UMnVBK6Ub2HypnxWOWoo0QGN6hD1FHKzuJ/jvcLyPT7wyN
	wgn6UPxt/kUufKkGsBSzaicgN9l2JOyOQT1ZoEzjKOOT/4x3xIzsmkY43ss/ro2X
	9bUNpiAVxNAnT60Kmho0jAILi8L1zoyZU/8s20eQAuRn1R79PKZ447H1UNPNqUJZ
	Me8Fww==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ey3eb8gv8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 22 Jun 2026 13:18:46 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-966cb1c76b2so5904808241.0
        for <stable@vger.kernel.org>; Mon, 22 Jun 2026 06:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782134325; x=1782739125; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EagaE396zMSCowVPFT/Lv2P0BLvUgaUxoxYWM76TMv4=;
        b=K0oucX7t3V4q4rJY5bHcCfs8LfSHRBHRbPdz4U2limMAkSlrTmHcGbJsmR1MtxGcOp
         Qn27mgwglfZgBftB5qqxWOX5Z0+JF7lIL7yOXDYZ93HfjF3N//g26U3MBwjhGqrbr2BX
         pq6eeR8DVHrBBr3R8bfAbf28uyb4JTUfuSoIQw+NQkwmYw5X7mET66THg6NcZjbGycfI
         MohsWxDrFVnklOGbo70k5D7sgkJvvSm/wnkfx/1M2OIV333PvE0YvBWzLEXx1kiAmvCY
         Hffmwyb/GAVLGvwXAfp9zLFUp4nrPdaunZz8Qx7sERwH2tCer/ThSFL2dAMYiS3mzLzo
         RQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782134325; x=1782739125;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EagaE396zMSCowVPFT/Lv2P0BLvUgaUxoxYWM76TMv4=;
        b=iYCzPfa++auonMa0w7omfmpklxqL/f0WWzgfkUBDsZ4wFw1Xx/geVdv8StbOgOwnv4
         RiDTDuh0Qv65r2mJaXpcyTDCj+10U/lSKg7SX9tzyIp/yC4NlgIdSZURVPUvkp3PN0ni
         xjYKEcCitwn1zYF/oNKiy6G7n9Ori9BZMYwYWNv274z1qI2NWMGApLJxKeJBttVb+G8q
         QT0UIoi6IAo4T82tNA1WObbSfhktsANC6cAis28oH9OM3YQPkA3vgtFyMyF0tPttGORH
         1BaT/i9e5JMRbPEieMvB8ip5DR5Xy/YCFX3vwpCSf3TTW2ZVLP9tDtxz7XubzKP8viyh
         Znmg==
X-Forwarded-Encrypted: i=1; AFNElJ9Jwp3pxuD+NeIrQIgzBrldqRsMneng1+baBhX3CdcWHZnQLEBRvW+rpKweD+6zg8DXAFQIkLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvPnuRJYp4N5GbqoAiPlmoSjr38bj77+xbmTptrUgQDDp+iJhL
	6dgyrEZXWlO2sZ44LUgxIMHV7VAr6wZo39t5fBuDS6hiQ+6IV+myTSLNe0YvIp2SWjTC+a9abDo
	aLHSNR/z9ehFrD4+Vx3MzQCeqGLCVUGdSpstf16GLzLQxx9AgwbZhjP3UaMI=
X-Gm-Gg: AfdE7cm3iYI7r9y0i3x6yqg1lhekg7OTTgQDhA/B4oHsK3fHHRxaO7rsiYnDQgRq6q0
	bcK1AeDBFjzgiOtIL4jUXdT9Seru8Zqr7wX0dt8GxXMFzC4aEFhHL03XYU+uw7GM+hDC5YV4rit
	yLmjI51E08x8FprwA6gHe6+Cf2ppazvCnxf7Y20FgWmB5zTdRxDEiUbgTstUGVEPJhxPS934fvd
	vC83zPxC+Pcc6SnEITXlsazrn0X4zgTlwA4wIcd4I0L6D5MsaHfKWxO27ukEkrml6ZUJg3Azg2v
	uONNNpKWhvfRHb2mtlMkaCiitAVE0fjrsk26Gf7b8cvXVD1ejaAjOTUfzgbLh78lrHwZCewBQ0C
	s6DxNKoZcHevyIhRl99iiCRyHfSHlnhGQIBhG4GYX
X-Received: by 2002:a05:6102:a14c:b0:726:c671:9b3 with SMTP id ada2fe7eead31-72a28dc5b45mr3659845137.11.1782134325469;
        Mon, 22 Jun 2026 06:18:45 -0700 (PDT)
X-Received: by 2002:a05:6102:a14c:b0:726:c671:9b3 with SMTP id ada2fe7eead31-72a28dc5b45mr3659822137.11.1782134325066;
        Mon, 22 Jun 2026 06:18:45 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:dea2:c31b:2872:1bd1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd30078sm294083835e9.7.2026.06.22.06.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 06:18:44 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 22 Jun 2026 15:18:15 +0200
Subject: [PATCH v4 7/8] crypto: qce - Use a fallback for CCM with a partial
 final block
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260622-qce-fix-self-tests-v4-7-4f82ffa716c6@oss.qualcomm.com>
References: <20260622-qce-fix-self-tests-v4-0-4f82ffa716c6@oss.qualcomm.com>
In-Reply-To: <20260622-qce-fix-self-tests-v4-0-4f82ffa716c6@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ejq3GCF3ALDtojefcexMkYFTMI2wVEXKIrBlhj81Swc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqOTYi8Jh1v8wUta/O9lvYexzHQYDAyJQDBui9j
 VQ63gP2oAmJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCajk2IgAKCRAFnS7L/zaE
 w1fPEACf0FREd4HRMwqXi9jrqFiMY2ieOc/pFZtlCrygde9QxQOlRqkQ1OfS3/Hv2y3YuZT2tIL
 UbnRMdaddzghJ+gis00EKzz3wSo7rGue5kGLiELEyZMDgXlsfeKaEC6iH7IaKaaVjuNTdhDtMS7
 OSZrUhsojr8g9gpKMQMGvPpG5p/LV/JAQXhPmS+TppIvPzlvKa1kMW+Rhj1tr5hOCwWy20xUTYZ
 cNBaks5Glryvhf9IQ6QxmnZW6LuKmF0RyK2BGejJTcVn4v6fn5c38PnfmHn9KSdueE+g6F5AOXt
 3mMgy/M6+l1DbfbNWAJImg4rUFfOtCYBIKVwvRp85Za5tqTaks8MsjCdtUTdKfdjKbVuXw9aGPk
 iaO4ciSHJ/xkZqknhlTPv7cFh583ySpDdDx3pZFMzNi3IJP6Fyh1cRg/bQG/YtgP5OBh5Pe5ZRE
 nuPsH++F5q8TmOlqjuE2QXkO2RzLFmJb59QuhovDJpgkwTWM3EBNYIkRP+pZaOpwYhIxIPM69BZ
 lcPZhqoK9Qq1sSJVRGc3ZymBXC5yWDhcxBcqeYMmzE94ZSK8g9oQ2Og8ym+wAOg827AqdpiYetH
 0Ko6AoViscjj33ww9ebnWgT2TpqQAy+e986HU3t+o+sNAbTA75uQz0OnWHUMZSUxazmLlF2x9eO
 8C4Cf4Ts4vtCVjQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDEzMSBTYWx0ZWRfXwRbK8w8VKFLu
 zsh9bHMTja1qcBlHCbEze4UIGzj8siUMyaNwt2k1+wY8iThZGhztoRbQSxVHkvE9pkadXcrlyka
 Cma1BIL8ifopip0FREANwh9uma1EbM0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDEzMSBTYWx0ZWRfX80IZ0JnK1ARO
 HOLim4FySE9laQGtvVXo0bTmPu6a8U8wQQGom5cMkjcGVfGFllHe27V1rDWol3Sqnuw+WzP1zZD
 AgN7IZNQcGyNXbnZS6HACX4moPE/lMM7EyTp6fXyxd457VoZR7qVVpD4Y0AM4Sn16+oSf1WhkKt
 /itzTKVW44WOd/TSlFEtZ4CkKdbk5XnM0uqK4ga3Y1Tacm9lLoVj6ZkxzkBIzPl2aB4tMjXr4kl
 OEhhs/VdrNbgpcgDYfRuNVVK0k2Sdy0Ud1ZBADehJ1DWKaPziPtZIJ4WU+efRo1DttRWKimDPf1
 rbKqeghSxAJgWAweD1vJO1wEIvTQ5TLDLhSB9uIXpcclox88mgl14tL2TgeSsyagiKxiC854MaW
 F0G9ffEWrWHz86pBL2lnbtICjsGjjZaQELi/nDnSf5XvvpDHsM5/Irxd9+t4b3VUxSc++r2/uhG
 qLGcgyEal/v/q0DKzlg==
X-Authority-Analysis: v=2.4 cv=ILIyzAvG c=1 sm=1 tr=0 ts=6a393636 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dx2SfONCXZg6tt9xEGkA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-GUID: GimBfNJ4LgREVeDF1mQDnNsKGxf9Y-s5
X-Proofpoint-ORIG-GUID: GimBfNJ4LgREVeDF1mQDnNsKGxf9Y-s5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220131

CCM builds on AES-CTR for encryption, and the crypto engine stalls on a
partial final block just as it does for plain ctr(aes): a payload whose
length is not a multiple of the AES block size leaves the operation
incomplete and fails with a hardware operation error. This was caught by
the ccm(aes) crypto self-tests.

Force the software fallback for CCM requests whose message length is not
block aligned, reusing the driver's existing need_fallback mechanism.

Cc: stable@vger.kernel.org
Fixes: 9363efb4181c ("crypto: qce - Add support for AEAD algorithms")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
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

