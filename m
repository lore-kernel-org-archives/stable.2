Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C93452BE31
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 20:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788553957; cv=none; b=BsVdvKjqsvFmuBITLSK7R16tlGC4sgjpMtmEPSHGksgmV4Gq7kv56/nmhfzXx03OD4ZXzlIg9UiShrLYEvSvkjBmbXXSQJq3GjBi0vWdka8KSt+N6PH5GauosArhqxl+ZdGFpcv6/wKvSx9oG96uYhzT8BkywkF0yRwbAroeqyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788553957; c=relaxed/simple;
	bh=MlnvCM/m3ubmuERZ+5fVcmH4xLynaGMJmzQlGt/osus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L8cQxKyR84n9UjG/90cTlf5K3fvYC0YLuFfpUSJQSIiNgxh5DUZq1voDB/Bjs53+X1gUA/U16ghlGyFEDiz+Nb3/5fXJf4ukQR+aTJpSHFY94LwwjBmZipCSW5DbO/JYz8fTj24piJNCpKrF9v4lmkpUVvm8cwGkeDFo3p6aHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bP0rKb7q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bP0rKb7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978551F0155C;
	Fri,  4 Sep 2026 20:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788553949;
	bh=gVHsaUioZgQJvVi4NTJnbdbNS4snvauMWcHHul2CJEw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bP0rKb7qeVs3KkNeohlEw1tgYYpbWsRWnlaq3cuxtdDrKhqtz34uSLaSpj8m+Rzl8
	 QMw2kgDGdLZ4ybLlUeFVCtdM9zyazwmxLGoyVoOxUd80RDnASbevb51ZsSyEAvD+qb
	 yrVYg1w2tWKvOOoya2A0X7giDo+ny2KGR7ApRAtHUX6VGorIzNFpsvOIhnqy4xCb4x
	 lB+ZfHiLXmTTqvaQTTVJap1rDLvLHstYx1ImcCgP2X7FPq46YPiwQVqFW5qaMsmy6N
	 lnXGWxNVFU6OY4zrywUoDgAn4XQkCXr5WrTjzzQ5yJjOnDbODJpTkc8x0pyb73IhFe
	 Cy3kfxoH4ouMw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Longlong Xia <xialonglong@kylinos.cn>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Minchan Kim <minchan@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 9/9] zsmalloc: account for handle size in class lookup
Date: Fri,  4 Sep 2026 16:32:17 -0400
Message-ID: <20260904203217.1548415-9-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260904203217.1548415-1-sashal@kernel.org>
References: <2026090349-deniable-copilot-d36a@gregkh>
 <20260904203217.1548415-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Longlong Xia <xialonglong@kylinos.cn>

[ Upstream commit f7bf5cd5b5f2b13fe2361860880c4e214c08b440 ]

zs_lookup_class_index() lets zram recompression decide whether a newly
compressed object would use a smaller size class.  It currently classifies
the payload size directly, while zs_malloc() adds ZS_HANDLE_SIZE before
selecting the class.

This makes lookup disagree with allocation near size-class boundaries.
With 4 KiB pages, CONFIG_ZSMALLOC_CHAIN_SIZE=8, and 64-bit handles, a
1025-to-1024-byte recompression appears to move from class 64 to class 62
although both allocations use class 64.  Conversely, a 1049-to-1025-byte
recompression appears to stay in class 64 although the allocations move
from class 65 to class 64.

As a result, zram can accept replacements with no allocation benefit or
reject ones that would save memory, potentially marking the object
incompressible.

Factor size-class selection into lookup_size_class(), account for the
handle there, and use the helper for both lookup and allocation.

Link: https://lore.kernel.org/20260809115518.3791787-1-xialonglong2025@163.com
Fixes: 7c2af309abd2 ("zram: add size class equals check into recompression")
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Longlong Xia <xialonglong@kylinos.cn>
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 mm/zsmalloc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
index b63864f5fa398..dde7162701f2a 100644
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@ -498,6 +498,11 @@ static int get_size_class_index(int size)
 	return min_t(int, ZS_SIZE_CLASSES - 1, idx);
 }
 
+static struct size_class *lookup_size_class(struct zs_pool *pool, size_t size)
+{
+	return pool->size_class[get_size_class_index(size + ZS_HANDLE_SIZE)];
+}
+
 static inline void class_stat_add(struct size_class *class, int type,
 				  unsigned long cnt)
 {
@@ -1140,7 +1145,7 @@ unsigned int zs_lookup_class_index(struct zs_pool *pool, unsigned int size)
 {
 	struct size_class *class;
 
-	class = pool->size_class[get_size_class_index(size)];
+	class = lookup_size_class(pool, size);
 
 	return class->index;
 }
@@ -1349,9 +1354,7 @@ unsigned long zs_malloc(struct zs_pool *pool, size_t size, gfp_t gfp)
 	if (!handle)
 		return (unsigned long)ERR_PTR(-ENOMEM);
 
-	/* extra space in chunk to keep the handle */
-	size += ZS_HANDLE_SIZE;
-	class = pool->size_class[get_size_class_index(size)];
+	class = lookup_size_class(pool, size);
 
 	/* class->lock effectively protects the zpage migration */
 	spin_lock(&class->lock);
-- 
2.53.0

