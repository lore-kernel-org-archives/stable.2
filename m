Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16DD360EDC
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783000340; cv=none; b=q88jGzNMC0Embj1r+Zj21ccqF1wB3uyZYlFmeED7oOiK2D2i8p/75bjGuv/ob+H8GIUrlV1dxG/90xBznVKyQ6QQG2Es6zQEbHAlcDP6KFWKgWnh5/JJB1em68zCgl7b3hVC5F5bQp/gAIXYiK/fyNUZX1RYgt5/wdd+WWluwmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783000340; c=relaxed/simple;
	bh=rAqQM6wEppmoYa+2gHkVTCL77cQ8mQYrTNmtCu/6eFI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UuEnFdw55LVZNfThP3VvfW6gDl/DtMYlCkGdjr6SXDN/uH/7MTbg5I5PPJrRDrE0ZuIq+a7JHgLRJ/oUCyHNBjUs0neIEJ/K8h1fC4P7kg0T2ZU03wtYWEixA2PyirGmP0OTBue/COvpA3aCOJsAixLM32/rsH2OD51lHs2eZzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XjFcajFp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XjFcajFp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13E1D1F00A3A;
	Thu,  2 Jul 2026 13:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783000338;
	bh=WfGyoAtn8H2BX+HZbQUkvluMLZOGndNOBD6za4JdDcI=;
	h=Subject:To:Cc:From:Date;
	b=XjFcajFphtgJul5HKK08KwCHYKw1FY5h3EN8MXTAd1pZNWyOHMQDwHQPCmwmUVVDE
	 qSVj5v+HDaHc34qZvkCe50fG5xk97oq5/xlVkUEeEstuiCPFkQVSkuNi7/FxmC+P6T
	 JlNKSxqhRAUrKFg+Tc5xyTScrb8oEx7c1DOW4BKM=
Subject: FAILED: patch "[PATCH] fbdev: fbcon: fix out-of-bounds read in err_out of" failed to apply to 6.18-stable tree
To: 25181214217@stu.xidian.edu.cn,deller@gmx.de,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:52:29 +0200
Message-ID: <2026070229-deflate-unmindful-6a01@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8fdc8c2057eea08d40ce2c8eed41ff9e451c65c2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070229-deflate-unmindful-6a01@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

