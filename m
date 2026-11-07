Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049221;
	b=WmcBsKa9ARPrudfIZXu5Jer5LboJoYUaO3gf3wQUxfs2uSAVPCLDiprxknMhvGxXZjRV
	 ZsFN1QXG4cP+z1nBK97Vxc/rZJv6BcX+rK9bUaj5c+1V9L1WeuEOm07MSXLYFwV1MF6xB
	 mFMbB4SyLseKtJKoNhWOvyZys29D1qOr5YooJzmA/i6WLNM41bNN+xVuDuFMyG/SyB3Lp
	 XUIYYuXX5tsHlqbrCi1iwRARh1zBsPL6o5JVJFz7lC4lMoXgsuqqUV99QoSklMxtIJdLc
	 WcFCsrDUjK8pIrO3E1tVA+mSoXi7suSVvVRbsh2aBNzjnRzK2yZzU94CFOMdmJ/kfng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049221;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Z8JYGIWvX/y+I6qjcPvWo3AkOxGlaAFmPSZ/X6cBARI=;
	b=12LvwaNdtXJKinjJWdHGefGYX3qe1JkZiq/mNsRHBjNRa03+HuMEISpXopYOhfVtnqSf
	 fU5Zdm3AXmnse1JQGsSKcVBQYgX5JUxYKqVDW3yBbcSjdK/2/bDkyq8cnKUbfusYI0ffJ
	 mTWXk8FM6ugtLZ6EKb45jmQpGNYrz99wQ3wPdVXjqy6+OFaeDjDU289w0LRViOho3q22F
	 EBZiGec34gk1OPb51stCeOYdBVS2VmuXGoj+1onfLZXjWqwZ5RjLH0GFK2GaFd0OXstC7
	 4609JjOzO4hqZTnMbQzzYIGoYvHlXQ6kOe1aOKXHKiq1uMpY4dCY8zokr4t7cTG0yqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EG2ywulC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775DC606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EG2ywulC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67791F0089F;
	Sat,  7 Nov 2026 11:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049221;
	bh=Z8JYGIWvX/y+I6qjcPvWo3AkOxGlaAFmPSZ/X6cBARI=;
	h=From:To:Cc:Subject:Date;
	b=EG2ywulCe3Eb/UIFEMKhuliwBn3nIrXMgepKOZ4JFGqukMuihttKz1z5hgaB3wD0r
	 NH5F58q+veSE9gT/4VCMQtPZTdficRwgUKe7Kg2YHi4i2Em3M1GYOF1qWfYYCvBsvQ
	 5exFTaM3uNeIbmWPCf4nWvb9p2xWZ3S6F30LhV9viP7ZmhTknLeuVXoocnoFCZwHOq
	 1R3ymws0EmDT+ETxftmxe4VVtu48aOShwI7k7Hk5JzA3HV6+Yv7ZiNhQmmjvrxwkcD
	 KKQ2nQ5x9BZFpGfONENs6c4yX8/8ChXDMop3GwqD1Xam0AU8F5e8oAIJE0iDyAnBCv
	 sCcnSmQ/eDCvA==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	miquel.raynal@bootlin.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mtd: mtdsuper: Fix MTD device reference leak in mtd_get_sb()" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:00:19 -0500
Message-ID: <20261107060019-failed-5.15-62ee3da38f41@kernel.org>
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
git cherry-pick -x 62ee3da38f41bef83c1cf250f6816a0ee187674b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107060019-failed-5.15-62ee3da38f41@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 62ee3da38f41bef83c1cf250f6816a0ee187674b Mon Sep 17 00:00:00 2001
From: Wentao Liang <vulab@iscas.ac.cn>
Date: Thu, 17 Sep 2026 10:25:50 +0000
Subject: [PATCH] mtd: mtdsuper: Fix MTD device reference leak in mtd_get_sb()

mtd_get_sb() is called with a reference to the MTD device already
taken by the caller.  When sget_dev() fails, the function returns the
error without dropping that reference, so the device is never released
and its refcount never reaches zero.  Every mount attempt on an MTD
device whose superblock cannot be set up leaks a reference.

Restore the put_mtd_device() that the fs_context conversion dropped on
this path.

Fixes: 0f071004109d ("mtd: Provide fs_context-aware mount_mtd() replacement")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
 drivers/mtd/mtdsuper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index c709ff7aa6b57..02eede3fe582e 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -31,8 +31,10 @@ static int mtd_get_sb(struct fs_context *fc,
 	int ret;
 
 	sb = sget_dev(fc, MKDEV(MTD_BLOCK_MAJOR, mtd->index));
-	if (IS_ERR(sb))
+	if (IS_ERR(sb)) {
+		put_mtd_device(mtd);
 		return PTR_ERR(sb);
+	}
 
 	if (sb->s_root) {
 		/* new mountpoint for an already mounted superblock */
-- 
2.53.0




