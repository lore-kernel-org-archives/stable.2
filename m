Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419596;
	b=33HYiFoCkyfGG5A7Wd2Xim0cKEAoqvAenyQuXOGHzPMw7BjDtyChTu24Lz9LVkFAeVRV
	 wkcBGqD8HIw1AI7hSdhhdVfXl7CqT5h8dcB4vXX0O6pHfNxwCC0uRBmcvabuvfD14oo97
	 ze9jM080CZpWrOJTCzmBXKMaqXd7SU9SYupKMwKynXE96Xpv5Jt+ZDk29e0Dvf0tmUGUu
	 G+qxNvzOsY3DF6tGTPW6kGZcMS28oOQiTp4G91m3I/59h9DvaMeAS+VWx4OiQFbvXzkj9
	 zccb+yyVEhNGkP6ZR/DRenNbVHnrCfZbQ72Aw9/57kfKBJXcOF5vY2JAgkMRBNCjuSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419596;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TH7qFfIZmZkGw4LcXefHnScdOxYHr4wYQr+eur5+Xk0=;
	b=4jk2+YroC9bYkxO6ttgV9Q7ydNJA4Y9YaQPf0shqgStC6jde5BPrECbkZ9VPPigm8u8E
	 YTvh3T64zZPSxArgY8AuEwM6u/E0IQ1klgM0Xq+Ypcr7HAr2M9zTli55qslBrVSb46KRF
	 6l5xKZn1qyILf7SlOot61D+GCczsL/cEaGhkkdSqAQhFdsAa43p6sAFNXqJlpMd2j3u7C
	 apGhljgGf7nCOCxpn+l34Pm3PSUveIrKwAEoQRr6vyBlm+GJlhIUPFiKJS6f83q+jypie
	 kb433dPwCxkqj0wF7VxaPkO7+IJAfnW8aYHoQhc3ELOE/EDWRFumST5iTBUr1NtRRDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4oR6uQg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C34E606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4oR6uQg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3884B1F00A05;
	Wed, 11 Nov 2026 17:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419596;
	bh=TH7qFfIZmZkGw4LcXefHnScdOxYHr4wYQr+eur5+Xk0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f4oR6uQgp9iR1bpX8tq+VZP+cgXKurREZSgZfaqyuecYPzx8j0SK2pUFTfs8O0meB
	 yzLRaa/iiTgMWy03TxKiVuXcqRFPAHAGfC2bBWZ++BVyuovze8U8DxzdKtxbDrt6Tp
	 XEGUcrKAGer+ITcGIqy8Y0p8MLNG+pX7Nt9+wtoB1wuAGI/5HC3k9fiueDVGQisDJa
	 5rmDNt1yweB41qZgGi1o8cSJC1z/6UxUuGC9EIMYoZKMmgSI+Cw6EWoH+f7WxMz63a
	 Q/Eo6UGQEGXYPlqGbFPl1yX1B+s1Szs/hKyt6FXWjCIH4SDxpgnysIcUu4/1duFbwG
	 jzCvpATUcwgeg==
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
Subject: [PATCH 5.10.y] mm/ksm: keep soft-dirty when merging a page
Date: Wed, 11 Nov 2026 12:53:13 -0500
Message-ID: <20261111175257.3718842-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202648-failed-5.10-2efc6332f18b@kernel.org>
References: <20261109202648-failed-5.10-2efc6332f18b@kernel.org>
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
[ sashal: adjusted context for direct *ptep access instead of ptep_get(ptep) ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/ksm.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/ksm.c b/mm/ksm.c
index 466ca19997551..bc097bb03c1c2 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1170,6 +1170,10 @@ static int replace_page(struct vm_area_struct *vma, struct page *page,
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

