Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD7C351C22;
	Sat, 26 Sep 2026 07:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790407017; cv=none; b=qU9YMqhwDlgLyUbgKN5g2yIZt5ZBO7wx2Hd32BNOGck2gNTnG6bpMoosVtN1mawQ6kI+r68MeuU1bczCaquVzOwTVM9hjraW2SkO3whUkOQs0Z9arColHqdu9yYkxUPnH70bX/FQjdxIzASOxRf3QwaLakp3sTwrHL2Uhs+VZcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790407017; c=relaxed/simple;
	bh=eQ7MB/qBuFHzMv4qVO3cAx9UnXEJ34m+nOfTXpVOyw0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oYZVVIhnobkHACsVz7JUN0glsr0Y0rt08zZmeff2aNy842T2u/g+svSV8LGGkqmTspvFCEgb5CYfxJfzAifexoa1CsdrbznmB6OCRCS9cwoq+wEUeJb/PLBDrIVzur5urk1YyqV3Pms7iPm8jQ70vE8efK8f07vr440HrRIEr5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=aApRAPIu; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="aApRAPIu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=73
	XNOlAF6E96w2dh7owltodN0UASq3BclRNN+vB8FBk=; b=aApRAPIuaegCfEtdx4
	KAhhMhIAmtfcuyumghTOTmgEYMVTuH5m7BCNIe0zbDLzyzecq736mqm1CKVTHvua
	2RQub8XJ/g+SNHnWl3aix54Qph8kP/2dUjVNpdvlmQcwqoh7nmeqxQZMKt6kU1Hn
	aWqUBnleZelFTVn7OQqrlFWdc=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wDnTzo3cbdqUXJ1Aw--.58745S2;
	Sat, 26 Sep 2026 15:16:08 +0800 (CST)
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
Subject: [PATCH v2] cxl/acpi: Check ACPI companion before use
Date: Sat, 26 Sep 2026 15:16:05 +0800
Message-Id: <20260926071605.3013893-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnTzo3cbdqUXJ1Aw--.58745S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7tryDtF1rtw15Aw1furW8Xrb_yoW8tFy7pF
	Z7ta4FkrW8GrW0kw4qv3y5C3WF9a10ya4UCF1kGwn8u39Igr1DJFy3tFWUZr98Cr93tayI
	yF1UtF10ka4UZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pRR6wJUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BjyLWq3cTg8ggAA3d

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

Notes:
    Changes in v2:
    - Move the ACPI companion assignment immediately before its NULL check.
    - Reorder local declarations in reverse Christmas tree order.

 drivers/cxl/acpi.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index 3b818adbd38b..fb09a5ff48c1 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -885,13 +885,17 @@ static int pair_cxl_resource(struct device *dev, void *data)
 
 static int cxl_acpi_probe(struct platform_device *pdev)
 {
-	int rc;
+	struct cxl_cfmws_context ctx;
+	struct acpi_device *adev;
 	struct resource *cxl_res;
 	struct cxl_root *cxl_root;
 	struct cxl_port *root_port;
 	struct device *host = &pdev->dev;
-	struct acpi_device *adev = ACPI_COMPANION(host);
-	struct cxl_cfmws_context ctx;
+	int rc;
+
+	adev = ACPI_COMPANION(host);
+	if (!adev)
+		return -ENODEV;
 
 	device_lock_set_class(&pdev->dev, &cxl_root_key);
 	rc = devm_add_action_or_reset(&pdev->dev, cxl_acpi_lock_reset_class,
-- 
2.34.1

