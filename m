Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708053;
	b=V0CoKxjfADxqxgVxFf90VMppeW0mBJcKaPCyp6DZwd2U3GXPvDuTlkfz7agvSW05trCe
	 4AfIy5C/06Bp4/Rtl7c90/zujRFkeBp4L1cySzQt+i5Dkh7r2xfJADvsN4QQxuLT7UUxT
	 UWqcrNBgjSk66zNIMvZ/l9ySCOUhRK57gYDdZPd7hY0mt6DRLjUGLDp03/LHxQk7FquGa
	 8LO0mzn2WVmerESSg/WEFvngdUajdhXkDlsGesvUPOgfQekxx09UpHbx0ocUA8K3EhTqF
	 U95qf4olSThsv6gEO34e/BGYmig5bKiTo3qEWYBGKU/Jw3qn82Gl+qTeUtshf314nWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708053;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2AMUUxdkJsHTkug+ZK8gVu/LjRnkh7YWlgmUsTkFxv0=;
	b=dG6cSy+0Z8sKs5W7XkgZAqpzaWF4B3xO/fVAP7qkq7CqoXfjuMBNe4S0j/Q3vMViLoFa
	 kDLrvJSHkLi8MUm66hTacOmWmNvEpiraQI/zaT9mFUiQvjuG5oCv6OAMvu0z8PhWZSBlV
	 NsPbdBNPrE7BvnBshf6LSiDVYou/699MUESY/iiNa1N7WcP4h6aZiIejl28XZWiziad6o
	 jXgBPKHdK1D2FEnLGlBySMeLWhDU+3YxFhZLk8CXLQUy9B8TY7wQz6J/8SlQAibvUuQYp
	 m4AataEygvVWXrlia8q2enBF++LBu4PxfMgQ/RSC4yhY1u4yGOwT3SI/pVcgagMAz4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaQ06Wg+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567FA606A32A
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UaQ06Wg+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F29281F000CF;
	Thu, 26 Nov 2026 15:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795708052;
	bh=2AMUUxdkJsHTkug+ZK8gVu/LjRnkh7YWlgmUsTkFxv0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UaQ06Wg+W37cPKIemNMHlynLy7SvNtNmWQmgmeH6hx2iM8iX+M95ssPxayjHi7tBN
	 Opr86fEfK1qhbDzUMd8plLl8IBUSlliwLM8S1HFY7JJKjBvxzxcRUKnGdBVNjcn5QM
	 efdSQMUHxF1WjsbH2cHKEXj3xNOnPVK3MreXFKF+MbinGyQp5bsyKpqP+kt0r+1bip
	 Ly8BqrV3HTsfoEUAaRoTWXSjjABuADtePl21+RiY1sfS+SpPUC51ks9KPv47YfyYRI
	 nzbq8hvVsWplhB8aCqfnbb8XjantA18c4lswUnvRYHtU7lmMNxLxC3UkjKMJefvqng
	 94Vv+hESCRWvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ihor Urazov <z0rc3r@gmail.com>,
	stable <stable@kernel.org>,
	Francesco Orro <ncesco@interstellar.eu>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Huang Wei <huangwei@kylinos.cn>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: typec: ucsi: acpi: Assume UCSI 1.0 on HP ZBook 8 G2i 14
Date: Thu, 26 Nov 2026 10:47:30 -0500
Message-ID: <20261126154704.2499085-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112536-creamed-rimless-700c@gregkh>
References: <2026112536-creamed-rimless-700c@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ihor Urazov <z0rc3r@gmail.com>

[ Upstream commit 3ee1e1c3fca6fb5d0abbe0fc91539951ffa60aa7 ]

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
[ sashal: Adapted the HP quirk into the existing DMI quirk table, with a per-entry assumed version in driver_data and dmi_first_match(), instead of adding new ops functions. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/ucsi_acpi.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_acpi.c b/drivers/usb/typec/ucsi/ucsi_acpi.c
index 17567bd134d11..94f95afcb67dc 100644
--- a/drivers/usb/typec/ucsi/ucsi_acpi.c
+++ b/drivers/usb/typec/ucsi/ucsi_acpi.c
@@ -32,6 +32,14 @@ static const struct dmi_system_id ucsi_acpi_quirks[] = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "Nitro ANV15-41"),
 		},
+		.driver_data = (void *)0x0120,
+	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HP"),
+			DMI_MATCH(DMI_BOARD_NAME, "8ED9"),
+		},
+		.driver_data = (void *)0x0100,
 	},
 	{ }
 };
@@ -57,6 +65,7 @@ static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
 {
 	struct ucsi_acpi *ua = ucsi_get_drvdata(ucsi);
 	u16 *version = val;
+	const struct dmi_system_id *id;
 	int ret;
 
 	ret = ucsi_acpi_dsm(ua, UCSI_DSM_FUNC_READ);
@@ -66,9 +75,10 @@ static int ucsi_acpi_read(struct ucsi *ucsi, unsigned int offset,
 	memcpy(val, (const void __force *)(ua->base + offset), val_len);
 
 	if (offset == UCSI_VERSION && val_len == sizeof(*version) && !*version &&
-	    dmi_check_system(ucsi_acpi_quirks)) {
-		dev_warn(ua->dev, "UCSI version is zero, assuming 1.2\n");
-		*version = 0x0120;
+	    (id = dmi_first_match(ucsi_acpi_quirks))) {
+		*version = (unsigned long)id->driver_data;
+		dev_warn(ua->dev, "UCSI version is zero, assuming %u.%u\n",
+			 *version >> 8, (*version >> 4) & 0xf);
 	}
 
 	return 0;
-- 
2.53.0

