Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2A73FAE0A
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303643; cv=none; b=Za+eC/FcCUVjH7sulA0C8kLF1rv8OcBffdpe4T5szA8TQfulUoiswIXwaHhoDviH3OuWV4/1zzXA5/XXEOqMu+DsG/Xq5bgX8gxh3LZJhE+UIRUKOxXOcyDcnRJ6KMswTnLgWis6NKaGcwKJQCLxyKkOAlWhpTkMhJ/Sw2fPRZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303643; c=relaxed/simple;
	bh=c+mrubN7rsfOnXUrhAmKfIPiEiFtp1qvBtE3BukFaZ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mRq6V5PJClDtpu36yw9jGPIrKabwclivW9OmXsKeilS+FLwpXqPtZU/KlCWcUhTK0mv9BakRUWerwZuQRvF3KpjR6b3yq/NLjGTS+zAjhNaABSjZw/zHClGl42vrXs58qfKNMppS9dOk/h1crTlgUha29Oa/4VOVF5DwXhkRS8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CZ6a34Wi; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=L3CC+iJ/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CZ6a34Wi";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="L3CC+iJ/"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HE8LoS2123393
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:53:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	su379PS4fCpra/SUatLozY865KIfA6SXq4/i5am3Thg=; b=CZ6a34WiUw/WrrZ1
	N61tgxau6FXPk/q7pIv+pdg8r0hthARXrJURahnhsibXj26LmowiSJ0By71s8Th7
	jfOHtCL05JXqaP6lAK+JekQ73R37CQoNF10yRJtgp4WnoKMkaobF2H5k6iC3iQ/o
	zET6TppVxmqlh87vB2T2qwhSh5ZNkkU++kE3iN152IP/aoiIHq73TsqUsNvDDOhz
	JHMwPM9sigvU96np1ZbbbHQWyU+ASHWWeRqtAUibDq55cPdFO/TcYpKuyRjwMHK6
	1e51lF1KPgKb9T7BJXZJrtHb0Y05+YOKaR8wxbL8tEv9QgNBNabmnGnhPPwqH04o
	7GkVLg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffe0utg1v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 15:53:59 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0ab07320so91658351cf.2
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 08:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784303639; x=1784908439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=su379PS4fCpra/SUatLozY865KIfA6SXq4/i5am3Thg=;
        b=L3CC+iJ/0X1zPuom7AYwanzoc5Q07W8PVFzp6pS3cKQH6kjEO7Na0VNaId5EseEuCB
         xdXNDQxKJu5xneMQYn+Vtn20q71pSQSeR8UbUbGcsiCw1hryi4MfPLJ51DJ70Vq4kbYN
         IlsTC+9vBwX/4VrGHuzpZn5zEK5qYx7iS7uHIFDzJ28xPtRXI4kD9feTDsTwyCK5ldV3
         spcR5juK6Cq/c1tMa93aJbXN2mbtaJS09Tp4pfet3fa3crKgT4oF13AY3Apvc9TDyG8P
         hdsmt8q3ki2ImCz6DImx5xOrq2J4uj+IvL0C5p/nd19E+GwO5cp9iOZCoBt1ZPpsL5lh
         3lNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784303639; x=1784908439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=su379PS4fCpra/SUatLozY865KIfA6SXq4/i5am3Thg=;
        b=kL40v0YhDv7d5KEbtc/qs9Q937zMYWHK58Wl4tTquIa2WyQqYEd9OMOcByKUUM3Yx2
         XWqJInDMzyjDYu0nihTHUDHYXfjqrY5SNv0ezrqjRPiY3yrUNwteNgqKF2QqY+EvNKVr
         T4lUxX7TwIZPJdv3Dp5kwSEW91AUrmoI/azfN4Nv1VOXcVomt8EBsNVP7YOLGAP6I2Mm
         x6xEy2mrpnFQIrtntvIcroYwHXLM6sqTaR/c+/8F5zxFP0fSMGdwf/VQrNejVft6eu/r
         NPVeHGUq+zg9uJgAJGiSL6QFmiar8+4H2RHZSf9JEH3Kv4AckCsqrIRc8KHnh6XC5hRw
         nEeg==
X-Forwarded-Encrypted: i=1; AHgh+RrmmsHNVxDE4JtfVsqJIH4YK17mHHw1AnDmWGNVQ/7BHvCbHvXNmQfogu6Zbp2BNlCQ9FlNjwM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKGb0ymvpIyzI9idt1zEn9QbUuqwylpcN0MqjtwUj/wJL+hSZX
	EG/6mR/U0CtrCU8SmfjrZ7asm00/TaKRtlBr8czzD/uiO/xO9kpIy6KsRVXdjNKIL+n51L6ap0h
	DpJ3xs0u/zjofp2nMx203vKSmckPRdpkLBDnISNDABbt0Gwxr20PsmTEf+Vw=
X-Gm-Gg: AfdE7cmAAEkPJUqsWodNiGBTHTrK7zz3YTDIJZv0AqGvtUX1XRVJH/F/fwk1kOMENOp
	HcdWq/G8I0fRNlf/mYpwGvwIipfxo0Zd3UBy7mfu2as/b3TeOtsenO3Ch1inos+DnyQNgzMLomD
	UY2I0WOibPgYhxtBq5NzADwVH0sJsFXC4t3cIzZqDi9crsXe5Jve2Z+TCyvtFpxt4ZlCcJug88a
	efWdC1DmByywsg+M1uHTa0qHrgaisBncp8VgLXJZy41oNIEGStEL1zgDwubH0QGUFfgMVXguEW7
	ityh7eRQLtEeec1P2DREZHKzCTcQ3cL5N2W+0Cwfw39tXfBCZK0ArjU1lsofj2RF/GVE1FcCzzy
	lwF6Y8lXownvSAk/XYlwGS/CKqXNpug==
X-Received: by 2002:a05:622a:c08:b0:51b:fcb4:7576 with SMTP id d75a77b69052e-5213aa6e50cmr27491191cf.15.1784303638595;
        Fri, 17 Jul 2026 08:53:58 -0700 (PDT)
X-Received: by 2002:a05:622a:c08:b0:51b:fcb4:7576 with SMTP id d75a77b69052e-5213aa6e50cmr27490921cf.15.1784303638195;
        Fri, 17 Jul 2026 08:53:58 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:dc44:5b1b:5396:79d6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2a2511sm47057095e9.1.2026.07.17.08.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 08:53:57 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 17:53:31 +0200
Subject: [PATCH v6 2/8] crypto: qce - Reject empty messages for AES-XTS
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-qce-fix-self-tests-v6-2-455775fe5f6c@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=c+mrubN7rsfOnXUrhAmKfIPiEiFtp1qvBtE3BukFaZ8=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqWlAJLk8kf+WO4QPge6zzsH6iLkYm/a4I6uEUB
 rNcxsO73RiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCalpQCQAKCRAFnS7L/zaE
 w08EEACNbC6vHABktCcrqSfMiYaJc6A+6pG66OGWUFdrHM7aOGe2iQwkorloHgWFT5SCmPQoQQe
 3Yiqy1+ewkNYT3hUZIIc/5TB252yq6PL92CZGpNLDB3jyR3OX/m2XU16Dg1jkrDhEyUuq3BbfR1
 Iv2oOUkByizuoYqiMcJjwIk4kbKwKJ1Mr3PEakYaNNCiePr4NhR7Is7gsjF9Li4muP5BsaaK5B0
 gp6n5ty2GyW7HFEI1Fi16TLsk/yhgoR6OFrNiMz5eXrUw5S/k9CpzjS7CnjcJQ9io0c9Yh8QU/U
 wpGjSFGU37L/2dfozPJc+cUKOB7ZfgEivyeyH1Znua7szBunnLROQI3TWTrV2oQU18kbMt+EyIU
 48NS9NgZAStB1xiAQgtbe1ElOj9evZ76TqRPVdZuiaJ70lR5/AZ9T1kNjWyPk017x8YI8ce/3Rq
 Ezxk0FZU96CzWaEo7QgoCMYRI73WqO2lZB0rLGuqEt2UdWqFUjKD4t2pc9tJoQ24+HD0TWVF+b2
 OPlK7cy8skUC9DR0vg5+uKTwaTC/BFM2CP1qhkJIDAVU+RFbsnx52wgt0ktXlmqUIF5Tr1cP4+v
 n+KwYRFbxSdXFAXFUGoxACXWUNWVv7c8aakCie2VZxZUQn+QprmhyUgTuiU7w6E4U4PLM/fjuct
 VGupaDD8FkAt9kQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=deWwG3Xe c=1 sm=1 tr=0 ts=6a5a5017 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=kiYxeA6Iecqc4QeK3QQA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDE2MiBTYWx0ZWRfX+NQJu0/uvptb
 XeOiI9ui3+nqBJfCY5ZuUDucKuGaDbu27AnI5/mO9LRlZmvdrmx6IUxyEwNEccGcnmAJ5jpcfYI
 3t+OFZFtV3yu4wx+f5PDI7Pb547avgJRoCNRNqNFtlB6wT3qw8FrVuO4yt/tXEoLp0T8hyf5zsq
 DOTIjLFq80KGQWlMWqLps/9dONPk136wJ5vevcCvQ/PO1me1osnir5KIwgdVGmI9L3PxHGW7/rY
 M4LOr9cIWMen390QuyjzCEok84HNUWIJkBAiSnJNEGfmrRdRQTnmg4VeZBDNfXRioqBQDB7VIVe
 1GapDBbIUXK8zUNUJHVAXMdqbqWLh1NUwJXgksqkP+d/NrJzGROxMxLaFylnVaVEcyOOsNKXFLH
 SWybE69ZNEblv4od+3cXqTOu+LfHZW1ertTy/CcgSMsGBHBKDWLNgT7CKVMrOnpnSuIifXNrhzF
 szJWr/qwABZgdsPkPgQ==
X-Proofpoint-ORIG-GUID: zGyb0zWQ72tcWfkE-4pu_pSRyzagiyAI
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDE2MiBTYWx0ZWRfX95PM5J5PFAEQ
 fGYHoVTDj6kzPN4a7xBmfv29k1OGrQVv9tlk+HR91ubYjMhLx/zkbZoxS9f2qX7EpvTeLyKiQA8
 m7Y7Nk2c6dftG8NZdPK5huqEk7vT5QM=
X-Proofpoint-GUID: zGyb0zWQ72tcWfkE-4pu_pSRyzagiyAI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_04,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170162

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
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/skcipher.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index b27008ace93a8a40c291d564c3fb9d73df5447ec..e1f69057607fac36e8b4bdb5dd9e62a2aabe5f50 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -223,8 +223,12 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
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

