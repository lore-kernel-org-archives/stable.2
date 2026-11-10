Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345933;
	b=A/45OMHOa5C/lcG1/yWwShwjWEqGKQjrHM/gn1FA7v1TOtN35Q5oEaIn4tcRT+HSXUdz
	 QiL06J8N5ADD468Ozbfs2Qky4PvhIlaPeu0IjoDSF/NXNjAbJ4IZ5tqjZ3tQ4LatBaRJD
	 9b52hQ4L3maG+J2ntyigLRAzZbVDK7D+Q/MKBXpOATpSBwMXQjk3vIL8bThbf1rMlptIf
	 tCTIbgcYvcT57mucr6yKsumIuKCMxkJTlz8f1WWfVeGqbvHKfKq1PKUlpAxnD/nK2qonN
	 /SH4CPsXH+Q24d3KP5wdR6PDDpqjW2yPWNDimC0MTJ+0M9dsrR/Da4EWX9tEaaDDvaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345933;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=s4mPlhc58dz/KEgQEibMDKI2tMxaZT0mY/4r1a+31ts=;
	b=d1XsSueeePmjiZx0UVRNufNnkZKA56GKrg6AagISeImgwfnfl8HJj0SR+KxcF+JfyPLO
	 0fedBPiZOvw9dmFUmNqXrmnrFba15ktcpOVBCGfO3/2/fPZC6g8RzgI19A8OkfgDLKLo5
	 u/mqlKbyurXg0SUibtw8rsFd4N6vNhQR6kGeL8xC+GZpQN5dTK1WcmfZnQI32uTTc9rCr
	 Iongn/t2XMAbHXaljRh+nll/Il8eWLN0Lxk5KAcJgkI85TNr6qdGqXFkkAJFCyphz6R39
	 423/PC7FyehcetvRvciYyPlqH6R05eI6cF4hwSezdMwkMLuGEDfcKS1pbUIvlJtYXDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKOWAYgJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE398606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fKOWAYgJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAA5F1F008A1;
	Tue, 10 Nov 2026 21:25:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794345932;
	bh=s4mPlhc58dz/KEgQEibMDKI2tMxaZT0mY/4r1a+31ts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fKOWAYgJcWu0yVQv5Y/RlwEMP/2APg+FmtSsS+EgBTUodEV+MdJZEeAlQz2U0eknZ
	 fF5Dt+DPZkn0fzZDMQC7NYS81VFdnUPdmbqrFdxMwJkeGnY4YXNkwibacqKgJOCu7A
	 UtkmBInadT/439jitEyad2suzz1Flyy5rAreaZVk8pAxxVJ7tgOurtALkiZvEC5dlc
	 /8fsgDxe9R7Uvlx/dg9vaYxL4BpgBJm65uVpog70MgRMeFkCQJdzdz3gWCFKyhvaGj
	 eAwt2dmUVZJ6vrf9yukHSQwHF5efNePW0u+LM18QUUTApuz7j+rKnlnsK39ueMYi7x
	 Lu0Ryp7yTFYcA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tal Zussman <tz2294@columbia.edu>,
	Christoph Hellwig <hch@infradead.org>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] block: introduce bio_in_atomic()
Date: Tue, 10 Nov 2026 16:25:29 -0500
Message-ID: <20261110212248.3885710-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052219-failed-6.12-a605d5d71a6d@kernel.org>
References: <20261107052219-failed-6.12-a605d5d71a6d@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tal Zussman <tz2294@columbia.edu>

[ Upstream commit 8ed0831b5263e1aa48d99063795a1f20e4e69b50 ]

Move the atomic context detection logic from erofs's z_erofs_in_atomic()
into the block layer as bio_in_atomic(). This helper returns true when
the current context is unsafe for sleeping bio completion handlers (e.g.,
hard/soft IRQ, preempt-disabled).

The logic was originally added to erofs in commit c99fab6e80b7 ("erofs:
fix atomic context detection when !CONFIG_DEBUG_LOCK_ALLOC"). A
subsequent patch will use it in the block layer's bio completion
infrastructure, so move it to include/linux/bio.h where both subsystems
can share it.

Convert erofs to call the new bio_in_atomic() directly.

Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260730-blk-dontcache-v7-1-3e8e6850068d@columbia.edu
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Stable-dep-of: a605d5d71a6d ("f2fs: fix to use bio_in_atomic() in f2fs_read_end_io()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/erofs/zdata.c    | 11 +----------
 include/linux/bio.h | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index 08720efbb1a17..10b9aa2c28541 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -1386,15 +1386,6 @@ static void z_erofs_decompressqueue_kthread_work(struct kthread_work *work)
 }
 #endif
 
-/* Use (kthread_)work in atomic contexts to minimize scheduling overhead */
-static inline bool z_erofs_in_atomic(void)
-{
-	if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
-		return true;
-	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
-		return true;
-	return !preemptible();
-}
 
 static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 				       int bios)
@@ -1411,7 +1402,7 @@ static void z_erofs_decompress_kickoff(struct z_erofs_decompressqueue *io,
 
 	if (atomic_add_return(bios, &io->pending_bios))
 		return;
-	if (z_erofs_in_atomic()) {
+	if (bio_in_atomic()) {
 		/* See `sync_decompress` in sysfs-fs-erofs for more details */
 		if (sbi->sync_decompress == EROFS_SYNC_DECOMPRESS_AUTO)
 			sbi->sync_decompress = EROFS_SYNC_DECOMPRESS_FORCE_ON;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d4f58a2d15b69..104a68749ab1e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -377,6 +377,21 @@ static inline struct bio *bio_alloc(struct block_device *bdev,
 
 void submit_bio(struct bio *bio);
 
+/**
+ * bio_in_atomic - check if the current context is unsafe for bio completion
+ *
+ * Return: %true in atomic contexts (e.g. hard/soft IRQ, preempt-disabled);
+ * %false when a bio can be safely completed in the current context.
+ */
+static inline bool bio_in_atomic(void)
+{
+	if (IS_ENABLED(CONFIG_PREEMPTION) && rcu_preempt_depth())
+		return true;
+	if (!IS_ENABLED(CONFIG_PREEMPT_COUNT))
+		return true;
+	return !preemptible();
+}
+
 extern void bio_endio(struct bio *);
 
 static inline void bio_io_error(struct bio *bio)
-- 
2.53.0

