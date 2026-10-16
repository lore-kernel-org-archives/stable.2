Received: from mail-dy2-f5.google.com (mail-dy2-f5.google.com [74.125.229.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349B43B811F
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 03:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792122349; cv=none; b=A6jyOt0dVrQq+AuDzrS3Q4MTkoSSVWPX/5P18thdHfseiGcNInomYUh3jXX2G7S3rPXWmOaHNlTMmd+FH96tE6E1+BBf0OJlzkOgbf5JW8RtHrbvq2AqY0PHU2absxaV0mYIrDMSA0GbCgiSfTsWoKoplFpEckGaHksgLnLwJfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792122349; c=relaxed/simple;
	bh=u5IrG70TsMGR0TeAkFBFLu/8wLCeYLQpP87CO9uxKJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BnXF7Vm3+B1bcV7e4bDdB0QRY2tJUoz3CCPi//CWEFxUszk0dRoAj1hPGzylhQ2loiikfD6Hq737ViztnlBuOadwMxkZpA5GkoMBApl7wtKXxKLwcl1bM54KMQgzPPdhMGWk9M0ZSgwjqZXHuKMlXvH3+5XYDSEehq/EEt5YrQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BcEHJUJB; arc=none smtp.client-ip=74.125.229.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BcEHJUJB"
Received: by mail-dy2-f5.google.com with SMTP id 5a478bee46e88-35de2661992so1537106eec.1
        for <stable@vger.kernel.org>; Thu, 15 Oct 2026 20:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792122346; x=1792727146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R0y1dJ5AAiyMzBzdNY5zHpT5jRGPheygtScQcJ1Wvm4=;
        b=BcEHJUJBpTvCLUk0LorQH908hXs8m6PjWOWm/atEATkkge6DfOHh/us4bS5xaAS39h
         n9bUwYCev7dEFz1yT291t9/fgDK4Q0Aag8SmlLL/Y7dhhHGAnIVmPPFOYUqB/AAFWPwE
         g+lRK9v7haGDdUGbB2ScdgL5Hv4Mh8fmQwTB/LctU7TZLuzJlpyPA/xn0evV14vvvGL3
         +i/8voxh7oLxOkcsVWDgpsCeEpjewMWgvhS6odwP95Cjlxr5n6nKriiCqcdrv84orx2m
         7r+zmUzOuqZFjcQ9HJ6x14A4dTQEqLPzz0DuUuzPZvtfQlhb2U40k0P/Zq9aqb7JfdYx
         Oksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792122346; x=1792727146;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R0y1dJ5AAiyMzBzdNY5zHpT5jRGPheygtScQcJ1Wvm4=;
        b=Z/de5kcHiVkQ/m/fpa4pr8LlzpppM7Vjo/wfDSjigZsoqXq2/howpv3Xiweo5tYwQT
         ZWZFcuolZCinrUkvFng7hzQR5crXOW1LFUyUfT5aFLRSOJRqaD3HBXG/d3g/uN4W9dPe
         9ukQA0iGy/E1tTZ9QNFs9Xa4bNnxUTXHSzx3gf1R+udu/4F2jfRxOeypHzvczivbHhrK
         BFI93PDetXIdhCED1IJDByBNPEqFgVCJlotaGwbLTP9q7abSjLpQD61rwFHBEsCzOEbj
         U5hi2A8wWIG1GPUfLZLTZI1cGFG6Cxpbmf1FFPRZy61xk9mPKew+T7ew43PRK10uO+cc
         360A==
X-Forwarded-Encrypted: i=1; AKwUvBx9zE+ORO5ap+kZK76kggArnoM1AuN/FY15dSEjIHFv+lkfWx3aMhEE6hl06PxrVFwwWDEEsk4=@vger.kernel.org
X-Gm-Message-State: AFq9FYI1WM2SGESlb5JT66tAI6cR1K+zaLwrrBEUI7s0hjm12Hb9/euG
	KY/GaaUKfx0O6a1S4dM1SYdzb6+95rzbU6zekWdH3C4MuFO2YCfbQZCxlR4DDe+68bAWgbk/RMI
	=
X-Gm-Gg: AYBFou1uN/ntjgH3QuMdFDIj1B09msRaXoHWHW7cQFOiW+lwHueyx23ZJug3htdeRjN
	cYChqygrnrRpyAwC59vWsmxqLlSIn1WGOqANpfU3z63TbIc6ooNRA3fqQYOeDMxv9+NsS+XOrlA
	gHpWBd7oSnPidDl7o0qiZCsgZfmZPJgXhHBk0qzruemRVdS1J8Tecuqdv1NYqQlPg15M1XhQWki
	09cG9buGuXNlGx9Z9ZblZh4r9ORSnDKnnKVVfGgV06y49qOhmGHWPxIdxsIQwPrlXoTYpR1tZFy
	Yze4UvBKpQFUBtOl9kSthX117yhVY+w4eItYhajE5n9wAD4r3LYbeX1S/WhXXkYTnFCoA3tf6x4
	zmAccAuqohcER0yqFKsk15y8iQklhofcdOY3vRR+KCLlmr1wH5j2ySOIUwdL2eeiflRHjxhWYah
	M0Vwd9fAYINymNuzGzhkVgqxvVGsYZpGMMjQf52YEk++uIinK56LyumZ7GVJ6aISSeqz3mIOXwx
	L0EBKWjfe/ooiTNA+xhiArKA9vYzK+gj/LCpko=
X-Received: by 2002:a05:7300:c8cb:b0:35f:f4c3:6403 with SMTP id 5a478bee46e88-35ff4d2b879mr3439491eec.36.1792122346157;
        Thu, 15 Oct 2026 20:45:46 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3608297f4f7sm2434229eec.23.2026.10.15.20.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 20:45:45 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
X-Google-Original-From: Yao Yiqi <yaoyiqi3@huawei.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com,
	Yao Yiqi <yyaqia@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 1/3] fbcon: Include font geometry in the rotated font cache
Date: Fri, 16 Oct 2026 11:45:31 +0800
Message-ID: <20261016034533.445862-2-yaoyiqi3@huawei.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016034533.445862-1-yaoyiqi3@huawei.com>
References: <20261016034533.445862-1-yaoyiqi3@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Yiqi <yyaqia@gmail.com>

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_rotate_font() caches a rotated copy of the console font in
par->rotated.buf and skips the rebuild when the cache appears to be
up to date. The cache is keyed on the source font's data pointer and
the rotation alone, on the assumption that an unchanged fontdata
pointer implies an unchanged font.

That assumption does not hold. Raw font data (font_data_t) stores no
glyph geometry; width, height and charcount are tracked separately in
vc->vc_font. When a font is uploaded, fbcon_set_font() deduplicates
it against the fonts of all consoles with font_data_is_equal(), which
compares only the byte count, the checksum and the raw bytes. Two
uploads of the same data that declare different dimensions therefore
end up sharing one font_data_t, and a console can install a new
geometry while its fontdata pointer stays the same.

The early-out in fbcon_rotate_font() then skips the rebuild, and the
rotated blitting routines index the stale buffer with cell sizes
computed from the new geometry:

	src = par->rotated.buf + (scr_readw(s) & charmask) * cellsize;

Rotation swaps a glyph's width and height, so the size of the rotated
cell depends on pitch rounding and differs between geometries. A 4x16
font whose 4096 bytes are re-uploaded as 16x8 on a CW-rotated console,
for example, grows the rotated cell size from 8 to 16 bytes, and the
largest character then reads past the end of the 2048-byte buffer that
was built for the 4x16 geometry.

The key has never included the geometry. Its exposure was limited,
but not eliminated, while the deduplication in fbcon_set_font() also
compared the consoles' font widths and total byte counts: with the
charcount restricted to 256 or 512, differing uploads could then only
trade height against charcount (such as 4x18x256 against 4x9x512),
and even those can change the rotated cell size. Commit 1e3c49aa03fb
("lib/fonts: Compare font data for equality with font_data_is_equal()")
dropped the width comparison, so identical bytes now share font data
across arbitrary dimensions.

Record the geometry that the buffer was built from and compare it in
the early-out, so a geometry change always triggers a rebuild.

Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
 drivers/video/fbdev/core/fbcon.h        | 9 ++++++---
 drivers/video/fbdev/core/fbcon_rotate.c | 9 ++++++++-
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 407d207b14f1..bfbd70f8b1cd 100644
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
index 6cdbc96eeca6..660a3fa81bae 100644
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
2.56.0

