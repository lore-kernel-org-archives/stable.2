Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794629599;
	b=UKhzuwdpwMLkIV3+mDHi5iLuGxB+Hzso3qFrP5gi8MfJxeCcO2ltYQ241FUWAHLzoqPz
	 7R3iRABOVZRtwLmP6END5ywU2NfqC4qtQD8sbRi25L7WvKtxGJ3JOPa+NUdH04NMf7ZH5
	 Q7WG/BzyIspkfinVhtdkzmQlvQ8hcgcmZpnOzQ13xy/EbxsrqAzf97xndyWfwOt1NIiub
	 G6LviWoDKyvN7HRephz4l6855RpCYuVmMttmVZEfKFXpG3zrK3aMwyUIILOmK3kecIe5s
	 hqdW1pWrbTnJFMbJFPVwE8Yoreqj1YCSoBj2ZWLxDOZZ6haJ+I0XOwO+/QE7+53p3hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794629599;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=tHB01mTlZiMahVMRA5ZCllm3iOdO8KFcrfBN05HIU4A=;
	b=p0XyiXCEBj8A0FGHURHh0tBQD6T5qgCCD/2uHavheuTzgnoH9Mjwu7tpyihY/dbIQr/q
	 DlzMexMMaFwt7WrTOL7YYFMzz9Etnc6Cb3oVGiMmvpKbhxUHXTBJTvxoASs87LTWOxs9o
	 AnnaV15Te8FBlZ5SBoKvmBdEHsC8j+3ZIjmOoBCM4Lm5pVBTMwgevrfOcPAwvkFKgf4iN
	 diQNsi94ftZbQxpsK3cLWR+09rX8HWF0DJ454q9B9JTZ0jqQxONmaWy66lLZPrayuho70
	 oGq/Uuu3e0/z2cnPKvh92+wlxZ0/90huqPhvGmAOC0KfuAGdv4nlD8GtPM3GePn5oMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mU0W43/0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C75F606A330
	for <stable@vger.kernel.org>; Sat, 14 Nov 2026 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mU0W43/0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5202F1F000C4;
	Sat, 14 Nov 2026 04:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794629599;
	bh=tHB01mTlZiMahVMRA5ZCllm3iOdO8KFcrfBN05HIU4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mU0W43/05otlu+C9Yy32xmvpusvfDGJIzO3IbP3gdG2dvXDX5HbWx3aPVrHKnawil
	 qWAhsN2hcSiejXSl0RWtJcenNJBIauWHPupKpEQLJHm8B92J6rGd8QimWLEKqqwbGW
	 MbjTAnsj/4gPENlAeT2LWwfMAvc8NrmRpaLWr23vVmeyVPS140XaEod+3IIOSHrrr0
	 j+X2Rxttmy6Jn479J+7gEPtXlG0BRmi/cMYKyEr2R9QMVB/bmUTYHws6NaNFgHaBDI
	 qEiIAyv+U2PQmNr6leVVviTnY2Fpx1RgvMwQMGgqeMfjJ63vSe2kNDMXWnKorgORF8
	 XXgeruJ4okzSw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	Dev Jain <dev.jain@arm.com>,
	Muhammad Usama Anjum <usama.anjum@arm.com>,
	Lance Yang <lance.yang@linux.dev>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/mremap: use pudp_huge_get_and_clear() when moving huge PUDs
Date: Fri, 13 Nov 2026 23:13:16 -0500
Message-ID: <20261114035316.2633742-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201836-failed-6.1-b4417d08034a@kernel.org>
References: <20261109201836-failed-6.1-b4417d08034a@kernel.org>
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
[ sashal: Replaced pmc->old_addr with the direct old_addr parameter in pudp_huge_get_and_clear(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/mremap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index a13ad0e9c1f84..45341c045b3b4 100644
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

