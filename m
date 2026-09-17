Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E8D3A1A21
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789613432; cv=none; b=i/ACkY6yB9XZi7xrwKAvJmARWZPawj9QxXqV9V4PlwjdNttT92OQB6+see/Z9eXLCl0V2lvxe3R4Z6zuHaQnXK4GAH5x+B5UfbLDKQQW2Wuj+YkTcSfrVvzd3TLt0eiUYX1SR9S2eg8azToHEUdcsB2d2hKX6BWTk0M/oS8Q4H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789613432; c=relaxed/simple;
	bh=+ZLNKfyoU7MKsW1TkT7z0lTahs4Y0Oy4YErv5cykqQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bsuFvKKesx5iVZ+73ImSuYD3DObCipm3Xed6bO+JwDhiwhitx/4azfsZY1yzvRRkwjuCWsMGe1D89tkglk43xwGCuQVlJ3fDbKHWhckKreYF2jqwGvHguODL3VCkondrV/yDtBAH9cHGuJ3KVV4f94jhiSj/OBLR5tbo956Ykjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UPxb9AvE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UPxb9AvE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460301F00899;
	Thu, 17 Sep 2026 02:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789613414;
	bh=f7E6mrE8/HRMcIGLeMMzJTrtH1+ayEy9OcboAV90iFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UPxb9AvE/AEb+ZcrG7RMgX76ppk5tto5fr74b+bv/nSa5Tf3meJTAN03TFtKvt/YL
	 SWroAor75njU4TeD4FkSE2JLFNiEUW3LvXmg1gBHLz/qht4q5xt03ZnoUSWBjINler
	 nFN4Gw0F5UUfvieU+YoIi63J4xKn4pVk/4qYY9Mvah3MDWErwvA5iyVB84jH9VC1Lt
	 luL9Sa6MQl5I5JAw3Bds11HMyXpx0rJ6aY3OSUITC6EvmeYEE7ZOz91H+UKDjh34ul
	 IHyMsU2aR7G+l5Lklqn1xJ5wrennAum+jK6C7BXHhoD6woEc85spqDJu4C0bFIcl+1
	 GU6ibRjN6BF2w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mina Almasry <almasrymina@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] net: page_pool: rename page_pool_alloc_netmem to *_netmems
Date: Wed, 16 Sep 2026 22:50:09 -0400
Message-ID: <20260917025012.3917055-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917025012.3917055-1-sashal@kernel.org>
References: <2026091638-excretory-liquid-7149@gregkh>
 <20260917025012.3917055-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mina Almasry <almasrymina@google.com>

[ Upstream commit 91a152cbb49c26609d217cf2f116d46143b9b8be ]

page_pool_alloc_netmem (without an s) was the mirror of
page_pool_alloc_pages (with an s), which was confusing.

Rename to page_pool_alloc_netmems so it's the mirror of
page_pool_alloc_pages.

Signed-off-by: Mina Almasry <almasrymina@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Link: https://patch.msgid.link/20241211212033.1684197-2-almasrymina@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: b814dfbfeb0a ("bnxt_en: Propagate TPA buffer allocation failures in bnxt_queue_mem_alloc()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/page_pool/types.h | 2 +-
 net/core/page_pool.c          | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/net/page_pool/types.h b/include/net/page_pool/types.h
index 7fae0d4eef5eb..092e52b7eba70 100644
--- a/include/net/page_pool/types.h
+++ b/include/net/page_pool/types.h
@@ -252,7 +252,7 @@ struct page_pool {
 };
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp);
-netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp);
+netmem_ref page_pool_alloc_netmems(struct page_pool *pool, gfp_t gfp);
 struct page *page_pool_alloc_frag(struct page_pool *pool, unsigned int *offset,
 				  unsigned int size, gfp_t gfp);
 netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index af4c7e62fe8d3..ce35c859e0ffb 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -673,7 +673,7 @@ static noinline netmem_ref __page_pool_alloc_pages_slow(struct page_pool *pool,
 /* For using page_pool replace: alloc_pages() API calls, but provide
  * synchronization guarantee for allocation side.
  */
-netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp)
+netmem_ref page_pool_alloc_netmems(struct page_pool *pool, gfp_t gfp)
 {
 	netmem_ref netmem;
 
@@ -689,11 +689,11 @@ netmem_ref page_pool_alloc_netmem(struct page_pool *pool, gfp_t gfp)
 		netmem = __page_pool_alloc_pages_slow(pool, gfp);
 	return netmem;
 }
-EXPORT_SYMBOL(page_pool_alloc_netmem);
+EXPORT_SYMBOL(page_pool_alloc_netmems);
 
 struct page *page_pool_alloc_pages(struct page_pool *pool, gfp_t gfp)
 {
-	return netmem_to_page(page_pool_alloc_netmem(pool, gfp));
+	return netmem_to_page(page_pool_alloc_netmems(pool, gfp));
 }
 EXPORT_SYMBOL(page_pool_alloc_pages);
 ALLOW_ERROR_INJECTION(page_pool_alloc_pages, NULL);
@@ -1051,7 +1051,7 @@ netmem_ref page_pool_alloc_frag_netmem(struct page_pool *pool,
 	}
 
 	if (!netmem) {
-		netmem = page_pool_alloc_netmem(pool, gfp);
+		netmem = page_pool_alloc_netmems(pool, gfp);
 		if (unlikely(!netmem)) {
 			pool->frag_page = 0;
 			return 0;
-- 
2.53.0

