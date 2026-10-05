Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C653C40A95F
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190088; cv=none; b=p3bymdQE048H8bN85+ODxbleEn9QI0EP50zg+QwZzEL/xuE4EHRT2VdWWSqE6nWtV4pMXkj12Co1B+TF1TTbGz86Q688tvwXylGz+qesa3+je1ExQeaPK+nzAQUV4Wm2Z5kUedWAvKNQIcD8QarG7VYKrqo7yg4m+15GmKe4Wfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190088; c=relaxed/simple;
	bh=vzlgjCcXyMLyGJWy/8RuVMxJEN+51u78wkozWJyu6Kw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=blPHU4uUaJaBiF+1TZVn6E3MR4GtjuNAWIfy7QVB299WIgA5amOSr6xBRozpV76DzpiheJo7wnr2dh2ID7KOY7/gsN199x7FbcBmXQXoiMoUviCiwBiujiH2qj1v9IjqA5neWOL9NVMhN+9Cm9nPzqQRptUQ7saR56IutAtDxu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eRqeV/5X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eRqeV/5X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6D0B1F000FF;
	Mon,  5 Oct 2026 08:48:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791190086;
	bh=NAkD4UJl1HtuQJKhk9YBQTxH9wMe7ByiLI4u3z4OaPk=;
	h=Subject:To:Cc:From:Date;
	b=eRqeV/5XrDHwpQPfawPz7F+UbuqMmXPJqRBZpHG8S5JdTU4mMdQT/ROtdEW9cemea
	 wUhzAqWhZexz5d4Bo1AVR1sFe+JEp6Ma4dFv+FQ7HmkppnKiHXcn01V1yf+ywJaQId
	 vmXFf2YC+cOtrHkgVZfxOCokMEQaf/vgLnZClmiA=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: acpi: Assume UCSI 1.2 on Acer Nitro" failed to apply to 6.6-stable tree
To: pannarat.wiriyaarritham@danielcorp.dev,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:47:52 +0200
Message-ID: <2026100552-arrival-nuzzle-44d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 8c51ea651d043c786c37668c51624bd6b338a0ef
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100552-arrival-nuzzle-44d7@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

