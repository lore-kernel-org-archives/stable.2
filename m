Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047155;
	b=vphEbtWWKp7joHmBn5bj9MqypMJkqmMwx3dSk+4zo/g4U+P+NlTXweSvK7JR4H+fj8e1
	 h2rJAtcEzzx02cqr5/s3NE+efK6yMFss1m7tgAaPJ1zDl0SW7HRfITzTKi2Yn+Wd5qcXh
	 InlujbuQ3omzB/rTKaZrhFZA3xtUS6Mhi9BgSspUL1KCFodGcLkvcE7HDQMTTqwaDqfkO
	 5pXVHCF/hbFEezpp3HMYKjZ/hyva4HIpkXF8+NAvP+tJTxERB6HKKqmndcUqevcqtHjrH
	 Y7AlxZGb1QL5FDy3qiWFCvFYteEDeQ5iTBthyUzInJuUIcpbzs73O86V+3DimL6TNRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047155;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=y4ADUSK2rqYLKotYFSQXIDJom3Io02em6Qe8sIaEMss=;
	b=jsbPXVZyvtVohvpW2MMrnZqL3hUNSXieayKd+qxHJw8zj1n4jOOv0eSAdM0Kv005bxoJ
	 dVWv6yuOIXnogijPJFfVwTXHuXMOaRA1X7Zmz2CoR0gM4WAUm3dV4kmqGOwt55DNuriIJ
	 4fxLZQwSz686b39ZlygCsoL0piX0Zg1S4ltAHTsU9hfrTLGCTEak7TYVubM0x9TGDa1Wp
	 CVBBXea9O/BYh9K+E2+4QXxc0EzCfMFHHaa+tufgRdcQrFrjjWkYil+ycd64knO76lHc3
	 nt/dHJaomsayQ83Dqww1rk+JjHmsuzA0/8aKSoZPgFsh5uAmq2+tt7hAIlyE2Vl2/mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oV5z3kIq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD295606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oV5z3kIq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D1651F0089F;
	Sat,  7 Nov 2026 10:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047154;
	bh=y4ADUSK2rqYLKotYFSQXIDJom3Io02em6Qe8sIaEMss=;
	h=From:To:Cc:Subject:Date;
	b=oV5z3kIqAeyXZBrAj95vJk7ZF2E2qbb4lGLpcy4Av5d2Mb5PpUa8BxtIEf8iq5psQ
	 HrPbybcRn0ogl3DJ5yGvhsuUoH8nbdO579kpFPs1qBGJnGhvE4/F+2DRDrBAIoWG4l
	 WZ2yFMaENmObFiPvCDvGPuJ442XL8ZkbGUGy/ODXQf0Udmd0ZEY7SG24z2EmHVdLLF
	 JwR2gdzd/NDCrzS1o+hoxsV1Seksm3ex6BK/X3MNtr1k0YKza1W//GQZdW0GLtVKub
	 845wdMZnUkhBlqgrsXx0JPYzcnKhcCyJQ6PiGatwl4bClnnBQGHmfuIGtVSV8H0goa
	 ElfxWKr26LpOw==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	david@kernel.org,
	akpm@linux-foundation.org,
	ljs@kernel.org,
	pfalcato@suse.de,
	azpijr@gmail.com,
	lance.yang@linux.dev,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	linmiaohe@huawei.com,
	nao.horiguchi@gmail.com,
	agl@us.ibm.com,
	mgorman@techsingularity.net,
	riel@surriel.com,
	peterx@redhat.com,
	kas@kernel.org,
	rppt@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/vma: don't leak the commit charge on mmap failure" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:25:51 -0500
Message-ID: <20261107052551-failed-6.12-aa09311c40f6@kernel.org>
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
git cherry-pick -x aa09311c40f6d3aa6037065e17d257ffa48b9402
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052551-failed-6.12-aa09311c40f6@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From aa09311c40f6d3aa6037065e17d257ffa48b9402 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 15 Oct 2026 18:07:07 +0200
Subject: [PATCH] mm/vma: don't leak the commit charge on mmap failure

Patch series "mm: various (urgent?) fixes", v1.

Here are various MM fixes.  The majority was reported by Josef at
Anthrophic, the remainder was found while reviewing/overhauling them.

Two issues/fixes reported are not included, as we are discussing
(better) alternatives on the list already.

I left most of the original commit messages as schloppy as they are: I
don't particularly care as long as the code is in good shape and as long
as they are not actively wrong.  But I (and Mike) could not be stopped
from overhauling at least some of them.

While I don't think there is anything too critical in here, I think this
is a good opportunity to see how fast we can get pre-screened/pre-reviewed
fixes upstream that might be security-related.

The majority are hugetlb + uffd issues, that are not actually that
relevant for most installations.  But all things that should just get
fixed.  Some uffd fixes need proper follow ups to fix some more of the
root causes of leftover UFFD PTE bits (or proof that there are none
remaining).


This patch (of 10):

When an accountable mapping replaces existing mappings (MAP_FIXED),
__mmap_setup() only charges the difference between the size of the new
mapping and the VM_ACCOUNT pages it replaces. It then zeroes
vms->nr_accounted so that unmapping the old VMAs does not return their
charge, which now backs the new mapping.

If the operation fails after that point, the error path returns
map->charged, i.e. only the difference. By then vms_clean_up_area() has
zapped the page tables and closed the old VMAs, so
vms_abort_munmap_vmas() cannot reattach them. It leaves a gap and
finishes the unmap with vms_complete_munmap_vmas(), which uncharges
vms->nr_accounted == 0 pages. The old VMAs are gone, the new one was
never created, and the charge of the old ones is never returned, not
even when the process exits.

No privilege is needed to hit this, only a file whose mmap hook fails,
for example a socket (sock_no_mmap() returns -ENODEV):

	p = mmap(NULL, len, PROT_READ | PROT_WRITE,
		 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
	mmap(p, len, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_FIXED,
	     socket_fd, 0);

Every iteration adds len to Committed_AS for good. With
vm.overcommit_memory=2 this lets any user make all further accountable
allocations in the system fail with -ENOMEM.

Once the new mapping has taken over the charge of the mappings it
replaces, it owns the charge for all of its pages. Record that in
map->charged, so that the error path returns all of it.

A failure in __mmap_setup() itself is not affected: it happens before
the charge is taken over and the old VMAs are reattached with their
charge intact.

Original fix generated by an LLM and sent in private by Josef.

[david@kernel.org: call variable "uncharged" and make it const, adjust/simplify comments]
Link: https://lore.kernel.org/20261015-urgent_fixes-v1-0-42796911043b@kernel.org
Link: https://lore.kernel.org/20261015-urgent_fixes-v1-1-42796911043b@kernel.org
Fixes: 4f87153e82c4 ("mm: change failure of MAP_FIXED to restoring the gap on failure")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Muchun Song <muchun.song@linux.dev>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Miaohe Lin <linmiaohe@huawei.com>
Cc: Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: Adam Litke <agl@us.ibm.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Rik van Riel <riel@surriel.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: <stable@vger.kernel.org>
---
 mm/vma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index f56317ee82471..5ab3fe59f06b1 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2577,14 +2577,17 @@ static int __mmap_setup(struct mmap_state *map, struct vm_area_desc *desc,
 
 	/* Private writable mapping: check memory availability. */
 	if (accountable_mapping(map)) {
-		map->charged = map->pglen;
-		map->charged -= vms->nr_accounted;
-		if (map->charged) {
-			error = security_vm_enough_memory_mm(map->mm, map->charged);
+		const unsigned long uncharged = map->pglen - vms->nr_accounted;
+
+		/* Charge only what's not already charged by mappings we replace. */
+		if (uncharged) {
+			error = security_vm_enough_memory_mm(map->mm, uncharged);
 			if (error)
 				return error;
 		}
 
+		/* Our new mapping owns the entire charge now. */
+		map->charged = map->pglen;
 		vms->nr_accounted = 0;
 		vma_flags_set(&map->vma_flags, VMA_ACCOUNT_BIT);
 	}
-- 
2.53.0




