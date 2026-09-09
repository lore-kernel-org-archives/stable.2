Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD49147ECCB;
	Wed,  9 Sep 2026 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788940953; cv=none; b=gZe4Wij5BqGbn67RZxoPUd6bAdWF/P+m3LOXPphxcGDy6ZHUT7onSl8mxdLGBsRDYbqYCxXHhoxgnSfCxdfGdDE976C1iywnCTpGqnm6yJQLdD4KHUs9iPyU9xtIkNTGw+XGE4H/pU8bGPVnhdsEOrr7ZtTxzBzxmSSxtU2+rOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788940953; c=relaxed/simple;
	bh=doFozkbQmIhIwnnl2kZ6KJ/alTEr96CSHcCvbOHZz9U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NFPmVkhdsjUDf93+rmE8u2KjJTzZT/lJOTi9+cOD0chYgBu9HX7F0pzp3Ispiaj2owaENUOoL0TsyluRBOiNUnVN2OA548PZJKXuhGls62yUCXbTOfX2Tv8ASWFQgcJiIxmpfwRDkO42vAR3mcO36gIl/IEEnu3XcQTZO+8M3nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RDE9CBvj; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RDE9CBvj"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 77D984E415AE;
	Wed,  9 Sep 2026 08:02:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 41BC260448;
	Wed,  9 Sep 2026 08:02:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3334311C7AF4F;
	Wed,  9 Sep 2026 10:02:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788940948; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=MkmdthSh8paWUEwmQAkZhqBjHWPZzyumh8DkXBWxqAQ=;
	b=RDE9CBvjZSPBSWe2rM/9+2WNzr+rU1gjvKrmoB8Va2yOiWu+01Nt7HOuUWhv35r89cR1fO
	P1Yh87BaYgSB1UBXTI145jbGV0KEvOomQfn7oBRnpgKqBex06HldCdQSyZyNmjkYoM5GZ2
	exlZDM8F6oB1OH30jwywksNz7M5MD3EhFLU1WND5MrgMLh5QAettdULWycds7+xxLgGmuk
	zRcFtTpUDRoUFhMgu5IkyAC9uhP6EF3jcDJfUVU45/O6/4HYuvBaDWMU7sEfQD9GZk6qzE
	M/auScPf/GB7qhzh0VpCxFviWNUg0veZGoo1AjGgy55TIUu+3IBN7ObSTSOeUQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Richard Cheng <icheng@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Lizhi Hou <lizhi.hou@amd.com>
Cc: driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-sound@vger.kernel.org,
	patches@opensource.cirrus.com,
	linux-gpio@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v11 07/10] PCI: of: Clear fwnode->dev during root bridge node removal and error path
Date: Wed,  9 Sep 2026 10:01:06 +0200
Message-ID: <20260909080114.591938-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909080114.591938-1-herve.codina@bootlin.com>
References: <20260909080114.591938-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

During the of_pci_make_host_bridge_node() call, an OF node is created
dynamically and its fwnode device (fwnode->dev) is set to the PCI root
bridge device using the fw_devlink_set_device(&np->fwnode, &bridge->dev)
call.

On removal, of_pci_remove_host_bridge_node() is called and calls
device_remove_of_node() which in turn set to NULL the related
dev->fwnode.

Later in the removal sequence, device_del() is called and runs its
cleanup logic:

    if (dev->fwnode && dev->fwnode->dev == dev)
        fw_devlink_set_device(dev->fwnode, NULL);

Because dev->fwnode has been cleared earlier, fw_devlink_set_device()
is not called and leaves fwnode->dev unchanged. This fwnode device
(fwnode->dev) becomes an dangling pointer.

If any reference to the OF node is held after this removal, the pointer
is still accessible using the OF node (np->fwnode.dev) but points to a
freed area.

The exact same issue is present in the of_pci_make_host_bridge_node()
error path leading to the exact same dangling fwnode->dev.

Avoid this dangling fwnode->dev pointer by clearing it in
of_pci_remove_host_bridge_node() and in of_pci_make_host_bridge_node()
error path.

Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/of.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 0f45c5b72458..29b63a9090ae 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -822,6 +822,7 @@ void of_pci_remove_host_bridge_node(struct pci_host_bridge *bridge)
 	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
 		return;
 
+	fw_devlink_set_device(&np->fwnode, NULL);
 	device_remove_of_node(&bridge->bus->dev);
 	device_remove_of_node(&bridge->dev);
 	of_changeset_revert(np->data);
@@ -887,7 +888,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 
 	ret = of_changeset_apply(cset);
 	if (ret)
-		goto out_free_node;
+		goto out_clear_devlink_dev;
 
 	np->data = cset;
 
@@ -909,6 +910,8 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 out_revert_cset:
 	np->data = NULL;
 	of_changeset_revert(cset);
+out_clear_devlink_dev:
+	fw_devlink_set_device(&np->fwnode, NULL);
 out_free_node:
 	of_node_put(np);
 out_destroy_cset:
-- 
2.55.0

