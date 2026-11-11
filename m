Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434425;
	b=kN2G1/be/6+3JfZaqtivdtHL6Bk2Ynh6Yep1Yzp6tGo5gZuHRcKpy1gKyPR17E+SH/LZ
	 eti7PI0MLXcCH6NzntagVI1lp3P/H4UmUWvp36m9tA2y4Q2UHtjQBCQkdPu4kI5UdgO8G
	 SH9TaLpqUB3WdW1gw024pQEquQXzqY6O2GaJsbEd3tHQES132WfeY2wnB3M1wcp5nLG3F
	 awM9lI79y0w2pb4En+BW61+EKoa5m+2eNPdTfkJB4jWCiNSkYQQjT6+2IOxqPUI65LEQR
	 UYwjGFxqys3yaBKjt4zc5hPQROMJpAMbNqHp6IauENqjBDn4OskbmS7Oq6Qbk5xJNPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434425;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ZHvYGTmbJqczwpKl5nraRSA21m3YoEwNoNnIMQVxtIM=;
	b=wAcLWcQeIae8hZDDU/YfQTy1a99Q/rZcDqfpNpX/VWB8Ayt7ZGmomgOMYOlczP3PSfFw
	 sdLdBTH0bUc1LgU00VHHejzM4X3pBMgJvXy/x9MAFL6BG5cKnVG1nF/kiUBKZJ72YNX00
	 F7kLlb5FfIfUirtfopA04CJ4EqPSzJ6a8oLqvAkx27t9izeGZuUqbGSmCzQQi3RzO8rh7
	 BeM9P9B0rEzcKNfSal9dXwhRwz2Uqty1MFXGzpUDFacLpCF7KMUHJnKmNR8GoJuDwJijI
	 O9TGFecWa4le/ZXSD6EvOFMqbZnT3ia4vrpxLDqc+/fdeglyuKJvAGcIQQVKnBDIi6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4h8Awzd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E6360A3836;
	Wed, 11 Nov 2026 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G4h8Awzd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5363E1F00A0B;
	Wed, 11 Nov 2026 22:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434424;
	bh=ZHvYGTmbJqczwpKl5nraRSA21m3YoEwNoNnIMQVxtIM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=G4h8AwzdWPBd5kXLtPEIcLPvQ1XEyQuMdhORFExWsjdSoCaNtKsy7cfD3LDzBiwzp
	 F/zr+qUwxinhgii6Ov55+l27DkiMmrKtOCqiSmfImRT63WEgM7IMeZtc12uDMHCX//
	 tJ8kF3IWMazWVTjbrF94KYeuJiqa9WwQCac0phugFVC4VBWOuFGHgt5/kCGwQOWtDE
	 tJmZvLYiMtMsry3oI6Of8Xhd+l2bCBFjjY1ax4kIB4m7/fmuV3etcOhrLgFP7IzHT+
	 L8UOZdV06abq0DPr+URdfAWVnUkr9k8h5sxMZjQCN0FeeSr/RySdscpSgh81/KZtCs
	 qETQm6/IBBE7g==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 11 Nov 2026 23:00:01 +0100
Subject: [PATCH 3/3] mm/rmap: fix PTE table overruns during batched
 reference checks
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
Message-Id: <20261111-pte_table_clamped_end-v1-3-2dbe339c487a@kernel.org>
References: <20261111-pte_table_clamped_end-v1-0-2dbe339c487a@kernel.org>
In-Reply-To: <20261111-pte_table_clamped_end-v1-0-2dbe339c487a@kernel.org>
To: Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Peter Xu <peterx@redhat.com>, Lokesh Gidra <lokeshgidra@google.com>, 
 Barry Song <baohua@kernel.org>, Rik van Riel <riel@surriel.com>, 
 Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
 Lance Yang <lance.yang@linux.dev>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Ryan Roberts <ryan.roberts@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@vger.kernel.org, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1280; i=david@kernel.org;
 h=from:subject:message-id; bh=fwx7b+WXIb167Hoov0yJz4Tl/bBR+K10WHa0ZfAYrs4=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLK+PE1depvP59o0LaXohd+F6rhf/LQ5Lrq3XMR35U1NA
 Z1a4VfvO0pZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZjI60xGhomLD7z/ev7Jq2uN
 qp6s3R5uuomPuVXjX9Vv2/148/Fqpb+MDI1HX02/wdpkJrDjDbu8ps4GjZ6Y9bfapLmaryZoygQ
 3cwAA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

With a folded PMD, pmd_addr_end() simply returns the supplied end.
folio_referenced_one() can therefore walk past the PTE table when
checking references to a large folio.

Folded PMDs are uncommon, but can occur even on arm64, for example
with 64K pages and a 42-bit virtual address space.

Use pte_table_clamped_end() to clamp the range to the PTE table and
VMA boundaries.

Fixes: 52e054f71840 ("mm: rmap: support batched checks of the references for large folios")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/rmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 491a954b7fa44..65646ed6fc453 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -973,7 +973,7 @@ static bool folio_referenced_one(struct folio *folio,
 			pteval = ptep_get(pvmw.pte);
 
 		if (pvmw.pte && pte_present(pteval) && folio_test_large(folio)) {
-			const unsigned long end_addr = pmd_addr_end(address, vma->vm_end);
+			const unsigned long end_addr = pte_table_clamped_end(address, vma->vm_end);
 			const unsigned int max_nr = (end_addr - address) >> PAGE_SHIFT;
 
 			nr = folio_pte_batch(folio, pvmw.pte, pteval, max_nr);

-- 
2.43.0

