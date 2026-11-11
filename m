Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437783;
	b=pQKrLziEeiSBh8szrVkNhkMw+sMgSSDtKqFT9pRa3Mcumbyphbc43K8okoQCWnsmzjFR
	 ed1A852bAg5R7qrubojngOMbYX/3u+GFygXYq8hISL9FbyS8qBqTXLT2c8L7+PfYKZXCa
	 6T2egsJcZCjeMedLEfH3DFb5SulCEh0lGjnf0/nx2GTpH2g05+CpRvJ8RW1FDULi4J7Aj
	 rXLqtTp7vYaEFQGGJB4n7GOliLblLuvVfitto+8LOPN1mzgd/vmI4/Sn1TfUk2jyCAbHj
	 eHtLgIul6rlGhAX/uJoBqkiy52WvzbJ61o7WgZrASkF4DHWJZHN8Ps66cEcqCB8D3LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437783;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cqlClgWe+TsZMjkGITpJjF2G69HmGu/15CL1x+MgOTw=;
	b=yfzpvDYQ318aPizD5jNmkvLZ8/BUvi6LFB74UcANtScrd7kLab9PdsD1vqI6T5kIetiV
	 MSmLVcYD13xGIceDHDg3zPxMZbbRw1c2WHb+WU6aKO7PhliZFro311FNjD6dDhtR25t4o
	 8CADzXqq6S65CWVBlukj1tu8ez17nncNXhDhYCICAWZV219WHvD7ykMYw6O5tvQN3hsEu
	 U0cl7DsJ47D2uCDrY7PxOqVet13KgU3tM+ymeHKINLStjPemtZJoefO+y423FZprtaT0u
	 uv9R4op5QQ1PVXn+2gOYKoxLdS2a1LkFGrfegptBOg7N1SgbGwNW5QhJ63KsfxvHpwA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOF7HgWk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B631606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GOF7HgWk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AAC01F00A05;
	Wed, 11 Nov 2026 22:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437783;
	bh=cqlClgWe+TsZMjkGITpJjF2G69HmGu/15CL1x+MgOTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GOF7HgWkBD65C3EHqYUOGQYZiQB7C8WC6ixJZuu9508kXOfcdGgbQ6g/8hNMuPniX
	 WXYcv1Mo7elzI1pEL76KXrgR4NV8CsMkPZKkArVTcsWj9fR9WnZsHF/+TvXSF3wDiq
	 U8SAttN8+beboYTw48NOSzBAOF0uatyBEXu13CD1ITTVezyWlN+7bX6odiflNfhdkm
	 iqUrsBvms5ncH0Yssvi53PIBh3v6iaYLdDS+bUuBkltgSFQTqjcrRomnc81iRjVB31
	 GMdkT1AoN9xmBH9WsVVEGA2MCisSuAdSnk7DJzRA6zKtzagFSSTYDr9LGNJXX26lfq
	 JG9a+O/ZU2wkA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Chris Mason <mason@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Adam Litke <agl@us.ibm.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rik van Riel <riel@surriel.com>,
	Peter Xu <peterx@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/hugetlb: fix endless write fault on a leftover uffd bit
Date: Wed, 11 Nov 2026 17:56:20 -0500
Message-ID: <20261111225545.346590-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052558-failed-6.12-f61e1cf15fb4@kernel.org>
References: <20261107052558-failed-6.12-f61e1cf15fb4@kernel.org>
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

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit f61e1cf15fb44f9cf89d43d8ef01f926322bb1c4 ]

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
[ sashal: adapted to the existing huge_pte_uffd_wp() and huge_pte_clear_uffd_wp() helper names ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/hugetlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 01b81fdf86f68..d9f43ee4d9bc5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6506,15 +6506,19 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
 		goto out_ptl;
 
 	/* Handle userfault-wp first, before trying to lock more pages */
-	if (userfaultfd_wp(vma) && huge_pte_uffd_wp(huge_ptep_get(mm, vmf.address, vmf.pte)) &&
+	if (huge_pte_uffd_wp(huge_ptep_get(mm, vmf.address, vmf.pte)) &&
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
 		vmf.orig_pte = huge_pte_clear_uffd_wp(vmf.orig_pte);
 		set_huge_pte_at(mm, vmf.address, vmf.pte, vmf.orig_pte,
 				huge_page_size(hstate_vma(vma)));
-- 
2.53.0

