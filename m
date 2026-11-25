Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608383;
	b=cILhWXxET9Uw3fR4rapUGnMb1To4b4mdCyp/XY2RBw+XbMTuNC3iRfi6jLFckKxeP1Qh
	 O0uHZZbB2VPAjubwpwemSndg8pzLI+q2L4d8YDbg45vh6OeHGq74yQIqBK6yD/dUklg33
	 d1Uhw+iOBCsL1mxwj2wDSSuaw4pn8L0n9Na8fKehJ9Vj9EJix6WpQwZIlFCS6gHYOb02+
	 UcUhqBkvSfP0K8Evjlt+3zu8q4gzgggFmEucamb1dvRNmT14NVSDmxnyyLqbiiGgVv2CM
	 GgD/4UAU8qfCG6h99oEjT/bAWbJvly3WdtMtyZlLLGw2edhHyMnwxYYzgfYYvqcdyQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608383;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A1btudlzYkOiMfoUp1v6Oc/KtSZilvvXmEMTv6Ml1T4=;
	b=PWALkb1JoeDOwyOQcXsp6FmijXnHiTF35X1iqRRMNvW7Jzn8/tNdkJlJ4OelIsjNnW9H
	 u25V5cy8f1zp3mQc9driSW/MBEh/AaX8AXiWUUVUYz8cKIz3IjBlSzIwmm+A3kjXD4DI6
	 KRTIzUn72AkvIeih//LdUe6Q6719BgihjO9Q0X+dHyRxRJs7Ij7q0+yvL1lAlHIsQEhnp
	 suKqHAIkWj8QpISkJJ1/QosBXr/WY2zUSrVk/72AdVNIwH97lQMrxcGAAKQH1baCEnY3H
	 nXxYuJU9zvJfCzO05xBmHVcRWMNiKDe/OA2JEhrNDcrC8o0J7w6ursaBMsWVwC8tqyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="k+/vx5t1";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF735606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=k+/vx5t1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63C71F000C0;
	Wed, 25 Nov 2026 12:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608383;
	bh=A1btudlzYkOiMfoUp1v6Oc/KtSZilvvXmEMTv6Ml1T4=;
	h=Subject:To:Cc:From:Date;
	b=k+/vx5t1V4ZmkCdSmQjfJbsgudpvYbyaf6XrfT6QQ8idH7ffYZLaqndkfES+eIZcS
	 1bkMA8ZhTkosUnyKmEdUFt/8UeePXcnJCn/tO5Y0YFk1NcQS/k3LxVZanSYbdtSBlC
	 Rs0sIi+i8McQTL8d31XBOyf3V0dDmDCDi0ZLklM4=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: acpi: Assume UCSI 1.0 on HP ZBook 8 G2i 14" failed to apply to 5.15-stable tree
To: z0rc3r@gmail.com,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,huangwei@kylinos.cn,ncesco@interstellar.eu,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:34:36 +0100
Message-ID: <2026112536-creamed-rimless-700c@gregkh>
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


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 3ee1e1c3fca6fb5d0abbe0fc91539951ffa60aa7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112536-creamed-rimless-700c@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

