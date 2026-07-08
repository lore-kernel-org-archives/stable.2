Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2263D38B12E;
	Wed,  8 Jul 2026 10:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783505072; cv=none; b=YUSAXRXrgNyK2iAUZdHXygDradrZhVuNc0gfsh0Zuu8yJ1yaJmJOYIxRwQ/i7p/XT7Y9zg5Fs9H01ccEkWEtjTstEy+k+e3vP/eAA96jld5YQWM3zD2kqtA/cq/XmAESKdQTdHXWtS6QYKT/iD+HtotoEYXc+bF4r1UxuXNP0UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783505072; c=relaxed/simple;
	bh=Dr7yY5XLV8e/9e5N9FOL+bV4EWOSxszyyOnFOIzQXrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gWkxwMgMEs/WZS5A+3gehu7IuZymwoL8Ie3f4rZr4BfPbSmBfmFRFsm+8K0w4YjYJoCBa5lE+6YlJb/2p42viJeaIIPry9XVZ59RKNv0wsOfLpx9mQAkLtX8bSDVablOdzWIXhD76mR2bWJRbpQ03QTIoksLx08qRbS/5BWrkJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=MESKkIMf; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="MESKkIMf"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id DCDE31A0EDA;
	Wed,  8 Jul 2026 10:04:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A8B7860337;
	Wed,  8 Jul 2026 10:04:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D911511BC33D6;
	Wed,  8 Jul 2026 12:04:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783505067; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=N5mQBROnrDBEAwginXZzryOTa1g0CZWIynlCLymzLoo=;
	b=MESKkIMf7M9PljdQihORQF2hfIL8Vpu6e/+i3mujJWBQrGBD+U3R6lG0xoUc0S5JTeaTfy
	Y+XPW7+0QuF5cWNdb3Vm12uzY4wCaheRs2gDcrX9VlFC2zby0Zgzf5i7MLoH2THSx50Xbg
	t88Rl4892Cdkt7FPFM3viEGz/Jwe2grrf7QX7pRq7CufXZzdIzY13hdpZVRO/VvJWr2eSQ
	VBuVr8VRM0SjzF1iwPL1KANlQqwGJCBGi8k8m6Ug6o5k8GReX4riK6EGjsseoxpdI5yvcw
	T6R+utUAoYSBWQz7wVeFuusd8UrKymfWQ/ARJryDKXfa0WVYyEJFsZzUN1e8ww==
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
	stable@vger.kernel.org,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH v9 1/9] driver core: fw_devlink: Introduce fw_devlink_set_device()
Date: Wed,  8 Jul 2026 12:02:51 +0200
Message-ID: <20260708100302.517792-2-herve.codina@bootlin.com>
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

Setting fwnode->dev is specific to fw_devlink.

In order to avoid having a direct 'fwnode->dev = dev;' in several
place in the kernel, introduce fw_devlink_set_device() helper to perform
this operation.

Having this helper allows to hide the fwnode devlink related stuff
behind the helper.

Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
Cc stable because used by other patches with Fixes + Cc stable
---
 include/linux/fwnode.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
index 4e86e6990d28..31538f54b1ca 100644
--- a/include/linux/fwnode.h
+++ b/include/linux/fwnode.h
@@ -256,4 +256,10 @@ void fw_devlink_purge_absent_suppliers(struct fwnode_handle *fwnode);
 void fw_devlink_refresh_fwnode(struct fwnode_handle *fwnode);
 bool fw_devlink_is_strict(void);
 
+static inline void fw_devlink_set_device(struct fwnode_handle *fwnode,
+					 struct device *dev)
+{
+	fwnode->dev = dev;
+}
+
 #endif
-- 
2.54.0

