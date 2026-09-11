Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CA12DA759
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 01:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789089190; cv=none; b=kJQxZb3uDo5ck+3V9pmLMSi19BassaxoCnVRSgsITIr8I3OBGfAT2Mggzlt/AFciYscbDH64eIAlYD+sjxhj3zdxz8Su+mKFaUhTm1a6KWtjyx0NpQC7I5v2GPHlty3c6VKObSlpS6PKYBARJKBY4eS4GYmydfLtJxLq0t8eMQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789089190; c=relaxed/simple;
	bh=yVO8IFMSbmR38ZYo3zEfQ/+/ZEmhT9jbyZdM5x4RnfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rc5QKuJJ9F0PCgeY6GHiyNY//Hb2ZNhA7jLlZRcLzZ1quLybhLXlTZzwoZvVVyNl+/PD68gcUfRh4rvJZGX7hWZ3VCbs95ifgrcohbDI4EoVEk9kvmq5trz6DwIU9SERgB+kbjGUFhsP03ZDFIbLzW42XKWra3TfTrxE9Q2Egrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MIq6GJZd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MIq6GJZd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3536D1F000FF;
	Fri, 11 Sep 2026 01:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789089188;
	bh=lg7qgUszhR+c+9TpDCszMm8s3iQjCaDGXmOjFN00AEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MIq6GJZd7kFctJaOGd46sjDXaT/RTZB17woDfLc+TFxWj8jXIB+v/T0Bmjs5d5z5J
	 m0wUH0y7mZgeaf1v1j6bFOXngvg+EvbhbazAD2pqDwTMbYyyAnM6kxe2IHjCV+bt3l
	 4CMaUXLFfJz9l3uYFb0Gb06WTox8lK3mYtvfP8OgjHDdynAB3+pRlf1Frraid2LXgQ
	 x328djfolrk3bvtdooXLhjxGoT+vGB83HflKdIfZ2AFewmrQ9ItHeNJ42KZoIz7hd/
	 9O2r5o1MBi0yQSR5scFeNz0lwAfleLN2EZRpeESyYNIayjuQkMCEuvKLv02aIGbvFF
	 RcJfIH5jREH+A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baolin Wang <baolin.wang@linux.alibaba.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	Barry Song <baohua@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Dev Jain <dev.jain@arm.com>,
	Hugh Dickins <hughd@google.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm: fix incorrect vm_flags usage when checking allowable orders for tmpfs
Date: Thu, 10 Sep 2026 21:13:05 -0400
Message-ID: <20260911011305.4032753-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090905-parole-radiated-b379@gregkh>
References: <2026090905-parole-radiated-b379@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Baolin Wang <baolin.wang@linux.alibaba.com>

[ Upstream commit 2fd4e7693674b17807a6d082feb01a3fbf86f5f8 ]

Lance reported that when nothing else causes the mm to be considered for
khugepaged collapse, an MADV_HUGEPAGE-advised tmpfs VMA alone does not
trigger scanning.

After commit 6beeab870e70 ("mm: shmem: move shmem_huge_global_enabled()
into shmem_allowable_huge_orders()"), the shmem/tmpfs allowable order
check reads vma->flags directly.  However, when MADV_HUGEPAGE is handled,
khugepaged_enter_vma() is called before the VMA's flags have been updated,
so the check uses stale flags and incorrectly rejects the VMA for
collapse.  As a result, khugepaged does not collapse the tmpfs file into
PMD order in time.

Fix this by calling khugepaged_enter_vma() with the new VMA flags in
madvise_update_vma().  Meanwhile we can remove the khugepaged_enter_vma()
in hugepage_madvise().

Link: https://lore.kernel.org/7d5b5eb27be798f89d563b06254c947ff53db0b2.1787020910.git.baolin.wang@linux.alibaba.com
Fixes: 6beeab870e70 ("mm: shmem: move shmem_huge_global_enabled() into shmem_allowable_huge_orders()")
Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reported-by: Lance Yang <lance.yang@linux.dev>
Closes: https://lore.kernel.org/all/20260815181632.21453-1-lance.yang@linux.dev/
Suggested-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Cc: Barry Song <baohua@kernel.org>
Cc: David Hildenbrand <david@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
[ adapted newer VMA flag helpers to the branch’s legacy new_flags bitmask API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/khugepaged.c | 6 ------
 mm/madvise.c    | 8 ++++++++
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a6b2c7d7d73b6..84bacd7e19620 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -369,12 +369,6 @@ int hugepage_madvise(struct vm_area_struct *vma,
 #endif
 		*vm_flags &= ~VM_NOHUGEPAGE;
 		*vm_flags |= VM_HUGEPAGE;
-		/*
-		 * If the vma become good for khugepaged to scan,
-		 * register it here without waiting a page fault that
-		 * may not happen any time soon.
-		 */
-		khugepaged_enter_vma(vma, *vm_flags);
 		break;
 	case MADV_NOHUGEPAGE:
 		*vm_flags &= ~VM_HUGEPAGE;
diff --git a/mm/madvise.c b/mm/madvise.c
index d2b315993a1c0..4abc466d37505 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -158,6 +158,14 @@ static int madvise_update_vma(struct vm_area_struct *vma,
 	/* vm_flags is protected by the mmap_lock held in write mode. */
 	vma_start_write(vma);
 	vm_flags_reset(vma, new_flags);
+	/*
+	 * If the vma become good for khugepaged to scan,
+	 * register it here without waiting a page fault that
+	 * may not happen any time soon.
+	 */
+	if (new_flags & VM_HUGEPAGE)
+		khugepaged_enter_vma(vma, new_flags);
+
 	if (!vma->vm_file || vma_is_anon_shmem(vma)) {
 		error = replace_anon_vma_name(vma, anon_name);
 		if (error)
-- 
2.53.0

