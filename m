Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050832;
	b=a3uhgzxN1SHhQpPKeBt1S4PXm393AVScPSWIT8Lzcv9jlU5xNQchp5ZcC3jaVRnxVUgy
	 7gbhwGJn1aSJQspVlp9zLT04tx8zlRmsLJerqRyAPp5pRQ6TE8rWZSyOm5bS+BXj0/W6r
	 jQjFCJhMQGFEh7qNSCnneffyPS9CaO+Mum1V+cMlpca9ndON6d+B339WEvm80PxsG0DF2
	 xCCi5aJPd+zZZHaNaXO9qf3nmvxJUTmdadB9m8WqSGKI3HilcsTbyVBk/6zlQImlYb+4Q
	 b+KjYmbZe3Yd4cmutp9xvtG++d4hTL1v9dQ6ES0Omjnq3vWJh/xWh3lHypt50BmQ1jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050832;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=HJLP/RVfAxEx8U8bLj91ms84Ik3PQMjkHBPjIEXOkBo=;
	b=H1sx6fq81EugLL1w4EXQRKmIqJNfn/3m7xbuyfuFY7jzj3XFNDyUNxMxN0PPM+7+2gDz
	 pNsmdXQZ2ZvWb3KVuW50slNoeilhfIuLC+WhJghERRCTuNgCRe37sXo7JrZfaJ6VKZ1eK
	 CQriJsLyvuWr88R1fo8IGRaXm+oXmsFxOk4sYOBYQuk5jqdsXBJuyw4IoDW5LfZ4ToMsj
	 j+Sy3Qwh7vQjnX5dCvAt6/Bo4ZvUqYgh6nllfirygxUjOpirQp4eKARDYVcdenGQ3JEZr
	 C5uTLjuzu/z0H3dawWCvhDpldHFP2EDAt9Fwg5WYU0Ji8WdINRZdFizRTZWHxLoqj/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJx4+rnj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CAF606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AJx4+rnj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C8C1F0089F;
	Sat,  7 Nov 2026 11:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050832;
	bh=HJLP/RVfAxEx8U8bLj91ms84Ik3PQMjkHBPjIEXOkBo=;
	h=From:To:Cc:Subject:Date;
	b=AJx4+rnjAkqRno+LyUhru1ELWQcasdTD0AxDt/n4l8Snpym/oqyPMNRzT++gnuhV7
	 4/wb3+TZArYHSL3/Z37zak9G7Vpjgx8dG+CimDRfnNJCO4EziHeJ3kpkENx0SKvPBb
	 PVbJEEypNprvjYSLGKtDAGaguJA56g3IGUBnZOwxMwBXSKvBHsFMmLcOu/deveYdD+
	 TEsiND+eoWkooZFIzKyYbpAwouBhn1yENluiE4hbJqlNeRHhjs/sPvVnRvTE3rMQqE
	 Q773h6bsUP1viVnwc4vMDC221w4ggFQO3uLKL4ZNc3m8UPCsO+onQ0zsiJr+aGA/uK
	 Me67qbY6LmqXw==
From: Sasha Levin <sashal@kernel.org>
To: catme0w@live.cn,
	tzimmermann@suse.de,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: bitblit: Fix glyph clipping when fbcon pans" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:27:10 -0500
Message-ID: <20261107062710-failed-5.10-06fccf840640@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 06fccf840640d8f6b0e08a1756f8d2f0435b4cbe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062710-failed-5.10-06fccf840640@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 06fccf840640d8f6b0e08a1756f8d2f0435b4cbe Mon Sep 17 00:00:00 2001
From: Tingjie Zhong <catme0w@live.cn>
Date: Tue, 20 Oct 2026 10:46:57 -0600
Subject: [PATCH] fbdev: bitblit: Fix glyph clipping when fbcon pans

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
---
 drivers/video/fbdev/core/bitblit.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/core/bitblit.c b/drivers/video/fbdev/core/bitblit.c
index 03b3b18e1fe92..590d12bbf30dd 100644
--- a/drivers/video/fbdev/core/bitblit.c
+++ b/drivers/video/fbdev/core/bitblit.c
@@ -18,6 +18,7 @@
 #include <linux/console.h>
 #include <asm/types.h>
 #include "fbcon.h"
+#include "fbcon_rotate.h"
 
 /*
  * Accelerated handlers.
@@ -150,7 +151,9 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
 		      const unsigned short *s, int count, int yy, int xx,
 		      int fg, int bg)
 {
+	struct fbcon_par *par = info->fbcon_par;
 	struct fb_image image;
+	u32 vyres = GETVYRES(par->p, info);
 	u32 width = DIV_ROUND_UP(vc->vc_font.width, 8);
 	u32 cellsize = width * vc->vc_font.height;
 	u32 maxcnt = info->pixmap.size/cellsize;
@@ -167,10 +170,10 @@ static void bit_putcs(struct vc_data *vc, struct fb_info *info,
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




