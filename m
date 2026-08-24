Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E72736196C
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583670; cv=none; b=pvCeYV7KAcSKaLsCAZCm7vL+gYcdmM9vrGB0+L91XQMv/W/rW5EziC8MYM/j7AU9/XxHaWJloFTi6FBt9noy1xWCPpx2++hliqlrx0FgIYd0A/BxG/54i4l9nVJX1VPOqhhhY30hEcIuBYPtqmEN2ZfWqG6UGvKkt6k5apjFRnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583670; c=relaxed/simple;
	bh=nwNd+kkdcvU+CA7EA1Ic8/ruhsTpw9upPEg/f5SX+m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aby/w21ejA/FZBFkQPqAi+iA9h6LMFG7Qp6gCdH2DCxRXcVGyapWozGD9zV09rXtD7YGKhPICklPcAJFHawJeNXhsXkXfEmB+cdY5WRox6VSmyqFtbLWFupvQrwpVRXkGJJF7cFb6SXn+B4OP1q57I7RlEQyOuEyoggGkvAhQxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFhKII6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFhKII6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07501F000E9;
	Mon, 24 Aug 2026 15:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787583668;
	bh=ZAStlzLn90HVAYawKL9TKaXiIG727eBR5DtbEvY1EHY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gFhKII6Yi468CvLKKzIiTH9cIL5C555MVhscWW5STd5/dKvVqYfybU3kDgTyLXSck
	 c28grToQpu2HKNCrO5zLyKzK/k0KgAKc44u/qAquSSMQPT9mBpOFMOwIT7BElFK4PZ
	 AHNrotly+yXF6KRyRsqHFDOumICNznGaCtS8WkbOboh7PpbdIL3lS4gcwqc0qDWE+n
	 66HK9GcCFdgiJq9P6YL7ZOjUr5BcPjg4XDg6/eLwh3LYy8gR607O+GIDKUhFxWrNK2
	 85WNIKMhsQFasCwym4UYRfwRfJwVSfE4L0L24njexN6P6JUpsva1aeWcMKE/KVxKK2
	 kwutTZUezAxSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donglin Lyu <DongLin_Lyu@outlook.com>,
	Donglin Lyu <donglin_lyu@outlook.com>,
	Ruslan Shevchenko <adefka@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] Input: atkbd - skip deactivate for HONOR ZQC-P
Date: Mon, 24 Aug 2026 11:01:05 -0400
Message-ID: <20260824150105.3723623-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824150105.3723623-1-sashal@kernel.org>
References: <2026082022-version-salad-624e@gregkh>
 <20260824150105.3723623-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Lyu <DongLin_Lyu@outlook.com>

[ Upstream commit 410c44b1096789d0c40fbee706520e981dba7bc1 ]

The internal keyboard on the HONOR ZQC-P (HONOR MagicBook Pro 14 2026)
does not work after boot.

Using the kernel command line 'i8042.dumbkbd=1' makes the keyboard
functional, but the CapsLock LED does not work. Adding the
'atkbd_deactivate_fixup' quirk fixes the keyboard and CapsLock LED
natively without requiring boot parameters.

DMI: HONOR ZQC-P/ZQC-P-PCB, BIOS 1.09 03/19/2026

Fixes: 9cf6e24c9fbf ("Input: atkbd - do not skip atkbd_deactivate() when skipping ATKBD_CMD_GETID")
Signed-off-by: Donglin Lyu <donglin_lyu@outlook.com>
Tested-by: Ruslan Shevchenko <adefka@gmail.com>
Link: https://patch.msgid.link/20260801151115.52709-1-donglin_lyu@outlook.com
Cc: stable@vger.kernel.org
[dtor: keep all HONOR entries together]
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/atkbd.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index f55f935c60c5f..8eea27722b6ef 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1940,22 +1940,30 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "FMB-P"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "BCC-N"),
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
 	{
-		/* Lenovo Yoga Air 14 (83QK) */
 		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "83QK"),
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "FMB-P"),
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
 	{
+		/* HONOR MagicBook Pro 14 2026 */
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "BCC-N"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZQC-P"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
+	{
+		/* Lenovo Yoga Air 14 (83QK) */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "83QK"),
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
-- 
2.53.0

