Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706902;
	b=pHO3rtSSyNqudDfejCtRUadXbTnvPgRTSVMQrD/40y2lsAejmmm5vZehZX6wPuToA0Bz
	 F1O8r4GoO9ZZdFbT2IiwexD2fGBL1vl85iI9TrSKETpyTlqmVAreXmgFwYROjj4rEMpic
	 EycR/a9tVWkK99jhRwB+5nYUCI75DaAal8h92KRETvCw9/y0ojVZKB4+w33NWLkw153ZI
	 +DhnCYiA6Sv5u0BZuVyYdYhwm1ryaYdI2JW8Z8QWmuhDRmvveUQ/gZaJqWcSK+JNPF0Fe
	 zWf9GteRtx1hh3rQ9TeDfM/5CKa95f3H93Yp/Smj2PIAbiTfhEaf+qUKvF0tye+Z89A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706902;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xCs2/k/QSJ3ypQ4g+gAAsn1uSRdfkDfitGElWEbD5L4=;
	b=NwWFIWxZpgcNWrOo7hjRxmQtWZ72/07sFwlkB8s0rS0ut0CJSi6QPsL34pmX2aTdlph0
	 +v475g3fOi080eA5IidtS0jsVylGZYE9pCznn8Ay9Tgh1y6zrId6QrgDdwp29MOrBiIrV
	 xKc6cIlNA3WI4vAKTHUXuat2KSNo4c6rEfDTc/0TKsuB3BJagRMFjEsnqkVkcQp2dxAF7
	 SPu47DcDBu9KhAt8o0fiqg97Idlsurll5eda3MdAq4RxMMS8GQOXiaWXyO06WtVLeRVyn
	 4+1wVyP5LvWVzLu5ipQkw8lc4T7ErbuySW3gdIL2FaD29RHY0aXGpru+TDhb8yS3egQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="hk/O99SZ";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B96B6606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hk/O99SZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C891F000C6;
	Thu, 26 Nov 2026 15:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795706902;
	bh=xCs2/k/QSJ3ypQ4g+gAAsn1uSRdfkDfitGElWEbD5L4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hk/O99SZeQNuVzEWIzKltsZyX3Z7d8rKfRk8nPfOkuJFh0nk1hzUNY1MmyysgXbv2
	 0r39yu0jhoxwMdLqg61hO+Ep7LcDSHTl9N5P+EJ7P2URyxKIgcCvdIKrU5PpeagOJE
	 9pwWFlT3IMv4UdeiyrjRJFYjdprBP1Dx+WJiglweEej/+H9+4G2fXcseHv4t1SHfBe
	 ChdfCWTDOIpX95f/dncToGd0Q/IAoSZfJF9wR8EPzcsDZlVrPA0YbeZkjriVnrSmml
	 BUYYTgLRIgT95SBMEGwuhAvTV4TTuW2te+D2SoisvUoJ740gloOsAXZNGb6ODtXVtZ
	 lVIEV7dvqQNnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ihor Urazov <z0rc3r@gmail.com>,
	stable <stable@kernel.org>,
	Francesco Orro <ncesco@interstellar.eu>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Huang Wei <huangwei@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: typec: ucsi: acpi: Assume UCSI 1.0 on HP ZBook 8 G2i 14
Date: Thu, 26 Nov 2026 10:28:20 -0500
Message-ID: <20261126152752.2450534-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112534-wrecker-agenda-58cb@gregkh>
References: <2026112534-wrecker-agenda-58cb@gregkh>
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
[ sashal: adapted the HP quirk to the old ucsi ops API by wrapping ucsi_acpi_read() as ucsi_hp_read() like the Acer quirk, and added the missing UCSI_VERSION_1_0 define. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi.h      |  1 +
 drivers/usb/typec/ucsi/ucsi_acpi.c | 33 ++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucsi.h
index f0cf52c6ddeba..50c41fbf06a56 100644
--- a/drivers/usb/typec/ucsi/ucsi.h
+++ b/drivers/usb/typec/ucsi/ucsi.h
@@ -30,6 +30,7 @@ struct dentry;
 #define UCSI_TIMEOUT_MS		10000
 
 /* UCSI versions */
+#define UCSI_VERSION_1_0	0x0100
 #define UCSI_VERSION_1_2	0x0120
 #define UCSI_VERSION_2_0	0x0200
 #define UCSI_VERSION_2_1	0x0210
diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 7a4969a086df2..2da6c14e34a5d 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -132,6 +132,32 @@ static const struct ucsi_operations ucsi_acer_ops = {
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
@@ -206,6 +232,13 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
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

