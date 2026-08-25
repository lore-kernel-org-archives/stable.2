Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D95D3E9C18
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787649110; cv=none; b=mluKNJNGzrd1z1mSpo328FNEJONUylaTRZfrVpH6JYQtdPfeXm8RRs1tCifrW6hiamKf1IN6oOcH0Un5AhM+Ak5LHWw6bsTWpErGGzEsMvtzH55MHhMDW7BPT6oGiSW07PiUxpcI9to2+NHg3/nwH4nDu/jH8ig5mHQuXFiNLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787649110; c=relaxed/simple;
	bh=IJM12IPhydPMhVfgKAD3r1R+hMTUt/15MFROcI+Z0fY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=UKusBTpv+3HUi3xlc9IMH+KC5s43iU+ax7BAJJ5SQUgO/i+ArzdZ30YXzeHdl0fuygvK8TI/EuwXw0RmgnlIYXw3rDUawp+Ep/F4spPe39yykVRq/vgtaYnUWN/J9vGCUekwwTXFFcgvM6WHO/vD2a5lHtp4ZVt76njrN4uTXZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fhiuw5Ez; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TzUoQf+I; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fhiuw5Ez";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TzUoQf+I"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67P88QqF196255
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=P4U1vKKGfvsW3iPMjF5IU+
	stSAtAMqxWdBp0JhDoid0=; b=fhiuw5EzKiQn8wsZnJKIEsnbHGR6yM9HywjfsP
	bM0BBGxudparrVcEB1xOr2i+7cPegsEqhA6R/3PuAHgabYcDVYjkJfGhsAG7Seav
	8TAIlIJ0UT2pB5nzohvZ+u+Z6TYLaV8wxXflGaFROjjKzey1ez7fUtU3mS01M4Ij
	gm4clV50QQIeLO2JlRrAJe/r67P3XabCF3CVEQvMgkMieBN8A8iVxmD/eS5zIaOd
	pY0clRCE9zryEhmbCvjnXhS7/HjF9AXjL1Q+sCHfS2R2IjJUcRb+InGnOMQfdXSX
	fnkKs5g+Dqy1sUrdIdWMpINaM2tM/SBQl7mjFzVwlh95YUtQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g93pvh3nn-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:11:47 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3954def0191so8129732a91.3
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787649107; x=1788253907; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P4U1vKKGfvsW3iPMjF5IU+stSAtAMqxWdBp0JhDoid0=;
        b=TzUoQf+IhO9Vj4V9vclhi+huShX1KTaG8cPycfTn2tv96lmsy7NtJLFM6RLnXRThID
         6N4D6jXVE+kmuEDBPOey+eZmiBOtMb95DjQmAt3QPo53fvsx4AONaG06bzl1WNW1KYSq
         U3eayVgHvCM6JupLJiNzMSLF+eZNIVmOzywDxVVRkop/MHpGxcOPjuyPxROq8opkp8Vl
         22ka7GNJ66n+XRhFWgPev26vP251YR3v4pDQbRuzLWs3SzhoMrwsGj/X0Zgy39gjIbLw
         5VO/DAadFLOlgRsgxt7rMr6gYEzAHaqCfHGXzjCIAZ/r/60AQNZ9AbBM82rbW/TqAJ5D
         Y5kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787649107; x=1788253907;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=P4U1vKKGfvsW3iPMjF5IU+stSAtAMqxWdBp0JhDoid0=;
        b=Lxhlqm2lv4vhN8QCaD3m1VqdCGwUe4IsNLw90e0q85N0HweNGfOCgZINSVaTZCg49y
         WJtbYCMHnT7K+/7fPS7EKqHnSU7kRBwam1kGT9lwCh/V58PmcQJ59cZelX4fcItNtTT/
         5EFjeTM9whvWaXY7ddAXbYciyRoWrEJYj+T4+f9ysC5TWIr1WzHoyitN4gAU3OgCsLXE
         5fExKzzDLY/UbHeBRveuUKh3kdcze5P2D0LkbXJ1uU1G5tze3HeXr9W5l8VuLQU/7O2D
         kF1MmXrbj4cfFOQ456f5pW9FQ5Aexd3/DkOhWsSi343y5U2b10vFicRywzZCYYV+8kdk
         bMRQ==
X-Forwarded-Encrypted: i=1; AHgh+RppNTUj1/VbPrWLOVzZvo6UObS0pA+6wwFvambFnq3kZwIUEwxQN6XCudRNGD8kLNp3B3Fva08=@vger.kernel.org
X-Gm-Message-State: AFuF++lWyTXuSxxxgPohj4Gk1+tCZBhDgUImfV6vcUY6GYqnagDlWezF
	mRqvCRQ4nKHXf+jTQCASwERUpTNxazGYW6IZV4M/SZMRCvL4w8/CMhSbMCuxgW/Bd/eJpy6j1z1
	cV9wNFZ3PLNbq8ZHrHkbPc7z2SHBDuNpU8A8+c0ytuiak/D/LUekISAqNGGg=
X-Gm-Gg: AR+sD12ev05Dggod2AsgOd33oUwNGgh4dNyF4fapYYRtiLA876Wq3TeW5U4MMzmhHLi
	0OCwAXdEkMqlhQgRn60H0SxrHx4RHbzLyf6QQuGMVKjs9UkUbCaOCnceB0p+aTe4owixylevXgU
	aY5/yiY5ZkHRUMvQSyLJGSZXd8UdpPAU5AFA+34cFhYAzf5ktF+Q8D0qtHAcis1CpCsKGn5skwI
	pK8ZxOkzBa0zOp3qAvjGVfCNkIL6OxNneijGiSnNUHY+I+l2C4eoIh6zWmvGW4YAAbFOWDHCcAT
	wiys5k+V7kwq2IKxurLzAwD5V9cQOqtjaU0ByH2oVXH8w+VxTRjkGWlXQbKySfkx5n7VW6ctDIF
	f1BQPhB1cOuUOGe47HTwaK9TiaOqA48URuw==
X-Received: by 2002:a17:90b:4a81:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-395c34fed98mr54562633a91.4.1787649106740;
        Tue, 25 Aug 2026 02:11:46 -0700 (PDT)
X-Received: by 2002:a17:90b:4a81:b0:381:a766:efcb with SMTP id 98e67ed59e1d1-395c34fed98mr54562526a91.4.1787649106314;
        Tue, 25 Aug 2026 02:11:46 -0700 (PDT)
Received: from hu-ketakish-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3965d119724sm895766a91.2.2026.08.25.02.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 02:11:45 -0700 (PDT)
From: Ketan Kishore <ketan.kishore@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 14:41:41 +0530
Subject: [PATCH RESEND v2] amba: bus: Fix race condition during DMA
 configure at IOMMU probe time
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260825-iommu_races-v2-1-49de6de71357@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAExcjWoC/22NsQ6CMBRFf4V0toS2QMHJQVYHHY0xpRSpEaotN
 BrCv1uqgyQuL7kv954zAiO0FAasgxFoYaWRqnMBrwLAG9ZdBJSVywBHOI0oiqFUbTucNePCQBa
 TlPCc1XmGgVvctajl09OOYF8cit0WnD5/M5RXwfsZNTcbaXqlX15rke9/DcnCYBFEkPBYVIiUK
 GNko4wJHwO7cdcK3fECi38RdInADlFFJaVZjmnC6j+IaZrefLfxYAoBAAA=
X-Change-ID: 20260714-iommu_races-a4363c9af982
To: Russell King <linux@armlinux.org.uk>,
        "Rob Herring (Arm)" <robh@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Joerg Roedel <jroedel@suse.de>
Cc: kernel@oss.qualcomm.com, Robin Murphy <robin.murphy@arm.com>,
        Will McVicker <willmcvicker@google.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, Ketan Kishore <ketan.kishore@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787649102; l=3320;
 i=ketan.kishore@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=IJM12IPhydPMhVfgKAD3r1R+hMTUt/15MFROcI+Z0fY=;
 b=0U42JO1fVzs55rtzLetyDoRhGmBMGfCcfn/oEopbGzFncYkkZn+5kCZOeArp0goFSshVKBreU
 h+JAAMv4e9OCCZizZ/70gP61XBKXTacOGKcSWZqA523nZ+78Gi1JFHc
X-Developer-Key: i=ketan.kishore@oss.qualcomm.com; a=ed25519;
 pk=4sb5Ima5x03wc0KSnl57v8kR/7FxMt01+xlZJ53rSJU=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI1MDA3NyBTYWx0ZWRfX1v547D1zMpD9
 jcm56oarqeG1AGuJNdxc/j/BWrKVclYC6vKoiYLV7+Jg0QA7CJnS7y32qiKg0aRTds/NEyH/7k7
 l8//mJb/qDuT/k80ptZu5s1dC/xqgaw=
X-Proofpoint-GUID: hu7BRDDhMnKB5UkvlWT9YWkFd3aPCNcy
X-Proofpoint-ORIG-GUID: hu7BRDDhMnKB5UkvlWT9YWkFd3aPCNcy
X-Authority-Analysis: v=2.4 cv=Ru716imK c=1 sm=1 tr=0 ts=6a8d5c53 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8
 a=7CQSdrXTAAAA:8 a=1XWaLZrsAAAA:8 a=9jRdOu3wAAAA:8 a=DEt-5Vgr3fpEtGrxzCkA:9
 a=QEXdDO2ut3YA:10 a=iS9zxrgQBfv6-_F4QbHw:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=ZKzU8r6zoKMcqsNulkmm:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI1MDA3NyBTYWx0ZWRfX9ntYbgS8bHH/
 LPG+/Zn8uN480LG7PxmRgqH81axLeTWhcQN9JyOU74r+ab1j2A40IxWjpy/2PtVVsnV+XkAlXrS
 OARCNiWmVRM08bvLdFR5LhvajOOG5HUImCEi4ngzOtWimgpIrF3a7+NJ5TYhExIAkNnu6or/y5A
 qnJ0MMZmhl4m+f0juRZRSyDS7az8vXoID+xLKUuVnVuQsGP4hChTlZQE8VFo4fVI0YkUGs/Y4PF
 Gscmx6QgeMFRGBe22ABW1Fjtli4s8zQveOrvL9lWh/vOiAnuAr6rBb9KFv1udNf+n7EgfW3E3se
 RCaSFXsVx3prV6C909xjXEc1bzgdjsg80aE64zcuWoYxtLCf/psBi5suJaDWTJ16mOnUOMouC4w
 cxIXUl3tLc9BDNiURROMMGUKurKR0wwpjDVv3puQbg+5KyatY9yi5DyTPCBIHPA0b4V2NWX7bJX
 vJ+TEF7ydRzYYTVwNVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-25_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 impostorscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608250077

amba_dma_configure() can be invoked from the IOMMU probe path while a
device's driver is still being bound asynchronously by really_probe()
on another thread.
Call trace:
  amba_dma_configure
  __iommu_probe_device
  probe_iommu_group
  bus_for_each_dev
  iommu_device_register
  arm_smmu_device_probe
  platform_probe
  really_probe
  __driver_probe_device
  driver_probe_device
  __device_attach_driver
  bus_for_each_drv
  __device_attach
  device_initial_probe
  bus_probe_device
  deferred_probe_work_func
  process_scheduled_works
  worker_thread
  kthread
  ret_from_fork

dev->driver is read and converted to a struct amba_driver before it
is known whether dev->driver is actually set. If a driver bind
completes concurrently with the IOMMU probe path, the
driver_managed_dma could end up being dereferenced through an
invalid pointer derived from NULL.

Update amba_dma_configure() to read dev->driver once and test if it's
NULL before using it. This ensures that we don't dereference an
invalid amba driver pointer if the device driver is asynchronously
bound while configuring the DMA.

This is the same TOCTOU race already fixed for the platform bus in
commit 95deee37a123 ("platform: Fix race condition during DMA
configure at IOMMU probe time") and for fsl-mc in commit 152f33ee30ee
("bus: fsl_mc: Fix driver_managed_dma check"). amba_dma_configure()
has the identical pattern, so apply the same fix here.

Fixes: bcb81ac6ae3c ("iommu: Get DT/ACPI parsing into the proper probe path")
Cc: stable@vger.kernel.org # 6.1+
Signed-off-by: Ketan Kishore <ketan.kishore@oss.qualcomm.com>
---
Changes in v2:
- Change the patch's commit description to only CC stable for 6.1+ stable kernel branches
  and not for all stable releases prior to 6.1 .
- Link to v1: https://patch.msgid.link/20260715-iommu_races-v1-1-3c4ed13b18a3@oss.qualcomm.com

To: Russell King <linux@armlinux.org.uk>
To: Robin Murphy <robin.murphy@arm.com>
To: Bjorn Helgaas <bhelgaas@google.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Joerg Roedel <jroedel@suse.de>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: kernel@oss.qualcomm.com
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-kernel@vger.kernel.org
---
 drivers/amba/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index d721d64a9858..0cdda7e07af7 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -324,7 +324,7 @@ static void amba_shutdown(struct device *dev)
 
 static int amba_dma_configure(struct device *dev)
 {
-	struct amba_driver *drv = to_amba_driver(dev->driver);
+	const struct device_driver *drv = READ_ONCE(dev->driver);
 	enum dev_dma_attr attr;
 	int ret = 0;
 
@@ -336,7 +336,7 @@ static int amba_dma_configure(struct device *dev)
 	}
 
 	/* @drv may not be valid when we're called from the IOMMU layer */
-	if (!ret && dev->driver && !drv->driver_managed_dma) {
+	if (!ret && drv && !to_amba_driver(drv)->driver_managed_dma) {
 		ret = iommu_device_use_default_domain(dev);
 		if (ret)
 			arch_teardown_dma_ops(dev);

---
base-commit: 49362394dad7df66c274c867a271394c10ca2bb8
change-id: 20260714-iommu_races-a4363c9af982

Best regards,
--  
Ketan Kishore <ketan.kishore@oss.qualcomm.com>

