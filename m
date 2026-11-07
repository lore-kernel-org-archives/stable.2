Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050839;
	b=xPxHDmoYGwhiphZ4KeWbRwiRTCzFE9tqcq3tWy6g6Oe9TapXsSDcGRhtGzZG+WrZKhI/
	 ljITYA/yhff7rzBXsdJq0a3IrW3r3DwCCRZJjnsMl2IKy3JQMuY79LrKDR1C0s2To3ZKd
	 sC+ku0Ft2fboWvDjW2fzGcZ/QsLDZpxialw/LeDhTrcAvxlQE5SdkUpLvIbdWQFVw9Vq9
	 lHHGv/xKT4LTglMBwuSdKaULDGJh+oeTvFiBQp89Ba3RtEjuJFyhb+EfYdO0+EOWxkLkV
	 2MjS8xgiOEKeNMwJkBruSyK1mwvOE+0rfIOpd6tqnRV8dewl+A5NZPhOiMxJGvuQY7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050839;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zggSTJcWFdkk8Tp8dGSj2+3UPH1pBxYnU0CMYn8y9e8=;
	b=GGdqCSeMVFy4IT1fSGqXYwBB4GFhAW22xlrKuBt8MVlzQiBqIfx8B5h4zQf+pbkIrse6
	 rfLlza6c0l5CjCfDBXJDUCoL4HaL79cwEBmOutCgwk0SN+HIZfCWv5fWkxhEA3th3jmAp
	 SBq9jKjBBr8iK0/k6PXcBXQ8NwPsFNJNFce4onDhFohRX6nVnZdTRL2hk45Xoy1iGbhPG
	 Ych7XGmCvR4XEhWhHsSavDnvYc+Q6utuU0LYT5+7JYmsnVxVGJjagT0gj9ELgi7Uq1vYz
	 UoFkCnCdcesAwLT1DtDZ12ov6f5/Tsc1+FWeL6WLb5vOPFrDNdrPnuGWijtsdFHNgkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMFAGAgt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED32D606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IMFAGAgt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9A81F0089F;
	Sat,  7 Nov 2026 11:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050838;
	bh=zggSTJcWFdkk8Tp8dGSj2+3UPH1pBxYnU0CMYn8y9e8=;
	h=From:To:Cc:Subject:Date;
	b=IMFAGAgtEyTBzijqslaUwy1snDMmog6RDm1b39+nbQgW9POfwLeBE5NNGQeRoX/TB
	 eMk2wK7xOv5BoPAFivmPaJHHb0Uq4u3tA3KqWU1RiNFcs9cweDcmfmskz+/3faTBO3
	 kIRbn64S9DwSnSkk8mIN+c90ovXMz70XrfZmTxlJ4tM/odDHmXQyQVOMICgEMKudCa
	 hgXuFSNyUJ5GVhQo1yQQMnsIb3eAPX3cS3xHo9WADuP+LtdbMMvHxAhtOdJjiTw0bi
	 FFjtDhBPuDPEPP38jSn3dTqca0ALuByAIFK0G2+chA6Zt1p3axn7nH7yLsNliiKAfw
	 XaRT3yAg9G8hg==
From: Sasha Levin <sashal@kernel.org>
To: yaoyiqi3@huawei.com,
	tzimmermann@suse.de,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbcon: Retry rotated font allocation after failure" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:27:17 -0500
Message-ID: <20261107062716-failed-5.10-7935db1a4a0f@kernel.org>
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
git cherry-pick -x 7935db1a4a0f83a63590a222500e5016e2f6c85e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062716-failed-5.10-7935db1a4a0f@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




