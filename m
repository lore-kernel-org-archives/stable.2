Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08C33793AA
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783259286; cv=none; b=jPDWrJlyZf+LnMs8tDqbrwnNGlNdjmZDGSfzRSLpX8SyhyATxeRGGdea6w+cRVtFHTSWFepQ4bRakez+Nw6uS2dAL/LQ15wLTFZoXXN0wZRgc7qlH6BZRCQ2LQRpC4BFvIj0j1se7R/r9AaqeFOiON89Hn+oiChSXVC5ErKC80s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783259286; c=relaxed/simple;
	bh=Kd34TJg+x6ai0CKYv+574DED0njug/7Roe3azyTiav4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bo+a4ZJ5lYfSvoQFtUg7HVS0fBb9H1APzgFDmqXDPVfYtzoWcTT9d1giuPMgI1QOkO/xNR+Cj8Zifb6gJfpdEst5uU/OFo96ksyY4UD4W0ClgLFvUr3AMXgxxa+1DP54Uww3NdXbEqAzT4V2nWOprap+YdpcFPxSLO90E/zjEw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCzox0P8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCzox0P8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385EF1F00A3A;
	Sun,  5 Jul 2026 13:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783259284;
	bh=cs8HLkI+yCJ5Id9PhD8I3qGcRWnqSVYn1WKA2Ps1Db4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lCzox0P8+Hmx+Zq9hI1j3iImdSU4JYNLnvFBjSeZ08LrW7mmtEzf7cAktvXXQDww2
	 76nDvhiGRjHU6X8FQVCeGInLE0nwyHkjbN9tGQC1fESPB569uOfRtqVI9x2DBSzYpp
	 GNvtsi0Mnbyc7y+9GpDH5QJo+93TrnlnMgPD4ZP1VT4GSCcvJuTrx54772l2th1rqE
	 tlS8WklXYxZf4pxsROr0yMU5FtE/TnyoYelY79907rdobWPMHOEK1p57i8AGJQtfAw
	 E9Vd2aMnkT/ZpdHz5A1QkY2wBgmQ+jIP2s05ZdHxnf1Vm/chW+hwft9Tgp/tlWWzo6
	 8gu1PcL+4WwPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] fbdev: fbcon: fix out-of-bounds read in err_out of fbcon_do_set_font()
Date: Sun,  5 Jul 2026 09:48:02 -0400
Message-ID: <20260705134802.1722907-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070230-citrus-unboxed-57bc@gregkh>
References: <2026070230-citrus-unboxed-57bc@gregkh>
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
index d1ac4e45eea68e..a12d699dcb83b2 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2418,6 +2418,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	struct fbcon_display *p = &fb_display[vc->vc_num];
 	int resize, ret, old_userfont, old_width, old_height, old_charcount;
 	u8 *old_data = vc->vc_font.data;
+	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
 
 	resize = (w != vc->vc_font.width) || (h != vc->vc_font.height);
 	vc->vc_font.data = (void *)(p->fontdata = data);
@@ -2471,6 +2472,12 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
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

