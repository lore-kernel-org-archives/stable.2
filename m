Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793482827;
	b=NmIUUi9RSi5tdo3BWDBo5ppQwzZCp3vS2bO12S8l+BARZeWEDvaFkj7ZbeqZaIIuwTLm
	 RB6riA2SYZJpcNX1Auw6VCBv3XxLGe+2qGqjNzNzif/RmXXDgodBNvR+Qs2TElPexH4Rc
	 OkinumLF2vZYhZdsNfPB5P96OhOi9XX/HC1RkhMlbzO9a/v0ckihDoEscJplKnZrLFvI2
	 jHqil56AUQZ9WVJ4hhEfaXMsOU/vfKAN3+BV7QwPXHSghIMCUT0ZBiWpJd58S06YlGdjI
	 GSWwMnO0Gl8aqDcXDQhysgwKMJVUJCfChLrhN++CfZqu5j8BC9TQje9PG1EV7/0KImw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793482827;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bED6UeHGo0n+Fue3XhZb+EygmdR0ZJTzWFCCOjQLUHI=;
	b=TnP6tE5bK/l56sA/64Z8goxoZMMA0E6P4msp7u+XKGtTIoDD8PQrr+aJNw/OEQiGcw3S
	 59bUYcINn3xDosdCF2cwgCgjQ5F20ee6YY31enYBjMjijnNHaToLN1jtpxWT9dqNL2pfR
	 O+N7j35YnqlticvsQEOnwOcuL63lj41k56hQXRZYQbf8/FeK2gr4/7fadZOBic5TVsclv
	 6HEY6Rh0unGWo98HDrp9eeNs1d2bkimdyoBdnoGCLbRigqzoea8SofUIxl7HOjHLy3HU6
	 qwdIcRUt3zag7w9s1qDgRYrxjNbjpYYYlivY8epdNh7l7tF+ZJ1O2EhgSYEmxPTLPjg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HOc3ftma;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDCF606A31A;
	Sat, 31 Oct 2026 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HOc3ftma
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793482827;
	b=ob7NZqI+GTz/hFX25Lo3U3DJNGFuB2mm/xWQNZyk7s0LAkEHHiZ3wLCOuSsfEv+UN5vS
	 rW0n8qs9Df/NL/FPDdQyJ/KDafp2TgD2wiELJk0/BD1KH9rnjsKPhBsFxVIGWsDww5U9a
	 aEbKcZ/IZPt0qZjATPBc2/jtt94QifqTmFpfkJ8KasI5MJbsbuUrOpzqHsvvHgSJ1VHD9
	 +D2suq6h+ajr1bHp3MBMWPwH03O6XcSw9yX8j16D/rupjVsUyC9+LSMggPMdGHIy/MJtC
	 uAMmESvtZ1OiaeLQwp4aoMgTWxLAGW0QAoA5TWqJXsI54WbVFEwLZUNpJ4MhvT1ifjg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793482827;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bED6UeHGo0n+Fue3XhZb+EygmdR0ZJTzWFCCOjQLUHI=;
	b=3izxiB/XrpmuvcPctm8jdhs5Sn/HZdSJNcMswrUuLy0Ubjqko5BvMidMnVwmoqQPECiZ
	 guZ5y1QckeDlflB95qZ8wF2CaiHLZfhUUzZBqrhbnkXTp1dtEGwkCdfq+e3LMalEa3CXe
	 NaTDNjBian5F2JPzubf3kp6Ja7K3LAPkTLPExi5ERBqfHGW7uX3BdNlKzPMVy/fwfTwLo
	 +9HtsHehjj1vfMrCIMvMKxMLBcw0RFCFwq7Xpy6gUtHQYnryPzmIoy2rxW3uFic2hsuEJ
	 tioccaVS8/Z5blHm+R6h/nylump9rCIfqQLWWI3RM6BgeuWPh3zd7fCXeOL1Zluz/cw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 83B9E1F000C1;
	Sat, 31 Oct 2026 21:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793482827;
	bh=bED6UeHGo0n+Fue3XhZb+EygmdR0ZJTzWFCCOjQLUHI=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=HOc3ftmafAvvALaDUBUROCDuIyEvqWxRMmzJUonIbA1SXH4WBT7zJ9QilCpgtDhBQ
	 dtDNeaQb6StQXjins1Oo4Jec3wjt4w6QeVIpUsnJxLbQe45cosvse7cYxUv8qg8ywY
	 A6TqLsZ9E6INdBgUGCy3cu1gQb08IMCLCtRfGZdFxXpqtbabGquB9PFeWJfPaFNesi
	 QdLr2aKYR3G+YADfxuzlkXRZ8p7r/qZ2g/8piXZH41pqRzEvWM40TvSY1iqOUX6Qvu
	 ruuJmwKqFZ5tVkZsIY7YAaoPHP6XhJFKcmEuh1109haIjBXiyON3QEPFDgXPBUOwI2
	 T7KERol6aTqUw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 00F2C45FDC;
	Sat, 31 Oct 2026 21:40:25 +0000 (UTC)
From: =?utf-8?q?Stanis=C5=82aw_Titenko_via_B4_Relay?= <devnull+kernel.resetko.pl@kernel.org>
Date: Sat, 31 Oct 2026 22:40:15 +0100
Subject: [PATCH] usb: typec: ucsi: acpi: Assume UCSI 1.0 on Lenovo ThinkPad
 T14 Gen 2a
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
Message-Id: <20261031-ucsi-lenovo-t14g2a-v1-1-183751e63c02@resetko.pl>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrDtgomjtVYqLNJnoFElKRkUQ7
 96oy7f4fwehxCTwKnZItLJwDBnqUYAdTRgI2WWDLnWjykrhYoVxohDXiLOqB23QOEOt86313RN
 y+Evkebum7/62LJ8v2fk8wXH8AVRi7SV2AAAA
X-Change-ID: 20261031-ucsi-lenovo-t14g2a-adae7df7cf98
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mark Pearson <mpearson-lenovo@squebb.ca>, Daniel Dev <daniel.dev@noex.uk>, 
 stable@vger.kernel.org, 
 =?utf-8?q?Stanis=C5=82aw_Titenko?= <kernel@resetko.pl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793482825; l=3304;
 i=kernel@resetko.pl; s=20261031; h=from:subject:message-id;
 bh=p95Jlz0L7Maeo6S23F9A5uV32hXuG2XEilhjG+4iteE=;
 b=CJVzqOB2QyLwtfq1dMaLkgblbKND58j8M5qXBZC2kN1CjY990raZUSbjvlijsEqgUuCOnCkak
 lRFLLh29W+JBI+/OT6O76jtSQQVnqYmwV39EtBUqnCLNxt1CBq1zxQq
X-Developer-Key: i=kernel@resetko.pl; a=ed25519;
 pk=xMhqzbyPNWfeOgdmzSHsSlr5qjH779F5SD6BBHXixlY=
X-Endpoint-Received: by B4 Relay for kernel@resetko.pl/20261031 with
 auth_id=1372
X-Original-From: =?utf-8?q?Stanis=C5=82aw_Titenko?= <kernel@resetko.pl>
Reply-To: kernel@resetko.pl
Content-Transfer-Encoding: 8bit

From: Stanisław Titenko <kernel@resetko.pl>

The Lenovo ThinkPad T14 Gen 2a exposes a functional UCSI ACPI PPM but
the firmware leaves the VERSION field of the UCSI mailbox at zero.

ucsi_register() rejects a zero version with -ENODEV, leaving the
system without registered USB Type-C connectors. Without an OPM, the
embedded controller does not complete DisplayPort Alternate Mode setup
when a USB-C dock or monitor that supplies power is connected after
boot, so the display stays dark while USB and charging work.

The mailbox uses the 48-byte UCSI 1.x layout, and the PPM works
correctly when UCSI 1.0 is assumed.

Add a DMI-specific UCSI operation for the ThinkPad T14 Gen 2a that
substitutes UCSI 1.0 only when firmware reports a zero version.
Preserve any valid non-zero firmware version.

Tested on a ThinkPad T14 Gen 2a with BIOS 1.33 (R1MET63W): both
Type-C connectors register, and plugging and replugging a USB-C
monitor with an integrated hub and power delivery brings up
DisplayPort Alternate Mode each time.

Reported-by: Daniel Dev <daniel.dev@noex.uk>
Closes: https://lore.kernel.org/linux-usb/b1Wn_eFvTFShGbd970WWl4CWhge_6P2x7Wb6rab3QHNlE4OJ4p__O-QN3B6I-308ftr5oV5Zr7vywA0vdvmtNw6E0YJnVM2ek_5DcFnkXB0=@noex.uk/
Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
Cc: stable@vger.kernel.org
Assisted-by: pi:claude-opus-5-5
Signed-off-by: Stanisław Titenko <kernel@resetko.pl>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 5697ccc24ec3..33747e24353f 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -148,6 +148,33 @@ static const struct ucsi_operations ucsi_acer_ops = {
 	.async_control = ucsi_acpi_async_control
 };
 
+static int ucsi_lenovo_read_version(struct ucsi *ucsi, u16 *version)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	int ret;
+
+	ret = ucsi_acpi_read_version(ucsi, version);
+	if (ret)
+		return ret;
+
+	if (!*version) {
+		dev_warn(ua->dev, "UCSI version is zero, assuming 1.0\n");
+		*version = UCSI_VERSION_1_0;
+	}
+
+	return 0;
+}
+
+static const struct ucsi_operations ucsi_lenovo_ops = {
+	.read_version = ucsi_lenovo_read_version,
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
@@ -196,6 +223,13 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
 		},
 		.driver_data = (void *)&ucsi_acer_ops,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_VERSION, "ThinkPad T14 Gen 2a"),
+		},
+		.driver_data = (void *)&ucsi_lenovo_ops,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),

---
base-commit: e9954f3fbddd25e1a01b7e5a0b72fb8b564204e0
change-id: 20261031-ucsi-lenovo-t14g2a-adae7df7cf98

Best regards,
--  
Stanisław Titenko <kernel@resetko.pl>


