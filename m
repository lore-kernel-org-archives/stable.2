Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795561089;
	b=fHRhJBUfGTzmrNRhNjjRs97X7IRht2OHubDs7msF9r9NHDbV0X7vAJAiuWnsaP+S+llr
	 7dkjeX9hQKo9sRQ8MA1V9ViK7dvm/7fQ3SvAwSI/I98c/5MnY/pz7vbBOfQUUtxNss2eR
	 6o5GtiC77rhr7zKZX49hmriMo3kdCGeplVdAZTbqehDYoLJeCrHWgiIhhamQOJ8YWlR9e
	 QIN/rdwikXwkvGj9fiRtJk8rbt+McwMGpjHuZrqH3x98N+MXQ5s3DYUWy+6HrS1pffnsl
	 WHn89aEl1qRJi2HPt2+ECwthdCngeejJi8UQCUji2uzujjdezu1IaVBcXCxAK3NZhXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561089;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=jbz8BDMY/2CA7sh3v0yfmrVut07KC+6h2R36fcNxQIU=;
	b=nz7BDaK8UEZOyKgLjnnTKNIFYNSxFL4TdPo/d8jd0WEgniCGTg3MIS4Qm2V9MfpWgaeC
	 bzI86tPHP055GcgDhJfUv/A8ciiztkxgax6K8tBNutONsVUZVvAE/zL8gaANvC+2raPIP
	 Rj24lLqnGUMhniAFyRqFWOJUKbACAybHtMo/d64+TzcFREuQ8KG1O/yEIeTmc2znUwpmR
	 GwH9A3OzuJXTihTA+GUVf7AElzlI4+EY187fgbp51LRFVpIwuZhzSXCK5RJQIcQZ2uCGf
	 H4BEZLjqrH8DMz2EkJRBKiR51nuwn8GXOjDltwcW7hfvaYdblwMo4+S3fPv7vEt1qig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhVkDzkl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBB8606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 22:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XhVkDzkl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21E81F000D2;
	Tue, 24 Nov 2026 22:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795561089;
	bh=jbz8BDMY/2CA7sh3v0yfmrVut07KC+6h2R36fcNxQIU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XhVkDzklTfaCWfgnVU0AbcZhY8TwO4OwtFvcYE+OZ1H9PIaxIys1Bybdwpg5vHcCz
	 ixrtc+TcNCNzGKctzvm8mg5clpukv7KhfNvE1jdSlKE8rbYDB2BQOpg8+WFSxk70Ve
	 mYmnMc0W0A2XeuPEjhkWO9odiYQk1GSJ2CvF8ttsrxYbetrHVk8/UCnwfw/BQjAMok
	 GhYpc5xJZ52R13CkAa0CRx/fXEP6kGKUqIeC3xpdmq8/B7ntfR8j22OhsqFJK/hQpd
	 jng3GqN3Zu+JzvX/XySlKJ2dyYpUYFxf2uGybv0jnY7xh2VVeCmaDsXyfEHDjycMLc
	 662RYzWJ3Z0uw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] mm/page_alloc: remove the zone_spans_pfn() check from get_pfnblock_bitmap_bitidx()
Date: Tue, 24 Nov 2026 17:58:07 -0500
Message-ID: <20261124225747.3162307-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112411-resolved-runway-7889@gregkh>
References: <2026112411-resolved-runway-7889@gregkh>
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
[ sashal: Applied the removal of the zone_spans_pfn() check in set_pfnblock_flags_mask() instead of get_pfnblock_bitmap_bitidx(). ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/page_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e58f3f514e640..e72413bfce106 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -545,8 +545,6 @@ void set_pfnblock_flags_mask(struct page *page, unsigned long flags,
 	word_bitidx = bitidx / BITS_PER_LONG;
 	bitidx &= (BITS_PER_LONG-1);
 
-	VM_BUG_ON_PAGE(!zone_spans_pfn(page_zone(page), pfn), page);
-
 	mask <<= bitidx;
 	flags <<= bitidx;
 
-- 
2.53.0

