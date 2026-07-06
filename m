Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9DA3115AE
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346006; cv=none; b=O9xyd0Gjrnl2U0AfWhBh6G0Cv1zHXQw/yUAs/u+FxsKOvm2+CwsrPTSp75HvtB8Ari2atyR5DKhjvtOz98fhcL+DiFYweBgyWWMIAVlJub4ilkNvwV8egwr4aUJTktiXYOjc8NWNTIFkXGPVWJSVWmplErvTGqgtyoQd0i2OOy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346006; c=relaxed/simple;
	bh=3AjHvDgnnTcsszFhHhPfPjFQmzqnsj2J02PCxcOc6Jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EZhLB2uukwm3m17SO7/q43RsdbT6Eun00J3++BK8FyToExJCeoj0jOqMEAMsOfoa8lzigZmMyJi29ZwYbbixYK/R3rMYpDK8gEZKil/MFESJJOFTZfCqzybPPKrjSa4mUq/qlwvGQVy6lVSP/Y9s8H41vupqMOLrkD8IVrIzu24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KZ16cK3i; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Zd4KHnku; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KZ16cK3i";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zd4KHnku"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666AxDIV366712
	for <stable@vger.kernel.org>; Mon, 6 Jul 2026 13:53:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	8NY/1ptN8ormR8uOFUxx1N1opjkl+PTSTOmsJSFl/rg=; b=KZ16cK3ilHN/bSpk
	Z4jB9kKYvs6MPHl3AmO2iHczlxE9Hf0+WJOAhd0C9mWxkig6yB3OMdQv0jgUFvSj
	QCp1k+xdQpqRdmvSULWwti/KqM0ejWEjfYNvdfTecjcgWOcn1InPmcdz+EweoRp6
	VRzNB+5gqfDm0pkMN/RCEyxi5oxkeBOEUG1yzkWidfY6OmVIYWhshuJxau0VONGU
	krUm1HAKfPKbwmtqICaJ+7xii1jQk1aAtxbSZnB2DwJLLtitU93p37kBp/QKdh+7
	dET0TeKCrBpt3Z9qhQkSg+BUZ3zePZ00svvEcQF6a1yUUjh3g3mgHs1NwEiVAHii
	Qqj9XA==
Received: from mail-vk1-f199.google.com (mail-vk1-f199.google.com [209.85.221.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f891us787-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Mon, 06 Jul 2026 13:53:23 +0000 (GMT)
Received: by mail-vk1-f199.google.com with SMTP id 71dfb90a1353d-5bebeb08c02so87759e0c.1
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783346003; x=1783950803; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8NY/1ptN8ormR8uOFUxx1N1opjkl+PTSTOmsJSFl/rg=;
        b=Zd4KHnku8gUMolNHc8xRiq7jgwmfoQ6uty5PAs/hYhajPtuxdF0T68iyL4Bo8CDZKN
         UO88TJSbucX0O6dxKDEC/vU6F5BCV3ZaZsLQyp++63kpFjJP+rHHW/sOyzZyxukOIbG8
         vqMwG8jwNs1s0wQtvNHPNdYilHTqWzMK/DeB+GZhRmi3ypQxOwdInYUcDIOi7z7GehkF
         3SDPfXDjTFG4xjMeaYhnRfjyN35T5N7yopjum9GG5PED8zoSmB7nXgME5+MtIVYg+PfA
         ucewHdFuvT+RRc2RDB+VQWsh4u9N4UBss44pNjG025zSWRKkq2d7CPpHIfyI+9TVNG+L
         LEHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783346003; x=1783950803;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8NY/1ptN8ormR8uOFUxx1N1opjkl+PTSTOmsJSFl/rg=;
        b=Y3FlYMWUza00BheqOX2tObYIs1Yt0F8qvYjlGGFk/FPvBZSVOa1kFAutJiN6W3gFzp
         JImMLif147jv5eRl6ubQegWN2hHUE8ZV7Y/h1ZLOcIG+2yavp0YOWkpPjCCvEb5RRztL
         D3oLZu0jhGGhMiQpD22ODl+S51Dyu0KyQJIQvOXTBcEVJLvPJ5UKm3LGY9qj2BLI/FO7
         pWHbhfmbFfSERWLG/1i7LwdXxtnPs+laysV3SkRXeGkq6+YJT/Y5pZ8jMOSI15FfK+Ql
         9PCyyvUig0e8v+YW51B+TuEMrlDNKc995+5hbeNx14Gjd2Be6FgW4J/OgNKnQ9gNi6Bw
         cTWA==
X-Forwarded-Encrypted: i=1; AHgh+RrAHFmR65Jysw39WCXr7ZgwZ5pQxA+ecNb5jVIs4dPetuI2LodRQnUZkK7nEVd+Z5RawlPANc0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzq3xViGeXGOlGSOb1KxGiW9D2bHQ+NlMGkB/VN/3F/vRrAh8cl
	OKuxQnsfJUsbCoiEqeVhZA7fVYmlo2nmqucTNHdFi4gGi8hiDm0aPoE03V3fZ9Hb4ALZZqmjShS
	AnfjjKcUUXiiNFOdn31fWBFLNT//6imbq+7gDF/faaSd+9DaNb54N7kfL2kA=
X-Gm-Gg: AfdE7cmAinp4hPFgXdJMh55E0ilCzFAPnttZ80+aGAfkECUq6ARt9RRuhovOPAeOPPT
	Lo9Iszw1C4kUWq9jVgl2wKhiCLEyGYAdE02E2XYieAqIT7M5QQioRqTNcgyef1kZ+yc4cWnFoi8
	bVzC82VMcSVD1ERunH6+SEJnll4Lo+yP2db5g6Cz/DY2++Y857qCKu4KnuphrdPqeKkniJyx0iP
	lK+4fodqh0OqKULWADv8oWocZHYo3z727BkBiglcJf9bRI0GpdaUPFjLtWlL+ANFOoufOGc1dh0
	aPCh5HRH7V6e2GEQ74EQdfHmpCozPz5bJ7EDSzzyISyY+5Pfw1OPoSvZZuGpdYf1OXiYqVA3dYw
	CloXSJFw3nOuWkacw66eWCwK1128xny/255c2HZXud8Zym5gRKY5G1YcbDcFgJKj8MWcZ427cfl
	roC7ewViLgIUB1H2SWXQkUKQSM
X-Received: by 2002:a05:6122:8b11:b0:5be:2177:70b3 with SMTP id 71dfb90a1353d-5be908cc9c1mr307565e0c.10.1783346002805;
        Mon, 06 Jul 2026 06:53:22 -0700 (PDT)
X-Received: by 2002:a05:6122:8b11:b0:5be:2177:70b3 with SMTP id 71dfb90a1353d-5be908cc9c1mr307544e0c.10.1783346002331;
        Mon, 06 Jul 2026 06:53:22 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13701easm2932551e87.16.2026.07.06.06.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:53:21 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 06 Jul 2026 16:53:14 +0300
Subject: [PATCH v2 1/3] phy: qcom-qusb2: enable autoresume on Talos
 platforms
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260706-fix-qusb2-v2-1-8d9cd73b1db7@oss.qualcomm.com>
References: <20260706-fix-qusb2-v2-0-8d9cd73b1db7@oss.qualcomm.com>
In-Reply-To: <20260706-fix-qusb2-v2-0-8d9cd73b1db7@oss.qualcomm.com>
To: Vinod Koul <vkoul@kernel.org>, Neil Armstrong <neil.armstrong@linaro.org>,
        Kathiravan T <quic_kathirav@quicinc.com>,
        Baruch Siach <baruch@tkos.co.il>, Dmitry Baryshkov <lumag@kernel.org>,
        Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>,
        Manu Gautam <mgautam@codeaurora.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1233;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=3AjHvDgnnTcsszFhHhPfPjFQmzqnsj2J02PCxcOc6Jk=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqS7NNSwp15TqI/ve0b4Klmq4hywtFwwzd4G0N8
 c3NV3rvk9uJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCakuzTQAKCRCLPIo+Aiko
 1fAuB/9ULsXW3j6y90PwaiJSN1E6m6IRWia2WVK65A3+Al7MY0NGP/Nh5bSPuloOjPaQbihil9b
 I7BfcCcKGkPtG54wzemp0jvPjQl0i/sGm2sbFxM2unJH6WNhFBLeNnqKe9zxRVECH+so5wMiY/c
 GMB9Fo7JU/8Oo0bmc17CnaJU1ZDdu/L/TSAlf4t72RLrDe11JPNYe+jjtSTMAr7KEae3a9FiVIx
 OW1oDUjjBrRT/LruRE2qz3i8m9mvu8jyF8YDmnT7rbfKdptqz6R62pBk3RFPqibjFCsoBlEg7hr
 541INcxZVAvf/if4rqjRsxAORj2J1YGF/vLVFJjtxWH+FdHS
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 2tHX7dEzTAulP2xw1A-a6dq52w-bXMEk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX0H7YgC3WZKSH
 4ayaIMWUxrzGXcCWbIIF1JRjA6Dyav0caDiv6XVOtJ8vDCbp9kwOUPKCrksnTJwbjEZaedoc2rB
 Z9gzZYt3jYd+TSGYRYslOYR0WG1JF0g=
X-Authority-Analysis: v=2.4 cv=Mo1iLWae c=1 sm=1 tr=0 ts=6a4bb353 cx=c_pps
 a=+D9SDfe9YZWTjADjLiQY5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=VwQbUJbxAAAA:8 a=R7DzW9ZLaHkN4G92kvMA:9 a=QEXdDO2ut3YA:10
 a=vmgOmaN-Xu0dpDh8OwbV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX/W96LRlxlq0A
 fnp6rdwClUDBNqV9EOYyRa1V4lch0NKCzJkMwuB5QIAjIcvOPrWcxAE5/QMvS+YXSt3zdHnz2/P
 AqCe7b3fumwE9nL21h01OL7jk+1XDU8Szzl6xCVOWtWRQqdecLjhyRsFZ6XPoEaNadFAL1i3x9l
 SpwCQhJwnpeDnhFJUtXXIsMCR0n/+v2ffClz7ViWRS9EE3iFYgOkOUDqdOwULrW6bAR0P6PpiJQ
 AedupMO+Im+7cDufyJPYA85BkgA8AS4nI0SlYOSamqqX93J0HHi8Wi38AJqu0hwaTXmULeCNRbx
 SBXsezRtWSIKswymAiohRJkBRfVna9U2W3tYoHwg8FwW+iFEfgiH3QzSnHGo2auurhBbSdCYBNB
 FTxq8eO2mrPfqCx2aI2XhKRn8PgGFhz6mzips5E3ebyh5N79sETrj2mp3+U+OCi1awoxmA2E7yK
 /HTdHzBsrcQwOgobKnA==
X-Proofpoint-ORIG-GUID: 2tHX7dEzTAulP2xw1A-a6dq52w-bXMEk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141

According to Krishna, having autoresume disabled on Talos is a c&p
error and it should be enabled.

Suggested-by: Krishna Kurapati <krishna.kurapati@oss.qualcomm.com>
Fixes: 8adbf20e0502 ("phy: qcom-qusb2: Add support for QCS615")
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/phy/qualcomm/phy-qcom-qusb2.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/qualcomm/phy-qcom-qusb2.c b/drivers/phy/qualcomm/phy-qcom-qusb2.c
index eb93015be841..15c36b594c09 100644
--- a/drivers/phy/qualcomm/phy-qcom-qusb2.c
+++ b/drivers/phy/qualcomm/phy-qcom-qusb2.c
@@ -347,12 +347,11 @@ static const struct qusb2_phy_cfg ipq6018_phy_cfg = {
 static const struct qusb2_phy_cfg qcs615_phy_cfg = {
 	.tbl            = qcs615_init_tbl,
 	.tbl_num        = ARRAY_SIZE(qcs615_init_tbl),
-	.regs           = ipq6018_regs_layout,
+	.regs           = msm8996_regs_layout,
 
 	.disable_ctrl   = (CLAMP_N_EN | FREEZIO_N | POWER_DOWN),
 	.mask_core_ready = PLL_LOCKED,
-	/* autoresume not used */
-	.autoresume_en   = BIT(0),
+	.autoresume_en   = BIT(3),
 };
 
 static const struct qusb2_phy_cfg qusb2_v2_phy_cfg = {

-- 
2.47.3

