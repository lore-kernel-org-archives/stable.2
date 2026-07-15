Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E9D3CC323
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784104169; cv=none; b=LrQmrs/dxiTkcWL8/oRLQjPIJeFCMnfLIWQ2Xwld0Z4ZkekJJK8I5ONuGbQsgV500XW5sesreZNImjrVFf4HMeK6DqdcMVsBM5dysIDqElqZ3BqWeNh2PD6EwesUlkSj3h9yh3WUztxdS5T0+U18ytTCiiCJFxrR0HlA14lun2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784104169; c=relaxed/simple;
	bh=4UvLxkyBynXuQZUY7ckV2hbCMLktaiLT4kV3hfGcfZ0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CsJcX+H2HXhsu/+F7gcXTsV2hEiat5J9N2eglt6PFRChUR1lx8XkN2POqu8cXKtjhNM8UAUGbvHXYZBRo9/YEI3HJkQu31S+WSvau+8Ty3NGg9dma0VfZJkU1U1wFx4y529n/LAMH3daMt6ZM2XYDyT7RKO9caOE7jtMbQfKewc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Er+kpEBJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fO0pnj9V; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Er+kpEBJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fO0pnj9V"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66F3l0tI2372468
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 08:29:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=/0UzOPQcHXSGBnMwvBIRKH
	G8Ztpa4Ze3Dr2gowK93mE=; b=Er+kpEBJ2BA4UeH2FPkiVl4pn2D4itI/0YSd6o
	0RUKnYJEtEI+rwHooubhPIkHzEtb3f30lsnSRqSS8ILgjYjB+QVHyRe+wlWG9uN9
	z6IfYOb+SkwaOXVcNCqcjF9/QFiBf5X9VynppE9OjDBaLyCchuR4FR+u98idDNOK
	K8Ye3jKpfdae0MKSySI69Hfl/VTIePnm2rBAKH4N+wuJRoe20kGZ3JDkHmUAEGZJ
	f3qOW74Vk5TwfaLpb11YTIXVZKOmebJ16iV+VpOsmJGIWfzlgV9xSu8cer1vBhCa
	wY8DRaJiQ8W8xY6xpBgrospe4rZVBI0pkmWdOAmRWYe0DiWQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdmkk433a-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 08:29:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38e2237bc43so2153176a91.1
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 01:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784104166; x=1784708966; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/0UzOPQcHXSGBnMwvBIRKHG8Ztpa4Ze3Dr2gowK93mE=;
        b=fO0pnj9V9N7mObUJE8+LqkDfWJabkhDui7dKerGrQk4dSSaBhhjqBkiGtL0du3Ym+V
         LBbe0+mPbWr/y7ScOTPP+QWSWp81VCl3V1UNEOtuE9eK4S5KYvxYF6wPzedQ188GtRNc
         AAuZEHgvkkW9a8QSIMLA+YXv1QMEW38traoobENQt7yCKqiEm5w9CAI4pIEOLwHF1zoI
         FpAzz9pCN077Y37fUwwq5LFsfRC3MUrQLr7caDVkE7KtKKrfDUPXIAwa2jSxJ6DV2DQ6
         oyPItq8f9XXqQGDrwjF6r1ehPasbj5p+KtxOxXm4BVydIEBfg+y9qBNs5lXLmtOXb1mB
         2Hxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784104166; x=1784708966;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=/0UzOPQcHXSGBnMwvBIRKHG8Ztpa4Ze3Dr2gowK93mE=;
        b=G7HhXmg/muKr3TpZsyOMDw/GT24EdIsBWz8Htfh6ecJyGic7Gdkiaxomcp69g/VeJp
         dKMPTv10BEs4M6h/mjlEO8YAmxxoRZzvA4wH7TKUV5WoIXe6L7EfCJqut+dEp4GCqffa
         vkOWyxrsXWknWkpFopUgzzQxXu4DtxQmAIt0V/JWL/IfXECn3A//2ffXXfujDBZy9tDQ
         l3SYqBT0OtXi0OuUungcGNS+xjgwSadMenhrpzfIoYt4SVHJ23R9DMHsZadrWAGiWwu6
         MXbN7/i276YjDPMvapggOy7uX2Ju9sGPIUGjrXl3pTE25/3piRzJ6IBfMZlQi1riRNEW
         uxtA==
X-Forwarded-Encrypted: i=1; AHgh+RqqKF+APgfWlz/IObndLXqFg49vU3CY9I63QFf2EWjEfvN4jQQdWn+S/B98KDoIv1fThPPF21M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz39NbJ28aZA1d1qAXzdhbhxtz48BQvzwDLmsqzTEug9sWewmXm
	tGCczvY2UcggYSST/sxmIbN8n8pZsq3xI7kuDKg5Ockmd/A7Gm1JU3d8WeqKqyseTkcfyrWzqvT
	PZ8SUECh8pDjj/07SoZ30JwCS1Xibk1PTTZByx4OWtwSA424liUG3wC/qC5Q=
X-Gm-Gg: AfdE7clWpS45XGPKBAkJb77iZMcL751K45X63LY7VYT8Q21xak5sF9JNdywD/jN9TW2
	Qph/pnobAJuk0BljIMKkPLK/PVN7T745fwYDl8DzxsUie1jElZFR4cmRZuIwR5YSN47ivWn47yJ
	mxARt4I8Sd6m/TsbBMYNqhASq8wJAhZsZpCOWoBoA085SQedCba7j6nhpEPNrOLRbmqhwZ3UkOS
	uWuJr+/dbo/gjdgpgniJHGLYb34GUobzG1Sa39+gjDnjBj8V5yBCC8Ow6dNSzNBYuISwNAfY9lh
	d/uWolkilJdqq4k+YnAsv2XL6dbcIT+0ROxfTXrrhIFHN/D2zi2zv0mj6pm+uTKASLLUe9Bkteu
	T79UnhMQYzPocR0dhZQb6zNExs8ZAG9gDSTA5YAFzOi4F
X-Received: by 2002:a17:90b:1dcf:b0:38e:500:3975 with SMTP id 98e67ed59e1d1-38e17dce4f0mr5887132a91.18.1784104166292;
        Wed, 15 Jul 2026 01:29:26 -0700 (PDT)
X-Received: by 2002:a17:90b:1dcf:b0:38e:500:3975 with SMTP id 98e67ed59e1d1-38e17dce4f0mr5887108a91.18.1784104165741;
        Wed, 15 Jul 2026 01:29:25 -0700 (PDT)
Received: from hu-ketakish-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e174440edsm2726718a91.12.2026.07.15.01.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 01:29:25 -0700 (PDT)
From: Ketan Kishore <ketan.kishore@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 13:58:59 +0530
Subject: [PATCH] amba: bus: Fix race condition during DMA configure at
 IOMMU probe time
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260715-iommu_races-v1-1-3c4ed13b18a3@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAMpEV2oC/yXMyw5AMBBA0V+RWWtSJV6/IiJVg5F4pINIpP+uW
 J7FvTcwWkKGMrjB4klM6+IRhQGYUS8DCuq8QUmVyixKBK3zfDRWG2ShkziNTaH7Ilfgi81iT9d
 3q+rffLQTmv1dgHMPOb8cm28AAAA=
X-Change-ID: 20260714-iommu_races-a4363c9af982
To: Russell King <linux@armlinux.org.uk>,
        "Rob Herring (Arm)" <robh@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Joerg Roedel <jroedel@suse.de>
Cc: kernel@oss.qualcomm.com, Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Ketan Kishore <ketan.kishore@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784104161; l=2704;
 i=ketan.kishore@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=4UvLxkyBynXuQZUY7ckV2hbCMLktaiLT4kV3hfGcfZ0=;
 b=yXH7BzTKntYnyonj7gSpHRD60ADrEBKGZfU2NegQLbG0D9r4T4VuqTsYXY1KF2NvjbaeohP24
 jPq8T3vsthaBI4NsstSmtyRBbCuZnsNMbkgET0yi96Hx7QeeYH0a8jj
X-Developer-Key: i=ketan.kishore@oss.qualcomm.com; a=ed25519;
 pk=4sb5Ima5x03wc0KSnl57v8kR/7FxMt01+xlZJ53rSJU=
X-Proofpoint-GUID: BchqrFRLUbRUij70vZGrQDpT7qR6nD2F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDA4MCBTYWx0ZWRfX69En8ilViAg1
 3SYuo30edmH5SxroF/5byhSQwPfZBjNmd94Pd0b6BxJSNAR3g93WHku0iB4bIiBI3dc3MBkl5Po
 Dbj3y1/wuN8KaCIsU/UoZYlL2abE4VtlUv48wPYsFVL1B8LcLaS0cxbGSEVIHAQ941oWJ/gnLM/
 amLZTsdgX62j/61yQbAG+CMki8JK2xM3U7ehL5ni5oshS9SfG+mqzr/QW/f5r7L83mrNP+1KpVw
 oA3M18stqaEVQ2HNoUF1kVHtJz/dcgsCuTOTWqB8bc6PPfmpaOT51/53TNzknZUhDdiDI8Yf8Tx
 dSf+yHLzLUspckJ7QoxCVVWM8MXqIrlIqltC7Q6dHXsK60wHcVwHV6pqkXGkYLfr6C/gYNM29SE
 1uUF/wF+uJjw8mtdXIZARceGe8MAThzk7lkA9qW1da16QLDViHy7s9C/YiJGjw54TPgxuWE0R4L
 K+Ju+pc7EpeIw1YJwaA==
X-Authority-Analysis: v=2.4 cv=NszhtcdJ c=1 sm=1 tr=0 ts=6a5744e7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=VfoRSCTNTtgxD6etynkA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-ORIG-GUID: BchqrFRLUbRUij70vZGrQDpT7qR6nD2F
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDA4MCBTYWx0ZWRfX3gQAionBXXMY
 dgz48dP9CVvWxHVdGEqkLfW5qa5u8AzEz9Tv3Dlt9nSMNpY3tq7oxXA2sP4ivu7lqXu3eyYM/WY
 HCKY55OIn43fyUO+kAZVPnM07104rcI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_02,2026-07-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 malwarescore=0 spamscore=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607150080

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
Cc: stable@vger.kernel.org
Signed-off-by: Ketan Kishore <ketan.kishore@oss.qualcomm.com>
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

