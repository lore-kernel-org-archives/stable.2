Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794049914;
	b=Zq/7putQM2F7TIPnI5g2qzM9gzvQSyxqy4/6dMUW6WsZSKG+Rl0wGAFnWvFmyfTHFv0R
	 NsMRzAgTzj/qI5AHxUkD9ymoAJB3uL71QdrRoGklsp/7BsQdlafzrSLCDPoL1E3k5BmB9
	 Vd7NQPz+LM7bP2rC3b19bD4uF1O5V7eWNh20ftV9ogOXNtDKPa/l6TjgUmOqDguLF0tkW
	 xgI+sS28oBdIRs/MShmoPV5G+ppc5+zsa1kisDlTxORZ6w2gju11LL/wxsNZXBrAJNMyz
	 Fk0J0pQn5GvdW35LwnswIXCxSFqJce/5F78DTHRa3ld8qN+ZUbeXrDqdnuPcsVT+b6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794049914;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=DbRpoSCsJLvVicrfDys+69fRXmxU7nce96igsvG0oK8=;
	b=GK4YStkwEWhOGP0ArwpyNUFmJhQxjAd9bKxuvZP1FXxMBcLpK9rt6wNpj3zsyUWY4rbo
	 Y/0allnMsCvw0zHCubiYYztaPpB6B0/ponRviK4NZ7y8Avwv3LqCQrfPDRkAtgXebjDZF
	 lZgSs6c1qyaCUWsXH5hKyZUDYHqR56N5w8AfKufxLN0vwLMi7cf8hEwx2xz2cD0Pezd86
	 36Oiu+s1Aro8v8FB+d7njXgHsgnN3V6aa9i/eA2rcfsf2XMbPNCJbNPc+GEfVpRvMU6jg
	 47QPmpEKl08KHuuvxvJXSqxf7DhJKMyCu4GM6Um321LveZbbF2KWB1D7yBC8pxsaqUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcBwGUu2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BF4606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VcBwGUu2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7691F0089F;
	Sat,  7 Nov 2026 11:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794049914;
	bh=DbRpoSCsJLvVicrfDys+69fRXmxU7nce96igsvG0oK8=;
	h=From:To:Cc:Subject:Date;
	b=VcBwGUu2LxWlEso4zlY7lGUAcjZFSbcU15lNXtKQ+v71LgntB2A1gmcPmJjdxACSq
	 j5jCSUn77XpEO5y/H7EXBKyqQxiNvhpy1BqE4tGgGmLPYfrg1tbP79cp1J3LRMPJaw
	 SgNoCI7r1wabPpArRkJCNn/utqsrGPT+hSxq1TzxalcaBWtZ99sGzzrA5IftdJQJGt
	 moy9B5z50/gse2Rxc5UveUCTij2AxedkoCKzCrW3tXxxfWVHTNMx3hvDKBfngz5QGr
	 H1l4eIIM7xSxcD0mGo/UXN0bL27GaXOzc/PNoHbGAVTUNADNJWzegbK3PF6kcv8UT6
	 SLDN8J8T6aYuA==
From: Sasha Levin <sashal@kernel.org>
To: ljs@kernel.org,
	akpm@linux-foundation.org,
	shawnq1@163.com,
	kas@kernel.org,
	gourry@gourry.net,
	xueyuan.chen21@gmail.com,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	pfalcato@suse.de,
	rppt@linux.vnet.ibm.com,
	peterx@redhat.com,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/vma: avoid broken uffd merge on mremap" failed to apply to 5.15-stable tree
Date: Sat,  7 Nov 2026 06:11:51 -0500
Message-ID: <20261107061151-failed-5.15-68cb098eadda@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 68cb098eadda190783f8f8bdf9fe764df59f7d32
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061151-failed-5.15-68cb098eadda@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 68cb098eadda190783f8f8bdf9fe764df59f7d32 Mon Sep 17 00:00:00 2001
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Date: Tue, 20 Oct 2026 15:55:30 +0100
Subject: [PATCH] mm/vma: avoid broken uffd merge on mremap

Userfaultfd often causes unexpected interactions within mm, and does so at
the intersection of uffd, mremap() and VMA merging.

When an mremap of a VMA occurs, copy_vma_and_data() calls
mremap_userfaultfd_prep() to notify uffd of this.

However, mremap_userfaultfd_prep() simply drops the UFFD context for the
VMA if the user did not register it for remap, i.e. didn't specify the
UFFD_FEATURE_EVENT_REMAP flag.

This is OK for the VMA itself, as upon page table move, move_ptes() clears
UFFD page table flags, using vma_has_uffd_without_event_remap() to
determine whether to do so.

However, this doesn't account for merging with adjacent VMAs, whose page
tables won't have received this treatment, and thus latent UFFD markers
will be left around.

Worse, it'll break UFFD for any VMAs it is merged with. This is very
surprising behaviour for a user, who will then simply not receive UFFD
events for VMAs they ought to.

Resolve the issue by explicitly checking for this case via
vma_has_uffd_without_event_remap() in vma_merge_copied_range(), the merge
function explicitly designated for mremap() operations.

Also update the userland VMA tests accordingly.

Link: https://lore.kernel.org/20261020-uffd-remap-fix-v1-1-0f34fc181f0a@kernel.org
Fixes: 3cfd22be0ad6 ("userfaultfd: clear flag if remap event not enabled")
Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: shaos <shawnq1@163.com>
Closes: https://lore.kernel.org/all/20261020110748.959870-1-shawnq1@163.com/
Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Pedro Falcato <pfalcato@suse.de>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: David Hildenbrand <david@kernel.org>
Cc: <stable@vger.kernel.org>
---
 mm/vma.c                          | 5 +++++
 tools/testing/vma/include/stubs.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/mm/vma.c b/mm/vma.c
index de5ebc57e7a58..1be613044b4a5 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1211,6 +1211,11 @@ static struct vm_area_struct *vma_merge_copied_range(struct vma_merge_struct *vm
 
 	vmg->copied_from = vmg->middle;
 	vmg->middle = NULL;
+
+	/* If not registered for remap, uffd context will be cleared. */
+	if (vma_has_uffd_without_event_remap(vmg->copied_from))
+		return NULL;
+
 	return vma_merge_new_range(vmg);
 }
 
diff --git a/tools/testing/vma/include/stubs.h b/tools/testing/vma/include/stubs.h
index be8f5161f92a2..f786a585caf05 100644
--- a/tools/testing/vma/include/stubs.h
+++ b/tools/testing/vma/include/stubs.h
@@ -386,6 +386,11 @@ static inline bool is_mergeable_vm_userfaultfd_ctx(struct vm_area_struct *vma,
 	return true;
 }
 
+static inline bool vma_has_uffd_without_event_remap(struct vm_area_struct *vma)
+{
+	return false;
+}
+
 static inline bool anon_vma_name_eq(struct anon_vma_name *anon_name1,
 				    struct anon_vma_name *anon_name2)
 {
-- 
2.53.0




