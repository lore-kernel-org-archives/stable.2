Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D4A3D6498;
	Thu, 24 Sep 2026 12:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254479; cv=none; b=CBuXDJAYeNgzNuvDiLYf3YAP1LUqHurqYkiQCA9Jm2h63jgbQcKGYhjhaXcwMbXciF4aR9zaZMY4GOujS6VvlY4ELLyzibCVfX6J5CNT/AUZVtsjHblbBtCbXFxBGEWr4BFHkfLP16RWHX7m6cKWcx4ByyQTZBFRWV7J0LL042Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254479; c=relaxed/simple;
	bh=0+ui8n6ozQLQozNSWWSOwzBR9tpSl28Xu0KniOfGKkk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dFlST14ki6mXqdERjVYeERmUYxzTPs3Eqd23+8bmlvWS/oMzQ9Ds6mMV4DiZu0xC3PQkQU38S4B9gqRwLqZEr7f31+ngIJgkFydPLGhfjs3oQVwagELEox+EwsBbERDKEFN36JZdVGCmm0orHPxLOJxgqUmT7ijTfZj8317Vwkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=X/MQ3wP6; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="X/MQ3wP6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Gt
	HbqC6WFjjhImYjnIEladIzqJDjQqfjE7n1FOtA8MM=; b=X/MQ3wP66r9aWaElUS
	/HkSf2DhjaFZHSAo0DT/iiv4mUG1EJrG+Kj/EgtQFycjVvpi0sb3IHQBvOVZWlRG
	9smMAYyjUKSM2SAr5bHsvoju/JRejnWQkCRfOTXqn4fY1tRh4L9tbkGS4BRS9018
	LNs91h8eC+k1bRdKy6uBV0k4s=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wDXX6JuHbVqQ5RNAg--.805S2;
	Thu, 24 Sep 2026 20:54:07 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] cxl/acpi: Check ACPI companion before use
Date: Thu, 24 Sep 2026 20:54:04 +0800
Message-Id: <20260924125404.923551-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXX6JuHbVqQ5RNAg--.805S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryDtF1rtw15Aw1furW8Xrb_yoW8AFykpF
	Z7Ka4Fkr4kGrW0kw4Ut345Ca4F9a1j9a47ur1kJwn8u390gr1UZFy3tFWDuryDCrZ3tayx
	tFnrZF109Fy8uaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUjeHhUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQ9qpGq1HW+kRAAA3B

Platform drivers can be forced to match devices outside their ID tables
through driver_override.  cxl_acpi_probe() assumes that every bound device
has an ACPI companion and dereferences adev->dev.bus without checking the
result of ACPI_COMPANION().  Force-binding cxl_acpi to a platform device
without a companion therefore causes a NULL pointer dereference.

This was reproduced by setting the driver override for the pcspkr platform
device to cxl_acpi and binding it through sysfs:

  BUG: kernel NULL pointer dereference, address: 0000000000000280
  #PF: supervisor read access in kernel mode
  RIP: cxl_acpi_probe+0xf4/0x220
  Call Trace:
   platform_probe+0x4d/0x80
   really_probe+0x106/0x370
   device_driver_attach+0x4c/0xa0
   bind_store+0xd0/0x100

Commit 2b3a5dabe89e ("platform/surface: acpi-notify: Check ACPI
companion before use") fixed the same force-binding issue in another
platform driver.  Check the companion before setting up the CXL root and
return -ENODEV when it is absent.

Fixes: 7d4b5ca2e2cb ("cxl/acpi: Add downstream port data to cxl_port instances")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/cxl/acpi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 3b818adbd38b..2b67138013a9 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -893,6 +893,9 @@ static int cxl_acpi_probe(struct platform_device *pdev)
 	struct acpi_device *adev = ACPI_COMPANION(host);
 	struct cxl_cfmws_context ctx;
 
+	if (!adev)
+		return -ENODEV;
+
 	device_lock_set_class(&pdev->dev, &cxl_root_key);
 	rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,
 				      &pdev->dev);
-- 
2.34.1

