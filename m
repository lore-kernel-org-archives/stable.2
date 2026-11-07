Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047876;
	b=ekWQLyKBzIBeCAwovYez+d9gU0JTeOMeD/Xh5LjM17Hp0tUIY08mKwVWtFfrntC6t29j
	 55JaxMekqDqjGPVYdLzuIh8viQOJuuItnZGfTVCETnvFPa9TT01IlRF8v8RjyrlLNPWIR
	 NM6wFPKDHdFuUJEv2aD77iYQsYowVuXIIu3PihULCrB7l1O/G90D+rZjPF/V1rdS9fgx3
	 pSlc/7LSCwjG36wtFcHJKZ5dczgc1Ov2nu+9HmLVdttq6FABqdmHTfgWclSsYGhQU6gUD
	 zjaEbp7M0DXDv4Dm6JzdVztMDu0Au/FuFQbrzO8uvSs04mD6EeGegyzki8hYrdoVS5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047876;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=tCgk6/hxRgCmea+n9jZQor4FnRP5vq7jd7UpS+k83pk=;
	b=cN96gBnJhNIiC656425fGsvO7EzjtZhinHTVUNZCMyBseZkFk+pfcnQR4c2ejS9SSb/Z
	 Pruwmu2i1eVH10mNzlvA1ylpGepeZtIcFNDX5Y8+YVVL7AKfCpyPqn7i270rASILxVOxx
	 0i5frhPAUkq+K/caabrY6p5FSkBtIW1mOC+V67ji/b0W07E33xH1ie7ayc30a7+hUekJ/
	 v1e3fMJjMtscI1OghfihouBMPiJCbdQUySYkGFoYRfyrHU+j/e/EFIc9wdGi2TgSv0gCj
	 2N1ULBCBn1LMnkTOYqlf5qCSjq4tCBqrd2To8QFmiWlI3dRI3lOxoXD4noIZWQN4gwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1pDG9ni;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97311606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B1pDG9ni
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00D2F1F0089F;
	Sat,  7 Nov 2026 10:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047876;
	bh=tCgk6/hxRgCmea+n9jZQor4FnRP5vq7jd7UpS+k83pk=;
	h=From:To:Cc:Subject:Date;
	b=B1pDG9niu4KT6aUEyNK3m0JBczSrzg7yP9/lkbSjl+iNvCD0bbUUdPlhABD3La7jw
	 8Md99v2C6UfV/sOQ+4itqMp0ZkikTRWNRMVX9YnDk2CGkaqVTep1/w05f7cRaLYABZ
	 wMq4evO0ULr7C1AogiZQaw0gTubdXffEK+lM5YKcMZQp9VEabPjibrhremMYSCV3am
	 EAVGitVk48qSD0M6KXgYDmAT75DNdMmu1u/xf679YgI6rqcLWYR7X0OiGGLbFtynZb
	 oXi9lKZlBve5BVoPWBT/dAjDfTUchS34iQaRPsfVQ3HpOBQYeioj4gG9ELAr3HiAY/
	 /xzgpYuCs3BRw==
From: Sasha Levin <sashal@kernel.org>
To: yaoyiqi3@huawei.com,
	tzimmermann@suse.de,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbcon: Retry rotated font allocation after failure" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:37:54 -0500
Message-ID: <20261107053754-failed-6.6-7935db1a4a0f@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 7935db1a4a0f83a63590a222500e5016e2f6c85e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053754-failed-6.6-7935db1a4a0f@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




