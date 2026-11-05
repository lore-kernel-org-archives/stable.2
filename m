Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895544;
	b=evXVSmmPAfd2w89FcSPaYXgzkaE3MseKtH1/JxSWql5p6Y6+6LIYfVyS5R59NShQB+Gx
	 3j7duVxjAsuMEeJH7yyHAA8xGMvzH/vI8XwLnRvamaF67GBYG7dDvoraKyvsFIAk5nRhI
	 ExTDqb9TXcDPVb2lcXtrAYhBnYX5c7MzzuN72+inkIewktbyrRknKyzIyC0Wkqjo0zdla
	 G/enTs48FhH4xSbnGHYPd4batFkLiC38nhIe5E1cusQWC/+LekolCGZ04GfOgom22mD8d
	 F6IwDlBq5lo+tJ7kFbVLqbGBqsyEO1HzbbB+Js+nBQHbrzhZ0nOndau2KFLVoXi4aUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895544;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=FcJOxiSipIa3lbkmFsBEsrX/6/5m87I40dDnzNRDJEI=;
	b=whdCFRhkzZk2BwEBKu1wozxA7D5HCzUN7lKhqH63tjl+h0EFOPkX1kEhZZuWg3z1dGE3
	 G0jsXPY0HJ6wEKeljMAtYz+RaHfTFjOzFNSUOvspqnXSwekC3JuTNJAh0xSsqgVpuelzf
	 sQWMR9LmYn+E3UmjTBjuzynk7rzF5efot92Ry+jBYEjV0xeX9L/xYMSL03N8kvMgCLPs2
	 75Rpfr78Os31Gx79Bpl6lS7lieH2tArOBx2qxOkFlCeSY5bV8YkWoImVEm1Sm0o4OanOF
	 eWs6Wra3eEg7tc9PGY9wbbsrc9azxqzr905TTPePQn0hgVUMarSUg3yCNo6JlcwfDtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MX3eRFb9;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OJoEZrDf;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD61E606D80F
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 16:19:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD61E606D80F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=MX3eRFb9;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OJoEZrDf
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A5EQHPG1630992
	for <stable@vger.kernel.org>; Thu, 5 Nov 2026 16:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=FcJOxiSipIa3lbkmFsBEsr
	X/6/5m87I40dDnzNRDJEI=; b=MX3eRFb9OrOtCYseWWLyf/hS44iSdGzDyMJ40q
	bcWrjZep9TMr28KmJYNBGVSm21a1JOWLjeGdDWXDEboM6Ucow0NF2dMvhoOavCDt
	85B9QLQyekmWJwv0QRK4/KR2cJQy1nJlbqgLUQ8v0Icnz9G4/uIxTVtLO0EOq0IX
	2DDVepFiWkOhZKDjoyJ7GOLywW9gB4roN5jPOEb/q+mr2INys5H0TzwEtadHV1PL
	m0l2p93mxgYT9+9Srm7IiSZnF5ui4kk3rVOPaxxbcVbQcu40RsuY3g7fuKjOhdv5
	+dEPk4Q//ZrGbethUX1asFng8mbPmp2P8xZj9/GhLT4APupw==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hrkaqarmx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 05 Nov 2026 16:19:02 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-99062be02ddso536009241.3
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 08:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793895542; x=1794500342; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FcJOxiSipIa3lbkmFsBEsrX/6/5m87I40dDnzNRDJEI=;
        b=OJoEZrDfXzijqaYJlvdzD5lwXfSUrVmqLljribq18NuWWFxWj2m5jwdrUWIroKlG0S
         eyGsGubV741rom5x4uug7UX1HS9AlRqco2Lu+Nw7RjTTIEDopi6yRr85hGCoKYMek1h3
         rb6s+SMWjctMsmK841MgKpVtFhMLbh3BW8GPMA87G2MLjk8MKJOYDdTCQ/jnOEaonnwI
         jluCT70zKRzkWFtSnOG+cFqcHumNdFZ/w0fTerxL/gFfW3sjOBEkgmNmFb1j95kTOsbP
         Tg5jLaUbizGXcmXaTP9iTBZLIBxR9XmewkZ2R1Vo5ruu22b2NxnmwH6WYkyQAwoSRSuL
         Grtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793895542; x=1794500342;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=FcJOxiSipIa3lbkmFsBEsrX/6/5m87I40dDnzNRDJEI=;
        b=pjZxX5HFbeOxCrBT0qoWPC48GTpc84MSDvuqYNit8HOpjvmx6erauTewinD5Qw2Ysj
         WaCPsL//h4/tN38qOWQeY8zmrWYojgLjtCnmCZ3h1Z+tqH7UQummalQdrLp7RGaGkNFQ
         KUIWwSNzD5DbP8W+qXFWtYnGKHasR7/a4eStNZTSOOkg+xmLdrDUYu6jfGijdKU0pExj
         i5v3a0YX7/iHkP3Muh1eSSVLYlH28ej5x3LhVMejcT+pj7axO6bXnGzLpGZeLAyqvMLG
         bmaueXj7/N13Bi660GbebNWJLXLfwMcpwbGIrBGkxd5XC+JedO2bEYIDroTwtDYajhKq
         RQrQ==
X-Forwarded-Encrypted: i=1; AKwUvBwfjSmI+bP5J7feeZSF58/ywUwlqmRek8SbnQtPPCceEyOxlTicsuQ4SHBRgLJ1ReH/xGgFeTY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+bargZ2mMmrHlymkHXcJal9lbpbzUktuXB5W+jqtxF+LJGvLnK
	oEXuO0LCy5na0V29ZO+glFc3MFkMcjyBuIO6GpzoO/vNH48lBFyXWhVErdaeJoGpEa1yWxNF81I
	TxanjU2dOUKujgRP4mmQ60xebxTAFU0tzqWmqMU+IyVBlQ7kR4YxNonkfyMo1TNt6H3c=
X-Gm-Gg: AYBFou2V/jNa0lRv7Kqv3vFDqPix6Eu/TJ0S0a274Z0NAqMmncJU/W9bkdIHWrieyBu
	Hja96Y1B/A/Jvndt9agpflQKmn+w0I4BssI+2Bap+PMXaasf/a+fqaFXtX/nZFwopG+qvGC7kLz
	oYHekuAht2BmU5LFTj+cJazhsR0O01+KT8syl542UqkwaJeAruyv6WuBLI+Qwy+Ubf0O5UMzfTn
	/RcN7wTAVFAJs2muhvsEutB5OCsnxi2pIvcHGQ3mYIiUPW4JFe8pZBNw7mhQjrcfuwpSOekKERj
	ExMW5NIYm+KXCno91ZzY/W33zjikfTg1V2JePJv+VwJTheEAfI+9/Cx/GUcHs7iuCIjpb4QosOH
	luGxumNNKP/Jh/zbR2RwUARbP0kgb3NLLRApVb8HpFYQ0U5rWM+yzrb9q9cTLdn6+EPCEW/noSl
	UMBw==
X-Received: by 2002:a05:6102:160c:b0:7cb:288a:b66d with SMTP id ada2fe7eead31-7d2a15989e3mr3554137.20.1793895541867;
        Thu, 05 Nov 2026 08:19:01 -0800 (PST)
X-Received: by 2002:a05:6102:160c:b0:7cb:288a:b66d with SMTP id ada2fe7eead31-7d2a15989e3mr3523137.20.1793895541369;
        Thu, 05 Nov 2026 08:19:01 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fee968763sm10593388f8f.56.2026.11.05.08.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 08:19:00 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Thu, 05 Nov 2026 17:18:57 +0100
Subject: [PATCH] pinctrl: qcom: check the return value of
 qcom_scm_io_readl()
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
Message-Id: <20261105-pinctrl-qcom-scm-fail-v1-1-a23f96c6b313@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAHCs7GoC/x3MQQqAIBBA0avErBtQo6KuEi0GG2ugrDQiCO+et
 HyL/1+IHIQj9MULgW+JsvsMXRZgF/Izo0zZYJRptFY1HuLtFVY87b5htBs6khUrqsmwo7ZjDbk
 9Ajt5/u8wpvQB5EjblWcAAAA=
X-Change-ID: 20261105-pinctrl-qcom-scm-fail-3a5a2efa79e1
To: Bjorn Andersson <andersson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        Ajay Kishore <akisho@codeaurora.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1485;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=Z+sYRV3+E9NWUPA5i/L8SISI8LUGUb1V03d4YnL6uZQ=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq7KxzpQS1HtT93B9G9ebCHgZUE6sRFu/yTU+MB
 roULgGzvqaJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCauyscwAKCRAFnS7L/zaE
 w1dkEACHi+NWYWNPBSDtUdYOsv1S2zl3Y6zL+Zue8MJ+VGfhxZQNnUqWkVzO54aA+DhdIHC6Ldo
 0U0OZGmZqTHDPwtM8aFRqPkekhWcS6ND1O3x6smBGzQqy4dehF5NRogebbs7nJDszlQ7l1q9RuU
 vpCIT4kExvHKNK2FK18S8kFy4za0rTZYwa6uy5SchV3WV2BoSRIEepNT3Mpwkg3OnlZCDNmlTsF
 hudDYkuv0vYk2gjKGN6KI7felVAMfU60j2nQCvtyMGAl+3na2XZFh9NLO9LITMnMpKNt+iuOk9/
 8VKJowPh48eWyALmB8sq6dHFUJGgWmYGbEAkQMiVacYLBVaYzPoRx4CjX6QVUC72HCnvSoHDssN
 1GYlwIQFIMJ95bK15CN5x2ApBxhl1j3h3bjgAHxlf7LnWabxPqMvalIu8ApAtv+oHUE5JO9Qwx+
 5UhV0yvFsIFmnC6reTv2F/12iAYcmXrNSTjkgGnwtklPNhzTkpe2J6994oUklkJtkNDZnVHFR4q
 Kjtn/p+NdnRrvKjnTNTm87x0fGh5COv9FbjU1+yfNf1ibrK6CF52kty3ari3OsMV4xyUhkJAPYZ
 l2eDNqlWU9dCaSIdF8ancsPN9THf9kEM2o2yN3HZznKymTXWIRHTAOVpPimMklAosmDyXLpVjZY
 PgUiCuAeGe8D7eg==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Proofpoint-GUID: Y9LBR_p7s_AvmXO1MTHvJciNV5dbuvU2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA1MDA2NCBTYWx0ZWRfX/3TU9hdJ2P+k
 Mz+a26vD31Ji3k5kVcF9SBMTkc+g+4gWeEmYTAWZbrvKeS6ZSLdHtNAXG7mCIQfPtFTLjlpTefG
 NHQpNZp+F1kIClSqp081MYUrYp+lHyk=
X-Proofpoint-ORIG-GUID: Y9LBR_p7s_AvmXO1MTHvJciNV5dbuvU2
X-Authority-Analysis: v=2.4 cv=OZoNnRTY c=1 sm=1 tr=0 ts=6aecac76 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=SLtZePgESXxLFGUVpRkA:9 a=QEXdDO2ut3YA:10
 a=TOPH6uDL9cOC6tEoww4z:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA1MDA2NCBTYWx0ZWRfXxt77kEViFqeo
 vvFKNVMZk4dTu0zXaQI1CJrd+NrL0xK0cg/+Cz+fl2t6YLIGLudwTwjDqtcBGApANIK8cYJxUlX
 Qcc14vDkSEJLQddkuNc0jMsvNOrq6GbO4Ulk8njCMpqw4Lkq8tgSahZU8cAOh/aX6bMJTI/wRV7
 5BwxG4hrrfNC5Vfe1ST8cFWHPO6jALPmXL2+mbIcBZse9kvfV6qDKrTKGtWeVT8QvM2ykQHk/ll
 BVax27/0XAo0gX3TvViS3k30fg7tIRkNhzFm+RPbEYZq8gnAkJ0DTaM83bxh3EdPCHeGB99VPYk
 46lHodcOs1wvy+t4az/IFEUashIAbCOtpmMJpXsMd9C+VMkKS/T5qTxEMqbx70LryUOzwaD0363
 d8/lpBbTiWqSoHJFiTQoZ5ji8XxM7rwr6Bnt2Wh+pKUumDDJWrxhbPfMm3hi8UwxdYrbjzYOQqT
 iuiia1lgE+pBT91foXA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-05_04,2026-11-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611050064

qcom_scm_io_readl() performs an SCM call and may fail in which case, the
stack variable val remains uninitialized and its contents are written to
HW registers. Check the return value and bail-out on failure.

Cc: stable@vger.kernel.org
Closes: https://sashiko.dev/#/bug/linux-a5545ffd-48cc-4856-94cc-4b2dd7968f50
Fixes: 13bec8d49bdf ("pinctrl: qcom: use scm_call to route GPIO irq to Apps")
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index 32aa7b919e24a0e614078ddc70a248c746e4813b..0053d1d927dc134ee81377fe480befa2da87c7f5 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -1117,7 +1117,12 @@ static int msm_gpio_irq_set_type(struct irq_data *d, unsigned int type)
 		u32 addr = pctrl->phys_base[0] + reg;
 		int ret;
 
-		qcom_scm_io_readl(addr, &val);
+		ret = qcom_scm_io_readl(addr, &val);
+		if (ret) {
+			raw_spin_unlock_irqrestore(&pctrl->lock, flags);
+			return ret;
+		}
+
 		val &= ~(intr_target_mask << g->intr_target_bit);
 		val |= g->intr_target_kpss_val << g->intr_target_bit;
 

---
base-commit: ddfe51b0a0f5dc9e415cc2c8ad8db17532dd426b
change-id: 20261105-pinctrl-qcom-scm-fail-3a5a2efa79e1

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

