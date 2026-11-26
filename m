Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706622;
	b=39JYI8CBofwi2889aDp1uiFv+Y1cm3pGi72Bijz9cQME83K5ZZCwe+Iz26b8xEdWHrKE
	 s6fARqjAXSB3U8MWVIdPE0omZDRZpvrG8vOTKN8j6+i6MmayyF71LkEEQsWpX1Dxza+bH
	 BNhqE5b0WEUoW+1m5sp4GwfKXp7Qc4WHHCJNEX1+jGycSQPBK4zuPpSIdQK6SEgtiuu4s
	 /G9btL0CQkeGt9gFW8UFLobnfrgm/2C06BE7yulbR8erzbFLk79YaX79BTJPHOO0UID31
	 wrA1iY7n8BPKrrwGQmbVyiWbBowinUJ/w76/WRGmTBQmAg1Li4CaICFuaYwRomt5qqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706622;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=qhvD3w0ivPM5dfMUVhwhOD64imRMeo4JnQ1gJTLlg+k=;
	b=UbvtlS5eCRi/dyEIDCYpLmxZH9kBVWVvwNodZKVHUbebHVjnNRkUM2kyCgxMKQrgOJJu
	 +q4IFRxQc5xfRxqjorqEWkjkfVPkRewuy/swEJqste/98tfIZDCxp6+mx2IoxqYbLGBG2
	 SYIGsVmDy5Mvk3gqmucLIlVZKvhtLUWi+DNyXIgFLL9kUG7OtCJ5rHpHGqDjZ6Xj5HB8h
	 WlGfwaw4vLl+TaeZ9SjBKM0gFrmmbydd0I44dpqVQ7MK7SjUVsphrSn5FAtrHoWXAq6aG
	 DfWuhD3I9lIcM6h6/im+Q6ZXP//7TudEivF9NvwFmFdiNRxDNVZ8CTUuwitG6sVBj4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYYzEvBJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16AA606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SYYzEvBJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 712C51F000C4;
	Thu, 26 Nov 2026 15:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795706622;
	bh=qhvD3w0ivPM5dfMUVhwhOD64imRMeo4JnQ1gJTLlg+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SYYzEvBJux0zlPPDlm4zI0EnP5zoDNKzT4YCzS7f/zFzmsT5WITmjCO1s39ArA+N1
	 yVryKBaUJUhJwDwE8mGiEGN50hc58i2KhKb9LXpz+yZqgIfLYalZFv13bbXbuw5E6m
	 aCMohKEfkKHtdDLNs0j8WL1V/QnzBT9K0NK1Kw37vCM3F5DO36e1LcHydsk3/38pkj
	 hE+zEmUP3tSMpmBPJudt8M7y6v4t1Uj4Lzz9hWnN3wFw1aV2NMdkDIGmRd9W8FKgJV
	 LBJ/p9Onf7xLhSP7tkCy9O4CiilthPCXewqMKYM3J3znFZIAhzz9imp3rQ/OdNK1Cs
	 fk10Pwf82m+KQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ihor Urazov <z0rc3r@gmail.com>,
	stable <stable@kernel.org>,
	Francesco Orro <ncesco@interstellar.eu>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Huang Wei <huangwei@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] usb: typec: ucsi: acpi: Assume UCSI 1.0 on HP ZBook 8 G2i 14
Date: Thu, 26 Nov 2026 10:23:40 -0500
Message-ID: <20261126152306.2409125-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112534-occupancy-unifier-94c3@gregkh>
References: <2026112534-occupancy-unifier-94c3@gregkh>
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
[ sashal: Dropped the .write_message_out line from ucsi_hp_ops because the older ops struct lacks that member, added the missing UCSI_VERSION_1_0 define to ucsi.h, and adjusted the insertion context. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.h      |  1 +
 drivers/usb/typec/ucsi/ucsi_acpi.c | 34 ++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index 120e5a5703854..d2489d64f0ad8 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -29,6 +29,7 @@ struct dentry;
 #define UCSIv2_MESSAGE_OUT		272
 
 /* UCSI versions */
+#define UCSI_VERSION_1_0	0x0100
 #define UCSI_VERSION_1_1	0x0110
 #define UCSI_VERSION_1_2	0x0120
 #define UCSI_VERSION_2_0	0x0200
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 8c6793361b004..399a55c7d524e 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -131,6 +131,33 @@ static const struct ucsi_operations ucsi_acer_ops = {
 	.async_control = ucsi_acpi_async_control
 };
 
+static int ucsi_hp_read_version(struct ucsi *ucsi, u16 *version)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	int ret;
+
+	ret = ucsi_acpi_read_version(ucsi, version);
+	if (ret)
+		return ret;
+
+	/* Firmware fills in VERSION (1.0) only after the first command completes */
+	if (!*version) {
+		dev_warn(ua->dev, "UCSI version is zero, assuming 1.0\n");
+		*version = UCSI_VERSION_1_0;
+	}
+
+	return 0;
+}
+
+static const struct ucsi_operations ucsi_hp_ops = {
+	.read_version = ucsi_hp_read_version,
+	.read_cci = ucsi_acpi_read_cci,
+	.poll_cci = ucsi_acpi_poll_cci,
+	.read_message_in = ucsi_acpi_read_message_in,
+	.sync_control = ucsi_sync_control_common,
+	.async_control = ucsi_acpi_async_control
+};
+
 static int ucsi_gram_read_message_in(struct ucsi *ucsi, void *val, size_t val_len)
 {
 	u16 bogus_change = UCSI_CONSTAT_POWER_LEVEL_CHANGE |
@@ -191,6 +218,13 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
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
 			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),
-- 
2.53.0

