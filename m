Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC013C3F4C
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 06:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294196; cv=none; b=XcDs/vJU4aPII5aXB/u7yjFZZc3pv/0ctAE1HouZ1bKGX3Uk1y/T2PpoiRR4ZIKr4mQmS38beHd+E3r/8J02r9kSppni3R21zZDtlwmP4Brx1DmQp6zM0HNzHXE3xr1CkaztfP4hwt3PiSWBlmavv8W+lcSgTx+PX2LfmD2a+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294196; c=relaxed/simple;
	bh=RarZbGpulP8iV7HiNc1e4BVeYUoDq7GNGkKAv4Gu4Vw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mwckLpB4JJK4MadCZksArUwF3fdVxVHL9iTbST9TwuuqtAFmXJHrC+u6C1oKz8OnIQ1zPJ/5zOJdaUPfJP861xJ5gJmmvKCitV93UfwXQA77l439hNctssE4eCNEkPxET4+xS6OrSqi8HFuAx/v9QvHbkub0FxeLG7fz8cbdjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=MI3F+Er9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=D+s3MCbG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="MI3F+Er9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="D+s3MCbG"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67L5Tcax1042271
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 06:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=nw/gwSZ4M1MHXOm0XJl8hc
	tK4ZwNsRl6X/FHG6JCAJY=; b=MI3F+Er9HkoH6+vXweySeufmoZGx4eNlqjsVpb
	el3519L/k9RsZHK7hjDjJ2BkImpyEszTm+u8xNOsOr4aq889AKdJRunMuQ/kpGMZ
	LaywodGKO1gIjJndXOpD002xORaCV1ONRWBQTA52F/1v2sZO3iKyXrPOAzm4BqTH
	VhRree8KICDusDgVqACQF+HVR5q/83Uju+Z0ZRpLU3ilGXT1Q3H+1lKviS2c6gF4
	wmNZ6tjFTiH1Q4He0q3KpRTKGaasDuQVq4IYC1ghTMc7np7oHMX2HV3t8IXROd4D
	NtBphWYspfznjOGbCuCs7StPbVgIbCVim+jzfXjHhWcjoKjg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g6fue0an1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 06:36:33 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e25e4b41cso741718a91.0
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 23:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787294187; x=1787898987; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nw/gwSZ4M1MHXOm0XJl8hctK4ZwNsRl6X/FHG6JCAJY=;
        b=D+s3MCbGa3Vh50GNsnzouUdjnds0DX0z1Dc6DrTN+akXATrjdNDeSTCNveBViATHlK
         u7BeV4ETnaSJM+//TJIzyXNiOd1dTnfPrC6/Ltkoiz1tyUsqYf0b8SxZVSsf1F3c8ZOm
         obryEVb/kwXE/m+a/pSA9XvPgBvuGHVMFA8bLf1xX37iAkKBxTOX9MIrPWetPfM3agAi
         cf+VcGKBkmwGQmly19k7NZoao9/7YYABvy7uj7YwGJ1Xr4PLlk5H/+/wKtxLDZmmM6K7
         Y5WP5Fibn5lVuvvRnWBUble21M0mUTFLzXgvAcQEU4GQak0hJv+v56tz5zOJuN7SZVf+
         FDcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787294187; x=1787898987;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nw/gwSZ4M1MHXOm0XJl8hctK4ZwNsRl6X/FHG6JCAJY=;
        b=sjZQ+16mrwdjdyN92tot0Td3K/6VxcpizpqYqjWXUOA6aRDUlS4ppm8O2nrmP5ZPA1
         CslXlEsEUh4xCjxjETSUDlxluNTwLLD/q3zTLNzeo+3jLf/EjtqTFnWtu6uSeXn4e73J
         GwQ8ktd7STZe2V+pbS0PaOTbz3FWHsqYYAle7zxCCSmnuGwkaSuVCabWUAkOwD/nF22y
         BSrRS958MAdnnYOEIUM4gcdusyaST0MOFnP3QVd1xdQMQBNIM20SyabNRgcWxbv2zRUf
         HTwH3LUWRSiCg0ED+G7WOFE67rvmRl56UXB3bCzGvo5xLHKzHvKUrUEImpcABPjMFq9G
         3Vlg==
X-Forwarded-Encrypted: i=1; AHgh+RrgOWA0qgz0jpbUqtQGwoEv5vdO3KHcXfOuUv3HzAlaygTg5edfVZA1ERsW/zqtC3/zcXFeqSY=@vger.kernel.org
X-Gm-Message-State: AFuF++mDLxXVAKpvnc6FG5n48Q5ujjZzwE57PknhWOJOLymLo40NQ5uS
	rjaD7Wao9uoZ++YQdNcG/Wyocn/XlmUHDeHKinLHyKqOOV+ELfCGIM0ZG55eTRq/87RzEtds4SA
	cHO35ZBD02WGsjrk2/nLChB+jD8iLbnjG7VzAaUrLp2k1GQiCZWuQ0VP806M=
X-Gm-Gg: AR+sD13yvg7RuXUAUgtQ0lcDijgAK0stJlaMSYc2PgyPF6GGrdkbRCLdV+siQiomQXQ
	0mikqFzHVPJuCB8Va8X3nlB5pVYnlFNL4t8G7Ja9qIvwhHrI2Nc8nJVEoTMCv1wd/GAdIc5/3bc
	xoZEiy/yegMjHlFYSBX/ngcVoR/l+KFjOJQWjwWw6GKpfpfW7s6jd98qdul24aRiBe3CiaAaWTV
	Ps5Kr+8waiJGUlbNJoas0KYylHYfakEuIb7B0DskMmKIS/8JHTj+fPtdcUNmiE2YiJF2fZ3a7SX
	b4BdGdvRRorom0iw4zZrq9icf3z+IWFqqYK2i0HkDRvKOS9rXxHH0wT5Cz1077YhsJNAHWCsbVD
	cBhIh2w+eD375SXdlAhVAlxovnvkph8nFw0JT
X-Received: by 2002:a17:90b:2f0d:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-395c3561a6dmr7864161a91.10.1787294187391;
        Thu, 20 Aug 2026 23:36:27 -0700 (PDT)
X-Received: by 2002:a17:90b:2f0d:b0:381:cef1:11ac with SMTP id 98e67ed59e1d1-395c3561a6dmr7864080a91.10.1787294186885;
        Thu, 20 Aug 2026 23:36:26 -0700 (PDT)
Received: from hu-vdadhani-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c4c3da9csm1787377a91.17.2026.08.20.23.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 23:36:26 -0700 (PDT)
From: Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>
Subject: [PATCH v3 0/4] Fix endian, overflow, and write-protection bugs in
 SE firmware loading
Date: Fri, 21 Aug 2026 12:06:16 +0530
Message-Id: <20260821-fix-write-to-read-only-firmware-buffer-v3-0-43e6a3abd651@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAODxh2oC/5WOuw7CMAxFfwVlxiiPlhYm/gMxpKkDQW0DTh9UV
 f+dFBYGBlgsXev6HE8sIDkMbL+aGGHvgvNNDGq9YuaimzOCK2Nmksstz8UOrHvAQK5FaD0Q6hJ
 8U41xTfWgCaHorEUCtTM6y1WCSnAWYTfCePkSHU/vHLriiqZd6Evj4kLraXx90oul97e0FyCgw
 HybKmlRSHnwIWzuna6Mr+tNHGxx9/KDLvnPdAkcskKXpjRJmlr8Qp/n+Qlh0HY8UwEAAA==
X-Change-ID: 20260819-fix-write-to-read-only-firmware-buffer-39ca7834e310
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Mukesh Kumar Savaliya <mukesh.savaliya@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787294183; l=2404;
 i=viken.dadhaniya@oss.qualcomm.com; s=20260324; h=from:subject:message-id;
 bh=RarZbGpulP8iV7HiNc1e4BVeYUoDq7GNGkKAv4Gu4Vw=;
 b=qVUEzVCiq/n88Tx/BazI3OYeazxJzggN8i3hyd9CesvYT3ZV/0yoGVlF71ZW+EKUljXvcoKp2
 zI7VRufskAoCe4sl3U9FHbeKIfa8r3ScfZdHKMdopBJY9d9PZcn2cTb
X-Developer-Key: i=viken.dadhaniya@oss.qualcomm.com; a=ed25519;
 pk=C39f+LOIGhh/02LQpT46TsUSXRvBn9qXC8Xb26KJ44Y=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA0NSBTYWx0ZWRfX2ZQ4e/QPm/85
 ShnEt6d+lo21nOoF11Ex3uc8LUN7vW87fH/Ub5LVJ6xsqN0Zq9rkBtBnC9zFlO5tIL9wFX8w2CM
 GvIsu4rP7/kOxx7oRHbWsvbIxtQd5Mo=
X-Authority-Analysis: v=2.4 cv=U9+iy+ru c=1 sm=1 tr=0 ts=6a87f1f1 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=XQMRRsFmXZ0RbJubXJcA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: No_3t0IPXFOQbsWn0JIpN210TLibJ_7e
X-Proofpoint-ORIG-GUID: No_3t0IPXFOQbsWn0JIpN210TLibJ_7e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA0NSBTYWx0ZWRfX0k7LEyoHlGy4
 OWATCVG6cxvtU1T8NKCeNmAZP3V626v2od5jVMKkZPyZsNNTNiLAXQwd1aitWu5P6ldZ9+76fZ8
 5vp846W8lCKWHDq2TaLPEmzJpsh0x75R4OFzc74YnE3L9TO3h4irMwbI159ntGkYflE90nF12e/
 KLfia80+9YVN/C8bkH5xFyI7ydZW98HxFMe334/d9YKsbV2yD1zX5p2Jj42BLzIPqaAG8cAa4Jb
 oDePIspXCbwq+c8U39Idw6cgVAOXUnTQ6yBvel2M8YYiWwEvglIfwfZef8dzYSBuTEXzOlQWgiK
 ghJYUagfrSz3FMLyWgE34AisJJ1F+vTR3GmYaGutUrIWGm0YyaXMCsC0RX86ZkMNLpyon7419+n
 egmgPRWQ/i49ZBcgdsq/XA10bdTEiRnEj+TRrbsXUiJfXmsCjWqN6Bb6VzrSkeaXd0Wscon8zje
 RywHWcLJTmSdnPsdyzQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_02,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210045

This series fixes four issues in geni_find_protocol_fw() and
geni_load_se_fw(), all introduced by commit d4bf06592ad6 ("soc: qcom:
geni-se: Add support to load QUP SE Firmware via Linux subsystem").

The most critical issue (patch 4/4) causes a level-3 permission fault
and crashes the kernel during QUP firmware load on CentOS; writing through
a non-const cast into a read-only firmware mapping is undefined behavior
regardless of whether the fault is raised.

The remaining three patches fix related issues that were uncovered while
addressing the above:

- The fw_end bounds check was computed from the unrounded fw_size,
  allowing an odd-word-count segment to pass validation but trigger an
  out-of-bounds read during the subsequent memcpy_toio() (patch 3/4).

- fw_size was stored as u16; incrementing 0xffff silently wraps to 0,
  bypassing the MAX_GENI_CFG_RAMn_CNT check and permitting an
  arbitrarily large copy into SE RAM (patch 2/4).

- serial_protocol is __le16 but was decoded with le32_to_cpu(), causing
  the protocol match to always fail on big-endian systems and preventing
  any firmware from loading (patch 1/4).

---
Changes in v3:
- Replace "the previous commit" with a self-contained reference to
  geni_find_protocol_fw() to avoid ordering assumptions
- Add Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
- Link to v2: https://patch.msgid.link/20260820-fix-write-to-read-only-firmware-buffer-v2-0-7badcdc455fe@oss.qualcomm.com

Changes in v2:
- Split into four atomic patches (one fix per commit) for easier review and bisection.
- Link to v1: https://patch.msgid.link/20260819-fix-write-to-read-only-firmware-buffer-v1-1-be86532fe122@oss.qualcomm.com

---
Viken Dadhaniya (4):
      soc: qcom: geni-se: Fix endian conversion for serial_protocol comparison
      soc: qcom: geni-se: Widen fw_size to u32 to prevent wrap-around
      soc: qcom: geni-se: Fix fw_end computed before round-up; propagate size to caller
      soc: qcom: geni-se: Fix write to read-only firmware buffer

 drivers/soc/qcom/qcom-geni-se.c | 45 ++++++++++++++++++++++-------------------
 1 file changed, 24 insertions(+), 21 deletions(-)
---
base-commit: e6664f2b33db9b6811eb4cec109f06cb2b4f458d
change-id: 20260819-fix-write-to-read-only-firmware-buffer-39ca7834e310

Best regards,
--  
Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>

