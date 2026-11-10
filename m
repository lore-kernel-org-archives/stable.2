Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273521;
	b=N7/8ELc0Fyun8zluadB5ZT6H4u/gmCyPK9EvxRLNuYZSEDsX3xBYUtAZjLZJ20kfpLB3
	 GtOREdMn5I4KV3KMKey60FdPVgacEpyBXc8HIzl12fRFs173Qi0imixPyNLlcwIJcTPHK
	 FrigiR3xciT8+364qsA/F8d5pomjcIlpWvj52XmEw4LZS1WX7/oETTyaz06ed+rnRZnZs
	 32GbFLHWv4gaAZdyFCSbgItcm2p5kyqkFl5prz1EjAi3DRqiNvtmJD8YJlRUlQwDlTSTD
	 Pi6wtHK/3Ouhn5WkPJdhTu3IpNjy4p+c23CPWDQfbU5ytEBFCenwG16hKS2RmeQRAhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273521;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=C6mgpNpMmNMLpVIzij4dbJ4Ryr3OIVBcUZBs5kFc2MY=;
	b=w6kqA2wzi4HPMcxoPjLAvW6gsPH7XM9xr54PhoWjFvq9sB6AQL1vOjKcVJv1BoJAeBbb
	 /cGRT6ALICmp57Qe5FXEzGxn7jVt6maYCQczNOPmLErRBSBKCBKaDdtvw0S8f/FjaivOu
	 XHHlkYWriq928s26w4lMRjNT/yleFUsnUPEzdruIgyqH/expyI73vuC7Mkgfwf+YScq/7
	 oyUAa4qQwbdp/nsSBZildiATxYBldR65XhQ0UuY38A76r+nSEWjEVwiHO1x6Lx12PQuu/
	 8jgi5X+b/43pB4KufMx7dAFrhPDxhmR7V0xwoMdaPUsa6wMoDnwhA6JLkK48jj1wqDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1pMV2kp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBAB4606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U1pMV2kp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFC941F0089F;
	Tue, 10 Nov 2026 01:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273520;
	bh=C6mgpNpMmNMLpVIzij4dbJ4Ryr3OIVBcUZBs5kFc2MY=;
	h=From:To:Cc:Subject:Date;
	b=U1pMV2kpIpQQYSGI1RVBGKGPqxqiPaFAVmUt53VgYyleVxdSw0UF3yPRWYQBW/47L
	 ejcwTa0s9as7BtiYPn9mLGT81RP1ECGw3S3ZYbmxxCpMQ1BwqB9Zg5aHX8Zg+z9TB5
	 KdbTDdRAGhRnf5Dswq53Jz/K7t+86q+yDBqwEOoHbCgn571TsUj5Y2/AsEzAFubem5
	 2qOKVAWueBvd65hwB6xINmuK+uuQ7Wj9ksFrqd32FpIQQHXl1iw7AEX4FRxfBO/eWL
	 +eMcW+/Avs7h+rmXGqUNforAvtdBTLYGTHj+KK58f+N5+Lq8p3p9+R5b+syqk9veoy
	 MDcjbSMRVPQbA==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	ljs@kernel.org,
	pfalcato@suse.de,
	usama.anjum@arm.com,
	lance.yang@linux.dev,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mremap: fix moving PUD leaves" failed to apply to 6.1-stable tree
Date: Mon,  9 Nov 2026 20:18:38 -0500
Message-ID: <20261109201838-failed-6.1-440c8779757f@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 440c8779757f09f290770b1d361dc1516a9d0b3e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201838-failed-6.1-440c8779757f@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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




