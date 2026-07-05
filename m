Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A9137FF71
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 14:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260059; cv=none; b=hZ8w8mAtpob5QWLPhe0p3xu7hFijlgmQ/jmKjFclYsB7HfYl3ZbK644dBuPpYIewnRxE7MetZYggrpM/DZL02T1qLoCn0BD1IbifwBDbf1B/06aHjl3k5gv6eNuqllZAxGfaFsA/LEmATWy+PzhvLhnFudsUc4/b84EVhtXiADY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260059; c=relaxed/simple;
	bh=A/zMK3GIRqtmjqhN1YBDJKFNTO1FCWMfWMMiwSE0pH4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e3YojrUo5jkmyfpCFXpBUrEwGT2DC17nCHBR9EnogcYGRd9KXgWMmSfIbFh912bo5xtvDx5AHc6DAeN6jPX0iLx8ZuYZ1sWdFQf2vNgQ0iZTpYv34Cllh1NMkaWWWjw48opB+0iSRl2Z2sPJBx+BafcpwQjO+OXBiQ8/59iQQEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1kNjJBa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1kNjJBa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB371F00A3D;
	Sun,  5 Jul 2026 14:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260057;
	bh=AF71D8Quu048x3csOv74CmMGr4qcAK5RE/A/gtxqOJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U1kNjJBaYeM9aNVnLPYSy457MQG2uW3w6tZq19iNDVOB2SRHn/poAsMbCJzg5rNP7
	 Dx1TqV6fzeO2hPJA1TYJ3ZPwQJOoaaZwqmrMRHzwUQ4tuXK3FkE2BxH40nkH9avQBA
	 v6FwzqR577yNQ4H/QJWaQ2g07qkxPbaBHb6zOMJU49nD6KJKeGAiTgKRCrmIDYmbI6
	 UmiCFeZpr8lPdE3WMSzWaj9+afqq62ChqvIc2HqDgYnabJRYsDL2gI9CFaG5p5NHi1
	 1zGPvKwpbvfNX29aUyQ7OWtpZXU5ngzIeYoUyfjlFtG4/li8e+0J4qiS8hE65wPyGs
	 ZZHCXLjD/GZqw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] fbdev: fbcon: fix out-of-bounds read in err_out of fbcon_do_set_font()
Date: Sun,  5 Jul 2026 10:00:55 -0400
Message-ID: <20260705140055.1744629-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070230-shaping-renewably-c158@gregkh>
References: <2026070230-shaping-renewably-c158@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

[ Upstream commit 8fdc8c2057eea08d40ce2c8eed41ff9e451c65c2 ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/fbcon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 015baff0192908..00c2841c23068f 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2415,6 +2415,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int resize, ret, old_userfont, old_width, old_height, old_charcount;
 	u8 *old_data = vc->vc_font.data;
+	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
 
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
 	vc->vc_font.data = (void *)(p->fontdata = data);
@@ -2468,6 +2469,12 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	vc->vc_font.height = old_height;
 	vc->vc_font.charcount = old_charcount;
 
+	/* Restore the hi_font state and screen buffer */
+	if (old_hi_font_mask && !vc->vc_hi_font_mask)
+		set_vc_hi_font(vc, true);
+	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
+		set_vc_hi_font(vc, false);
+
 	return ret;
 }
 
-- 
2.53.0

