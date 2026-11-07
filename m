Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050560;
	b=u4Qh6rIrwskWnWwZOkOBJ1wHWENmCJfbz3ZOw0DKaD2BRf0CKpyLb6aLxJE5xnm+3Mc0
	 CI1X+r6YlfbBWFeP+lXoGlQY04+gS2aebpNixEtMGD8l+GiRVenSvHPIjuJZE5DNQboND
	 hw98giWgYG4hy4O7kVhKBfOmBjOCELemrxPlRlwh9+DRkURxkSfCSJyAGUtAzJYW+1mQD
	 i72sX3wzfSzQELc7doKD9H7YdslLv61ILK/ImrkC2UyGtls5699xMM6J8N/FBToJek/gg
	 KfDF8k2h7dTLRCzpZCXP3FXGqUs9OoxN1RJteZanRW3S3rLk/qjD1sYZphi9o+tH+Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050560;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LmqGuWbLrRMU87ovpxmKvmPvTDgITKqnP/4Bi4G6LEo=;
	b=2C4+FtyVKkKH5iN+LUXyT6ORLSulyZIdoebZ5+mscGZqTzPBEPtsJAv//Hb9Vk7Bu0tR
	 yz1cfeQOaRMxFGOrlBqjXzrrfMXAtKV0bX6kL6V/GCHttmqFBYAPpEAI+a/gTayqbeuBB
	 gaIXW+mRErg7iEIRZrxAnuxszjPgUOt5v5FJrtrh1VXrbfWdkCHNnbfR5cjhS+jWG+Yjq
	 4C8Vb5r6UAFkLO2+Qw2CVJUayVeFivGItMZ1dxo+TuxMhjyPmAJavd4S9mVC+4/aCSks3
	 771bzM0mrEBVDhUISCeImk5cfHyv8Fi7dV47wMOBdkLenqfeHmlPQriCReNDNHLJaYQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZ6aUlt1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5881C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OZ6aUlt1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66F271F0089F;
	Sat,  7 Nov 2026 11:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050560;
	bh=LmqGuWbLrRMU87ovpxmKvmPvTDgITKqnP/4Bi4G6LEo=;
	h=From:To:Cc:Subject:Date;
	b=OZ6aUlt1dMEWqn7gTSM615LfIWbwAoYamIZyMgNY9vJ06ZxhUB83b/V6Wv02FyOec
	 uYbGZPmmzgqIOjRAqKIrvi3/LaXv2GoyQ2HvNGnjaIFY9TCfKHen1mPXDXcukWRC0H
	 5tal/KHx8tTmWmNvInAHanPbxbSgzi3Kt/ZvkR1H+hXvSm/1QrMBqvOzWVKbLz0TtW
	 R8isWK2/equOldOVZVAqORcmlyKqqu3X2Lxnp+GMBY4PebA0YPlt0N/a/u6SeT/anJ
	 8T9rPS2Jnekcgq9HA7TnjFHxaiEF615xXlYbmQJ4wXpX7KbUP6n7qLZ1VXAOgJTUMx
	 v0mLN4tg3B7vQ==
From: Sasha Levin <sashal@kernel.org>
To: zhanxusheng1024@gmail.com,
	zhanxusheng@xiaomi.com,
	chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix defragment writeback range truncation on 32-bit" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:22:38 -0500
Message-ID: <20261107062237-failed-5.10-92154fe28c37@kernel.org>
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
git cherry-pick -x 92154fe28c3701bebf75176dc5522bec62519a8f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062237-failed-5.10-92154fe28c37@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 92154fe28c3701bebf75176dc5522bec62519a8f Mon Sep 17 00:00:00 2001
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
Date: Mon, 5 Oct 2026 23:49:54 +0800
Subject: [PATCH] f2fs: fix defragment writeback range truncation on 32-bit

f2fs_defragment_range() flushes the range it is about to defragment:

	filemap_write_and_wait_range(inode->i_mapping,
				pg_start << PAGE_SHIFT,
				(pg_end << PAGE_SHIFT) - 1);

pg_start and pg_end are pgoff_t, 32 bits on 32-bit kernels, so both
shifts are evaluated in 32 bits and truncated before they are widened to
the loff_t parameters.  pg_end is only capped by the file's page count,
so for a file larger than 4 GiB the shift wraps.

For a 5 GiB file pg_end is 1310720 and the range collapses from
[0, 5 GiB) to [0, 1 GiB), leaving the rest of the dirty pages unwritten
before the blocks are moved.  For 8 GiB the shift yields 0, the minus one
makes it (loff_t)-1, and the range becomes [0, LLONG_MAX].

The matching call in f2fs_collapse_range() already casts:

	filemap_write_and_wait_range(inode->i_mapping,
				(loff_t)index << PAGE_SHIFT,
				((loff_t)pg_end << PAGE_SHIFT) - 1);

Do the same here.  On i386 the shift changes from "shl $0xc,%ecx" to
"shld", i.e. from a 32-bit shift to a double-precision one.

Cc: stable@kernel.org
Fixes: d323d005ac4a ("f2fs: support file defragment")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 713fb6f49bcb3..d4d859dbef880 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3036,8 +3036,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 	/* writeback all dirty pages in the range */
 	err = filemap_write_and_wait_range(inode->i_mapping,
-						pg_start << PAGE_SHIFT,
-						(pg_end << PAGE_SHIFT) - 1);
+						(loff_t)pg_start << PAGE_SHIFT,
+						((loff_t)pg_end << PAGE_SHIFT) - 1);
 	if (err)
 		goto out;
 
-- 
2.53.0




