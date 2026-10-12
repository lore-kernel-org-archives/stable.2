Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523963876C3;
	Mon, 12 Oct 2026 01:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791769476; cv=none; b=d+Y3lpKvpSL3o1EKo07BQwzSmxxL+tDDoWnUZuUGWGMjB4e1LnCqMyLcmZZbPY2e7lS9/2p82gtC3QxywPvWMNhZuSnw9Jj0KBG5h71PbfGtmNw1DSjnloh4eiJVhNPczjAQThOlrKAtr+RTbatZLEcWHWewvhxxKPGjfPjQBE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791769476; c=relaxed/simple;
	bh=LJujeDhRMrUPcqlSxOoanuEO/CJqSUDmwzv+tUlACOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tssE9ZQrHIhiBHqmUdTTCw0m8NYDEBdY0zz1JXAjceVyM1f5k/hsn8qK3vo/PtZxUg+YvmTkmULRvWRZzSXiHExOJdrlcX0csd4CUS1SmxLe+ricagxqrhDiqtZuyvtXNAj8jCGUsq0BrvrjVhO9bjtoO5DymrWQFFpEsBy9tW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=D0pd+Ci9; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="D0pd+Ci9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=cT
	gdMR5xsl/GVsi/wQahkEXsQG9rBtA99KKcGm04LPA=; b=D0pd+Ci9x8Y3i4rx6o
	HjAtJ8o5bggCq2yisOfb4nx2ebf3WTOzhkJMZ0bvdCZ27kiAj5L4XFYIfnnan2h+
	PBD7CC17Irc6Wv5LjWu4ecZMupkO8Zyn7z+Em29A5ozcCCHO0CYO0fHs9pwiwgfN
	9XBXNtJXdMMmvX0r9FofjYokg=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDXvytXO8xq_nZsDw--.19357S4;
	Mon, 12 Oct 2026 09:43:59 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: broonie@kernel.org,
	sbinding@opensource.cirrus.com,
	hansg@kernel.org
Cc: linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	Ma Ke <make_ruc2021@163.com>,
	stable@vger.kernel.org
Subject: [PATCH] spi: Fix controller reference leak in acpi_spi_device_alloc()
Date: Mon, 12 Oct 2026 09:43:49 +0800
Message-ID: <20261012014350.3600177-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXvytXO8xq_nZsDw--.19357S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxCF1UurWDXF4rGFW3tF1fWFg_yoW5tr43pF
	WftFW3JFyvgF4rG3WSqw45GFy3uF40vw43Gws3Jw43uw4S9348XFy3tr1Yqry5AFWktan8
	ZFW2qF48Cas5Aw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_0PfDUUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC9h+zvmrMO1+K2AAA30

When acpi_spi_device_alloc() is called with a NULL ctlr, it lets
acpi_spi_add_resource() look the controller up with
acpi_spi_find_controller_by_adev(). That one uses class_find_device(),
 so the controller comes back with a reference held and is stored in
 lookup.ctlr.

None of the four return paths of acpi_spi_device_alloc() drops it. The
three error paths return an ERR_PTR directly and the success path
returns the spi_device.

spi_alloc_device() does not consume that reference either. It takes
its own through spi_controller_get(), which spidev_release() puts back
when the spi_device is freed. The reference obtained by the lookup
therefore has no owner.

The controller must not be put when it was supplied by the caller, so
track whether the lookup was ours.

acpi_spi_notify() in the same file shows both halves of this. It looks
the controller up with the same helper and puts the reference itself
after handing the controller to acpi_register_spi_device(), which
calls acpi_spi_device_alloc() with that controller. The
caller-supplied case, where the function must not put.

This is reachable from serial_multi_instantiate_probe(), which calls
acpi_spi_device_alloc() with ctlr == NULL once per resource in a loop.

Found by code review.

Fixes: 87e59b36e5e2 ("spi: Support selection of the index of the ACPI Spi Resource before alloc")
Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
 drivers/spi/spi.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 5b5b3bc5f0d8..4373afc1259c 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -3163,11 +3163,13 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 	struct list_head resource_list;
 	struct acpi_spi_lookup lookup = {};
 	struct spi_device *spi;
+	bool put_ctlr;
 	int ret;
 
 	if (!ctlr && index == -1)
 		return ERR_PTR(-EINVAL);
 
+	put_ctlr		= !ctlr;
 	lookup.ctlr		= ctlr;
 	lookup.irq		= -1;
 	lookup.index		= index;
@@ -3176,9 +3178,11 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 	INIT_LIST_HEAD(&resource_list);
 	ret = acpi_dev_get_resources(adev, &resource_list,
 				     acpi_spi_add_resource, &lookup);
-	if (ret < 0)
+	if (ret < 0) {
 		/* Found SPI in _CRS but it points to another controller */
-		return ERR_PTR(ret);
+		spi = ERR_PTR(ret);
+		goto out_put_ctlr;
+	}
 
 	acpi_dev_free_resource_list(&resource_list);
 
@@ -3189,14 +3193,17 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 		acpi_spi_parse_apple_properties(adev, &lookup);
 	}
 
-	if (!lookup.max_speed_hz)
-		return ERR_PTR(-ENODEV);
+	if (!lookup.max_speed_hz) {
+		spi = ERR_PTR(-ENODEV);
+		goto out_put_ctlr;
+	}
 
 	spi = spi_alloc_device(lookup.ctlr);
 	if (!spi) {
 		dev_err(&lookup.ctlr->dev, "failed to allocate SPI device for %s\n",
 			dev_name(&adev->dev));
-		return ERR_PTR(-ENOMEM);
+		spi = ERR_PTR(-ENOMEM);
+		goto out_put_ctlr;
 	}
 
 	spi_set_chipselect(spi, 0, lookup.chip_select);
@@ -3212,6 +3219,10 @@ struct spi_device *acpi_spi_device_alloc(struct spi_controller *ctlr,
 	 */
 	spi->cs_index_mask	= BIT(0);
 
+out_put_ctlr:
+	if (put_ctlr && lookup.ctlr)
+		put_device(&lookup.ctlr->dev);
+
 	return spi;
 }
 EXPORT_SYMBOL_GPL(acpi_spi_device_alloc);
-- 
2.43.0

