Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D6240EB8E
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224072; cv=none; b=MKppFMMKR0n21vR6/bzlnTng+vE37Sh4ere91812TI/+B3yI/1gnPqNGTFhieOTul0ID0EV5jNUb8pczddMRA4wfZASMkS8LpFRqjJZ4gOESqVQU+GOfz1WfpAktmTsbnF1Mh9Ai+AmbS0n/f4DvgN8OXQd98F69uVQW5MU26dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224072; c=relaxed/simple;
	bh=bwqQEw1Xshigy+ELtjPnKfTAl/uDQ1unLUjPOFLUaGY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CYglr3nyv3c0MEFnzXowkEy4Bff4Yxt5ykyJQAl4nzl3fJVJKtAWg0aqUl2vT0t1jZqKWWmJQvc6tXBVlNsmzdvQtcUjFfFpKMu64qhY+G/FjPDXzwFZdV/aUkBb0PQobLYFoyLq5nISYy0XlKtTOw3oGblKUPYleGfav28roug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1XqRAiLx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1XqRAiLx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 136EF1F00A3A;
	Thu, 20 Aug 2026 11:07:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787224065;
	bh=+OAQ5m34HhFIHXeMcGLe/d6Mu1pTJEMhStvOLS7Bmjo=;
	h=Subject:To:Cc:From:Date;
	b=1XqRAiLxi6jLRjiZdZiwf4Bpvq3NxMOZgfXSZ/cn3M9SuJ4cMV7HwWXnRgm4sIAZf
	 w6ENMYSze3agT3ZY9LoIYgAy+YNgaXh1QIGDppSgjm2TmblalIAEM1xO09vITkC4rk
	 ME9SNdlj11zbGuNdrGdYaLtKWAGrfY9URyI7zgD4=
Subject: FAILED: patch "[PATCH] Input: atkbd - skip deactivate for HONOR ZQC-P" failed to apply to 5.15-stable tree
To: DongLin_Lyu@outlook.com,adefka@gmail.com,dmitry.torokhov@gmail.com,donglin_lyu@outlook.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:07:23 +0200
Message-ID: <2026082023-staunch-apply-c4c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 410c44b1096789d0c40fbee706520e981dba7bc1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082023-staunch-apply-c4c5@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

