Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D212C11F1;
	Thu, 25 Jun 2026 16:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782403414; cv=none; b=VZ9tZ0c/yLxq8Ms5wreKAhft+/ZYpTpTehcxDzlBBCaoCKaFXHGZdFzwCKxseQDMMg1K/UK9aCQncFXfX08QbDUJDfWOLYqpWply9MmyHRqTp8CguVjbgiJQlNPFZU8u6mSyQfj1rbTE5wgyZ3Jxo5MhAlPVSOSN4aILrgC75GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782403414; c=relaxed/simple;
	bh=samrj8yHo1D5/fsyySq37fuxzVFvSDkrpjTR0gmCqSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=h+ZR4DJ1DR4x/qv8JjSXFnSkD2rv/T27rH27nNQpSViY+9jmPA6Lo/p6XH73oxXblxx4Osz4+sMKMibo7YMTFOv27sO/mmUKBebGynQdLjozNj38EZPZLPCNaTicDpbQceZZN4A+VE77qoqQK8OEuBsLupo4on65/IJ0sbLjiYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn; spf=pass smtp.mailfrom=stu.xidian.edu.cn; dkim=fail (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b=tOBLxWgM reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.xidian.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=stu.xidian.edu.cn header.i=@stu.xidian.edu.cn header.b="tOBLxWgM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=stu.xidian.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-Id:MIME-Version:Content-Transfer-Encoding; bh=T8/WLYardC
	tv6AXvQJyez5N5S5F59yReGTMgkUtb4vY=; b=tOBLxWgMYVfYBLB/OWvGtfHPl8
	xK5FUWZGNTZvsHlJ3brp1x8d+BZpUfzWlP0zeuBMzLZARAWPjzcYRB2cyDcbwfXW
	khjBglHXGXJFqOTsLLVVJ4CaJPJTv8Xet8PBBEUiROGWD92IdgxdbJMvx9MLPZ4n
	Cz529xigziL3TIpUk=
Received: from wmy.localdomain (unknown [113.200.174.100])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkAmTxVAUT1q3zwBAA--.5710S2;
	Fri, 26 Jun 2026 00:03:15 +0800 (CST)
From: Mingyu Wang <25181214217@stu.xidian.edu.cn>
To: deller@gmx.de,
	tzimmermann@suse.de,
	simona@ffwll.ch
Cc: syoshida@redhat.com,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	w15303746062@163.com,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	stable@vger.kernel.org
Subject: [PATCH v2] fbdev: fbcon: fix out-of-bounds read in err_out of fbcon_do_set_font()
Date: Fri, 26 Jun 2026 00:03:06 +0800
Message-Id: <20260625160306.438847-1-25181214217@stu.xidian.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkAmTxVAUT1q3zwBAA--.5710S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGFW7Ww13WFWxCr1DJr1rtFb_yoW5Jw4xp3
	y3Kw13Kr1ktr1rGa10gw4kCF15Wan7A34jqayxK345Kw15Gr4UXFW0yFyYvF98C3srXF10
	qw1vg3s29FyDC3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r4j6r
	4UJwAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Avz4vE14
	v_JwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUUsXo7UUUUU=
	=
X-CM-SenderInfo: qsvrmiqsrujiux6v33wo0lvxldqovvfxof0/1tbiAgUPEWo9RfMFSgABs2

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
---
 drivers/video/fbdev/core/fbcon.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 9077d3b99357..37beb93045af 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2405,6 +2405,7 @@ static int fbcon_do_set_font(struct vc_data *vc, int w, int h, int charcount,
 	int resize, ret, old_width, old_height, old_charcount;
 	font_data_t *old_fontdata = p->fontdata;
 	const u8 *old_data = vc->vc_font.data;
+	unsigned short old_hi_font_mask = vc->vc_hi_font_mask;
 
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

