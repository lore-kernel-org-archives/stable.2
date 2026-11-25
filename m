Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608374;
	b=1flpEfzYkRaoXgxdy6sSPPPatqW5KMwmhc9Qiu4I4erjyIBDsVFMuIqu5rDtTjYHHgl6
	 1nY3D23yR0WPKgzvo7Btnk5Joka/zDzz63p8EYTxiNKo8W+gnI+N+5rzmypCdcYc4aBEu
	 UMNq+FZPK81Jxx/y0hoeia2YO4Tn+InB+7JsolzEFZGVS1h3769Y1WkoByFvyjNg3RnCU
	 i7B1CaRJGUIbQdHn5pmjv7XCwyowpavzgJwM85eYOLaLNh8gpLGTY6cpDiv7QTEUUcIWE
	 9rFpQ8XwC+O9KulCgff05UjssgRWf+Cz+s56pfOVv0xbdjs0wSmmuPERmCRXV43u22Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608374;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xcMQhF5Zko9nZOnhiRQEeLwOHgFTs/fB6rd+4awCjzU=;
	b=HEo4l/uGABTbDFyE3KJRtcDi0Y1aaGf1f7M4fDeHFNanvCS4dlMKJKKh06HJB50O6VA0
	 R2U3AUUxkQZ8vPowo34dhuvwFc42UCZmZmW5tZUL9FgKaYJGfLKhEwsf42gx6NZR8hcsZ
	 b3pXRPV+A/SD3QcOu/EUoiSkeInDkwtMRcCc2gW1v6rBlkEBbDd31ovT3VmRZDXWO7Kyu
	 NowIqpbGCnep8/VmVjr6gXq+tA3aHhpRsIS+4pv1iKlM4ZHSh+SYx5IcT30CxP5O0zHR7
	 OCJ8Lx9I+917+xgzV7KZmHh1AXez35KmZ5vpv30x/WiyDWatM/ntU1ciuKorzz2F9uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aJiDr4hq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A4D0606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=aJiDr4hq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362151F000C6;
	Wed, 25 Nov 2026 12:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608373;
	bh=xcMQhF5Zko9nZOnhiRQEeLwOHgFTs/fB6rd+4awCjzU=;
	h=Subject:To:Cc:From:Date;
	b=aJiDr4hq06J4+yaMR2jne1hZTVEU7Cc5QPMT9iEtypIup9TX9BCBL5WUCr6Tsn3L3
	 rs3ABDwSSUCYCbpCgQJFC64MtgNq6o55yK0PKtKkmbeo+Bd37T7atGimglGg3xrldY
	 8e1E1AUD2EU4gpc3+81YFsHvRNweqmf37kyax8ek=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: acpi: Assume UCSI 1.0 on HP ZBook 8 G2i 14" failed to apply to 6.12-stable tree
To: z0rc3r@gmail.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,huangwei@kylinos.cn,ncesco@interstellar.eu,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:34:34 +0100
Message-ID: <2026112534-occupancy-unifier-94c3@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 3ee1e1c3fca6fb5d0abbe0fc91539951ffa60aa7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112534-occupancy-unifier-94c3@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3ee1e1c3fca6fb5d0abbe0fc91539951ffa60aa7 Mon Sep 17 00:00:00 2001
From: Ihor Urazov <z0rc3r@gmail.com>
Date: Mon, 26 Oct 2026 01:47:52 +0200
Subject: [PATCH] usb: typec: ucsi: acpi: Assume UCSI 1.0 on HP ZBook 8 G2i 14

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

