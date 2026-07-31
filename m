Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E7D361651
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785522150; cv=none; b=BTugzNfZj1Xc655SBSX6erRq0gIOXnvU10JWMp5qqIOF0HFBfJYhc19MKiCdbsrHpOtdaBm1p+Z14X2k+3AXSKmou3qMnku/FNJ/Aq0cOFgr8GIOibjpqv5v33S/jKxu5LsD9N19G4vkGzMBrT8N47VmoxRC82dANnEbt9xP7uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785522150; c=relaxed/simple;
	bh=cu4pPclpDZcAviAJxFeTJo/ayR7Q8C44r0iQltHM1U8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=oyB1Z1Z2EgXBwTtTKCHnumEkphHjnygVHw6czSyOssv550+WYx7XNGPmPso9eDKb4SYjzVes9l6l97CHc9XTbaYEqTWHX/Ac3xksOAyVhuilH9tduqqXXmGyyvlldKq1xuuEK8AjBSIYZqJ/XCJreA2CYoK1Anry0TTL0WqhudI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oKkS0Di8; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=UXxMC5/r; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oKkS0Di8";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="UXxMC5/r"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66VFOcPL206235
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:22:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=054i4meXxT28F/sqxTyxwv
	fLZnm6tcmnQPyqe5M48xg=; b=oKkS0Di8VkvV76wOrpCbXrOdISX2/lfUm1Wlce
	J345gCq9LwtCFzhRl8ZnA/5NYmBvh/4jIpZDjPs1EqnV2xwo/Yqw8unY1YFuj8hq
	m/YGk7R80UBiwAuw8VsmTnggPgyWJ4pG+YPeUWrUngx1D93iWNqtot7hEy7FxeEQ
	2sJDByX1SIzYkWxyTR8q8ImG0B9cYVXMaPSVFpS0WYqwOBoy1QDW5NRQPE3WU1cS
	vqNhxEz5SRfkvcYOf80gFrdtCaFjcmVTY7zuSLV/9f7cD74v1WbtV96+strDIWxD
	xWiQyyEl8KUKfq7XYxKF7rQCl1b0fzvPefheN9PxICoRIJIQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fru5dhvh1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 18:22:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cc640dfde3so14174655ad.1
        for <stable@vger.kernel.org>; Fri, 31 Jul 2026 11:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1785522146; x=1786126946; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=054i4meXxT28F/sqxTyxwvfLZnm6tcmnQPyqe5M48xg=;
        b=UXxMC5/rFnBi0DYhcEfWgVbzI+Lx1owOrku+1NTE/VyuvR4u8BLFQhdnFtkIfTZSay
         wzjqLC4J0OoMPeecslKBFeo2j4uK+ifiF7PGYhLa89+1lrJsSfAYu1TnCrHHdXazjmb/
         QYT187x1rNWBF6vOYMn2Id28wIHaUlOp52wJrS21XGOIVvuD6V/BAuqsDbedUjQ8xuWw
         LQ6JzuhJF5ep3GHI2JU1mKYYBoj7vMoE8m7GkXrJSQ/BqLMcBzhnyGCU8GGFL1E6Et75
         XvX566ZC0jcl3j1U1PxUW7hOZ718C4R29kSbsdqoH3zMlfnCbosE9AcQj2HhHrfgICS7
         uA6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785522146; x=1786126946;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=054i4meXxT28F/sqxTyxwvfLZnm6tcmnQPyqe5M48xg=;
        b=F/BHZJ094RBis+hIez4aKwXfxMfEISbAKUDBALsezLqxfz29at4GMgSnmFHXB4rRvi
         pv9zpkCXeHfqPcLf/TGk5JzSHzu3tKlV2gVrI7twm5IbMvHPEAoFUJwR2F0JvhjiakVO
         QkX35zxE1cWubfqKIB0TMrvVUKjWwq8xXbNRaWMGUdA8VY2Id9OLsgkd1KETnZMlgho4
         6DZiHk0KSxUqZrLoswvnMUYNySr0lU6FfitySdeREO9Z2K22BW6EVyuVeZXdCDWMMw3+
         HvPsg0bsNI73YNKB9D4DTBRxmvV19vJ4ck+ZZ2GbbVHs2C+8jkOLdaQmPkJTnvdxpvqK
         +5EA==
X-Forwarded-Encrypted: i=1; AHgh+RqNmsCmG6g5LutNEfP444TTEH+X9NpcC2BJ1Dk5E/XxZWowqLlDkPL/58aiXfeRYBMeKNEqru4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxY9ZPFAzp7H/pDHSu4dKY8MFJZkGziPpXx/2p/LR4JM228HBIR
	Wvm6jGxtRwMDYDnaW0R2PFO0143uZEwE2Jyc4LvJo4U/6ZG+aymT4T1+qkFfmurjpev2SWrA2j0
	vTVuv8YY1AVCHC3Dw5QOKZqJ2k6pogGZFGGAzjymHa5xp6WBNRf0Mg8xemcY=
X-Gm-Gg: AR+sD13VrmWntxE39Ui1NHXiHIBNkYrwm8IPYAf1ZYy+ynJfeVK/84BbXY8DCzOImXN
	2Xhlh+be2H5ds6BPCvhgP1BNzJN2FEfWBd2fASHKzJeAPn0O09AlZUz8+iX1X9QDatZE4Wtxwtv
	GARuVh8Ao7Yyc/tVQB8+JdxwQYaC7+dcqEu5BW/Mg1MBd5luEvrxPD9bnPWQArvSwSGTSvQbTsk
	hkl6SzoQOQdTTnnOEETHCNQWCO6wu59X4k7rAWxnD9jfsK4yv+fgg3div9XdHLK5g76CNyG4z0M
	dI01dK0jGe4MOzyIR7C9FSHETCvnlHXJklH42knCdWCS+sfFt5zU2WNtDVI1s1NdYLT0U1MaNMx
	v25dJsxoPEOUOfuvguh990/0bACrk/Z9ROnI=
X-Received: by 2002:a17:902:ebc3:b0:2ca:2079:91cc with SMTP id d9443c01a7336-2d052188c55mr10360765ad.5.1785522146102;
        Fri, 31 Jul 2026 11:22:26 -0700 (PDT)
X-Received: by 2002:a17:902:ebc3:b0:2ca:2079:91cc with SMTP id d9443c01a7336-2d052188c55mr10360305ad.5.1785522145478;
        Fri, 31 Jul 2026 11:22:25 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04456dsm7203089eec.14.2026.07.31.11.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:22:25 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Subject: [PATCH v2 00/12] media: iris: Migrate iommus to iris sub nodes
Date: Fri, 31 Jul 2026 23:52:15 +0530
Message-Id: <20260731-vpu_iommu_iova_handling-v2-0-da52b5228dbd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANfnbGoC/3WNQQqDMBBFryKzbiQJGLGr3qOIxCTqgBpNamgR7
 95R6LKbD2/4/80O0QV0Ee7ZDsEljOhnAnnLwAx67h1DSwySS8VLLlhatgb9NJ2ZdEMdO+Lcs6J
 QrlKVFp0wQOsluA7fl/lZEw8YXz58rkdJnNefs/rrTIJxVsq2VdK00nb24WPM102Phto5BdTHc
 XwB8Cj1X8UAAAA=
X-Change-ID: 20260701-vpu_iommu_iova_handling-556e969a1f1c
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Stephan Gerhold <stephan.gerhold@linaro.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
        stable@vger.kernel.org, Daniel J Blueman <daniel@quora.org>,
        Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785522138; l=5190;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=cu4pPclpDZcAviAJxFeTJo/ayR7Q8C44r0iQltHM1U8=;
 b=d3AiWXBgtaAaCrEGWKOfCxWqFRgXkeBtOaBkJqnJrnN79zcPEKVePvs6z62kKYgh1SGjiaXHx
 adkvzMB0o6bDryLR50IVFmstuEdNdOR02QjO7POzRmzDdTwsJHemxd2
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-ORIG-GUID: CuLdDfJJpEX856BCwVpGMZxvG2W0CaTR
X-Proofpoint-GUID: CuLdDfJJpEX856BCwVpGMZxvG2W0CaTR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfX1LLiEVlRA5bo
 0/SKGRnFc8ufb4OuOw09rutafDynKMjBHiXO23I9pcS4aOlkXdFYvUNzkkcqTBD65C3maGy6HyO
 rnuSfgR3gR1vX/3IYN5q9NiM62MgeL31naG48ZUVOp3hyz46/cNHQHiEUyl4H+Dy1cYwEMOVvTM
 h3yQLwkfJfnJVkJwOJCHV+QnayF6fi4vd8ZGcVZktFESVen2kzWJJgR8zKIo8hfERXt3A6VpGIU
 f0SGFrNXsuhP58JnhhLiAjwLtn/48V43bJ4kt4SaQvO/m+sN40JNO+pwZeqviIX0IYKlWohZhUn
 Kz3Ew9lZLmkcorJctVQdAaDQQfjpvZOM9fUGXaSEiYIXk77Ob0qBPazGLeOq4HPIUmUK8HZthuV
 aXWT9hE+uCQpqZjJupGB7raHg0saqKRcJsi1fBEZKQfBLH0OcpkxZ7djskniR5rKKtO7pCTnwCJ
 OvnsHn6sGjnwAROWr4w==
X-Authority-Analysis: v=2.4 cv=SKZykuvH c=1 sm=1 tr=0 ts=6a6ce7e3 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=e5mUnYsNAAAA:8 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=yNWNZktwws4dcwluj8EA:9
 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDE0MSBTYWx0ZWRfX/g7PpzI0MWir
 imAlYV7ooCKvP/mvWG9QxyQwK3TzZcQbgwTrhT2n4kXV1UAICLPyfY9R3uPFky2jEEtyFL66kyv
 GbLxgBA0M0Z/tgSZvNWYLRCZwPEvPs0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_05,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310141

The VPU issues DMA through several SMMU streams, and the hardware does
not give every stream the same addressable range. The non-pixel stream
is restricted to use 0-600MB of IOVA space, while the pixel stream can 
address the full range:
    +-----------------------------------------------------------+
    | non-pixel stream addressable range (600 MB - 3.5 GB)      |
    | 0x25800000 - 0xe0000000                                   |
    +-----------------------------------------------------------+
    | pixel stream addressable range (0 - 3.5 GB)               |
    | 0x00000000 - 0xe0000000                                   |
    +-----------------------------------------------------------+

A single "iommus" property on the video-codec node puts every stream in
one IOMMU domain sharing one IOVA allocator, so nothing keeps a
non-pixel buffer inside the low 600 MB. Once an allocation lands below
that boundary the hardware faults, which shows up as unhandled SMMU page
faults and spontaneous reboots:
https://gitlab.freedesktop.org/drm/msm/-/work_items/100

Daniel, who reported the crash issue, have also raised a patch to workaround
the issue. While the patch partially handles the limitation, it is inefficient
in a way that it keep iris hardwares away from using the 600MB address space
for all the different streams.

To address this limitation, the subset of stream/s are now represented as
sub nodes, so that they can be associated to the respective addressable
range.
In the past, this limitation was tried with iommu-map approach, with iris
driver dynamically creating the devices. The approach was later concluded
as an hack to avoid having sub nodes and NAKed by iommu maintainers.
It was discussed in detail in the discussion
https://lore.kernel.org/all/c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org/

It was agreed by maintainers to proceed with sub node approach to address
the VPU hardware limitation.

Stable branch handling - one of the suggestion was to bring the 
workaround on mainline and stable, and later revert it on mainline and
apply this series. This would ideally breach the binding policy of
adding something to describe the hardware and then reverting it. As per 
binding maintainer, the approach is not acceptable.
This series can be applied to mainline as well as -stable, and in the process
if there are any conflicts in stable, I would resolve them.

Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
Changes in v2:
- Fixed sashiko issues.
- Moved subnodes into common schema (Dmitry)
- Kept the firmware name as the one defained earlier (Dmitry)
- Added dma-ranges to specify parent-child address translation
- Moved context bank hooks to VPU ops (Dmitry)
- Updated commit description.
- Link to v1: https://lore.kernel.org/r/20260709-vpu_iommu_iova_handling-v1-0-72bb62cb2dfd@oss.qualcomm.com

---
Vikash Garodia (12):
      dt-bindings: media: qcom,venus: Add context bank subnodes to common schema
      dt-bindings: media: qcom,sm8550-iris: Add context bank subnodes
      media: iris: Add platform hooks for context bank device setup
      media: iris: Add helper to create a context bank device
      media: iris: Route buffers to the matching context bank device
      media: iris: Skip DMA mask setup when the core device has no IOMMU
      media: iris: Create pixel and non-pixel context banks on VPU3x
      arm64: dts: qcom: hamoa: Add Iris context bank subnodes
      arm64: dts: qcom: sm8550: Add Iris context bank subnodes
      arm64: dts: qcom: lemans: Add Iris context bank subnodes
      arm64: dts: qcom: monaco: Add Iris context bank subnodes
      arm64: dts: qcom: sm8650: Add Iris context bank subnodes

 .../bindings/media/qcom,sc7180-venus.yaml          | 15 -----
 .../bindings/media/qcom,sm8550-iris.yaml           | 18 +++++-
 .../bindings/media/qcom,venus-common.yaml          | 51 ++++++++++++++++
 arch/arm64/boot/dts/qcom/hamoa.dtsi                | 19 +++++-
 arch/arm64/boot/dts/qcom/lemans.dtsi               | 19 +++++-
 arch/arm64/boot/dts/qcom/monaco.dtsi               | 19 +++++-
 arch/arm64/boot/dts/qcom/qcs8550.dtsi              |  4 ++
 arch/arm64/boot/dts/qcom/sm8550.dtsi               | 19 +++++-
 arch/arm64/boot/dts/qcom/sm8650.dtsi               | 20 ++++++-
 drivers/media/platform/qcom/iris/iris_buffer.c     |  8 +--
 drivers/media/platform/qcom/iris/iris_core.h       |  4 ++
 drivers/media/platform/qcom/iris/iris_hfi_queue.c  | 16 ++---
 drivers/media/platform/qcom/iris/iris_probe.c      | 33 +++++++++--
 drivers/media/platform/qcom/iris/iris_resources.c  | 69 ++++++++++++++++++++++
 drivers/media/platform/qcom/iris/iris_resources.h  |  2 +
 drivers/media/platform/qcom/iris/iris_vidc.c       |  4 +-
 drivers/media/platform/qcom/iris/iris_vpu3x.c      | 38 ++++++++++++
 drivers/media/platform/qcom/iris/iris_vpu_common.h |  2 +
 18 files changed, 314 insertions(+), 46 deletions(-)
---
base-commit: 95d6a9ccef99117115e41e9adb271243bd5e985b
change-id: 20260701-vpu_iommu_iova_handling-556e969a1f1c

Best regards,
-- 
Vikash Garodia <vikash.garodia@oss.qualcomm.com>

