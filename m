Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736A13EDE57
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235226; cv=none; b=t01GkUK8xzD8T4FYTvtbzuIMn5VoAi8jjTDvlNCby1aQECBO/nawjplRLPtbjkOp+G+xJxlYkV+L+6eqFAh04v0wIDwa3u69U34FvOYBwDqwzIWgO5gvk45M23HL+005uD5PWphHXUlFPXt/xzayjo1ySbSS9cJtI/whb0kj8Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235226; c=relaxed/simple;
	bh=VjxrAlnRRU7GOLHmJeBnhkJHwdTiS0T921YR0E015Bw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHGKzUL22LJuC3qHQQqr0w6YxkWaSVTdEiEPvspAN91BZmwnxnOcEFhFxZdl6x8r9GRqolAbna6xACm1+gJHSCTs3MxnNb/jljGdH1Wdl9V7YAh5TjE6EYjUPCWEZddkJJMQ+tMo/SQAuHyhxHcq6f/g2c9hFsEo7tq2ixR88Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aeml2n5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aeml2n5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8726B1F00893;
	Mon,  5 Oct 2026 21:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791235223;
	bh=DST2koj8dRH8b8A1UooBDMtrB2Kxt8i6wSBRDBkMdXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Aeml2n5xINAdQ1eiF9B5gV1JDgQ7u95lT7GVcf2RrnnjfeFanWr/dDKuovX8N/dTH
	 wn/VZN8kVOjotyQ8p6Hzh0CAec7P7ese2+nFha9mhwoxSK5XCkXeCt2ejMUb3yFDEq
	 1j6VRWboZep2wCsmJ6I7hepp9qEMQyPkY0zy94Wbifh7P5zcRzkyU/1n37Du0HZ3xN
	 u9dPivTQcoxbYICZlhbsQk/UZW0uo8R349JZxhnwrXD1u+2yPi4e29V8tjZnyTWfG0
	 Wd8y31WWvMYyOS32e5fLjdhxKifdc5fL8rXPnBHBn8fsC+g80QgXP8277hUo35F/1G
	 Tt8pb615kQzUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Pannarat Wiriyaarritham <pannarat.wiriyaarritham@danielcorp.dev>,
	stable <stable@kernel.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: typec: ucsi: acpi: Assume UCSI 1.2 on Acer Nitro ANV15-41
Date: Mon,  5 Oct 2026 17:20:18 -0400
Message-ID: <20261005211853.3352114-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100553-eloquent-shallot-2e9e@gregkh>
References: <2026100553-eloquent-shallot-2e9e@gregkh>
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
[ sashal: Moved the read_version callback logic into ucsi_acpi_read() because the dedicated callback is unavailable. ]
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

