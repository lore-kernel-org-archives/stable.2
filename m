Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273823;
	b=3VWpRSW8/7C+BB9O6ujAPYRb9iYWW0bTTrv21sSTnAkXpILcT75fkHx2KhElBuoEdIML
	 J2v100BEIFyfxJulVJz+KdFgtIjCFFI/SNjZmIzGh5acs06dOATPVmEygzWelGNs4BQsE
	 MRxlvqrjOS0pLVei5IAcJxTCsqoTQRe8TgLhZrBa8ERxf960T59yA0nRlroRqyz2Wopd+
	 6Lq1c90KqsGzLbVQITbnYS3OoVSFS8gnJHRydzuidD81Wg5v+WUyculXpkQuzE5m2qUqY
	 eVJ2G+VbNDPm738tygnawsbLu6Znt33MLvs/aS7zWe1Q9W2JyVHf30Nq5Q3YrdcU2BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273823;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sSiL9+7wOICTBtG8VdDl4xttBMj1t23tblUqs6agIHY=;
	b=IPEis4OzQfBEM5CJAF4qmkabNCf629E6H9q+bd+e/6VXdComjkybnZireKqvrhiTO/YO
	 vvZjBFObys9gVLsCWUshqlg7Ti2gepU7ZqvU4Wq2imMoNCwg/WTv+BQ8SkbltcTaj/sP4
	 n1J4ikPrqDT2lbyL4VwQpcAKqhJBRJBruCZocq6zcfCIyWoxUTkFc2SJODdtRQ3vQmwV8
	 9b2v0s1d76TrpzGmiu3R4wCCGXPDHiFb4x/Fg2bgiG9oUGKjh0lyvKwbmFyFVw32voqls
	 ayCWclmwj6FGzTXz3NSZQ3MBy12iuf+xWZNfLVGc0jXiMerYHx6ik6pByVCZchrYVxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvZVkq5R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7154F606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fvZVkq5R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC6D1F0089F;
	Tue, 10 Nov 2026 01:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273823;
	bh=sSiL9+7wOICTBtG8VdDl4xttBMj1t23tblUqs6agIHY=;
	h=From:To:Cc:Subject:Date;
	b=fvZVkq5RC8XBOd0lVnadovJ9mFEdBH60djwqxwp9mtQJehh1M0lww9wqZENFfNDsD
	 efkJZyyikFT4Ag3Lpab8DOK+pS/gIDnyfJphyPg3NuOmUwyhzm1jZ0fkpjq5/pEN4k
	 qDSfpBJiDImj4K2iy6Fonmy4baygLW18XvsnjATe71edTB8hK+geNmmQ+5faVAZgZR
	 ZfSOyWsdZiq8vbkc+wEjr7PuOsQecWaBs9ksADA9lpSQabWziGrEsHJG9cmX5FU3ZH
	 PgwXoQIouiuudgaffgMtXACbGEgQC/6fB9GyqvKW32fLu5W/oM/lMS7/y0XqB991UU
	 3Xn6Zitgt1clA==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	ljs@kernel.org,
	pfalcato@suse.de,
	usama.anjum@arm.com,
	lance.yang@linux.dev,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mremap: fix moving PUD leaves" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:23:41 -0500
Message-ID: <20261109202341-failed-5.15-440c8779757f@kernel.org>
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
git cherry-pick -x 440c8779757f09f290770b1d361dc1516a9d0b3e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202341-failed-5.15-440c8779757f@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 440c8779757f09f290770b1d361dc1516a9d0b3e Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Sat, 31 Oct 2026 10:40:01 +0100
Subject: [PATCH] mm/mremap: fix moving PUD leaves

pud_none_or_clear_bad() only really works on page tables. PUD leaves
confuse the check and make us clear the page table entry and print a
warning.

Since commit aed877c2b4257 ("device/dax: properly refcount device dax pages
when mapping"), this also leaks device-DAX folio references, mapcounts
and RSS accounting, resulting in "Bad rss-counter state" warnings on exit.

Allow PUD leaves in get_old_pud(). If a PUD leaf cannot be moved as a
whole or the move fails, split it. This unmaps it with proper accounting
instead of treating the leaf entry as a PMD table.

Keep using pud_trans_huge() for now, in the future this code should be
cleaned up to just check for PUD leaves.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: a00cc7d9dd93 ("mm, x86: add support for PUD-sized transparent hugepages")
Cc: stable@vger.kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
[ david: fallthrough after splitting ]
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-32-d6437171ecc3@kernel.org
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mremap.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 91f0865f6aeea..1237718848f5c 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -87,7 +87,7 @@ static pud_t *get_old_pud(struct mm_struct *mm, unsigned long addr)
 		return NULL;
 
 	pud = pud_offset(p4d, addr);
-	if (pud_none_or_clear_bad(pud))
+	if (!pud_trans_huge(*pud) && pud_none_or_clear_bad(pud))
 		return NULL;
 
 	return pud;
@@ -847,11 +847,10 @@ unsigned long move_page_tables(struct pagetable_move_control *pmc)
 		if (!new_pud)
 			break;
 		if (pud_trans_huge(*old_pud)) {
-			if (extent == HPAGE_PUD_SIZE) {
-				move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud);
-				/* We ignore and continue on error? */
+			if (extent == HPAGE_PUD_SIZE &&
+			    move_pgt_entry(pmc, HPAGE_PUD, old_pud, new_pud))
 				continue;
-			}
+			split_huge_pud(pmc->old, old_pud, pmc->old_addr);
 		} else if (IS_ENABLED(CONFIG_HAVE_MOVE_PUD) && extent == PUD_SIZE) {
 			if (move_pgt_entry(pmc, NORMAL_PUD, old_pud, new_pud))
 				continue;
-- 
2.53.0




