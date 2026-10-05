Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD428392829
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791237300; cv=none; b=e9Na+d2ZhCooBZxOBwksCMEJHy6KHWpCJiARbH6Nx5bvD9tG0u20wIK5Ou3H4X7rml63HbNYW+rvoONGUMwu6bCHdfFtKAGSG2qCqCBR0MVRwI4lX/3nmHgS3iKsn/CseHkaks51RkWvAZ+hbVOv/1iyp0Qf076w/1vI3sl+5Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791237300; c=relaxed/simple;
	bh=1Irc4SbnKcbAisITGBL9oVe/3tm9nHxZhakQXzsOCEU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U7vdE0nWmG3om1nFm120O3kCLafR6QIuAcwIdHjUj//UJy+D4h7TzWxri46LoIgj3pG7K6W247Ro1V9HcJel/2+MFyim7j0cj7NiPluURzHPyCn9eO1rRKRcIenqJg5gknXFv0st7T6vvk5ySJVzTbB+PK1OX4RALtZYzw+Q9gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw6bi8pe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw6bi8pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82ECB1F000FF;
	Mon,  5 Oct 2026 21:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791237299;
	bh=IUeCqQtUxgS1euW35MSU3J4zgI6bdLRKBRf/HFHOjcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Iw6bi8pe1iYPFhBJAogPtcnTjfOFz29Aquu8Ulssmdt1ZXvhkzG4l36o4GieX/rm6
	 20H/ua6uAQVd/MCkum6kgeRuzSmhgjzmELqbSon3xoOL9xOBVcFeSZxwL3DzGSD9Xp
	 VN8y1fYJXIndgCkte2SQmRSqCiq+98WRZtS1js4uzOa3ehPBv87yUagp15lbeS50vw
	 MoORo/UdJj8TkBaz1c5f08tNElMXYpdjTYzmFTRLHFwO52G9iMtUvSsqUazH3buZ8B
	 AL9KJD+cQxIQZ0AlkUbb5wEEQ29+tWMgj5HaXWWmd7V4a0ux5AQTig9cI1IkTOiR62
	 smmu+qKzeYGXQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pannarat Wiriyaarritham <pannarat.wiriyaarritham@danielcorp.dev>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: typec: ucsi: acpi: Assume UCSI 1.2 on Acer Nitro ANV15-41
Date: Mon,  5 Oct 2026 17:54:54 -0400
Message-ID: <20261005215351.3398251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100554-catcall-scoreless-e7d8@gregkh>
References: <2026100554-catcall-scoreless-e7d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Pannarat Wiriyaarritham <pannarat.wiriyaarritham@danielcorp.dev>

[ Upstream commit 8c51ea651d043c786c37668c51624bd6b338a0ef ]

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
[ sashal: Replaced the dedicated read_version callback with a DMI-gated check in ucsi_acpi_read(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 0c88d5bf09cae..17567bd134d11 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -9,6 +9,7 @@
 #include <linux/platform_device.h>
 #include <linux/module.h>
 #include <linux/acpi.h>
+#include <linux/dmi.h>
 
 #include "ucsi.h"
 
@@ -25,6 +26,16 @@ struct ucsi_acpi {
 	guid_t guid;
 };
 
+static const struct dmi_system_id ucsi_acpi_quirks[] = {
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Nitro ANV15-41"),
+		},
+	},
+	{ }
+};
+
 static int ucsi_acpi_dsm(struct ucsi_acpi *ua, int func)
 {
 	union acpi_object *obj;
@@ -45,6 +56,7 @@ static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
 			  void *val, size_t val_len)
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	u16 *version = val;
 	int ret;
 
 	ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
@@ -53,6 +65,12 @@ static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
 
 	memcpy(val, (const void __force *)(ua->base + offset), val_len);
 
+	if (offset == UCSI_VERSION && val_len == sizeof(*version) && !*version &&
+	    dmi_check_system(ucsi_acpi_quirks)) {
+		dev_warn(ua->dev, "UCSI version is zero, assuming 1.2\n");
+		*version = 0x0120;
+	}
+
 	return 0;
 }
 
-- 
2.53.0

