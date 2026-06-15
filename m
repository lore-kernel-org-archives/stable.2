Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D40B40B6F8
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781538632; cv=none; b=afWj/mcUj4bYeu5KOwZUgWs17TSSSq/RZFT+nZ8tFMptfgPrUDxGDukGB5GdFHuUE/4b6JsrSpp/EsKOH40GQYz2DXuL9SKbtyPSNbHRm+7BwFBaQ9jhABtRPI3BUcXb206/+tn97sVzWgo9Yy8FSSf/0M1Zjt0Rbl5vcoS6bYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781538632; c=relaxed/simple;
	bh=p2lkPad7k8iHoVjbfy8gEFAEKYRKdaoCK71ypvf9NhI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JhneIJ9voZ/V3cNJRMCx3ozFh+HjAUo5anDPm6NnOZOpSwubWBjJQpKC8imckEP2ZzldH/kaydRbjRBoifOFP/tHPNbSinD0yErnb8+14h1G0z1fXPrzPmLAXNrs3SufRmGr01vaEw1qto2ndo7pJsLpgu33JZh/udOJQFk0sfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bGvvymD2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XAnwx9Ol; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bGvvymD2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XAnwx9Ol"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFhRQs449172
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3yjUdgaJbaFa6PDJnEExmCea7RaAxdvGuHpd+tJjd6Q=; b=bGvvymD2W+/OgvDh
	1SiV1LivfAMR89G4fHsisIaIefUdxzsnvmcIIT+X4RkTLra6UVIpew81CT8q+jBP
	u5I+3lhqFbzsi2MjpE5qSgU/Yyz3Zu8SScJA1fNA++1zz6qhNbBpq0oqoXfx8b+X
	lrJvxbbPd8cY08ufNfSDDsaNP68Y41QDzakBeCciVsGeEbK1WwXIDIQbhHbfqV1m
	72LAPRUqZFdcXwU/UcM8hAFkS66cNOxZFTTYGXedDJZa1g5hbtj+AiqdHAopK4Ro
	sbf0FfqHL3fI0e68YnQ0K2cdsZnCWp0CbLzUKgdHGzcP3p5maaSkxQDLG+7o+svC
	HDMELg==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etfa71eu1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 15:50:30 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-6751c50552dso1449673137.2
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 08:50:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781538630; x=1782143430; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3yjUdgaJbaFa6PDJnEExmCea7RaAxdvGuHpd+tJjd6Q=;
        b=XAnwx9Ol4Aws+YPbUwsXJx3EALe9MdnjIPBLiiHUcwhg7hJ2s8hstruvzIYLnD/Zoh
         y/32dKBiozWbSiwMo/MtUnFAMRnaH9c7JfxSGWRHXYYm22Eyje3BPOgPAwFzyYV07woN
         6VnF6HOVhfRrlQhztisKaSXa17aC4elUneQiQqfVH60jg9yWILnFDNk40hkhrj1N3miS
         KheMkiRL8HG/VVLDeOTm8F2CgV1NufKvDPzWp46f9IdILtBr7o5mVqH96AQmXh5UMRCO
         DuJstKFEtprn4kIKnZ+H4srdHL63ItIq6VOXkGp5slPwyez3a+YX1x4YAtBKyxti+Jj1
         vTxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781538630; x=1782143430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3yjUdgaJbaFa6PDJnEExmCea7RaAxdvGuHpd+tJjd6Q=;
        b=HBdeWGx1ubMMIaoikCE1kMsWP8pfydFV2O7N4VyQDYmEX3ia+IDAct/xLmy2PWznmk
         8QA4YFF58IEvr9yPAkQvFQgZyn8NuporhSo7PQdAO810UxR15MKs7zN+o0TRZYr17+bW
         PJTxeW0IUY8x5s0ypp/pPl29MMXuWPYDAk+LIv4lxlpiqMDutsDjSiD3AueDR7iIUGu5
         lnx1pIQfMfIlfNFJPsodmZ4qAC8VappolniNreWu4Qmjj9eLZHrErNipBdU3Ij9rNEG8
         7o5E1veX60ZpySTh/BV5g2gntopXkzOKsNfB6KpRrWoKUdVPAYMDr1oqWtnJZlV7HFXj
         f+dA==
X-Forwarded-Encrypted: i=1; AFNElJ9fbwfE3V6XW1CRC848oYrGukYlthXQQ1/VW1T2nV5P5I6/SPAVsunbX3Y10v1W9wY/sn1QRBs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjLiZZ1Zf9ljzRP2bkVr3IMq0itKxXjkeSadhG2WllyxufXeg3
	+cgJWfsBp1l5ZSTCZpFmqHrZ7eFxlzpOAfY6ThEfOqkRCzh2Ogiz0k1ZaZdRfW+Fks+SoARdIp5
	bhhP5sJzi7MECepRAmb9ESruwfHXooXT3C8/pBVWK+T9ptzIrC2Dd/5dT+y8=
X-Gm-Gg: Acq92OFkvPapZUiGIKDWIO8khoofOPUuqur9DfnaXzQ4ay0Mn10btRx+5zDmVJ8L2qB
	mPWGym8bso16UDYusa28iu3GcfpDpk7Gf8ZGLYeYDxV10nN0ZD5orx8q0Y8XetinuFz241Nj/Kx
	6N8U+fBf6vz+Vf/PtI5bJzavqJb0HrpFrsGnLGouGwrVyyUuAw/N3YfgYKMd+l9ujXRG88kYGz7
	s4iMEgMeYGfk9t6T3w8PsZNhCi6ENqCmLVLDcHt6K53zAzwmO6cUNvGDkNjTEBbWTMucT7+gKc0
	Cvlk9YxwVuyU8+0+H/VTqGCiNSIWoEMg+b0X4tOsyi5pYczdHU8qbYSKQWmZ6rNCoO/PQNxjq3r
	wi6RWvd0kSHXr1hKbpvtutuuYkHl/YQd6JQBTXsSqGLQ52nb4/5A=
X-Received: by 2002:a05:6102:5809:b0:64e:32c3:1371 with SMTP id ada2fe7eead31-71e88ae97edmr7413224137.2.1781538629724;
        Mon, 15 Jun 2026 08:50:29 -0700 (PDT)
X-Received: by 2002:a05:6102:5809:b0:64e:32c3:1371 with SMTP id ada2fe7eead31-71e88ae97edmr7413196137.2.1781538629266;
        Mon, 15 Jun 2026 08:50:29 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:7fe3:eaf0:5a0b:2610])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f26f450sm38643032f8f.10.2026.06.15.08.50.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:50:28 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 15 Jun 2026 17:49:56 +0200
Subject: [PATCH v2 5/8] crypto: qce - Use a fallback for AES-CTR with a
 partial final block
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-qce-fix-self-tests-v2-5-dc911f1aad42@oss.qualcomm.com>
References: <20260615-qce-fix-self-tests-v2-0-dc911f1aad42@oss.qualcomm.com>
In-Reply-To: <20260615-qce-fix-self-tests-v2-0-dc911f1aad42@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1705;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=p2lkPad7k8iHoVjbfy8gEFAEKYRKdaoCK71ypvf9NhI=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqMB8w9UYBQf8k/SKnm8wmtOfEsV351SVcyOtam
 4bNoNgfKBCJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCajAfMAAKCRAFnS7L/zaE
 w0jPD/wOXCxa9itukT5y+o6hvqPIfJ09Oq6s90WL64CIcIRsLBuAlO1zm2uYbqKJNOhM0moWCQz
 OLkWL31iOZIoln+fCaCXfyugEeHsiALFzQUAXg8NMUbJ1HyGsIQRLjCQSe0ygxVC8mAUKkNDn8+
 6RONM8eYxhuguf/k8Ycejq1nHHCyYrr9u8hWnyyZTAiLtxAFkKdk3HgNQ25T5qmbdMKLGNbon3Z
 aX4fi6fP7vn19p/DwgZQUfu0ujf/X7LXopo0JVgjIRw8F8HONQWn1+NnlJQeC+fm0MTbF8NBT+/
 hdsoXzH8Vm6dGNRHqErbnYmvXFuljWkQBJoGbeQrbEUAocsWBwaU7DpOb/jVwsNCKG7XHDjyh7+
 LW/9qRJCU4guinuPzLRdkA0CSFx50+a95z0/KU0qJspftAp9VJMhGMANU7SC4yC+m97cNYery7A
 7oJeXPJMI3YcMO6a824zxEgs3OHl9ZqMEeCPz5gKO6ccGCX0vf5Am7WLNij00CsOotTZFH466Zp
 H2bz5ihj1ADsX612GABx3EcuAj7kSZHDcUtxJKqE2NJ2IXfoB841MGWHnIn18tht+J3zZrUvZKU
 /4fWeF5AjYC4WjPHyj3Yr0q3AfcbcHlS2XIWufxG7l/v9Yv0izNOOcR6cCSb2EjeFCepDZ3FPBK
 zXHIS2gHmPCqFow==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: qqyptmKMCN5qKAfEJ0QF_D4QiC_uwRjr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE2NyBTYWx0ZWRfX6+yg9rJGGbpl
 Y3kYBK0r8+kYh/ofSuNIf+rflDHRCOmoFRjTXeFc/m5c2c+21qxNjGWJX4cjEpnN8O5g92jHt6r
 nHhT/m8L6cM9PLxbs8esABeSQaUFDVc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE2NyBTYWx0ZWRfX6wTsOaMLa6U2
 5y9J8d8fLRLhgsckr9FqALk2INQKg5+rsYMrKZHPzN1c8syDJifo5n7mXX0ivDCrSVqimPQnQay
 dLOTbFSb/hsltIXTLihOgXuPZSXJ5BDDC37BJKS57v4TSVZbdbNnyY4NEkJRBDd9kTHtQcAd0Uq
 9zWsdNAm2Gcqa1wzPFJIJKx4WGjbFc4XsDpLSE2yolAtZrnKUVNgxj1tsPu5X5vrpZQwMTjafun
 vnpIfJuNQ0rzx/AJlRDD8KxooaFHXIi/41asBjhXqPiRKtvUgcf9rk75I74xDdSCzJvCDYFzir2
 A+l9cFuPcdK9/Pb7thA92QDchpdwqTY7YZYk/g8vcmOntCh6lZJgeQwfkxegGyQ4/5nmCdCvcTc
 XPQpY1hcg0AqjunLRluB7TiS3HdsxP+3L0xS40RCNB4XbHnoPKDKJBF/ec1YzIdM6uoDcO2ABjk
 y7EKzg9nra6ir9sZaDQ==
X-Proofpoint-GUID: qqyptmKMCN5qKAfEJ0QF_D4QiC_uwRjr
X-Authority-Analysis: v=2.4 cv=AN2yTM5Z c=1 sm=1 tr=0 ts=6a301f46 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vUpbTSJP45I4i0_vGVUA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150167

ctr(aes) is registered with a block size of 1, so the crypto API hands
the driver requests whose length is not a multiple of the AES block
size. The crypto engine, however, stalls waiting for a full block of
input in that case, leaving the operation incomplete and failing the
request (and the crypto self-tests) with a hardware operation error.

Route AES-CTR requests with a partial final block to the software
fallback, which already handles the other cases the engine cannot.

Cc: stable@vger.kernel.org
Fixes: bb5c863b3d3c ("crypto: qce - fix ctr-aes-qce block, chunk sizes")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/skcipher.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 379b45d2cd952a39c387e84af71238b53f7737e9..cf34278da30b1ffccf230ed194faae2352cb8550 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -277,9 +277,12 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
 	 * AES-XTS request with len > QCE_SECTOR_SIZE and
 	 * is not a multiple of it.(Revisit this condition to check if it is
 	 * needed in all versions of CE)
+	 * AES-CTR with a partial final block (the CE stalls waiting for a full
+	 * block of input).
 	 */
 	if (IS_AES(rctx->flags) &&
 	    ((keylen != AES_KEYSIZE_128 && keylen != AES_KEYSIZE_256) ||
+	    (IS_CTR(rctx->flags) && !IS_ALIGNED(req->cryptlen, AES_BLOCK_SIZE)) ||
 	    (IS_XTS(rctx->flags) && ((req->cryptlen <= aes_sw_max_len) ||
 	    (req->cryptlen > QCE_SECTOR_SIZE &&
 	    req->cryptlen % QCE_SECTOR_SIZE))))) {

-- 
2.47.3

