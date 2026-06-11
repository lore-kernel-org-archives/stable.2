Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5803F346A01
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781168605; cv=none; b=RV73ekLivN3j4kkTXHaW4GkPk7EbwQFtWtQzkBLij4hs3DeIfFpeafWrclbmlvinIMa/MZ0tM9ZJ7DJclHG2728UV1kt0bo+GLFuFUcF0NNLFVIoaLsI3E6+GdcpSLXq4TwmP5tFJFKKmrC7SUIyejBZRZFRdI35AmsDjdvcHWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781168605; c=relaxed/simple;
	bh=axDb+Ty1CX4/IKRVgSK8XXCQL16o3/4/13lR+5cK4M4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ct8k3GhEvCkvzq2g36k4tv/3+2RdJBN/1t47VoBOoBX9SFd6bikru9HjM+Xa6Ut/C6FSM8hkTpGXmQ75avKTl82lDmOz2E3MrMdvdQiKQ9lA5SZ9Ov9Fzt+KRBZJS8ZGGoNE9u+W72gWBv5pwr5kvOhtx8Z0Raj/Rd2M26NGRWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=hRZVPin/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QaO0GCcv; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="hRZVPin/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QaO0GCcv"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65B5GG7M3791630
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:03:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=6sVOtotN0xxy813wqL3hRN
	DDiZZLjmqdNer37sSn9r4=; b=hRZVPin/OWjB0VV3sOiMdMuILGd/K2Z+Jzr1d4
	eT4ekoxyafHgvig9S39HI80QqzkcS6nSgL7aauiTL0+aeFVFIA3TY6ESsS35uNe4
	dVNxNY77OXYK0vfl9fAMFYmqsGiaMBmlGPumezorj/UMKIm2jXDao96DlpMREA58
	aIjrgM1bLK7QjmG12lRVvSGeXnOdVj+KJ9fzuM/wnOmP1Xe5bhOmpj0PuLClhjik
	AyrYVKpgb3E8z20pNBtuO4VyXljTi3DEDwI16hiDwsMF9NN/YcjijU6YOZ5BCa20
	S0jiOGp1lp8fxtmY9iWleqnMN9xtb1AB/4jiByjiwNBPaosw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eqe702mgt-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 09:03:23 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2c0c20f7581so81541605ad.0
        for <stable@vger.kernel.org>; Thu, 11 Jun 2026 02:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781168603; x=1781773403; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6sVOtotN0xxy813wqL3hRNDDiZZLjmqdNer37sSn9r4=;
        b=QaO0GCcvTfuQRcAaLmKsS7+S3c5FCOszLzDj29h4afNLCWYxBfJ1qW3A7lpFnUAqN4
         +4gsKhdgivLrqdSyK6Vbnw2H4LQbjnjSZJmWTgiDTRrT8dsH+fGUEsTBS2uNWrHYUYiP
         oV+Vco0oNh+QweoRRScxlL75BKdOoGZkwvkC8yuBltOB+A3Rg9+i2oSSfhZiyx1cFkxz
         +uTOtbsLs7uPAX9BOtxEn6aEkU0Wz+XzITS80xrlr2N2RmrDrV1ZfMP7gCWFy45xoqAZ
         v6pbe0B4QUO7yXFDVMO2X818jsRmvgmJQpfffivXGvYDcjQpz1sfZjw7UwEYS5G9+jt9
         JzGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781168603; x=1781773403;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6sVOtotN0xxy813wqL3hRNDDiZZLjmqdNer37sSn9r4=;
        b=pGEyPZUHNkZg5Dn1ez6O5VTCIAvmDex4U4iAAPgA3Snb2UNPjqUY0lmgO28+znstHj
         r/sVjOB4JFCfi2kP8y/hVMqgH6hJkUzjGoPuNuXI+MBreFR6wB6Osro3rOiJAGCAXbab
         UeyOA8NrJgH+mn0EgXufC2G9tX/RJbcVDG0xVFXs1hH5CR6JSsNdyb5vz/ckHYKOTgNG
         z/XLh5Vk9vMo6ukTf2U8ekv6j18tp7NKsaN3R0tqzJe8eEBktWJTvPUkbnyCtDSjHMtm
         MJT8vvrkEps0lT4RSbBVluiMz9Woa01RzSzQKlSz3RJQtymHuMCrA2UWs6EElTnM3Hze
         cTJA==
X-Forwarded-Encrypted: i=1; AFNElJ8WFKha1Tktx+iO7R3li1u2gGeGEqmQQAIakM3QSLxJvpL5kK6MjtO0f91N2ScIC5KMZ/UpJ0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNi+OpMsgx68YG7ISZS0caqQ9/aPR6MRrgtpC+R5zSWm3aaF2t
	z2zKwDZHYGQrX37mcpG7/5Nlhg1IJuaCdjdffSf/u8h0IoNmsQ8xo5YLUM/f2nZWQx1Y1I4XDzs
	jffJ8m328RgaVS1bVgdtPQEYVeltRG2sq1qnbkaIVez/fGMXVWEyok80b7dxlB10XZE0=
X-Gm-Gg: Acq92OHUKD8iPSO32sONJrjYTNO136P71xJTht1E4vSPoF0mJDZ50nAkY4GjJW/R9ss
	L+DuZQnukWi6OadDDFU/W5chvGoflYIiPlIzoxpwoZQM1JcBaDLWhDpnyd+mAlTXKy9+nJeoAsl
	LHE+Sqjr87cc0r8BY6jx6fLdJNf9hddEvPSWF5nH9hMAkEtd/a9PiLh53ydonY1+uiKeVK133Ve
	UtMqy1pVY31PwslOLiQ8QkDeFcDdcPtSJIJ0gH4Wmr2o92g6kZNdRbSS3eySw6llL4W3+N+lzv4
	mDmR5T+Sx0G5bVdef/JhwHg7wKlFgbmEsrcbonBkxPHo7ZWODeivjBVNAT2Y55omZv5AYpDLzlD
	eSCEMrNvEUO2g9XpZA2yTHuj5OQ3aRdmsfwGNVqvjxiiXkiqstcje7LO7a3p+qdLMDlFiWAuPSa
	svbtzeas+3dIU64qEyygtPqMfPBpoV45y5w3iXSMabUAFrF+WCP7CB7cfkesdAPxbf8XU=
X-Received: by 2002:a17:902:cf0e:b0:2bf:bd17:90d4 with SMTP id d9443c01a7336-2c2f315d3cfmr27031205ad.28.1781168602840;
        Thu, 11 Jun 2026 02:03:22 -0700 (PDT)
X-Received: by 2002:a17:902:cf0e:b0:2bf:bd17:90d4 with SMTP id d9443c01a7336-2c2f315d3cfmr27030615ad.28.1781168602363;
        Thu, 11 Jun 2026 02:03:22 -0700 (PDT)
Received: from hu-kathirav-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c24edbb49bsm140980535ad.38.2026.06.11.02.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:03:21 -0700 (PDT)
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Subject: [PATCH v2 0/3] Add support for the REFGEN in the IPQ9650 SoC
Date: Thu, 11 Jun 2026 14:33:15 +0530
Message-Id: <20260611-ipq9650_refgen-v2-0-d96a91d5b99e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANN5KmoC/12NQQ6CMBBFr0K6tmRobBVX3sMQU8oUxgiFFoiGc
 HcL7NxM8n7+f7OwgJ4wsFuyMI8zBXJdBHFKmGl0VyOnKjITIBRIAZz6IVcSnh5tjR3PclXKC1T
 X0gCLoz7m9NmFj+LgMJUvNONm2RoNhdH57/5xzrbeIVcg/uVzxoFLiUJbLa1V57sLIR0m/Taub
 dN4WLGu6w/DVu4IxQAAAA==
X-Change-ID: 20260520-ipq9650_refgen-196b570d8bc0
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA4OSBTYWx0ZWRfX006rZHI4B4cG
 KmlfHD2jvXXmvvOj6yNqsOHOkCLLKKDY1FdLd3OtSX0bCjyp4nQESbvXlhqiM257gi/r37TPVff
 boLxi8zNgXMYjUHuHHCKZ6NcUdc+emgnSS566le+UIo7vGKwSTscXPGFSR8SVOhBk5N53EYvhPE
 ch7boWfcLHm405oHVlt5G3ghrGg9b3G+W4v7200MedLDESHigS6PaDIwa3alq+86uCYndYF93a0
 8uDJwoFNlhkLwWkFuuj9Oll3WlKK2GZkl+soe/f8cz+VCCoUHXc4TTC8ErbXIzbTGsOQVWXgRE8
 nX6sXHw9pjeqPAHHlGboHC1OBWyHgQ2cGZZKAsB8txV44gddf/JS8bQkkpTUjARpebBf1ZC2ei/
 HLDFf1EuzxgPPlk3N8J2JDsiZoR8Ln865NdQDD9JmJV8ZXFLWGwt+rSxy8mgBk1YdyxoP4C8k0i
 Gp0zV4uYEV4dl1GLmvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA4OSBTYWx0ZWRfX3ZOBQ2841uSj
 5OuQZFuPYDezNs+6Ph811EYJh6dSO+t7shpOq15EvECHJKQR8/0zhIJetL9MbAsYbOk+t5VmDYS
 qsF6ixmJQMDLB6fhSTS3rYkCM+ZHJFo=
X-Proofpoint-GUID: 4WMuBn4MM5myeJ0COAIcSwkP9vF3zsjC
X-Proofpoint-ORIG-GUID: 4WMuBn4MM5myeJ0COAIcSwkP9vF3zsjC
X-Authority-Analysis: v=2.4 cv=Z5Tc2nRA c=1 sm=1 tr=0 ts=6a2a79db cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=VwTxn3_DiD7NDJhMThUA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110089

IPQ9650 SoC has 2 REFGEN blocks providing the reference current to
the PCIe and USB, UNIPHY PHYs. For the other SoCs, clocks for this block
is enabled on power up but that's not the case for IPQ9650 and we have
to explicitly enable those clocks.

Document the same and add support for it.

Correct the regulator type to REGULATOR_CURRENT, as the REFGEN block
supplies the reference current to PHYs in the SoC, per the REFGEN IP
team, aligning it with the hardware behavior.

Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
---
Changes in v2:
- New patch 1/3 - change the regulator type to align with HW behavior
- Add the constraints for clock and clock-names property in the binding
- Read the REFGEN_STATUS register to find out the regulator is enabled
- Dropped the unused slab.h
- Link to v1: https://patch.msgid.link/20260602-ipq9650_refgen-v1-0-55e2afa5ff64@oss.qualcomm.com

To: Liam Girdwood <lgirdwood@gmail.com>
To: Mark Brown <broonie@kernel.org>
To: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzk+dt@kernel.org>
To: Conor Dooley <conor+dt@kernel.org>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org

---
Kathiravan Thirumoorthy (3):
      regulator: qcom-refgen: correct the regulator type to CURRENT
      regulator: dt-bindings: qcom,sdm845-refgen-regulator: Document IPQ9650
      regulator: qcom-refgen: add support for the IPQ9650 SoC

 .../regulator/qcom,sdm845-refgen-regulator.yaml    | 25 ++++++
 drivers/regulator/qcom-refgen-regulator.c          | 93 ++++++++++++++++++++--
 2 files changed, 112 insertions(+), 6 deletions(-)
---
base-commit: abe651837cb394f76d738a7a747322fca3bf17ba
change-id: 20260520-ipq9650_refgen-196b570d8bc0

Best regards,
--  
Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>

