Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6293A0B24
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168609; cv=none; b=LIfWz/0SpZ8CBVScnLV7u2f74+ZSbs46qz/ppgvMH0vsmTwhQX53Mk3oc7XJjtQwLuuI8qg7rq9cOubt28SQ19pR+CW0L5gHfXkQd2yOVZn93rp/3lMs+aQNlYc+ITtK/B7a5kJ9N0D/78slcmS4R0oDCATJgKR0ziyccqK4JTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168609; c=relaxed/simple;
	bh=sXe88ukQSNsLZHvzyXQa5xxcPKvZD1x3wSbHfVavSEE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=obq9kBu41HfeblWWByHIazaZOIXE5K3QoF3/ZOba73vXus6vJReb2n5VOcurm3ZhpP328i83V99NIedro2y101gijpl1R/aZDjqFks6Viac4UpTmsWeNWQTlvnxZ6FiF7xqzNhDRCUWY5jX5DOlYfNRdBCYioVhufD6hNZ1VZvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=P+ZJsfPE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J8MAxrQk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="P+ZJsfPE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J8MAxrQk"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GTov3835238
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:03:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ou64yNSBPM2pfV/tB9X33X+l86QX/kXFd8dLTHz7OTw=; b=P+ZJsfPEddYxB5VE
	odBoFZ3Vrui5W2fBtB2JfVNanPmARXn0z65PTRH5bb3PPk8h5wfP7/FK8sy35bRc
	cq5Fhvvbul0hsmNGTdkbyLP7krpGcnnBeqLwfa7ZXkLXZivrLfVcZBUcqBGh6bdt
	PyDBJk8FCSklJYAgnKwOR7ybky0HXdBrWSSsTjJY2gEzbtTtlwdysq/OpI7ZyaJJ
	3a1jDlXpcDWQDMAwot09Ct1hVHghT/RnBEvUwapfacQ0OoMufIJWVyHCGlAB1oHc
	YdIi4loJa3kEZZeFQ2NZedobptbbmI2sN6mk2yxPkM/YuDtv0ObAqFloLi5bJVRf
	uDdIAw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe6tjmkj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:03:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2befec3fd8fso54332975ad.3
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 02:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781168607; x=1781773407; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ou64yNSBPM2pfV/tB9X33X+l86QX/kXFd8dLTHz7OTw=;
        b=J8MAxrQkfLSgJkGosICjZd/+rsLdNx769EXZZVHM3H1HthgmFN7LW/ZxpeNWU0QcGD
         /A+blAcSNw3tE7PRvkRmswJqI1ITp4+4HoE3TxJlEE2AjR3yVFVmgLaik/Oenj6/gtdS
         20rlR+Ni/p1GvnQUZhOaeYmvAC1o/FxrKGvfFMA5TOX3RvKu2UsR067AbTtXCIq7fNx2
         WgFmHnOkwnpaEBr/YrW7xHG9miCL/DgAMJdCA4l2p+TlPSNBjjYiXHEuo2bQzqj96T1x
         alPixuaIXY78cLrmDgtzspygNiMLiPC8vAl7PLFCEQF/AfICJmlQT4xmwyyaf/Ujy6wA
         /PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168607; x=1781773407;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ou64yNSBPM2pfV/tB9X33X+l86QX/kXFd8dLTHz7OTw=;
        b=r3FJCV+QEl+MNaF4UAb/zX+InXKZFlzBpzu2PhBSK7Jfd1/7ZegYqllIl8W3L3MjBz
         V4NpHNIY1GI7IfhL0FtnF6ZdRUXt4XMVn0hkPpqypccNcDrY/hEmkZ91OEpAFdq9hIY3
         mO7dnmYFM1v8gSIg66ZrgbyqetlIrrtQLlGWtre1/aT5eX5wnA+hHTsw9SaZrerckoTQ
         J/GA8ZxTcSpgrNPumq1MtEfxcDf7tc0SabUBpoOgjvNQN9H1oiB1+ZK96rdHgnqDPJbU
         a6h+yuAO745pykLT8ukbbVmzLWXpEc0xUbkVcPRUbxT9s+RtajPMrvDk03X3pm1hpmOq
         DCmQ==
X-Forwarded-Encrypted: i=1; AFNElJ8mDJ0zFKhZ8eq4ZzXLvYDXjSNi/z/HEV3ndRnczXX3vTEe3W+FoidROabOSrn9KTFjIloLcgo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIt6lP5Gwjo9JZstzhCCyXFddiLPnqUREx4dggahn8tyU4g/xR
	iv7RJKIAGRoLm59SHH5TEY9wwcd6GbXOLY52VxcYf6EltR2lFFXTiAL7vK46R4yVIjHkGNDuIBa
	0y+tez3PbaM74noX4Ne+V3bQhbMmv8XP8DYkrMRax8ZrIdHr95nTEjr/9KGs=
X-Gm-Gg: Acq92OEL3K841Fry2oXAzJdUBAU2XrJvxKgIhpBpnDybFWZVRmlHNYGZDAw24jl6Idv
	Qnug/7yUAZRpE44MD7Jtm+X0pMo8xHXLl1ItuEj+fl+IMoI2QwdPK+Hxgik0IVY6/DxsdTs8t8G
	6xD14sa41yDA6iQPRYw0g6qYk7wovzVmWWh9Eb7ZT+Tgh00FN0Kh8awD8SeXIeoEVmeZA2y4lID
	uNFg5qyCU2og0TP0pSdY8+eAFUKUa0xALbyAc6JS8GK/WIDsCzGbAbp5pzO4tpdpVPFttz/cMEm
	GGzLykdxfs4LzzpAAwTr9fuIeskm6u6UKO8IUSgz0v76b9UkiIe4tu0uyWqLyjJpm/L+0qhbjfE
	mW1h5U6lm4+0rmQHmtDuyzkU8lVdzj3Tb9EiA+gTXSfbhgjHlk4Y6RXAi44vzx/5fSKDLYuuJBo
	GCkpLChlWCp7Heg9wjc3uH8jNo7FtfXR6J6rd5w8eN4LU7N3qM02LTHh6fQGI3Be9cUPE=
X-Received: by 2002:a17:903:2acc:b0:2c1:4310:d80 with SMTP id d9443c01a7336-2c2f0731e2bmr25403615ad.8.1781168606711;
        Thu, 11 Jun 2026 02:03:26 -0700 (PDT)
X-Received: by 2002:a17:903:2acc:b0:2c1:4310:d80 with SMTP id d9443c01a7336-2c2f0731e2bmr25403035ad.8.1781168606280;
        Thu, 11 Jun 2026 02:03:26 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c24edbb49bsm140980535ad.38.2026.06.11.02.03.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:03:25 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Date: Thu, 11 Jun 2026 14:33:16 +0530
Subject: [PATCH v2 1/3] regulator: qcom-refgen: correct the regulator type
 to CURRENT
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-ipq9650_refgen-v2-1-d96a91d5b99e@oss.qualcomm.com>
References: <20260611-ipq9650_refgen-v2-0-d96a91d5b99e@oss.qualcomm.com>
In-Reply-To: <20260611-ipq9650_refgen-v2-0-d96a91d5b99e@oss.qualcomm.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        stable@vger.kernel.org
X-Mailer: b4 0.15.2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA4OSBTYWx0ZWRfX4pQ9CKws24AR
 qPfjJDshADID0vvVkfIMH2s1gZs6VmAVrVg2f3syGLx0Sj/oc567K5WbuVwAynl5qtps7BvaFYx
 0RIFcddBwDmZqsY90QOVchPglI+ZnEiKroVz4RMIxouSuorACw8CmfiYzHArBAZKPz0hgS2HBwV
 P2C3pncT4FohvVL3jL2rBx1bOm5PeecF0HvmPPfEb+t0qfoSYtgXV9Etm8bGVBncAqkUSViJuSz
 XwAp89i0s7hMVAoJl4MAavgLRj2DsETLhgyGg2rrPJCQZhAoum3qBvQWx2P7B45smD1bwCDm3e7
 UVEXDsluXwvM2jo+6FMXBvPQBo7C4qN4MHFIjHTO5V8QstzZeSMVnZsvafUFJe6IrwuuKtev0xT
 PzE9gDpEitIzki2hZIEUuTFxrmDtudjCEjHkr0wyMlCJPzkVHlL6Dp8bznuAjBDwx3yB4CHRXbP
 5B5Harw2TQrWgtdeGiA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA4OSBTYWx0ZWRfXwFZk3tYXkfDL
 8Jum45xDo7DCBLudTJVS5xBVi7pNrHepZ8HXn5A3AQSpW44SSE+rysGVN0U72wHysCbCCi+LYJ7
 A/JuvAnOVnmCm108RpVOgx6cqSMltN0=
X-Authority-Analysis: v=2.4 cv=AaiB2XXG c=1 sm=1 tr=0 ts=6a2a79df cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VkQhxhI6jZxeKeB4iE0A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: DeIn2wQxb1LLjXf6RmbeLlXnYR0niMtX
X-Proofpoint-GUID: DeIn2wQxb1LLjXf6RmbeLlXnYR0niMtX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 priorityscore=1501 bulkscore=0
 clxscore=1011 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110089

As per the REFGEN IP team, this block supplies the reference current to
the PHYs in the SoC. So, correct the regulator type to REGULATOR_CURRENT
to match with the HW behavior.

Fixes: 7cbfbe237960 ("regulator: Introduce Qualcomm REFGEN regulator driver")
Cc: stable@vger.kernel.org
Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
 drivers/regulator/qcom-refgen-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/qcom-refgen-regulator.c b/drivers/regulator/qcom-refgen-regulator.c
index 299ac3c8c3bc..6a3795469927 100644
--- a/drivers/regulator/qcom-refgen-regulator.c
+++ b/drivers/regulator/qcom-refgen-regulator.c
@@ -66,7 +66,7 @@ static const struct regulator_desc sdm845_refgen_desc = {
 	.enable_time = 5,
 	.name = "refgen",
 	.owner = THIS_MODULE,
-	.type = REGULATOR_VOLTAGE,
+	.type = REGULATOR_CURRENT,
 	.ops = &(const struct regulator_ops) {
 		.enable		= qcom_sdm845_refgen_enable,
 		.disable	= qcom_sdm845_refgen_disable,
@@ -82,7 +82,7 @@ static const struct regulator_desc sm8250_refgen_desc = {
 	.enable_time = 5,
 	.name = "refgen",
 	.owner = THIS_MODULE,
-	.type = REGULATOR_VOLTAGE,
+	.type = REGULATOR_CURRENT,
 	.ops = &(const struct regulator_ops) {
 		.enable		= regulator_enable_regmap,
 		.disable	= regulator_disable_regmap,

-- 
2.34.1

