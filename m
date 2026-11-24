Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795554349;
	b=f2PwnUp5yIvFtAVvMsLLpDW/ABKIdFGU/PsB6D7ap3Zippq4dUuPxKzVP7w5Roq8xS9z
	 ihUiUlER9NoBZrJzpGiXL7G7B4VMSX8cGhMGVV7ScKcKQdv2N/mXHC3K9MFMt9GgGoSuW
	 aBxc0TGhOVIfKoiS+kQ19n+2tUsudfdJ3PZePgl8xy1dEDSrfWonzLJ9bg470LkLOb2En
	 40Sf/nW1L2MBPuU0uTMIKJ3NYK3ZEe/AjyRxgSUVMfu6mFJdOzX/WXdxslFp/flkJo5HS
	 YDbNYE96kA3tvUabAuGeihJkcK+Twh6ulLrJM2zAtUepP5wJ5W9HmJuWyDutxc/QnGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795554349;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GfXj0GmbzooYIqa9JPZB+N6SjHC+EDePcDUxQGwOKo8=;
	b=jrlAmjqYdqQBdbNUiqATLK+Vhy0GkOozcIbJ48qV/lbTFO3WGiq3eYLtKES/fO0oaMzH
	 TVPSN+elnMaT+cHa1n5tTFEcvqg1bsEXCZP4tYb53bneDAM3u6K3DDEc3Ma5KY1psJu8t
	 hQmNwD5FAJvht2tVWZDmTKuS03vB0yBx81DGaNefbpIvGkyrBSGLxgJhyiN5XUnvdyEwF
	 pLpF2Z5ftXepmNcny0d17qDjDot9r7LYsBQT8JLCwTlcUzsZ4jwoX7We+Sowus6xsTpOp
	 TyC20dY5X2Gs+0r3fS0+IR6Y6gxAloJpRva+vb9mRhM1OR6m9/uXOhHrmRBishgU0Ew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k5nsZlvS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F0F9606A326
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 21:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k5nsZlvS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 562B61F000D0;
	Tue, 24 Nov 2026 21:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795554348;
	bh=GfXj0GmbzooYIqa9JPZB+N6SjHC+EDePcDUxQGwOKo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k5nsZlvSpe8ZR1qXxcTA6nKCj+hh88o5e6sgzvPpcOowh2HwTk3H8GCLCSmRAoJgl
	 5cxruPfI0vsgk/grBnKxp8GWs3oNTDGNIcscCBVGQ2R/69y2YaGBq9nlg3P6FVuZMc
	 iQ8zyTvbFHnG984dHlM6gslq6iWIHhU+JZb+SJX0xe2R0IhMtS8sxdqg5c8gm9Z+WJ
	 mb02jc835WHh7bvhO74S8HJ6hQTBVDxwtu+2co+bOf1H0tR+aJi4X0/CS/6xnxOVaG
	 T0Zn3GD4i7VGupWpfQnJQgGp0W+4/qVEOm49r0zjopppKjsWWByv9WO0XQjWlD1RRu
	 oQITZ3/lzoYUw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] mm/page_alloc: remove the zone_spans_pfn() check from get_pfnblock_bitmap_bitidx()
Date: Tue, 24 Nov 2026 16:05:44 -0500
Message-ID: <20261124210529.2757387-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124210529.2757387-1-sashal@kernel.org>
References: <2026112410-negligent-mutiny-06fc@gregkh>
 <20261124210529.2757387-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d37596a9c60e9..7351ee684f39b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -399,7 +399,6 @@ get_pfnblock_bitmap_bitidx(const struct page *page, unsigned long pfn,
 	BUILD_BUG_ON(NR_PAGEBLOCK_BITS != 4);
 #endif
 	BUILD_BUG_ON(__MIGRATE_TYPE_END > PAGEBLOCK_MIGRATETYPE_MASK);
-	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
 
 	bitmap = get_pageblock_bitmap(page, pfn);
 	*bitidx = pfn_to_bitidx(page, pfn);
-- 
2.53.0

