Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF7A401492
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190602; cv=none; b=d+XBs9BCSoGSU/L+yOZACbJHrqs85lMef8jSj6gUbLHPT73wer6CtCPelhYLIisulXlzFNN7GA2V/ub6vHNOPLIoJ+h+GZXJMSM1yYU+SM1Sx7v6+kIoHYNQpuqzWRodT86tieIyJvlLXRqobIRPbbyz0xlXyRcai5WKejqx5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190602; c=relaxed/simple;
	bh=TbVxnB97M6Hbl3AmmLoraAhrlrQiBF4SiBtrvvUezjk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=S/ri1QuPDsm4+YDEAbcH7A0YiiZtO8oiK6nJo0aIfwVLIcgeEpLlAWLJtIW6DLpx/wf4xP9Dd6AETKB4XWDqAiKvIctdT2OkwUUuzjm+UvEBBdTTPfgOFC9bh+ovtSvhFlyddPCnP697PdUhDIHPAAKKVP2tyY+zlKesWleACiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FOXK3NN6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FOXK3NN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 267371F000FF;
	Mon,  5 Oct 2026 08:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791190600;
	bh=bBqUFnzQ7Nk99ZNl4lLEavcGhJ5r9oDgrV73nnMc19w=;
	h=Subject:To:Cc:From:Date;
	b=FOXK3NN6G+abpgRT/ecdqsejwxf1Y6JbamGf4KWlHqkg5viQvD/dTB8tz5Y7/uKxb
	 UU6LCy1jlqWlthDkRv8La8ehqhJkswMVNL4/UKvybg9/KJuSu0a9cUKrOacYLhMcjA
	 JRMPB/B4/Fg8TJc4Y7bSszrr+OT/q7oCFfilEpto=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: acpi: Assume UCSI 1.2 on Acer Nitro" failed to apply to 6.18-stable tree
To: pannarat.wiriyaarritham@danielcorp.dev,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:56:37 +0200
Message-ID: <2026100537-fang-cold-8093@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8c51ea651d043c786c37668c51624bd6b338a0ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100537-fang-cold-8093@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8c51ea651d043c786c37668c51624bd6b338a0ef Mon Sep 17 00:00:00 2001
From: Pannarat Wiriyaarritham <pannarat.wiriyaarritham@danielcorp.dev>
Date: Thu, 10 Sep 2026 09:33:37 +0700
Subject: [PATCH] usb: typec: ucsi: acpi: Assume UCSI 1.2 on Acer Nitro
 ANV15-41

The Acer Nitro ANV15-41 exposes a functional UCSI ACPI PPM but
reports a UCSI VERSION value of zero.

ucsi_register() rejects a zero version with -ENODEV, leaving the
system without registered USB Type-C connectors.

The PPM works correctly when using the UCSI 1.2 layout. With UCSI
1.2 assumed, both Type-C connectors register correctly and USB Power
Delivery negotiation works.

Add a DMI-specific UCSI operation for the Acer Nitro ANV15-41 that
substitutes UCSI 1.2 only when firmware reports a zero version.
Preserve any valid non-zero firmware version.

Tested on an Acer Nitro ANV15-41 with BIOS V1.51.

Fixes: c1b0bc2dabfa ("usb: typec: Add support for UCSI interface")
Cc: stable <stable@kernel.org>
Assisted-by: LLM
Signed-off-by: Pannarat Wiriyaarritham <pannarat.wiriyaarritham@danielcorp.dev>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://patch.msgid.link/20260910023338.31816-1-pannarat.wiriyaarritham@danielcorp.dev
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 18286d3e9cc5..5697ccc24ec3 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -121,6 +121,33 @@ static const struct ucsi_operations ucsi_acpi_ops = {
 	.async_control = ucsi_acpi_async_control
 };
 
+static int ucsi_acer_read_version(struct ucsi *ucsi, u16 *version)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	int ret;
+
+	ret = ucsi_acpi_read_version(ucsi, version);
+	if (ret)
+		return ret;
+
+	if (!*version) {
+		dev_warn(ua->dev, "UCSI version is zero, assuming 1.2\n");
+		*version = UCSI_VERSION_1_2;
+	}
+
+	return 0;
+}
+
+static const struct ucsi_operations ucsi_acer_ops = {
+	.read_version = ucsi_acer_read_version,
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
@@ -162,6 +189,13 @@ static const struct ucsi_operations ucsi_gram_ops = {
 };
 
 static const struct dmi_system_id ucsi_acpi_quirks[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Nitro ANV15-41"),
+		},
+		.driver_data = (void *)&ucsi_acer_ops,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "LG Electronics"),

