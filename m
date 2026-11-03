Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793722706;
	b=cGP3fujxTVf49BrzmN+4mZHE4yzoMavEbuyBfIay1tk9/JnzqTu0+rkiJ9iT8KFywhi/
	 LE7qKWM3vavZatsuZg7u2MiM50xJ1pG46sirIWwfbejOdgJV0EcKzFCG61sAJKKILtXx/
	 Cn5J2DD1Q9tlliszqXditEGpfmiwWxRln9WepnYDZcPqHX6N9L4PSHds/JWro+5O4D0H/
	 XYlSxuA87RQ814IMmwv3BYOSQPiwYsEV8X1SQg7vaLY7Kh/L40fUf/xpeXtpozTbNwg/I
	 Kk+Rg6MkWmT6m99B3T/3yue4Nw3SsTg/WY3hfXM0ldZZnBbN2OzgqnAV6eOrikLn+Fw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793722706;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Endpoint-Received:X-Original-From:Reply-To;
	bh=TIlg5+Jr+rE39YU9MasG/yuhvLUgY4s1vPHwCpCoHYw=;
	b=t2H+f3R3rlHWiuqlgm6Tu1aU/WfIWsKkuFoeViW3+XB/g4AZNNqz9mRHlibQ+pK63G6J
	 U7IpOD1tbst2c/+Pc1gMva1KDnI2fDK4D0hw1z7pe7wanpz+440BKlrftGoX0gB877byD
	 /7mHC8ZaKqgyqNTw7QNNrhlXeu5q0Bmgo0cbl9cgicYFYt/Kgje/QQG4LoMhCBeKkgvHa
	 sOcqpx9AiycveyJk/Uixy96X0WILjMz9CihTkQjkzvkWenutRDSqJlNnpJvFRzjgi8zMH
	 Ynop+qlfu6PJGK01D7KuP/uZolw7RiW+hiVb1i6JORnKVCEREgOfH4fhYy/Qh1N+pHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I666OMCZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05115606D819;
	Tue,  3 Nov 2026 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I666OMCZ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793722705;
	b=sZbthj0I6I9c5Yi52Mwu/N+vrazO8TwK74TZBIb61+UZ8oZtkPfpxCtqBHX/ehWgA3BO
	 QUei4g/tpJ7tHO2+i6MIrKBVc2/aXoXjY2dXyhtV28W0V09ie0ASHrC8Wr9D0mcQgMt6G
	 Vvy7s6wKXw4zt8JFwdFKugAHeow2yJdcIkg9R0r8uyn2vRREzk94E3BxnByRMZ3LgMnHT
	 1lJ+IAaQ/LjRqg1RT0QXP7JyhMS+sucTf4WTykqTUJUaK7Uv6lpJ8/YwyNMLZmbLJ2Yu7
	 IoASEX9V1B5wi2hOd78Q2uCO2Fmz/mPdjjO/lw3JgLg6OjwpRoE02CjdIMhRjkP4GTw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793722705;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To;
	bh=TIlg5+Jr+rE39YU9MasG/yuhvLUgY4s1vPHwCpCoHYw=;
	b=JSFlhq59ychgGHrcfXqcE3kVdS3iVtKRp4PWR7oO6QMyKf5EIUxqgQ6Tb+krhp0iTcWL
	 Ljqmd54C9KDOJB3SLDV3m6kkrTTNaDfHE7snTaGcHfEtTGA3PK+fyGiQlRh3IzV9UeDEq
	 1XYJMzn4pudf+J6P0ZbQTnENIWlwWagz4GYvNtWyu0QWVPAgHsW5Lzm8nv/vEb42/cgFA
	 pVu+sQVXYe62ItxM6kELnn3ltCoyb03Nz9YrHM1hhj3cN6N8Lh6TAEJJZlxDLrk7WUinC
	 sRtkflGBk82ZZD5yP8oez3kR71aYHejnLTnA+q+CE6w6MH2gEHS++gqmPMkhqTZPQ/A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F1B391F00919;
	Tue,  3 Nov 2026 16:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793722705;
	bh=TIlg5+Jr+rE39YU9MasG/yuhvLUgY4s1vPHwCpCoHYw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=I666OMCZwN2Zl5HxaGVFOwcRY7UqL9cjjD4lBglUgCN3rjmbzeVfbtjUieDusr5Au
	 oaHxUonpjkvqh+oX9i4bZaq7Jvde1WbYQP3mKhx/rBkR7KxRsCVi9E6d9wipbPf9ZO
	 uZ7tMfz3ewZVRyOu6p3csy/v+/mYP/Alton0tAD97DcEZLBWoylrC1VqOh14n4BkXL
	 k19y9QOqWvrDSxdP+vzQE3bxyZ3UUva97OOWhdohE4DAg8I3sG//r+5pENGK23e+gD
	 1cKODou14+chmkI2WK0QsCFkUPADFqwgqXR/RS3SxrGVQWTZcraXJIOUi7xkZcIUEQ
	 qthkP5NIp8ESQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 5CA5146A0B;
	Tue,  3 Nov 2026 16:18:23 +0000 (UTC)
From: Kairui Song via B4 Relay <devnull+kasong.tencent.com@kernel.org>
Date: Wed, 04 Nov 2026 00:18:14 +0800
Subject: [PATCH v2 1/4] mm/zswap: drop the stale zswap entry of a zero
 folio
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
Message-Id: <20261104-swap-fixes-v2-1-204be064be5b@tencent.com>
References: <20261104-swap-fixes-v2-0-204be064be5b@tencent.com>
In-Reply-To: <20261104-swap-fixes-v2-0-204be064be5b@tencent.com>
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, 
 Usama Arif <usamaarif642@gmail.com>, 
 Chengming Zhou <chengming.zhou@linux.dev>, Yosry Ahmed <yosry@kernel.org>, 
 Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Chuanhua Han <hanchuanhua@oppo.com>, Mani Tofigh <mt4022@columbia.edu>, 
 NeilBrown <neil@brown.name>, Christoph Hellwig <hch@lst.de>, 
 linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793722701; l=2902;
 i=kasong@tencent.com; s=kasong-sign-tencent; h=from:subject:message-id;
 bh=5JIfvqgJZSkDLS+9X8sNXJzSR9p+F+l9mzgjMoyRQf0=;
 b=nnIkmk/QGTpjHCzmkNn8ZZTzaxluVqlOIuUU6+PAEz3ckDifiSnny/fyr9FzDbFlimey9SHP+
 EbB2jPyII0rACVUq8xQ3eS4VRNg/1DDZ3CFhSZzZONMVtqLoOMRKBgI
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
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Reviewed-by: Nhat Pham <nphamcs@gmail.com>
Reviewed-by: Yosry Ahmed <yosry@kernel.org>
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


