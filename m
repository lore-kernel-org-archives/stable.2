Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368033;
	b=wD5AzN1Lb1x2KW7ftmNyZzeCIOumZ14WXtNBJ/rDj1C41SodA64Jm666DbBJWoAzLXwS
	 8s1o+3SSCng7lU3cDumgjdsyyPeylc29vBz+9OfAB2QGMAol8MWTxAEhVU4ypbtV4JQ8U
	 CDPi2X9f3NOYicj5nMio7Hv/GamTmhhAlIrEO2qhiXGfALckzK7Hh+2qufELWjn/TDgrP
	 VkaIa5z0NwA0ScfPD2sdTWSYjxNTgQIvG7iKAIgU8iTXJDtc1ghhIZE5xKyI4N1n8MvND
	 LQAgYBmdv4g4ydbNT/z7dbiT3AUTaHrGTAuTnjsv/wRC3XStjYvrLqvUx/ZbLoQTPbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368033;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZZMaJa7A8btflg6fzjNWikrxEkfZP7b5T+vroRVbtbs=;
	b=i9mybpqsAEITqvRVmDyjvpBSYn1VVEel0MXYBDWRiFshLj12AHvIp5t6WHqdZyhjCDi3
	 ZN6bQJfFg8cU67EvMasDkbJOhy3oUELEWRCMm5buGEJxDtsUqv/15dm1Ifz4lSa2nt/zN
	 nXty16AnMBeTAOWVdE+IhqrLfu2NUOfPTkRgQ9ImA/D4+KsB9aOrYF1bKb6pHqLAMRaM3
	 3mHH55K5/aIm6+UtSBabvN78jqf0gUKEHXi+zc+CZycr6+ecccztzVuWdroprSw2eQviC
	 bTgb6IjcQhhYi7Zg8uwXoYxkSnSQmm/ZidYsDTDz8MSVjgkYUtA2dBGjAGWz+lllKMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQTv4+r+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34B0606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LQTv4+r+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F38C1F0089F;
	Wed, 11 Nov 2026 03:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368033;
	bh=ZZMaJa7A8btflg6fzjNWikrxEkfZP7b5T+vroRVbtbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LQTv4+r+EJsQKUO3bD2JVnb+sheUjhvc/y4IOntPLl9i3/+OiipKlgI2jv4fD5eO2
	 pkxnA3n3K1SL2ixhtW98rYfIzEI7JLnFw3b5hcEQZD2JF/OwK9KliwFd7Jgan3NdO/
	 d/CcUYxBcYiggLKhS5oum/QqTPPxkZ4nh02cKP/CfcgoULB3LVkX8wq8t7tTSZmU2B
	 E+KnYfXwJyrlUxR39BW9NVblOKrMWkVGmX9IjcqMk0TW4qs/+8qBMhJWG0NugkAT2W
	 Rle0Bu5k9qNJOqRP6IfsPur9KZmNTOOdO3W3f2hNjfiLaTPgnLMJRJK5JKRnnu4ioE
	 +CX1FCybYfjvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	"Jose A. Perez de Azpillaga" <azpijr@gmail.com>,
	Lance Yang <lance.yang@linux.dev>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jann Horn <jannh@google.com>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Adam Litke <agl@us.ibm.com>,
	Mel Gorman <mgorman@techsingularity.net>,
	Rik van Riel <riel@surriel.com>,
	Peter Xu <peterx@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] mm/vma: don't leak the commit charge on mmap failure
Date: Tue, 10 Nov 2026 22:33:50 -0500
Message-ID: <20261111033332.882078-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051410-failed-6.18-aa09311c40f6@kernel.org>
References: <20261107051410-failed-6.18-aa09311c40f6@kernel.org>
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

[ Upstream commit aa09311c40f6d3aa6037065e17d257ffa48b9402 ]

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
[ sashal: Adapted accountable_mapping(map) to the existing accountable_mapping(map->file, map->vm_flags) signature. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/vma.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/vma.c b/mm/vma.c
index 8669da66edc5c..3710cb70ca682 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -2462,14 +2462,17 @@ static int __mmap_setup(struct mmap_state *map, struct list_head *uf)
 
 	/* Private writable mapping: check memory availability. */
 	if (accountable_mapping(map->file, map->vm_flags)) {
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
 		map->vm_flags |= VM_ACCOUNT;
 	}
-- 
2.53.0

