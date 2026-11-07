Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046719;
	b=DBf0ek+AD3KdZ6Lei7KNfMTbfqpu0KlEi6aDnKtllkKxb6ajdQgdcX1fIcpidJbXu48S
	 YmTSlv+WxXLFReOrq2Kr03x13FP64h4UPzOzbOzgjhjFksFVqUIiRrfT8g6yQEgRCZ/Zd
	 2BvO0tx6/cWMM6yRpIA4Gy3oalizRsezEM4uUAILBRAwki/r/IwiAlDX+L6j5DIg7/eOk
	 7KWxH0r579suD54Fhev2A45f7RJmA/dEeA1HgSEd9VCn5/5B1FIS+NeGrHAyt6Gia3WBe
	 K3HDpsX+71A4BAKrOvYklcnY0Vr1qjVPfvCBUS598m+0Ntj4r1EpTAqq6UDB4cQTsjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046719;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=QynDcrsoOE07YEc4dodaPuQLuoidhSPaT0CnJRr7RvI=;
	b=Z0yXnSapGeSrRnQIGWU16GwsSP97fmgZ7S4rFYdWnVp30uUdUUESfFxIgEBZ66RqpUlb
	 qQ49J36m0/T9YbzqftCtp/+rlE4VGlr7ZKY98FZA5y0GvLntmCMmclZMOBlv+lONgCXXj
	 6lw9Bc+oUmAagDCRszW895tufDgq2aTc4EtIV9FWppVBKWKS8Da6M/ChqsLi1RnAL7Om/
	 ++m2s7ANJeWwnOu8qthx0R9LV1isK3ojfYXg9Va82XNTI1HlxpGIRRonqtJ054Ks+j8HH
	 P+LbHX9anJE1ONtAfw3a7rv6ffq+bg6VRST/33/MMUJrKsD+27cIqUyOy1YMsoRJt/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SwFFYHKp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAA4606D819
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SwFFYHKp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAF21F0089F;
	Sat,  7 Nov 2026 10:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046719;
	bh=QynDcrsoOE07YEc4dodaPuQLuoidhSPaT0CnJRr7RvI=;
	h=From:To:Cc:Subject:Date;
	b=SwFFYHKpUpgu7delXeLxXkcoPNeuYtI/bfK744V5ffKzIes8iJddX6Ooag7Ye7tMG
	 rK9dFcGt83kQgveaCg5n8uZLxSrXi4/qs/g3ohPYitIy/R4lBr429Q1/dGJBujdWaK
	 w3iE8gpLRGIMBiNFZEdGhtyIGRcKkjiMsimbpZUGK2KkAC6Mnl2Oa8RUk7vCCkVHFF
	 ySQFCLYm3hIQyHcOsMV9jNJKLLxPg10FfDWO/WZpbv001vshZp02xRZ8bix0ypdfBl
	 4E/0m5LHl5FI+sy53ggImguRuQIZ4ElANYfMXODAmx2Pl0dUdOKmQctSJVoytqbXih
	 lGmU0P8wB6gAg==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to check continuousness in f2fs_sync_meta_pages() correctly" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:18:37 -0500
Message-ID: <20261107051837-failed-6.12-1383cff4ccf3@kernel.org>
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
git cherry-pick -x 1383cff4ccf3c8833c6255edffa29eb67c6419bb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051837-failed-6.12-1383cff4ccf3@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




