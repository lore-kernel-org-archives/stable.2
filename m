Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045883;
	b=HowsBupMP4XD9chpLnzIW+/YV0DvVA+yGFYQNNGJPtT36TPHh1oD/LenyFPla7qRaw8J
	 7j1RtP5CpF7Co4uzdpYoG4lps6FMLi3RexSdMjaIJORAVxgNlOp3UYeTKXGLkSvhSGbF3
	 8767GCSKf2LgPLBZLlv1be0OQV6yJ9SZr4Nnzv+TIlptDz7E0Z71GDKnR9smRUaOnLMx+
	 HzvmrzWvNJmp5UVeR9ny6YO1rqvZeLSKEzbZz/dwSLAUv/AzAsahAImRT8JOpTkiguK/p
	 XlW3zWCwVnmn6CgJauBBg2wsfjIZpbAdQ5lAC6yTt5/ZScN1ErFciGZqjYD1gPuOmyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045883;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=VugbaH3sne9uGSwzqkzZ5qY+/38pAYOZ87+yE8BdrPc=;
	b=4VpLDK2ZVXvzDL8Te0MID16O1uMFEtnkz3040pURSkvf/8IyWFYkqVF+sli9jjhWfMgU
	 2wpNHl4HDzVt640J1CAmSuIPAJldgh1XyO5/lOX+uh5QAz1U51/PHqoM1JFfDPmEyxOen
	 jOtJeBJQECLI8y9Ju7GfoFIKVvVuxoOQA786O70f9/yA7X5DFtjfriEids819fTelJhcD
	 NfS6DdyFK//7416Ap89IYO8ziZFPF8Q8XFvQb1DDQSbfXe/2nm2eDqdr2upBHIAXqzVUa
	 6mosecOZe1DqJgaEg2UOL0qGKpiff/aEFA8looVOZdZQuuWTegMWj24YJHKYdiUHy5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KvpMYfrr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED88606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KvpMYfrr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F09A1F0089F;
	Sat,  7 Nov 2026 10:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045882;
	bh=VugbaH3sne9uGSwzqkzZ5qY+/38pAYOZ87+yE8BdrPc=;
	h=From:To:Cc:Subject:Date;
	b=KvpMYfrrvZ0HNbIktwXFqM2WQVsetwnnHyVEaeb24Glau0UeFUiXV/UgBcyf9mx92
	 sNfPd/uSW/ld9iwddpCY79VTIeGQwwCqjSB7ya0eHjSmWFvWbF2rYjozeHdv6NiWG9
	 MDV7LD8WPtbMyf4fwjCVRmj/iiCVG2hAUoTSAqiO6ohctaui5mTLrhxk3OHl7n/nQV
	 6/2fKtRsSXOvHWEqzUacjCxlUiUDZgmHId4VOwzyn5X4NGDgc4jS85cj9FYw3p7FqF
	 MJ8+PUwcIDVzv0c6zEUpvP8V+BIERhKxZ236r3u+3oxnMrYZ1r7FDucikpO/tCarcR
	 M1wemQxwtv0Sw==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to use bio_in_atomic() in f2fs_write_end_io()" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:04:41 -0500
Message-ID: <20261107050441-failed-7.3-e4582e5f3b43@kernel.org>
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
git cherry-pick -x e4582e5f3b439228d4e900edcf8225aa89be32b4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050441-failed-7.3-e4582e5f3b43@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From e4582e5f3b439228d4e900edcf8225aa89be32b4 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Sat, 10 Oct 2026 14:55:45 +0800
Subject: [PATCH] f2fs: fix to use bio_in_atomic() in f2fs_write_end_io()

f2fs_write_end_io() uses in_atomic() to decide whether a write bio which
exceeds max_atc_write_bio_size or max_atc_write_bio_entry_cnt should be
completed in sbi->wq rather than in the current context.

However, in_atomic() is not meant to be used outside core kernel code
(checkpatch.pl warns about it), as it only looks at preempt_count(): it
misses irqs-disabled and RCU read-side critical sections, and on kernels
without CONFIG_PREEMPT_COUNT it cannot see spinlock-held sections at all.
In those contexts, a large write bio will still be completed inline,
which defeats the purpose of the above knobs.

The block layer provides bio_in_atomic() for exactly this purpose, it
checks rcu_preempt_depth() and preemptible(), and conservatively returns
true if CONFIG_PREEMPT_COUNT is disabled, let's use it instead. The
difference is as below:

 Context                              | in_atomic()    | bio_in_atomic()
 -------------------------------------+----------------+----------------
 Hard IRQ / softirq                   | true           | true
 IRQs disabled, preempt count 0       | false (missed) | true
 RCU read lock (CONFIG_PREEMPTION)    | false (missed) | true
 Kernel w/o CONFIG_PREEMPT_COUNT      | IRQ ctx only   | always true

Note that on kernels without CONFIG_PREEMPT_COUNT, write bios exceeding
the thresholds will always be offloaded to sbi->wq, since there is no way
to tell whether the current context is atomic. The thresholds default to
UINT_MAX, so the default behavior is not changed.

Cc: stable@kernel.org
Fixes: 3de6b8094115 ("f2fs: Run f2fs_write_end_io() asynchronously")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1925fc3aef57b..ae3bde0767f3c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -398,8 +398,9 @@ static void f2fs_write_end_io(struct bio *bio)
 
 	sbi = bio->bi_private;
 
-	if (in_atomic() && (bio->bi_iter.bi_size > sbi->max_atc_write_bio_size ||
-			F2FS_BIO(bio)->entry_cnt > sbi->max_atc_write_bio_entry_cnt)) {
+	if (bio_in_atomic() &&
+	    (bio->bi_iter.bi_size > sbi->max_atc_write_bio_size ||
+	     F2FS_BIO(bio)->entry_cnt > sbi->max_atc_write_bio_entry_cnt)) {
 		struct work_struct *w;
 
 		w = &container_of(bio, struct f2fs_bio, bio)->work;
-- 
2.53.0




