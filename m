Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69438AC8C
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783178393; cv=none; b=gi6k79TdeBj+ceH86I9o3SMDoKPkyoSw/0mv0/bR4jqj3ogqgeeZXES86eFb6WBxs9Ay3OAE+m8TIwdLDKi9c6c7P3CgvskcE3BjZllAya3EdUE2S0W/VjduN8EkHEr1XfgIGZXU0Pauj+CjNa+gDzuo0G6hjqaawXwNiws/mEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783178393; c=relaxed/simple;
	bh=HgbWa1J+k6obfUhdJk2IKfMuwc//5O/JhSjj4yJUHA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KX5RMTBtBJ/R7jRB+5P9rZbCBP3u2Mqn/3EBK+tomoT7uNkzz/nIzuDB1uXb9F3ofFlssfT572Q9FRZTBsczufhDfSDFGfsq2fWt9jcfYg13rWO6E3si8VR50sOhrAgWBI6DyNMps30nupkx4+N0GLN7ZxaVEwznXqIfIo+t4v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HAVLc89u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HAVLc89u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D3C11F000E9;
	Sat,  4 Jul 2026 15:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783178386;
	bh=VqwbGFKC5wTG5EmsYqo2iB8WDnP3YJ6uJFFPe+hJeLU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HAVLc89uwOGl9o5OEpMmJ4GB17sK2bWLdrnwmML5WiVaWrGigKhTkq2bk1sEyMGIA
	 doHQOWMRiK5Q9ZhH7fjSfFmN/c7OigB//y1a4ihOkOs5CoW1t+ugaZdeNEaCs/iuBL
	 rf4Paf1PIDx12J96rYlPNuZq8lkc9myuAbgsrQM97FBAiwBx8K8SixoJoCCrIDmiZf
	 DznHAPaBi/aOQ8mDhznA21meu7oYpN0k0RgUO62kMxESCApMWdH7UqKElCHW6ALhjF
	 s6v2TVZ6FzfLAsHhU+0biXq2kiXcI8svQGIKE5sfjs/EYhpXaGB5usLQrz2mS5ATr6
	 tkSaa2YHfKxgw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] fbdev: fbcon: fix out-of-bounds read in err_out of fbcon_do_set_font()
Date: Sat,  4 Jul 2026 11:19:43 -0400
Message-ID: <20260704151943.1019054-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070229-deflate-unmindful-6a01@gregkh>
References: <2026070229-deflate-unmindful-6a01@gregkh>
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
index 8baad7ec1b8566..926905ad46a306 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2422,6 +2422,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int resize, ret, old_userfont, old_width, old_height, old_charcount;
 	u8 *old_data = vc->vc_font.data;
+	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
 
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
 	vc->vc_font.data = (void *)(p->fontdata = data);
@@ -2475,6 +2476,12 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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

