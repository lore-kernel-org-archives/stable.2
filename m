Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793097305;
	b=LooPhtysJb5oqFrqJdv7ASCYUbhnlRVgjhp1DNhgFLstdlYcPREMa9RcGgtI3dHyRLLK
	 5hNmZ70zbIuFZSy0Nktkob+WtTBNybf1vfzAnF6uJY9Y4TlTzuYQpKoPXjRNseOPg5LZ/
	 qV3xM/uSgdIhdru6xiVMkx71oRLJSc3Q7Q0vB4o8uYgoWqW8nYvWnkig4hJ4UY5cJ8qzc
	 5L6ZVXoWtdtW3F8Bah07xTnGLUKAZnaNV5ZtlOLRbzyEQwmp1J02GdAmDkxw2XaookPC6
	 GDX/vg4ftx8R8qCBK5ZYJI8KIwlAtgvYh4/ENwx1EGIHUbW73JZaxzFeg0q8W/CxvyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793097305;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/hK/HeD74JlrBU8bMobw4ozyo8xVjYyuYPU+95BndyE=;
	b=2ommctLqp2W01jtp5fk9DxBuago4RsiPDvbhbfcGl2dbygmmhq9lg/Zqc+xb28/yP9Fu
	 WQngZgRBvPHKtgphe5rucxQJU872vpUHvBybo5eKf7m/0xDRWbzGnK5y7x8DT4bPPXY3N
	 jaae7oZy2p4wEFVrRTMCxmP9X2jeiAIYXZmIWA1LmKI1Ms8JxEqNqLKkXRlw1tJcFfCEb
	 GBkNXKNWNhUjy+BStsIYIpTuRpohvymCFL5/FQJE/yq1VCxxUCL42Gi+hVqWOuX5z6kSG
	 wlg2s90Dk67/Bc9LoX1DPXG6+S0UQlgsqz8O+AKDDMZ1Y+ZIRGdD4e3stTeQ4Mu4xWg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggWIhMEB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257DF606A31D;
	Tue, 27 Oct 2026 10:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ggWIhMEB
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793097304;
	b=fhOiJqaV6Cz2a2GJrCjSL34IzRwK0rGk+ElAr97Xcn8L0a32rX1XG18yGBEH9w35VBmS
	 lZQK+sgYKcW0EdMlmA8jgS1NNcy6AmsvpEcy7LUlOseSKy1s5zWZwvcOESGDhrtGEp4cB
	 aql3iY4iwdiX00OZ1hCgZp0Pyis30Dlc0lrYaxzeLAUYdAHE8hOlujldzaTDIYRYfnZTF
	 CmhdKAkpHuW8KKnw1jvWOnixCfV7qQH4L88aXcxenZNQbctU2p1g2Ay3HozRdoTYlwMDh
	 RsUKDBSzSyhnQb2po6C6Ula/GC0qCPj6ytz+NOG+ittNpBkz+odaOeW4m744/zM0l9A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793097304;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=/hK/HeD74JlrBU8bMobw4ozyo8xVjYyuYPU+95BndyE=;
	b=FT8zVN1zk1gFzDPH7xNdBfXdMMcc3tKxzRuQp00ob/I1fH8hquaK51EB9AW+Jnh9amff
	 VAemweTAO3akxQqIp1VxzYppbP0u9wc16JpxklxP8pOYjdv2gtJIANmaQQDqCrRHOlxpa
	 x/TST8TuKsKk6kW9paQ2g1j0z+zsUbqi2y0yPHFt+1H1/3qWBvwKTipIgahhB/Gd+cpt/
	 FEGCT5BF/wzHMLHoL2GzfnINjcGylL4iCVTtDX51+kvSVDFBcTzlWJ+hZdixeTm2UIkHa
	 +jwXUEzwt/Ldh4jHJBsRYQJFrfJFFPA4nRU+mYjEVcMIJHtDU4RW/815mTlXLj6oNJw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2ADFF1F01825;
	Tue, 27 Oct 2026 10:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793097304;
	bh=/hK/HeD74JlrBU8bMobw4ozyo8xVjYyuYPU+95BndyE=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=ggWIhMEBQsXgLuXLjyuujHHdv7z0IgSG2xHfWIc+L9behCPvLksuo4YXKnyXXy3aU
	 cf3diZskVr8U1g8ISfrbeOBzr/NCIPDWiv6tvg9oo8OQynbe8MQwSJR1sy+I7hJy1J
	 5Bs1EqpUF7YnzgUslU4mRt7Uo8lB/MSElzbdI21zaa906F/xCylXHSis+71JyNYo3x
	 uUzOdpZSQffJulk6jlWi5wyj1j0o8iT1AaDw2d/oHq5fPJujQi3rdPLRe8n5U66QRD
	 6CdfRfSihBzi5x+oj6BOgDsXxGANP6wD/pa/yzCrqtkkr+z6AurPmu5pzlEo1tR/Ky
	 mjvBsl0kUl8mA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AF0B045089;
	Tue, 27 Oct 2026 10:35:03 +0000 (UTC)
From: Ihor Urazov via B4 Relay <devnull+z0rc3r.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 12:35:00 +0200
Subject: [PATCH v2] usb: typec: ucsi: acpi: Assume UCSI 1.0 on HP ZBook 8
 G2i 14
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
Message-Id: <20261027-ucsi-hp-zbook-8-g2i-v2-1-02a600e4f0a4@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NwQ6CMBBEf4Xs2TVtrSie/A/DAcoCq0JJC41K+
 HcL3j3M4SUz82bw5Jg8XJIZHAX2bPsIapeAaYu+IeQqMiihUhmDk/GM7YCf0toHnrFRjFrrtCh
 TOlKlIS4HRzW/ttdb/mM/lXcy43q1Nlr2o3XvTRvk2vtvCBIlZlIIRRnV4nS4Nl3Bz72xHeTLs
 nwBQeBu+8gAAAA=
X-Change-ID: 20261026-ucsi-hp-zbook-8-g2i-4446ab6e5ed4
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Guenter Roeck <linux@roeck-us.net>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Francesco Orro <ncesco@interstellar.eu>, 
 Huang Wei <huangwei@kylinos.cn>, Ihor Urazov <z0rc3r@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4023; i=z0rc3r@gmail.com;
 h=from:subject:message-id;
 bh=NlPCvrvQhtgItzt9zsdsYFiRx4ZowVkUcnfZuo3biYA=;
 b=owGbwMvMwCWmab25vPXFu0bG02pJDFkP6sIKDLW3xMdYFExSvVCrEH9SYOrxPTm1Dpkc0bX+r
 9bqP/zSUcrCIMbFICumyNK/z4BXW8hUnOmLzRuYOaxMIEMYuDgFYCLPKhgZ5p7v37Wsanozl4il
 p+uM59orTF3WBQradSS/Plm52HYrM8Mf7kVvvj/Lj2WY1Tfn5QlHtvVLl2f67mE+bNkjK17WXf6
 MEwA=
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
Fixes: bdc62f2bae8f ("usb: typec: ucsi: Simplified registration and I/O API")
Cc: stable@vger.kernel.org
Cc: Francesco Orro <ncesco@interstellar.eu>
Assisted-by: Claude:claude-opus-5-5
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Huang Wei <huangwei@kylinos.cn>
Signed-off-by: Ihor Urazov <z0rc3r@gmail.com>
---
Changes in v2:
- Point Fixes: at bdc62f2bae8f, which added the zero-version check (Huang Wei)
- Add Reviewed-by tags
- Link to v1: https://patch.msgid.link/20261026-ucsi-hp-zbook-8-g2i-v1-1-91002e9ef073@gmail.com
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


