Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD785275A1
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791913886; cv=none; b=hnobbpylzVolVOTGRfbPNKA/hFOYnZ8Ry8nsn/+Lrx5erpgk1Fbz/2jAJwxD1J/mUByvwjEhx2pt3ydLLPAFlVzPTTQlubPLS7aW23CE0vRNUYoF0wIYjjHsnlOaoAqBeYyknXEhjojHqlcnPUZICCjNgL6Y2zXu/zEPvW0lSmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791913886; c=relaxed/simple;
	bh=JyaYp74hyva8mz2RggMjk+t8RJI4RaB768yDtXt9oRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lUcotupsKP7JJ138PcvxOsFEZ9Cg0t9W3JWUnLvDm1UuMVmCEpnmYTJ8H8YNr9iAn2cXKNSa2KznMR3zymbfHhvRnt1BBI2eky6JGWheAdkDycEBiPwRz2AED3eaNFCu4LyoxsA07nJ23k+aW77NOU0VGLFC2wCzvORnqSrH5NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Kaoj2yN7; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2P1uCRnC; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Kaoj2yN7";
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2P1uCRnC"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 647941A1219
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:51:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 3822360362
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 17:51:23 +0000 (UTC)
Received: by mail.galae.net (Postcow, from userid 0)
	id CCC6211D7183E; Tue, 13 Oct 2026 19:48:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791913882; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=I1e0hByJo0lwlUNMu1e3zjHq/L3qiW6+OWE+PPvPOK4=;
	b=Kaoj2yN7pM8dbGdNifNj6a649j/HhkyDPVXpGjFJBeOVGCypXefUmT1H0db+Izzw+thCt1
	31E1jL9nCFzXYmzIJIDisDR1XN6KSJpOsgHtEgjwUKGGdzXfyHlvB8ot1UqjyoyKAvjZKA
	alZyWNZ8ZQeuyW4nH5wyfVzJl1pj8grQOKTpp9SUepgSaS4gLEDCrETlT6agXTajnLe6nG
	MSejHlqQ4YN4nBukTLRvxd4bg+7JDrP8bGp5a/Rvf2BLdWEF6ZkX3Fj9VHs8gj+gqP0chE
	JzUXzQsrnJsebd13b4A9JG2NIiEIMcoGCOMa5k/JhtNG9ibTAp5JSJfzmP+IwQ==
Authentication-Results: mail.galae.net;
	none
Received: from mail.galae.net ([172.22.1.253])
	by 9e7fea892943 with LMTP
	id SNbrGOvuzGqxHxEAtaWaaQ
	(envelope-from <herve.codina@bootlin.com>)
	for <herve.codina@bootlin.com>; Mon, 12 Oct 2026 16:30:03 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AA4FF11D70508;
	Mon, 12 Oct 2026 16:29:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791815396; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=I1e0hByJo0lwlUNMu1e3zjHq/L3qiW6+OWE+PPvPOK4=;
	b=2P1uCRnCsO3Do3ZrcvAShPBPCxTJpHhZ6h65FLDvjj1LaicvmYuNq2DsrCcZeLr/iJvxs9
	rR60DlGNvC0pwpodOUG3dbA6mzlPbGZR6EfumyT3dA3r3h6/xdkc/D3Y1Xvtak1aeMx0pz
	22xk5i9RJaIXaJtP4uWeK1zgCSpfbpbBtPzazxD0CIyGWWNDoFlahteBaTnmzTUfIPVCd/
	HeaWg+hEp4doOil+nv+xeHcy/w73W3pwFQtI2PlXa3dj1KwLlIug5yWVlC3MLkFdvnXjQP
	vnixOKQkA6mfbQaB8NiN75dd1/62w+sp4hZ60v28xTwyUB2OXqEH5Ad+NR451A==
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
Subject: [PATCH v13 09/10] PCI: of: Remove fwnode_dev_initialized() call for a PCI root bridge node
Date: Mon, 12 Oct 2026 16:28:23 +0200
Message-ID: <20261012142826.159178-10-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012142826.159178-1-herve.codina@bootlin.com>
References: <20261012142826.159178-1-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Last-TLS-Session-Version: None
X-Rspamd-Queue-Id: CCC6211D7183E
X-Spamd-Result: default: False [1.34 / 30.00];
	BAYES_HAM(-1.16)[82.34%];
	DATE_IN_PAST(1.00)[27];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_NO_TLS_LAST(0.10)[];
	URIBL_BLOCKED(0.00)[localhost:rdns,localhost:helo,nvidia.com:email,bootlin.com:mid,bootlin.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	BCC(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[herve.codina@bootlin.com];
	RCPT_COUNT_TWELVE(0.00)[43];
	PREVIOUSLY_DELIVERED(0.00)[herve.codina@bootlin.com];
	DKIM_SIGNED(0.00)[bootlin.com:s=dkim];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FREEMAIL_TO(0.00)[nvidia.com,lunn.ch,kernel.org,linuxfoundation.org,google.com,opensource.cirrus.com,cirrus.com,linux.intel.com,gmail.com,stgolabs.net,intel.com,zohomail.com,bootlin.com,amd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MAILCOW_DOMAIN_HEADER_FROM(0.00)[bootlin.com]

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

