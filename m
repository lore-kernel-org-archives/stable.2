Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046454;
	b=GQzu/+G6GqMTKpuBd6CTT0W3x09/+3OVJsRSBc4gv2aMhe2/9bU/SnJsAQvYv/n2iSw+
	 nhsJ/fFuDD1ZT1fzknyQrFBKn/ZXa4pTdRT9ayxRddwtPFyfvDXu9jX/P6JQbWpQREFpP
	 KK+kem/fe0N3Lkr9Bw0JAlJKSIxIf12VdU5fqzAulWC37vUmKX5skqBzqTa/41PtgYwzl
	 JMjTrCPaajXzwnBalTicrQSM7ucoNhFF3Hs+1KOyhffhmhpl6zti5TQFYBO2tiERh8RWC
	 EZQKxaH07hdNKXc7b6nGJHPyIVl996dip4w4tLWC1tT9k+F/+tTGyrIS1OqU4Qltb2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046454;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=D3rI1IG5Y4WCgIlXFyO7AlCD5h1m9P/cPAOc2X6mKms=;
	b=f7w6IznM+loh0oeJToIAkRARQ0jUx/lk0cvBvu8eg6uZqa9NuUojE8QFftdLAucUvrQk
	 pX/VU9fuHZ45CZC4qeiMTS26wX0pxbRXtuz/0ZC2W3PvmzIXuC+OCVt47ENaeowj5fo92
	 EIC15AH1/D0J+hNGow6VQxYPu5s8sULuQG4ouE+o1R/m6Fest7UGwg6kRY4ZunDYktM/j
	 bFD6usfc05QOrZ7jzfnwXurLJQojVyYg6V5sEYkMFIwS45sDt/hEppWEB7th3Mq8YaeB0
	 t6AHagHp3uyNZoFpSs3KBGpsJqysHp4zMKRqXlIQ8LXZWWxLj3TK+3oWCdXagHHaJQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5Tk+jH0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF87B606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A5Tk+jH0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 932111F0089F;
	Sat,  7 Nov 2026 10:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046453;
	bh=D3rI1IG5Y4WCgIlXFyO7AlCD5h1m9P/cPAOc2X6mKms=;
	h=From:To:Cc:Subject:Date;
	b=A5Tk+jH095su5fN2rOfXicC/PxE8DW9sz9DkdiBULuhu3n1JtmhqqdvfydOEC6Up/
	 9+mXwHXcE8I728b3P3bOS29jKRJ/OT85//LjzRvVYnNR3Jyk1fPG+e3hwOlclwvWbu
	 VxpjiBV0/zo15wJ643NX6tTzHCiZVP74D/LxWith5yVt/B3M2t2nuvtg/xqN4OZRvr
	 jNBM70LEgAN0860ychMofJqljBDoCYefBVjk4DN8Yn3KKQ6egChSOrVuv4ptFEMANc
	 DxYmJ5aCizIRytYnnQPSo7F8A2KcykZ8YbPDDFuHw/OT0LrT9Ymm4apBrBch2tLs4u
	 v52/ldUa+4g4w==
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
Subject: FAILED: patch "[PATCH] mm/vma: don't leak the commit charge on mmap failure" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:14:10 -0500
Message-ID: <20261107051410-failed-6.18-aa09311c40f6@kernel.org>
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
git cherry-pick -x aa09311c40f6d3aa6037065e17d257ffa48b9402
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051410-failed-6.18-aa09311c40f6@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




