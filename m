Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047941;
	b=sHLQQ3mFy5NUmt67eGbVCeZZhwtttFBMAN2qXeTs7EtfSbW3CPoSHxBud7zgIDABubPX
	 ZtqifmLI5lxPuoV/Lc1jV6cCrLcNXega7kZJde4ao8lX0SpYNOo0nkPMBTzgGPEUTvPZF
	 JP6iyY0UJem9T67aSdaBttRLV0aVvU1lh4VAk1rTDlTqcTPrucqeTvFi0VxKOFv6+CCzr
	 6mG9MqKeToBhSBziRPAvxw3kT0C1h4OhZD37/DTzL2/dfC1cQmKq5NuIGZafXKgbWfqfR
	 nX9LVuPEsLrvmbiH0AIYixyw0DcdTM45R+qvRlHO2q1Xh39c9kTOgxxVq4VaTeOfPQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047941;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A9B1gWVbsAnThkrHMp+jseFIFJ9+GQ28NpgZpLBI7E8=;
	b=vSzTMd/EC5n50bY+yuBcFJXfA2yo6hEJLQi6ptRDfO8dx0zApIhAzj6NSDNluHBroAaK
	 JCeYqCeysdUpFE7lRDH4oDQ+UffV2mvm48Va/OnTO1zfH91rkWsIRwbiYL28FYyVlPNA+
	 4X1OAzYdz4RzOtRCYCdlBYeUl//a+LNfAXq924ORcGdk7kknfZ3NBnFB5+QcOjA4G0c1M
	 jm9AGRBa4GhMXTh0GPJJElIFcVXJh3CtaPZT5rQBzfuuBt7zpd/4w/8lLRftiRTB30+mZ
	 XUOsM986OhUlRfEbx8PX9gGFRKGdQJCZBDAKBspuQiIOOM7e/z90gb3Xiv2WBjG/cxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwuCKf1Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39980606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwuCKf1Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EFC81F0089F;
	Sat,  7 Nov 2026 10:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047941;
	bh=A9B1gWVbsAnThkrHMp+jseFIFJ9+GQ28NpgZpLBI7E8=;
	h=From:To:Cc:Subject:Date;
	b=UwuCKf1ZZ0cMk6f0+6I0z+EDtsO1aO8UWfniOHsO1S01mVJAMGiiROHfWKIdnVIjU
	 LU2DiHk2+puI853WuFaNQ/gyb3H7pS+NdStLR1w8p6zby2ZNKk3xz0c3lkugqk4N/j
	 Ok6wr70ZfmB+ip0lbcu6COCs/VchC+L4uiy630DmN9e7kc/h3+xRDzzPgzAIIibPzH
	 KPOnkJ3xCr/pjxceAkcvZuMJYVdzFvjKey22E0ahjxA7pkd9qDbsmwxrQslmwwEi5t
	 /j/eAvArpjUh3Pi+ejM+ho9hpAzFmnzS6CJHVphR6CXlJD008u2DEARdxk9s2nDaHB
	 f7uHZN/cIlSMA==
From: Sasha Levin <sashal@kernel.org>
To: pfalcato@suse.de,
	akpm@linux-foundation.org,
	samarth.colleges@gmail.com,
	gourry@gourry.net,
	ziy@nvidia.com,
	ljs@kernel.org,
	david@kernel.org,
	sj@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	jannh@google.com,
	minchan@kernel.org,
	mhocko@suse.com,
	hannes@cmpxchg.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/madvise: atomically clear the young bit on THP MADV_COLD" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:38:58 -0500
Message-ID: <20261107053858-failed-6.6-246c8cc33438@kernel.org>
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
git cherry-pick -x 246c8cc33438a71c28f9b86baa492d9a0a130316
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053858-failed-6.6-246c8cc33438@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 246c8cc33438a71c28f9b86baa492d9a0a130316 Mon Sep 17 00:00:00 2001
From: Pedro Falcato <pfalcato@suse.de>
Date: Tue, 13 Oct 2026 20:17:19 +0100
Subject: [PATCH] mm/madvise: atomically clear the young bit on THP MADV_COLD

As-is, madvise_cold_or_pageout_pte_range() discards the hardware young bit
by invalidating the PMD, doing pmd_mkold() and subsequently writing to the
pmd again.  However, it does so in a racy manner, looking at a
possibly-stale snapshot.  It's entirely possible that a write elsewhere
set the hardware D bit, which this logic now loses.

Fix it by using pmdp_test_and_clear_young().  This is an atomic
modification of the PMD entry, and thus safe against any possible racing
writes.  As a (nice) side-effect, this elides one non-required TLB flush
in pmdp_invalidate().

This bug can interact with the swapping system in complicated ways,
leading to data loss.  For instance, if a folio is marked lazyfree, but
was later read from, and then MADV_COLD'd while racing a write to that
same THP, dropping the dirty bit may lead to data loss as
reclaim/MADV_PAGEOUT drops the "clean" anon folio:

T0                                T1
================================================================
MADV_FREE(thp)			|
  folio marked lazyfree		|
read(thp)			|
  PMD marked young by hardware	|
				| MADV_COLD(thp)
write(thp)			|   if (pmd_young(pmd)) {
  PMD marked dirty by hardware	|     set(pmdp, pmd_mkold(pmd));
MADV_PAGEOUT/reclaim		|
  dirty bit may or may not be   |
  set				|
    reclaim/pageout may drop    |
    the folio			|

Link: https://lore.kernel.org/20261013191719.95502-1-pfalcato@suse.de
Fixes: 9c276cc65a58 ("mm: introduce MADV_COLD")
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reported-by: Samarth Narang <samarth.colleges@gmail.com>
Closes: https://lore.kernel.org/linux-mm/20261011132227.413217-1-samarth.colleges@gmail.com/
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: SJ Park <sj@kernel.org>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: Jann Horn <jannh@google.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>
Cc: <stable@vger.kernel.org>
---
 mm/madvise.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8702b082a02d8..75b409e97dbf2 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -430,10 +430,7 @@ static int madvise_cold_or_pageout_pte_range(pmd_t *pmd,
 		}
 
 		if (!pageout && pmd_young(orig_pmd)) {
-			pmdp_invalidate(vma, addr, pmd);
-			orig_pmd = pmd_mkold(orig_pmd);
-
-			set_pmd_at(mm, addr, pmd, orig_pmd);
+			pmdp_test_and_clear_young(vma, addr, pmd);
 			tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
 		}
 
-- 
2.53.0




