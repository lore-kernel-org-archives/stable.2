Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCA22E737D
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 13:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346066; cv=none; b=IoC770tttyaGtv+3NEkm6wA6jJ/tBSkCHMHopnpPB57Xw/TYjRfFzee9Ktmh4/mpJbznBCbl+MV/154SrtQvbQXUGXgJB9fOKbwSRPY+4s6KsVUMsBFyb8QXGTIqNmZtnALQTXQEgbaBzV5Q1IeZA4cr4ij5gh2pSsToAsDVqC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346066; c=relaxed/simple;
	bh=CYY45MSM4ZMotmXQHnMyBcMwgxFxp0g8DkA1Qgi2eCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NkyFdz8+nakqCr48yd+dPYxsPSjNxLuWEiXULd7ZkwMq8bm37VBitSoyyCNshZo3SWGiYWfQh9d19i5+bsgEC8HRcKdvzwxlBPr72C5Hj2ncfUGYOhcexl8HqlNu+FS5pL8brb8SzsXndd82d5APnoaLWZ4cPNsyQZPOVSNIO3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cxhnd4JI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ap8bImlL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cxhnd4JI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ap8bImlL"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxMOu387498
	for <stable@vger.kernel.org>; Mon, 6 Jul 2026 13:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dh/jB5jnhJ+W/sIx1gynQvHO09FmmOdVkDRtzuKngL4=; b=cxhnd4JIPdsDB3HV
	RxCITPeoOyY/1Iz0V+VX/F6kgCLpz86EkkETIr5LtgNBMmi693/1Sk0TumfNzldG
	k6IZzq1RldbA3ohQ01yHN+pa7aMlzThe5Nr9x9T8f1YaGLlckun4UKy4WVsuImN7
	EZzUEhT66BQkk9jsqmagUzDsCMfgL1wNLYiddsOr5MSaYBPn3KP+emIMi7nJ+uIn
	KhUmZepuHUkRJB16xpzQVaoXZoUYDPyj4PyOqDEpUlidstkVy+4RUHMvRBnCKcJQ
	MykYCO+YkswnC7UDIWBm23IaE+1j4yy/lvka989mGH3zD6YiLYNFch8LTy9q0jGq
	zmEfNw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3r0wxx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 06 Jul 2026 13:54:19 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92aea0d801dso289422685a.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783346059; x=1783950859; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dh/jB5jnhJ+W/sIx1gynQvHO09FmmOdVkDRtzuKngL4=;
        b=Ap8bImlLrF4s8edk+mQ2tblNhSbgGzBg7lNuA7360niTomlXYmH71AsXWGB3PxIi9b
         I8OkHoS+W2k2kw22Cd2cYI/YyRTVyfUULsLYsXaUz+pQzAJ9laCHQcDCxmMU9coY0X6x
         4nnkAuurNyDf/+zMrT6Rc4A+o1m9wCUgPSC5KYvhGXUCAcl65nYqq8r1TO3Sq6iLj5Jo
         MBjIO2M7YJLjDTqbhEw7hd/4r8POlAZZIpb08ZH393xW8LQoLbIrpwvLF0NnOdHuiMMC
         +Ee6j0/6eiaXlmjO+AOB6DlzOJZDSW8p6S7Ak/dzkill5+QopxE3WSiL59HP8lPNN8Ve
         OJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783346059; x=1783950859;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dh/jB5jnhJ+W/sIx1gynQvHO09FmmOdVkDRtzuKngL4=;
        b=QFR/I0tcNRBj804ROP7juukC9K5HsdOCAYwikYGrXB7+FGisCfLjnGxyFati7Xge7q
         qQnmqVUTixb86dyFSLLlu6Yc5kqVcpxeSfqIpEKgRbEj7ntNJTmfOjMqFixNj3c3+VaR
         Qi3lOhCq/LirccLbanRiiM7DKK3NSYc8s5Q8IxeRsnWDwlIMngIgOe7pt96/w3J8yn0T
         +pyjaxOCSlT1Q1PiGj7/KPTz6+9Q0A81sJ9pCprNoYAiQYGTXQqguXBsMmbYDHXhjPhc
         icyL1kiKXmkL0DLnjR6a6j97I4V9SMU8NRHlGtO1rfSmpu3t0qcXU4To50py6Z+D6Juw
         /LlA==
X-Forwarded-Encrypted: i=1; AHgh+RrcKB4ElsIJE4oJhMT7Ph/c45sQKiO+eM1duRWOAU/oqXSuEWr6+18elm4AeQ6/ZGaqoct7kFo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZg5Mx7+HF3h4kikloroLxrQyIn9Q2UED455o+dg7svfDTDF0P
	ZnZh99yIxSmksm9H6ESZUucyQc0t7dtOllB4yXVtRdCaneEpdYla6Bn3emm7wzh31yD4QrQACpa
	zmdpMUH5K35oJjbuDyPGl1hu0/vcPyVQU87MeE+jm2AkhnBZ84idQiedB2ng=
X-Gm-Gg: AfdE7ckBgZhaqC0KmwlPB14ZNgaUXINniFriEzGrSpn7XjWIWl90tCPQQffffUy9Cdj
	9Xng24gHT2gaTLZYz+RlRWV/gxQs2mQSX9veeymg0lVQ3hl1adTbbF3oBh7FKoxthTtIFNyrxCZ
	Jat6K/8I3fubV7I1fXIU0wQ90qm55ouWgFyTfQF17uCXN7LCz3dL09QUi/X0ZKmVV/Sqcg0lE7U
	7wruGZ4RErYJe1VyYrtk3QzJfNE/41SpAnpiEkUoKT7duapeg9MUuQ9CT6CwqiJLgKJcZAnNHFn
	EcDkJxscu7rTcSXU1DqX2TNLBc9I7RPgA7leIYfxYiXZZ8G7I9m2XYZV7aKbE10CHvXa9v9NPN/
	XaqojmsUrtaGZtBrKRWtG2vBKwwAW0LjL29f1Mgm2
X-Received: by 2002:a05:620a:45aa:b0:92e:5d7b:fe5e with SMTP id af79cd13be357-92ebb4a77f7mr87674385a.7.1783346058523;
        Mon, 06 Jul 2026 06:54:18 -0700 (PDT)
X-Received: by 2002:a05:620a:45aa:b0:92e:5d7b:fe5e with SMTP id af79cd13be357-92ebb4a77f7mr87670785a.7.1783346058076;
        Mon, 06 Jul 2026 06:54:18 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63ba971sm619805145e9.13.2026.07.06.06.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:54:17 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 15:53:55 +0200
Subject: [PATCH v5 4/7] crypto: qce - Use a fallback for AES-CTR with a
 partial final block
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-qce-fix-self-tests-v5-4-86f461ff1829@oss.qualcomm.com>
References: <20260706-qce-fix-self-tests-v5-0-86f461ff1829@oss.qualcomm.com>
In-Reply-To: <20260706-qce-fix-self-tests-v5-0-86f461ff1829@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1764;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=CYY45MSM4ZMotmXQHnMyBcMwgxFxp0g8DkA1Qgi2eCQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS7N9F2PQsqgPWerbzEG1Ny3CFRX3iVQwi2/tn
 3n/28mLl4KJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakuzfQAKCRAFnS7L/zaE
 w+4AD/974L1WFHbttFV3QzVKJJkYq77j9ywQTrplx37/qk1W2sejrqyvKupD3FSRCbstJbObQVZ
 tCojY4/50jlhRz5O6AA05XjQHNhZytDp1Ag8q2bhIRGsaG7mXbl/y6EA741juZL081h9vMoijyE
 9JuLcetbEwoAQO5lEjb4xOIB51CbCT2pzXpXRxq8bm+92anwEvTju9QSvIXDGoL+5Dw0nd1u6n2
 /T50t30ufLoHZh/yQKngRpOmsGbWZK9BU3+BJrBBUdJ7sxtgwbUt4KssdTs8pSWYWhjmAjUV6Cy
 xl5U/n1YN8jNS+GJt3xNM5zlIWZCqyQ7V24GaHV9D7WVeRNSkm9H+3NIOJdBVAfoRdnpIt/RMfv
 HR4RP03hOFWXWDHbPuA81eKUPVDB3OLTFYx6yHrfCn+8smOVah1S8vfBU4FIC3x5b/GPlVP9Qf/
 PgxuntAuGaz8Xd4isrfAAuQ5+0UDRU5NYrs1cSkxQ1n807wKfCGZ8+n2KB8PhA3HoQ1BosBRTnV
 pUZTXXpHZ6CTFikbDAi1ExUS/RrtgFPRpQPhq0JHcrkP1yR860jVD2I8xOqXrZtfjSyFe9luRSF
 VK9UBuuHlKtn3U2pnttg0p1c4SXlBf5hY+Ogj2W4Jmw59gJhLDy5QVtVUE9PbLi50KVekmr/IN2
 eTKiP9QrdTRzhUA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX/ia1aL52j+HL
 b6o3EDnvw25Q6srtqatwLZltG6Fqzamu8gwPrQtaLlSJO75VlJdheCG5yTNS2JLkHSybQcAud6S
 8M7iedySyZdPoxNRa+fwIRWbeAtz3bCZeReVwsr/MVYiMCc37q+Lz66VqudJ8e6WvjDFAp8R2xS
 vT0kI2RC3Rk1ZD03eJVQ8WnwRPvGDESUR+t7SW1osL0K4CHAANmJn/NdrCFX61BAlop3OSfgnwB
 zkI/ynZR/y5Snkuo3uBh/xkXWp6C7mx8BrxOEnQ8Du77VjXiq3OMR4Rgjj6RLtyW1pd+fyxhtx7
 l+upOcxDCejrC1eHNXZDwe9iO1fJUNcAjg5BKM75aHb0MxcGiM0D06k/vOt9jgxywU+mGoK5XJ6
 DBGSulDLn0qd4L1XVpABRv+DYZSfzidVrrGu9+I16q96s4ouH/3cN+W8WjIE20xkWk1WgVLhfvP
 LHs3qW2m+F/CU1Exvhg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXxzp6d2Zu+Tuk
 Uefm/xKE2EriksZwixW4UwNVDF5jQYKHBUl3F5vro7UioxyWvfeDxbzp95qh4YIZxFoMJQW3Tg8
 ed9yGFyFo06nD4FO+cj6kMlY0CGBdIM=
X-Proofpoint-GUID: t3phipoTC_1rG6TYk5CPLzAD-eRjcEdR
X-Proofpoint-ORIG-GUID: t3phipoTC_1rG6TYk5CPLzAD-eRjcEdR
X-Authority-Analysis: v=2.4 cv=OKcXGyaB c=1 sm=1 tr=0 ts=6a4bb38b cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vUpbTSJP45I4i0_vGVUA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141

ctr(aes) is registered with a block size of 1, so the crypto API hands
the driver requests whose length is not a multiple of the AES block
size. The crypto engine, however, stalls waiting for a full block of
input in that case, leaving the operation incomplete and failing the
request (and the crypto self-tests) with a hardware operation error.

Route AES-CTR requests with a partial final block to the software
fallback, which already handles the other cases the engine cannot.

Cc: stable@vger.kernel.org
Fixes: bb5c863b3d3c ("crypto: qce - fix ctr-aes-qce block, chunk sizes")
Tested-by: Kuldeep Singh <kuldeep.singh@oss.qualcomm.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/crypto/qce/skcipher.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index 35ddbe03cfcd75db7599a5754e4ff978f3528105..54ff013e24317cd4d7a0dcde88cef8268db784c9 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -260,9 +260,12 @@ static int qce_skcipher_crypt(struct skcipher_request *req, int encrypt)
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

