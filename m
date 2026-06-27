Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07151F1513
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 08:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782547636; cv=none; b=Wvsnh8ONcbf9yPJB7RMM0MKXl8HxiYxs3leIeWBF1vGhvK6CMIc82zkFkosy21FRA4bfs+uvpmr7uIL913GwMhQUUJBSQxACTwT9OTU8jmPC4iO2ufGrqXmV7glVsLEuyR4vbKbcfYF7o3XNvn7KVtrlTKdmh0Wa2MH9iaIMjg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782547636; c=relaxed/simple;
	bh=zXW1XafnasxL3ImW4DzgnyYlWRPzxh82e7LFGdDr9VA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o7SproqlvyGtQzXRY/U6uRYCZmxDCzBnrai7DLDABJRqcqBlSidQuV6xikf6X3W0Fmc2IyDHEcfjvnd+37nv95NstzqEePf0c9CWXDJETYyDw60+5quEjaCg/nY1OaFOKdz8UAIVLGv7z5BvNBFdVjdxh3A/mJakI3C8xG6ROOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nTIwn2MN; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=XLeQoSTR; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nTIwn2MN";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XLeQoSTR"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65R4BmkB067741
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 08:07:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=a2v9cSxlzqYTsoche+QEUyXPjVQP/dlUcd7
	xJmpAwLg=; b=nTIwn2MNeXouSw5NBjb/GBLYho1Vy2yoHCdNe7XFGLAuNlx2CYw
	sy3cBr6jlSfQwvm0LYHUtz8OxvI3E+bC0gEnu57yY7EgxJqFgClddjQXHuCszx/L
	nW0re2ecKFPP2WkbDPfM4+aSYOlIQI3PKazAaBKxFyC6wshJzZb+fvYadakPuyV6
	fabV2FfKqXN4zN+pOQ64ukBHWFLMnOF3jgUKsURiMMBBA5uMmt+s/F8ji+vLwIv5
	7McnAkIL1QFss0nZQXgfNwCT9JFZQQlXou7ccMT8fv+U40VfyAJU2biWgKGykifx
	vxv5dBzxYXuly+mwRc73Rph9LcGjmg6sLSw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f279cgbsa-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Sat, 27 Jun 2026 08:07:13 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bccca5620so2467920eec.1
        for <stable@vger.kernel.org>; Sat, 27 Jun 2026 01:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782547633; x=1783152433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a2v9cSxlzqYTsoche+QEUyXPjVQP/dlUcd7xJmpAwLg=;
        b=XLeQoSTRnXG8BEHCfQ+G+KdchfkyiEYhtyKfzRfCCwsBeNdRyY5I0uwHsgAIBjvwVR
         Y844h8BbH4oxD92RpOflozxulWD03N57pcOYae41NxOqCVaDNkUAMWrcrM/62x0aiMGl
         QOUjBkGjddpoah8YYQYSLtb9GNpadI42VKy3xwQyuFA19kdBM+rqmhmFOZYWJH51mLJQ
         u1Kj+ZiAYvVvBTtult5dfGycpccCqYEugV2KSk+b4hmdSZsv52fALMIVm7Z/qYyBBYCZ
         wb1Jr72qobA/kOa/6gLn9hNptEOinXehMF4LZ2rIIwqC61ShZQnFz1jS+99NV1GbP6po
         3iZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782547633; x=1783152433;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2v9cSxlzqYTsoche+QEUyXPjVQP/dlUcd7xJmpAwLg=;
        b=UJyDwrmc0j7uUJ3BEzZ0S7G7WyciXBCm5TmcOtsvV9x7b3HH+0kbXr6lKvtytoz+91
         3kfwGm+nkMBNIWrAM0A5J+T3c7f7mLjJfx8bfsI5r2jyTyidNzHEOCzbtSDXx/geQUBu
         3Ifd6QmlM5lLW/lG6vC55h/VD1Pe4hgJ4Zi2ojG9+RfSE/uGbq063Q4UtXJL3Cv6dkM6
         dP+d1dA7W0AM9MZhek4Gj46uP0S94SjJK+aS7LYnUTffCNdI5PzPUDfMWb8uljq4q7l9
         vs9pQ1S3ltLzOVZM6w61MVc0qQPPuDwyc04DBBnlCHcCYVqt1tHDoqVX5nya7UPvl8kU
         QysQ==
X-Gm-Message-State: AOJu0YyO4khFI1Or9XQjp61/1TFodlXmAHHXMsvz2G5b+iGB+Mzto4aK
	oqjG5gcQ32b5N3h+VvbYHdUTFxnMh27B/qN/21R4qcZqJpdxfEpmVHwE275E2fKqEU2SsGTOk8W
	UYUQUZV485WiJpnLON9a+EE3SYrEvxjb7JDlgPtuw/97yAkYfCWLJJccCQVTo4gtJoU8=
X-Gm-Gg: AfdE7cleDQo0k+VQHHVGaBxdnfXHI0xqdwY4+OYYygQ4AJ/xyO5UUYZlBHL+xLjG/No
	cFHpVCP2WgL1D5g6Pl0zjQgnG3Vhc2mL2Wkp66sULvaCVVKSvz14AipB/B1gCLcFehzwnP9I2xr
	xRVfmx3pKTaG43rFBxg/7s85jRp0sEDqaLPt0K+Z5t8miKCvIWJ7Pfo5V6ic03ZnDJukBKFzuHc
	jmtPvb4bg2VaBZFLntQOI0OD/+BZwji1cRLMPI8J9uYVRnkFITBn5QemFdjGoCWV/mhk3ydDpbG
	Z6tPxaPfoznIP4Ze3SG05swaIAj5gJeNVedz14EoKjZOfzAVnQz6yqoxd81xH6192ZmVz9U02CV
	KlswEEspZqlgVQYx1u/McXNBA0ms4/no1SGaA
X-Received: by 2002:a05:7300:578f:b0:30c:7dcb:c8fb with SMTP id 5a478bee46e88-30c84d51fc8mr10062459eec.11.1782547633046;
        Sat, 27 Jun 2026 01:07:13 -0700 (PDT)
X-Received: by 2002:a05:7300:578f:b0:30c:7dcb:c8fb with SMTP id 5a478bee46e88-30c84d51fc8mr10062408eec.11.1782547632263;
        Sat, 27 Jun 2026 01:07:12 -0700 (PDT)
Received: from work.lan ([2409:4091:a0f4:6806:2040:16b0:8991:15a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30d3af0d2e4sm3915711eec.22.2026.06.27.01.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 01:07:11 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
To: stable@vger.kernel.org
Cc: linux-pci@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org,
        mani@kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
        Paul Guder <paul.guder@example.com>
Subject: [PATCH 6.18.y] Revert "PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support"
Date: Sat, 27 Jun 2026 13:37:02 +0530
Message-ID: <20260627080702.11517-1-manivannan.sadhasivam@oss.qualcomm.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=evzvCIpX c=1 sm=1 tr=0 ts=6a3f84b1 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=xqWC_Br6kY4A:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=A1X0JdhQAAAA:8
 a=EUspDBNiAAAA:8 a=VmgAbFiIFK11awy29BgA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI3MDA2OCBTYWx0ZWRfX+sl+2CbjbSYU
 7ry6RrHH41CislIdhE1mFRr8esE93SkQpXnrDn8owvCYADzCQte2LruOuodxC13qF6bS5B/dx8n
 vmm7pxlZs/b4Dwb/Gbj54Qk/Sz/2pNo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI3MDA2OCBTYWx0ZWRfX4MqBFQr9Aj5R
 9qdLvMbIv77dNmfExenZYRY3xYIms9yUG1nCW9sPspXlTiNnHuPIA2koq1cHSzJqYHXlJPDHQPY
 7dYh6N29H1uVpl1hbKVYUVFiRfg0sSEx4qg247oNnUHtx9B4sZNg0/hJrKsHwoZ24TEuFcmCjIJ
 GnBgcHLiPWusQ5mUlro7dIq6WN75XLdf4243OyVf/wmdpticHcF+tYWOk+lSCTpPzjeHcR1UCR2
 Ny6zLj8PIg2yyWZIe0+IpbmmbQIwnCHtwTrEW7UZZ/rVSIVfZDqLL1sMoFCX5z7A8/pTL0Cdni8
 Mqonq7Pnfair0Kl4LTajQ+3ADF/b7kXak76R5etzw2lyCVKB9aHQufAFsNlrHSGpEoECVc+fX38
 C7wDe6uUQdirEJIra+RBDujmwdrjywwl3cwnU78rZ5UIg4Q77vJ2JCI7hB0XK/B/fPP46tl4i5M
 mrNWiw8C4ehkB3XPdvA==
X-Proofpoint-GUID: c6WoWaA_Z6beZGu0mrqQk8y2YpYm3DDG
X-Proofpoint-ORIG-GUID: c6WoWaA_Z6beZGu0mrqQk8y2YpYm3DDG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-27_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606270068

This reverts commit f176c47683bf6365e2f6d580d557fae49169a703.

When the Qcom PCIe Root Port advertises itself as hotplug capable, the
PCI core pre-allocates a conservative 2MB non-prefetchable bridge window
with 1MB alignment during the initial bus scan. However, the WLAN device
(17cb:1103) on the ThinkPad X13s requires a 2MB BAR with 2MB alignment,
which cannot be satisfied from within the pre-allocated bridge window.
This causes the device to fail enumeration:

  ath11k_pci 0006:01:00.0: BAR 0 [mem size 0x00200000 64bit]: can't assign; no space
  ath11k_pci 0006:01:00.0: BAR 0 [??? 0x00000000 flags 0x20000000]: can't assign; bogus alignment
  ath11k_pci 0006:01:00.0: failed to assign pci resource: -22
  ath11k_pci 0006:01:00.0: failed to claim device: -22
  ath11k_pci 0006:01:00.0: probe with driver ath11k_pci failed with error -22

Before this commit, the bridge was not marked hotplug capable, so the PCI
core deferred resource allocation until the device appeared on the bus
during rescan, at which point the BAR was correctly sized and aligned.

On mainline kernel and recent stable kernels, (v7.0+), this regression is
masked by a set of changes in the pwrctrl core that defers PCIe controller
probe until the endpoint driver is ready, ensuring the endpoint is visible
on the bus when bridge resources are first allocated. But those changes
cannot be backported as they are not bug fixes.

So simply revert the offending commit to restore the wireless functionality
on the Qcom platforms.

Reported-by: Paul Guder <paul.guder@example.com>
Closes: https://lore.kernel.org/linux-pci/CAH-zrtu1Bci7M-tQc9Vme9z+Bw=1gthM7z6=XX33Jjd_Q6itcg@mail.gmail.com
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 43555ad9e5dc..789cc0e3c10d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -341,20 +341,15 @@ static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
 	dw_pcie_dbi_ro_wr_dis(pci);
 }
 
-static void qcom_pcie_set_slot_nccs(struct dw_pcie *pci)
+static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
 {
 	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
 
 	dw_pcie_dbi_ro_wr_en(pci);
 
-	/*
-	 * Qcom PCIe Root Ports do not support generating command completion
-	 * notifications for the Hot-Plug commands. So set the NCCS field to
-	 * avoid waiting for the completions.
-	 */
 	val = readl(pci->dbi_base + offset + PCI_EXP_SLTCAP);
-	val |= PCI_EXP_SLTCAP_NCCS;
+	val &= ~PCI_EXP_SLTCAP_HPC;
 	writel(val, pci->dbi_base + offset + PCI_EXP_SLTCAP);
 
 	dw_pcie_dbi_ro_wr_dis(pci);
@@ -554,7 +549,7 @@ static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
 	writel(CFG_BRIDGE_SB_INIT,
 	       pci->dbi_base + AXI_MSTR_RESP_COMP_CTRL1);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
@@ -634,7 +629,7 @@ static int qcom_pcie_post_init_1_0_0(struct qcom_pcie *pcie)
 		writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT);
 	}
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
@@ -727,7 +722,7 @@ static int qcom_pcie_post_init_2_3_2(struct qcom_pcie *pcie)
 	val |= EN;
 	writel(val, pcie->parf + PARF_AXI_MSTR_WR_ADDR_HALT_V2);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
@@ -1033,7 +1028,7 @@ static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 		writel(WR_NO_SNOOP_OVERRIDE_EN | RD_NO_SNOOP_OVERRIDE_EN,
 				pcie->parf + PARF_NO_SNOOP_OVERRIDE);
 
-	qcom_pcie_set_slot_nccs(pcie->pci);
+	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
 }
-- 
2.51.0

