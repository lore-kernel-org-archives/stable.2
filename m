Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DD139023D
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 20:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233735; cv=none; b=NtmaKONJ1wJoaP7dz/jzxhYxDoORdVqOa83fUI2ZNy2883EOOM8OQYP+44Fh8N6eRfnqSU7dhuDw2diSURKvoaSQne4yGRtloHHq3nfHDjg/aZB9IGJ7cLr8xu/8TJpMMxcP9i0mazh7yyjeSF4AkWGnjYL8c6XPC4JCq1pj+vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233735; c=relaxed/simple;
	bh=1BylJ1qcxt6ia7vBUGVelYlEsjG5H5UE4KL4utunPOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzRwz3yoVMSJ5VCD/PBmD3iNZfxdJpC9cgPGKAXuPoWQgH+FCBQfCafJg54mkmgZPdSvNzzg9OZsnXTeJuNh5ai+wJogsHNfkjYU+J6vkUCCh6vlxZr8CbHTEM2KOxdfhBDKi9hqt6VDeb+t4LxDQQV9lrTDwcGMNiCgoPgzTWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQ7oAHX8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HQ7oAHX8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612E01F00893;
	Mon,  5 Oct 2026 20:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791233733;
	bh=ktB6vqVmUO+C94z8neB5I0iBV1K9gYawJFw+uTIE4+s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HQ7oAHX8VBXy9OANOUiSrnnL6sAv3l1J8k3qqe2MZUxhkIfX1au5+PrIcS4ZCb5IH
	 LL/UGynwGuLNaZa4BnChwNfIXyIliO2+3mq0ECm5ekgaeRNDmzYd/mTD4+NPYZtryZ
	 Olki9tArjpF/3ts/RGDRHuZYMYb3LVfT+Kn2San6OxmNelcVne9aqHVwldjIe34Cc0
	 GGbenhOKxJt5wC/CK2zWWcg8bTjrSza9F6v31/ZgrtQ+5NLMaLE/xcns2j02KUhPo1
	 vJt5jqEg2jKA1UVdHVWRY5X8Qg2833/sF0pd8lQ/AUqzqPGIr/RzHR31uWspCTCWyu
	 6xUv1Z9LUbWUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pannarat Wiriyaarritham <pannarat.wiriyaarritham@danielcorp.dev>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] usb: typec: ucsi: acpi: Assume UCSI 1.2 on Acer Nitro ANV15-41
Date: Mon,  5 Oct 2026 16:55:29 -0400
Message-ID: <20261005205254.3275261-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100552-starlight-exclude-ad0b@gregkh>
References: <2026100552-starlight-exclude-ad0b@gregkh>
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
[ sashal: Adapted the dedicated read_version() callback to the generic read() interface with offset and length checks. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 32 ++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 03c820fe5b0c4..eeb457ff255e4 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -106,6 +106,31 @@ static const struct ucsi_operations ucsi_acpi_ops = {
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
+		*version = 0x0120;
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
@@ -173,6 +198,13 @@ static const struct ucsi_operations ucsi_dell_ops = {
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

