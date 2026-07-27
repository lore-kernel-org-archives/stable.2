Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1C73E44EC
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 13:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157998; cv=none; b=Wpd8sVg0k2JZoj9fvLDEHWXrBgO25GB8pKI35GDHmn6wFDtVPjXRhNeJjQfrShhPxw6kddHy7q1BJX5XlacRtq6pvXtSNXkP57IVTxVccjz/1xua65FiVsfpl25n11PKECh1gbhHT9GWYKWoxyy8EmUtnTRjhjeKyqcPQJA+a6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157998; c=relaxed/simple;
	bh=+ZU5cHG8gA8S5d9P0bqUtA4WRa/W5bIjOhKcZUpWaks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Avg9lvl26gK93TBH6gPLZrNoVjuXd09o7fkLsdvjkOPf+d9mHEN5lFLAmvNqR7SVrrdQXfO2AoZCSHV9BG5gEAS70Cg4HmbjYUiVnScD4u2Pf4CEQeb2I1/U6fAoQ0aVMO0+SAjXfn8LNu5/bHx5eCFVFymSOrUIynb4PGeK/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EVTW5VV8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EVTW5VV8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0599E1F00A3A;
	Mon, 27 Jul 2026 13:13:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785157996;
	bh=J1FTYhIdSMXwlPG+P+M1PUvXgJT2hwE5I0WgqeKPmjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EVTW5VV81Jh8jYCNFMNGL1gdiERdiLJyy7XRGEJ+GYoBwzovcs2xUXPqXD40+RJQ/
	 lyZe/qXF2jqKfp3h8gCpSeWU2UIgiPTG4IsbprhMhjlmNNYL7RO6hibwJn1g57eIeG
	 3bCFH5o9XL3cqENcy3jej1yiU7ne/J0/zjJJr+ha/UeLEHvj4RA7qdy7JiBXXKqUoW
	 Xba77FkYkiCuJ977Vd7O2YYjWYg+KU3XQ4iy3QM8Vogtm5he7Sy7Z6u0dpqAdYon24
	 JVHAOBPYZaM7GVC7S70RiiFrwb03GGUh1KnjlvUHJnXBQNZrqBPxdA+fE//ENcRj4H
	 NnelSSP2gRSXA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Frank Jungclaus <frank.jungclaus@esd.eu>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] can/esd_usb2: Rename esd_usb2.c to esd_usb.c
Date: Mon, 27 Jul 2026 09:13:13 -0400
Message-ID: <20260727131314.399083-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072029-exit-twerp-6461@gregkh>
References: <2026072029-exit-twerp-6461@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Frank Jungclaus <frank.jungclaus@esd.eu>

[ Upstream commit 5e910bdedc84c1f196863cebdf27c1806449c27c ]

As suggested by Vincent, renaming of esd_usb2.c to esd_usb.c
and according to that, adaption of Kconfig and Makfile, too.

Link: https://lore.kernel.org/all/20220624190517.2299701-2-frank.jungclaus@esd.eu
Signed-off-by: Frank Jungclaus <frank.jungclaus@esd.eu>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Stable-dep-of: c43122fef328 ("can: esd_usb: kill anchored URBs before freeing netdevs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/can/usb/Kconfig                   | 15 +++++++++++----
 drivers/net/can/usb/Makefile                  |  2 +-
 drivers/net/can/usb/{esd_usb2.c => esd_usb.c} |  0
 3 files changed, 12 insertions(+), 5 deletions(-)
 rename drivers/net/can/usb/{esd_usb2.c => esd_usb.c} (100%)

diff --git a/drivers/net/can/usb/Kconfig b/drivers/net/can/usb/Kconfig
index f959215c9d53af..1218f9642f331e 100644
--- a/drivers/net/can/usb/Kconfig
+++ b/drivers/net/can/usb/Kconfig
@@ -14,11 +14,18 @@ config CAN_EMS_USB
 	  This driver is for the one channel CPC-USB/ARM7 CAN/USB interface
 	  from EMS Dr. Thomas Wuensche (http://www.ems-wuensche.de).
 
-config CAN_ESD_USB2
-	tristate "ESD USB/2 CAN/USB interface"
+config CAN_ESD_USB
+	tristate "esd electronics gmbh CAN/USB interfaces"
 	help
-	  This driver supports the CAN-USB/2 interface
-	  from esd electronic system design gmbh (http://www.esd.eu).
+	  This driver adds supports for several CAN/USB interfaces
+	  from esd electronics gmbh (https://www.esd.eu).
+
+	  The drivers supports the following devices:
+	    - esd CAN-USB/2
+	    - esd CAN-USB/Micro
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called esd_usb.
 
 config CAN_ETAS_ES58X
 	tristate "ETAS ES58X CAN/USB interfaces"
diff --git a/drivers/net/can/usb/Makefile b/drivers/net/can/usb/Makefile
index 748cf31a0d5347..1ea16be5743b4a 100644
--- a/drivers/net/can/usb/Makefile
+++ b/drivers/net/can/usb/Makefile
@@ -5,7 +5,7 @@
 
 obj-$(CONFIG_CAN_8DEV_USB) += usb_8dev.o
 obj-$(CONFIG_CAN_EMS_USB) += ems_usb.o
-obj-$(CONFIG_CAN_ESD_USB2) += esd_usb2.o
+obj-$(CONFIG_CAN_ESD_USB) += esd_usb.o
 obj-$(CONFIG_CAN_ETAS_ES58X) += etas_es58x/
 obj-$(CONFIG_CAN_GS_USB) += gs_usb.o
 obj-$(CONFIG_CAN_KVASER_USB) += kvaser_usb/
diff --git a/drivers/net/can/usb/esd_usb2.c b/drivers/net/can/usb/esd_usb.c
similarity index 100%
rename from drivers/net/can/usb/esd_usb2.c
rename to drivers/net/can/usb/esd_usb.c
-- 
2.53.0

