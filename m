Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050521;
	b=JgYGxZh9YMNMyoVnNkH5gaBvWHEXQ5tu9ntwP5f7q3rImwH54U+TqvxelsUTgqq/3Wxm
	 7rcpI6OMMzAJPSL4Dvu4tmuaEQkrFRVIbyNG1YUQNTpDF85lOUE1J9IplRFwXKOXiISmH
	 X/sfwnMoUZ7dJO7fFRpVyzeOHicD9z5ri3w9G1phNawDFd9zbQsca4pnFEB2PwSPCzBy4
	 edGfi851dddcKntDAgtjGjvobCjduQDvzduU81QfuoxnKNt0FPmLIjMAJkNtOl1y50WWr
	 qS9WrI8hcKR+7IQyHikP6VcakW+p2qSVE0zwt+8QBXpBcAxyFIr/vIiow9ouQ/x7gyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050521;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=R/lWK1kvXHURTHAsQJSWBgObbVS1GXIWWHCD3EZIVN4=;
	b=hlpz9WRtw7QzpY14F8doCy0Cg1kXfj4pw4BkP4KMXxb1wAXpUHUP+/krcga0ZRiLHiKo
	 jZoG51awIo859KSOO+60lL9jInMRSqO0wc5CA11qdx+Vg8TYxzEL+6G+ALF+3rgpByMNP
	 EqrzLmvouGWgw2Byk+5jinrVRPVz55BIx8IfdFPcQPhBVg+l4bJiXI791n/Mz9PPlSTeN
	 Ftvq3m3C2jOQVHalktVXTKjLdqMZQal7OtitbOiHwdQeIj21SX6N6Fzo5JAmbgFL7IVEK
	 ZixAU1D8VudqkZKwPNYdjDIUlWueLB0Y01mxZAxaTiUBprj1vX8cQiiDYOlhsOiXYdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LC8tlj/B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D713606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LC8tlj/B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7561F0089F;
	Sat,  7 Nov 2026 11:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050521;
	bh=R/lWK1kvXHURTHAsQJSWBgObbVS1GXIWWHCD3EZIVN4=;
	h=From:To:Cc:Subject:Date;
	b=LC8tlj/BLOmUk4xFrI+yfOxaJkR+oUbDF0xB2Bfq/0CRBW7Rp9yDuzTu+DiMHHXMY
	 VO44+2Q4GWfanRf8zqxpxzV9ICnRsu1pLbEwIkV6uNVfWOW/+Q+37Wn1ZkWhPtLac5
	 87Bh3Ab6qrfsF71pPrI2dxCbQjD0SxTW5nFB6F7B9Rrt1KehTqrRcwIUCUIq2maHx4
	 qrQ9glEVAxGKLJlP2e3FKV3jheilXBP4yvx8Uh4ghb0ZUQa9tbb4/s1oJJSkbP5Y8e
	 J+uIP+iJi1ybyHDPjQj0dEwfKoVKuZnF9AckIiDMEymjj2uI1MDCfTqS1+SRTYKU3T
	 iZuS3zTwAG7eA==
From: Sasha Levin <sashal@kernel.org>
To: ljs@kernel.org,
	deller@gmx.de
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] fbdev: udlfb: check for fb_deferred_io_init() error" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:21:59 -0500
Message-ID: <20261107062159-failed-5.10-eae055f33e41@kernel.org>
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
git cherry-pick -x eae055f33e41e1d3e1a7e905bdcb1e9f196ed31d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062159-failed-5.10-eae055f33e41@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From eae055f33e41e1d3e1a7e905bdcb1e9f196ed31d Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Sat, 26 Sep 2026 14:17:02 +0100
Subject: [PATCH] fbdev: udlfb: check for fb_deferred_io_init() error

fb_deferred_io_init() allocates deferred I/O state, populating
info->fbdefio_state, or leaving it NULL if an error occurs.

Currently dlfb_ops_open() ignores its return value.

Therefore if an error arises in fb_deferred_io_init() (for instance, due to
an allocation failure) info->fbdefio_state is left NULL.

fb_open() will then dereference a NULL pointer (calling
fb_deferred_io_open()) as soon as dlfb_ops_open() returns.

Additionally, if the allocation of info->fbdefio itself fails,
dlfb_ops_open() sets info->fbdefio to NULL and invokes
fb_deferred_io_init() regardless, hitting BUG_ON(!fbdefio).

Fix this by only invoking fb_deferred_io_init() if the allocation
succeeded, and checking for the error.

The driver already supports operating without deferred I/O, so in either
case fall back to that by setting info->fbdefio to NULL.

The ignored return value was introduced in commit 56c134f7f1b5 ("fbdev:
Track deferred-I/O pages in pageref struct").

However, the BUG_ON() issue originates from the earlier
commit 5bea1fbf9423 ("staging: udlfb: fix incorrect fb_defio
implementation for multiple framebuffers"), so target that for the fix.

Fixes: 5bea1fbf9423 ("staging: udlfb: fix incorrect fb_defio implementation for multiple framebuffers")
Cc: stable@vger.kernel.org
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/video/fbdev/udlfb.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 92b352bc7e969..8b7b4bdac4fbf 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -947,10 +947,13 @@ static int dlfb_ops_open(struct fb_info *info, int user)
 			fbdefio->delay = DL_DEFIO_WRITE_DELAY;
 			fbdefio->sort_pagereflist = true;
 			fbdefio->deferred_io = dlfb_dpy_deferred_io;
-		}
 
-		info->fbdefio = fbdefio;
-		fb_deferred_io_init(info);
+			info->fbdefio = fbdefio;
+			if (fb_deferred_io_init(info)) {
+				kfree(fbdefio);
+				info->fbdefio = NULL;
+			}
+		}
 	}
 
 	dev_dbg(info->dev, "open, user=%d fb_info=%p count=%d\n",
-- 
2.53.0




