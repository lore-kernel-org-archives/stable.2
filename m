Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793882791;
	b=dGSnoaUANpeiIBPno6aKodeov55Ifii0m6JKCR9p/1Uj0zl8EvEgku0s21O8hrBfsHdr
	 XWbNSfGtAxo5CuVrgmCroJL2JcxU6P2lEw1GfIkEueJBhA/LTyop9fQEcUxn78fErdePd
	 AdrXccrJqhfw71R2fTXMkzgEXe/SVplrkDTmJLmN+2wi+G+Qf+Y6qr5iuiZX9HZJ5GF7c
	 /UufyYbqm5WeZil6TtrLlguqEYwehCHPuOVxOTnI+2nrt7O32F5+DWDeWqESDJIrFvlqI
	 zkwzfMw92E3qi4rm7PlvkhFrvskBlbaULLTkTNPf0a3lo1jiaC5giMAAC8sva1xMlKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793882791;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IMSAIlQUHxsrVwK1rBDy4tctUKgRwlHxS9iZdXXuxeo=;
	b=31dG6uuI9649kiT0Okcz5TW01Wf2VntvAI66bXsgUf2GWIHu/ahFZEbDNM3OW6ar41tT
	 uQCNTdX1IrjkPsw8g57FOJXWrYPmqGfGKFAzl1+zYV7hqhiFqd2XxMBd/VfTVjiMMVOPO
	 64MUSQLlov4nrOwF7mM+5fIwNCnLjoFSNQTd9TcXO25sqin4gym0R+ppJE8Ef2GfvKZUA
	 beN1yvZjvQ4cdRSvvxSvfnyRATh6fIDsaPExMDgLYj2JEYwSNAB0C6EnR2zG8b8qQcEek
	 f6JgMRsu9ZEQt9koxY+WNwGUa2TOesd9/VUPhNiyfqeYKahv6xjOhbn5HQloffcJ12A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KakxBheD;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DBFEwhYQ;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FE7606D80F
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 12:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17FE7606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=KakxBheD;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=DBFEwhYQ
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A59tTdo4084601
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 12:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=IMSAIlQUHxsrVwK1rBDy4t
	ctUKgRwlHxS9iZdXXuxeo=; b=KakxBheDcKi0eSX8X0QgILgx/oy+IDQeMbXDyC
	IKj/cju94VVixNo447OpBo0NJXqy71GLgnW4FVYeLpChjmDXgc/g4I06sA6FbSiN
	ioaKTk6SE8PUXSJdUXdw5eGiano7K1Fba8PmgNzxXwaJxDKfmDE2MrShkl1syXjP
	ypnn7uwCAic5+bzKqu43ggl1me69+YhjYuA47EQ7t3W9xArQA8VS7yWJbA59VHiH
	x0a4waxb6v96/Nk22xrHG/g6lW4PjCPpVTRNOlOkzJ8x7Q0ha0lwPFds6mrmj39A
	7pxmn3TlF69L1fkclZaiapEb5x3pCsEzoAF0fhc+1INgKd9A==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrqhkrpcg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 12:46:30 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-7bf45382794so1358528137.1
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 04:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793882789; x=1794487589; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IMSAIlQUHxsrVwK1rBDy4tctUKgRwlHxS9iZdXXuxeo=;
        b=DBFEwhYQ3QnsmGBJgXrgpcMOInVpZbC/i39GYhfjlzbiXAMEz8gW9+RE6Gtt+veLwM
         Go4BKuUKJ4dRaR+XrRWCnZIMAe/AbzvZRGNzWNKQchQiWecXnZTiW1hq+gjeULHtU1+9
         sRTnDRmVTKEMBlQJ95NmS9VvpetPXv3ga1/Rul6AEjWMC+tqRAH62Bx05m3hLa2nkNCR
         LYNh6BfBRS1rkunrdo37eUZtE96ki4qc2R4zit5TU/lGEhxths2nhIjo0l5Og6phN8wY
         +MlDeV18pYxxNYJiajoBXOH89j9lJx5qoOfAQjZn6y+NJ6mqpaeF+xbL4oE3vXeKUw/D
         MOcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793882789; x=1794487589;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IMSAIlQUHxsrVwK1rBDy4tctUKgRwlHxS9iZdXXuxeo=;
        b=luEIvgKC3NO5YeYFNNSuFr6lC9f1N9lwI/a9GeRfNUD6DZGE/SxOE8w2i8u5at2iNE
         tHTwUDDDLX0OyuC1gvJYxDlagUvfurdmgj3pLK6VGGmg1Ie9vLHizWY08W50fLKqODVu
         0q6xSfUnE/awd/l1QR20UYmnA7tBN6dsizhKHtCi1bpsMJvd81ZbEtps14AuZP/TAImT
         vh+eDALAkTufiRRagxM5ZbEGRod2z+Ai+mQyE+mpOkC3AtW0dqaoG/BQp9Trzi5/SQBa
         OUMBxbz+hyBwbgrjTC/a2adWfxodvsY8ZG42qCRufgQgl9UDu+5Q1j82jfP95QTtt4Rh
         6X7g==
X-Forwarded-Encrypted: i=1; AKwUvBwMARDeCPIVYesgtOPYRRyYVlyo/TkRTj6lSAD5RSNcDEQ3dAcIaprQ+gfPllkSg0OXTEXksBc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/isvOeVbDTbqaF7RB+xoxn8PBbHi6hHVSCmGVPkGV+qnxXBSNY
	JU0QzG2U+c51Jbu8IoqMy/8kOppuFgdafJW2Qxv1VlU/QVJY0ACI8WRRXXD8tvOiz8nvoys3gP+
	jjUBb/jHnsYM3eGFZ5RoRaIdfdEgFOigZuxtBp+tNGKBVz492Yt3jVTVvcJw=
X-Gm-Gg: AYBFou3SkdwTn+YBE7ZqPs29nqQhAmaa4R4vM3HQvHkqbNoSiQwlrwxM0wcOZQtiCxu
	Ayk4GGlFCF1IulNIztRjQ4UVDodzWpErOd8XrbtDu4CUjxyyyFAV/8UIYOZgGy9isO198KaP7/N
	ikb9UsVIEnWLMZcqbmCCRScwJo2dLJNuYM5ViUDn0RPNN8VEvZCXMLbVWArKxwZDobpnjgcDEdO
	ZQD4HOaNLDXY72NXmPbkz+Mx7kInKoqXfrSxt/NKDBtz1RI0DG3IHU+9noKC/H0K41TOKCe4EaF
	tZU3a6CMrHaOYxpzhPT7LdEJNQoIAQs6i4+KwBvVNe5xYD92AUZYx2d1P66IJJ7NEAoNPH/3vwH
	cjZyEgXjxwU/Ief87gAd/fqmRnMpz0fy8+VybqSXajlYaCzO+N8NU81bCCelihsLdh3C4/hzjv/
	8G0w==
X-Received: by 2002:a05:6102:548c:b0:7c1:ce61:19b3 with SMTP id ada2fe7eead31-7d0727a7ccfmr8528573137.33.1793882789173;
        Thu, 05 Nov 2026 04:46:29 -0800 (PST)
X-Received: by 2002:a05:6102:548c:b0:7c1:ce61:19b3 with SMTP id ada2fe7eead31-7d0727a7ccfmr8528559137.33.1793882788694;
        Thu, 05 Nov 2026 04:46:28 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fec8d8748sm9959225f8f.16.2026.11.05.04.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 04:46:27 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 13:46:25 +0100
Subject: [PATCH] gpio: mvebu: fix sleeping-while-atomic in
 mvebu_gpio_level_irq_mask()
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261105-gpio-mvebu-sleeping-while-atomic-v1-1-3ad7bb1c9e36@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAKB67GoC/x3NQQqDMBBG4avIrB1IIq3YqxQXRv/EAU1C0tqCe
 PeGLr/NeycVZEGhR3NSxiFFYqjQbUPzOgUPlqWajDJ3rdWNfZLI+wH75rIBSYLnzyobeHrFXWb
 ubOewKDO43lLNpAwn3//iOV7XD7dxMMhyAAAA
X-Change-ID: 20261105-gpio-mvebu-sleeping-while-atomic-3b3fed029f7b
To: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Baruch Siach <baruch@tkos.co.il>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1258;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=thivSyhkwpeE/0FZmc6W5zleYdMpqoRl93RZ1WSCQVc=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq7HqiifQg40GMX16lT6teUzPc0u3oUdyXsj9dF
 wDmzN5ickSJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCaux6ogAKCRAFnS7L/zaE
 w/alEACbroycZMlQKHJe0TJrLeYzLJ8SrgrjXvU83S46LOPs6KpCf41Y3ZGsvi1Q4PuV8Pli0WJ
 epUBxYkmv6rA4S5AKU0chaySwy8VlGtFSSUpneOZzdD6mPTYAQoaLsCKg651U49dRlTHF8UcS/Y
 9QGNl3liGJqIcC2V/3OeIHhk+sEMaqHWoZaAn7CuajoORKZMU9ztEaQw4uoXYZbnTRE9AnNQrmG
 TMXdhKg1Xy5DMTi/Z8Or6xupStm4cPiSgCcHa3M96NM6csd3z+7n8kNAqEdAFvewjcphGB8WjMt
 Yk6eATZb3vOK2woKOQsoeSPND7PUBBpf/z0vMZqNFeeEwqH7jw+uOg+2jjMuWoV/HIUeHgfvUE0
 Q+lIQLGPdNr0A2QjK4uwYNaobw98aOOg066DOmfa16S8i/AM0hskbfKQJqXt2cvBlbczC+b1WAu
 sZC1SudrHEeaklPx8aDoK5I6ZC1PEsGozWKRLpIzUAM+OXdqOjoT/H6jgA/iO/JVfGQ06SXV4aT
 WX+u9asDoi8JD1ohLWq2oNMu07FnzcspSWHJFENnaFt478qpJvkoznve6nXTi1eNn5IBDSGyIWG
 COJ+TtkNQ5iuUUxt+aXOhjmhhNBu5CHMH6csCxiMA83EuS3kIU4YGEg8ApA5eFNYI0wwC38jRWJ
 hjHQKq+2m0ZQYAA==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA1MCBTYWx0ZWRfXznXYAQ3fdXdT
 lP68gcjPGCPE8Epiv+i1nSjkxYSiye1btC6N7/5HP7cQFlRVIyd3h45OyTM5keRnUTZZpXnEE2d
 zNghSUWUowTmcIpqxxyggIImu1FonyjDQ1wt5vLb8orEWU9ghLgBRhQgLb0dpQGU5Z2KVGlPvER
 T5wmFw8E7Q/XZDq5XYkDQPt7tqoTI8pX5TZGPAxPQ3hS6pg8aPSyd7MyF5XSeydMnYQmpT5UH2g
 4tIlf0U7mqghiSwCcu8Z91uPgIP/awKlwTc8Ovj/E1CTOH8XotSh5JXtO5wA1c50PsRpKnqlOZf
 xLt3K+W6WpJn9HY+GZCZUXO5XV2MYWKax0+goYwYzF3iAiBq0L6J2kAzljZYyFSzsmjC8hF6S7S
 xAL5k8zcBekVj9ZP0z/G1h2nVUMZRV9VKgPsGv/JHInh7FcBNvPOUTDDQswDzwsZzDD5ZFNWaFj
 M8vKPJNgXC6dXZs90MQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA1MCBTYWx0ZWRfX6vXNndR3aIRs
 pHPkIepKdPBs7Nu86tbyuet4w8XGplZoaCBQ5VHMT8OHMkZRgPmdDYbYTpyEqZVhJ0GzfBxCYMJ
 TyF/T0qYGMsM2Q0r7aSfS4Fz45eGpk4=
X-Proofpoint-ORIG-GUID: uXC4I4AZEiAExrj_un1-lpxgRvWCOH_3
X-Authority-Analysis: v=2.4 cv=a4+lZkSF c=1 sm=1 tr=0 ts=6aec7aa6 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=lusAeXgTHze1FH2-YeIA:9 a=QEXdDO2ut3YA:10
 a=ODZdjJIeia2B_SHc_B0f:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-GUID: uXC4I4AZEiAExrj_un1-lpxgRvWCOH_3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_03,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050050

mvebu_gpio_write_level_mask() is called with a raw spinlock taken but
the underlying regmap uses a standard spinlock which can sleep on
RT_PREEMPT kernels. Add the .use_raw_spinlock attribute to the
appropriate regmap config.

Cc: stable@vger.kernel.org
Fixes: 48f32a835373 ("gpio: mvebu: switch pwm duration registers to regmap")
Closes: https://sashiko.dev/#/bug/linux-6bee0c4f-384c-494c-868e-07c420195d13
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/gpio/gpio-mvebu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-mvebu.c b/drivers/gpio/gpio-mvebu.c
index 267e6d5bacd0d1c9de0ebb7e21233bc9e2cd3bad..02d9ae5869d75ccc9ac78c41650b9f21b18ffdaa 100644
--- a/drivers/gpio/gpio-mvebu.c
+++ b/drivers/gpio/gpio-mvebu.c
@@ -603,6 +603,7 @@ static const struct regmap_config mvebu_gpio_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
+	.use_raw_spinlock = true,
 };
 
 static const struct regmap_config mvebu_gpio_percpu_regmap_config = {

---
base-commit: 8b7179210b22f8e48a82c5ceacb9d56a9c4cfec4
change-id: 20261105-gpio-mvebu-sleeping-while-atomic-3b3fed029f7b

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

