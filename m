Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047960;
	b=rIrXmRIEnwg+3xwjcNS04X0yafHRGBRN0yFEGx9NwliOGwOhOxgKmTTEjyzgcIIymgQp
	 YaB11Uk69+/nOn6NrS4v1+CwtHPhhBDBDOlpo20l74xfXBKVmgPsTPHlfN8KhvdrH2AgG
	 daByqh2N7xTH7gla3d6QDT8EKa3fBFT4qFNivm8jaW6+WkMDIbOfJsk0XoTngE1WwmAoc
	 jgmtp7JwVXeXg20bKiXlnAu+hc8vdp9FRLubiOnBbLLWB7UN1NrWq5DTO0pSE1ErfDIO7
	 /XM9VS2O8nQqFMBcXtHF/DuylnT2Ou8BQ4rAc7zq1RkRm5D/H1N8d5dd7BcCtjoXmBA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047960;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=IK+aprnxXHQnqUr70kj4i/cLlRSFg1hrysAwLDpy1RA=;
	b=IhGgBrch9KQJopz8RA4Uf79HkVOTkMa+VumKiUS4Jd22PvVH8rYr3DYUpXffQy4qDJO2
	 DxZW88F/JL7biFgMTb1WTuyOhp/cxnDQd9LF2KrQ8fSOwwc2hvYm+BiUbIgaecAYsbaA+
	 P1Th+8wEKLxfsQoVNBS0GJCf5uZ6LzwQTyarbswbWdW1vT7fLBiTk9EuOy7TU9jxYJjlW
	 gja0CYLMmFaSHBuHHZr3aV9JKjfZb3fbzLPT3dcbwMsQ7sx0WH1JxVKZhAOFqdCtUy56T
	 eqGq320umE3Td2PKr5wWVEahKRJd8RSVFJrutaPqdqT1nnbbA17eVLu1/1Q8xL9YdtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9bKTRct;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E386C606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d9bKTRct
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DBC51F0089F;
	Sat,  7 Nov 2026 10:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047959;
	bh=IK+aprnxXHQnqUr70kj4i/cLlRSFg1hrysAwLDpy1RA=;
	h=From:To:Cc:Subject:Date;
	b=d9bKTRct5jEDs0po3VQNluFs031M4ld/VVMQGH5tRxBL+YJXYgPMAPcxR1gPsR+88
	 yN+uFIQMQpoGD5OLZXrTFUpIMhS+9NHTf3sLxbWn99SJbHqPhMWpZ+TLlTs76vOVVV
	 sCeOXKl19dCrpHxOUbeuVb7IyQxUJHnuOLMY/JXb70PKTpW+sPw+OvMNIFM284jr9g
	 34RXznnlW6JDtXLajQp0oOZKXodsztH6yZB7acEbk1PX3og/ScUvl3/zxZfWt8SGnT
	 mVeZeODrHbPITsOtO2AcGbkIkIyLIqDr2fVoldkSX8of/TkuPsy6WitepHVkAE3b1z
	 ZQV7CKGoyIrHQ==
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
Subject: FAILED: patch "[PATCH] mm/vma: avoid broken uffd merge on mremap" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:39:17 -0500
Message-ID: <20261107053917-failed-6.6-68cb098eadda@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 68cb098eadda190783f8f8bdf9fe764df59f7d32
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053917-failed-6.6-68cb098eadda@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




