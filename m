Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049806;
	b=Vau9Sqpf4ln9Oqd19eSLTa+i6XuER3z8qYBBCPJJTzGojeKNB0wnVZ9Ese53ZNgX66yI
	 QIsYZB6fSxcwaby783i5b6oY9eQlynvBpLgytxeYQK1NNmg1OPx3nhaGD4/eLpLK78IW5
	 OBU1QrgwI377/mEyRMp09BpWX8OG/kt17zu4JT5uI4+8/Jg3Xg5nG1qW4fZn/cpf/wQnp
	 ehIt/on6USnV50jZjpc+K89/lpyQXRCpGrObShbJhOVh+qImshSVzS3S0mVXCfAOS7Z+f
	 96UlaUqYwKRBLjH2xGubS/o4uOX0j3plHVWrLhrXAoL/5ojtQAHj8CnmyRhiASt+mQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049806;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=MBspieL+qfRz3qN9v/+2rml5gdYeX3sNgOl6D+7xU0o=;
	b=e/uBcqcnoeeZESE6nfdPuJkLMkAmd5bjLoMBsnseSxU//bq24x9MSoL0iEDerGgkLT2i
	 boA/DvW45+t9NVlKCNZOamQaM347qzRh7A5jVUrYXzPAZpQP2sERm1llObkQjd+y6kDaJ
	 +0VPSrLELASAnAQpHhhd8UKIEl4LqV+kd6jdS3WtD4a0olvnpaY9MZ1dHCgWAzqAC4fkZ
	 oVTvGS6dziFINQhSdVqrORmiQ3WyCMdv0BSbp/pq7Xw4UFHL8Jx2qtOgWLpzkFkr2vw9a
	 Ri6AsdlhkvDqCpkM6peJ8P1G95AkKug5N3MteD/Fd/80WFVikGvmb+ANFGT8FDIzKaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="V0aZap/K";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039D3606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0aZap/K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1811F008A1;
	Sat,  7 Nov 2026 11:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049805;
	bh=MBspieL+qfRz3qN9v/+2rml5gdYeX3sNgOl6D+7xU0o=;
	h=From:To:Cc:Subject:Date;
	b=V0aZap/KzkSlofnYYfLg41mT2uvU+Z6aYZNis8L4oUvBuwUo8zuM5oTpYZrm6J6bm
	 /RtVeH4QSfot7WBsyMUxCDkiynlxyC9jhjYajV7MnmQN+gi7iA364jI963pMyF512o
	 VIR1M4zt9X73z2HuOo4GXO6Jl1mC9aXvCjWFiA06FMr71XSL4rdbqYZFveo1CaGJTa
	 5bmU7fz0WtuhUKphT2lyjkPsfu2Ynlpd0PYLoZmPoCz5kWc7mf6YG0LJQvmkp6aLQO
	 cw2AzlSZlrrstcL63cy0HESsPd4mz1MVu24gAzA3HwLEc06AHe5k0PFaFLGbk3weq2
	 ygXrI7Q13P7OA==
From: Sasha Levin <sashal@kernel.org>
To: yaoyiqi3@huawei.com,
	tzimmermann@suse.de,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbcon: Rebuild rotated font buffer on font change" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:10:03 -0500
Message-ID: <20261107061003-failed-5.15-e4b6b865d45d@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x e4b6b865d45d8dafb6c6f28c8a993a5b4431d25a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061003-failed-5.15-e4b6b865d45d@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e4b6b865d45d8dafb6c6f28c8a993a5b4431d25a Mon Sep 17 00:00:00 2001
From: Yao Yiqi <yaoyiqi3@huawei.com>
Date: Mon, 19 Oct 2026 17:43:30 +0800
Subject: [PATCH] fbcon: Rebuild rotated font buffer on font change

fbcon_rotate_font() caches a rotated copy of the console font in
par->rotated.buf. The buffer is sized from the font's width, height
and charcount, and is rebuilt in fbcon_init(), fbcon_switch() and
fbcon_modechanged(), but not in fbcon_do_set_font().

When the font is changed through KDFONTOP, the new geometry is
installed and vc_resize() redraws before the buffer is rebuilt. The
rotated putcs/cursor ops then index the old buffer with the new cell
size; KASAN reports a slab-out-of-bounds read in soft_cursor().

Rebuild the buffer for the visible console before the redraw, as the
other callers do: select the console's blitting state with
set_blitting_type() (which also uploads the new font's map on
tile-blitting hardware), then rebuild. Background consoles keep
their rebuild at fbcon_switch() time, as the buffer is shared per
framebuffer and must not be updated for a console that is not being
displayed.

To ensure a correct rollback when the rebuild or the following
vc_resize() fails, save the rotated font state, clear it before
rebuilding, and restore it in the error path of
fbcon_do_set_font().

Fixes: 6cc50e1c5b57 ("[PATCH] fbcon: Console Rotation - Add support to rotate font bitmap")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/core/fbcon.c | 46 ++++++++++++++++++++++++++++++++
 drivers/video/fbdev/core/fbcon.h | 22 ++++++++-------
 2 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index ba689d42792d7..af587ff02e437 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2391,6 +2391,10 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	font_data_t *old_fontdata = p->fontdata;
 	const u8 *old_data = vc->vc_font.data;
 	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	struct fbcon_rotated saved_rotated = { };
+	bool rotated_saved = false;
+#endif
 
 	font_data_get(data);
 
@@ -2409,6 +2413,27 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!vc->vc_hi_font_mask && charcount == 512)
 		set_vc_hi_font(vc, true);
 
+	/*
+	 * Select the console's blitting state and update par->rotated to
+	 * match the new font, so that the rendering below does not use a
+	 * cache that was built for the old font. Clear the cached state so
+	 * the rebuild allocates a fresh buffer; the old state is kept until
+	 * the font change can no longer fail.
+	 */
+	if (con_is_visible(vc)) {
+		set_blitting_type(vc, info);
+		if (par->bitops->rotate_font) {
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+			saved_rotated = par->rotated;
+			memset(&par->rotated, 0, sizeof(par->rotated));
+			rotated_saved = true;
+#endif
+			ret = par->bitops->rotate_font(info, vc);
+			if (ret)
+				goto err_out;
+		}
+	}
+
 	if (resize) {
 		int cols, rows;
 
@@ -2425,12 +2450,26 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 		update_screen(vc);
 	}
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	if (rotated_saved)
+		kfree(saved_rotated.buf);
+#endif
 	if (old_fontdata)
 		font_data_put(old_fontdata);
 
 	return 0;
 
 err_out:
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+	/*
+	 * Drop the buffer built for the new font and restore the saved
+	 * state.
+	 */
+	if (rotated_saved) {
+		kfree(par->rotated.buf);
+		par->rotated = saved_rotated;
+	}
+#endif
 	p->fontdata = old_fontdata;
 	vc->vc_font.data = old_data;
 	vc->vc_font.width = old_width;
@@ -2443,6 +2482,13 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
 		set_vc_hi_font(vc, false);
 
+	/*
+	 * Re-select the blitting type, which re-uploads the font map on
+	 * tile-blitting hardware.
+	 */
+	if (con_is_visible(vc))
+		set_blitting_type(vc, info);
+
 	font_data_put(data);
 
 	return ret;
diff --git a/drivers/video/fbdev/core/fbcon.h b/drivers/video/fbdev/core/fbcon.h
index 91b59b2990d29..d93a89877d043 100644
--- a/drivers/video/fbdev/core/fbcon.h
+++ b/drivers/video/fbdev/core/fbcon.h
@@ -72,6 +72,18 @@ struct fbcon_bitops {
 	int  (*rotate_font)(struct fb_info *info, struct vc_data *vc);
 };
 
+#ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
+struct fbcon_rotated {
+	font_data_t *fontdata;       /* source font */
+	u8 *buf;                     /* rotated glyphs */
+	size_t bufsize;
+	int buf_rotate;              /* rotation of buf */
+	unsigned int buf_width;      /* geometry of source font */
+	unsigned int buf_height;
+	unsigned int buf_charcount;
+};
+#endif
+
 struct fbcon_par {
 	struct fb_var_screeninfo var;  /* copy of the current fb_var_screeninfo */
 	struct delayed_work cursor_work; /* Cursor timer */
@@ -88,15 +100,7 @@ struct fbcon_par {
 	int    rotate;
 	char  *cursor_data;
 #ifdef CONFIG_FRAMEBUFFER_CONSOLE_ROTATION
-	struct {
-		font_data_t *fontdata;       /* source font */
-		u8 *buf;                     /* rotated glyphs */
-		size_t bufsize;
-		int buf_rotate;              /* rotation of buf */
-		unsigned int buf_width;      /* geometry of source font */
-		unsigned int buf_height;
-		unsigned int buf_charcount;
-	} rotated;
+	struct fbcon_rotated rotated;
 #endif
 	u8    *cursor_src;
 	u32    cursor_size;
-- 
2.53.0




