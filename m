Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CF1322533
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 14:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783260542; cv=none; b=SkuGFlFLsgq5w838vICxK6vcGCetWw6IyCGn732fAFeeEDqQ6fiLwrHQf1aO9xNTvVPc+joWJ0kKlNwK0BeBLE7Eq5aWPmeIdPhvg97IkDUIIZLKNG+djgjTWKHUvq0dUfcNIJ0GK4Vbmy9/VI37b7eiXl+CkzD0IRGMEj78CTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783260542; c=relaxed/simple;
	bh=YJ9rMJS83Otub89LJmGlk2kuDnhSRgS6EuMBFO1p6+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDuGevr+TEn+7+HkJ4bXIFMeLVrI+iWIcKQFEoWjO01JuoMVyNMLpcp+JEPRSkKO+oV6WLFrqu2bhgJwtozYEIUh0F/9Ua2rMzFVxBYjMMzuJTRYBAKfotu98a7LTS0KYNLtCuK8J6aJoshIWDV67aX5mdNyZ2I0+wdILUM/Gt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSsMBwV+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSsMBwV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFBE11F000E9;
	Sun,  5 Jul 2026 14:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783260541;
	bh=4Bn7Y5aHbrqyeO7mol6I1uSHiOaF1VZu6eHdxzoAUsA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LSsMBwV+OGRCLwBawiUnXH+Z5DuLMcj/PXfiKvx81XOV5MjXBuwDxSC/V96rZmojh
	 pO2itbpRRSNgE5O1tQ841jOUQajytpkLsCrd38TuZUvhyyVrM7enVWT/v16m9poX16
	 B2F7HFzwBV94H1Pf9j7Eqz7ba7O11qd4BBx2X6axN6mtD2VP/pYrgZe3TeaHcGRuqh
	 xOo68ebW2gXIS/Gh4+uPRsQY6uTd55q/D+pX+MH4Ra+oDlbhZ12kYczahOtbCrOSry
	 PmlaYi/W9+lzUTo+Bn/uYACpXd5iDDrI3Me4GbJ5bAfC1GLJzNd4v+JS93QWod99N3
	 YE7+k1E1HAN4g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] fbdev: fbcon: fix out-of-bounds read in err_out of fbcon_do_set_font()
Date: Sun,  5 Jul 2026 10:08:59 -0400
Message-ID: <20260705140859.1776330-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070230-congrats-plenty-c9d5@gregkh>
References: <2026070230-congrats-plenty-c9d5@gregkh>
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
index 7dce023c2fb34c..a3993925d8ef77 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2381,6 +2381,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int resize, ret, old_userfont, old_width, old_height, old_charcount;
 	u8 *old_data = vc->vc_font.data;
+	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
 
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
 	vc->vc_font.data = (void *)(p->fontdata = data);
@@ -2434,6 +2435,12 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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

