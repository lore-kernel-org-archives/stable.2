Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B52142FCB8
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303653; cv=none; b=MRTZ4UY5mCMRvXxDuBO1TFOsvyev0JdvJMaPSF3bXYG32D5tx+vEj7TZB0aHnxZOAvcBNCple6XwfkneKhCvL3XnGmudJerulJCCQOAXCWtf9hifBbsmfUWMW+Yks4aNvpXfm0LPX5dDpDm6n65hctm6ER5szaWeOJD1VjEvWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303653; c=relaxed/simple;
	bh=Ejq3GCF3ALDtojefcexMkYFTMI2wVEXKIrBlhj81Swc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D0FhlSg95wTkx2jg6Vn43bUN1lPP2Aes32mjlRhr3VwApTlBzXxoEnWsnVkLGst/31GnTZeEkMLsUpFukYRwRy8o1CBYG4jd1fJq1nXN/5kF3CdgyCpHkJIbZoo6g4SUX7Gy/NFM/sQdPu8yW+Q5rBgopXfFWAo2kxhy8GIIDcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Re1956Jw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=hzF6FiwW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Re1956Jw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hzF6FiwW"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HFD6EL2126584
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:54:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EagaE396zMSCowVPFT/Lv2P0BLvUgaUxoxYWM76TMv4=; b=Re1956JwAckyOO7o
	adAI0amBabVaNIeGGa4UbKyHrNxHxhWnyGdw8RY0NGfM7in+VQsBr7IWv6ZTwRD+
	KxVFEnzjgBFmxeOCa7WtVt5BrvNFh1DZdeFmmnT3FUXJb8RvOSI6BlwsM7XvM6qo
	wIo8QLHyavTqHzoP4T9sfDK4fbLlDUTWz/nof5UdXhzBg06DAxaTIr5Bl2cGc/6m
	TVVYSDh/6zz0zOATU3jLECb0z1mqRHDeTYfr02GHznEw6tz/pMVGVYEhE8QOwaJl
	90oFrQoO8e2sRvJmwD44Wj6IyFiNNsYfzDauJuc00t7yedhnA3w06lPef3HsqAJa
	xbaipA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffpug05hn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:54:09 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c1a97644aso197320841cf.2
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 08:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784303649; x=1784908449; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EagaE396zMSCowVPFT/Lv2P0BLvUgaUxoxYWM76TMv4=;
        b=hzF6FiwWqH550MyNSHqui4DT2z9rmk4DpbcwNSsFkYTsqq31+eLH7H6EpRUAqOOGyq
         XNzCBhh5D06+b3omxl9MbpPdsjs/xe3I6R3PTooWMuwm9VwVmv3v2U85mzLGXVPMNYpg
         9P+AhO5M+wm9kG/aBTWoiT+RplNPjEXUiqhEMYmVu+MFqc850AkwwlzBi6awB7sj5X5n
         1Tg1OhR2xxLb78J0Uq470TxDkV776jJVFbHZOzy2eIQk1I/6VQwfMqLsJxmlMB/SUy1x
         Wj6r9xv7EmRUkYUlDrDHJoYyebfQbPMPQg/crU2dHOt2Su/0skttjrygjhV4dZsEjNOS
         swGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303649; x=1784908449;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EagaE396zMSCowVPFT/Lv2P0BLvUgaUxoxYWM76TMv4=;
        b=GIoD0KhqxDFB6fqn2hhe1aMrRWZ/yv5u1xXbntZguDtddv2GCKPfNazfqt7o9g5Yks
         xjlskACvQq306X5w/iwcbkMrk+emp11d7k3KA+1Nj2szLHbafclLt2LAnkokNdTs17hE
         KP6kfvD1z/BWVr6cJGHFVvWeBuNfx3eVvrWpKs4S9X9jRUEwgbL6U63I2q53yi3/6y60
         ffnEQ8DTNSVHp7AVOkTFRa907UmYAtspjef6OLHlRepo+8Rk1iT/SABcd+xp4k45NQJm
         CEBJj9G6Xp0qGH0v6tenVRfkDrmVpXCWm5RPI2HeXIsSFeAs1CeBan+othTnuXgFG2hm
         s4AQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr/ChIscog5uc7pqwIAx6jYQGcAl4YOvZOhYNyRWfta0P33P/+uwYO7hOLrO6XtgRZRkq/ANfs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzZsWMnQIIrwpmmC8BBVA3Ow2VMlBSpcDfToC4kYJbWKldqpc/
	QudACW2rV0EcJGes3/tUFrvJOpxZMrY7XLVfrl+6ozO3OdYb9dbENkfNly4MtiSCBj+dPSqbYHt
	tHEliJGRm/jmiU3GyCNkac6B5BsOJWp/4LmdVvRr2x8It3EqRMa8InMEUNG8=
X-Gm-Gg: AfdE7cmsfVWYoUYuRP8DW4Glsqz//H+UohkK9jfygIIubuFkT/wx1OJB+oaLT2Gi3TS
	ezCXeZZ/qHG8GlSU40fLkYT7ldEHycDFqdr7vdshDhWc39rlsIo0KWvVfGdCJaV9JvSE0KcnMsv
	HXEu6rC1sbP9BAP20rlXlLFM2e4wxTR7Iqg0gDrwVN7DXwxmgs84F7hS3C/iHnFUYvMquYfy31a
	WK9hCo4I5dNcyVFblf2tXN9Kg4GNKoT4RftoYjX9/M1HQRozLLI88i6RrcScTm4aJRMcyU3LvGq
	G4GJkcLYBayrleLAL45rmVfzd8IK/+/66AX5jQ2NUjhm9nM2afHKoW+Tr1R7T8a+F/fpIPGBHpt
	wA2K3A7PnqBhhUN5gQBfxL8aQIY5S3Q==
X-Received: by 2002:a05:622a:1825:b0:51c:10aa:9cd with SMTP id d75a77b69052e-5213cbdbbfcmr31141171cf.38.1784303648746;
        Fri, 17 Jul 2026 08:54:08 -0700 (PDT)
X-Received: by 2002:a05:622a:1825:b0:51c:10aa:9cd with SMTP id d75a77b69052e-5213cbdbbfcmr31140621cf.38.1784303648115;
        Fri, 17 Jul 2026 08:54:08 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:dc44:5b1b:5396:79d6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a2511sm47057095e9.1.2026.07.17.08.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:54:07 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 17:53:36 +0200
Subject: [PATCH v6 7/8] crypto: qce - Use a fallback for CCM with a partial
 final block
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-qce-fix-self-tests-v6-7-455775fe5f6c@oss.qualcomm.com>
References: <20260717-qce-fix-self-tests-v6-0-455775fe5f6c@oss.qualcomm.com>
In-Reply-To: <20260717-qce-fix-self-tests-v6-0-455775fe5f6c@oss.qualcomm.com>
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
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqWlAPaFTiZJIikiS+XIqgLGbRUYSYPJnKjbz9N
 KdPL6DgEn6JAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalpQDwAKCRAFnS7L/zaE
 wx7sD/98xG5RZf4PJvVVfk3S7ql5N3aOH5ILUH2o3aR53LkEfo5TM2M7sH5EVQNWK9j4vkTFNVF
 /GO77AUPmFfCvpI5sejifI9saF2+CkDeTpKnAfdkLx7jdodVj7XLLIwqNoI+F2QrCfJL37V0VKr
 fzU7+84itQjV+VMgcFrRm3K38vr1TY1ThxEgFa5wcaBzltqPVpBQn8Pq9k0YgUUL6xD2TxA/Dpk
 A9MsFidVnUzV6n1QBc0hPmOyMlIvzRIMsHU/7EvqkTG8Cio5mdM1ky2mluMBmIntRCHrFctEZyU
 Kx3PBv6jxv2EWG3P72HCLEg8vUAQccpnMW4iwjDE6KUI8EQaHiMuDmUpw4zKE9iFbKagMGN0qUW
 kHGJf16hKAgo/DCgVsYNE8FACQ/ZCx5EXqXXNLTyegjRq1Dft9W/RXSDHPB4w2UeVNYuNs1XbXY
 3uIak4BMu/3m07FmtCYEKeizDrzscV1iBZrdE9QRYdyAxxQJDWW6ruosSHH+dazDoQa5lywFWr/
 rFqlhNYcqkEmgPfs1qKJf/YNHPLhXBFVskSKjHVPPeTCIr4pdefIAi8e+FKDPqqfh3m6M4v9kUP
 5MbErzwEAnaqtZNLbh/NdpazUmpZzTMafOm6RzyH+AkCBHJSnloppqoWD+K3r0sabnguUWUV4lz
 dZv3CQl1zZQ31vw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE2MiBTYWx0ZWRfX9Nc5L1otTyrN
 BC8gxEJYLG3Dp+hH2Gl8ovYugJHJ6Y2m2aijENsL9keY1el7lJip8sPFWpkAec3rD2svb1n2d2Y
 WGuJnVSb6hKDvRb646u6+wKrdjjFTU951HmPvkCZhlEr/QjM45UpyI2UtbbFszaLWRoCRUE8+Xp
 gXQrDRX9850Z79JsA6X1wosVr9vptKnmHtEgQjJLjmiqAC/bP22rJ/ECRDnnYuFkUz0q8lmLAjz
 tk//j351AZ/JqJMUKkNgtt/taTyBgzH+LUBUU8FeoAysBs++Zb+0cqBrabR9x2t3T+Y/5EMAYV2
 Bu4lj351bscudlbVb31Bv6lFE2wcK6dW2/2ud2dU2v4y+WJULQzxGOEKZK/HVATK6NESWpaV1c3
 S62y232YAC2QUPgQwNMXYNVjU7GRQSW11FGIH7UYeHsbjZxTTrwiwrmBXhjBAbxCxr7m1Cb60qL
 qGv7xd1tSb6fvb1nKrQ==
X-Proofpoint-GUID: oLUjSVC8BIHRDf9NPTd6h5waEIPLMX31
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE2MiBTYWx0ZWRfX/rc40dghKrgC
 fRRnP6ZDPQdAodNSx2QfU5S+mSaAJxDFn3GRVK086T7bpI5rdBU9UBdEGAj2HUsZxqeOWlNNd7E
 A+7kt6Na8g/74E16FqAIfrKkk6NqwOE=
X-Proofpoint-ORIG-GUID: oLUjSVC8BIHRDf9NPTd6h5waEIPLMX31
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a5a5021 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dx2SfONCXZg6tt9xEGkA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170162

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

