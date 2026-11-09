Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227558;
	b=HIx1p/ZpWStr6QBQKDmGAL+WqwLICbEWEQ5Le7OPFCiNg2iLUWd5M2Ecj3SZEnXdc8kh
	 v7umnngxrCjzgoYYKiV12dZ2swPeg2gAjoJNyycAQ7rA3Ywb8TVrzCWT7eV+9McFVKRBD
	 KLqZF4stHz+uo04qEdB651cwxH3HZbcU3NBCBg5RbbIWN3OTz3VORFYlRtTi5kYsAiILy
	 IElZBFJsPGD2Yq68u+g33/euTMcpx0jFHS5b9BC8qAiIgddVTcdwSxJkWGHRX/3kTSb8A
	 TmUssAc1DpZPHogFddjPBefMNLWb1BIk9l0JRjVYNi2MF7tX7SdzFH2BcTDfWP2LafA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227558;
	h=DMARC-Filter:Received:Received:DKIM-Signature:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=FMMjg5Tb5QutiWvyksGb2lNhCLSGiUBKibO1R6YfCBU=;
	b=vgtK8Yb1t7Um0Du22ZChCQuSvmd14rNM0PEWoVGi3lo0LNjXuNdTIzgIlomn7rC0Rfzj
	 ASmCbb9RWtUuL+ZKl8I7jndr5rbTXG9h6XkRJdQtNyoqvcl7Q2HjsuWhwJaWzP6mUcBy/
	 L31RVS8jya+FjWKbH3cg3U4xgGIOmVCb7jMFHA/rE4Cz+dBdhDdza5vDgdlFSxWvZwajr
	 +MFKaecTzPAZqnDYRdtkMBIC85QKnMeiR2pYI9kgHPL6rk3SQ4h7LtUhXKkao2LNbbbhs
	 U4KXXfgm6Jqd2XBtjc+t7KIZh3y5NJFhzbxk9snAIjhIKXDfANfKvOwd2J4pB3HeaUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nt6X1uQl;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0382608360B;
	Mon,  9 Nov 2026 12:32:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0382608360B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=nt6X1uQl
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29CA91576;
	Mon,  9 Nov 2026 04:32:33 -0800 (PST)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D8ED3F632;
	Mon,  9 Nov 2026 04:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794227556; bh=wo2RMPDExcAkwy96P2D0uHY6dqGY6uIQRPmpWz0sV0c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nt6X1uQlJNrlFb1A1X8e0d4wOQNnPCq9YA08w2E8SDR3QXzGBDnoBba1cpTgsjmyz
	 npjSQLJXsnVyqkY5JQw87sMGb+MSa417Ja7lIYVXl/x+cZBHYEfNMYF8U+u1k7GJ7y
	 DQjAjCEg2EqIi9cYEJpv0jaLkxj2YnukULBTlWEs=
From: Yeoreum Yun <yeoreum.yun@arm.com>
Date: Mon, 09 Nov 2026 12:32:25 +0000
Subject: [PATCH v3 1/6] mm: khugepaged: ignore MADV_HUGEPAGE for shadow
 stacks
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261109-refactor_gup_fast-v3-1-2aaef02df0e1@arm.com>
References: <20261109-refactor_gup_fast-v3-0-2aaef02df0e1@arm.com>
In-Reply-To: <20261109-refactor_gup_fast-v3-0-2aaef02df0e1@arm.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Peter Xu <peterx@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Rik van Riel <riel@surriel.com>, 
 Yuan-Hao Hsu <aa9736195201@gmail.com>, Yeoreum Yun <yeoreum.yun@arm.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2250; i=yeoreum.yun@arm.com;
 h=from:subject:message-id; bh=wo2RMPDExcAkwy96P2D0uHY6dqGY6uIQRPmpWz0sV0c=;
 b=owEB7QES/pANAwAKAW3Vw9FaxTEzAcsmYgBq8b1c1s12W6hVfBJ0af2H4ECDILxl5SXY0xgRk
 dMWbEcjOCqJAbMEAAEKAB0WIQQtg+CS3QUzuFh1pJ1t1cPRWsUxMwUCavG9XAAKCRBt1cPRWsUx
 M5cCC/4whLG62aLd5wDKkGxX45q5wDXTgLQzStSXiohOrwsj5ie+SOSiXuQ49zjifts5Jsb1vzu
 GopB+twzLQxnHHdLg0EcWA3qQeihfZ2jgZ008vAaetQavRt7ElV+hQnaL4b3IU+k5QR2oJJdyaU
 mOvmBwHaB71miYhWLHW/SjFSg4Q1lgMeIct4w6rcuDQfvJJZ4PlTi1Cf4kBEGpef8OoWD7yJf7w
 Oxt+p43GHsCgXiNlY5fyLElkAKbpyeNy6mJUoCMyc4aM1tWdN5p5SOXbhmO+pylxqG6YV5q0hvv
 gkjGORrbcj39v+ipCRtL7+64ljESlq1uVcYAKNLwa5sgOnuc4m6vzOlzC/nbhaCL/LRQYU95DOh
 Gds4xFEgQKNo1QxIGou8OkWn6vNlsV0AHd4rzYfx+KAGEQlvJbnZ5W5B1r7tYdnzu6B3PEnr6F7
 aUaMwK74VC6idueVz2sP02KRWkGKL4SZNlSCXzVBHow6e/x+68N0WCDksj4n5IG51mgPw=
X-Developer-Key: i=yeoreum.yun@arm.com; a=openpgp;
 fpr=2D83E092DD0533B85875A49D6DD5C3D15AC53133

commit 3efb9800557b ("mm: do not map the shadow stack as THP") makes
shadow stack mappings default to VM_NOHUGEPAGE. However, userspace can
still clear this flag and set VM_HUGEPAGE through madvise().

Allowing large folios in x86 shadow stacks exposes a limitation in
folio_pte_batch_flags(). For example:

  1. create a shadow stack mapping.
  2. apply MADV_HUGEPAGE and populate the mapping with a PTE-mapped
     large folio.
  3. apply MADV_DONTFORK to the first base page of that folio.
  4. call fork().

In the parent, the first page remains writable and anonymous-exclusive,
while the remaining pages shared with the child become write-protected
and lose PageAnonExclusive(). These pages can still belong to the same
large folio.

On x86, writable shadow-stack PTEs have _PAGE_RW clear and _PAGE_DIRTY
set. Write-protected PTEs have both bits clear, with the dirty state
preserved in _PAGE_SAVED_DIRTY.

When FPB_RESPECT_WRITE is set without FPB_RESPECT_DIRTY,
folio_pte_batch_flags() normalizes PTEs using pte_mkclean(), which clears
both dirty bits. This loses the distinction between writable
shadow-stack PTEs and write-protected PTEs, allowing them to be grouped
into the same batch. GUP-fast can encounter such a batch when walking
across the VMA boundary created by MADV_DONTFORK.

Since there is no practical use-case shadow stack with large folio,
ignore MADV_HUGEPAGE for shadow stack mappings, preserving their
VM_NOHUGEPAGE setting and preventing large-folio allocation.

Fixes: 3efb9800557b ("mm: do not map the shadow stack as THP")
Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
Cc: <stable@vger.kernel.org>
---
 mm/khugepaged.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 40fad28c52f6f..51ec043fa26c3 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -367,6 +367,9 @@ int hugepage_madvise(struct vm_area_struct *vma,
 {
 	switch (advice) {
 	case MADV_HUGEPAGE:
+		/* PTE batching doesn't work reliably. */
+		if (vma_test_single_mask(vma, VMA_SHADOW_STACK))
+			break;
 		*vm_flags &= ~VM_NOHUGEPAGE;
 		*vm_flags |= VM_HUGEPAGE;
 		break;

-- 
2.43.0

