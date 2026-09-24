Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981D497B79
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790260264; cv=none; b=m6l2kVOWV5Vwxy3qLzSRx8Wl9DnF6KjfhHVL7OQWfyTsXkNZ/gyF/ESwLS+Cec1tCHKkcWqeFS+R/SUQqpOeiy9vmMohqpHG0BGt/vBIg0x5/nZAGSEX9buq/J39Id6EcquX+IR1IFAOgR1kw1ChIplB5BS1wlmd4/ZVpKfSs5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790260264; c=relaxed/simple;
	bh=WvJzVZ93u/jnZMmTJFoA1CXtfvTl0ya7PkrEGzPonGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YIDX8OjOW8f9mw3gIxkrFTY9liux1e7Og2RIExQcoCi4WCkHpoT13I+nG8KDgNvsJMZJVeeUzjDNTKuipkeX7fIqaFnBihTVXg2/dsE9Dx0FZQheU5NkP14/XXhBbLi8JmpIt40KtOenFXgnNrp2sgfvlcNDYbB55pK4ML8Y0H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N8ksqOCR; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fUP2+ofg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N8ksqOCR";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fUP2+ofg"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC4VRa3282827
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=ldpVhahcAZ5SyKKj/a7T0l
	AqAoDK8x+z9W+veZE/Ybg=; b=N8ksqOCRAcbu1+ZgQpRSUb3UIXuGOzoTPH4pZS
	xLCydb/IwGzn57lRC+x9mDL8nAnXEsrOgzd8MlgKcNOpzHaygJdXAJoD7NfE9DAV
	0ffvKtdVrTPpplVWz/KFzZsS78ZhpT7K/po3o7ZtnDoqbgtALiJesQhOSLwbY2il
	V+XDheNPuo3wMiJe4PBZhNHLfc75QXvVVTa3OLb3HVJ32hgevOQG0k/gZdEZQR6g
	wsd5PsAbEzTtd8MnnLUMUFqKRnQik4rB3vUKvdtiVNYVUIS8S9cDO/KH5fSEI5dp
	vkajSlHpaVc46vNUp8sZVSgpEwCH5Ut67xE6LbBSxBZkAN5w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gvstuk2x8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:31:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2d9336581a2so29610625ad.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 07:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790260261; x=1790865061; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ldpVhahcAZ5SyKKj/a7T0lAqAoDK8x+z9W+veZE/Ybg=;
        b=fUP2+ofgy9tTQ5Ou5R/D4qsJRxRo4DTmvMb+444E5KjxLFqAZEf6Be7avoPegmFXWg
         n0hhSDSIfM8KxT0u35P7Fn10wdQXYYugyitDun6+YcUWyYc1x4tiw+xONZ1Ij9wXYiMC
         bzBKHqgRwXxZOAhKPJypLf1fK3xvzI0EIOf+huuUYcXLnyCSStd6CIsWv3P4zACs/Xvy
         OgWxQ27QhIWbNFJvJeIS2PEDXyAExrja/Kn/tp23bdTIhVmFImTXXjJP5o+Lp5VY4AhY
         E51+Jffz4HNNwZ3sh965yvZLFmwHvQZBiXypjrHWR5T7/WhfGWXKtkgl3C8A+Oi//H6l
         j+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790260261; x=1790865061;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ldpVhahcAZ5SyKKj/a7T0lAqAoDK8x+z9W+veZE/Ybg=;
        b=b3LMTyfuVAuOcAj8TTWiIR6sh0mgiVeOjFNQNdVUIK++Fh8YzPM84mN0yxDR3rhRAt
         kIx1AxC5a/ApivI5bfLPtp6mZxqWbyk7A42GOJZuPZrnxRqfeMPS/qMSvBCsToHSyZMd
         Hkm/xr48hOp+V7I22sU7hb29IhS0ZmsbbaB9Nv9+aCZAqmg7XM6OZjG7UVdfHkTJrb5R
         wcNEw41VkWXyR0bPZWurvsJPNZavPUBcYCy3oRi0HYss/kdgHiDp0ZtF5qu2M2lx0tqM
         ygdpzEtXTD7HD0vWngjcHVpZDvRDOj7BfOs0tpxox+3F7jftodoka2hKxTzj7ZaaHWqE
         2sFw==
X-Forwarded-Encrypted: i=1; AKwUvBzqRBrNR/FT3DlkQWLkWfk3shM6XvRDlYFxgwupZ8l/V0k2p5syng0NruZav5bIS+ANlX7KrHI=@vger.kernel.org
X-Gm-Message-State: AFuF++l/PnbLuRkgrw+V6LDXTn7Nxi8YPMFtv207GMrPuZvej9AlJQ6e
	K4qrH+P+BlKWsDwl+cYZoGeUK64Aw6j8gLcgRbB+10mNIqPbN/jAJLyqM3kgkTJ4NPpi+RqY5tp
	Mor/nTFTiwLotJaeuwMp0lOW7cSajttOluqkoaMmJ9ADkFw0lBMODaK4Hsf4=
X-Gm-Gg: AYBFou0BkdskoLBR2MpmmeFWdvD2A9gGqvzoVDCFEqpA7OYUVNGRwV6+DFTZKwqB/xO
	6njuwMnqQXOnWKgq23OTa9/W4Xxin3DBjChn8jWSu027L+Bt65Ih9hPCscU1U3UOD09ZV7HTnmX
	/7u77586X5WfoMcXI/awNahsvJefwoNmMqm0II6i5jM70GZk8OA+Lthp79vK2B1h64Kz9D9ULKF
	kUAUYrz7d0vrwR2ozKIpZkqrV+IWMw9dqOsAnxfjjL3yiElyBtFLYvMjKOCtHbnffK7TVQwVj49
	ML22+pumgfedpmFRE7M9ko9ZcuhtVi2eEbT/bv2GoQ7j1vCGYkqURRyVfGDRXnAVnwZ23MAr1pI
	qVzL0Ix1ufFpB1Lo+qZX9REhJy8YHaXXJRDbO5pQcpNri
X-Received: by 2002:a17:903:2ac7:b0:2dd:ad74:ac7d with SMTP id d9443c01a7336-2df7e27c485mr25943755ad.24.1790260261353;
        Thu, 24 Sep 2026 07:31:01 -0700 (PDT)
X-Received: by 2002:a17:903:2ac7:b0:2dd:ad74:ac7d with SMTP id d9443c01a7336-2df7e27c485mr25943235ad.24.1790260260770;
        Thu, 24 Sep 2026 07:31:00 -0700 (PDT)
Received: from hu-vgarodia-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5c3160sm28994415ad.40.2026.09.24.07.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 07:31:00 -0700 (PDT)
From: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
Date: Thu, 24 Sep 2026 20:00:54 +0530
Subject: [PATCH] media: iris: reset AHB bridge before enabling HW mode
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-vpu_hwmode_fix-v1-1-531498f3499a@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAB00tWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDSyMT3bKC0viM8tz8lNT4tMwK3VSTlETD5GQTE/MUAyWgpoKiVKAw2MD
 o2NpaAM/taCVgAAAA
X-Change-ID: 20260924-vpu_hwmode_fix-e4da1cc447d0
To: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>,
        Abhinav Kumar <abhinav.kumar@linux.dev>,
        Bryan O'Donoghue <bod@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Birk Skyum <birk.skyum@pm.me>,
        stable@vger.kernel.org, Renjiang Han <renjiang.han@oss.qualcomm.com>,
        Vikash Garodia <vikash.garodia@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790260256; l=2029;
 i=vikash.garodia@oss.qualcomm.com; s=20241104; h=from:subject:message-id;
 bh=WvJzVZ93u/jnZMmTJFoA1CXtfvTl0ya7PkrEGzPonGA=;
 b=Fsx6oom71cJ122h37d6jT2FTuZCNGrBl4UQN7681bQwbDGKwbchyDpt7q2uEacGxdn2OuJ4mg
 v4qtkGa+tvNBQo1BAKCz5xaxwu39eRbgpreg9nP6oUcHU8AGu//lyfN
X-Developer-Key: i=vikash.garodia@oss.qualcomm.com; a=ed25519;
 pk=LY9Eqp4KiHWxzGNKGHbwRFEJOfRCSzG/rxQNmvZvaKE=
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1OSBTYWx0ZWRfX5Ts23jxQpWrJ
 I1BK77SyJRV1DFpOsPFd4bjIjl2TYi12TRfPGcKjaqf75lKfpGLPOzPymcLlKHHy5LLpnWEc9pO
 O80neYQNZ5+3My7V/zIkgzypkb6ixYI=
X-Proofpoint-ORIG-GUID: x8xdizC4YT5AAdXvBdmcWdiYJOqJksJd
X-Proofpoint-GUID: x8xdizC4YT5AAdXvBdmcWdiYJOqJksJd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1OSBTYWx0ZWRfX/6lH8vmJA9RR
 ryVWyfcpqZIeVCbxkdq7hGrnR+z3OgjZCVoq7HzMs3HfJybnsPC0ppFTXBnfZnDORgHdaKC7clS
 16wN16sJriQ4RM0hBeKrGwWov4IuWDP9E9XP4uu1d9KBeBTc6i0I3TEXcHQ9axykBJNoOmk+HRH
 U4ZDmDeqy60DQ02lJZFJYje/KIWcsIyLi3H03UgYmLFzSJwmD6663K/Kef4vcoy3cF0pWbJG792
 rErp9DaS7z1z3mWpcnbZDAaTtvZAqTnL3y3iluQ2gnQBFxN8iyh4OvVV1BZyQXv0RhQAI0ezxSk
 dxO8wxiR5B/Bn8mJuEkoCE4AUQeMXYo1kMSx08AkZo3XuzZ2UP8EYhVFGkippSYZjHS/axP7i8C
 Oi2ebiFprv4d+KBw0E58mE021sJvptO53iZKNB9+pW0GuAddFdrnW/0fVm5LpxJOOZgVW3HotP1
 DfqdOLphRJG61X9qwiQ==
X-Authority-Analysis: v=2.4 cv=cKp1IVeN c=1 sm=1 tr=0 ts=6ab53426 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=XKV6TwXv6a9nc5w5uhUA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240059

When video power domain is switched from software-controlled mode to
hardware-controlled mode, the core may be powered down without the AHB
bridge going through the required reset sequence. This may leave the
bridge FIFO in a stale state.
Reset the CPU-to-VPU AHB bridge before switching the power domain to
hardware-controlled mode. This ensures that the bridge FIFO are in
reset state before going for mode switch.

Reported-by: Birk Skyum <birk.skyum@pm.me>
Link: https://lore.kernel.org/all/20260913194707.91885-1-birk.skyum@pm.me
Fixes: 95a337f92f0a ("media: iris: switch to hardware mode after firmware boot")
Cc: stable@vger.kernel.org
Co-developed-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
Signed-off-by: Renjiang Han <renjiang.han@oss.qualcomm.com>
Signed-off-by: Vikash Garodia <vikash.garodia@oss.qualcomm.com>
---
This is tested on X1E80100, and is applicable to all VPUs.
---
 drivers/media/platform/qcom/iris/iris_vpu_common.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/media/platform/qcom/iris/iris_vpu_common.c b/drivers/media/platform/qcom/iris/iris_vpu_common.c
index e4847c1077097160cfc8324e807b4aabd9747812..2ef8004e976e34ac3e5ad1971894253fee77648d 100644
--- a/drivers/media/platform/qcom/iris/iris_vpu_common.c
+++ b/drivers/media/platform/qcom/iris/iris_vpu_common.c
@@ -311,6 +311,11 @@ int iris_vpu_power_on_hw(struct iris_core *core)
 
 int iris_vpu_set_hwmode(struct iris_core *core)
 {
+	writel(CORE_BRIDGE_SW_RESET | CORE_BRIDGE_HW_RESET_DISABLE,
+	       core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(CORE_BRIDGE_HW_RESET_DISABLE, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+	writel(0x0, core->reg_base + CPU_CS_AHB_BRIDGE_SYNC_RESET);
+
 	return dev_pm_genpd_set_hwmode(core->pmdomain_tbl->pd_devs[IRIS_HW_POWER_DOMAIN], true);
 }
 

---
base-commit: 3d7783543c2646af69ad65825e810060494bea21
change-id: 20260924-vpu_hwmode_fix-e4da1cc447d0

Best regards,
-- 
Vikash Garodia <vikash.garodia@oss.qualcomm.com>

