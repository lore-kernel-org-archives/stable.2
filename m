Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274094;
	b=Ttg6iJWgm8VNvUDmG/CEN5ubUeMhj4PbajxLy7e4CVvI9vMpro46ousaacsWcxUxBNhK
	 kqLZxWQtpeVcw73TPC0PXsk9ipSlbzUykUBjetXlQ4JvvnhnZs1Bfz8TAJZQpc1pLoQBJ
	 eV3ri3aW7XebNPnZMaobuWRUvjOpO00XLV58XAJoEgjrKT+Xhp6z1kz61VOhI+R0hcw4m
	 wwJ/y4c4wygmRhkJFk1dqSosvMDS74UVy3LWREGiwVAj+f0oqvXSPxGspTeeZtwUnf5nz
	 n16ZamJ7R0u4MULFhllCOXvqVc7vdVkArOQkIXPKIdWlYSnvOHf0SF0u6IJqW2scwRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274094;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sTXBY6eNKjYWIkKR6DwGxXPUm9eKmW9PeWlJ4g4p2UE=;
	b=X3Ir7RtGF1eM1qpaHkXT0iwuE1K+SNK6X3aVjVRUIUgdYOXLatvhVNW3ZPhAcis5bBXw
	 6xWOaqTgUbOKeIzaV9EopjxKbasOkUxyavtCb2YgWk/7uR2YBBPK4OP8foi0iMvQvewRA
	 HKHGCvgGLZTVRW19f7X9rQr5fLND/mJ0e0DkOc4xxncytL1bXl3X4Ul1S/wAooD3AqRcT
	 yHzU0yYnHuRD9GvABpTxHhtWNWf2Y3wuJyEGltOazqPMCzaFyC54q+OX21hvmOE/BLWb1
	 ZTdVHaLT74QYlxbRQ02RxuZtRG4fAowuHXUTkrjbEyfSmxSNBRUbeX4Uy5TD/RlqlFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nCv3rJ8A;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF67A606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nCv3rJ8A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE321F008A2;
	Tue, 10 Nov 2026 01:28:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274093;
	bh=sTXBY6eNKjYWIkKR6DwGxXPUm9eKmW9PeWlJ4g4p2UE=;
	h=From:To:Cc:Subject:Date;
	b=nCv3rJ8A30JccZLiVCpbsxv2PDqWDH4WKC9t4tGv8EhOsjxfpvMLK84JKmZARsEIz
	 YA7Z8kP5VojWmEKIw0zypzsTR7gyYCEZRIIkoshRNv15EKfy8A3KsT5CpyK2UBFTih
	 0A9+SKHRbS2owvZmyrbeyc17MczkaYrsApKavzTqH9IzZSS0Eq43pFfcg1BRYdoB8k
	 sptMjV1YMZnJEcEgDHrLUZqRX4vbsX3UofvVQzOc9EAsjR/zKDwtl0YxscYiPD9ftf
	 ahlwnBM82KKiwFTmJjtDVLlkR0RjgcBaApw/NCpFu9TT1LXWng8zW8xBxo+YytVuGL
	 +lSTt0AYLr+zA==
From: Sasha Levin <sashal@kernel.org>
To: josef@toxicpanda.com,
	ljs@kernel.org,
	pfalcato@suse.de,
	usama.anjum@arm.com,
	lance.yang@linux.dev,
	david@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mremap: fix moving PUD leaves" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:28:11 -0500
Message-ID: <20261109202811-failed-5.10-440c8779757f@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 440c8779757f09f290770b1d361dc1516a9d0b3e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202811-failed-5.10-440c8779757f@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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




