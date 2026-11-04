Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793834083;
	b=tav1ExIACHxKJLnVDPlIHDhPOQtHijlshrlPdUS/lOiuMUqe9T6w2qoAonrKSd00SG81
	 xg+lM4Cisz1c20paQqzOI6JAIn01LjgSResOtestHKS+pLXYQREmtQTBpwr1yr2nE8rAO
	 S3r5GktHFGp/8NCDZD5MbNrkw7VVIVRJmU1U/LcBbdo4jdV/ZNGpG9Ffg0HS6MzjVk98h
	 QgjxABUoYlsecIaC3qbmx6CAUf0OZzbiK9Gbpxlej82bvL1gehPu8SYaxJNloX2dlUI/s
	 MOWF5TfufUMkY101IrTrj2UyEwQb9d3X6JD3eIYuTXdxC7XkMNIOwBdt7Ie5KQXup2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793834083;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+mPBoAFZaI/kXrME1blIrD7m0pkImBMDcD7wGGRHj9M=;
	b=U5Xm1mLq+SHyb7T7kUcsKzGO3mo+f60m6RBrLiNTn/O9MXq/zldBA1Bs0IgJl865GP67
	 5+Ou5i7Fcl+CsfouQjSIKT4jpJ4fkR4iK0Z29QyQhzOTADl3LZAlWyIdXA1S/oRW1VZLa
	 5qWcl9tIeFPQyhIEhpD1yY2uknC0bVqJ4TdKdljiT7vzZX2dQw8cNqXhu9qFiPVRpkr7w
	 c+CHJVOdJWcP2WecEQ5iAUx3TMcY2WOKR5Gme5O2PYPfHZv8JGpLxoQ+b9RbqQUWEXIRn
	 c4WQdE7ZjOYbxgVdS3588PvGRh/Wi7XkDyAqbn5+X72NueP5WhPW4I9AHL3uo6m4Naw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LjdSz0Ud;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5500606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LjdSz0Ud
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A96D1F0093A;
	Wed,  4 Nov 2026 23:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793834082;
	bh=+mPBoAFZaI/kXrME1blIrD7m0pkImBMDcD7wGGRHj9M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LjdSz0UdPEma2jkh9nEG82urMHFp+Ybiyd/j9O2d1L3ogDGqrRtWMInGdf5hFVF5H
	 FSDJEXB9vyNN4bClUHt7WXfxRb05t6WJJenunuM/wJS5/A9Ms7KB9+Ap/RAq9JF3sJ
	 Uj+dbdI6pnOCu0Y1VHkkjpJerSO4IUu+9eOrfy2vWQB5ASPfjsRITk28gAvKzei/mb
	 55IHxnHHMMJGf0+jQ+TdTdDa3u9E3gAz/u1Jmh+UdJPeCWqaAgKATOAl3yAvlR5QK7
	 0VZr0HjxkUvJXctksqUmZWe/GRZtXUYunbClaFzg7w/RC5NkeBmrX4Qj9HTqVCViZj
	 UgmiRz2dOsBYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Vernon Yang <yanglincheng@kylinos.cn>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Barry Song <baohua@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Zach O'Keefe <zokeefe@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm: khugepaged: fix folio is used after folio_put/unlock()
Date: Wed,  4 Nov 2026 18:14:40 -0500
Message-ID: <20261104231424.891478-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110413-cacti-bonded-6534@gregkh>
References: <2026110413-cacti-bonded-6534@gregkh>
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

From: Vernon Yang <yanglincheng@kylinos.cn>

[ Upstream commit 9010383e71e6ce75fcd3c8f87133c8ce6c0e6ab4 ]

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
[ sashal: adjusted collapse_file() declaration context to preserve struct page *tmp instead of struct folio *tmp ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/trace/events/huge_memory.h | 6 +++---
 mm/khugepaged.c                    | 4 +++-
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/trace/events/huge_memory.h b/include/trace/events/huge_memory.h
index 37f2443b3cdb0..a1ac19bab4a2d 100644
--- a/include/trace/events/huge_memory.h
+++ b/include/trace/events/huge_memory.h
@@ -207,10 +207,10 @@ TRACE_EVENT(mm_khugepaged_scan_file,
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
@@ -224,7 +224,7 @@ TRACE_EVENT(mm_khugepaged_collapse_file,
 
 	TP_fast_assign(
 		__entry->mm = mm;
-		__entry->hpfn = new_folio ? folio_pfn(new_folio) : -1;
+		__entry->hpfn = new_pfn;
 		__entry->index = index;
 		__entry->addr = addr;
 		__entry->is_shmem = is_shmem;
diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 42330aeb76386..1f7c0655d8db9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1788,6 +1788,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	struct page *page;
 	struct page *tmp, *dst;
 	struct folio *folio, *new_folio;
+	unsigned long new_pfn = -1;
 	pgoff_t index = 0, end = start + HPAGE_PMD_NR;
 	LIST_HEAD(pagelist);
 	XA_STATE_ORDER(xas, &mapping->i_pages, start, HPAGE_PMD_ORDER);
@@ -1800,6 +1801,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	result = alloc_charge_folio(&new_folio, mm, cc);
 	if (result != SCAN_SUCCEED)
 		goto out;
+	new_pfn = folio_pfn(new_folio);
 
 	mapping_set_update(&xas, mapping);
 
@@ -2207,7 +2209,7 @@ static int collapse_file(struct mm_struct *mm, unsigned long addr,
 	folio_put(new_folio);
 out:
 	VM_BUG_ON(!list_empty(&pagelist));
-	trace_mm_khugepaged_collapse_file(mm, new_folio, index, addr, is_shmem, file, HPAGE_PMD_NR, result);
+	trace_mm_khugepaged_collapse_file(mm, new_pfn, index, addr, is_shmem, file, HPAGE_PMD_NR, result);
 	return result;
 }
 
-- 
2.53.0

