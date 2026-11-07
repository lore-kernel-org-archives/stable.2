Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050933;
	b=kBlipVDs7nBF/WlFE8h8sLkYjMxlPHGTtaCwVPcn2KD6YzFimQUWs/6MpOUhOwdX9Zpc
	 FoEtA7NUmydupQmps4+8v1Tvr9/YOZ0OfiHhyoV5QS+XMGwnOzngEubv+JgxvBHh0AzKh
	 hJ3M4V6xKlJ5ykdzBXtLARDyqbwD/ekqlwmOD+dL59tiuC8pfnoeioPE/m/tCM9JMgHIl
	 PLQX24US9mrbyj0N69fRwYa7uaen9s2FGx0aSsTdxuT/F3N4Fp5oAnbIUyUtrEsMnvz3v
	 +Eagv0TPjWw+HXW7UUAoKFoE0PrLRTL/B3AooB81EKc53EXdmiSNnyZegKrp7xTKfoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050933;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=com3EgPSA5PpraFEKttMi8iMKRG0ykEGKWCRwhtXWaw=;
	b=AL4OT/ydVV0qIYcVYat7npcDfiApIc0l0Zofz8t7nJtZ2uublYe0SunHaWjKp2HVg5O2
	 kBfQAj12SHdYe10pj15m0EE1eeBWME7KayoyAH3f08DdYyiSXj+ub4eYgssIk+hL7+4cT
	 e3OvaLz6rVJn5vqkjPC4tESWWcNPRRnalPYj0AJFwsj6Re6BA9Cc3JZmfp3zColXJzs7p
	 m+CljUPTbm74WQ++2Uf+18b3oyE2+PWvq0FrdnlPvWvn1Vhg8sCu/xXCi19S5n5/YB1Vj
	 drVIccloCip86udJNX96mU8x/aZvisvZ2MqcSoy++gSX1hyCeaGvv9NaQwi+3MYpymg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmcsHGWz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2621606D802
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nmcsHGWz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DD441F0089F;
	Sat,  7 Nov 2026 11:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050932;
	bh=com3EgPSA5PpraFEKttMi8iMKRG0ykEGKWCRwhtXWaw=;
	h=From:To:Cc:Subject:Date;
	b=nmcsHGWzh1vbDSU7Uuc4hFv1SmKQMBlYzzXubM4CFZ1xXkJEDvqTWKBjYV/mlhhBM
	 8ckvDuTiHbylPOkLB8xN7JENLTAP4RASMqUKpgJZg10PEKoXeWPY/24WKSd2jEw5L1
	 v+VP9Y4Ato8VFjrfo874zDFvsXz2jMnznsaftIMa8dmz2iI9qR2BwcPzH/LW2PpPRh
	 97IF20GKV6A8jTDOVace8/agO+weHYcpVhrQaKxTCnCC7XhMT/n+tjScr/2TeNdXI/
	 QjXI8oSBguV7gu4QDy4Ljhaf5v4U0Cum7Y5QoHO/td0BUudJF+JqzZ/nH1yE7mCiyP
	 W/j5D3sqqRr2Q==
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
Subject: FAILED: patch "[PATCH] mm/vma: avoid broken uffd merge on mremap" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:28:50 -0500
Message-ID: <20261107062849-failed-5.10-68cb098eadda@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 68cb098eadda190783f8f8bdf9fe764df59f7d32
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062849-failed-5.10-68cb098eadda@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




