Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087072FDC20
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 20:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231421; cv=none; b=Pm8afalabehoFHqNTkCfkJ266mN+UgOiJN+hSc/yECwpJkU/tFU/GQegBiZKrRgBpIgbRQjRm30+PeSM6ue4mg0QuXwquqyNH4KN5Vy9XUypSuijA0cCXUc2gTvQc5UP9asVxyEWP1+C+Rlr0B1pxW7Q0KSTtVpaEHueUKy7H/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231421; c=relaxed/simple;
	bh=GBOS7wCfdINnpihQPBRBtsXHf8A/cu34Xbi9OMBvnzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lnFfBmXJQ/PmX7x7nYkUJjk1NWPmFPt/LO9NIWu3pPVc7YJOurvD718IUQw4t9MoouVt/6hQNPFsqR+BDLJ1tXElxmrJrEf10gT8IPW6doz5AuI15R8Y/AbCJM3byRwAzpa5ojhIulJnSiqOEU30bjjBEqg7qvM80xfJ7qNzkvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IS20J8B4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IS20J8B4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14DF1F00893;
	Mon,  5 Oct 2026 20:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791231419;
	bh=//vh8bzsWj/JtOw4RBtRBJGm8SUm7rTohX4JMQKEOwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IS20J8B4wt/xvAJCoPPrByuwEP17lJZJD4KvlzxgdHLpxbUBbGMPWBusck1hzTAbZ
	 WF5TG2Kh5AsVWMB6ag5YocereiPOT6DjggcvlUDF85TR/UkD2qAMN35l1cxFUaqaHT
	 zFpdWAuVu0MRqWeWTZFnBd+5wfK13EFc7gclweE530aepb2qQx3a2Zl7CoC6g6lg0U
	 gAAhMn4KM1hJqpPnIVp9doqOjOzOOmGar6XFDE+0Ded4v96veNxG1iWIhUssgjoUX/
	 +rZ8/HxDqEp3Pe1ppyFpvUG9Eir3prcL6JPYDrUQ8Z8WXWw7F/uhqbhuwXqkYM3uL9
	 UIz+hLGMBL+cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pannarat Wiriyaarritham <pannarat.wiriyaarritham@danielcorp.dev>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] usb: typec: ucsi: acpi: Assume UCSI 1.2 on Acer Nitro ANV15-41
Date: Mon,  5 Oct 2026 16:16:55 -0400
Message-ID: <20261005201508.3155216-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100552-arrival-nuzzle-44d7@gregkh>
References: <2026100552-arrival-nuzzle-44d7@gregkh>
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
[ sashal: Adapted .read_version to the generic .read callback with offset and length checks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 1054947497bb2..7a4969a086df2 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -107,6 +107,31 @@ static const struct ucsi_operations ucsi_acpi_ops = {
 	.async_write = ucsi_acpi_async_write
 };
 
+static int ucsi_acer_read(struct ucsi *ucsi, unsigned int offset,
+			  void *val, size_t val_len)
+{
+	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
+	u16 *version = val;
+	int ret;
+
+	ret = ucsi_acpi_read(ucsi, offset, val, val_len);
+	if (ret)
+		return ret;
+
+	if (offset == UCSI_VERSION && val_len == sizeof(*version) && !*version) {
+		dev_warn(ua->dev, "UCSI version is zero, assuming 1.2\n");
+		*version = UCSI_VERSION_1_2;
+	}
+
+	return 0;
+}
+
+static const struct ucsi_operations ucsi_acer_ops = {
+	.read = ucsi_acer_read,
+	.sync_write = ucsi_acpi_sync_write,
+	.async_write = ucsi_acpi_async_write
+};
+
 static int
 ucsi_zenbook_read(struct ucsi *ucsi, unsigned int offset, void *val, size_t val_len)
 {
@@ -174,6 +199,13 @@ static const struct ucsi_operations ucsi_dell_ops = {
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
 			DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
-- 
2.53.0

