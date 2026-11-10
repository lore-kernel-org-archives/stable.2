Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272958;
	b=nX3rshbkGL5vQY6ofeZGkjlWVp6UodQuBBxawKkHOxPtIo1RxYJ8FSJ8J/snVpdiSFH1
	 J4oeVnoB9wzYbYuxVZ1+qc1TqPCAGzu3Jk0u6x0QJGFAYzPySCnjqeF2OxZspEywiyG6a
	 A519m1FZWHh9Gqtq9p3AHvlALE6vMTUXz0OWO1euZ7xNLP7nUeaNNG7M9i4h9ZXyE7r2o
	 g4o7winvwPg50ECBF1ZDJdfOYWbXJfg3i9XZUCD3JfyyCahQlTgWBIQJM0LiQBGNFVrsC
	 +A/6UU70dPD3/qc2P1rKvgCHJhq7+wudcfk0OZS1tfaH9JML4AH7H3ZLu7YvcsBE/SA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272958;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=ldyUiP4qWHElVzddg9/0TG8eCmrpS+hDwS5mg/MYXok=;
	b=RcXeTczmayA36eGMBY1hXoT3dGnla/Pmt8Wy1T9JWHo7pBbLc1VzsZUOJOUKjTfUVTqS
	 qChC6owmVsihrEDxBpt6Kzs1WcU/kSm7sdlnYZmNkjNwsb4QYIXvdjE7TmKIs5Ee9ZkhX
	 FpUmEj337nPu9MGnS7VUNyj1+s3CgZbZ6Ruhqkwl2J1bsrkvfM0bS4lTBOcYVBc9S2Slr
	 30rOVwg3T9IBrhe8HAfE16/8/XG66PrNW7RQtYlCSDxA9JQog9n41VNbHOs72fhMeWXb8
	 r9rWEvG3jRjCT1tLEeP5ppJa6NQWx9OI1W2ah9RTp9xPOdwYKcWaeGr0zWzwBUmnQcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijN+s82q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F47606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ijN+s82q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 255951F0089F;
	Tue, 10 Nov 2026 01:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272957;
	bh=ldyUiP4qWHElVzddg9/0TG8eCmrpS+hDwS5mg/MYXok=;
	h=From:To:Cc:Subject:Date;
	b=ijN+s82qkJcOzsl2WA5fE6euCsLsL5rvVCbFPSNyI1P7rbvD1/8k0nVrjICuOdJzB
	 8naSARdFaB3LkW84HBOgZm9sjSGCGpDyR289mnCDDlGvNCXssjc4GZ1DWGolstSYGy
	 xv1/p7KrFI5WUKj0o3TiM71+prT3AQbno0qukjSSpf0L4egE1zHD7v2lPsKmcZl4qH
	 rHUXWYLatzzNqa4tGj7AM9PZXNIjQZVh5eYLSvTAZ2CaQrQWIyqEwG+LqGGrJ85jF0
	 SbT9DMG5787gB+/PZRT+VfSG9x6CAt4tksTWu9h6FhMsT7/idUh5af6FX5OFSaoTv6
	 eZxTeVjgQnpxw==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	ljs@kernel.org,
	pfalcato@suse.de,
	usama.anjum@arm.com,
	lance.yang@linux.dev,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mremap: fix moving PUD leaves" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:09:16 -0500
Message-ID: <20261109200915-failed-6.12-440c8779757f@kernel.org>
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
git cherry-pick -x 440c8779757f09f290770b1d361dc1516a9d0b3e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200915-failed-6.12-440c8779757f@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




