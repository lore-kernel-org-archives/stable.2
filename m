Received: from mta0.migadu.com (out-46.mta0.migadu.com [91.218.175.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF2546C837
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 07:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545343; cv=none; b=KJ4dN7246fGIkQr7gC/uP1Kcj4sZwP0PEFfTGcVFvy9X1wu8psUdujYAzBdErqHrcB1KEPEF+Zjo8i+yuFavrwVSe5suOQrzeipDKG8YXqYgZZ0hYjYHoi7WNFm9VXwrttauQraBVFgP7VX1knj2vXdk6ALxeXLzpn1SvpV6oy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545343; c=relaxed/simple;
	bh=Gy2Ww2TXVYXoXh9qTH28gt960gctPg4lRt01C40cxiA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OaMCJcbDYspfQpOY7eeA+aDZToD2yrt0ualgiJ2nUq5j5tTGKqqAuVDIvxNw6wriK2KLCZfIa166KOLRbflKaq640szYg68WcPiJd6fsa86XKosgqjTvMUi28xSPbvuvp3lVa+T7uuVnymxwkkzptegcgA17cAa7D7erP55XszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QVSEMd6P; arc=none smtp.client-ip=91.218.175.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QVSEMd6P"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Gy2Ww2TXVYXoXh9qTH28gt960gctPg4lRt01C40cxiA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789545322; v=1; x=1790150122;
 b=QVSEMd6PqpzHY7q0hnGKXXCWWQUVkCWYEmcmyGW3nrQcS0N39+QTMs0MNNqyFMDK0jRh6hjX
 1OPIxq1Iq8r2s6KkKRgQmIGlIYTXH6LypKtnQ9mATen4uDneYuP2veRRWgHfBJ1QievtkEimite
 YtWFdubl0wdASnkqyGAAQ6n0=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5bc0a2ec64a68065;
	Wed, 16 Sep 2026 07:55:11 +0000
X-Mizu-Trace-ID: 5bc0a2ec64a68065
X-Migadu-Flow: FLOW_OUT
From: Hao Ge <hao.ge@linux.dev>
To: Suren Baghdasaryan <surenb@google.com>,
	Hao Ge <hao.ge@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/alloc_tag: account for reserved tag ids in the kernel tag check
Date: Wed, 16 Sep 2026 15:55:57 +0800
Message-Id: <20260916075557.121316-1-hao.ge@linux.dev>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The tag ids stored in the page flags include two reserved markers.
Id 0 means the page has no tag and id 1 means the tag was cleared,
so real tags start at CODETAG_ID_FIRST. The kernel-side check in
alloc_tag_sec_init() compared kernel_tags.count alone against the
addressable limit, so with the count at or just under the limit
the last tag ids wrapped into those markers. Pages allocated
through them then look the same as untagged pages on free, nothing
is ever subtracted from the real tag and /proc/allocinfo shows
that memory as still allocated.

Add the missing CODETAG_ID_FIRST, same as tags_addressable().

Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compression")
Cc: stable@vger.kernel.org
Signed-off-by: Hao Ge <hao.ge@linux.dev>
---
 mm/alloc_tag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
index cfa0fc84b68f..cf100e7a852f 100644
--- a/mm/alloc_tag.c
+++ b/mm/alloc_tag.c
@@ -629,7 +629,7 @@ void __init alloc_tag_sec_init(void)
 	kernel_tags.count = last_codetag - kernel_tags.first_tag;
 
 	/* Check if kernel tags fit into page flags */
-	if (kernel_tags.count > (1UL << NR_UNUSED_PAGEFLAG_BITS)) {
+	if (CODETAG_ID_FIRST + kernel_tags.count > (1UL << NR_UNUSED_PAGEFLAG_BITS)) {
 		shutdown_mem_profiling(false); /* allocinfo file does not exist yet */
 		pr_err("%lu allocation tags cannot be references using %d available page flag bits. Memory allocation profiling is disabled!\n",
 			kernel_tags.count, NR_UNUSED_PAGEFLAG_BITS);
-- 
2.25.1

