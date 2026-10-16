Received: from mail-dl2-f9.google.com (mail-dl2-f9.google.com [74.125.229.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9566380FF7
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792135865; cv=none; b=Zu4WelGnkUTGw0p4Oxxfsd1NUh7AKw1v0V+7+ZvSquxVN+4N8I88f3W6Osmp3l7f8FLVdDS4YeVhkITbLI9x3rtGlWfAXLqF9NFM35QA0A2yTomb7YexlrVHk1I0ixBcvyuGWaLuJ6hRiB1tUIIDmv4Tx1Ldw2Kfopg3kCqARQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792135865; c=relaxed/simple;
	bh=w78AxETGPHyzfmayF6RqGh9MNLfHyZeAJnbAFfjzWAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OzFfM483BKVMp8aEKzbhh8Nv1OK8fngp2W4TxculyHEFCttvJue7dQei32HMXwkNHKOJ5kcDbXkHvgjqU2Fm+8fnv7VIGl+Ebn5RFO5eEWbdyJZxOJ6vHpYYPyoaMAiw0Fm96/tXAmx3hu2h2PcG++iCX7gzFuP7xaN6Aen5BXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sL461faJ; arc=none smtp.client-ip=74.125.229.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sL461faJ"
Received: by mail-dl2-f9.google.com with SMTP id a92af1059eb24-1397ad3d891so1518833c88.0
        for <stable@vger.kernel.org>; Fri, 16 Oct 2026 00:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792135862; x=1792740662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ddI7wafcUO9ClL5oaRHB8Y5QOHWEf7RdloyAjD1mNAk=;
        b=sL461faJjIl2+cWt/R+J4hg5eBKnmPIFj3ytOAQEtjli1AtOpkcjAGsdNgsFN7dr31
         x1A6SQ1zO+VSwI2mrkdABeLRP2HUiCUrJFROIitaKMGqZhrB24OtFgHQg5JtydP50Unl
         p73zRKT3yymEJniuz57cRf2DDHUglSn0FTU4/mdLSnAEPIjE7KnXoHXpqnGnpfDIgGQD
         8FG2lY+JIwsCimquzqqjU8AvM+sqgY0IAFz7GyEo1iYt5E2IGhgDnxbsTll05AdBu439
         Z60jBUFJjR9lNr0HrdYTTcgWzLrH+ExP47h7G5Dwwhe+crtWGT3sSeSSs56P8p1Q3cpV
         i0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792135862; x=1792740662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ddI7wafcUO9ClL5oaRHB8Y5QOHWEf7RdloyAjD1mNAk=;
        b=tNPTEc7YyMVkKFsEOKNOHitxnDUjiEZlGmMdBFvbZXXwC7GynBo9QTPThicuswebgA
         86/Kk8rumQTrR92Sh4TF/HlRD9eh0AZGFDeZt5JdLbahAAi1oDxHNJgKEnLWGJX/fA3+
         l8kWjYStnvagAIQdh1w3dlRUsmH4ZORPcFy6D8ja8ie9E15YYSpd4HGTj74fV1M7rth/
         IazoRnVZmV0qyUErliFuYQ6VF6L0Yt8cYaYK5mZUGe9tSN4bBlA/oWpcsPTkxnSKUDCg
         JBwFhHOJ8z1dD9Y+/vjoYEodR3p1FIuU+PC2rQbvJ845XhC9jrQ0hidwyT3bHn5v+Xqf
         JD/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxBBuiKr5WxBo1icp+nVwBCOAYmzDQliFyrWBEFeDVg28M29bXSEN/dXqLgXkv7L4bnVuRJvFo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJmyOfbxn89ARit2bNggqPkjUKAEPtG0L1HJFqRo/KZXFQhATSO
	SqjLfCWBJ1fsfBD/vMU5ASLnHwc4DNlydXviTEbk10CITdNgQ9nIwytQ
X-Gm-Gg: AYBFou3jV5eHcLzuz9uFIS42S9KXzgRJn120teRtXA74G8kAgGEWM1PpQ7r1oyEHAQ0
	jmYGJAi15wygjRd6pIkowtRLtk3vQH/FrFA/KTKD2V1ScaqxZzWA4No8J8hKpELsqU52Tfmjtn6
	jbw/W1IRc05SVXGZwsTYoIZe+8FeHVEtd1Wp/Tqbl+XpUW/9SqfnYibbEX4+SWcMXO9o9qY9MPj
	G0GppRB9tPJNsopnevh0Nk1O06p5tJZQqBE/yOMMu78uZ2EmllOhLq7pK5B3wBxyaiWlYN2/fT9
	vBh/GJCTyojeCDxceQHEt8GLeIfChdFvy0wq5J9FXndMk6tbzG/JQyS2TSfHxAaj85+V9n25ItL
	B2JdOBtohu6hlxx/i+HM16mgf1LjRiLPqSZvei/CDNZAkkeqICIOR1vUVA/M4vJgVXTG6UtN8ax
	he3oiY4+VivJzSLqPf5k5IVZPkL5UfpbHvO4ZIE8NvMzNeQ+JQ3kRQCyh5HjhgZpAVtpl4acvwT
	Q2SSaDZeZ8KH+gWpbAK99o96wEqNomLnhQBI3JPCGt6Rl4=
X-Received: by 2002:a05:701b:2713:b0:143:26cf:8615 with SMTP id a92af1059eb24-16a6169558fmr30706517c88.25.1792135861737;
        Fri, 16 Oct 2026 00:31:01 -0700 (PDT)
Received: from blue.tailcc13ef.ts.net (104.194.64.109.16clouds.com. [104.194.64.109])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831a6f58c2sm5367021c88.11.2026.10.16.00.30.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 00:31:01 -0700 (PDT)
From: Yao Yiqi <yyaqia@gmail.com>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	yaoyiqi3@huawei.com,
	Yao Yiqi <yyaqia@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 2/3] fbcon: Rebuild rotated font buffer on font change
Date: Fri, 16 Oct 2026 15:30:22 +0800
Message-ID: <20261016073023.490430-3-yyaqia@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016073023.490430-1-yyaqia@gmail.com>
References: <20261016073023.490430-1-yyaqia@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yao Yiqi <yaoyiqi3@huawei.com>

fbcon_rotate_font() caches a rotated copy of the console font in
par->rotated.buf. The buffer is sized from the font's width, height
and charcount, and is rebuilt in fbcon_init(), fbcon_switch() and
fbcon_modechanged(), but not in fbcon_do_set_font().

When the console font is changed through KDFONTOP/KD_FONT_OP_SET, the
new font data and geometry are installed and vc_resize() is called.
The redraw that follows reaches the rotated bitops while the buffer
still holds the old font: the rotated putcs/cursor ops index
par->rotated.buf with the new cell size and character codes, so a
stale, too-small buffer is read out of bounds.

KASAN reports, for example:

  BUG: KASAN: slab-out-of-bounds in soft_cursor
  Read of size 64 at addr ...
   memcpy
   soft_cursor
   cw_cursor
   fbcon_cursor
   hide_cursor
   redraw_screen
   vc_do_resize
   fbcon_do_set_font
   fbcon_set_font
   con_font_op
   vt_ioctl

Rebuild the buffer for the visible console right after the new font
geometry has been installed and before any redraw. Select the
console's blitting state with set_blitting_type() first, as
fbcon_init(), fbcon_switch() and fbcon_modechanged() do before their
rotate_font() calls: fbcon_rotate_font() reads the source font
through par->p, which may otherwise still refer to another console of
this framebuffer. On tile-blitting hardware, the same call uploads
the new font's map to the text engine, which previously happened only
when the console was switched. Background consoles keep their rebuild
at fbcon_switch() time, as the buffer is shared per framebuffer and
must not be rebuilt for a console that is not being displayed.

If vc_resize() fails, err_out restores the previous font. The rotated
buffer that was rebuilt for the new font earlier in the function
cannot be restored with it: font_data_rotate() has already reused or
freed the buffer that belonged to the old font. Select the blitting
type and rebuild the buffer again after the restore: the upload to
tile-blitting hardware and the rotated cache would otherwise keep
describing the rejected font, and par->rotated.fontdata would keep
referencing the font data whose last reference the error path drops.
A failing rebuild leaves par->rotated.buf NULL, so the rotated ops
skip drawing instead of reading a mismatched buffer; the next patch
retries the allocation on the following call.

Unlike the other callers, this one does not fall back to unrotated
rendering on failure. The "par->rotate = FB_ROTATE_UR;
set_blitting_type(vc, info);" fallback they use does not actually
switch to unrotated rendering: set_blitting_type() calls
fbcon_set_rotation(), which immediately re-derives par->rotate from
par->p->con_rotate. Replicating that pattern here would not change
the outcome; repairing the fallback is left to separate work.

Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
---
Changes in v3:

- Also select the blitting type again in the error path of
  fbcon_do_set_font(). On tile-blitting hardware, set_blitting_type()
  uploads the font map to the text engine; without the second call, a
  failed vc_resize() left the engine with the rejected font (found by
  the Sashiko review).

Changes in v2:

- Rebuild the buffer again in the error path of fbcon_do_set_font().
  Without this, a failed vc_resize() left the rotated cache describing
  the rejected font while the console rendered with the restored one,
  and par->rotated.fontdata referenced freed font data (found by the
  Sashiko review).
- Select the console's blitting state with set_blitting_type() before
  rebuilding, like the other rotate_font() callers, instead of writing
  par->p directly.
- Reworded the note about the unrotated-rendering fallback, which is
  now left to separate work.
---
 drivers/video/fbdev/core/fbcon.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 01715873ea49..d90a2ad45053 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2432,6 +2432,17 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!vc->vc_hi_font_mask && charcount == 512)
 		set_vc_hi_font(vc, true);
 
+	/*
+	 * Select the console's blitting state and update par->rotated to
+	 * match the new font, so that the rendering below does not use a
+	 * cache that was built for the old font.
+	 */
+	if (con_is_visible(vc)) {
+		set_blitting_type(vc, info);
+		if (par->bitops->rotate_font)
+			par->bitops->rotate_font(info, vc);
+	}
+
 	if (resize) {
 		int cols, rows;
 
@@ -2466,6 +2477,18 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
 		set_vc_hi_font(vc, false);
 
+	/*
+	 * Restore the rendering state for the old font: re-select the
+	 * blitting type, which re-uploads the font map on tile-blitting
+	 * hardware, and overwrite par->rotated with the restored font's
+	 * state.
+	 */
+	if (con_is_visible(vc)) {
+		set_blitting_type(vc, info);
+		if (par->bitops->rotate_font)
+			par->bitops->rotate_font(info, vc);
+	}
+
 	font_data_put(data);
 
 	return ret;
-- 
2.56.0

