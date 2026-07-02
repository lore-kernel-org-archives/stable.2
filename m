Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D584A2E01
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000358; cv=none; b=iHgmS6dZk0h45EzcOPnkx5+1qePb0zHHVISy3aKmKxM4OmHhCJBL/p0JRc6owddGGUizTHHkjMeqP+WsDJ+yqDTseOlSZ29xhT6WpnzTcDg4hOVzCfu+p4L4vEpySznP8xhVKS0j/X9wXa5ZwQ94zg6CE1u/0H400NZ/HVBg5ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000358; c=relaxed/simple;
	bh=FMUwW5VjdwcBextb3Y9yjB9p/8Q6oCYfm1I2zcu/6R4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=GYOUQsZUZ57gFaexNsn8zGZBNhg7LzMjq4BRHKzfpaKzdNkq8uCMTlwkez4/190v4XxlqLwZ2E15paF6VNgDxLiOrllze/B7FQTR6yk/0KYWZoOFoGIWX7GRFcK+FCU7HmrMdRkrlOZO1YXEZrZ/RtbDm+NVCKOkg9HU8kfQbUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kwNH6nW/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kwNH6nW/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A45771F00A3F;
	Thu,  2 Jul 2026 13:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783000357;
	bh=ILGFZWpiySzyMX7CQq5o6NpRD6hdCfa+cfwUSfl3/qo=;
	h=Subject:To:Cc:From:Date;
	b=kwNH6nW/w3WTLkeV6UM4hu63Nh3othOE5MbCXyrKimkQNQkBEZPYOcgg3h1DLInHY
	 LOKJLOTq69oo8Tq+MA3P5yBSOovEUYzwXGO7vt92cbDKZitp6cOZcqq9sFePkdguK4
	 sNUiyCMlkh2ccLCQWCIlxZcZtIBkHFnVNOAxmMQc=
Subject: FAILED: patch "[PATCH] fbdev: fbcon: fix out-of-bounds read in err_out of" failed to apply to 5.10-stable tree
To: 25181214217@stu.xidian.edu.cn,deller@gmx.de,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:52:31 +0200
Message-ID: <2026070231-lash-wick-98ec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8fdc8c2057eea08d40ce2c8eed41ff9e451c65c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070231-lash-wick-98ec@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8fdc8c2057eea08d40ce2c8eed41ff9e451c65c2 Mon Sep 17 00:00:00 2001
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Date: Fri, 26 Jun 2026 00:03:06 +0800
Subject: [PATCH] fbdev: fbcon: fix out-of-bounds read in err_out of
 fbcon_do_set_font()

When fbcon_do_set_font() fails (e.g., due to a memory allocation failure
inside vc_resize() under heavy memory pressure), it jumps to the `err_out`
label to roll back the console state. However, the current rollback logic
forgets to restore the `hi_font` state, leading to a severe state machine
corruption.

Earlier in the function, `set_vc_hi_font()` might be called to change
`vc->vc_hi_font_mask` and mutate the screen buffer. If `vc_resize()`
subsequently fails, the `err_out` path restores `vc_font.charcount`
but entirely skips rolling back the `vc_hi_font_mask` and the screen
buffer.

This mismatch leaves the terminal in a desynchronized state. Because
`vc_hi_font_mask` remains set, the VT subsystem will still accept
character indices greater than 255 from userspace and write them to the
screen buffer. Subsequent rendering calls (e.g., `fbcon_putcs()`) will
then use these inflated indices to access the reverted, 256-character
font array, leading to a deterministic out-of-bounds read and potential
kernel memory disclosure.

Fix this by adding the missing rollback logic for the `hi_font` mask
and screen buffer in the error path.

Fixes: a5a923038d70 ("fbdev: fbcon: Properly revert changes when vc_resize() failed")
Cc: stable@vger.kernel.org
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9077d3b99357..37beb93045af 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2405,6 +2405,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	int resize, ret, old_width, old_height, old_charcount;
 	font_data_t *old_fontdata = p->fontdata;
 	const u8 *old_data = vc->vc_font.data;
+	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
 
 	font_data_get(data);
 
@@ -2451,6 +2452,12 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	vc->vc_font.height = old_height;
 	vc->vc_font.charcount = old_charcount;
 
+	/* Restore the hi_font state and screen buffer */
+	if (old_hi_font_mask && !vc->vc_hi_font_mask)
+		set_vc_hi_font(vc, true);
+	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
+		set_vc_hi_font(vc, false);
+
 	font_data_put(data);
 
 	return ret;

