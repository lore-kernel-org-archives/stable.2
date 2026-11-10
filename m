Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273229;
	b=3426/dH3vO1OeNB9z1xRFs5tQAgZ3kMxAmI1zi89Jnjgh5tWkk8BEqmG8OF6nkjnBOCV
	 UUMEFqMYeRmE1WTxdY6OznelP7E9imNnKXtbAZIED/hA+0dnCglbb3vKzxd4iwApW8wqK
	 pIgxLukAEP+p3VClganN8YpmAaLOCz6JN5S3AWTZV9Tc1NBPEiCAL7g6aycuq6nN/cLLv
	 EH2hL/AaEh4tbBLHha4mjCn+8vAYyUxDX7QqKHfq7gWCQW9csMv/cvjlwyhvVCrv3xhpk
	 +yEJqDgZwJQO5mUm2+wGqRNMI6hRSYrWAXcggElq6VlU34S9N+K7rdAUz21HpaAd23w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273229;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Mw8lZdYuTVIgXmqjwC4czwDN6NYvgrVwSKmDklZ1MjY=;
	b=Fe2Wd001Ct7+kxZW+jM20YefO8kiOyW7xAUjLooBhpICvlnUxx5xeJsJqP7aAF1uhqqv
	 tNJAqoCef+hOI2E2ZHxZCd+ZW48m4O8YoC4vKobVAaGJeyJ/lYtQHWSSXPeJPf+9GNyCi
	 wFk+5P2j+518hjjes7wsBTfHOtHrIwykdVE0D2OoINMVjhUgmscQIevEnbwY7Hfu97tJ7
	 cm2UHFLnmA/EuFviq6FGd2x23if7warObKMujv45/DIsVBLNfnCPAK11WONTGk1t6AAIn
	 zllDdddMBE3gr78WpvPEoCzIAsDe9LDr7twaNwQz36zBrdRCGA7aqAH6BqOArYePaOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkjGojHU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CCE606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SkjGojHU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58D7C1F0089F;
	Tue, 10 Nov 2026 01:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273229;
	bh=Mw8lZdYuTVIgXmqjwC4czwDN6NYvgrVwSKmDklZ1MjY=;
	h=From:To:Cc:Subject:Date;
	b=SkjGojHUapbui7RjoHYHP8qfwbzQbX2SoF1YY8K0Tbxvju6/mWCH2qUUMsYEZBLbq
	 bLJD1xKLx24k7y70aMo8yMrCafD+Y7JKRRs789XOvPkHzSIn1XvjE6JMJQoTYGH99k
	 0o47asOFt/VyXiA8980M9TtGDJFxduGF+LR1w7Jg9rNVJHzrx10e8rjaUwUaNbS1pk
	 6rMCU7jHvWHCdbzVg+qQhnqSK4SihBcJZVfMIqK4Wc3p1zWJUoXG31nxurt29bvLdL
	 15oDbKr4h3WuRpmP2xifsY/J2lSeJ59wVVAqyKoIXtOXqm48THacGLkuMRfxM3Q/J2
	 /GUESgAuhTBKw==
From: Sasha Levin <sashal@kernel.org>
To: david@kernel.org,
	ljs@kernel.org,
	pfalcato@suse.de,
	dev.jain@arm.com,
	usama.anjum@arm.com,
	lance.yang@linux.dev
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:13:47 -0500
Message-ID: <20261109201347-failed-6.6-b4417d08034a@kernel.org>
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
git cherry-pick -x b4417d08034a7b4a3083e0e2d95429d4542524f2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201347-failed-6.6-b4417d08034a@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




