Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A254376A0B
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 13:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346069; cv=none; b=riIXsPVUp4FJ3AKIuQImwXY0EC4Nqqpp8sWpSfFV+t5rW6X8+AAM8l+/vpEB+ZvobwtyqMZnADg9007ky5Yxe8BnYtowjwLTlp5Rj0oyBki8mEJZ9zzreGdvqlmplQDatIiK0MiPdibej/q+4bYys2IONqgPQWVaqHw8OqwTLSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346069; c=relaxed/simple;
	bh=Ejq3GCF3ALDtojefcexMkYFTMI2wVEXKIrBlhj81Swc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kn8X+0ojUZxjf+fpkFJSqCeZOYL1BHCIEEvrFUTawIpOapMyQcwru2I9TuYGaKU2q9QblZjY6topkrg3xHSKzG1YUxGS1Al34skwwB9feKkcmVEkxrF/MYgvlm1RM8SgFmkKxzQwfqNJjanhHZLCgEZmB8uTqU50WX50cUSpWT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=lFI0PthK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WiwlPZER; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="lFI0PthK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WiwlPZER"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxVZr369651
	for <stable@vger.kernel.org>; Mon, 6 Jul 2026 13:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EagaE396zMSCowVPFT/Lv2P0BLvUgaUxoxYWM76TMv4=; b=lFI0PthKJCdQx+wp
	AhZosW4s1BveSYqqVtQgfHJTKGU16xzv0Apyg4xr3zlBIehRtDOJOJ66Qq4kUSJH
	b4u9gzoSHy8JXrx0cASxlGvS2gaGWqE07SYF3nLrXXxYeUz0XtRYWJQgXJmsOi1e
	2yIJp9KW21JwNOpgKD+5dD9HNULbmy+9gTzTwDiXNgjQZUPVvThCYccwIrinoLiu
	fl26r72/BWHY4OL5K8OS0DhselwV+FVvkdfQ246zPl+oBYgYqwxUSGhkQvRVQpGW
	QuzlRGlTYAdm3mZM3+oj8xB/QTNu3WRnNqGWl2CUV5mO5nACBLknDhICDMQ94GY3
	eLra/g==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f88h99d04-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 06 Jul 2026 13:54:25 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e63df032bso336007385a.0
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783346065; x=1783950865; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EagaE396zMSCowVPFT/Lv2P0BLvUgaUxoxYWM76TMv4=;
        b=WiwlPZERPL2NkMG6ZVqxmw0Cf07+yDsx9nE0rlV0RZGAMXIXr+8ZjEukJeg9Ya10KO
         jNetl7aX1IjtGfUJn11UJS23+m6cXph+eNR+taJkDbcuJRHPgT2DQnLYnLOhqNzqNpfU
         K0SHZn1nORV0VnUfkS2wPOvB3N5PKwmE4EIWQ3mQU7Pr5dEPSIToFRs/thK5UREISTyD
         8meCg8pb1kUy4ZG+DEMCU2sZZfjeITKEGAmDFgL3KMxRnlgjY5XDIh/QhMuh2+IgFeN3
         RfCOIeSDOfNfzdE8aTVBMzNBboXc4DolGSGoQSDg/iwqr0/jvSzZZ+/Lnt6UlgCu6Rwk
         nVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783346065; x=1783950865;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EagaE396zMSCowVPFT/Lv2P0BLvUgaUxoxYWM76TMv4=;
        b=IJiYmxOX7ycHp8lPZ0C24nJwa3UyhrAj2PIIrk871QEJSZooZmqN+MxoKIihW3LVxF
         SLRSpaCaVt7DNJwEMXFietclYIZGKl4KvoG3+BnN4Xhz5dWmajiA9GnOSzdXRLRK0fC0
         DwDjO27BfucoWvf6OZUDnby2XzjiX5nvFLp9OEr46Jkg6jWkQ+PCgQTMu1M8q6+cCMLi
         XDYMkQru1n9S2nbCDKR3cC7lAEBD3mqdJIKpNTXBanXiHZwAsm0Jw8VPSkcjQCP8O1ff
         0ZT3O/1ad9W27ZT23EAr470wjpYmcGXnBfYMCZb+eX8XtQvsgsAzZT1/EdQga7GUSslV
         w7ng==
X-Forwarded-Encrypted: i=1; AHgh+RqPmuAyOGHZ3v69o7A6zZ4OXFM7mNXkuGgpNZtmx2Hhx73hZI/quaHvlTMufLX7xwGc/PAXxZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YygTtATm5BC0leZavhK8H5N5Dt4hDr7H+vcvcF4Q1lN+mtzfkTV
	4xXNAMH+jUaq6+g+lMNrcls+ULH+x2fo1m8r054INVkRmm8i7QI5Cbaul6+o35tvyAWXyCePQPO
	jSk5/LWkelfsRiF7Q3xEJjACFwLSkBgROubdlb9CZFwvVYD0CMuvnubqiVQwtGoTuna0=
X-Gm-Gg: AfdE7cnci27wCFnR1S8iZ/nnPihVXZ5gyU9vbsIWeQi3+DuXRpFsx792nnPDjC1Tgf1
	EVt8Pv6TC2Q2d787Bpa0ckEhGE7Nc+tGU8zj2EHpkXvau3yivd7xgjUKCkbPaCDaSzBIB1Kq7gU
	xcv+/zEqBrZzRNjjoscP/Ub3EH803cYaSh+xli9sBflbrqVfYkWTSocCYlYJ+9opvOvne2nsznv
	eF0YnOoi84mQs0xYDgxtkzf+HHK34jWIEQukTho0FJhqcA8dtmLkPtvU78zjqeMXvQ4t1I8gm9t
	j6b+E+SeCfO04XchbaMl1AJ2F9/57gXbXTDWhuyz1foE5EtJ1dYsTbhvYfGP/pHpUHbtRiFR9OC
	ZrHwc2XIsZbQ1z9gEmVtSX0wepoKnjo6OutQrGm2e
X-Received: by 2002:a05:620a:3944:b0:929:7356:2e51 with SMTP id af79cd13be357-92e8b29ea49mr1954699185a.11.1783346065232;
        Mon, 06 Jul 2026 06:54:25 -0700 (PDT)
X-Received: by 2002:a05:620a:3944:b0:929:7356:2e51 with SMTP id af79cd13be357-92e8b29ea49mr1954694085a.11.1783346064642;
        Mon, 06 Jul 2026 06:54:24 -0700 (PDT)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:86f0:c42b:ef4c:d3bb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63ba971sm619805145e9.13.2026.07.06.06.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:54:23 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 15:53:57 +0200
Subject: [PATCH v5 6/7] crypto: qce - Use a fallback for CCM with a partial
 final block
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-qce-fix-self-tests-v5-6-86f461ff1829@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1622;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Ejq3GCF3ALDtojefcexMkYFTMI2wVEXKIrBlhj81Swc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBqS7N/XzOiCW37/37DC2kSjBUfMS02JFc9UyEga
 1YdY63C3IuJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCakuzfwAKCRAFnS7L/zaE
 w8PUD/9XFKMV4iDp/XCMdL18GM2Or8cchFLaa8I1fB2w7R+CP3nCLVdyY226OlZvUcl/5bVAcoR
 fGn8jnOwQo5nhqd4Vmul9Zk8dtQ2I7NNhscI8kGnOHe3X+qsrKGbzncqt/SiRWFrrJ2fo6EChld
 fqI2LGqEP1rkQXQaDSYs5o94bt/bB1P9MT4ULjCXJryp8VT76nzKM2lJQ4cP7xQgPFOAjypWni3
 uexKknJq10GUeYkuG/nlQP4yTmIgyKm+OFP/SSn/cbSsndwIy2kWOrT70wbd4rbpN6iGhZgUMUh
 gZAQ3giu2XiL58/YAfwtayqLOwgdfbRj0Pl/huL/E6fDBgiZdEObSu7EWsDFUBAh8Cm/3/Z7PJH
 +QneJuwsPU8OkpAG1+0LAdyQN7O3ocXQUQrnQnCKsIY9z8Vh0mnI8j3MsTQKCZhHaB37h8ePpE2
 PU8I0notdC7qZHTYIZPKjD+c87ZX9ZoJ3/gXiQyeDDI73fgWYYn/WZ0/6VI1rpJRLT54gJ7XFjl
 JJy7Rn7NqehpkoVOirXNPw92kP1KLRvEyvja2CUdF9rsCKRqjTaaFsbJ5iiascp80CDmDRa29A9
 RDQsxOV4xHpnYdijOvzaX1mcVVb7rz2GvOvwGN7RDs8al9114uejioQCkiATy/SmJCPNI3A4FYg
 0uONVkpEnxYna5w==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-ORIG-GUID: VVLPzwYsl2q0qQ8M9CYTbPEN9XNMyeFv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX/olmL7ISy7l2
 GGB9phdPbUefqhWSPMaUkrrPM1Vf8ddNi/+cAIPhcBVYGLkqpilYx8zYuwZ19pX/9gPHqvWJ5TI
 s/TqLAq/nQbkjpVZrNTcqPSdCjWcFUU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfXyvvW5oH5QIsn
 4T82Nqu00z9/gH0eO5TEPe3Ibo60poLM23Dwscya+x8Vg7vdGri0xC7JBvQ5BOrpBtoNNHg49UC
 4feA7ugybupiitplTPth5pU7OtEvSbOROvVwKJuL4rMSINSYJPQEBWipbidXR1OOjNCe3LxQD/b
 y9EiRFsk5LiHBFO1i8wi38pd+uJS8TDeSSCulvmdGs5vIRwuldqVgGRyjoiZltV1fg6YLXyMUKC
 /0Be5+/FYGayTNXsRnrErtltgcJpu1WUZ/hKQL9STaih83xruQcx/8bdb3Jou8m+oM0guG3ZGMw
 eCMNVeMGBjtG9xqArHjmiNpJjW5nPH7N4SeSUr2rnBVcsMBD3ng0+lbSJZbO5A72fr5s0l2FfoS
 OLdhIIWA57y8ce5mmICkQF5dCvj8YbDj6bB/cFuzV2XPlbbtdu2WjHyqKQdkYU8ZIikcgbeQCcN
 6mtgAd21VuPUYQ36DjQ==
X-Proofpoint-GUID: VVLPzwYsl2q0qQ8M9CYTbPEN9XNMyeFv
X-Authority-Analysis: v=2.4 cv=GulyPE1C c=1 sm=1 tr=0 ts=6a4bb391 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dx2SfONCXZg6tt9xEGkA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141

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

