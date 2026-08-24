Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73ECA3AAF6D
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787585679; cv=none; b=iD+78D2Ht8EAAx/OEg4k56zcS+vsGieDLkvvk6DtH7heeWfQKJ2NYC/kgT27F4qZ62hiyL2rUj05V5AqdyymR1syfDsoS9y0x4X/AQT1h6aaAeqOvzfbK4Yohc8EuP2scV12bc+ZzVBuRcSmvUdwXmm/YUSm4hpvN5vwu7CzbV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787585679; c=relaxed/simple;
	bh=14cdQ41E0X3RV0xJQrkY3Hc7EJF6CPIGMEJNBqMCLcU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOIJbuRDMLUQu7OvqHxyA2TAZ3tRykwsX4YWn6s46qfRXaNIMNdQw24nLbOOaKJAhtttzU1tS9qaeIcThdM9r1zAH4/FaWjoxVcG4g5kruDKf8bVPACduG8VSCtt1yQ0jwPGS4EEwxzGnILbX1fSZdg5zvAXIJqK/MEyAA4y9gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BgrfE3eu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BgrfE3eu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5274C1F000E9;
	Mon, 24 Aug 2026 15:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787585678;
	bh=kAckhru0N00YrYQR637X5J2JlwSv3LLV/P185DoIggU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BgrfE3euEI6c2LX0tHFrq+8zUxpfQgkcVX7VSHqM5i+xaRtRMsPTkUNt5UVXN7SZ8
	 NKtuMH1M7//TgyDRI3iNlT0JkX2BDbhUFRqDbrMLDV8HvDpMqwHFYFrr1XUmiYpse+
	 7bAf5wckKrOXxMRolqJRhaQalZrqwMSTEt7jrU0EvIyTyfLux7lDK3McZ+O0kIHmpe
	 CeduzQ0uPS4bs6dClyqHDrnK/0V9rrahK9H0kaBT7Zc0M0m04+F19FMaaUp+pd0a4M
	 he7K1r1GmPZwhA0ZMWVW9JnFlet7uqmqhzMUeY95qJB6Dy/4GKDOWZScCyiVO0JjgT
	 ozxBqY+DzRn+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>,
	Mikura Kyouka <mikurakyouka@aosc.io>,
	"foad.elkhattabi" <foad.elkhattabi@gmail.com>,
	Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] Input: atkbd - skip deactivate for HONOR FMB-P's internal keyboard
Date: Mon, 24 Aug 2026 11:34:34 -0400
Message-ID: <20260824153435.3850535-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082022-arbitrate-hunchback-c487@gregkh>
References: <2026082022-arbitrate-hunchback-c487@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>

[ Upstream commit 2aaf33c6e1e82561d7dce2345298a985a2483266 ]

After commit 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd -
do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID"), HONOR
FMB-P, aka HONOR MagicBook Pro 14 2025's internal keyboard stops
working. Adding the atkbd_deactivate_fixup quirk fixes it.

DMI: HONOR FMB-P/FMB-P-PCB, BIOS 1.13 05/08/2025

Fixes: 9cf6e24c9fbf17e52de9fff07f12be7565ea6d61 ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
Reported-by: Mikura Kyouka <mikurakyouka@aosc.io>
Reported-by: foad.elkhattabi <foad.elkhattabi@gmail.com>
Signed-off-by: Cryolitia PukNgae <cryolitia.pukngae@linux.dev>
Reviewed-by: Hans de Goede <hansg@kernel.org>
Link: https://patch.msgid.link/20251022-honor-v1-1-ff894ed271a9@linux.dev
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Stable-dep-of: 410c44b10967 ("Input: atkbd - skip deactivate for HONOR ZQC-P")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/atkbd.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 94a7de558fcd6..c3cdb5933e94b 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1924,6 +1924,13 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FMB-P"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{
 		/* Lenovo Yoga Air 14 (83QK) */
 		.matches = {
-- 
2.53.0

