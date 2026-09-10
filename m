Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B171D489FDC
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045287; cv=none; b=bMXgIeC820naxREGxSqQQ88BScTU/seH9Q0naatVv/iFgqoG89WIsguiP24U2KVPtHMFnLAKCrJEeWLv3YM5cIf9pVfW2RO2PgysRN2HwPJUY18p0gvEs4vb504J+cuVWOnKHzZAeCltr2c+J8ih3oukCFTzF+TggYKYBvJ/uGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045287; c=relaxed/simple;
	bh=fiubGOpznSBlWjS81EhUbY8+Jvg8mdIEbz8sZifJeJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z/gINpmOVm9BDO9QR1jlfBHuEHI4ShZChsPvhCZ8vWzWS/Gzcb9mYwfQDbeVVNPqqe01kRvhBty4EnY+MynM3Tu7aQP2cNsG+iJbHJKcebFtk1mmxMtPnX5kn1AF0CMff6DdMsncBCife9rMrsLU2HfhAbiX6y6vYnl9qv8lphA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HjDllPDm; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KbOxQm9o; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HjDllPDm";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KbOxQm9o"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AC7hVh869072
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:01:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	skjmTwe/2/9vsGC6HLJTSQTIY2ObikwZKwuHsPTlEzE=; b=HjDllPDmBNjrJIYe
	PCoW0BPGw4s5pa5PUZRjEHfunhly70NromYsN6NVcF50TxSaDUgnVbBFVC/FlkDz
	RAD0qXM2FEKgshz+fwo9kd+z1aiI5TLWdYJoed7fth2bJRpUi1LNFYXs4TC+JIci
	TIXU7YVXvQqUeXULKbvcXCqkikS5tz5feAt9hfcpQu5P3lodTWYg+QYlDSJO3a3T
	REq073oR8EpdP5+4fK+gwFgpQoPF4Vczvsm3YWC96UburMReAVCDEa2fppED0IZ/
	EjaaThXAvDAtJ/r6C4wqGRlpEIyb/a6idBxqdv8E10LXkkadeWYJhobMAx/9zDAe
	BCQqQw==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyd3vkx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 13:01:24 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5c7ab4af214so1930092e0c.1
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 06:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789045284; x=1789650084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=skjmTwe/2/9vsGC6HLJTSQTIY2ObikwZKwuHsPTlEzE=;
        b=KbOxQm9oHcYtnrxg4IHZqi8dhK6QM1e4a7JWH+PgnMI7PpSR+S4tdzrlHXoFIWNVpo
         u7a1dwbble3C7+uRjfP1EnC20WUSmR/bEzx7sbUDP4MVSxa6mNc7GGYkyEXzCUwy2xyT
         YDFsc5stUln+q+0ppA+Q79hwDRtT8szNN2i0yQDafMNyRzazJZ7Eqp1rFd+lfuDeWHor
         MH7qODont2DfOiOGGZ/jANzpG1gM4/nbIHdvtSm5K4VUT3kJwEEa6a2NEruYGDO59tnG
         29NKiKt+444Y7/BAeegGL5Xm+KbJLUNFAEXYnvyrmILK41mFCyCdU79ZRCq1QYQgamRj
         oxzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789045284; x=1789650084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=skjmTwe/2/9vsGC6HLJTSQTIY2ObikwZKwuHsPTlEzE=;
        b=L57kA3q9Nq7FiVQutnE3PcX54j42mhqhkvBvMwDVa3SXjSR5UhdGN/ctP3lcIGpmmR
         OsuRqOUJ6bwGj/vX9J7MIuB/P9siVZqDQg+9KywyVM8D8LZ4WPIC68NFhPa1eAAqgi1x
         9rvAhpr3cq77KjhIvZJfGhS3I82/T5aQGogfMPJ/jeyK07t2tBZrYmBes0bgtyyaW+fb
         TBn51MI11JRf94tkV+dk4K0z8wBRS/L5w54GyKJNn2u38Wz+lUzMYlVAjmXngm2Y5pW9
         9N4ayosYfpj5A6nw4YqhlvVMPsnqISOJeAV08OT/u7hHQqvQFXKuEG126yXnj7KSRSPt
         xnJQ==
X-Forwarded-Encrypted: i=1; AKwUvBwN+u27Hnaa8EsXUfhHOu1wUar/V+l3q5iTfMdNGraa4HZ/Ndn/TZLAS0KThtXgJm4KkAr8tao=@vger.kernel.org
X-Gm-Message-State: AFuF++lGU5AQAiGcD3rzCyRkYlveegV+aFxB27uNE3FpSWtiWvraHsCR
	A+jcwAMHShJu2LsogbewJ9uu3uRHeJ6cFzcq9VW03Qo/5ZVO6Uc4XX9GB6FaF475D2Excdi0das
	4UJbXaqEkNh5pJV/PzXuvT6sgoiiyK2SYwU/CsxIBGVGLo/XgrnLCM/cCvgE=
X-Gm-Gg: AYBFou3XZYA5dMDqA0DZmKZLhG3Zzpo8ux23w1gyCmvHPUaO091FRdybOIG/XXv+Q8+
	fQlkU5P9b2GMP6EgqCKt1A2J65kXvAkPQe/q3Ot97chyDVLfrd+I2mW8LceZOaIQOd2lsMkDPHn
	CA5Yvf1bFD7kvcUuKseLps8MQGLak67sBLxoeM4Ljyz2zBzcsPfCDzFx3OCdY6nsalKkbxDB/zu
	Y1MhYRJ+kRiwmF6KmTQ+WEaVnwlOWskBVBIiA7S4p4i4KD5hT8fIi1LPcwFoxE1A/GEdHpjifyL
	9J2gp1yyzl39qOQ4zcaI9D2aH7XbDOmVFBdEpfEVamYE/4LNmb9DhxVHfcaBryNF4jqswEyheLX
	F+lZecQGYGw4BW7LNHp4UbTm2RwZW
X-Received: by 2002:a05:6122:f18:b0:5c7:a814:b987 with SMTP id 71dfb90a1353d-5c7ed298f6cmr2449948e0c.2.1789045283328;
        Thu, 10 Sep 2026 06:01:23 -0700 (PDT)
X-Received: by 2002:a05:6122:f18:b0:5c7:a814:b987 with SMTP id 71dfb90a1353d-5c7ed298f6cmr2447218e0c.2.1789045275485;
        Thu, 10 Sep 2026 06:01:15 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:c9b1:abfb:f300:5e98])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c26204ecdbcsm831849866b.25.2026.09.10.06.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 06:01:14 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 15:00:43 +0200
Subject: [PATCH v7 02/12] crypto: qce - Reject empty messages for AES-XTS
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260910-qce-fix-self-tests-v7-2-cdbd2718af14@oss.qualcomm.com>
References: <20260910-qce-fix-self-tests-v7-0-cdbd2718af14@oss.qualcomm.com>
In-Reply-To: <20260910-qce-fix-self-tests-v7-0-cdbd2718af14@oss.qualcomm.com>
To: Thara Gopinath <thara.gopinath@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Eneas U de Queiroz <cotequeiroz@gmail.com>,
        Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Demi Marie Obenour <demiobenour@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=fiubGOpznSBlWjS81EhUbY8+Jvg8mdIEbz8sZifJeJk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqoqoKcY6VeoV7uAaQfnvTc+CvguzwaEw7NG/Cu
 8SLkUH96GuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaqKqCgAKCRAFnS7L/zaE
 w9+tD/4qzI8NshC9kwQ3NuRh/YcmU37MwUDDOclQjTz38ZU+o2+KCUP9p/TGSWazcK3zGYqD1+e
 +XnoG5b7OAvUhlgWmxZpCJHdm4rcxsX8BNpFbaF7Dw7VE2rgIoT3lF8FpwGv+XilOEb/doc4N+V
 VlwYDiwqFgsO/fW0Xu+Zve/BbPDA3amixlqiD1386ijpScbGs+mmJ9gsyeprV1RBS6XuGfzhLHP
 +EOLCUgRBgjW59Wr5A8hvNSN288iz2Xf/VRWvbI8tzqweRefG+qxbHA+bUjg+5atscpqQRf85d3
 jzAr8mIQ/6YZHglJJg1CmhYDZXHLQWYDmpFORVPdUyReWKLa+IoSEV7GmH5VWFOMasDzKdwzX9k
 ZLW7afyjyAMgtwGrHKoMR01nuC80rYzRmRyc/fivWDbiR0R5urhxfsBLoai/tluyhRp7vXAP7kZ
 7jnRr6Swty2XIkRdvQlBtWLKRW4QJ23ygkSPn+hzMFBD4r+Nm6DfFXzcz6CFwa0rRL/Z/BtLzrm
 PDxT1u6tq32+OiianYYqDeanLAu5qAsv0vCmHdiGvzAbHGF2CV2tAYCvE5Fdk7gUuvewEKu9J0e
 5nlWL7/Z7Av76DKee/jCxCEC7vqJasO6C9e5LQI/hHqPwQ+pKdXbAN3X0+7YcuBDXiVUlWci/Sk
 Rk00/MmhPKktKTQ==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: mzzJ2IRRhfrMR9D-BmSfOwnEV6Qi2N0D
X-Authority-Analysis: v=2.4 cv=ef+o7LEH c=1 sm=1 tr=0 ts=6aa2aa24 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=kiYxeA6Iecqc4QeK3QQA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-ORIG-GUID: mzzJ2IRRhfrMR9D-BmSfOwnEV6Qi2N0D
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDE1NiBTYWx0ZWRfX2hbrCsm8KrZA
 G+j9Qg/RapeRa0aJV8S5DzBHWnGWKo5qZyFRrFzuMSLQ9/VcuioWWHMy2/zfdS+8UX7/wXPLmOE
 AL7z+N50g3P3ejrEMWg5XJ5PKHr5mDM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDE1NiBTYWx0ZWRfX0dpmzOiL3mqi
 vUpJCs5GpDiI/Cd4rj6iS4GEuQmjxVY14ekua1IMQDpozhlW3ZBEgyNHfkJgu9Fkl7i5w+ynj3q
 Od5uxELXSl29zTCMcVcN2WCYX0BvSo72ipXh7VUG4HTum8W+DPvf0VSXW/LHhAHCAdV5OM7N781
 J/5dapxQilFIjrcnWFkeaVtZqXRKiGOEwxYj3RbNSyy98qZjZe+G5ZRSERApoXy/5lYwX4Skp1D
 uwd75dZMnw5Ewy9wyv+FRb5irok4BwqPol3o6iDj7ofUoM0KWurqHaaHQznxs+rAfXO1NkoxGzn
 sT+X+gIsfXKpZLnTALQKpnwQP3xWthhhg3JfHj6zaUPtpPbLI++k6s/6ecg8C9zeaYl7ys6K/s6
 QGLsAlJfHU4xHheX3Vqjywz488G+UJ97dTNmR78uxU9IAiCCIa2MT00lYPNvJxJMW3OrXTBbOSK
 icw8lOODzBGNPluSy2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609100156

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
index 84263ddbd62733f4d1ed42a2b94ae9f4d0d5c6df..b49c1aeb0d27d4798e3e3d0b30299f48ef8ae453 100644
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

