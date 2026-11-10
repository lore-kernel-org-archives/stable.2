Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272976;
	b=bmf0/gaNpt4LqBFftvzaFi/MsmdW8d/AcNUgUQfvClKX/6KJh6J6IP7pGL2EtOijgLne
	 5UL8OJHCef1RmkrAJU42/N0ZztcuAW+lvG0ZSK+/QRImNv44STSeGNuAPhB5g6MCHQqdn
	 6gfc/jAf7cm52tR36i13SAmJftOiWJt7qLViSZ7KLnCnqB+4yxXLAgSwNvICK3GfeB8HG
	 X16iavggOhpIQywiAtO72XML+M7s3HmeLggWDT9LN6/51H7LHXYgQSD+6x4r40T2wbhiB
	 a+RfE0zAQugBlx9scmxUZZst+SOYXWBEmg03iuh5XsqVz3IJbZpJPK4RDsDwwbDGpJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272976;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TWQrRjtS0vRGLH//kSfJnCtMCyQeLkKNcf6q45TsRk4=;
	b=oU1M2S88uBfDDq2AVh2LVXY7C2eezD/+mxb7+RqJmvi4yMAs96jd3bpPRUhlqIW7s7W/
	 XwwP9YJZWaxNeFip7t7qUGACBdmDn9VrbLN22na1CpEhZSHfgtGTbP8JmAS0m5d9M86F1
	 VnPYlNf3GxesyaMfQ3di7nV707pwETHOPehaL1cvSq2fEH3YjJyTtLf/4zKIslEu76gYf
	 fwRrEZwtwwm9xDIr9X1dCZVnaVAZxa4+2Qw0NekE+KzGYCP+yuq8vMWq7+x38mNPtZ/Zm
	 O0djNzO0YePNsmRewunXr3lwvPbdCLbLmqZ7tMkxjncNA2S3KHnOjyF0hr5KxVw5BTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ns7Y3ORG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2059D606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ns7Y3ORG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44EA31F0089F;
	Tue, 10 Nov 2026 01:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272976;
	bh=TWQrRjtS0vRGLH//kSfJnCtMCyQeLkKNcf6q45TsRk4=;
	h=From:To:Cc:Subject:Date;
	b=Ns7Y3ORGqviTa3w+tpRSYDltNhjrSksmP8LhRtejNHp+wu9LkTn2A3alRMJuGnxia
	 4Ov19odedeny/1mLe0Ev+6o/gKqCefgNSRBXZjki4kJr99QgkumTXsrBPHa9NF5bCu
	 fO95jgz+swA9pKhIkl4aQPCQFvAu14KHXdDTQFLisU1LTT5a+iEM20RI2MxsW6+SIS
	 z8qHLqa3IZv06mdY2x+7sNQ2X0wL71WAttexv7FrP62UcPw6iYuUXW+MNR1BsMArtw
	 BttNiTIl8XqdegIhFpyRJ1fPgOVhLH5kfKE2XQhPNJ/cjwJjNtFvShT+vO5cwqKOLq
	 Dt28E352i8OnQ==
From: Sasha Levin <sashal@kernel.org>
To: lance.yang@linux.dev,
	pfalcato@suse.de,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] khugepaged: fix readahead lock inversion in collapse_file()" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:09:33 -0500
Message-ID: <20261109200933-failed-6.12-eadce52a9ef6@kernel.org>
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
git cherry-pick -x eadce52a9ef657d561b3e76c9b5f178bd99735f5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200933-failed-6.12-eadce52a9ef6@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From eadce52a9ef657d561b3e76c9b5f178bd99735f5 Mon Sep 17 00:00:00 2001
From: Lance Yang <lance.yang@linux.dev>
Date: Mon, 26 Oct 2026 23:20:13 +0800
Subject: [PATCH] khugepaged: fix readahead lock inversion in collapse_file()

collapse_file() can call page_cache_sync_readahead() while still holding
source folios locked. If truncate holds mapping->invalidate_lock
exclusively and waits for one of those folios, readahead waits for
invalidate_lock and neither side can make progress.

We need to release those folio locks before starting readahead. On a page
cache miss, roll back first, populate the collapse range, and retry once.
Doing readahead after rollback avoids an extra pass when all folios are
already present. If another miss occurs on retry, give up rather than keep
retrying while truncate or reclaim removes folios.

Keep page_cache_sync_readahead() and wait for read I/O with
filemap_lock_folio(), releasing each folio before moving to the next. The
existing uptodate check during collapse still handles read errors.

Shmem uses shmem_get_folio() for swapin and fallocated folios without
taking mapping->invalidate_lock, so it is unaffected.

Reported-by: syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=16bf7cd0ebeb1de93aa5
Fixes: 730633f0b7f9 ("mm: Protect operations adding pages to page cache with invalidate_lock")
Cc: stable@vger.kernel.org
Signed-off-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Link: https://patch.msgid.link/20261026152013.10511-1-lance.yang@linux.dev
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/khugepaged.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index ce794d9760a87..6d5a44cf3a00b 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2240,6 +2240,8 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
 	enum scan_result result = SCAN_SUCCEED;
 	int nr_none = 0;
+	bool do_readahead = false;
+	bool readahead_done = false;
 
 	/*
 	 * MADV_COLLAPSE ignores shmem huge config, so do not check shmem
@@ -2257,6 +2259,10 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 
 	mapping_set_update(&xas, mapping);
 
+retry:
+	result = SCAN_SUCCEED;
+	do_readahead = false;
+	xas_set_order(&xas, start, HPAGE_PMD_ORDER);
 	__folio_set_locked(new_folio);
 	if (is_shmem)
 		__folio_set_swapbacked(new_folio);
@@ -2321,17 +2327,9 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 			}
 		} else {	/* !is_shmem */
 			if (!folio || xa_is_value(folio)) {
-				xas_unlock_irq(&xas);
-				page_cache_sync_readahead(mapping, &file->f_ra,
-							  file, index,
-							  end - index);
-				/* drain lru cache to help folio_isolate_lru() */
-				lru_add_drain();
-				folio = filemap_lock_folio(mapping, index);
-				if (IS_ERR(folio)) {
-					result = SCAN_FAIL;
-					goto xa_unlocked;
-				}
+				do_readahead = !readahead_done;
+				result = SCAN_FAIL;
+				goto xa_locked;
 			} else if (folio_test_dirty(folio)) {
 				/*
 				 * This page is dirty because it hasn't
@@ -2654,6 +2652,30 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	new_folio->mapping = NULL;
 
 	folio_unlock(new_folio);
+
+	/* Readahead may take invalidate_lock; source folios are unlocked. */
+	if (do_readahead) {
+		for (index = start; index < end;) {
+			folio = filemap_lock_folio(mapping, index);
+			if (IS_ERR(folio)) {
+				page_cache_sync_readahead(mapping, &file->f_ra,
+							  file, index, end - index);
+				folio = filemap_lock_folio(mapping, index);
+				if (IS_ERR(folio)) {
+					result = SCAN_FAIL;
+					goto out_put;
+				}
+			}
+			index = folio_next_index(folio);
+			folio_unlock(folio);
+			folio_put(folio);
+		}
+		/* Drain the local LRU batch before retrying isolation. */
+		lru_add_drain();
+		readahead_done = true;
+		goto retry;
+	}
+out_put:
 	folio_put(new_folio);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
-- 
2.53.0




