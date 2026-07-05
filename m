Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7492253EE
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 03:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783221104; cv=none; b=gWz/xvkWHlrr1pWhDNLvNs1vGsGbfSilgUd/WbOD7iGdaO4zzmnUF2sr2bp86287NeoxF4ktgUEUeNgH94OlVokRkczFuU7HuZXz/VM14WykZTXspMwbzgMhYSPMb3PDhbQ4zxhEXLbNNwlc75oi4mta29y3gR74VaRO74mr5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783221104; c=relaxed/simple;
	bh=Xo5qX4Hi4EnBxQIPWeZ5u0PmDcanCy7LUT8EmylenzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OSelCgdELTcBmiF2raKV7fotBtI6sTxus5I4jRDWeVQFgEixdWkvsZ1OnSNX70N33p9ng/DoGl3LqcOG9PIVOliEYLTISNwNdILAAQpzAmhtN3SHq878eTY+z60qWJ5z9BJORIyZsv1JM9V759a1lDGcb0ALnmGrJeYVVWFDSjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwx1ROb/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwx1ROb/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6F01F000E9;
	Sun,  5 Jul 2026 03:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783221102;
	bh=aI+m7jXe8j3ULi1w4uQmcF8g3sU7EJUN9zYCoUjF2+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cwx1ROb/JbmUBFOYi1Ytb+IyUvwuHIsjxIn698eutYHuBLqfaSDUM/dX+erRvB8nz
	 /tkoR3LU0DCZhf2jzUJmYygeNTlvsXYaDLJxz31T9DXH+50nvMefbAZFieMugZB3jY
	 9M0k4jrOg3eXxA0o7mkCZY4xvJBaulX2MnBYRjBoau5pBSTFFmtZ5LQ1THVzglin5H
	 4xlOAs+6NlkdC5dBd8usWDhLBHe88HR5+UAG99vTqSWlx7xLB6wRNSt9LSdpK9Ki3c
	 1az1cyok7A9KIszvujjzZ34TM4vgu4ObAEvb3MrcKYvp+d+f88010gYERolbdEMW5G
	 fgWJwSfuIOHug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] fbdev: fbcon: fix out-of-bounds read in err_out of fbcon_do_set_font()
Date: Sat,  4 Jul 2026 23:11:39 -0400
Message-ID: <20260705031139.1600541-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070229-impound-unpicked-bec0@gregkh>
References: <2026070229-impound-unpicked-bec0@gregkh>
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
index abe9e0ad9b43bb..d6ed7ae6546222 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2427,6 +2427,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int resize, ret, old_userfont, old_width, old_height, old_charcount;
 	u8 *old_data = vc->vc_font.data;
+	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
 
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
 	vc->vc_font.data = (void *)(p->fontdata = data);
@@ -2480,6 +2481,12 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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

