Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135AB51FCA9
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 14:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864980; cv=none; b=F6GUV7O+SYdS4xeznaiPba9P8jKlUU4fNwVuU7AKOqSAPzNjhWQdxs6E9S9L9SSs77AwvrLVIxkkOLWZpawnDu78A+J3wLh+EOWhBY9oC7XshGdf0vbgLfHDuFdIjmM+kOxoJP2Yy+x0Bb2Kyba6q3721gMw8AhKwXtpk4raLi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864980; c=relaxed/simple;
	bh=4RVhPavqbFdZB9dLlUgTUNkwX9QrrcgqvBFuvF2ryQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n5i74O9ViU+O6thQYhMYJSuuOuv+R3kxOx1LrSp4Eo+xOftLyHtaxY1gMCYt8fNlE+SoehF5yyQQ3fTjuljFHCeHvaZs/WKYWv0wzBdHQMjOnUZpCh24jocIu9m6VuVODMEQfzMQeG6QJdwXGOoVOzduTB9xHiEGdNN262led0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Q4ex75hZ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Q4ex75hZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 140391A10B5;
	Thu,  1 Oct 2026 14:29:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DA54760341;
	Thu,  1 Oct 2026 14:29:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0EE910328187;
	Thu,  1 Oct 2026 16:29:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790864968; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=S9hVX9w2762K2NqjWVW1JueaSmRHavaw67h+zQmQF34=;
	b=Q4ex75hZwP04W60MFoVlgKimQyT9u83QcNT5kyeMB1pXGq5ouzIYbRX6qRQncbnyQoxqyz
	J4ZA8zkN8Dy+Vjz1+GNgamyQQDZTppjGtHDxqMrpe+SPIWT8iOjhssUBHDMxiAyNyAvN69
	JKjpXv+Xm0XulfCaYislcoFEanVfe4VXxu7KWbcuXURYBRTHUy1xDdWQ9HDO1bJgE76UgL
	dHy3C78zWEzruhf3DB0zS13JtTUVldXAaZhu/W0Z1T+Dk6S1fam2KYXkaAE7IK/HMxNz8v
	lrI67jfbbqBnFfDHib0LObMAsz2D13tS/IJQaVbq34D0RfsJWVZMe/19sBdQYg==
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
Subject: [PATCH v12 08/10] PCI: of: Set fwnode device of newly created PCI device nodes
Date: Thu,  1 Oct 2026 16:28:08 +0200
Message-ID: <20261001142815.277550-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001142815.277550-1-herve.codina@bootlin.com>
References: <20261001142815.277550-1-herve.codina@bootlin.com>
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
Reviewed-by: Richard Cheng <icheng@nvidia.com>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
---
 drivers/pci/of.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 29b63a9090ae..8914bfa25dc1 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -736,6 +736,7 @@ void of_pci_remove_node(struct pci_dev *pdev)
 	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
 		return;
 
+	fw_devlink_set_device(&np->fwnode, NULL);
 	device_remove_of_node(&pdev->dev);
 	of_changeset_revert(np->data);
 	of_changeset_destroy(np->data);
@@ -788,9 +789,16 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
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
-		goto out_free_node;
+		goto out_clear_devlink_dev;
 
 	np->data = cset;
 
@@ -805,6 +813,8 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
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

