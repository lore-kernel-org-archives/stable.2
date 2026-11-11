Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365112;
	b=mXOOzwq28LwIvPBj7XyuQ+fi/ldMs56ybPplmVchmJydYJMZOQbTeDKEZpVq0TPCVmzk
	 rt5SMCVuALHmXIK/dasFkL0t80kLqb7Lt2nnZnNQrJsqgISayp0PxYp/zmsyRRzpWJ+Uk
	 sfq+iShmN7dnWCh7de0jdcTdU2S2LtHubpXOTSotH99jJAMtfHnVzOaH6wSUiVU55lZCA
	 uu/BzqgNy+uDkBTX5P9sqELJHWmvttCC8Yva0SyWWK4MU2wXyaarmgW+kkYINnwZRur3J
	 GQWYsgPs34YLw+Mx+Ub93BvRirgrbRqE11hcpQBzx9N3svEH2zf91L9yq+5Zq3UkqWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365112;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZWlQpXLkj2+adiJGp1kItIrdpue1+jabIP6zhf8buts=;
	b=gZWBflkj/oyEt1N61cUq+aS9FFLv14zWigotC+Mo8++7u84Q72+GTZMcFmjJ0BAL8HYJ
	 bY5g53Ujp456B/Tut8hYfARVyBigiFQIhzu7LcViyiStVb/CTTq3VPTqMbnqIpGTLgS8x
	 PU+rXfKj89md3pDsXAnoltV2mpE4SJALKyyxSufsKEu+0FcANPy3HAcACTqIm+MKxebxK
	 WtuTtyl8QLISAun5rz7m5/fucbaIp9u6iB81VcAWeTKeofPepLErJsiiT3bAEVJG5nBCS
	 WNsnN+8Z4+dUawarIgUk/WzfXldRIiGTuq6vvt0uRELIMConlIV3J7SmetQRybqEyVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0Cft8lo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57EF606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W0Cft8lo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0AC1F0089F;
	Wed, 11 Nov 2026 02:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365112;
	bh=ZWlQpXLkj2+adiJGp1kItIrdpue1+jabIP6zhf8buts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W0Cft8loHcj5s7YjZLdCgp6vWZoEWrTRuqB9JR0dtERDazoltLjIxcqngZaXyYhLN
	 ydqIhV57GllXoB5S+e4b/Y5ErSawv9N59WA9H8CZ5dE7LcGR0tAcCJwU1ZWx62PCjk
	 9kBOq/vijVMJmvVGPQT79XUpe71PwyA/KqQrquvJXnToya9m7CseKsP7o1EV7M0+6z
	 aOU3ROItbJyMt67fT/RJCmiQ/mNKAW7+6RsqajAVmu0cEjJYr707EYiJ8Vr/3Ud2Rb
	 dYyGrWr8Y0up2xWx1s1NKrgZ6KfGsNPmludhhPZG/qt+ZwwE6j9Yc9a89mQ5+Ec23W
	 cbAHpxbyCIDhA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tingjie Zhong <catme0w@live.cn>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Helge Deller <deller@gmx.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fbdev: bitblit: Fix glyph clipping when fbcon pans
Date: Tue, 10 Nov 2026 21:45:10 -0500
Message-ID: <20261111024445.737333-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062710-failed-5.10-06fccf840640@kernel.org>
References: <20261107062710-failed-5.10-06fccf840640@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tingjie Zhong <catme0w@live.cn>

[ Upstream commit 06fccf840640d8f6b0e08a1756f8d2f0435b4cbe ]

Commit 3637d34b35b2 ("fbdev: Add bounds checking in bit_putcs to fix
vmalloc-out-of-bounds") made bit_putcs() clip glyphs to var.yres. When
fbcon scrolls by panning, it draws text rows up to var.yres_virtual,
so after the first pan most new text is not drawn until the next full
redraw. This affects fbdev drivers that set FBINFO_HWACCEL_YPAN or
FBINFO_HWACCEL_YWRAP, such as vesafb with the ypan option, when
CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION=y.

Clip to GETVYRES() instead, which fbcon_ud.c and fbcon_ccw.c already
use as the drawing area height. When fbcon does not pan, GETVYRES()
returns var.yres, keeping the existing bound. When fbcon pans, it
returns var.yres_virtual, which the framebuffer memory must cover
anyway for panning to work.

Fixes: 3637d34b35b2 ("fbdev: Add bounds checking in bit_putcs to fix vmalloc-out-of-bounds")
Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
Closes: https://lore.kernel.org/linux-fbdev/b8b52ffd-ecec-4fba-b432-ba32135c2f99@suse.de/
Tested-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: stable@vger.kernel.org
Signed-off-by: Tingjie Zhong <catme0w@live.cn>
Signed-off-by: Helge Deller <deller@gmx.de>
[ sashal: Changed struct fbcon_par to the older struct fbcon_ops type. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/video/fbdev/core/bitblit.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index c36f92965e0de..fbc05fbbd82a2 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -18,6 +18,7 @@
 #include <linux/console.h>
 #include <asm/types.h>
 #include "fbcon.h"
+#include "fbcon_rotate.h"
 
 /*
  * Accelerated handlers.
@@ -151,7 +152,9 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 		      const unsigned short *s, int count, int yy, int xx,
 		      int fg, int bg)
 {
+	struct fbcon_ops *par = info->fbcon_par;
 	struct fb_image image;
+	u32 vyres = GETVYRES(par->p, info);
 	u32 width = DIV_ROUND_UP(vc->vc_font.width, 8);
 	u32 cellsize = width * vc->vc_font.height;
 	u32 maxcnt = info->pixmap.size/cellsize;
@@ -168,10 +171,10 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 	image.height = vc->vc_font.height;
 	image.depth = 1;
 
-	if (image.dy >= info->var.yres)
+	if (image.dy >= vyres)
 		return;
 
-	image.height = min(image.height, info->var.yres - image.dy);
+	image.height = min(image.height, vyres - image.dy);
 
 	if (attribute) {
 		buf = kmalloc(cellsize, GFP_ATOMIC);
-- 
2.53.0

