Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793721445;
	b=rmEEaFaWeeRGTPX4pUEK2pOf9IlCXaRtuSdrkd7SJnFMbzDXfblk9PtqCBss2ce9pbym
	 jy0JP8sTddtQucjmvbKqy336+B9rMqr3GdXx6D9IDRQz+xbo/Jsi3LQ0bJBh5oJklrQ3q
	 OwXPnxt+jLzshFqNZJE7PO5mLEn/QMFn3s4rsOfLjfMWlrqcYMi6YPZX5u0Evy19jIB/m
	 iQqdIgjIxCwrAAWR5eqtJ0HtA6Je3H3cs9Sob1JYzEuAk7tgll/LEWyr8zOdp+BQEzcZE
	 xe2GpxOHoG6tQPW9WgmTePFAuYXCGFpywxlA06u7r+bxQ9dVWt53mgg91In+tMq67Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793721445;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=2TvMe4LCKmILWIzuz3EJ3JpqPzOFZ/3qb8oZ/Z0fiHg=;
	b=14PBUD+csT5rB1lR/dwr8zXHCpSwIfrVuq1/k3RV0xumsiLt1BjCrmNEUX1ESDtYzIEv
	 wzYHaT2EBvoZNWVsKgPikdgxmneo4qIW5zs5DmsDFmHcaNlaCFjVYVBIsLoX3iAP0kgGa
	 /EXx1lTVf3ptYMpvVw9hMPoud6Nh2MTlhvcQmoUIhQHN8E03k0RH6ikzyMC2g0BcJpclx
	 Z+n+pL0gT7i2jOlpH296PS8RTABgvUNx3yZWl3AjBQlLbKXmsnnfAQSoBxJzw/m9W9dhB
	 NXyFr4+lzfRtMbswTVqLWBlWpqTa+xy5ItEc+nlcRXnalulQxuqAY4hXFO/bw1BOLOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=R3aDJtz9;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1304606A335;
	Tue,  3 Nov 2026 15:57:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1304606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=R3aDJtz9
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id DE8B9C49F46;
	Tue,  3 Nov 2026 15:58:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4CB7B6046C;
	Tue,  3 Nov 2026 15:57:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 25325103291F0;
	Tue,  3 Nov 2026 16:57:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793721440; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=2TvMe4LCKmILWIzuz3EJ3JpqPzOFZ/3qb8oZ/Z0fiHg=;
	b=R3aDJtz99zjte1CqZo19m834oE4Swv73b6FGJWDXOnqp1JuT+65BtZsm0fYk5Z4r4YH6dd
	LTXlZNE4fASpH3FU1VPIe6RHebNAsHx174HiNzbIo3Wz7XJ7opWhSmsIZfN/IznySXmheG
	K3f0/86lqQYUBsIlqN0dI0C+M+YI7s6Oi55W7Mgs0Kk5yiWFlPYAt/9v0si1RHxkiiL4Cw
	Xk80rcfv2ujQsTaDy+uswNaU3GrQ4NmZ1MQg+2/kBSCTMkb+7aMgzy0SSKXZbQ35rv2dvR
	LSY78mPwuuoBDISQpkpSk5bPPZHW3f4E+qYAYRlKMhZDjDJWzSS9fIe+fix7MA==
From: Herve Codina <herve.codina@bootlin.com>
To: Abdurrahman Hussain <abdurrahman@nexthop.ai>,
	Richard Cheng <icheng@nvidia.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Johan Hovold <johan@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Rhodes <david.rhodes@cirrus.com>,
	Richard Fitzgerald <rf@opensource.cirrus.com>,
	Charles Keepax <ckeepax@opensource.cirrus.com>,
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
Subject: [PATCH v14 08/10] PCI: of: Set fwnode device of newly created PCI device nodes
Date: Tue,  3 Nov 2026 16:55:14 +0100
Message-ID: <20261103155540.365294-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103155540.365294-1-herve.codina@bootlin.com>
References: <20261103155540.365294-1-herve.codina@bootlin.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
Tested-by: Abdurrahman Hussain <abdurrahman@nexthop.ai>
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
2.56.0

