Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794598951;
	b=aNhJhy3J00A1FuAg5kajpi6p/WAMVzqUf5vaX3bCovd6zbF/iKjV0qBsAtAzhnf8WiO9
	 9QHANx1ie0SzeU/0RCW6uPPEYwTN/I+5vc26tlMeiN4hiGdPjGiB4vET6cQk/2tbSNJjM
	 HB0Km3/4oSh6V8jHk2F3yXmgAJG1t9hLtC+1dup2Agxx0pAEwMQ+x9Gu+NaUgCgmsCJe3
	 zLcWg+q8a9eHkPkO5lb/8m4uFsWqehswbGK+G2++6clykcCMS7aD3QMEgp+jPeoYp4eQA
	 LNNA1j5OLVflRcIiShs8ANzTYmz3f1ggSOVA/qOhqy58q/6/N47Yv9jOTI/iZgsNsbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794598951;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ky0cNbwV2unYv6t66+W3VNu2PKE1aGgirGvhVPzOy+8=;
	b=ikzHURYWrjgE6qNUhuZ1vBoFtcVOyu6J+qhP/ntxXd0AFUIs2NNjmaMTnU8j4Ji4u2yu
	 6GHVOFGGcP08ychT5KabPjQPUKGA8kY+UiWG7qQ9wAMBwsoyd/s2VffeBjks019/sB0lN
	 2v8Sw9XJ/jDgSspXtpzp9g4/j1/U4trqfi+W1dCeYJ2HNDTNf7cNZ51w8wwI5JLGDckLG
	 ZJt8fwmIiIjs/T4m6q0IwoJ342MPFh6/SKFOaFkX1ZizWYpON8GFjfMC/MUSwSLr5g1tI
	 W5tLPPdxo5P3ofosbvGdnpFLetJFEV5HxtEFkog8Y2ZpfH5/Eq4tINjvR6g+bNfJjew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VAfyIx1i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D49606A331
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 19:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VAfyIx1i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12BD1F000C5;
	Fri, 13 Nov 2026 19:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794598950;
	bh=ky0cNbwV2unYv6t66+W3VNu2PKE1aGgirGvhVPzOy+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VAfyIx1iT2LEboSelfKsZr/ztsKh84e1HT3ZEJeqTjSw6dnsA7kMCrn6yVpT5At53
	 xpyPAJfgfu1IABMEuPcxgSX0+pxJmowEcOGxdpwn8rhrf5vWHPt8NdCRxoaLTdau9Q
	 rsaL+YkFfZEpOWLF602qcW1gJK0Sy2JFVQBPqc22nCsLbGQav4iHJSwxwPQTzNFZft
	 zn7Yv0N9om7yBluJCwb6QVEDrmWGAQR6oJt66HVKopNeHQu52FwPPeFgZBaPfqIWTT
	 PJ/v1Cd7IjlhlKT8FhJfG4kamMZK+yWW1NvB96t1Z9aM1Yiik+3JHTTLDiYrhdlU3n
	 ehKdKy9zWEdFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Dev Jain <dev.jain@arm.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs
Date: Fri, 13 Nov 2026 14:42:28 -0500
Message-ID: <20261113193959.2446464-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200910-failed-6.12-b4417d08034a@kernel.org>
References: <20261109200910-failed-6.12-b4417d08034a@kernel.org>
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

From: "David Hildenbrand (Arm)" <david@kernel.org>

[ Upstream commit b4417d08034a7b4a3083e0e2d95429d4542524f2 ]

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
[ sashal: Replaced pmc->old_addr with the existing old_addr argument in move_huge_pud(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index d4666f1ab5939..08d0761efc11e 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -393,8 +393,7 @@ static bool move_huge_pud(struct vm_area_struct *vma, unsigned long old_addr,
 		spin_lock_nested(new_ptl, SINGLE_DEPTH_NESTING);
 
 	/* Clear the pud */
-	pud = *old_pud;
-	pud_clear(old_pud);
+	pud = pudp_huge_get_and_clear(mm, old_addr, old_pud);
 
 	VM_BUG_ON(!pud_none(*new_pud));
 
-- 
2.53.0

