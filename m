Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046086;
	b=bgCFBN4IgsUxsHLY0zfJIDaCEbw80A0MqYWDGXUO87Hod0JRvvg8nC1GF2u4xPjbbakk
	 /iIAU07t7OoB32ZHEkA3+QP3S/4OS0Hm2hRsxDl6/gVMMo10kFgHn3zKWXh7s0lO+SmLp
	 l0Dt6iE16oIH178+hnVOgD5YYNk7ASloIThRZa/VrcvHEdilBhpWapUyxbu7M3CUxRslI
	 gCWaHkZRPQikdauqKiDj8bueGMF9iRr4putcMxUKNZ/W09pHcXYN2PXw9eB4qmGl+4+Zk
	 Jph/NA7R7o39i7DDxbnWGFfwpK0l3C+Ao3aWqJJw0A+GTCF8zSZD+x0pf/KXaQ0tgdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046086;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XnyDjRNuLqEEN3gpi4XnHISQTcR4HBbJjV2XubvFnTU=;
	b=jRpjKfVzPzzCMd6hu2LQ6s45WBWJ9x25Bis3MSFAXem9aJsQACCSYTGqu4UH4Fyv9p/I
	 SvdNQeNymokQJS1PArKhga12slLyq5s6DVkI68AHLNgukkyIrETVFhKsfmYIZ5f558hU5
	 8PWVJM38601p8NFCvbP27lZCW4Jg9z0yxC/YLUaIWbFqVzEiNyliB6OkRpV7Gs5ya2xt6
	 FicayxCf+Zc/vgvroX2dN0yHRgTUy3Nh4j48pMxVYECH+OKcGkli0yb5T+nU6L1trF54x
	 uZar0luwg9IrjjViqo6Zmt3vsk/YjaBOVyoXU8lCqMr1vvLcQb8k3ENcct0B5nAtGeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=En89jFix;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446B4606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=En89jFix
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B60271F0089F;
	Sat,  7 Nov 2026 10:08:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046086;
	bh=XnyDjRNuLqEEN3gpi4XnHISQTcR4HBbJjV2XubvFnTU=;
	h=From:To:Cc:Subject:Date;
	b=En89jFixzJPyqZ2Bb90lZGCOrvPV5HQ227Sy9o5DbusoRspisMtaKAqw2ufhl8tOs
	 BIzCew/fxsrCqKvlbVQKmqyMQz8nCTBiQUX8ijmEA6Gh8oDBR8Y4cJH6RspbCRzmo1
	 gpdFJRRaSAwvbmXVGt2BACJZ6HSl4TaQXmr0XgU9//26TIBc/aWOXyBdblCXXNTovo
	 /IJJO1B4VJ6x2o5OZE71d0xzmzloIO9F0wzZUk+O6tJXOeyoET40zM/r/DmxMMiDFE
	 EJOegcy3eajmBFOdziFRLowE2z34lkn4Dsr8o/hWvzMYylgQPpqI+C42qEnhDPArPJ
	 3Nxr01uTCX/3Q==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to check continuousness in f2fs_sync_meta_pages() correctly" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:08:04 -0500
Message-ID: <20261107050804-failed-6.18-1383cff4ccf3@kernel.org>
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
git cherry-pick -x 1383cff4ccf3c8833c6255edffa29eb67c6419bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050804-failed-6.18-1383cff4ccf3@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




