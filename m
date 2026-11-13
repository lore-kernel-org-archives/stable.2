Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586293;
	b=TrEgFq9zb8uM1UCdTDviGmj8cRJyuwqQtnzBU9YjRL7cfPyBAsiQtkCTmjPY/k3LuGLG
	 TuZHlIn3J52ZtdMNy9PT9cJFPOW4dti/Sk1ryaJ3f9fesObLlrEuSXvh/bL4zXaJzmWSE
	 BkgVmgeF4wLnwfDUlZG0Gs+8DE3ZkCc2Zq4nTLrWufIzZsfxmPvHczweRwckt5XlYPZct
	 7rHBH/KkXKlCBlE+NRK7XjKWLCE61543dfOH3xAL+M1NKwuHVXrDfdfiM8sPfn9y+jTKF
	 chfqrBEyvfq42QEJyh+phnKbyj4dI7PbVtrUAS5sZQcL2jHT6TgBMGwwX9yXE4YRcRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586293;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=4LUGD2Z1OxVUhNrmytBWWKebaTfhvUmsQJIgh2WdKo4=;
	b=CvAb6bpDRJODmaYJYwsAlqlVSFc+4zL2Exo0yWSxtxcSrCpZVHQvrAMubeQvtdqtlvVp
	 ai44CiExx84nM/Su55HN9AHr6SC5rVLi9MzdMWuqUvVA18gyJY0FFJZt632X3xz4ulQED
	 u7BCZZ5r5nXtHz9L3VuYaRWWYnxxD/2ijhTkgDC6oWJH73npHfAmtD6tLB+XVzit5IsH9
	 4Ux8sTdE1LNBMLM1Uo+X1HK9bw5kcgfoEUzjkUyXQEEqC3X6KadvzwGM0LadDhY3FTRTT
	 00QpoUtgIl6AVb/Y6a5TH2KBXmW/wHi8G20KeP5B79BjAJIwQlAUzsaP1azSuciqQdQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jgj56eqi;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Raep9uUt;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61704606BAB9
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61704606BAB9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jgj56eqi;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Raep9uUt
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADFRSdv552521
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:11:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=4LUGD2Z1OxVUhNrmytBWWK
	ebaTfhvUmsQJIgh2WdKo4=; b=jgj56eqi3jJEwA23q3UdKoHj2IVs4IYzacZtPH
	Ohmhcb8AZVR5e6SxDb1oouW10SHbv9UACBN6v+DJCcavnfmRYdvow+hb+X+bJMM3
	b4B5tBU6Ym20Ogs0vZr1N69KQjgsvYoZeJ1sbHKOeVCjzLIE8rbtoSav882bARtc
	g7Qts6ld3mu2SmzjTD0WN37nr57niKk3r6xl3m8rxeyFQdb6Pchf45P3sB+jDf5S
	6UUYaK3iqFs/bZWInK0nzG7U29sqE+ePtnxKe1a8VtPjUwKUKPEQKhReyou77gQx
	n/Al0uVxJ/1N8CHSLnTq5BBhd2GVKyxD938p7J03qgn2gf+A==
Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hwkgwbs7d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:11:31 +0000 (GMT)
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5eacc615f73so1574482e0c.1
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:11:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794586290; x=1795191090; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4LUGD2Z1OxVUhNrmytBWWKebaTfhvUmsQJIgh2WdKo4=;
        b=Raep9uUtdLfpw3dMOZFp4uX2xRd3jfMWNCQShUYfqsoALvTQaZl17Le6tTIOQSvJnP
         xDpi0XjKe7DA09DWa/Y4+pMsGJVtM7Mjn1qTYqsm4mwhKj2XXfAXTj+XQLUVFQR9ZC1Q
         8MKpEBBGEWR17T0AqEfcGLBf+Kqhfczf8SrTY4Hii8FusHsgW27SJY+80+/pD1I0YSWd
         fT8tQORAsnYojIPV/7KTbsGRc5P9jPD1SjPX84FfkHyuPVTK0QZZwtGyppcDSVTd2Od3
         OKEW+5wGbO47LEhcN9SmkNVXcB1DjcvGyusO0PLEy0dZo5UlLSq7tngmGFiKU3Z6Fu0C
         px2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794586290; x=1795191090;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4LUGD2Z1OxVUhNrmytBWWKebaTfhvUmsQJIgh2WdKo4=;
        b=tNbqXZZ/bJie5a8TBHGV6okAS2e8MIJrduz4CQxjNk0pJFvNKQNIB9l+RUkgloUAPL
         /l3ipcP7U1RJujjA6KkFuHReSCWHKySBA/kVxIisRvd9k7tUtiAU2Xkv8pCHTbA5/jNl
         hmDtk2xpx3mzBoFNaT2oPgk1sygfRjwqft7cgk/9NvByl+cQI+sFGdxjP27IrsbHPvv4
         m/lg8akg9iz72PHIDL9Omu9HgQw9lMr/nFyVqsIOdWwbP8qCLs6Fat5roZRxofvchbTg
         KBiC4mbpVvFnkbxHcBWAKF2OwF64WkzDCYqhgUrd2UliLAfwBkHAlYCKJxXcqtNTp0QW
         wENw==
X-Forwarded-Encrypted: i=1; AL+hErF2hPq/IFcmPXbmKRkKJEixxtHKOU0xXtHZOXN8BYlsjVqxbO2+le4AL+RsZ6U3Z+Lv/JwK0NM=@vger.kernel.org
X-Gm-Message-State: APuU4Z8RJuAvw5BJBnkmUKxX5nvN+EldxyQml2YRGRnzqk813pNcPqRZ
	Jqp10Prsn3wasQadFwqqhFk3PYZJ6pLj7zYnc3y3aczkxwj6mzZiWdFEy/rxDO5mLWe/AHAtzsX
	DSZQfT8Sj16j33j6xkMyZbU5v42XH4+/owfBTLR22EEPxXiQPx5cJ0phPr4M=
X-Gm-Gg: AYBFou3AB+dDRXqPLJ+2Xp77LUDgA6PeJ7rGOVVufUCfug2hd8V8Jsqbi5ujp7yw+L/
	e6Txa9sQC8Rs9nGJBErCch5wVPIiykn0v9eq2CKeraFNebasJZQnwEXvxXlJ9dPO8hyFf2jmH0F
	d3dpAmUuu62I6ITa7hPi9PN8AfauxorKu73/1k0AVc4Fwh3DGn5N0/M6c0ZJLy+ABw566qP5W0z
	XnZg3+nlnWSg5VbR/M9h1nZ/0Gp+jfB1FxtNzshyV2uT+EzsMYgYHOb/DfJP8spuakDLww5ZWKu
	P5iCni7IuZJC0Wd0YXa1vSJxQOfTQVC5xmdFhCz0++UhAoNrzXb3nv7BmyKrpmHe5aNIdpBP9M9
	u+RXNpVSnXuIY/jGPJJxMSdsY7DK3kgMDIgmnNMAKGXii3hvJZW7URPsrQoN0D1QUxzwMbn/PZd
	FdEw==
X-Received: by 2002:a05:6122:178b:b0:5ec:3e18:a8fa with SMTP id 71dfb90a1353d-5ee34afd0b3mr1266368e0c.20.1794586290458;
        Fri, 13 Nov 2026 08:11:30 -0800 (PST)
X-Received: by 2002:a05:6122:178b:b0:5ec:3e18:a8fa with SMTP id 71dfb90a1353d-5ee34afd0b3mr1266330e0c.20.1794586290019;
        Fri, 13 Nov 2026 08:11:30 -0800 (PST)
Received: from brgl-qcom.local ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5f7828a4sm6191547f8f.23.2026.11.13.08.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:11:29 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Fri, 13 Nov 2026 17:11:27 +0100
Subject: [PATCH] pinctrl: qcom: fix incorrect pull-up reporting
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
Message-Id: <20261113-qcom-pinctrl-msm-i2c-pull-up-v1-1-0eaf5c154441@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAK4292oC/x3MwQqDMAwA0F+RnA3YTAfuV4aHLsYt0NauVRHEf
 7d4fJd3QJakkuFVHZBk06xzKDB1Bfyz4SuoYzFQQ09jTIN/nj1GDbwkhz57VGKMq3O4RuwfH7Y
 t9WNnCUoRk0y63/17OM8LUIJxqG4AAAA=
X-Change-ID: 20261110-qcom-pinctrl-msm-i2c-pull-up-93bca429d5a2
To: Bjorn Andersson <andersson@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Abel Vesa <abelvesa@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1653;
 i=bartosz.golaszewski@oss.qualcomm.com; h=from:subject:message-id;
 bh=qENpHSvjG0OILGspIeuGYed8DR95/mcpbr3JC5vzuhY=;
 b=owEBbQKS/ZANAwAKAQWdLsv/NoTDAcsmYgBq9zawOIlsCCw6UJnBvKKinLIKFGP9eaFeaQNnT
 R/HK0c/EAGJAjMEAAEKAB0WIQSR5RMt5bVGHXuiZfwFnS7L/zaEwwUCavc2sAAKCRAFnS7L/zaE
 w+TtEACp2L3URF14/tI1QXht7ZgNJhAgYs55HtBCCyjUatNwfi1z24FxQ4JbPgiwIdU83yZ3xSf
 s/QBXAsqDzPb6oB6V0xgldpQOoyXHbSYmRsmyIO2tZlrI2j//RET0QzHY6SPpdEwy+HRKEyqnBY
 c7MpBWaRf9AeDVMZBRjkP8jbG4EMODEJUGCMWulX72RcjASSukA/T5yC2tRQcx3rKhlMhXXQMAb
 cHyA9R3VTfg8DORiZ4aqxliBCkkU58y51zfoUnY2WDr03rgP6wV7vy8Myslze5hJNuhZOZyLZxt
 iuslHDs3hS2CroAFH+Xq73cQYO9o3QImSM1XtLsWY5XruI92A4CosEpmOGEBWXizE8JPM5MQ3pi
 JePuB0Ur4uor8B3nDGw+rFPdQ4S6eIgYttF0ncvs5NcyPjGQNOXLVETryYZSMuIgJUj2dzOdtTb
 QwyAEQ7Z0vj2dWYlEwq+BGzMnAaZ4/Fu6bpvg0I0j14hMHR1QeK1+wmRkEappMyH1mN8V50iIan
 gc18swCkRgaCIyUusLzYAs+/uCrQQV+n9IBSOB/Znhyo9sSE2b93jol6k0tg20pBRwCe6/my6cR
 OawC3tRcPTisnZVeZFzeCdbv+gham7jp5ssqRxvo2oW1+Ybny6VYksjFxBnAKs+RUv7gCgBAtuS
 GQbfBRt/NxaFtkw==
X-Developer-Key: i=bartosz.golaszewski@oss.qualcomm.com; a=openpgp;
 fpr=169DEB6C0BC3C46013D2C79F11A72EA01471D772
X-Authority-Analysis: v=2.4 cv=DNgacCNb c=1 sm=1 tr=0 ts=6af736b3 cx=c_pps
 a=1Os3MKEOqt8YzSjcPV0cFA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=c92rfblmAAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=Gl397SsdjGjx4eaZ7aEA:9 a=QEXdDO2ut3YA:10
 a=hhpmQAJR8DioWGSBphRh:22 a=GvGzcOZaWPEFPQC_NcjD:22
X-Proofpoint-ORIG-GUID: DXu7zD-ItlXLyBGPyp2HtjBzdwH2_q8P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX4135fmI9Kh2g
 y+xFdMtzimg/EfAvP7QY50IdJSk9xSXvwTTTfnXIYJJs8nAQugoq4aw856bdplM1adMX879vME8
 +J6tdQn9xoTX7IMlOaWysragLI/Aigk3B/5pQ2W+69G4nmiZFsN6jIEj/fFFNNU/Ex0cPOL5qRO
 obYbJIS511+5z/lPQJU8rfo/kv714wAA5nOl8jnUgMkyjpHnafKZCvADISbYV0xH96OE0HNkWY5
 +7m/H8gZ7AFU0VbwNl+DQ57CWqmvRZ7NSw9YHvrsU1W2zUWRmzvv0q/vqd+oX3BA0smqg/J2XGW
 cvCG/ZumChh2QMJ7Sqop53HEeUQYdMa/L7kI+LmkPIxwyZj3jHrgUG3mSIzcnEPEfleSeNXi+tF
 NhDJJhvPQkwLSHH7fdOB+kFMOH9WlprwmNJ6KJBHLNl8H3yeq/bYJ2sRrVRymP0qof+wF/d+fgi
 tX2z9ATQexPZiMBls9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA2NCBTYWx0ZWRfX6arj6goGQF2k
 cwUpWr3twHNmhh9nEQJn2zbdaRNxnp04T49CVNnAtgGGXqTkypBxf7A55WtncBN7qtB0+R6n/at
 EzEmPfFxs9emDngdg21EvKdZbLwgNb0=
X-Proofpoint-GUID: DXu7zD-ItlXLyBGPyp2HtjBzdwH2_q8P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_05,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130064

In msm_config_group_get(), querying the PIN_CONFIG_BIAS_PULL_UP parameter
on non-I2C pins incorrectly reports a strong I2C pull-up bias when the
hardware is configured as PULL_UP or PULL_DOWN. For non-i2c pins,
g->i2c_pull_bit is 0 and the condition is always true because BIT(0) is
1.

Check if the pull bit is non-zero before comparing it against arg and
match exactly what's written in msm_config_group_set().

Cc: stable@vger.kernel.org
Fixes: 099f37a539e6 ("pinctrl: qcom: Add support for i2c specific pull feature")
Closes: https://sashiko.dev/#/bug/linux-42fe82f8-2ab3-4bdf-9d87-6f46c976e49a
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
---
 drivers/pinctrl/qcom/pinctrl-msm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pinctrl-msm.c
index f953d3d9e0980c535e08ba1c1765d835b8abb88e..7230780ee8d2982c56f59738e5f92dca7ff5e991 100644
--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -396,7 +396,7 @@ static int msm_config_group_get(struct pinctrl_dev *pctldev,
 	case PIN_CONFIG_BIAS_PULL_UP:
 		if (pctrl->soc->pull_no_keeper)
 			arg = arg == MSM_PULL_UP_NO_KEEPER;
-		else if (arg & BIT(g->i2c_pull_bit))
+		else if (g->i2c_pull_bit && arg == ((BIT(g->i2c_pull_bit) >> bit) | MSM_PULL_UP))
 			arg = MSM_I2C_STRONG_PULL_UP;
 		else
 			arg = arg == MSM_PULL_UP;

---
base-commit: 6d582d78fad9d828e575ca0cdcff8ea47a77220b
change-id: 20261110-qcom-pinctrl-msm-i2c-pull-up-93bca429d5a2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

