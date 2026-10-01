Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C024E522695;
	Thu,  1 Oct 2026 14:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790864989; cv=none; b=L5Sch+XZTpv4lViYkHLMpntC+JRlB7nHd7zDZGmuvf4NvOFbBBusrbSteybxcw4BbP5zgQ9BLPri5Z5AcotDTogmF1Y3h+7h+gIOsWILTVF0zqHULdNSH8JhYNq3cyos8q7h079rhhaO7Z9keWpRhSpbzZo0q0OTtKnZIbkkJdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790864989; c=relaxed/simple;
	bh=JyaYp74hyva8mz2RggMjk+t8RJI4RaB768yDtXt9oRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBepuLbE9nHzZ5gzRooLFB6OvaHXXVSa6B37m+2kdv5zZ1T4mzXeTMCRY1mNOrAFbmHUrlIDNOvkVYETXf56K4eDVdpHwg5nRHFp3uUHlRSultVHkd1ru1uuHRLt+nOHNkjAfZQxSZkTTVrKjkVdTD7uDSwJ8mnO5M4JAKn/PIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LZY5ylAZ; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LZY5ylAZ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E140E4E4136A;
	Thu,  1 Oct 2026 14:29:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B234B60341;
	Thu,  1 Oct 2026 14:29:40 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B8E210328188;
	Thu,  1 Oct 2026 16:29:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790864977; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=I1e0hByJo0lwlUNMu1e3zjHq/L3qiW6+OWE+PPvPOK4=;
	b=LZY5ylAZgarHaVoGAnh+oQ/R1S5B/6ku8R3lYW7GgOr7Yke/P7YfCy7Z7w+xY/NRlwwNjh
	zGyZWOTjottSoUlskWZE8UY8+C26u9vGScDihB24SJEyZ5TBKFmYEm8anyadBu6yREWLwL
	QJo8V76jr/8g/CYVu/baq1sGiXfzTEwn+SsdUqgyHjYOjVNJwy8kpEALO0cK4vlwM79Un/
	QDMDLojmZWPxSrNhAXNAP98w/J7gRV5RdVwVVg+nucebYyXSHHw/YJqTN2HSLYC6G9/dKM
	ucRQeRJqhGjwtMNwZ1kbO68GiUKEfGJRTx3Pg+szHGFy0K2nJyR9BnwEH01Yiw==
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
	stable@vger.kernel.org
Subject: [PATCH v12 09/10] PCI: of: Remove fwnode_dev_initialized() call for a PCI root bridge node
Date: Thu,  1 Oct 2026 16:28:09 +0200
Message-ID: <20261001142815.277550-10-herve.codina@bootlin.com>
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

During the instantiation of devices described by a device-tree overlay
applied on a PCI device, devlink displays the following kind of debug
messages instead of creating the expected links:
   'Not linking xxxx - might never become dev'

Without those expected links, the device removal order cannot be
correct.

Those debug traces are printed by fw_devlink_create_devlink(). In our
use case, they are all printed because the supplier of the link has at
least one of its ancestor with its fwnode flag FWNODE_FLAG_INITIALIZED
set.

The culprit ancestor is the PCI root bridge.

The fwnode related to the PCI root bridge is created dynamically by the
of_pci_make_host_bridge_node() function. During this creation
fwnode_dev_initialized() is called which set the FWNODE_FLAG_INITIALIZED
flag.

Calling fwnode_dev_initialized() tells devlink that the device related
to this node is handled out of the driver core. This is not correct in
our case. Indeed the device related to this firmware node is handled
using driver core mechanisms and is fully compliant devlink
expectations.

Simply remove the fwnode_dev_initialized() call. With that done, the
devlink debug messages are no more displayed and links that were missing
are correctly created.

Fixes: 1f340724419e ("PCI: of: Create device tree PCI host bridge node")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Richard Cheng <icheng@nvidia.com>
---
 drivers/pci/of.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 8914bfa25dc1..0a5797652e18 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -894,7 +894,6 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 	 */
 	of_node_set_flag(np, OF_POPULATED);
 	fw_devlink_set_device(&np->fwnode, &bridge->dev);
-	fwnode_dev_initialized(&np->fwnode, true);
 
 	ret = of_changeset_apply(cset);
 	if (ret)
-- 
2.55.0

