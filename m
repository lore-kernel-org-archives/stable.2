Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707200;
	b=bQ5Pj2CuF+ZIsmIZBUlB83nln38ghwPJ29tvM6uK/62QGPzoMnWUSF+IprAaJdKm/D9K
	 dneRniufgJwZ1vnmiVc1incOEXBUQtSb5FedFmDzHkxahZkPFxbJOkTlAXe3cfzYqoYnu
	 bUpdnehclhzhYV1LvrwzjxSjvDKTNLpqZggM8jMJ0q/DDAM1cbxqTEVxGTO8XC4aJn+qo
	 SIQAPyN4UyTP0VS5F9ocqrSP2S1PWgLbkSdFu60Va29GL+Gn1iBC5uM+cp0ViDqb2wWkZ
	 LG2wx7eu0Y89tQD0BU2cg/fnqLmA1CmSGQTtbKUWBAFlSME3+o9qxxq50ljns4LbVFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707200;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=p2gu9OJZLR3ha8ZLeNR0ZCH6KxVleHc2tqsXria5VtA=;
	b=UtEAKHCwjJG4hGza+7bs2boVkFv4K7g7qrzSpRbSo26OfOw8QQrS9/4ZFdsDdTnYV5Io
	 370bhQ/WFG6lqzmFSxzqDQPNgyKq4HMgRK/NbyL/O4k4hEUO5XYqX6GnQjZHwnKJcGg4r
	 PdM+FRdeLEinLIziliRVqz/wo3x459b4O1ZkBUqjomoJOFmlgopiaPgoxyutXmv0P9Go1
	 Qfn7VFcCmYk4vGERNVxrmczIEN+V3TyPPqCkSqE4lBNlAr8myGsyv3SXw55io6f5TTzYN
	 46bvpPdapRDBU/7RqyoCzRNn0Hr71tU1qhEiVTL4MWRzWuVe84EsuOlVVprvRVcu6+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzI8dsDY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0168606A323
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PzI8dsDY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22D71F000C0;
	Thu, 26 Nov 2026 15:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795707200;
	bh=p2gu9OJZLR3ha8ZLeNR0ZCH6KxVleHc2tqsXria5VtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PzI8dsDYKN5y+JUR7jHdp0ZpPsyBQz1C0B/YYivezJmgZ/xrmgm5K0CfQh/C90rxT
	 yt3IoZsq3ChvphmzHgwRq0pUp4Yr3WMWv6WhluxoVgd6P8nqOQeCHE2HLAATTZEr84
	 YEJPc4v2OMs5tUhBpJtDnldrS3wYPo5j+7I5Q3CcRtrDXZ2Niayh4glHxQ4SUI3LRx
	 6kWNutiDq8moWEswecB0OKUJrR4+PLBdcM5MOUQp8Kj5xCca9OKONtBPrgHuL+isKJ
	 yv7ObEaHQEr6hRmxloAKmbXwVC7nxLdYJBj4MHER2He0qZ0k3NWw4s6FXMsfdeK0jO
	 CZjPygBNFJ31g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ihor Urazov <z0rc3r@gmail.com>,
	stable <stable@kernel.org>,
	Francesco Orro <ncesco@interstellar.eu>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Huang Wei <huangwei@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: typec: ucsi: acpi: Assume UCSI 1.0 on HP ZBook 8 G2i 14
Date: Thu, 26 Nov 2026 10:33:18 -0500
Message-ID: <20261126153227.2468958-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112535-cried-husked-8ee4@gregkh>
References: <2026112535-cried-husked-8ee4@gregkh>
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

From: Ihor Urazov <z0rc3r@gmail.com>

[ Upstream commit 3ee1e1c3fca6fb5d0abbe0fc91539951ffa60aa7 ]

The HP ZBook 8 G2i 14 (board 8ED9) exposes a working UCSI ACPI PPM, but
its UCSI VERSION field reads zero until the first command completes.
ucsi_register() rejects a zero version with -ENODEV, so no Type-C ports
are registered.

The firmware's _DSM READ function (2) is a stub. The mailbox VERSION
field is written only by the EC response handler, after a command
completes, after which it reads 0x0100 (UCSI 1.0). The mailbox is
48 bytes with 16-byte MESSAGE_IN/MESSAGE_OUT fields, the UCSI 1.x
layout, and _DSM function 5 is not implemented.

Add a DMI-specific read_version for this board that substitutes the
version the firmware itself reports, UCSI 1.0, only when VERSION reads
zero. A non-zero firmware version is used as is.

The same firmware defect on the HP ZBook Fury G1i 16 was discussed in
"[RFC PATCH] usb: typec: ucsi: acpi: bootstrap PPM on HP systems with
empty _DSM func 2" [1]. The defect was reported to HP as case
5166176673.

Tested on an HP ZBook 8 G2i 14 with BIOS Y70 01.02.08, from a fresh
boot where VERSION reads zero: three connectors register, the PD
contract and alternate modes of a Thunderbolt dock are reported, and
its DisplayPort output stays up across the PPM reset in ucsi_init().
Dock unplug/replug and s2idle suspend/resume update the connector
state without errors.

Link: https://lore.kernel.org/linux-usb/f3M_fpjtt8FxDqGKcA84vqXmRbKzCBfpCrIK4-jCWvIscER51zkD8qD8FYpz75qZw51rMDRSkUyYlrBvLvdM8CGRY2l8TFVvr4MC1LdTzbc=@interstellar.eu/ [1]
Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
Cc: stable <stable@kernel.org>
Cc: Francesco Orro <ncesco@interstellar.eu>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ihor Urazov <z0rc3r@gmail.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Huang Wei <huangwei@kylinos.cn>
Link: https://patch.msgid.link/20261026-ucsi-hp-zbook-8-g2i-v1-1-91002e9ef073@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: adapted to the older ucsi_operations API by using a read() hook that patches the VERSION read instead of read_version(), and added the missing UCSI_VERSION_1_0 define. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.h      |  1 +
 drivers/usb/typec/ucsi/ucsi_acpi.c | 33 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 16ead80d3a4e7..30cbc95adf40e 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -26,6 +26,7 @@ struct ucsi_connector;
 #define UCSIv2_MESSAGE_OUT		272
 
 /* UCSI versions */
+#define UCSI_VERSION_1_0	0x0100
 #define UCSI_VERSION_1_2	0x0120
 #define UCSI_VERSION_2_0	0x0200
 #define UCSI_VERSION_2_1	0x0210
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index eeb457ff255e4..47630be780ebb 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -131,6 +131,32 @@ static const struct ucsi_operations ucsi_acer_ops = {
 	.async_write = ucsi_acpi_async_write
 };
 
+static int ucsi_hp_read(struct ucsi *ucsi, unsigned int offset,
+			void *val, size_t val_len)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	u16 *version = val;
+	int ret;
+
+	ret = ucsi_acpi_read(ucsi, offset, val, val_len);
+	if (ret)
+		return ret;
+
+	/* Firmware fills in VERSION (1.0) only after the first command completes */
+	if (offset == UCSI_VERSION && val_len == sizeof(*version) && !*version) {
+		dev_warn(ua->dev, "UCSI version is zero, assuming 1.0\n");
+		*version = UCSI_VERSION_1_0;
+	}
+
+	return 0;
+}
+
+static const struct ucsi_operations ucsi_hp_ops = {
+	.read = ucsi_hp_read,
+	.sync_write = ucsi_acpi_sync_write,
+	.async_write = ucsi_acpi_async_write
+};
+
 static int
 ucsi_zenbook_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t val_len)
 {
@@ -205,6 +231,13 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
 		},
 		.driver_data = (void *)&ucsi_acer_ops,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8ED9"),
+		},
+		.driver_data = (void *)&ucsi_hp_ops,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-- 
2.53.0

