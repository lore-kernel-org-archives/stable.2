Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047103;
	b=e2um7skszdlIA87eeTZ6/bJZC6WtDOseuivWcM4Ly5wSOLfseSd913UdR/G2ofUV4nXr
	 Y4VxIeHCzdjIm3oWe5E4tJPO7PPnf1VM2oVDiHe9YBRlTl7fbmFIvNZVDGSLyD15rD4Bi
	 8Vs6YpUdO/HbpaGhJG+idygPF8y6BBpjfnLxjpRHtRl9iIoL2F7HG5ChLLX90c0FbtWQi
	 CYziyLut+A3DGciOFrtwhPNVaW41yV8DVBhmZFCNsN3cRGlmN2G2FIz3WlHrarKjaNnTk
	 dqfEj1Puych1ob4+Yn7/xL1sBhpTaEXadYk31HKN5uaOcaHDfdemMQxFIUwkieUu6Jg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047103;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pVV+tMw4V5ZKuNneOXe03un5Omy/g39RsGIyN6GOpSM=;
	b=PLwyYEHN2HK2Vd+hVRbIt89i86056QkmbiJ7Y1SUV6FlLAzgoOUXja6I2J2fezzE4Qnu
	 N68S7TrpQGPLbCHOwdF0VMx5ChiKeulGiMf8izYVBTwzS4dHKTSqt3sxVvSp1T5QQy6CM
	 Lv/DjXiiQ2xGUWDSQcahfe1j0yo1jpZvw/mx3u215FFOTFT6ejIR+nLVnO/l1e+5Dis1z
	 aSQaQX2kWSY5KCuVcJc/5dqQ1a9rb+B71rL9DNFBGaI3mVJ4DmcBXQtc48IqfEhbKdXui
	 Vy7HtzzlsVpKfmqtaFDYRDK4bBQec4eJC4elyHHnFCbtQPTA++8d94QfWpuoaP6PZXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxWf7Hps;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EA2606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RxWf7Hps
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478B41F0089F;
	Sat,  7 Nov 2026 10:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047102;
	bh=pVV+tMw4V5ZKuNneOXe03un5Omy/g39RsGIyN6GOpSM=;
	h=From:To:Cc:Subject:Date;
	b=RxWf7HpsiTlhCpP3jTuoSXv0rukqURPjCfyfMjOnaFaYlW8UQx8cnBW0y84NHllFp
	 VAIqOhY6Npr81abQ4gnemB8DesM+7E9cEWIxRGbplt5emy7xtyzlPN2wjZXFkc1Pza
	 yyZu0ti0PMLZ8tQVojudV+OYlIbji7vV8QdiEwKgF1xZcPBHHgLn7v4oc3q3T4i52B
	 YtWhANxmfGLzmhIXuFJK3NdMoFKrryfNqYciWTVpuEc/hzSBngzpTtKiB6OtbY6CxF
	 jv5xc4+fCF7bnPR314mBpS9nE9AtTAMslYM85z1VC0M2jYQlz0x4kubBOtTxsSAvAo
	 bqJJTDwez0f6Q==
From: Sasha Levin <sashal@kernel.org>
To: yaoyiqi3@huawei.com,
	tzimmermann@suse.de,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbcon: Include font geometry in the rotated font cache" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:25:01 -0500
Message-ID: <20261107052501-failed-6.12-10463bcd4349@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 10463bcd43495fb88ff667b2c5348200860f6bdc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052501-failed-6.12-10463bcd4349@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




