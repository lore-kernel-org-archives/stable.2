Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047163;
	b=jxM9hnljo+s6tJRirOxnSzRMpVbnDiROsR3kMY5abvuf0b2lKs2YCXmv3BiYnHn1h6Uy
	 DbfGkKcVlPKaIc4fl5vEBk5UtP/2yXGewJe4NrYiKoL7wqbYwVSzidh2GJ5hBILeu3/Of
	 4CVxahDTiNSUytqcOq265g6en4r48VjMA2hZ7gK50syqofY9FE9G/uJ9MYF5VKxudJi94
	 TG1Iguz8a9E+wEotXm4Pm8aN56rbgW55V4CNsxRCXJKP3jFPo+3sIbTTJn+iSpG7+K340
	 HZ2Ot4P3CT1pD4mzkS0PDF1ee8UKGpCtbsXFTvWhU+WbCGpVlYjlYVaJ9U6N4g6PfJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047163;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ltG0rHuwdQb9VWgqOlhZHriNSnUsFWPK6Y5h8myK5kM=;
	b=WtpCqdkhzVOjlDD2UCZ082eYCjFv0igbi/PJ386LOaKTO0RwnBaj0SwR7RE7CyOH6T2i
	 ggKfUuJirK+1Bo2eIv6HDju33GD9QVK3KaEqSyP5mkd4jp0zQqXm1P/uC14GBTns25U/t
	 cJ3/fA7bflO+4A+iNmeNPe/JZP4Q87WEEY62GDW8t5ntPVTLvzNuuZTwbP8hY7jl6ZjTM
	 ALeodpieZiFU4Okgx/AkSGZZXaAx7leF3OW/27ORxXpd15Llhso9g5SnFgY8PwXFfX2aE
	 YA0iAZvLT2q0sPsvBE+b6y0Jh/nc2LgiGf/z/s7RWnpL3Joy5oTSi+hsBUdFjXqL4Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aqiwNS7K;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8FD606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aqiwNS7K
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0553A1F008A4;
	Sat,  7 Nov 2026 10:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047162;
	bh=ltG0rHuwdQb9VWgqOlhZHriNSnUsFWPK6Y5h8myK5kM=;
	h=From:To:Cc:Subject:Date;
	b=aqiwNS7KQjTylXjdXRadHgPKar7BX6B+Q8emSZ1KqlBi5/8xDjSj+rOZBYUhTCqIl
	 ngh1aNl3Pz+91HmJUdoCA5LK2ScCyBLG1N5aLSNLLd5Z2TnfRTVUDI+cBUfHIrb7KG
	 o4RyRS449OR398CPjjPmO8y9Qwui977GXkEZIQnAthP6seQwho3VZEMdzf0tWzdXmT
	 LpvbTi+CisapdXUWPxoK0hnJ9P2qYe07Ql+dwct3iPegEQ17ugLPNWkq12UE49TCRS
	 VlZyF9npDQI7TN4oA71eHMk2VgLc2XQyT8RKGyTmTM44JN7ql3adxJleW4R210JKxu
	 QGb0FzRVD1rNw==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	david@kernel.org,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	mason@kernel.org,
	ljs@kernel.org,
	lance.yang@linux.dev,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	muchun.song@linux.dev,
	osalvador@suse.de,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	agl@us.ibm.com,
	mgorman@techsingularity.net,
	riel@surriel.com,
	peterx@redhat.com,
	kas@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/hugetlb: fix endless write fault on a leftover uffd bit" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:25:58 -0500
Message-ID: <20261107052558-failed-6.12-f61e1cf15fb4@kernel.org>
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
git cherry-pick -x f61e1cf15fb44f9cf89d43d8ef01f926322bb1c4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052558-failed-6.12-f61e1cf15fb4@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f61e1cf15fb44f9cf89d43d8ef01f926322bb1c4 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 15 Oct 2026 18:07:12 +0200
Subject: [PATCH] mm/hugetlb: fix endless write fault on a leftover uffd bit

hugetlb_fault() resolves the uffd bit on a write fault only if the VMA is
registered for userfaultfd write protection, and hugetlb_wp() bails out
for any entry with the uffd bit set assuming hugetlb_fault() has already
resolved it.

When a read-only hugetlb entry with the uffd bit set is mapped in a VMA
that is not registered for uffd-wp, a write fault to it never makes
progress. If the access comes from the kernel, e.g. read(2) from
/dev/zero into such page, the task spins in the page fault handler,
ignores SIGKILL and keeps holding the locks taken by the system call.

Such entries should not exist, but an unprivileged user can create them,
for example with MADV_DONTNEED of a page protected with UFFDIO_RWPROTECT
or with UFFDIO_COPY in MODE_WP racing with UFFDIO_UNREGISTER.

Clear the uffd bit when the VMA is not registered for uffd-wp and let the
fault proceed to hugetlb_wp(), like do_wp_page() does for regular pages.

Note that a FOLL_FORCE write to a page protected with UFFDIO_RWPROTECT in
a private VMA that was made PROT_NONE now drops the RWP protection of
that page.

Original fix generated by an LLM and sent in private by Josef.

[rppt@kernel.org: massage commit message]
[david@kernel.org: convert comment into a TODO]
Link: https://lore.kernel.org/20261015-urgent_fixes-v1-6-42796911043b@kernel.org
Fixes: 60d5b473d61b ("mm/hugetlb: fix uffd wr-protection for CoW optimization path")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Chris Mason <mason@kernel.org>
Acked-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Adam Litke <agl@us.ibm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: <stable@vger.kernel.org>
---
 mm/hugetlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 4a7c52802cde5..d3adafbea160b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6226,15 +6226,19 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_ptl;
 
 	/* Handle userfault-wp first, before trying to lock more pages */
-	if (userfaultfd_wp(vma) && huge_pte_uffd(huge_ptep_get(mm, vmf.address, vmf.pte)) &&
+	if (huge_pte_uffd(huge_ptep_get(mm, vmf.address, vmf.pte)) &&
 	    (flags & FAULT_FLAG_WRITE) && !huge_pte_write(vmf.orig_pte)) {
-		if (!userfaultfd_wp_async(vma)) {
+		if (userfaultfd_wp(vma) && !userfaultfd_wp_async(vma)) {
 			spin_unlock(vmf.ptl);
 			hugetlb_vma_unlock_read(vma);
 			mutex_unlock(&hugetlb_fault_mutex_table[hash]);
 			return handle_userfault(&vmf, VM_UFFD_WP);
 		}
 
+		/*
+		 * TODO: fix all cases where uffd PTE bits remain in VMAs that
+		 * are no longer registered with uffd.
+		 */
 		vmf.orig_pte = huge_pte_clear_uffd(vmf.orig_pte);
 		set_huge_pte_at(mm, vmf.address, vmf.pte, vmf.orig_pte,
 				huge_page_size(hstate_vma(vma)));
-- 
2.53.0




