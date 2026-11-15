Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702136;
	b=r72bi+6IuKURZeJt81r4RfOKFEcQuGiDCtrBeJT9axdDUx6tHRYjbULEQ27jXxwWrel7
	 MqvqyXubOgfkCwiHRhzGlnWdzC1N+rPYCf7ar6hgTzdK61dTyI0jjEaM/0aDGS+lRU9q6
	 Qcs2sxSW8J3Msnfqk5nr6E/kax8Xj8JBj/EoVuI8pXEOKWLH4yObAk+EqEvwHS4ApY6c/
	 CpyXj9lvEMuJRhr2xMWW6nNCjG864bvzDI0pMqz83FaNp8Zz2MeJHRUtooDuEYaDhBlE0
	 EokPYYP8xjH+MELk7n7qSUAGY/6EfSQAxLwOfqonHMXO8bMhS2zqBlJc2XJSF9kKerA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702136;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yauzOlNqaiRncpm/7jb+NIR/dAQ03mPEzyinA8AhCk0=;
	b=Zx1o3TdACIwLkJ9eIYKDurMMDKwRB5/gQAEZRDz0lOypIFVW2BRwsHtCU7r9s1nnjJFj
	 qE+iSlClOZdsLPvfvAMA/qXNr5yojBTsUnO76BZs2zsrrucfvybJzLdQ3Uelu0jXaQNdn
	 J14GNHedQFgRKdw2i/DJKhrYkp7ztcEQ1iMXwLOo+ZrzG21s/XZjwiMD8Qy/q2UTDk3Ur
	 NP7xqBo/kLK04RL/HsnhChMWP+7qGzvMvDTgGcQl/wpOpK9+1ZLSgz+2PPhsKTuHZFXb8
	 K0NZW1G3IrI5onpHcZtirz/DProAxB0hJDODh13c1+5CAKc+OqaDNKNiMh8OFtohSPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NzuJ5mJr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9F606A329
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NzuJ5mJr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FACD1F000C4;
	Sun, 15 Nov 2026 00:22:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702136;
	bh=yauzOlNqaiRncpm/7jb+NIR/dAQ03mPEzyinA8AhCk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NzuJ5mJr6MhKTD4BYDHUOPU30EWJ70n855oNMVOoyc8a6I4lgNaIfg4mXufeUxt+D
	 4ITkTd+NrW8a1StjeB1YnxiKTn0HmgoTqmLOgGRAoFfR2j4htKmwhRWfaQLCTjlKpX
	 CM8rEUI5FISvpFmi8iwlHk/WFap5sqpxDYpFHlT6amOv495Lrg6NRSCR1Evmsk42Tc
	 3LXZI89OHM22tk7QGSRUhTJJWcXM7rJnRb1L6EgFmxaCLRcQMfEPZ0yLLqOAFcXsrP
	 IXWMrkULdEKqOdi+ZvMTJsjmXjxZU9rVDIa7vj/vrDnDKMaTBDdcdE/uKcDyJfpT/n
	 8bSTPMAR89T/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] mm: make lock_folio_maybe_drop_mmap() VMA lock aware
Date: Sat, 14 Nov 2026 19:22:13 -0500
Message-ID: <20261115002150.534207-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201133-failed-6.6-97156a6c355c@kernel.org>
References: <20261109201133-failed-6.6-97156a6c355c@kernel.org>
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

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 5d74b2ab2c15d596c470bae6626f345d5575a9d0 ]

Patch series "Handle more faults under the VMA lock", v2.

At this point, we're handling the majority of file-backed page faults
under the VMA lock, using the ->map_pages entry point.  This patch set
attempts to expand that for the following siutations:

 - We have to do a read.  This could be because we've hit the point in
   the readahead window where we need to kick off the next readahead,
   or because the page is simply not present in cache.
 - We're handling a write fault.  Most applications don't do I/O by writes
   to shared mmaps for very good reasons, but some do, and it'd be nice
   to not make that slow unnecessarily.
 - We're doing a COW of a private mapping (both PTE already present
   and PTE not-present).  These are two different codepaths and I handle
   both of them in this patch set.

There is no support in this patch set for drivers to mark themselves as
being VMA lock friendly; they could implement the ->map_pages
vm_operation, but if they do, they would be the first.  This is probably
something we want to change at some point in the future, and I've marked
where to make that change in the code.

There is very little performance change in the benchmarks we've run;
mostly because the vast majority of page faults are handled through the
other paths.  I still think this patch series is useful for workloads that
may take these paths more often, and just for cleaning up the fault path
in general (it's now clearer why we have to retry in these cases).

This patch (of 6):

Drop the VMA lock instead of the mmap_lock if that's the one which
is held.

Link: https://lkml.kernel.org/r/20231006195318.4087158-1-willy@infradead.org
Link: https://lkml.kernel.org/r/20231006195318.4087158-2-willy@infradead.org
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 97156a6c355c ("mm/filemap: finish fault cleanup before dropping the fault lock")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/filemap.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index aec7fb85775c3..4e62509489c58 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3154,7 +3154,7 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
 
 	/*
 	 * NOTE! This will make us return with VM_FAULT_RETRY, but with
-	 * the mmap_lock still held. That's how FAULT_FLAG_RETRY_NOWAIT
+	 * the fault lock still held. That's how FAULT_FLAG_RETRY_NOWAIT
 	 * is supposed to work. We have way too many special cases..
 	 */
 	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
@@ -3164,13 +3164,14 @@ static int lock_folio_maybe_drop_mmap(struct vm_fault *vmf, struct folio *folio,
 	if (vmf->flags & FAULT_FLAG_KILLABLE) {
 		if (__folio_lock_killable(folio)) {
 			/*
-			 * We didn't have the right flags to drop the mmap_lock,
-			 * but all fault_handlers only check for fatal signals
-			 * if we return VM_FAULT_RETRY, so we need to drop the
-			 * mmap_lock here and return 0 if we don't have a fpin.
+			 * We didn't have the right flags to drop the
+			 * fault lock, but all fault_handlers only check
+			 * for fatal signals if we return VM_FAULT_RETRY,
+			 * so we need to drop the fault lock here and
+			 * return 0 if we don't have a fpin.
 			 */
 			if (*fpin == NULL)
-				mmap_read_unlock(vmf->vma->vm_mm);
+				release_fault_lock(vmf);
 			return 0;
 		}
 	} else
-- 
2.53.0

