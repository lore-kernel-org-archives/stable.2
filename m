Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419139;
	b=4IFvzVSoq55T0bxYTuKeeZv+GEUaHm/WJ36szh3mNiBwgL00c2fCEu854CO9J2Im8GSH
	 s3/6AIOMoxiR7DzkKdtisCp0Z8yvGsWa72EeU2tbdFRbIHcvhcmG3sPe+sHjvvMRmx3a6
	 srlVBloXzmWr7G0vU6MJ+158C5FaeCxLwmDvFcognPuGDiCsperDGRItgsSzsBulPRIiN
	 SlUJpsgffBhWOmD3dlmSz3PA3XKfy5OQOSivhHc7X9NW9h0EWjyV0ZjavDKHLPy3VRnEM
	 /dFJHhTVF+axgU77dFfyl/4A1u2GlatnprGfsNFA/fHyY0/jAxwm1eLYVAakExtPpNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419139;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cVZMS7plCFhcLSpzUPKcqs16DyXXNTzX3X1i67/v02I=;
	b=ZMYmVdZpFUw3RgFcnUMrXtpJZuTexBX7FP2HwCxG+U66mt6F6dIJuIvZxu1Ldyx9wYge
	 m657XM/aMRjRmBE2lYZMm6VDcXZwPxq6Cpi3fNcRaDP/TdL1FRY2etRsaO8fDm1ZQEXrB
	 HiOXFkM7+US/0yQtHxm3z4Ubm8BLPkxoB7LjFbXn535flqJIVxGkAyCSqM9HCSooAqXbw
	 /pEjS8u9Q5TCXJu49iaz4t244kFHcsg03eot8YB+GMKuItx+j8ovF2mC4SLUpeSEhLMyG
	 O91MJYWwI2h2zsV5ElfwU1tNYtg3SAaf+DQVWgVAwppIyzZuClA9Mz3hWhVlYhLhcPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmmvhFGJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BCC4606A89E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmmvhFGJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260271F00A0B;
	Wed, 11 Nov 2026 17:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419139;
	bh=cVZMS7plCFhcLSpzUPKcqs16DyXXNTzX3X1i67/v02I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PmmvhFGJxzskSobyrH2XfiI2XvB0Ze4dQuaGF9DgJMuK3IM5KzUMEleWeefyVyrBx
	 XPKfmYuwP0RTiMAx/RnH/WBikiarqTsYVRNu02iBHKyC2xKaR3BTUhaXlrvgy151qK
	 vl1m+gqJTM/Szl+SGAgxW+o/676Eekp9hvmrFaONgkcNBsEw/3wIaV69sow3CKnewN
	 qbdDKNYDDhXeqMhXRYZ+vX6ngOnFPPbfcLDtgYJwg/U+FrG1mJ3ED/275NVkrqi1D1
	 FRN9TQd5dD+8FGzbdIJj+n+KmXNClcSerl/rBeMAYybgFEufn6fK6GL8ODFrQ4RKZb
	 kdlTMUan+Fbag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Samarth Narang <samarth.colleges@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lance Yang <lance.yang@linux.dev>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Xu Xin <xu.xin@linux.dev>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Peter Xu <peterx@redhat.com>,
	Kiryl Shutsemau <kas@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] mm/ksm: keep soft-dirty when merging a page
Date: Wed, 11 Nov 2026 12:45:37 -0500
Message-ID: <20261111174518.3654526-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201702-failed-6.1-2efc6332f18b@kernel.org>
References: <20261109201702-failed-6.1-2efc6332f18b@kernel.org>
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

From: Samarth Narang <samarth.colleges@gmail.com>

[ Upstream commit 2efc6332f18bfd848f74f3d5ba45b31450601faa ]

replace_page() maps the KSM page with a PTE built from scratch, so the
soft-dirty bit of the PTE it replaces is lost.  A page written since
"clear_refs 4" then no longer shows as soft-dirty once it is merged, and a
soft-dirty based dumper treats it as unchanged.

Copy the soft-dirty bit from the original PTE to the new PTE.

Link: https://lore.kernel.org/20261021182157.1873726-1-samarth.colleges@gmail.com
Fixes: 0f8975ec4db2 ("mm: soft-dirty bits for user memory changes tracking")
Signed-off-by: Samarth Narang <samarth.colleges@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Lance Yang <lance.yang@linux.dev>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Assisted-by: LLM
Cc: Xu Xin <xu.xin@linux.dev>
Cc: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Peter Xu <peterx@redhat.com>
Cc: Kiryl Shutsemau <kas@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: <stable@vger.kernel.org>
[ sashal: Adjusted context to retain pte_pfn(*ptep) instead of pte_pfn(ptep_get(ptep)). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/ksm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 99eb19860fd59..c976e41f853b0 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1178,6 +1178,10 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
 		dec_mm_counter(mm, MM_ANONPAGES);
 	}
 
+	/* Preserve soft-dirty when replacing the page. */
+	if (pte_soft_dirty(orig_pte))
+		newpte = pte_mksoft_dirty(newpte);
+
 	flush_cache_page(vma, addr, pte_pfn(*ptep));
 	/*
 	 * No need to notify as we are replacing a read only page with another
-- 
2.53.0

