Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046409;
	b=i+DPsE79HK1ZGqQH5KNbJ/I85nGoRpxtLEJKCzAhJFHMqEi9eDKL/jdTA3uwmfKII+Al
	 Ui46cl91Empv2ILa2BnGHI08H66FWhts8hRb+wE/i7CLL0iN6rfTI44TNLd3P1zeiJCGK
	 F54ZwtGnEIbjcmA09s0AHGQ0PUYOCC3AoaLhQy3Y35XZOF946Hj2LJs0RQIdY7YB+2jeN
	 Rphef65z5B5qCR4SmfbRnyM/Q/ZC+4pRqDMDQN0vWehnyqLLvjMQjTJGqGQB3LSu8E2sm
	 xLgYMxI8oy6mkml71RVUUE6O/NXwJQBQZGVAh2NiBWIgzuNvVdO6YooU78pLp0OlcHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046409;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=177H/DLBswvHteOtnEze7kv+8+KO6hU3nJnpHTUADKM=;
	b=0Ov7OuqENWvCrwcJDmJU5ONY/BIlqA4c6hpqm+9LR3MF+WUZsmA+djnE5XT2NuGe+pr2
	 BS3TCIixnfZUVCITjuaqkdtFjeXmLLRqsEdytq7QtRtD9W4Ky6CSueq16aJ3FoM35TwAW
	 xHGStEzPbFLQ/1RctEuEBonVzRGDFk7vrAFhVYlG14hML0IQ1lsM9e1KwMV342lLzSps6
	 rNr8R/WyKQd4txwGdv8YxU6kdVBOAfhE0JciZSLCDeO/W5LK9/f2eKrntDuNqy8OH3YGY
	 YmRJKvud0yWvP++9pkAgX4654NrWkWfFDap9nD/YQCJ1hMz1rEQYKgrPEOxdeZnwR7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxMIV3zh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D6A606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WxMIV3zh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CF601F0089F;
	Sat,  7 Nov 2026 10:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046409;
	bh=177H/DLBswvHteOtnEze7kv+8+KO6hU3nJnpHTUADKM=;
	h=From:To:Cc:Subject:Date;
	b=WxMIV3zh/HiHs09WP+h5I7eVOpXZJhMzU1sqWCX7c3aBBsJXv0hk1hDeRSGRcmzTe
	 gAfSxzy7F6Bqte7Db/ncOTtg6WN7MtkIHO1i7/UJCNLv9RyrdC5avNBGSWVDMEvzyw
	 Av3ozYsHm2au6hlMdHPRDD3RRR6A8mahgCO1LCURjA2s7zwgeHqQjOJk2UVwI2KgXg
	 arzVJo60ukU/u7NYUto8dw2J1SOhFmbl9qZ6GB4EywedlP2+hGCgdvcC+z2ulCsvZt
	 MXeQDDLJTovyiUoydqFo2keGY+2jLCeBhfxX+Z240hOdtfov6hpQylIzjNS+jPN9KX
	 DUI3unq+sQpkg==
From: Sasha Levin <sashal@kernel.org>
To: yaoyiqi3@huawei.com,
	tzimmermann@suse.de,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbcon: Retry rotated font allocation after failure" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:13:27 -0500
Message-ID: <20261107051327-failed-6.18-7935db1a4a0f@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 7935db1a4a0f83a63590a222500e5016e2f6c85e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051327-failed-6.18-7935db1a4a0f@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7935db1a4a0f83a63590a222500e5016e2f6c85e Mon Sep 17 00:00:00 2001
From: Yao Yiqi <yaoyiqi3@huawei.com>
Date: Mon, 19 Oct 2026 17:43:31 +0800
Subject: [PATCH] fbcon: Retry rotated font allocation after failure

fbcon_rotate_font() records the font, its geometry and the rotation in
par->rotated before calling font_data_rotate(). If the allocation
fails, the error path clears par->rotated.buf, but the recorded key
already looks up to date, so the next call takes the early-out and
never retries. The rotated putcs/cursor ops keep returning early on
the NULL buffer, and the console stays blank even after memory is
available again.

Also test par->rotated.buf in the early-out, so a failed allocation
is retried on the next call: at the next fbcon_switch(),
fbcon_modechanged() or font change.

Fixes: e4ef723d8975 ("fbcon: Avoid OOB font access if console rotation fails")
Cc: stable@vger.kernel.org
Signed-off-by: Yao Yiqi <yaoyiqi3@huawei.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/core/fbcon_rotate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbcon_rotate.c b/drivers/video/fbdev/core/fbcon_rotate.c
index 660a3fa81baed..7afd63dcee7be 100644
--- a/drivers/video/fbdev/core/fbcon_rotate.c
+++ b/drivers/video/fbdev/core/fbcon_rotate.c
@@ -25,7 +25,8 @@ int fbcon_rotate_font(struct fb_info *info, struct vc_data *vc)
 	    par->rotate == par->rotated.buf_rotate &&
 	    vc->vc_font.width == par->rotated.buf_width &&
 	    vc->vc_font.height == par->rotated.buf_height &&
-	    vc->vc_font.charcount == par->rotated.buf_charcount)
+	    vc->vc_font.charcount == par->rotated.buf_charcount &&
+	    par->rotated.buf)
 		return 0;
 
 	par->rotated.fontdata = par->p->fontdata;
-- 
2.53.0




