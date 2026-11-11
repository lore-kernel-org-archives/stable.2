Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368657;
	b=v+IXG3lFqjIETVdtcBG3vuOe8jDa5CEoAVtc6ZTdDcB1BPkz/47YnKUDQnrkNtSMVJL8
	 j5TOwSeQA1TrT+qJP4RdRDp3K13KfR4vpllPeexQ0PJMKv4Eu1y66m6GIr6pelPu1rhpE
	 uE8Ko1Dt0k/XzawOD1h6y59JKTXRhgDl7Bew22uhvNf5sEEFQb5Fy/aoRrahOBc1VGU+3
	 13qPIwccbdkeG6qarRrcx/l7q8BRzZZFzCUJuBRiBbKwO1xeaNCstLoMv2mhVOnEasvsM
	 vnbBqfb/Y9ydHHArxadbSvwFMadvLC9tzlwYBczeAQ1t8nADYWmOLkiG3DCyl1GmAhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368657;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=msR9i/1MTLEoaqk3JRMPpZ7lsKwZmhRVysIK19BzZ5U=;
	b=n+YXGADb5uyKPXjH+uZex1PbFSl1QVB3qWvWOEzr1WZjzi1lu2fLoefZOtXuqXA1n9Nv
	 kYZfWu7QCKhFqyfvK0jvJpnszgrNlCEbZo0hUPySoDq+28nTXte4dPbigJ1n77mzTJeuU
	 kw3Cvs1ERsqFUfPZZoBhtEMKgz3wlSyaXS7jS8wP/D+CIiXYn4U18fCU18iWBg5UJ69yG
	 tStF9u2P6OjR2QAnf/RXM9ZjxCP868vZxZWhBLTc47GcK121BGLbR7smx/VqfCfZK1kbH
	 oenaESlJ60PgN9/p1/O4R7tXptkGykv1j4iZEjWuQiImmJ3WZdoHpACrNoaOa/7DLcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpZMY9zv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56107606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lpZMY9zv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0341F0089F;
	Wed, 11 Nov 2026 03:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368656;
	bh=msR9i/1MTLEoaqk3JRMPpZ7lsKwZmhRVysIK19BzZ5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lpZMY9zvcK77bM84IN7TJ1z4lWblYJwnaePFwtbugHkuPrd3L4oRLSZGCmXXccSyX
	 lngoyzlclFm2qcJsPIrbAn8gRGnofZwkpo4L6WKLrkHADZV17512MrwLLK6VtCebst
	 ZMZmF1utSt8kWV79u/NKiA2cHgiPfHTPV/OKCmJv3K+RJT+vhLlknk0+jS5HvmXIkA
	 hy7bLwvUFNe41iakVxaWiG5+mjMAnt2We9CzJ9B+unEA/5dbE//pI9hY46HQBA7rNJ
	 lKekA6XeHfelzh34rgqOVR0W0dnNYU+5md45r277XUL3V4QdcLWmDvP/5hT5dhyRZu
	 8UqEUNoOIOvoQ==
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
Subject: [PATCH 6.12.y] mm/vma: don't leak the commit charge on mmap failure
Date: Tue, 10 Nov 2026 22:44:13 -0500
Message-ID: <20261111034131.950891-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052551-failed-6.12-aa09311c40f6@kernel.org>
References: <20261107052551-failed-6.12-aa09311c40f6@kernel.org>
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
[ sashal: adapted __mmap_setup() changes to use existing local variables in __mmap_region() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mmap.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 2d69552e6be38..c930e03bd7997 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1415,14 +1415,17 @@ static unsigned long __mmap_region(struct file *file, unsigned long addr,
 	 * Private writable mapping: check memory availability
 	 */
 	if (accountable_mapping(file, vm_flags)) {
-		charged = pglen;
-		charged -= vms.nr_accounted;
-		if (charged) {
-			error = security_vm_enough_memory_mm(mm, charged);
+		const unsigned long uncharged = pglen - vms.nr_accounted;
+
+		/* Charge only what's not already charged by mappings we replace. */
+		if (uncharged) {
+			error = security_vm_enough_memory_mm(mm, uncharged);
 			if (error)
 				goto abort_munmap;
 		}
 
+		/* Our new mapping owns the entire charge now. */
+		charged = pglen;
 		vms.nr_accounted = 0;
 		vm_flags |= VM_ACCOUNT;
 		vmg.flags = vm_flags;
-- 
2.53.0

