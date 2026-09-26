Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C29045D180;
	Sat, 26 Sep 2026 13:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790428660; cv=none; b=gwg0aLalNmuI7jt5BVMNDpETXjwWserGQwwEsOVDFDxACNzcLe5bsniJktQZYSBuQizRawHabrfbmeUIL5BkpKHpBzWz2ZOuESMXltQ6OyWaAC/Vxr7rtD2Cnv7odKHw3jFOrP4wHjpl26z7qy1RKhRIcfofswBwNEHp0GvGG34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790428660; c=relaxed/simple;
	bh=dMncSx2UyYLi2dqedF+v1BK1FWHzRgo/LCaroSYg0tc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lQu0+u9kQ7ymG9raxahwM9KfaGovMls0faS8AOga1FUSwfQZSY1dKzkjNhbJFrof98Qiyyr+vq8Dq9+2DjJAya3I0fMwPBxckUal2/NNYt9TyBNFkRDPwbukrDXv0PVBpgbBAlFd5IgFizGlyO5nf9PESQBPw5OcAFWH7GYwlw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAqq27kk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAqq27kk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523FE1F008BC;
	Sat, 26 Sep 2026 13:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790428659;
	bh=+XrNL16ZCg2GVmApUxxrwAUI6/bTuhIIbKwqFaiiCBs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YAqq27kksXDUuc5wh1SjhduSlDqU8MGIy1c6OXOdPIfjkQ7LaI/Bt+sEgclzO60xb
	 5xWLizQxgtMVsZ8xiQzogJ51sEik7BylX0bQi7Mql1SSSCv3fB7yVRbI+sQleasR6U
	 jYGT8HicdvYrST8eFGjaUYT5l/0C2QKaTBXx3Pcxz1fwQt1/bLNTj/E5o/30Y61H97
	 llR/4vpzGH733BqPiOnbieZedVlTM3GUBNWVVWiBhndobrx+gIhBT40pSV8n2rQAWk
	 uRFa14mc5W+ZPozPibQHGf90KbR7OqvZ6yEkm6s9olW0wD3UllttRAay1nyxhsgLZC
	 gVz5eYzmgA1WQ==
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 26 Sep 2026 14:17:04 +0100
Subject: [PATCH 6/6] fbdev: sh_mobile_lcdc: check for fb_deferred_io_init()
 error
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260926-fix-fbdefio-error-handling-v1-6-a94810b6e263@kernel.org>
References: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>
In-Reply-To: <20260926-fix-fbdefio-error-handling-v1-0-a94810b6e263@kernel.org>
To: Helge Deller <deller@gmx.de>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, 
 =?utf-8?q?Bruno_Pr=C3=A9mont?= <bonbons@linux-vserver.org>, 
 Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>, 
 Bernie Thompson <bernie@plugable.com>, Greg Kroah-Hartman <gregkh@suse.de>, 
 Steve Glendinning <steve.glendinning@shawell.net>, 
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 Steve Glendinning <steve.glendinning@smsc.com>, 
 "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1566; i=ljs@kernel.org;
 h=from:subject:message-id; bh=dMncSx2UyYLi2dqedF+v1BK1FWHzRgo/LCaroSYg0tc=;
 b=owGbwMvMwCV2fu7ZrsZH9SKMp9WSGLK2H73KEn/g933Vea0zd8uU13Sbhb0Xd1pskP0pmqM44
 +f1UGXujlIWBjEuBlkxRZbnX8T3B4mEzeu84O8GM4eVCWQIAxenAEyE25uR4WuJzjGueXH6rO9c
 rt42ua3H+PeC3/vQ4IXFGbmmV/5rnGVkeCYx2SyqMvp756PXugXGn/dXX1/rqSm89LfTeWlXlXe
 fuQE=
X-Developer-Key: i=ljs@kernel.org; a=openpgp;
 fpr=E7F417BF5214569E89D04F46CF9DCD8A81E27F14

fb_deferred_io_init() allocates deferred I/O state, populating
info->fbdefio_state, or leaving it NULL if an error occurs.

Currently sh_mobile_lcdc_start() ignores its return value.

Therefore if an error arises in fb_deferred_io_init() (for instance, due
to an allocation failure) info->fbdefio_state is left NULL.

When the file is subsequently opened, fb_open() will dereference a NULL
pointer (calling fb_deferred_io_open()).

Fix this by checking for the error.

Also clear info->fbdefio in that case, so that sh_mobile_lcdc_stop() does
not attempt to clean up deferred I/O state that was never initialised.

Fixes: 56c134f7f1b5 ("fbdev: Track deferred-I/O pages in pageref struct")
Cc: <stable@vger.kernel.org>
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
---
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index e8324b01700f..1409a5cc736b 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -1042,7 +1042,11 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 			ch->defio.deferred_io = sh_mobile_lcdc_deferred_io;
 			ch->defio.delay = msecs_to_jiffies(tmp);
 			ch->info->fbdefio = &ch->defio;
-			fb_deferred_io_init(ch->info);
+			ret = fb_deferred_io_init(ch->info);
+			if (ret) {
+				ch->info->fbdefio = NULL;
+				return ret;
+			}
 		}
 
 		sh_mobile_lcdc_display_on(ch);

-- 
2.55.0

