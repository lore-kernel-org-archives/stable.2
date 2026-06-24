Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D8F31F9A5;
	Wed, 24 Jun 2026 08:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290036; cv=none; b=RkpYk3qomMGo5wOg8YJ+7pykWpYf3DD3PzqK/SbNHOFizdu+dzmPJ6bt2E/vuIFi3joSAebg7YsG03HZ+JnawcUQQ8rNfyZ0q8jNh4W2ROPlpc4bM0lVHzJnSn9HZ+cXZPLl9reiWnX1tFIimoFGi6Y5kBJkcJaT1WCDdTFbTdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290036; c=relaxed/simple;
	bh=vJTNC8A0MkcNHYkuv4H8UnfJcYK38I2Z6SyNAqP+Xks=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Aq4zj97IiB6ohnTFN3o6iAiPYgkizOlC795Fz1yiNLS9hkTtSc0z36yTdkHB5OHUnvl97sFLmNXoea5ge0tWLx0XGZf7bJggl7jcnUo1kL5MO1QI/oUFYDxCdFt1pXgusyjFM+ZQaLCOexWRWDTl91PN62+3p2dW5jr6AHE94yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=BcyLReX7; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="BcyLReX7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=M0
	yyVVLf6YjrZtZ/GI81jVYzh2dTbOxLY0Y7vtCZdlQ=; b=BcyLReX7rdK2398iDs
	ZBaOlyGJYiODRv4UL2QENLR/BgzoTrz18bqKqEubU0UGi+xKVGXQUrKLSb5xt+h1
	zOnJ3gWc8jvk7qmXLSB/3jl0/Ld1JxaoD7ZEh6cBUGRgOYqYi+abL4GUlEq42G7B
	Wdz0oYxuEXd8bwkIrTaL1sJMM=
Received: from 163.com (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3O0dPljtqZF_NFQ--.56523S2;
	Wed, 24 Jun 2026 16:33:22 +0800 (CST)
From: w15303746062@163.com
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: syoshida@redhat.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH] fbdev: fbcon: fix out-of-bounds read in err_out of fbcon_do_set_font()
Date: Wed, 24 Jun 2026 16:33:16 +0800
Message-Id: <20260624083316.389677-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3O0dPljtqZF_NFQ--.56523S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGFW7Ww13WFWxCr1DJr1rtFb_yoW5Jw15p3
	9xKw13Kr1ktr1rGa10gw4vkF15Wan7A34YqayxK34rKw13Gr4UXay0yFyYvas8C3srXF10
	qw1vg34q9FyDuw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5_-PUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC5BIjB2o7llIsJAAA3P

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

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
---
 drivers/video/fbdev/core/fbcon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9077d3b99357..5880ab9f3cde 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2405,6 +2405,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	int resize, ret, old_width, old_height, old_charcount;
 	font_data_t *old_fontdata = p->fontdata;
 	const u8 *old_data = vc->vc_font.data;
+	int old_hi_font_mask = vc->vc_hi_font_mask;
 
 	font_data_get(data);
 
@@ -2451,6 +2452,12 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	vc->vc_font.height = old_height;
 	vc->vc_font.charcount = old_charcount;
 
+	/* Restore the hi_font state and screen buffer */
+	if (old_hi_font_mask && !vc->vc_hi_font_mask)
+		set_vc_hi_font(vc, true);
+	else if (!old_hi_font_mask && vc->vc_hi_font_mask)
+		set_vc_hi_font(vc, false);
+
 	font_data_put(data);
 
 	return ret;
-- 
2.34.1

