Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D59D3F7886
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 09:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785922450; cv=none; b=YzkUr7386d27X+MevR1PAH3aPM4F7h1j2sBBPEtwmRtSKPnq3Y1NDl1cZy728+Yo1QfS4iZdho5BkNhKWM+m2BSlEzWk0rm20+5vmyFsFjc84DUl0sqy9n99iagoooxtMTeSnRbvRwY6R+1EUKkr8b1NRDfCgpfQCAGaQyoo8dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785922450; c=relaxed/simple;
	bh=zC0fh81CzqNT8fwSO+q1ZI+1I+j7Mcr6L7Gr1QKD1Vw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=YZfUHLngHxOKYc/zFB1DdAUdy1QWbwsQVgmpZ4JQ4ExmxkOHQnI4vdOKcfafIA0wGJMrIY8uw1msfgZSNhTnVnIAyk9kdW288/Ypiy/V+9NTbI1y/Z9K2RT6lfkZcIKoKXZDhu3MEunP71m9Fx4OezPd10zzOXp1EuJ+0rgvIDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tnejiFLv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tnejiFLv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04381F000E9;
	Wed,  5 Aug 2026 09:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785922449;
	bh=JbPG0wYRWB23AqNtAuhUHg8+1m9ppQXBscpBj/EnIFo=;
	h=Subject:To:Cc:From:Date;
	b=tnejiFLvUz367uDxbUtZcFa771GXoeXPNCOHm/9/thG2uNPNuxcLeXKUcZUlLUMiX
	 RX7xWiPZV0tbEUBwNMJvjqPo8yA5EBBfRX0Iz5MtJPwHef8wLoJ7UD0LP3IrJqKHNi
	 RQPNC1oZXHoHHFK5FnVWrK544O9lbLJglc5u+E8Q=
Subject: FAILED: patch "[PATCH] userfaultfd: wait on source PMD during UFFDIO_MOVE" failed to apply to 6.12-stable tree
To: usama.arif@linux.dev,aarcange@redhat.com,akpm@linux-foundation.org,baohua@kernel.org,baolin.wang@linux.alibaba.com,david@kernel.org,dev.jain@arm.com,hannes@cmpxchg.org,lance.yang@linux.dev,liam@infradead.org,ljs@kernel.org,npache@redhat.com,riel@surriel.com,ryan.roberts@arm.com,sashiko-bot@kernel.org,shakeel.butt@linux.dev,stable@vger.kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 11:33:44 +0200
Message-ID: <2026080544-unwilling-bullpen-8ca2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 4165b7d1c45c2da0dfefe528f8d1fb7d79f0d344
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080544-unwilling-bullpen-8ca2@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 4165b7d1c45c2da0dfefe528f8d1fb7d79f0d344 Mon Sep 17 00:00:00 2001
From: Usama Arif <usama.arif@linux.dev>
Date: Sun, 5 Jul 2026 06:12:31 -0700
Subject: [PATCH] userfaultfd: wait on source PMD during UFFDIO_MOVE

move_pages_huge_pmd() snapshots src_pmdval under src_ptl, drops the lock,
and, for migration entries, waits with pmd_migration_entry_wait().

Passing &src_pmdval is wrong.  pmd_migration_entry_wait() must lock and
re-read the real page-table PMD; on split-PMD-lock kernels, a stack
address also resolves to the wrong lock.  softleaf_entry_wait_on_locked()
then waits without a folio reference, which is safe only while serialized
against migration-entry removal by the real PT lock.

Pass src_pmd, matching __handle_mm_fault() and hmm_vma_walk_pmd().

Link: https://lore.kernel.org/20260705131231.1499198-1-usama.arif@linux.dev
Fixes: adef440691ba ("userfaultfd: UFFDIO_MOVE uABI")
Reported-by: sashiko-bot <sashiko-bot@kernel.org>
Link: https://sashiko.dev/#/patchset/20260703173903.3789516-1-usama.arif%40linux.dev?part=8
Signed-off-by: Usama Arif <usama.arif@linux.dev>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Reviewed-by: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Barry Song <baohua@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Nico Pache <npache@redhat.com>
Cc: Ryan Roberts <ryan.roberts@arm.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Zi Yan <ziy@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b5d1e9d4463d..032702a4637b 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2774,7 +2774,7 @@ int move_pages_huge_pmd(struct mm_struct *mm, pmd_t *dst_pmd, pmd_t *src_pmd, pm
 	if (!pmd_trans_huge(src_pmdval)) {
 		spin_unlock(src_ptl);
 		if (pmd_is_migration_entry(src_pmdval)) {
-			pmd_migration_entry_wait(mm, &src_pmdval);
+			pmd_migration_entry_wait(mm, src_pmd);
 			return -EAGAIN;
 		}
 		return -ENOENT;

