Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F503624C8
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787584754; cv=none; b=q8uBihek+qM/HBpeld+O6GnxB8Lq9G8utgSSpFJkrsll+Us0AqkcmlYxPqZaoWcT06uYm3jaAOx9kp9yMg+ZK+cAEYq4CW1+ANbt0WxzQAsqEX/a02F9lrABGnOGjf46U9dbKjFvFVR8u7IfXAVtybgj/HLDiFR5lHxwviyhUdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787584754; c=relaxed/simple;
	bh=pQ0YzymW5C0hxNYVJXIBFVZniJG4b+0fB0C6tDnfaZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecFWuOI+70SKasnmabPls4+pQwMlI3X+OaeA/PoE/5KLXqkEdOY9Yz8KYsPqXJTdtmPBYLW9dZTCS451j+YhPb16vpD8qFIPpG4gti+qRmO/dGWLgVaXdhLtUPUbu8i503oFvgJamrPTbB94cX0GX/ZnWmn6xppoqfrUqcjNiGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvCT0SFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvCT0SFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4C201F00A3A;
	Mon, 24 Aug 2026 15:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787584753;
	bh=zED9KxdYzXYKo2HSgSz8hugHopPbkP8+kglUyqdsiOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QvCT0SFhX+l1E1VyAkNDG42WZegLGKiC/MK7iwJhgubMEVOkOAFpUffZ9+40lbK/O
	 8jOtF6eet6oKVFoBbTY1dUXh9lVaV+L6BOCNOi5gtriAKaaUd3h25w82E3BMv53EMO
	 4blHd7JRKqMhjoiGtqQgpKFM+/nOSygNlFQtP0pOZ+ypoj8n9WrPgh7mM65hIkpRpL
	 Z4xwZ5VYZrwqVLo+ELHnejfruvKAqvwLJXkGv8a13VD0RyzVDjQFWWoqlUEy/XtZwU
	 1Czig/15YYF/7MaEXzAwgTbMY5UpfPqUNxvznVuYZt8pB5S8VA8wTAx0kF45/0FT5c
	 sqTpDa2H02qNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Donglin Lyu <DongLin_Lyu@outlook.com>,
	Donglin Lyu <donglin_lyu@outlook.com>,
	Ruslan Shevchenko <adefka@gmail.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] Input: atkbd - skip deactivate for HONOR ZQC-P
Date: Mon, 24 Aug 2026 11:19:09 -0400
Message-ID: <20260824151909.3764555-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824151909.3764555-1-sashal@kernel.org>
References: <2026082022-overshoot-smother-3576@gregkh>
 <20260824151909.3764555-1-sashal@kernel.org>
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
index 6ca9910b852ab..665c09fe8410c 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1947,22 +1947,30 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
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

