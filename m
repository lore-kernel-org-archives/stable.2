Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046188;
	b=CSrZd2yBUC/5B9JksxC0Bob1a08uaxW2bZN5/gx7yROGCsWkdGKomcHM2PAWhFtWTcb5
	 K0GvHgf24udVmAJsrA3s9T+WKSU9DlxTW0uLVRwJGwk0sd4R0iJ3Cf45CpG3TBNANOK4S
	 eHtFuC11Zr5E4DD0iqweYZEUapidNVXMABEuRMlVvQcKz+MwLqtLgqKKTKt1jekKEefvF
	 NWtyOHDRdDmtUT9T/JUTgcKYYD1VrGkjUPIecMMWUpnSWbAlytoasgYL9w8xRa+q997Gy
	 ou1EXcbSsSZGNR3EJX4JyrSWKn1ZrqHsTChm3kGjoQEdzG1UCTOtxpT/PjYW3TUL7pQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046188;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EcnXpgEdDgLdS4wZfMZkQ//fmr/HAufPekfjJBddUIk=;
	b=p/nTfWILJXN8+jZ5XUcJcJNiCOiuPfhy/xt6Gp9015ohlDC92jyd1T+2HhZfTmGyL/TV
	 xMbblv7WFLilEYJJYIaAjSJ47LkwsIHFROAcMY2XSVUxybLuq78zRQGtOHJiJdIDU9u+L
	 zv1gHceSm/q2mUDgKlwlFbilcWpFaZWVVvEYLL95gr5Qo//TNkKGVjATOI1l2AoZZ7mNC
	 Ypfwii/u2TwcsJAdtH5VMJPhUK3ksporLcbk5DeZ6U0lFcwi73svuIAeCwrYeLi4cc5iu
	 5d9ERyAS0GltbPfa8KjNZeeKN3ZXbIird3Io5XSZIxxJk4H5GiBd6C9KP99RkKB30eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5Bb8BwS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B406606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5Bb8BwS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F581F0089F;
	Sat,  7 Nov 2026 10:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046188;
	bh=EcnXpgEdDgLdS4wZfMZkQ//fmr/HAufPekfjJBddUIk=;
	h=From:To:Cc:Subject:Date;
	b=W5Bb8BwSdezo5TMERnziNNIxiiHqAMMZ9rNyuxNOH2gke1vUGpWXxiXC4sXP3t9eb
	 ibnaJ6oqWVnMOiu/mg2Oq935eCvRyOz3CLMuFiIoKHQOXGyjO2WpY/aNNrHhhWgd6F
	 LgPBFihcQrDa+E/VEH3X3wG8XMyvdDXQWHPIaOtDd9nCD9Dpc6wf4meuSdjckrVvsW
	 5EOCddcGA9MBTeVMLfv88nQRL8PnYulCFhzv1cuk95HQkiB6cUaqBnjhLsZv+YhgW3
	 DK7SEbEReT6M4mL3XEzLrVBPnoUMiu/J6Az07SFBXMQFvz3dY3EE1Xty0j5CCvpQWJ
	 8eH7S9c47pLjA==
From: Sasha Levin <sashal@kernel.org>
To: gourry@gourry.net,
	akpm@linux-foundation.org,
	sashiko-bot@kernel.org,
	ljs@kernel.org,
	david@kernel.org,
	ziy@nvidia.com,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	joshua.hahnjy@gmail.com,
	rakie.kim@sk.com,
	ying.huang@linux.alibaba.com,
	peterx@redhat.com,
	jgg@ziepe.ca
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/madvise: use vm_normal_folio_pmd() in cold/pageout PMD range" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:09:45 -0500
Message-ID: <20261107050945-failed-6.18-0bd719cb607e@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 0bd719cb607ef14bcd554e044bbd80dd901b9996
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050945-failed-6.18-0bd719cb607e@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 0bd719cb607ef14bcd554e044bbd80dd901b9996 Mon Sep 17 00:00:00 2001
From: Gregory Price <gourry@gourry.net>
Date: Sat, 26 Sep 2026 06:51:10 -0400
Subject: [PATCH] mm/madvise: use vm_normal_folio_pmd() in cold/pageout PMD
 range

mmap a VM_MIXEDMAP region whose ->huge_fault installs a PMD through
vmf_insert_pfn_pmd() - mshv_vtl_low does this, and needs CAP_SYS_ADMIN
to open - then:

  madvise(p, PMD_SIZE, MADV_PAGEOUT);

With a stand-in module for the driver:

  BUG: unable to handle page fault for address: fffff587c0000008
  RIP: 0010:madvise_cold_or_pageout_pte_range+0x410/0x9b0
   walk_pgd_range+0x52b/0xaf0
   __walk_page_range+0x6a/0x1d0
   walk_page_range_vma_unsafe+0x8e/0x120
   madvise_pageout+0xb2/0x180
   madvise_vma_behavior+0x46b/0xa90
   do_madvise+0x108/0x190
   __x64_sys_madvise+0x26/0x30

Nothing validates the pfn on the way in:

  can_madv_lru_vma()     rejects VM_PFNMAP, but not VM_MIXEDMAP
  can_fault()            *pfn = vmf->pgoff & ~(mask >> PAGE_SHIFT);
  vmf_insert_pfn_pmd()   no pfn_valid() check
  pmd_folio()            pfn_to_page() -> unpopulated vmemmap

Even with a valid pfn the path is wrong.  The mapping carries no rmap, so
folio_maybe_mapped_shared() sees mapcount 0, and the walker goes on to
folio_deactivate(), or folio_isolate_lru() plus reclaim_pages(), against a
folio this mapping does not own.

Use vm_normal_folio_pmd() and skip on NULL, as the PTE half of this same
walker already does with vm_normal_folio().  This also filters the huge
zero PMD, so its separate check is no longer needed.

Link: https://lore.kernel.org/20260926105110.2156652-3-gourry@gourry.net
Fixes: 3c8e44c9b369 ("mm: mark special bits for huge pfn mappings when inject")
Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260817220810.1175596-1-gourry%40gourry.net
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Assisted-by: LLM
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Rakie Kim <rakie.kim@sk.com>
Cc: Ying Huang <ying.huang@linux.alibaba.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: <stable@vger.kernel.org> # v6.19+
---
 mm/madvise.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 963337f93a7a1..6c52f699222b2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -394,16 +394,15 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 			return 0;
 
 		orig_pmd = *pmd;
-		if (is_huge_zero_pmd(orig_pmd))
-			goto huge_unlock;
-
 		if (unlikely(!pmd_present(orig_pmd))) {
 			VM_WARN_ON_ONCE(!pmd_is_migration_entry(orig_pmd) &&
 					!pmd_is_device_private_entry(orig_pmd));
 			goto huge_unlock;
 		}
 
-		folio = pmd_folio(orig_pmd);
+		folio = vm_normal_folio_pmd(vma, addr, orig_pmd);
+		if (!folio)
+			goto huge_unlock;
 
 		if (folio_is_zone_device(folio))
 			goto huge_unlock;
-- 
2.53.0




