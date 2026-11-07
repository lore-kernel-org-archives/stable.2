Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047469;
	b=mUf90Wb1zSku5qPXmEgK+AipVycWQBBpbw/jxRCbqWuylad/1Pb9m/MkmfseoB/nRFwr
	 9zVt1g4tKzDynSSywjoTtMwQbwbTg4c2IK0n09GVUPw2K2kIDJkhI4Bqpbbitd+VB6x1s
	 ndpMBKCsQ34hhumNF1VQkG+Giw26f1VWY+tbAqNhOwICjqW9CC3+g4685Q2DLgFq3PdsQ
	 Cn+HOoBqKe8Ae/5uoPgmobxTq2W07lpHd/i0Go9rxNg1XZAk8GcZil9m2urz9GOQpfF6k
	 6AVmGQLk7jaBR0IPa3wXQOSu4uJzmCKzV3lMuOtOafuXCpV1NYsLkoBJtKcSJg98UIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047469;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=SPXRz132blyZ1+SKl3KRUY4jQcFtjc0d+u6WaR+J6mM=;
	b=2KSxYNXrHnMQfttvLFd/AH0p38+i9bah9csoViaHOCje5whZKdKEoIDIjcsObBSXqTrm
	 XeuZPMcJlBunRF8H/SdmEXfioAwrNaFmRRLx5sdbnTbS/F3QcgKN3QSjFsofXwhKvIhr+
	 u83szHtsfmQ7UsAcycgcg0XFf8HXfj2XgszfET8cc86EdspPAwovaXp6/yi77jcdGNnmq
	 l6HZKVbzneijabcIsm0uZEcd9op7GY3tuDAu5rCYHTzmfI/xIYA6bWm8q2wxF2bIgw+I/
	 C8sZKYlGnNYFCBoOq5upORlyJiD9jb3Vij0RH7wn+hB5xx8PHAFAuTwSmdm0iEKmdTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9HG6pMU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB586606A33E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h9HG6pMU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428DB1F0089F;
	Sat,  7 Nov 2026 10:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047468;
	bh=SPXRz132blyZ1+SKl3KRUY4jQcFtjc0d+u6WaR+J6mM=;
	h=From:To:Cc:Subject:Date;
	b=h9HG6pMUciJM5/q5SEoIhZkuyaAocG9wgZ92FKaMCsC2JMCikgBES/hpq3lKvKXQY
	 kF+CKdQwZYctl1b7nIqb+DWXb1AoY8FKXisW/N0mAkdH9nxJmIVF+T3hW/FDneSKUy
	 +sD2W5IxgVTNLbwl5M3/GMEv6ZuurmnjlKbjrR5IY2KiOcvSvChVSEk0eUhhpqufKa
	 fBl8O0J06ROm8okPoQK050t6nb3/BDiv9EBf2jCOLTrxDvp3dXoJh+JrgtxN77O0hC
	 CnlYwgN5Uul8MNAU23ImuuHX6owltMw13o8yZ74ps4jKgIXebqCN9nsTlbl1mvdm+x
	 v6AlfSvoEBM4w==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to check continuousness in f2fs_sync_meta_pages() correctly" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:31:07 -0500
Message-ID: <20261107053107-failed-6.6-1383cff4ccf3@kernel.org>
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
git cherry-pick -x 1383cff4ccf3c8833c6255edffa29eb67c6419bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053107-failed-6.6-1383cff4ccf3@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




