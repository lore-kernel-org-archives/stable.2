Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E1ED3F0A97;
	Tue, 30 Jun 2026 10:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815396; cv=none; b=J1fbBkbUb6phKqKWrxCbXgQQBkxv4u1UNtuV3PJg0+LfN2vUgIHuk1ZxM+PVYLQFnzPtpQP3/sNmJARYG8ucuFgmB2jgaZ1cNNMwWAHCP1RsTp5OZRlwQwX8qdbZMOqmzCI/VpFoFygf++USRmEz43Az/uYeRdyE5qGzWrE3FAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815396; c=relaxed/simple;
	bh=JtHNH4m847l5mtPzd0VHeP+WOUOiH+Uc9gql/erzMUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Af68jfgCtfK3ADbeFAguoDfdgvUdKmO0dsf2UUGbs6N9hQAnM+xvQ/fMFm+gqxDx0q1Y3nZINuKxgZWIp+V3qQYe4BFImw2widKrrEnFTiDT0YmZos03WmDztIGLN/GhMgt8HiwM+fwSqEARkQE2f4tF4sabQkL/3B7li42lBMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=m8vYgJnM; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="m8vYgJnM"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 860FFC5CD47;
	Tue, 30 Jun 2026 10:30:04 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 103E26025A;
	Tue, 30 Jun 2026 10:29:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28508106F1D9A;
	Tue, 30 Jun 2026 12:29:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782815391; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=wEM807POe4trG4Qi2FA+FagRQw2RIVnWZHNQKyw2iOM=;
	b=m8vYgJnM+ZWEYXYbE2thSFunZHblYIMG05iP/GorDlyuJYTAZWwpgCJnTFwSJx+3jWUtTP
	wkRJ3bB8DmQIQz1RoF98UMxyEBFFtK9nLSnbRkxI9j4HGcxWNZpWUr5b+Hf2INhSUJVdNI
	vR9HZhsi8Xitq8AfZ02LR5lzOs9K22Xxu6Z7CaTXDqjppJY0PiBBpTIRoWf9WvsGpvMrlO
	KtCXOCATXou91LjnBnb1kYPRLVpKuIaBxvtec4P/V9UmX+xeBhUyYgPqDq1sqN+FcCHSYQ
	SyNX+5r33GhmpsawABN7tgeXxNZkapVBeB0Kq6BoR4QJ/7GJoqVvXSE+fJ0h3g==
From: Herve Codina <herve.codina@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
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
Subject: [PATCH v8 7/8] PCI: of: Set fwnode device of newly created PCI device nodes
Date: Tue, 30 Jun 2026 12:28:01 +0200
Message-ID: <20260630102804.413563-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630102804.413563-1-herve.codina@bootlin.com>
References: <20260630102804.413563-1-herve.codina@bootlin.com>
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
 drivers/pci/of.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index ee9eb384b377..eda14cefca5e 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -709,6 +709,13 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
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

