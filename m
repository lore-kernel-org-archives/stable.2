Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64F0C3B71D8
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 09:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280362; cv=none; b=GW7c4Qw25T3fKlKaPXXKETFWWZwnJFYMb+8ReKSobGjJULMXIYMAaEYoIstLU9sGfyfc8mPAKhSnMEQ598KV+buEyxxoJU/FK3cczkvk+/9FFddyqVtEYKzwx5r0YXGkLnmzLAD9V22qnDKzUfWcDlCAYejKQklODZYIwE7O4OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280362; c=relaxed/simple;
	bh=IJM12IPhydPMhVfgKAD3r1R+hMTUt/15MFROcI+Z0fY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=uvPhbojyaRYniRoJFqDFX8PUshT7MoIS0qaBGVbLD+WQFhPKL6EWWWfUnXJeuAISaI432D2yXKvznkV67/iF7/c8EjWv8MZrBejnRJN+Ov0UisEukc/oz/WsshJSjPXshIwphZTgSuGwjWhFigrkK/cDd9H6aC+Aepr54SwEPdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=LO7M9aoz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HmRmlLNJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="LO7M9aoz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HmRmlLNJ"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H6cFTp1065321
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 09:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=P4U1vKKGfvsW3iPMjF5IU+
	stSAtAMqxWdBp0JhDoid0=; b=LO7M9aozz5kwEywpc5rYJPjQiC5tJNeR460jFy
	uCgFQOdVUOXwsb/zsRsCTWlZmc6wL2hlRzIBtzZkeXaGk1b3qGhyEMHDhWdwfkO4
	QnkMlg6gTsJfJvPUVqJQfbOT4VujVUTqI3FMCsEUOdIuXvmCG7LO90jIKqpazDqr
	k5OODjn0b5jjbbAXcASjumElpdpuY5eviCK06WsEB2Llpx4sIgZ6f+bCkd3EgeEs
	jBkVD9CU9as0MNjhGQb3pyYeUTb2yie7IjaF4ZunB+CPuGFumNUir2sXxxqBwlYJ
	QrIqNSyYy1aXPKy+11rIamQ+kO9elGj/aNDq3zw57fq95IQQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffbquhdtr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 09:25:59 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-84a3514f912so9655507b3a.3
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 02:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784280359; x=1784885159; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=P4U1vKKGfvsW3iPMjF5IU+stSAtAMqxWdBp0JhDoid0=;
        b=HmRmlLNJmo2vb/TbD2J/sZXI6gtvNfpV3cgZh7elItDvSDwBlEiRotyp5BBVs5UTUv
         JYhVKPJeVgoMtwM9LRG2goLD2VfbGDHfMotFMhOaSpcRb/Za72QnHw3W4WLcksg5NtrP
         PJAUGBgS6/5lsZG2eCjJlbYhdpQatwTwvZyXhzBp8LZaXbUT9ka8Pb0xRzHnm+b78oEZ
         7wASYcj51fuVqYZ60pS4ETrCR9ix11tWM1q9BN7uSZfzYw0jpjk7VuZAas0i1YLU/IaL
         us8HIZqVvgq+erWQCghAjTTDNZDxrkSe5MACTo+cggpC8iGbQL+mSyw59tknwxQN7m6s
         ScfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784280359; x=1784885159;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=P4U1vKKGfvsW3iPMjF5IU+stSAtAMqxWdBp0JhDoid0=;
        b=FJaSCIBgW/uv85ez/8C+rfdzLslkh1ecC5e5Fh3amaI9O+kj8BuFdIzcwP7L7gfexw
         YX7vH3Yhz6t3q/QlDXZhH4LAUBFhqRfXFSfkvW3zycihpBJRoIY1kTPSE+pt115idAq8
         wlbqz+MujxC9HJPoE2vjGGO/qe6Va5EgtbZT6+yBppaMENeGZWnFdxz/au68xBJ6mueW
         v2+mzzJs9TFMHHeOaLiJXwGAEqYCtZ5VDZe1CVQDk7vtxTVSLc8xPgyvRrw9jWQB7eQs
         kACOc96rIkoO0+/E2bFW+TzobqGyJJ+OLSGFQ2x0p9TC5ndKR1GO/Ubbmh5aWnrVwE1C
         1g+A==
X-Forwarded-Encrypted: i=1; AHgh+RpIOouDS8OjojIVUGkHMtaQ1WB9muYXqDpuIh7MaYYdWMY/+hnapg9ii0h7vlPuKrZ0DgNVqHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU1HPje9WE0Xe0XCkPbr58LbiBaNnpdwNV99LBqW5qvNd9JaKa
	NPK0vymBJu5LYQln3eqnXW2GfyT6na54yomTbAuO3hAVyHPRGnfM2Xe/c3r/VjBgDD2oNXbzRSv
	5Du2FLPZlBzfmwDB7jczWVlbjdpgcVl8Kz0sSdC2oYRcuYdFEElFXmWyp1MY=
X-Gm-Gg: AfdE7ckFJjq3HshhQxvXMNFciMS/QspLrFX69A2DzzioQWpHLiEsLvwRM4sQbX5Ra4Z
	SoISNn9M0KD239Nyc069aEOkq0uXqgONU1np/6wa8FlqBKuAcX8v5UNbnzaEtDA3h4PiZws35AR
	9xPyEYf1VH1nYEpAxT+SMQZJGPAsxSg+fd1HSnzfbzwB98EhpehMaYI6hf1eZP8baFt6jcKnkqC
	WC54Qo5E4/ixyzvJX9EGODsEdNshT7ffQ+IWY0NdMvM36lYRtcXhrKDRBJ8dLo6lQCUx964i6XC
	pVsmLBTcYHxc9ejb6KaJQxdOySbb7QeyCpaft/jEpaxbS3bGTvnE3Ck8e28ZOESJT1df11zQ1TA
	ZlNtnbi2vjY02YXGASVk080ctclLMlIXHow==
X-Received: by 2002:a05:6a00:4149:b0:848:7b92:8e79 with SMTP id d2e1a72fcca58-84c295278aemr1810009b3a.67.1784280358883;
        Fri, 17 Jul 2026 02:25:58 -0700 (PDT)
X-Received: by 2002:a05:6a00:4149:b0:848:7b92:8e79 with SMTP id d2e1a72fcca58-84c295278aemr1809974b3a.67.1784280358358;
        Fri, 17 Jul 2026 02:25:58 -0700 (PDT)
Received: from hu-ketakish-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84c2af6d8b3sm658379b3a.42.2026.07.17.02.25.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 02:25:57 -0700 (PDT)
From: Ketan Kishore <ketan.kishore@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 14:55:47 +0530
Subject: [PATCH v2] amba: bus: Fix race condition during DMA configure at
 IOMMU probe time
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260717-iommu_races-v2-1-d0b7789275af@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABr1WWoC/1WNQQ6CMBBFr0JmbQltEcGV9zDElDLIGKHaAaIh3
 N2CceFmkpe8/2YGRk/IcIxm8DgRk+sDqF0EtjX9FQXVgUElKksOMhXkum68eGORhUl1pm1hmiJ
 XEBYPjw29ttq5/DKP1Q3tsCZWoyUenH9v7ya5er/y/q88SSGFtinWUlcyN/rkmOPnaO42WHE4U
 C7L8gHjByWMvwAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784280354; l=3320;
 i=ketan.kishore@oss.qualcomm.com; s=20260617; h=from:subject:message-id;
 bh=IJM12IPhydPMhVfgKAD3r1R+hMTUt/15MFROcI+Z0fY=;
 b=xTlHyOPTjU0bQ86chbLU7U4TzuZPy5yJiGOohpT6CbHHHs9Y4chReL5lofaga4TQ3/VUmzTi4
 /8v5rCYVZqaBH9k0FsJOSVfb8EVin7o/kLjYwsfXEhig3jh+D8AYrqx
X-Developer-Key: i=ketan.kishore@oss.qualcomm.com; a=ed25519;
 pk=4sb5Ima5x03wc0KSnl57v8kR/7FxMt01+xlZJ53rSJU=
X-Proofpoint-GUID: UiKaHK3erZ5xkYGTtCJNUpy-IvxqGxTa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDA5MyBTYWx0ZWRfX5RXTEW+Yi0ND
 eF6Q8GXHuXmmTdzt2UkBZqVoVr5/rZZE3+fv3T9xY/o+CDHz/aVIVGKTRzYBFI05yHDgXjL7RGs
 sBmvxLej5dREEvWiSwudAiMqxYD5c4rWgqxnN4NUcBBD+obAFZJtZlKMxF2KGbS/wKo/Dc39gfg
 2AdU95dHLNLQfQqNakrG5sWBnYXWc2iOcZUQiZIBDI3G/dTy2EFUvjmcf7GKebsazipz0wK1i6M
 f0TfE5tLV/0FcPmiZn7gqd95zVooP78W/lOyVMVHR3bNMDoZeRpIw+ydcWhlcSboUsddhTgu2bm
 +xQRUZ/dvICVKgTd74cpL4w/9qm8VwP0LDxxkkXIGhgemjU4CB4KyOhN1vPO5zJeVSAxPGOEMrl
 iRw8uxeCPkazA6xw61gy5kUczxrT/xgoqhXzqFcqHdoAuE516o1gFsFihfIyXr1jE+Jgy+CLBCx
 bGnbT1c0EidxjjgffRw==
X-Authority-Analysis: v=2.4 cv=NZ3WEWD4 c=1 sm=1 tr=0 ts=6a59f527 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8 a=PHq6YzTAAAAA:8
 a=7CQSdrXTAAAA:8 a=1XWaLZrsAAAA:8 a=9jRdOu3wAAAA:8 a=DEt-5Vgr3fpEtGrxzCkA:9
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22 a=FO4_E8m0qiDe52t0p3_H:22
 a=ZKzU8r6zoKMcqsNulkmm:22 a=a-qgeE7W1pNrGK8U0ZQC:22 a=ZE6KLimJVUuLrTuGpvhn:22
X-Proofpoint-ORIG-GUID: UiKaHK3erZ5xkYGTtCJNUpy-IvxqGxTa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDA5MyBTYWx0ZWRfX3T89iDeSTp/W
 4zPywFayPmZe8vGmBwzjAs4OqOYr5HbzQZLakR9TD+7AktENtjZUvB2SV5Pp/7NIaRb2WZ31qh/
 7Yl6hgrx8xs6U941Y5pJWIhwKBu4fS8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_02,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170093

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

