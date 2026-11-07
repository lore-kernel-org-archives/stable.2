Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047107;
	b=xIOOjfa7EvwBhyFtWR6aWCNxpS21YW3pyFSpupLijoxQpZkQ8vGQh0bH2M8Ge27a2Sbe
	 +LT34YF+E3PoeD+WU6kNFFxR0nIypdDMdayCSTyaXMBCi3xRop6lnJ60zM3dOIlC2Mwqw
	 c9/IO/kNQZXYnWjWkDiUDcTh39lMdOrQUuqtTwwABNBBVhZHhD9GqtKyJBOSswTl7krkc
	 aqbALWPoQlL6hk/v4rOlMPeTRctyXDNW5ZDgZZ29h22OGfCdSLCVFhvSg3KtC+J9etbJr
	 hjDxSOs/Q+HGmCoFyBEUotNfbo2rXk/ZmvGA4j/Uc2/C+10p39mEgnB4EF5JGt2BDlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047107;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=1gCEkT8UUQmRQK3zvBTm0FPsdIYwOJ71yQFxXau6O4s=;
	b=0av/3+F6WiH/a1JdYXjzxHHyrt7SL65/NXqiZpaY6eJnmMIQtYHsdXoA+24vDObIEJvS
	 MxUuQ6wa9PsSa+zQB3Iiz8zzd3nTwZEWFx+9Ak1Pmtmtouh59aXIAu9gYp9iVbw/NAK4b
	 7C1P4JqjetnuZ6AJcNQETQ5DQsWBQKCY3y1tOwLZVa1bJg8dN+uHwdFITGPt3v2S8SyF4
	 qU8hxidJGVXrIbp89qlyk8QaogqBqZPwBm7S9fFdF3L9XxqM6F1Ev7ZS8yx1eDrjmIcC8
	 9cWIcqNsicYB5nzdB5zK31NyTQAZ0zW4GebtlA3J2vdd1uC/VvP2dQGC8nTNkC323qg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqB1IPBH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5784C606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqB1IPBH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FCB1F0089F;
	Sat,  7 Nov 2026 10:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047107;
	bh=1gCEkT8UUQmRQK3zvBTm0FPsdIYwOJ71yQFxXau6O4s=;
	h=From:To:Cc:Subject:Date;
	b=WqB1IPBHQK3U33eX/+MDeCPZXei0e2TMszC/6+M7foTwAgPDGk14ikG63nS5wea1b
	 OK0zrIwWoWbSpAzqNYjRtxCTEhkP6A7XeMg1Uz2nCaApvGsv2BH27rafglqYgzWXrr
	 s9Fc+wVtZ8WXGH0w9NvvbqtFK1oT9xN14vsibjpoRfDiO8sE98GbTsYEnrnCSWHPZA
	 iNhvxsBAxjpR7d+suANbkT7hmNwfmJIm+xplJ2AYL0NSYuGL8ZWEfHXwzNjnVhpXbl
	 cTbyoYVqaHFzuzZeMRBR26/ln2Te6qRab7MWuzaiaxmoS6ToaKbOb3RuP5Y+sMJjBv
	 VS6sf41iaPpHQ==
From: Sasha Levin <sashal@kernel.org>
To: yaoyiqi3@huawei.com,
	tzimmermann@suse.de,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbcon: Retry rotated font allocation after failure" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:25:05 -0500
Message-ID: <20261107052505-failed-6.12-7935db1a4a0f@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7935db1a4a0f83a63590a222500e5016e2f6c85e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052505-failed-6.12-7935db1a4a0f@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




