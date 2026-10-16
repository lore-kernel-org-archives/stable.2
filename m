Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C3D25B091;
	Fri, 16 Oct 2026 05:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792127728; cv=none; b=fg2QoMQB0UFSga04u95D210n7S1CmFZtLsiBI38bFaBvStr2PHrT0/sGAYSwotftpgMOuJb3UtSATXb9gCAzz15TR2CFxFsgA+h5kKsSKiqJIs/mK/sMwMGQ1EyBoRGXscVp8huEO5LZkkh0vRQTWSzSWMP3MeSX/wQiuvbqDr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792127728; c=relaxed/simple;
	bh=3Lkcc8H7OSsvw4QKrxbjbmw/ALTLOqKIBxNk7g3as+c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bbceWbbZuNq7MYuwwszQD07MLSMo/QBTmIxmgt9BKLvdnNCk8goFHcXUvAN8plJX+P0vgsTJOsyQ+LX/CtlDFOwi9E8sLwz8y48Eq+V5Kah1krGJ9V9Twy17KIUGbRgVmWr8yUO2l8J7XeFtqRa7VbBxVbeQ5PKV0BncQZ5mRS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=ZzK8QWhR; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ZzK8QWhR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=X9
	zZtpBTNtwIeKmOEiZ6v6fbm/DBfQrHDFlivSmpwJY=; b=ZzK8QWhROGbPnUlSzK
	0HpaHL9VnvPcZJ42FUcD75LTQ85bjk6mItOo0X4dZJtkYGNxAr74L3grMtwIJ2Rt
	ZFMzr7MmKF9Ob+ssnrixR9slN7gwWko5o6bGnbaHhs5NduHUdFI+HbYulFswTbGu
	RI6mY4DyEsnmKvGIwnYGYWvhE=
Received: from ubuntu.. (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDnL761stFq5CnUAQ--.19128S4;
	Fri, 16 Oct 2026 13:14:35 +0800 (CST)
From: Ma Ke <make_ruc2021@163.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	o-takashi@sakamocchi.jp,
	bhelgaas@google.com,
	dakr@kernel.org,
	u.kleine-koenig@baylibre.com,
	make_ruc2021@163.com
Cc: sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	stable@vger.kernel.org
Subject: [PATCH v2] sparc: Fix leaked platform_device references from of_find_device_by_node()
Date: Fri, 16 Oct 2026 13:14:26 +0800
Message-ID: <20261016051426.2317433-1-make_ruc2021@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL761stFq5CnUAQ--.19128S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxZw1kGw47CFy5WFW5Ww1xXwb_yoW5urWUpr
	ZrAay3GrW8Wr109r4kXr1kZF4F9r1Iyws3Wr13KF9Ygwn8JryYvr1Fqas2gFW5trWjka1j
	yFs8tFW8J3yqvrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piGjg7UUUUU=
X-CM-SenderInfo: 5pdnvshuxfjiisr6il2tof0z/xtbC1Bvp9GrRsrs+yQAA3X

of_find_device_by_node() is documented in drivers/of/platform.c:

 * Takes a reference to the embedded struct device which needs to be
 * dropped after use.

Several functions in arch/sparc/kernel/of_device_common.c look a
device up that way and never drop the reference:
irq_of_parse_and_map(), of_address_to_resource(), of_iomap() and
of_propagate_archdata(). On sparc these are the arch overrides of the
generic OF helpers, so a reference leaks on every interrupt mapping,
address translation and ioremap, and of_propagate_archdata()
additionally leaks one per child node because it recurses.

Release the reference once the value has been read out of the device.

Found by code review.

Fixes: 44266215e3c8 ("sparc: Implement irq_of_parse_and_map() and irq_dispose_mapping().")
Fixes: 930952af15f8 ("sparc: Implement of_address_to_resource().")
Fixes: 9889376ab91f ("sparc: Implement of_iomap().")
Fixes: 5059625ed886 ("sparc: Add OF archdata propagation helper.")
Cc: stable@vger.kernel.org
Signed-off-by: Ma Ke <make_ruc2021@163.com>
---
Changes in v2:
- Cover irq_of_parse_and_map(), of_address_to_resource() and 
  of_iomap() as well. They are in the same file and leaked the 
  reference in the same way, so the subject was widened from "in 
  archdata propagation" to match, and the Fixes tags are now one per 
  function.
- of_create_pci_dev() in arch/sparc/kernel/pci.c looks similar but is 
  not. It hands the device to pci_init_dev_archdata(), which stores it
  in sd->op, and keeps using it afterwards, so the reference is 
  deliberately held there.
---
 arch/sparc/kernel/of_device_common.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/of_device_common.c b/arch/sparc/kernel/of_device_common.c
index 7f2f9972b59b..e2e1c1e97f90 100644
--- a/arch/sparc/kernel/of_device_common.c
+++ b/arch/sparc/kernel/of_device_common.c
@@ -15,11 +15,15 @@
 unsigned int irq_of_parse_and_map(struct device_node *node, int index)
 {
 	struct platform_device *op = of_find_device_by_node(node);
+	unsigned int irq;
 
 	if (!op || index >= op->archdata.num_irqs)
 		return 0;
 
-	return op->archdata.irqs[index];
+	irq = op->archdata.irqs[index];
+	platform_device_put(op);
+
+	return irq;
 }
 EXPORT_SYMBOL(irq_of_parse_and_map);
 
@@ -32,6 +36,8 @@ int of_address_to_resource(struct device_node *node, int index,
 		return -EINVAL;
 
 	memcpy(r, &op->archdata.resource[index], sizeof(*r));
+	platform_device_put(op);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(of_address_to_resource);
@@ -40,13 +46,16 @@ void __iomem *of_iomap(struct device_node *node, int index)
 {
 	struct platform_device *op = of_find_device_by_node(node);
 	struct resource *r;
+	void __iomem *ret;
 
 	if (!op || index >= op->num_resources)
 		return NULL;
 
 	r = &op->archdata.resource[index];
+	ret = of_ioremap(r, 0, resource_size(r), (char *) r->name);
+	platform_device_put(op);
 
-	return of_ioremap(r, 0, resource_size(r), (char *) r->name);
+	return ret;
 }
 EXPORT_SYMBOL(of_iomap);
 
@@ -70,6 +79,8 @@ void of_propagate_archdata(struct platform_device *bus)
 
 		if (dp->child)
 			of_propagate_archdata(op);
+
+		platform_device_put(op);
 	}
 }
 
-- 
2.43.0

