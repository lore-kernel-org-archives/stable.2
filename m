Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050230;
	b=NjSfxzjYOvXP2YPjQd6nz5GA+o+DXbemxjJdT5cwvps57IIvFYbVEekG92R8/NISyPMl
	 RTqmZTyTxtvXZfRGsDNCsVLwg40wT7L2iOE5R1M1Oa2gOFfYhYAV09O8mtZ/MmB6kZbhx
	 jsVkQzqerQa7mRdnEJPxyENb/XHgPg08+rwKnVzqWrbUxxfkkr0KKUQxMHCS0YC4Jm2HG
	 +xO/kW2K5UN3NpE3fDVFlR4Lva9KD86AnjgE7dFtL5dFdZ1JKyExBiR6Siro9t1KEnGdQ
	 ERUkVopfxIc9TfNUwUc2muYXbpO4kJrl/6y8QFMZwNJPjWi/tIAZVWmFd9/xedKGdYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050230;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=npeCPKeeseR3EI3BDLFkQeirHFnoBUxxPJDGeGaRu1c=;
	b=ZNFfTcZVekBela8MDPRsChH6xPxYjI5slcll4k+GouUAfTfJNJeMenvkKX3YmPP3KO+M
	 4APjFv2jjadaO3CLkdrEU5kylF3L0oLiwSb7vTYdwpyX8eJF3Isp58oLykLS5qUa04ujw
	 6QVeF7URGaqfDJBLa9AFYKLPkfSXO0KiUigvB0wFIcRbLoj90c0nmE3rwJ3otflGB1imX
	 I0Y+tZHetJVxQ2WQz5J/2xXvKYsWVRWKDQsh1coYzXcTGD1vDHVBtiZ8Gcq7A5FGWhtiX
	 vrBNpN0TEKZP96cDk4QAHhpWvoqW47BQ7zrTWFoawFo1lfubTd93XGMz+dI8D2lpeqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPor0LTC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D114D606A32F
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPor0LTC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E7FA1F0089F;
	Sat,  7 Nov 2026 11:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050229;
	bh=npeCPKeeseR3EI3BDLFkQeirHFnoBUxxPJDGeGaRu1c=;
	h=From:To:Cc:Subject:Date;
	b=iPor0LTC2PN+KxalyRvVigYBSmGKjUy++vyEQ/aiIzzF8S/AYf9YtpKFUaUOYPnER
	 NSQakC7N0GJuFqhnBHAstGOetDxr15rdahSHzispvcEHECBMVBqcmBbcn/A/4BA9NM
	 Tw+jbAlYCh1aTRXXKOXhJamMfmNuB/sGSdJud21I9jVIxHk8dHuit2YntLEYJv+TDI
	 vXSYlIZb1hzJs4j8pfw5JeanvVO/NSQ+NLdQIwW4pm7+TpXbDGM41A8lC49fQs4Inf
	 buH1S/Iegqhp3hbuqunrdXozmJaj2sJ9fC+fVhP2nzrMFfWASAiioZlggqdAR3yomf
	 c/rDgel7JCbcw==
From: Sasha Levin <sashal@kernel.org>
To: vulab@iscas.ac.cn,
	miquel.raynal@bootlin.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mtd: mtdsuper: Fix MTD device reference leak in mtd_get_sb()" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:17:08 -0500
Message-ID: <20261107061708-failed-5.10-62ee3da38f41@kernel.org>
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
git cherry-pick -x 62ee3da38f41bef83c1cf250f6816a0ee187674b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061708-failed-5.10-62ee3da38f41@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




