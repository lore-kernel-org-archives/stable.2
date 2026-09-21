Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A691949B5D0
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789995523; cv=none; b=Gd0iY4bPqVxSDmo1/KdJCtvPCditCrYGsBtx+R8QjY12/EnuKIWY+uoMvYLUCcnn2B6wnNtNktWXGQk5y1ywbBtVb2On/oGBm0YrTL+aevjsGWNquEtn02/YMTGnkAkO213uSNL+XZnxXqpGaShLtVhtnrDyj8U2KgpdLVY17HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789995523; c=relaxed/simple;
	bh=fiubGOpznSBlWjS81EhUbY8+Jvg8mdIEbz8sZifJeJk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sz9R7FPWFuCIoWSGv2V9NaS5Pe0Cx2g7QHZEksXNNzssL4xag9Fta8weaD8RX+cZEeLyOO0l5nEdhQmEOOoOAQNs1LQ9hlw7hQ1HNNv1mb/gzZe65d8PsAT4G1FkC1o5XwtQ1nkPtcBqoRzHFN3dJSaOCMSfY5eQ6GseX67u3rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VlRpau30; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=X7MUfdID; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VlRpau30";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X7MUfdID"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68LAdsnK1217803
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	skjmTwe/2/9vsGC6HLJTSQTIY2ObikwZKwuHsPTlEzE=; b=VlRpau30bHj0O0af
	bMiAMhzBP3oJ3f+PCA+Omm47zjxSPgeHoVPCynbxfHgavLE3pwCdR3fDszGGfCmB
	dMJevFWloWqUGqD6PSvaDak2BQdUAYY304Y+tZv33JcoF1iZMVAgDTx+sRv4eM+N
	QQ0+oKKdBl7Hq754yQno04gyFP3Ok9io4LuKBmvTO9knR0b8T44gIiI6yVtW0LnI
	DhUpmAkLhqEBESm4DnmaKPuu8saAm/qECqoV+VWoJaR7XPgrxUIKQHX2bugZUqxS
	D/wfgf2hti5DWeOcczvMHLc3uItPCTlyxNgXcL5SiWF1IAPBpun/CCG6J8YJfDQY
	tpWdqA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu0119ba5-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 12:58:40 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939f925ba4eso420651685a.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 05:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789995520; x=1790600320; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=skjmTwe/2/9vsGC6HLJTSQTIY2ObikwZKwuHsPTlEzE=;
        b=X7MUfdIDd9eg7Ap8LIb/9gI1kJSIFcMSP3sNFXPMa73kWNubSr29qtqtNXhLlPKzIc
         7SCv6EqSqtV4CS3IR3qlfU5g35S2hSz7Nvi4WqAl3MS4GL9rarip1I2IE/rhddMkPY0H
         FUnB/V54kF3j9nPkEZB478+pR49A8z0WYKIzOS/TVotYgCOIPLefOAsueuzmQ+SJu2CJ
         85UTQxu8OHP3nI04KV1dUtuBwyBnsWrlZttIODMqAu5Y1jzcEO59EznQ2QYC6gmF0xkK
         91cEmgGDqBf+CDEB+mZROz8IJGvDSeboHWrfpqqpPUZQzOeJoRFq6JFQVIHS2unvL64c
         asuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789995520; x=1790600320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=skjmTwe/2/9vsGC6HLJTSQTIY2ObikwZKwuHsPTlEzE=;
        b=TEEEKgtLZtA2wo+vde99y1inAxN7yv0wZnsh506HD9c3t4ObrYSQHgocmm/koTu3VJ
         TrkN82Bm7cEcQCW6DD/OJxakORHCPya2zk8HCJ37d4b4GK7zER1usCoS9Hnr/kQUHL7y
         RdLZO1Yo3QJI/+glNiY5h/aVjWR2MHNbEHc67SuveDhuYJ3NlaFBydXHESRrh7EM5zZS
         I0+1/fS20RKkfbBNY1kDZ15ZnynvQrX8waeCKxMgWNGrjsHpsAOywxVV63I9e8gg7NIK
         fESSZvf3x/Rw4E9zxIpmswMsaHPKdiQMDNWU6x5tCc9cSAGMZtz5GVCaMlzzfmOYafTi
         4xqA==
X-Forwarded-Encrypted: i=1; AKwUvBzTKPhPxyJ48jD+FyhAq6YfyRJeFBa9/BnQdAxAYj32q27thMTU2edYJ8IqPeJIRuELCO7gIzM=@vger.kernel.org
X-Gm-Message-State: AFuF++kzP2hXRxVVxrTUB7mb/y5/dZdyqyFuR2dpR46jug43+TGrFQmo
	HeULlmnOCrYZbFdy91ZiOY4oX0KDH8DLsrRF6kuxlUvYrHOfDDlBTaq75v0B3fF7f6J8YOgMlp6
	4DU4LDvph+rLXQF4x39j3SqM1ScYsGLVAPF+AT07hrd6Aohk0QAW2AKvYr4Q=
X-Gm-Gg: AYBFou3dZ35QnpsDhOdUq+U2ffa9Ul6dpJymolEM2a7f8lwOEW87thpbex055tAYjKO
	HcY1rGuR8haS3JGszGHPXnZidRzSaObyxbjNOzOSJgszGUDQiHqZqmZA9KpJGkqeVrmsElDzXGg
	5eJyqWqYIPOUx7SNWEFD7dCAWh8c68JWA7JGX+iaC8BKHojTm+zago8VVZo9Sd9H9ysC/FVV0LQ
	mZv6sHQagkn7tl12ZQgpsmRZxzuuJqE9B/8nIXvuCdbgLnkAHk4OhRougJARyGBBDPR8yJr6Tx4
	KGmoHiG4+zt484si4OY5Ap9iRweuWXZzFIjN8zF4eGqc97Lle1/GR7PfBmNefkRcb4llDRvu+NQ
	RYogpCqr2B5bKd4ssRAIIOuckXkg=
X-Received: by 2002:a05:620a:711a:b0:939:6de8:43dd with SMTP id af79cd13be357-93c15e99f46mr46325985a.49.1789995520085;
        Mon, 21 Sep 2026 05:58:40 -0700 (PDT)
X-Received: by 2002:a05:620a:711a:b0:939:6de8:43dd with SMTP id af79cd13be357-93c15e99f46mr46321585a.49.1789995519625;
        Mon, 21 Sep 2026 05:58:39 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:d04:d483:faad:1e4e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2a359037aasm320278766b.63.2026.09.21.05.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 05:58:38 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:58:11 +0200
Subject: [PATCH v8 02/14] crypto: qce - Reject empty messages for AES-XTS
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-qce-fix-self-tests-v8-2-107537869a72@oss.qualcomm.com>
References: <20260921-qce-fix-self-tests-v8-0-107537869a72@oss.qualcomm.com>
In-Reply-To: <20260921-qce-fix-self-tests-v8-0-107537869a72@oss.qualcomm.com>
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
        stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=fiubGOpznSBlWjS81EhUbY8+Jvg8mdIEbz8sZifJeJk=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqsSnq7SZtnuJ3gKn76T2Cx+kF+kAxPiEDzJeO3
 touwhyuOyiJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCarEp6gAKCRAFnS7L/zaE
 w+B1D/9BQnIoyDi5SScYSIHdGc7bLgsPn4vN+50qIfkwN8ShCn7wuBF/r10UFpbpv79rp1kKs+y
 mL4qBlu4S4FUE9viYPuBAaIqmKY+N3+AjtL9a8mhQYlynycI0UxiGH+b7cgKPes6M9sSJkhr+9Y
 BMekYaS9+278rJDDmGEpkoQSVSOIH9lm1DR/McGD2YR2zhCBmPaT4vVA9mNevX6B/yEMSoan6he
 A/ZwZPtGlhimDROaIY0tz7eUJ4HWnK83FrE9JRu7N7N/di8gRBwaZ4xe+63DUGU05Qc9WNmD9p7
 7BEetO5JtnDxQ+WqEdyfxls8v5oGiRZ8F9ZxAGAF+tiwYvY5+/YhihcOml14oj3cEHQlkzdj62a
 /QIOVdtmXDiFpJP6/3y5qsCwLRagVaYE8NXTfZtDCaoZeiEtdDNYAJpxPA0dKlP3fu48BXl4JYJ
 M+kdYY9KeavSzzclGlOfhbDo/SEDRXunAslSwus271IMIgFIQ+L2fcd6zB3hmREtIyAxAgLf16t
 ULmY9J64DZiAU3FisagvSDLX5Ne0cGPUn7t2RpQTee1P6gL9FN3VAJRUvXs6b/+b15uyiy93H+v
 F9hhxFFojcpp286Gbi6Anb/sD8NxVQwM8CNCbUAKap1yPw77Ina52qCAeZilBlDccYCdA8Qem25
 cwPGQGTqnUzVFhA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: -x0V3Oyge32Y22LMBwleQ0ueCsQIHfF6
X-Authority-Analysis: v=2.4 cv=dPczC+Zb c=1 sm=1 tr=0 ts=6ab12a00 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=kiYxeA6Iecqc4QeK3QQA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4NyBTYWx0ZWRfX5AdNdJyDPiNy
 psl5RaugOAoxbtMnogXH6+7dKJAp3VRWVmOrgsV8js1VQ1Q4FVtvMgd2g24EZ7MYNDVe1/aU3LU
 qYnwZmnDkjTG1DVgvmes0qLE/s9JB6WkzvSu6AueWFfZarOjxzoAp+OxJA6dZiRz2cX06zjkbZf
 idw3MZJ0kUgDQIWhdpBLdezmFX4smnoJq3T5dLEfS9Eo5OK0nJUG4MceUZ+H+fkn028hY6ESFLV
 d03nhoJMSiqJqTjl3f1eOEMjpoEYkEv/YfDTjuXvzV0p39sXhb1YQ4AO9GqMnwWlsrIIJTWIYVb
 X4i1HsUpLKiHpDmEjHTF8PyRCHK5sUvrKgpmkcxlRpwc2JHnht1v/hUvDJ3ArLuO00v47wsIF1/
 gkbCEQBDshJKD73Vdyb8jpYIC+eK6oXPHGPh7jCmQ0/+3Q6oJ0kgehxGkqx0hEpSSRH0hZ/u4lg
 tWYy8+d6R/AYLdAL5XQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4NyBTYWx0ZWRfX3Avj/1Pq3yGn
 vmtXPgKVS5asu+h0HAjj0WSJA+gdwYvSP7/wJemME20MoMP1KdpXgAgm1E7ncXHFJRfap1YTLhQ
 03Yl0okW3Izf4Vft4JLAHX2ZoTLiq1I=
X-Proofpoint-ORIG-GUID: -x0V3Oyge32Y22LMBwleQ0ueCsQIHfF6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210187

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

