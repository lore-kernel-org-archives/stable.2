Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792972075;
	b=ihWq8USvS1DQzjc1EMXPBpFpdjJSe5zlu2PyeJYVrx4RhcOb8aYDDFYG0oBnIAtT85XT
	 bMJWKjZiOuJ3AYdaZIZEiAeW/MVSl0kzIiBiYh/TkB/XHlEgnlJdD5nm+1Xpl7aCg6N49
	 r1++CGzhMzi+I/WpOY/BO1gvFfcZwY6MTkII+55AQksmMP9e2TGWfGrNXOinNzWx5pgAF
	 dX8Vl28LwU5bMoSKaL3+wNTeOh5ku+10xgYY2putQKBFw9zCuAQmBIAImPE0AAWueOixp
	 H2CX5RzjfrThV41yPFC6DTtnWOaggfq8A9blzEWt/lHmzD3TNqB+fuElD5Sg/FwT+EQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792972075;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2yg3jmdq2UHiiRRzD0ZbP28dzxHUaJul0GWd80ON/y0=;
	b=sRZ5EOre46bvRxp4xeVN4vt5ztlIIsynS8RagWt11o0CtX1FlxU55jMthc6Q2VoRLjzH
	 G6fQYnJhBI9F2vQNEgUZ7tRs1xILmsIUNbPqMy4R9VcLfY0L/j2W4+eVcTwbkMA72+DL5
	 kckfyQjvQY8Zr081Ysv6kXY1U3Jq4LiimEMry4qPjrWPSLtZDpsUBj1fP/IPlzQV/mETP
	 gArVe05AFjsIRJSBoQ6vYKmP/04szfthSajhktfEwHrIfZW7L5XJQXNbGm+uAig9bBuF3
	 +0lj37d8v7Bj4GutEkD7ggtXuGPX2ZryAyxsgom/2e9Ml00Zq13/ibkN5OSAl4llCyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U8ldsg1V;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78971606A31A;
	Sun, 25 Oct 2026 23:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U8ldsg1V
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792972075;
	b=F9XP6Zkd1ihxON3Hfrwzts12Jt7ND5V5IIhgK20AU603F60PxaoT7vLgfmV2Ez1dnaKV
	 RrJxG5X9HiskngyTnBETsIrpItpBDFjVL0I5WK9n0V4+WT9YINRAn11PUFEZBoiVeD11g
	 XtZ1MoaIfS1xSC3VTdWxdRkvDo+ie255/h8oZVXnOgEJvgy9fgae+OUhBW9qzO509bln4
	 g32+pt6C/0Nhok0yv4CgQiE/KYv9tMo9Udxr2707/PGCxCt1WQjv2TsDiQWamqNyNiURK
	 hJ06/0M+AMqQjkcXZFUSnLhZZSbppfWf1yRyRY9ZOrFkuxrYTo9ZDlYypskXOt0Ae3A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792972075;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=2yg3jmdq2UHiiRRzD0ZbP28dzxHUaJul0GWd80ON/y0=;
	b=utNxcrPThO0B3oaj4PLGGXhY59ImtKyxzwWE6f6moKRj/zEOneQoqRroMGlxP02j8tO7
	 5VUONbjLpDe0VU4+nIjw/U2QHCkDgW1q8u4k7N3b2yTVFfBlISZnOpdDhUZ9bkExwnKcX
	 eh58Gr4JmxUv2vLI6z5a+W82I+sBS1jGb+PXKHHVZCwG6mfDjgif7Qvl5fAqKHWoi9FuH
	 S4S6fZjVUbsqRT9przfN48NqdQuqSpBV5Xg98+cdjFim/+vMjzI4Phef4eBDdZUEfvpEu
	 fpx/7cYnvVMb0ZZXa5AXeipOYDxFbfVpeQzr1NSSgNtg/H0yEZEFwxjB+/tBObNZbVw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 71FDA1F01825;
	Sun, 25 Oct 2026 23:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792972074;
	bh=2yg3jmdq2UHiiRRzD0ZbP28dzxHUaJul0GWd80ON/y0=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=U8ldsg1VpBe6PBqoOxP25Dc/M1+TTkRVWb3AOHl9SvCJb7eG1lu8Pllkd1pVhebJd
	 WfTY2iBPqEgLfVTVMSonIwHhWwOnVw4Lfx0vdTzTW5ITxusaWmB1xaFmZj/ETItqpr
	 0+19Ti2vLy+ohA2SKBWz/M/nw+m42tKzIoHedue9EKHc2COd4dEYavkC2amR0ufzCm
	 so63BvCttyc94uY/YkxaX+evzzYvl8qui1TdB5ADD9T8g+LWsN8QrcygLbUuKf17PT
	 0zaFm39nOSCD7fl6C/EM3JlISJZiEWVZwch1+PlXZYN8G7bVmLdIriEt68Heq72Fe5
	 TOCeoZE+/6EYw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E4D7644B1F;
	Sun, 25 Oct 2026 23:47:53 +0000 (UTC)
From: Ihor Urazov via B4 Relay <devnull+z0rc3r.gmail.com@kernel.org>
Date: Mon, 26 Oct 2026 01:47:52 +0200
Subject: [PATCH] usb: typec: ucsi: acpi: Assume UCSI 1.0 on HP ZBook 8 G2i
 14
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261026-ucsi-hp-zbook-8-g2i-v1-1-91002e9ef073@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBCF4avIrB3QkIbSqxQXJpnqWEgko6UYc
 ndTu3iLb/H+DEKJSeDRZEj0YeEYKvq2ATePYSJkXw2qU6avw90J47ziYWN84x0nxai1NqM1dCO
 voT7XRC/+XtXn8LfsdiG3/VJQygnhDZjkdwAAAA==
X-Change-ID: 20261026-ucsi-hp-zbook-8-g2i-4446ab6e5ed4
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Francesco Orro <ncesco@interstellar.eu>, 
 Ihor Urazov <z0rc3r@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4018; i=z0rc3r@gmail.com;
 h=from:subject:message-id;
 bh=xe4U+KYh11Pj1uxmd73sL6TM+I5I1Id6YUmQWliU7IU=;
 b=owGbwMvMwCWmab25vPXFu0bG02pJDFn3pmoetTq2h5Mn6++0gi3vWS4yafMwFz+yfshrcrrji
 eWRLSfNO0pZGMS4GGTFFFn69xnwaguZijN9sXkDM4eVCWQIAxenAEyk9xUjw44Xd3VrqxdJuX+K
 sjZh3mOnl65VFv1g052feftPXTmrvYXhN/uZwiQLz+ZPl7er8/BO7bv21TJrRiAro+7+GVtYOa9
 t5gAA
X-Developer-Key: i=z0rc3r@gmail.com; a=openpgp;
 fpr=F7D877ECBB274E704A31F3AC5D006BEB7252F7F2
X-Endpoint-Received: by B4 Relay for z0rc3r@gmail.com/default with
 auth_id=1320
X-Original-From: Ihor Urazov <z0rc3r@gmail.com>
Reply-To: z0rc3r@gmail.com
Content-Transfer-Encoding: 7bit

From: Ihor Urazov <z0rc3r@gmail.com>

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
Cc: stable@vger.kernel.org
Cc: Francesco Orro <ncesco@interstellar.eu>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Ihor Urazov <z0rc3r@gmail.com>
---
Hi Heikki,

on the Fury G1i RFC you asked for the actual UCSI version instead of a
guess. On this board the firmware itself reports 0x0100 once the first
command completes (read back from the mailbox), and the mailbox layout and
missing _DSM function 5 rule out 2.x. HP has been asked to report it from
boot, case 5166176673.
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 5697ccc24ec3..2421a92ecb0e 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -148,6 +148,34 @@ static const struct ucsi_operations ucsi_acer_ops = {
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
+	.write_message_out = ucsi_acpi_write_message_out,
+	.sync_control = ucsi_sync_control_common,
+	.async_control = ucsi_acpi_async_control
+};
+
 static int ucsi_gram_sync_control(struct ucsi *ucsi, u64 command, u32 *cci,
 				  void *val, size_t len, void *msg_out,
 				  size_t msg_out_size)
@@ -196,6 +224,13 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
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

---
base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
change-id: 20261026-ucsi-hp-zbook-8-g2i-4446ab6e5ed4

Best regards,
--  
Ihor Urazov <z0rc3r@gmail.com>


