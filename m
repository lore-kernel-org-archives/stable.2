Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793801954;
	b=I1NcYxPwf/ZBREX6r87YWQDitKJBysJK/J7LJezbxEVgAZKIy0tBt8hRWK5jLcylSzeK
	 4rYM32gwAy/qyFx559dAhi6ayhrYAgx8zXV9W3L3jSYc7stLnlKDtQ7gXRS8ZXjCqYdfn
	 Wx7pu42+9fC6uWRb1PS97bfXhHCwd14+oMTZllk3sAIC8TSz+aU0FU00Ccatbz436i+xm
	 h0CgbMnNsRwzejL5hUYZOhO7Glb+EMRj8EfEt8PHTi7RNvnF9xHzaj+BACmsxrzd4YjZu
	 ZwE7q1yXR1bjZ8ZQbtgwWGq6zu28QHUGBbaoDmd9SIJbiaxGCIZMEoq9oj/KS1C+/0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793801954;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Bj/g7o71Zed+1Va5Vai+bkcv41XUcj0kv6daT+lrMpE=;
	b=Jd3tgrjwdJTvqlqElE+s/iiiduY0zE2SjVZf+EA7dbaTLocj7Vi4t2ATTgdGGIIJQqz6
	 ttt8h1EHDIggCROoXnCbw2uR77adyIptbPczX2KtYpJCHPICTYW7c4yvbPqWuV6jktdhR
	 lt1bEzsg+0vtoVDsNdQV6h23X9+/eiBsZ2LpyC8CgmnxCyuRe1UUt2IvY3/xhsUEKBGNp
	 MZePQ83buysCgOH07sIoTOBAHgcyKIKNBpjL0pdypyueAnESsYMggDwTYsJYrxxTemfIx
	 KcxzPtR8r3HniPzZIBcPL7jFuFnBwdCMK7v+QVupnUh51+DmSMdr9mz8VW+SwhJmgVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b="yaJphJ/y";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93E19606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=yaJphJ/y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2ADE1F000C1;
	Wed,  4 Nov 2026 14:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793801954;
	bh=Bj/g7o71Zed+1Va5Vai+bkcv41XUcj0kv6daT+lrMpE=;
	h=Subject:To:Cc:From:Date;
	b=yaJphJ/yPR8jO93JMjkEmppnj5k1kdzj+dBIZpPh08Bw0QW+kAKIAgwHPdQyw8hhp
	 jMyI2pd1GOVzpXs+X1rC2oCzzdCBkauSzhe/t45jsc6dyVG6RGRffSWUKRgRgquDHv
	 SCAQSTw/HJI8iy3ButN9d6ikocvwxBeVTtK0hkCw=
Subject: FAILED: patch "[PATCH] mm: khugepaged: fix folio is used after folio_put/unlock()" failed to apply to 6.6-stable tree
To: yanglincheng@kylinos.cn,akpm@linux-foundation.org,baohua@kernel.org,david@kernel.org,dev.jain@arm.com,lance.yang@linux.dev,ljs@kernel.org,ryan.roberts@arm.com,stable@vger.kernel.org,zokeefe@google.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:19:13 +0100
Message-ID: <2026110413-cacti-bonded-6534@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 9010383e71e6ce75fcd3c8f87133c8ce6c0e6ab4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110413-cacti-bonded-6534@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9010383e71e6ce75fcd3c8f87133c8ce6c0e6ab4 Mon Sep 17 00:00:00 2001
From: Vernon Yang <yanglincheng@kylinos.cn>
Date: Wed, 9 Sep 2026 10:58:03 +0800
Subject: [PATCH] mm: khugepaged: fix folio is used after folio_put/unlock()

On the rollback path, folio_put() has already dropped the last reference
of new_folio.  On the success path, new_folio is already unlocked and can
be freed concurrently.  The trace_mm_khugepaged_collapse_file() is left
with a dangling folio pointer.

So using the folio_pfn() before dropping the reference, closing
use-after-free window.

Link: https://lore.kernel.org/20260909025804.3233645-4-vernon2gm@gmail.com
Fixes: 4c9473e87e75 ("mm/khugepaged: add tracepoint to collapse_file()")
Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Zach O'Keefe <zokeefe@google.com>
Cc: <stable@vger.kernel.org>

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index fa828967e1fb..5fb4d92cfd84 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -211,10 +211,10 @@ TRACE_EVENT(mm_khugepaged_scan_file,
 );
 
 TRACE_EVENT(mm_khugepaged_collapse_file,
-	TP_PROTO(struct mm_struct *mm, struct folio *new_folio, pgoff_t index,
+	TP_PROTO(struct mm_struct *mm, unsigned long new_pfn, pgoff_t index,
 			unsigned long addr, bool is_shmem, struct file *file,
 			int nr, int result),
-	TP_ARGS(mm, new_folio, index, addr, is_shmem, file, nr, result),
+	TP_ARGS(mm, new_pfn, index, addr, is_shmem, file, nr, result),
 	TP_STRUCT__entry(
 		__field(struct mm_struct *, mm)
 		__field(unsigned long, hpfn)
@@ -228,7 +228,7 @@ TRACE_EVENT(mm_khugepaged_collapse_file,
 
 	TP_fast_assign(
 		__entry->mm = mm;
-		__entry->hpfn = new_folio ? folio_pfn(new_folio) : -1;
+		__entry->hpfn = new_pfn;
 		__entry->index = index;
 		__entry->addr = addr;
 		__entry->is_shmem = is_shmem;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 730829947b4c..792166950bba 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2253,6 +2253,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	struct address_space *mapping = file->f_mapping;
 	struct page *dst;
 	struct folio *folio, *tmp, *new_folio;
+	unsigned long new_pfn = -1;
 	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
@@ -2272,6 +2273,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	result = alloc_charge_folio(&new_folio, mm, cc, HPAGE_PMD_ORDER);
 	if (result != SCAN_SUCCEED)
 		goto out;
+	new_pfn = folio_pfn(new_folio);
 
 	mapping_set_update(&xas, mapping);
 
@@ -2675,7 +2677,7 @@ static enum scan_result collapse_file(struct mm_struct *mm, unsigned long addr,
 	folio_put(new_folio);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
-	trace_mm_khugepaged_collapse_file(mm, new_folio, index, addr, is_shmem, file, HPAGE_PMD_NR, result);
+	trace_mm_khugepaged_collapse_file(mm, new_pfn, index, addr, is_shmem, file, HPAGE_PMD_NR, result);
 	return result;
 }
 

