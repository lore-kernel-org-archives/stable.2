Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272953;
	b=GUCo0qqOq/+OKxXxgO5lWAFKR1selPCaOnCG0D5mLjjqvfzEtsHfSTMRBMSHDOyPhWXc
	 XtsUDm1wsHYHPIDLfX8+B2XHq9EDIzW4CMaJynKmXhPV9aPzfMY1UJQ6kdQ9Iojf9NSIJ
	 I4anzgFey6HZPMwW4cV6bu8wjaEtPlKuy+wY6/Lq/Q8//+M5Ek051skFK5uKrSImqitXh
	 sk7umzU0A2IXqmZyHLx0/E0kZy7CkxqRNB2iVcg6fbgfbi0hnVNWynihE7Lq3XkoqJjhj
	 SbR9f/XZcW69dZF1sNqnMULzzkBpR5NWKeLJ7+4h8QizUgHCT4qDp9J2HA5lfypvNNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272953;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=KvEQ8YbqcwKCR6YENq1V2CFQo6ebfTSdSccUR467r4c=;
	b=KH6tCWSMYGgKWsGDcNBFfa6zvFpyHdjBFCT0rHOhjKiEhee9Dx5BbR0kq5XjPI/9/vmo
	 smd9nnojjStik4swYKhLPZtKkne6bJgsm7YIekBjBYkUkvhMfjtAADwXc/M7g72OZSA2d
	 1A7na1ctH9dDKGDS6hWuIK1gE+CNhazGd/HTsGGIQcJjcGKckDQ9soAQnvea2YezS+40G
	 +k22QAxMEbfqGIcQRWWOFYsbQEKx6rlSEiMmSbpmUlXKhLVYkeFgXkTU6fIBo+zdyfGt7
	 lMUiUNQ5l7XqkaRMPrSinDDy0/7ZLw/GGPI45jwcAXTAsWOoqppS/igg/oSPwYEkCaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dceyUZjq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD14606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dceyUZjq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6311F0089F;
	Tue, 10 Nov 2026 01:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272952;
	bh=KvEQ8YbqcwKCR6YENq1V2CFQo6ebfTSdSccUR467r4c=;
	h=From:To:Cc:Subject:Date;
	b=dceyUZjq7690UdFu16nqG92fkVKm8oX4pcEfHCTWGc+3i1qLaGNXsilJmJywRsFqD
	 KsodnFPfIoEl72bZCROlkbQfo2+w3Zt6IncyKsaINVD93VtPqr21DT1T9bNZjX+xaP
	 +GlnBbdLUjedUElOmD5LIYiktpAvzA4nTs61qAz2xPdmjzLGe0uqxuU38uUL36GqmQ
	 AvQEsuKLgAniam+XrmgbW8euyarsODapW0Dbb7GmA3rMVpdHQRPzkuYPrqIEyLyzOk
	 oCdqbKDzdsRQ4C+jqgkhkHv3vQ4GXaP6ytCF1UEuME1NCGKkZCL4Ixtbr9wfYMD6+h
	 zFn+hyn6beLng==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	ljs@kernel.org,
	pfalcato@suse.de,
	dev.jain@arm.com,
	usama.anjum@arm.com,
	lance.yang@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:09:10 -0500
Message-ID: <20261109200910-failed-6.12-b4417d08034a@kernel.org>
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
git cherry-pick -x b4417d08034a7b4a3083e0e2d95429d4542524f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200910-failed-6.12-b4417d08034a@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b4417d08034a7b4a3083e0e2d95429d4542524f2 Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Sat, 31 Oct 2026 10:39:59 +0100
Subject: [PATCH] mm/mremap: use pudp_huge_get_and_clear() when moving huge
 PUDs

move_huge_pud() reads the old PUD and clears it in separate operations.
Hardware accessed or dirty updates between those operations can be lost
when the saved entry is installed at the new address.

The raw pud_clear() also bypasses page_table_check_pud_clear(), while
set_pud_at() accounts for the destination mapping. This leaves the
checker counts unbalanced for mappings tracked by page table checking.

To fix it, simply use pudp_huge_get_and_clear().

Fixes: 7d846db7d0e2 ("mm/mremap: convert huge PUD move to separate helper")
Cc: stable@vger.kernel.org
Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Dev Jain <dev.jain@arm.com>
Tested-by: Muhammad Usama Anjum <usama.anjum@arm.com>
Link: https://patch.msgid.link/20261031-fixes_core-v3-30-d6437171ecc3@kernel.org
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/mremap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 0d06d7f37f19a..16e736c72d9cb 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -509,8 +509,7 @@ static bool move_huge_pud(struct pagetable_move_control *pmc,
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 
 	/* Clear the pud */
-	pud = *old_pud;
-	pud_clear(old_pud);
+	pud = pudp_huge_get_and_clear(mm, pmc->old_addr, old_pud);
 
 	VM_BUG_ON(!pud_none(*new_pud));
 
-- 
2.53.0




