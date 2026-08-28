Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526273242BC
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787878211; cv=none; b=YLZKJz7WSYJ8yi6HoIu36KjANX/Jt3q2rhp++B7S+v4CCpeiy0dYikimxsiYrbBRmnFReupTXb95GfpBAGXt2uWJ6/LnkMU2GeQCNKwaOuK+1w/j7KsIBIbUDcJ4fZQIv8td9dRUeWT9Tny6L3CFR2svcPrg8PYMEvSWUK1ubuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787878211; c=relaxed/simple;
	bh=gHIYHgTe71pxOpV7+og1ksN4v6H+Xfn5LzAVWPmAgyc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=SsH3+8XpRpJHz6nk0JEM5k65o/xmN5NOe1OvlUOj+8RhxNLtC/GAExFY65zsfxJi6hZbrM9kvlwwksbqAFqQaRVp2Zzp0sNd3q0rs8+j3XUSW2NkzjwgmhrWiDXXaH0J2awa4xH5x4hIFSCgN6noQq28ozbcjUnFdo/apWBHQP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U/f0gnrU; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jthoughton.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U/f0gnrU"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc15155cde2so408043a12.2
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 17:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787878209; x=1788483009; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=M+L/jEThU+UMCGGhHnA2GUCWkP7cgtpwQVPowQ/g9e4=;
        b=U/f0gnrUCtU4A2rEEmbap/tVmTsIGep8bO+oUGVUsG1QqSfBLszdIojJkGwiEq/119
         3xzgDqAwcC1hjbMSJfWAPncdj1r/4ZnXzeHAcWDF5AP0bczIZhWn/Ei7sNo0Kj0VdvZr
         1zRKQMHs3BKiRHIP1c0zZrm9oBki+ZVKwhKHLhpcWC7pb0f8xEwKQAc5xuSQTN36YUBZ
         T1iEJZMUmVrsuEeznKWMxYdFVFgWEhc8TZ7P7pN0KSM+hHuTxOg3L7Pdj4f5J57KI7ae
         m6HDw6Qo/sKQsU8QT7yKSpOqEW71QBMZKQjNHiXg4L8kbqbxocaIEmYByqAv9OC9SbXt
         Y8Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787878209; x=1788483009;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M+L/jEThU+UMCGGhHnA2GUCWkP7cgtpwQVPowQ/g9e4=;
        b=f/8TkMoL7W4/tRbBlMWENC4P7GPS6RBJpssYmly5UhanXxeidbZMinVaEC92CZ7DXm
         uFPGw2aq7hhEBUZlAaSe6t7hIVDIxVwac4Cgi5BSX9o4E5O7DKOJyQTt2o5koNyuGPpe
         xeZS3T0/bMtLZANjP2856sMFBajRQ2EIXVEDgfxl02AW9vvk/yjNYJaVp4SoQoWzubIE
         5zjm+5goDPYKmMKHBp0NCo38hwdel4vJawtBpOVn8VmWs2nrWMQ3YvPuKJOXYCMCzZTd
         Fki2BVDaq7Ryv1tHifmdu7/iA4LSydbYmTMbMXS9G+GnUSjwEh/BwCMzA5WFbNr9MIW0
         pgnw==
X-Forwarded-Encrypted: i=1; AHgh+Roxx9K5lnSYZcoCJgi5vPuliU6o8EOuHb1qi4lQBvRZLjMK94ze/fvibm++TB0PUSEjT+cLC3s=@vger.kernel.org
X-Gm-Message-State: AFuF++mEKhtwHErL957XUEkjWc0j62Jp0N4ifNhCus/wRIMdsmY5QgAi
	Skb3A68xi7mPIgjef3hx8ndTLmHbDdlUcl/8vEgCmo/msxxBnSPHwIe4pEOhD/EFnRZNyV0aktT
	RZNGHfRu6SD/pSFPWuIGVIQ==
X-Received: from pfaz21.prod.google.com ([2002:aa7:91d5:0:b0:848:7fd6:7dec])
 (user=jthoughton job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:13a2:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-8562953e9d8mr4642983b3a.1.1787878208961;
 Thu, 27 Aug 2026 17:50:08 -0700 (PDT)
Date: Fri, 28 Aug 2026 00:50:04 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828005004.2870750-1-jthoughton@google.com>
Subject: [PATCH] mm/khugepaged: Don't collapse uffd-minor-registered VMAs
From: James Houghton <jthoughton@google.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, liam@infradead.org, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Yang Shi <shy828301@gmail.com>, zokeefe@google.com, 
	hughd@google.com, Kiryl Shutsemau <kas@kernel.org>, jthoughton@google.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Userfaultfd minor faults provides userspace with the ability to manually
install PTEs with UFFDIO_CONTINUE. Right now, khugepaged collapse can
map holes in the VMA when a naturally-aligned THP is present without
explicit action from userspace.

This is a problem, as it bypasses userfaultfd minor faults that
userspace is expecting to handle.

If userspace implements post-copy live migration using userfaultfd minor
faults, this situation is currently possible:
1. The VMA for guest memory is userfaultfd-minor-registered and nothing
   is mapped in the page tables.
2. A stale copy of a page is present in a naturally-aligned THP (from
   pre-copy live migration).
3. khugepaged collapses the mapping of the THP, installs a PMD.
4. The VM now has access to the stale contents => VM is broken.
5. After installing the correct contents, userspace attempts to map the
   page with UFFDIO_CONTINUE; it gets EEXIST, indicating that something
   unexpectedly mapped the page.

The naturally-aligned THP case is the only case where this is a problem.
khugepaged otherwise requires all PTEs to be present for
userfaultfd-registered VMAs (i.e., max none PTEs is 0), which is
correct. This check is essentially bypassed for naturally-aligned THPs.

To deal with this issue, completely disallow collapsing in
userfaultfd-minor-registered VMAs. This is slightly pessimistic; it
would be nice to allow MADV_COLLAPSE to work if all PTEs are in fact
present, but that seems more complex than it is worth.

Fixes: 58ac9a8993a1 ("mm/khugepaged: attempt to map file/shmem-backed pte-mapped THPs by pmds")
Cc: <stable@vger.kernel.org> # 6.1
Signed-off-by: James Houghton <jthoughton@google.com>
---
This was caught with manual review while diagnosing a related issue
that came up with in Google's live migration testing.

I've uploaded a mostly-AI-generated reproducer here[1]. As long as
/sys/kernel/mm/transparent_hugepage/shmem_enabled is not set to 'deny',
the repro should work.

[1] https://gist.github.com/48ca/d399bf534158e80241fb4937ef1ff664
---
 mm/khugepaged.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index b237f6e7662a..66f956d3dd67 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -2804,6 +2804,15 @@ static enum scan_result collapse_single_pmd(unsigned long addr,
 		goto end;
 	}
 
+	/*
+	 * Userfaultfd-minor-registered VMAs should not be collapsed, as
+	 * userspace is expecting to explicitly install PTEs.
+	 */
+	if (userfaultfd_minor(vma)) {
+		result = SCAN_PTE_UFFD;
+		goto end;
+	}
+
 	file = get_file(vma->vm_file);
 	pgoff = linear_page_index(vma, addr);
 

base-commit: 26260251022fbc2f248a3d747a9b2b961b18d2d8
-- 
2.55.0.897.gb25b4bd76c-goog

