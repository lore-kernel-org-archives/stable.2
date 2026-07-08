Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6ED38C2D4;
	Wed,  8 Jul 2026 10:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505098; cv=none; b=In5vXGOLPYs83k/dW7dWfhLsqLIXGJw0IjAcuN7yZUoC5tE+vrBfkMifgRvZFy6wRQiJDfux/6ue1Dj46ZuNIn+oL1hEvXUZ84D2jEYGVOsL+dtOI1SjCPd4q2F/OYRNIYNmTHLI/wA7Z9OQOg2zjBRYOquwnwzczMntVmsnsUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505098; c=relaxed/simple;
	bh=xyfH6doCc7i4sKmvbyl3EEgYdlvB7hed8KKE/NxYwQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NidjWVqNO96/8s8XmDOfNfGI+HIwCm5Rt1OvEqSA554S9nMIiEK/i9vaqem7ypJUJYfdye1GMRaGa1MxMxs/Rgy97GAk4gbV+Uh1KBMCo/8kBKJtdPWuwerFRs5yDQfg56glYq2cGxLRweJLtWVJO49Lovg3BRWbom2ukPhQtfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aZVFJSBl; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aZVFJSBl"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B86344E40CF2;
	Wed,  8 Jul 2026 10:04:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 8C1C560337;
	Wed,  8 Jul 2026 10:04:55 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BC29E11BC333A;
	Wed,  8 Jul 2026 12:04:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783505093; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=w9+HL8YzUCvPl39+FuJI3IoQ23qvAeEZjFCCDFbNqtk=;
	b=aZVFJSBlkrdzNUA9dPq+XKYA+Z9LUoiiblc3dvEMdNTEEg4Rk/QybiycMePYtR9L/lXRDf
	yWmt04VhpfkxUuyw4SA/A57nkOYTNdX/tdIP75sF50uexRfUTZrFsHJ4Cmdkdv32C6MODw
	iGddlE+SN4gg5iS1qmrZ7bDJO9Rw/L05u4MLVWvKWMqxT9uidDMEIJgk3IwmcWNiVxk/bG
	frSosNJWneZiSB3814wz1Qm4Gfkz37ktpCnw1EulnqbvVsa+aDGI8/tUeaLAyzGxoJqRz6
	gJQA7q9d+BXJLUR+HgUHgDa182Od+4gzRldRqmzT6a/uib3JETNpOdVrUwu8Qw==
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
Subject: [PATCH v9 6/9] PCI: of: Use fw_devlink_set_device()
Date: Wed,  8 Jul 2026 12:02:56 +0200
Message-ID: <20260708100302.517792-7-herve.codina@bootlin.com>
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

The code set directly fwnode.dev field.

Use the dedicated fw_devlink_set_device() helper to perform this
operation.

Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
Cc stable because used by other patches with Fixes + Cc stable
---
 drivers/pci/of.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/of.c b/drivers/pci/of.c
index 8b18c4ba845c..ee9eb384b377 100644
--- a/drivers/pci/of.c
+++ b/drivers/pci/of.c
@@ -803,7 +803,7 @@ void of_pci_make_host_bridge_node(struct pci_host_bridge *bridge)
 	 * bus. Avoid any new device creation.
 	 */
 	of_node_set_flag(np, OF_POPULATED);
-	np->fwnode.dev = &bridge->dev;
+	fw_devlink_set_device(&np->fwnode, &bridge->dev);
 	fwnode_dev_initialized(&np->fwnode, true);
 
 	ret = of_changeset_apply(cset);
-- 
2.54.0

