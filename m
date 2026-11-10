Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273224;
	b=nimPu0rozIkBNiMzRQBJu0F1PXNJDc0kWWrhkKzD4OOqtZnmKs1x2Kt8SmGVGDkF8y4n
	 Ok4IUkXIDRyTFAaihD2rBrrYxj/yagdONx/3HhOCvM0wm7u2fqAxyWk3jsk9JXqTOs612
	 ejxVw8+YPxWwi5bUqK7ORYEIJmbcxKgv8Ihe+9r1KRkcGm2mYH0OWSTXkaEZKykIqjdDK
	 UBg/W6Lr8O3savS1A76rhrpf9PzwY2xtgnPnuAE0Z2ZfwlgevCNoxQeRSsDZYPgi1Cxw1
	 Yxug7uu4mWpQyaYyhd5B4V6iQw4jFCPKNWM4X1tfaO3kSohmqViu468QuzuslkPmsbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273224;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=0nyg+Iauj4/pF5YNDnHiq44Vlbp5kDevUvwfcGDxwcI=;
	b=Y7h63I9muEZCqbYHMQMowkafCUUFCFM0uAa+WPzEPeVIcQszNdSGyfKaqq83oAej7ESk
	 XCbcxy+ynBHC4fNMlqCryNWcLbTTyJrzkh/+0VSNHmGizHnK2DeIzwqbe4G1kvPdjXk7j
	 3nNu8oh6DO+uaKLw6G2Cm2Z0fQR572l0uTT86QMmpAvYZCnjBGgd96OuVLKwEZ/GjFiRe
	 tl001kYSjXHggyfjPgQQxaSe0OlpFXUwqO491MA+6lzsD3vJinadBc29oNjxTtwpVhRfO
	 lSfFoMNv93VD67zsy4/YqIqBncerduSbP44BcSszuJ4evhy8v12SWXqoXUovccBLTVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dvrg6ac/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA00606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dvrg6ac/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B5A81F0089F;
	Tue, 10 Nov 2026 01:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273223;
	bh=0nyg+Iauj4/pF5YNDnHiq44Vlbp5kDevUvwfcGDxwcI=;
	h=From:To:Cc:Subject:Date;
	b=dvrg6ac/LU+pH47RV4TDDGqWF/WrrT84AQPy5wq/M6IO3/Wq8RzoIxFe3aUun1Olv
	 09x9cqNPZc6Zz1alzA29y3SiBZmDZcnxgHa+3WLGNEseXu0r4xg5uv/3PgmWg220+b
	 RbD6v4xBENdb/JJKhjSyLC3IIIx/TCbUTzXLTTfyam8HLNx9gbKyJf6tKtuxk0lGHE
	 scSGH8qtcJw9i7dNeBtadZOHNnNJxDrmbJDuWOMIS+w3hQGpfYUxO/HVa9iVPDGMTp
	 SIO9EMCHpXJpG/cSOuk0vLZ/k7AaoKJVTggR0H9UdLy/9bt2WzL0XMFDTLsRtyEkR9
	 9H9myNTJFLi1Q==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	ljs@kernel.org,
	pfalcato@suse.de,
	usama.anjum@arm.com,
	lance.yang@linux.dev,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mremap: fix moving PUD leaves" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:13:41 -0500
Message-ID: <20261109201341-failed-6.6-440c8779757f@kernel.org>
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
git cherry-pick -x 440c8779757f09f290770b1d361dc1516a9d0b3e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201341-failed-6.6-440c8779757f@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




