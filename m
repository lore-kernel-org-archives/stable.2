Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4B38E8A8;
	Wed,  8 Jul 2026 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505107; cv=none; b=IgRmuftqEm+MPAPh0tJUSmQFvtvkEOQ4oAoXBQXJBrXTvm4Ze8OdKnPFmWpkHmucls8QqkawkaXt+z5VbQuSWDZA14hwLAT6/OE6Np44wwTdRQvPWwOhHXOArEJWEUhU+ca15JI9wwuO036/acIEPeE7xIADLmGHr0VPH6ebeIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505107; c=relaxed/simple;
	bh=ot0ZUZZAvX2dWnG+6ZdjH0wAviaK+ovjXv80kHGhr8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EDBbJaRFNTgkZLDL3MPnSMH/u75XlQcxfS+I+URQgqDlcRaRQYwRMmjBwxwKMgh2OYwg4P6t8nWF7I+9CfFGjpsqVXcKQwiqkS0FjKjGV0SAic3fRviw3sY/v+zKKtuVTZGFAcT5ruQPNk8x+YUad+cRuiicnfaePGj4iN5Mh4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q9jg6Tjn; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q9jg6Tjn"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D5A58C8F448;
	Wed,  8 Jul 2026 10:05:18 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EFA9260337;
	Wed,  8 Jul 2026 10:05:04 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2FFBE11BC3414;
	Wed,  8 Jul 2026 12:04:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783505102; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=Vy314oL/7UUB26ONuI2+X1y4jcu1eRSAEDyN4HB9Vfk=;
	b=Q9jg6Tjnz6yPc1ahCgBwmx4X85IEkOVEmhe11cYp5HQAyJedpfu7T2A3XFROV/QWWxwlnM
	D5Y1kA/n61gNRoU73IEqVYa4wM0hfwFOJtkOukF/B+xqXoATSwkeyirPTRGkPhF3AM9rE4
	e0xIkrLN5JWCgcZSewgxav0IL9dqBR7bc6tBuLIXxcoANG7BJXhqaVC0tdLDfTY9PJcAt7
	JbCH777uJYAUfoXbxb4Et+XW7DxoOgrbr+pbNqmzGX7KV2ti/6/S27Dh2gA/VdqP9lBYIF
	1vWIoqXeJE58COwQ0j/PDYKz7Su2ScYH6EWP6/7bmv6JLXoVjumW9IuFDPbhAg==
From: Herve Codina <herve.codina@bootlin.com>
To: Richard Cheng <icheng@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
	Linus Walleij <linusw@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jic23@kernel.org>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <djbw@kernel.org>,
	Ira Weiny <iweiny@kernel.org>,
	Li Ming <ming.li@zohomail.com>,
	Lizhi Hou <lizhi.hou@amd.com>,
	Herve Codina <herve.codina@bootlin.com>
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
	stable@vger.kernel.org
Subject: [PATCH v9 8/9] PCI: of: Set fwnode device of newly created PCI device nodes
Date: Wed,  8 Jul 2026 12:02:58 +0200
Message-ID: <20260708100302.517792-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708100302.517792-1-herve.codina@bootlin.com>
References: <20260708100302.517792-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Device-tree node can be created when CONFIG_PCI_DYNAMIC_OF_NODES. Those
nodes are created and filled based on PCI core information but the
fwnode device field is not set.

When later an overlay is applied, this confuses fw_devlink. Indeed,
without any device attached to the node, fw_devlink considers that this
node will never become a device. When this node is pointed as a
supplier, devlink looks at its ancestors in order to find a node with a
device that could be used as the supplier.

In the PCI use case, this leads to links that wrongly use the PCI root
bridge device as the supplier instead of the expected PCI device.

Setting the fwnode device to the device of the PCI device allows devlink
to use this device as a supplier and so, correct links are created.

Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/of.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 8dd558a490bb..ca83006b7c7e 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -657,6 +657,7 @@ void of_pci_remove_node(struct pci_dev *pdev)
 	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
 		return;
 
+	fw_devlink_set_device(&np->fwnode, NULL);
 	device_remove_of_node(&pdev->dev);
 	of_changeset_revert(np->data);
 	of_changeset_destroy(np->data);
@@ -709,6 +710,13 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
 	if (ret)
 		goto out_free_node;
 
+	/*
+	 * Set the fwnode device in order to have fw_devlink creating links
+	 * pointing to this PCI device instead of walking up to the PCI host
+	 * bridge.
+	 */
+	fw_devlink_set_device(&np->fwnode, &pdev->dev);
+
 	ret = of_changeset_apply(cset);
 	if (ret)
 		goto out_free_node;
-- 
2.54.0

