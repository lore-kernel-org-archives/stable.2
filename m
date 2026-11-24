Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795559921;
	b=Vl5kWNK7dmIY5N4ph0gzc6gcolbJiDG0PD9rfnL1V09wGDcqxYzRMJqKYISJqqfX4Gt1
	 zokwtbslG3yvgUr5Cm+JzlMpM/gdxr6h4+hYpf/0uHmvgsz77vK2pLFA65Vp27ip/yVbF
	 G0Q13xgCRqKy79zLmnfnBtKqbFGx2rE8/PfRlHpTqaTBaObCnmar9l7lt9aNm2nFZG0uK
	 hf6Ielk/Zq8ABzciQq0+5n0Gxwrye8nP/G8TCT6TOxSrlUAqljXuPPJmJ+NfDHdBDIRzb
	 zviekQcEnt+ok9Hr8KnhuZSNbHZ6osLpTfPkHWsq4S8h12ZR1dTwRkRIAzYT/PrOCuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795559921;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yS4oUoV213aJzwOdLaAZIgA17idud59jK82mL576hjA=;
	b=krpPVIJiE+zY4ZvxL0jbVPp+jjK6eiHq9u36iKdDkpnoVCIQspUcvnUKMNOg6RzDleFL
	 2Pqfss9K3vtSAf7lK0reM2SCK5BvekKBS1ZA94pFOwNCkxP678OzpLtuGpL6KeG7zoH26
	 yzVMkAsvLwp1R25y2dCJOGT2zQ+x7mJUeOANTNOkib5rxudu7O35i3I68+JlukziL/aKr
	 GUvWuzHkgmnDd22RYTiHGQz/2VZy4dRcTdvdoZQmeUJzxsE7J58aS0UmMIgs3SpoFXh+E
	 d8Zjg1aBIuJkDwYNNl3vocCeviAXqhapmluPos79Le9GhbFu358QcIPXuu2D3lhiM3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O2T0D20y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5571606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O2T0D20y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEEF1F000CA;
	Tue, 24 Nov 2026 22:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795559920;
	bh=yS4oUoV213aJzwOdLaAZIgA17idud59jK82mL576hjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=O2T0D20yAacV5p2D9TdDF3orR4hBqADPIWIzFVbnx0dJWsfrBTP+KpMScw3XqMpRo
	 OkCihhAUPodjWx+BZi+AvoJrh1YFHGaS6WVHOGfc2ZvdN6m1ac1c0dpdxv//qKOF4z
	 d1kD9qvYJpRBfIeCrnF1Q2Xrjqa65inEaXxiwfsPWtAzZezm8Dyrs/WqXSKbIaAYbI
	 ktIIxWRR/9prkNRU9+o7OIrv9apqF16ksZRnHEXLCaRjvv7LOFZhR+m1ezE6db9tap
	 2lrsqr3BW2nRimTq2++wbNc3q+nLEO4QY2MpyLzc9R2XX7kl/nFgFEWZGv9mpOTA7A
	 OkJ2e9JBD8JFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] mm/page_alloc: remove the zone_spans_pfn() check from get_pfnblock_bitmap_bitidx()
Date: Tue, 24 Nov 2026 17:38:38 -0500
Message-ID: <20261124222701.2814668-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112410-engraved-scoop-a71b@gregkh>
References: <2026112410-engraved-scoop-a71b@gregkh>
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

From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>

[ Upstream commit 2122887b04f3f2d76daa80055c2c273926032fa0 ]

Whenever the flags of a pageblock are read or written, a kernel with
CONFIG_DEBUG_VM makes sure that the pfn lies within the zone of the page.
Unlike bad_range(), that check reads zone->zone_start_pfn and
zone->spanned_pages without zone->span_seqlock.

Memory hotplug changes the two fields one after the other. If the lower
end of a zone moves, the zone seems to end before its last pages in
between. A page of that part which is freed at that moment, on another
CPU, ends in

  page dumped because: VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn))
  kernel BUG at mm/page_alloc.c:372!
   free_unref_folios+0x55e/0xed0
   folios_put_refs+0x2b5/0x530

An attempt has been made [1] to fix this with the span seqlock check.
But that can trigger all sorts of problems in restricted contexts, as
noted by sashiko [2].

Since this is just a sanity debug check and anything with BUG_ON is
frowned upon anyway, just remove it altogether.

Reported-by: Josef Bacik <josef@toxicpanda.com>
Closes: https://lore.kernel.org/all/20261027-pgalloc-ai-hotfixes-v1-9-9c7d1aca801e@kernel.org/ [1]
Link: https://lore.kernel.org/all/sashiko-outbox-188081@kernel.org/ [2]
Fixes: 86051ca5eaf5 ("mm: fix usemap initialization")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261103-pgalloc-ai-hotfixes-v2-5-e0d2890ab74f@kernel.org
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
[ sashal: Moved the zone_spans_pfn() check removal from get_pfnblock_bitmap_bitidx() to set_pfnblock_flags_mask(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 50cb81d42b1c0..547fa05f59472 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -444,8 +444,6 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	word_bitidx = bitidx / BITS_PER_LONG;
 	bitidx &= (BITS_PER_LONG-1);
 
-	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
-
 	mask <<= bitidx;
 	flags <<= bitidx;
 
-- 
2.53.0

