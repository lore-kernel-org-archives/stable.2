Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045843;
	b=2tv2nMJEw7WTf+6t/dZBNfVZbvtbuivvR8+AQE4KiHgBVOHTqDyKMXlQCub17ZZFwHMf
	 rvrki1ZqypFwnn7Izr8BzOeBad8yGaawfyXFsqT0WyCcvBeecxeUUgBOd3h3xutML+y0c
	 P43M5fvoOwwqcPe7wKfLJyy/33BK2y6WqRIsUw21Xn7IoM6yGGB1xKmqw2M0Yk2Z7OP9k
	 YgNRCaPXzr7Z5HD1iIA4Ry+1o7OSe0kU/YNeXpEXpQ0xyofxRuKhbxJ1wrwfzGxbgqnWd
	 2BjjgKndpYIKUTnx2QgK6MBq3O4NLey/0FNYaHIxelxHnfEzj564EnEcgQNnUhFb6lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045843;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=eeneTULSPRrkQAl5cx0yHskaxw7qZI7CmjLjSseYl+g=;
	b=MLXppfQmrjB7B46X5x9zIoFf71pLA/WSVSD+kySbUMTPY7RETyXhvwjWBwZris8qV5AJ
	 mRG3zmkup+E+HrcRqD12/XZwj+MYQSNW6LRVrio99KhiDvlu7SShv35RONCr+VZwFf/2l
	 KDGVy2PovpLYPMSMBPOnyLh4BkzmgZjrNlXIJ3BtX0uNoIgiZ3KeUORk4zTOffyXeWCS5
	 HK65R3LasU8YzN/cXtW1vrRWKJWt+c3HbjpoZCOia/DN/R80pETRQYkeIoMrvMk55lged
	 MNIK+tvxbsIygqgFNecgmBJsT5KRC38MK30s5kzeXEfl5CjpruOWx2UkPSnIhR5vxlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDPYK50u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6D5606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDPYK50u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B405D1F0089F;
	Sat,  7 Nov 2026 10:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045843;
	bh=eeneTULSPRrkQAl5cx0yHskaxw7qZI7CmjLjSseYl+g=;
	h=From:To:Cc:Subject:Date;
	b=NDPYK50uKnIRzU8OajhdwpSLXuFKZCIayxnNKLoXX+ywMCviACcon0cl/j/GdEKhl
	 FWQX5/rzKPVFqMlXb6Tg2cMJTZ6fRMfgFoislnGe6OFzPJzcGrX//8n9t3Lfg1Kp0o
	 8FLgF5Ky7ry+ONwavSkuL5a4HcUrd1moeBPLG/8KncRw7tCUsa0bcmNvTpY4V3awTi
	 iyAgWIPA87SaqK3Ah+1qG6QGxdWiOEDHQyes6K7VnCPxm4lyoXKGzsp/voSLKcjNgu
	 n4bC+esgS09OZSVBh1ysUPlk7D3WuM0NK+2tfoUBHt6z/fN60UrdsdZv44nJL8Td4t
	 gCa4TA78Nh+8w==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to check continuousness in f2fs_sync_meta_pages() correctly" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:01 -0500
Message-ID: <20261107050401-failed-7.3-1383cff4ccf3@kernel.org>
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

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 1383cff4ccf3c8833c6255edffa29eb67c6419bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050401-failed-7.3-1383cff4ccf3@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 1383cff4ccf3c8833c6255edffa29eb67c6419bb Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Thu, 1 Oct 2026 00:06:16 +0000
Subject: [PATCH] f2fs: fix to check continuousness in f2fs_sync_meta_pages()
 correctly

In f2fs_sync_meta_pages(), whenever i becomes zero inside while loop,
below check may be skipped, it failed to check the continuousness:

	if (nr_to_write != LONG_MAX && i != 0 &&
		folio->index != prev +
		folio_nr_pages(fbatch.folios[i-1])) {

Cc: stable@kernel.org
Fixes: 580e7a492608 ("f2fs: convert f2fs_sync_meta_pages() to use filemap_get_folios_tag()")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 7b89bb838946d..2e5e0ee5feb20 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -606,7 +606,7 @@ void f2fs_write_meta_caches(struct f2fs_sb_info *sbi)
 long f2fs_sync_meta_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 				bool sync, enum iostat_type io_type)
 {
-	pgoff_t index = 0, prev = ULONG_MAX;
+	pgoff_t index = 0, next = ULONG_MAX;
 	struct f2fs_cached_block *entries[F2FS_ONSTACK_CACHES];
 	long nwritten = 0;
 	int nr;
@@ -629,8 +629,8 @@ long f2fs_sync_meta_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 				goto stop;
 			}
 
-			if (background && i != 0 &&
-					entry->index != prev + 1) {
+			if (background && next != ULONG_MAX &&
+					entry->index != next) {
 				f2fs_cache_gang_release(entries, nr);
 				goto stop;
 			}
@@ -657,7 +657,7 @@ long f2fs_sync_meta_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 				break;
 			}
 			nwritten++;
-			prev = entry->index;
+			next = entry->index + 1;
 			if (unlikely(nwritten >= nr_to_write))
 				break;
 		}
-- 
2.53.0




