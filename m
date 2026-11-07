Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047872;
	b=hUCVBcABfLIw3s6G2EWo7zs+IcjVzxxvefC6duHncXHV+5Y9B77J6prr22/HdL8OjfT5
	 gqZG4qP+G+kmg0+bhW8/67FCNrI3IVSFZO3aMbsZCnYO7kHaTljA3+enYo5itxx5hIBpn
	 GG2HbU/6/PVAvzuyCddGD/WUr7rN36E6Z8LK3VXx2ilGvckgTq5kC8aHMPXDCC9WckB7b
	 y3MWQvcI8xjYNTP5jbFbKafpqfM9wqYMWv1jEIPmy8fcHD6Bxx2ptOd3lPK4vvsXwNFM+
	 VBVtHs+/KO+I1luoLbdEwbCVuYCTRUd0RYNLvDNQGmj1RG/aRi+1q3ZmC0zB+W8RYpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047872;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=N9bRgkr9V/k4/n9HR2GahC7PJ2tP2A8+eSjhlKiH+zg=;
	b=uY6uMDxMsNqP4MZu9dYzLHAB/ha53nUCker9D8SdaJTdJ0PR9fXSqracgdLqw2SJtYdh
	 nJPt0kfqMqig5iuL8lDBa69rbu4TYZLUOEAQEvVANnOgP7Qw+4W79fT8VZImxU2XyjOqO
	 2/S+cAWFTByvRQ7etCPFJgm8G1Y2aCbc5KKIiiWSX29DRPOu4gVFVY5TC+QzlaLzzTNNk
	 e3Mtm9XiLNUirbm72s9VvC3CGkrjZsseHyNHhrAI/0Dt5Qd6ur6/V31yopBgyJy8/98QM
	 WzrWivpvJiTCeXYMjT/rThCkThQmFW/nFeVDWaTiWAQJA2Q34QlBczJO5ZCnR3zQRoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nJzri2x1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52334606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nJzri2x1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87C71F0089F;
	Sat,  7 Nov 2026 10:37:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047872;
	bh=N9bRgkr9V/k4/n9HR2GahC7PJ2tP2A8+eSjhlKiH+zg=;
	h=From:To:Cc:Subject:Date;
	b=nJzri2x1sVtroaZ5xf3LNCWjA6Fx5sSI926mBuIKTXKbX+fkhYlP+VbCIifGjnBNC
	 vFM1xiSoDGSDyQ4u1JQdbYf6rYwaSRTlt31GZsH06ITKKG8kknT2BqM6U6LNYmGX8q
	 0vHyOIoVCZ6n64ycpWs9g+I0YMlB91404lJGVFYOpTwEaiQYjz9VzvkJtL3+666Jcb
	 S3ybeuLmAzO9t1dgK2UYCsP4FWP1tgOOiBzDfE2J1XGb31pF5E1+ClOWoZu04BtkL9
	 F4cywzoG4TeRZVkiHrp3YOR5Hk6KWgdRuX34wGHAOBvPK/vzRr4JZog5/oBDaVutDB
	 9VOkjq58lYhXg==
From: Sasha Levin <sashal@kernel.org>
To: yaoyiqi3@huawei.com,
	tzimmermann@suse.de,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbcon: Include font geometry in the rotated font cache" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:37:50 -0500
Message-ID: <20261107053750-failed-6.6-10463bcd4349@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 10463bcd43495fb88ff667b2c5348200860f6bdc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053750-failed-6.6-10463bcd4349@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 10463bcd43495fb88ff667b2c5348200860f6bdc Mon Sep 17 00:00:00 2001
From: Yao Yiqi <yaoyiqi3@huawei.com>
Date: Mon, 19 Oct 2026 17:43:29 +0800
Subject: [PATCH] fbcon: Include font geometry in the rotated font cache

fbcon_rotate_font() caches a rotated copy of the console font and
skips the rebuild when the fontdata pointer and the rotation match.
Raw font data carries no geometry, though: width, height and
charcount live in vc->vc_font. fbcon_set_font() deduplicates uploads
by byte equality, so the same bytes re-uploaded with different
dimensions keep the fontdata pointer while the geometry changes, and
the early-out skips the rebuild.

The rotated cell size depends on the geometry (rotation swaps width
and height), so the stale buffer is indexed with the new cell size.
Re-uploading a 4x16 font as 16x8 on a CW-rotated console, for
example, doubles the rotated cell size and reads past the end of the
old buffer.

Record the geometry the buffer was built from and compare it in the
early-out. The pointer-only key used to be backed by an explicit
width check in the deduplication, which commit 1e3c49aa03fb
("lib/fonts: Compare font data for equality with font_data_is_equal()")
dropped.

Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/core/fbcon.h        | 9 ++++++---
 drivers/video/fbdev/core/fbcon_rotate.c | 9 ++++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 054cf66b15fa0..91b59b2990d29 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -89,10 +89,13 @@ struct fbcon_par {
 	char  *cursor_data;
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
 	struct {
-		font_data_t *fontdata;  /* source font */
-		u8 *buf;                /* rotated glyphs */
+		font_data_t *fontdata;       /* source font */
+		u8 *buf;                     /* rotated glyphs */
 		size_t bufsize;
-		int buf_rotate;         /* rotation of buf */
+		int buf_rotate;              /* rotation of buf */
+		unsigned int buf_width;      /* geometry of source font */
+		unsigned int buf_height;
+		unsigned int buf_charcount;
 	} rotated;
 #endif
 	u8    *cursor_src;
diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 6cdbc96eeca6f..660a3fa81baed 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -21,11 +21,18 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	unsigned char *buf;
 	int ret;
 
-	if (par->p->fontdata == par->rotated.fontdata && par->rotate == par->rotated.buf_rotate)
+	if (par->p->fontdata == par->rotated.fontdata &&
+	    par->rotate == par->rotated.buf_rotate &&
+	    vc->vc_font.width == par->rotated.buf_width &&
+	    vc->vc_font.height == par->rotated.buf_height &&
+	    vc->vc_font.charcount == par->rotated.buf_charcount)
 		return 0;
 
 	par->rotated.fontdata = par->p->fontdata;
 	par->rotated.buf_rotate = par->rotate;
+	par->rotated.buf_width = vc->vc_font.width;
+	par->rotated.buf_height = vc->vc_font.height;
+	par->rotated.buf_charcount = vc->vc_font.charcount;
 
 	if (info->fbops->fb_sync)
 		info->fbops->fb_sync(info);
-- 
2.53.0




