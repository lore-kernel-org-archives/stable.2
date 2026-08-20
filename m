Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62FC41A926
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224073; cv=none; b=MJw5y0BK88UTJyfclKN9qO4V4rmVde8Vf3tEedynZxt4SZt4AL5OCrvQC33JXnyck7duMfwQsGWXCesgEJ3Gx4M5U5lkGzb3Nn11KsMBy5iER3NvDsRe+uZAW7GYl8wun06Yj4VnxFIDz1hHvo5UI4IyBjApi4N3o+ZBXL4lXtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224073; c=relaxed/simple;
	bh=9r50CgwibwT1pDZKUZ/ETazxQPBeElsbAgtTJgOwlIE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QmLLavMXDqoizgCRL8nth4v0OafIKo1Am32z7R61voZfUERcDmCzeR8kgG15DssYDiJxhHM26DPk7T1wDsZEJdklO+A17Ezy6AlDUQ7A0IZjXuW3sgEBhOOdl516UYa7E077+Pf+T/mXr/D8U4M1Q25IXl0CkVDtAjJbVReqXx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XNS1CgsW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XNS1CgsW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA7A61F000E9;
	Thu, 20 Aug 2026 11:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787224060;
	bh=a1PcOT07EPWhz30N6VJEhyiBlrSxxtNgdApmCZMnM5Y=;
	h=Subject:To:Cc:From:Date;
	b=XNS1CgsWyKuQIG1n346GMXqEnrMUuS+c8ln/zxN1qT/YENugqsMzhLdbddM/BQzZa
	 efOQqHg9/jyaanpsL+uAOogcsy/ygBeaUpq7RbZqj5YtTVjc85YgNtWwjzHismGZbb
	 PcXDDEfLKXYJBbZJ6wzLbIu1VTFWMHRLlOmXd1CM=
Subject: FAILED: patch "[PATCH] Input: atkbd - skip deactivate for HONOR ZQC-P" failed to apply to 6.12-stable tree
To: DongLin_Lyu@outlook.com,adefka@gmail.com,dmitry.torokhov@gmail.com,donglin_lyu@outlook.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:07:22 +0200
Message-ID: <2026082022-version-salad-624e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 410c44b1096789d0c40fbee706520e981dba7bc1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082022-version-salad-624e@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 410c44b1096789d0c40fbee706520e981dba7bc1 Mon Sep 17 00:00:00 2001
From: Donglin Lyu <DongLin_Lyu@outlook.com>
Date: Sun, 2 Aug 2026 15:37:18 -0700
Subject: [PATCH] Input: atkbd - skip deactivate for HONOR ZQC-P

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

diff --git a/drivers/input/keyboard/atkbd.c b/drivers/input/keyboard/atkbd.c
index 6c897282d25f..4c82e988260e 100644
--- a/drivers/input/keyboard/atkbd.c
+++ b/drivers/input/keyboard/atkbd.c
@@ -1916,6 +1916,13 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "BCC-N"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
@@ -1923,6 +1930,14 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
+	{
+		/* HONOR MagicBook Pro 14 2026 */
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "ZQC-P"),
+		},
+		.callback = atkbd_deactivate_fixup,
+	},
 	{
 		/* Lenovo Yoga Air 14 (83QK) */
 		.matches = {
@@ -1931,13 +1946,6 @@ static const struct dmi_system_id atkbd_dmi_quirk_table[] __initconst = {
 		},
 		.callback = atkbd_deactivate_fixup,
 	},
-	{
-		.matches = {
-			DMI_MATCH(DMI_SYS_VENDOR, "HONOR"),
-			DMI_MATCH(DMI_PRODUCT_NAME, "BCC-N"),
-		},
-		.callback = atkbd_deactivate_fixup,
-	},
 	{
 		/* Xiaomi Book Pro 14 (TM2424) */
 		.matches = {

