Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793298769;
	b=hKZeAurYpac+RGaNLhm91nVbJYpwaRw+b5F6+B3Z9DOouW2GPiTvHVr3F6uk8Wx7ZVmW
	 SsgYdIqunqlZ1yNNTuMwV0bIqwDHf5yxITZPOObldbqH3drjhVqaBK8290xOkcznZLBSr
	 WnakhuTWxCU97ziuGwD30pqbacTXF+hSrQP21A9LfRchpEXLTMTdIm3POIXj85iGlb24n
	 th3i1TFoMfUAYgERZSylxYlVlQoMhv4mouvDPf1sG3r81m8dMiiNivGhzp/mVuBHNajM2
	 P2xPKw52IOznLuD2Dgu4NOJTEJJ6oUHEuvG+n9lRa/aWyBnPtTWDn9Jc464vm9mkFvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793298769;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=8siEiW80N9vi14SdVxolv/f/YD8Btawb+y9/5dfekKs=;
	b=cbb13IPqoExpHVWEBvJ1fOtUcZoF+Um13CCunTZM/8nLKiMDbdgR63wDAgA1LxVUx4to
	 LV1Ql7R/+nFb0oGLaX9dR8+2lD4VeB8SS+1vgcvefjjs0j06i06jATsSiHYqCgLJU8HN0
	 CbVDcH30B/cxVHnX0/NlHTkgUaxwIpM/3PXn1MlvSiORjcXTbo5+latYYCFQA0PSCwYk5
	 Nl0iB1MD7K+WUPqmtwl2jbsZtchGFP5BAjG2i0nWmrw2aO+P9QBTQQoOX9c/1l2IYOssQ
	 S24N3gEm7htKH4wpVnWS48L7hSvqqQGIeqmtOtNke0gE/M5e5tKpBDzum1u9THXzJ/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIkIKK05;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC50606A31D;
	Thu, 29 Oct 2026 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIkIKK05
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793298768;
	b=jM/7uio4+97seb1sV9uove/T6bji7d1kj3Dzkt0jxbY4nTwAv7XHrFBnlea5fq6W85Ty
	 iI0RpNY1goNETnLlntl3p6QdQ5SzKooMor0uMm1uldTtdmpoG3jKFrmOf+s+Kd7E1uPT4
	 vnwI3RFAQ8YVZAGXONr8dG1BuBkB6ACI/1od4uZHLsG/R+E3rmLBwwXK8OThjV8y3Kxzf
	 vjeDGW1P6AKKO8++HzK6OveMm5iJUepoqzk290ymSwxJocI/kxcNRkj5XcxBZSaOCBgAS
	 13baSSsCv/nJM3S7ygWUQjXkfPcEDa8ga/VCl+G19YpSTcPYkxsVpGmJmPGgONlS4kg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793298768;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=8siEiW80N9vi14SdVxolv/f/YD8Btawb+y9/5dfekKs=;
	b=ucQKrqcoBVBeQ7bZRgKre/TLCuitgmjrmu58AtZYV5haH8E7NUNpyB5W/IAhZwP/snQ5
	 ZiyPaW8i8Dch+joQi2XASNvCbaSpjR235GxCYTcabA5Ymh6a0bgapM0/E+jc9da7eqTty
	 gpARp+AxittT0SF//UcuUCWuIz5bLRLY5CwzEvmgW9KPwN6b6XhdvlahJBYMRCvMMkngL
	 JiAHYYU2eYSyTh3oFewKh1GUekq71omTCtUGjR9Sh0rFp/domhqu+a2ufUXej2Nb9akVx
	 e5FSwHydq9g180AbqkUkEFX9Lylvrl5GvocBDAS1ZLHhSrm9Sgxt0Zs4aupznMtg8lw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A173D1F01824;
	Thu, 29 Oct 2026 18:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793298768;
	bh=8siEiW80N9vi14SdVxolv/f/YD8Btawb+y9/5dfekKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=aIkIKK05GV8kayJ/fVVtStE1hQxEf/HIpoVCNW5veLMwhkWp6Jh7u7pcwSc6qVIEK
	 WMyOKauFi/wQfLHshGXREQcmqxGFBA5q1jQUBI+gtnPEtQi7dS1bjG2cu51ruezyG8
	 pD0BgTIW4ykuC/QQU14ofTuMFBa2lxlk+jwEk/vbaefJ+dCWzaaeDeWI0QL1tt5xs9
	 11c1QvAS4F5MNBuIZJqSVznMeJmrh6/p+hSIcAvVaobYVB/r/QQc/zkWL7gVy/ta6p
	 f2mEEIJfe2HgZg+8y/9cwHteJ/i9l9H6xo/qQdpB+SNd9jD30b9MbefVCm0zwZJ4lx
	 qr19VIU/mk4Bw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 0B76E45957;
	Thu, 29 Oct 2026 18:32:47 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Fri, 30 Oct 2026 02:31:41 +0800
Subject: [PATCH 1/3] mm/zswap: drop the stale zswap entry of a zero folio
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-swap-fixes-v1-1-73f73a59f2fc@tencent.com>
References: <20261030-swap-fixes-v1-0-73f73a59f2fc@tencent.com>
In-Reply-To: <20261030-swap-fixes-v1-0-73f73a59f2fc@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <baoquan.he@linux.dev>, Barry Song <baohua@kernel.org>, 
 Youngjun Park <youngjun.park@lge.com>, Yosry Ahmed <yosry@kernel.org>, 
 Chengming Zhou <chengming.zhou@linux.dev>, 
 Usama Arif <usamaarif642@gmail.com>, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Chuanhua Han <hanchuanhua@oppo.com>, Johannes Weiner <hannes@cmpxchg.org>, 
 Mani Tofigh <mt4022@columbia.edu>, linux-kernel@vger.kernel.org, 
 Kairui Song <kasong@tencent.com>, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793298765; l=2762;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=Xn6wBaxs47PABMIOsovdsII1DHl3JPR04Vav6SHkQvA=;
 b=kH2Vbsl0GjvjwSMuOje0D+Ghnvzt7n+7cJTAJcz0EnhxhQ0cz/16dZ3jWFyGPkoZsBr0IS7Xo
 6d7Z3YSUD+fA2vDleYo1OD+QleLPLt7uDPh3RBXaCSXqJYvtaAo4l5c
X-Developer-Key: i=kasong@tencent.com; a=ed25519;
 pk=kCdoBuwrYph+KrkJnrr7Sm1pwwhGDdZKcKrqiK8Y1mI=
X-Endpoint-Received: by B4 Relay for kasong@tencent.com/kasong-sign-tencent
 with auth_id=562
X-Original-From: Kairui Song <kasong@tencent.com>
Reply-To: kasong@tencent.com

From: Josef Bacik <josef@toxicpanda.com>

A folio can stay in the swap cache after zswap_store() has stored it,
when a swapin fault gets a reference on it before reclaim can remove it.
do_swap_page() maps an exclusive folio writable and, for a read fault,
keeps it in the swap cache, so it can be modified and swapped out again
to the same slot. zswap_store() handles this, it replaces the old entry,
or drops it if the store fails or zswap got disabled, "otherwise,
writeback could overwrite the new data in the swapfile".

swap_writeout() does not get as far as zswap_store() if the folio is
zero-filled now. It only sets the zero flag of the slot, and the zswap
entry with the previous contents stays in the tree and on the LRU:

  reclaim            fault              zswap shrinker
  zswap_store(D1)
                     swap cache hit,
                     map, write zeroes
  swap_writeout()
    zero flag set
  folio reclaimed
                                        zswap_writeback_entry()
                                          swap_cache_alloc_folio()
                                          decompress D1, uptodate
                     swap cache hit:
                     maps D1

Swapin looks at the zero flag first, but only when it has to read the
folio. The folio that zswap writeback leaves in the swap cache is up to
date as far as anybody can tell, so the process gets its old data back
instead of the zeroes it has written, until that folio is reclaimed.

Invalidate the zswap entries in the zero-filled case as well. The folio
is locked and in the swap cache, which keeps zswap writeback away.

Fixes: 0ca0c24e3211 ("mm: store zero pages to be swapped out in a bitmap")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
[kasong@tencent.com: fix zswap_invalidate() arguments]
Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/page_io.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/mm/page_io.c b/mm/page_io.c
index c6824fcd483e..65681eed9c80 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -224,7 +224,17 @@ int swap_writeout(struct swap_io_ctx *ctx, struct folio *folio)
 	 * acquired internally by swap_zeromap_folio_set/clear.
 	 */
 	if (is_folio_zero_filled(folio)) {
+		swp_entry_t entry = folio->swap;
+
 		swap_zeromap_folio_set(folio);
+
+		/*
+		 * The folio may have been stored in zswap before and dirtied
+		 * again while it stayed in the swap cache. Drop the old copy,
+		 * or zswap writeback would bring it back into the swap cache.
+		 */
+		zswap_invalidate(swp_type(entry), swp_offset(entry),
+				 folio_nr_pages(folio));
 		goto out_unlock;
 	}
 

-- 
2.56.0


