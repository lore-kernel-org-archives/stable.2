Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B1642FCD0;
	Fri, 17 Jul 2026 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784299986; cv=none; b=Zc9z1SNMSMzZzI1FesJjK7wxUjPZ/xHN6+yu073eHuz6sBWLMdGyD7II0vztJezpfIaKx8TGJ/nNM/YG+Km5cAUbGI4sz22KBYUvcUcHhkPrQc9/mXKhTKksev+9xiaddlp5/G/BZKLCYnpawqKJjIcP7mO0FVeLroCOKhBrlgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784299986; c=relaxed/simple;
	bh=dyxCvKqe/bgL8/UAv84A8tM51QU4qZZ3bv7WC2hGeKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ozkgDoyUuw+y4lP/9rL764EeHzsYvyF0/OPPn1iBiS5sCAlTbIvdyUCPuBNAQZy47M30t5hdejd/+RLTMXLIYq0LrmfxGFvxeRoOygCX6DJq3+pdLW/MosaWaoT4iq5mMdIE/pNDrF7ZfQbljzowKFvlKvryyrWSA9I3aE8VqxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LQmm/Ucm; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LQmm/Ucm"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 48C9D1A1065;
	Fri, 17 Jul 2026 14:52:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 1AC3460361;
	Fri, 17 Jul 2026 14:52:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9892911BD2195;
	Fri, 17 Jul 2026 16:52:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784299975; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=qCmU1MyL7zxZtzwAGxXkVRLqO+rKk+ae2dd7R96TSC4=;
	b=LQmm/Ucm+1wOR65qotHec+wGwY0LnMW680p0HtvhPcaBSe0fi5Fqt51Zs/zZofJtGh4OIi
	4cNSlzEel9WdAfHb15+zLmWdNWe1/zOJGtTbtLp8yWjjq3b6CT2vZeXO0IciKP31vVNGGh
	4PYing0unFjmzs33QZGZ48LKQKXenkDOEfiJbNXXSL1z4KVHE+z54WSv7Ao3KjDd6W82lB
	uOBHMddLv+sV1fe5mQBFHgy6paT6jE18cvomTHd3eyqxNxgRTpblVHDw6f/JokqC5UfFvk
	/P3YoxXMBfXiaoq/tR4MM+VG0YoZmJnK92NkGmtVSuoThSgZGoaXN5j3aWL6lA==
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
Subject: [PATCH v10 08/10] PCI: of: Set fwnode device of newly created PCI device nodes
Date: Fri, 17 Jul 2026 16:51:43 +0200
Message-ID: <20260717145147.823749-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717145147.823749-1-herve.codina@bootlin.com>
References: <20260717145147.823749-1-herve.codina@bootlin.com>
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
 drivers/pci/of.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 6a533f9bbf3c..a98f360c289a 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -657,6 +657,7 @@ void of_pci_remove_node(struct pci_dev *pdev)
 	if (!np || !of_node_check_flag(np, OF_DYNAMIC))
 		return;
 
+	fw_devlink_set_device(&np->fwnode, NULL);
 	device_remove_of_node(&pdev->dev);
 	of_changeset_revert(np->data);
 	of_changeset_destroy(np->data);
@@ -709,9 +710,16 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
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
 
@@ -726,6 +734,8 @@ void of_pci_make_dev_node(struct pci_dev *pdev)
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

