Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534674;
	b=I08JEannt6pxwDVF8VEt8aVM60BT+NCJ/4cSogWoQ1dzn58lxQWxoW7AtjCb2LPukavE
	 51pERgLq2ZUrWDaD/CfvwL+E4JMtfbO2S/idS8g6qMt+oLCg73a7qJTiwXKIKGSHXGEGb
	 OkacX72hLdhd9nEihLaXhPnE77t2TYe41fYxrCCJ0F3mV3pSHgfZqFzeE87cC2v9e53hv
	 r/6xRyM9roq16ELr4ACMnx/4Rvxzr5ssBaxHG+IwNSrgpLAvm8hepHdQRKOn6GjP0dr32
	 RhW93hL5CdmxBw43eVjEXweBrQ+ms1xSOHoFocMA50nO8RcaVQ1DTpSYWq1a9EsqL/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534674;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xi+3zgb6ldnqUYj9HYS4GGyWoPdzWpgl7Oc4nHkZlqs=;
	b=bqe1cYMCsVZJa5WbN8w+3o3lI32I9f5qjL2bwkfWPffxPt3wzNQQSBYw1wSDUadRlU55
	 YLrNIHSUQrckPyvMHCCfW95lWqpGLhyzbiNeUt3cvuSjH82Dj0yIjGNJin3vZ7eAP3FyE
	 VFogu87iCjTFxbLk0AzRmUeA9cC9vY2MIJ2I8SR8PUYjxZJMzMWmI0J5iUIOqT2yBJM2F
	 q/oNQBA0F18qDQjz2fCaq9Onn3MjIo1AS0w1INHt0ygrdWSTQy699idLMo4eN4HLfhdnq
	 IlG9XNn/0bL2AmxH0h+6eQ02SxKea3sckt90MI4H8U4tv5YV3xgD+idpsVTkETMfNew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Inm5TwT8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B037606A31E
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 15:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Inm5TwT8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BAE1F01561;
	Tue, 24 Nov 2026 15:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795534674;
	bh=xi+3zgb6ldnqUYj9HYS4GGyWoPdzWpgl7Oc4nHkZlqs=;
	h=Subject:To:Cc:From:Date;
	b=Inm5TwT8Qcn8MoN2BXmtdIW0v7laUnn8q/EWtpnuD7ewTsZk4jRGJ2VF9lvocaaKH
	 Jgjx8E954jaV98dl8+4aXm18W5nw3grGZ6vWRK34FgLYuSmbaPLI+jqtfc/KDXnEQj
	 PjSDgWDf0//KtwKxXyTXQnv3ybn7FOcZBBZeJurc=
Subject: FAILED: patch "[PATCH] mm: page_isolation: do not take slab pages for free" failed to apply to 6.18-stable tree
To: josef@toxicpanda.com,david@kernel.org,hannes@cmpxchg.org,vbabka@kernel.org,ziy@nvidia.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 24 Nov 2026 16:38:14 +0100
Message-ID: <2026112414-subtract-calculus-aa18@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 213268869301f747d19ca00a391757a6cf2d4fa8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112414-subtract-calculus-aa18@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 213268869301f747d19ca00a391757a6cf2d4fa8 Mon Sep 17 00:00:00 2001
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 3 Nov 2026 17:16:49 +0100
Subject: [PATCH] mm: page_isolation: do not take slab pages for free

page_is_unmovable() regards a page with a reference count of zero as free
or about to be freed. Since slab allocates frozen pages, they will
be wrongly considered to be freed if order 0 (higher-order compound
pages are caught earlier).

If such slabs are the only unmovable pages of a memory block, memory
offlining now isolates the block, this can lead to offline_pages()
looping without progress.

Thus detect the slab pages as removable to return -EBUSY, as would
happen before commit 9aec2fb0fd5e ("slab: allocate frozen pages").

Fixes: 9aec2fb0fd5e ("slab: allocate frozen pages")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Reviewed-by: Zi Yan <ziy@nvidia.com>
Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://patch.msgid.link/20261103-pgalloc-ai-hotfixes-v2-3-e0d2890ab74f@kernel.org
Signed-off-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index c9cc42e54f05..0ab9a6e09222 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1832,6 +1832,13 @@ static int scan_movable_pages(unsigned long start, unsigned long end,
 		if (PageOffline(page) && page_count(page))
 			return -EBUSY;
 
+		/*
+		 * A page that was allocated, but was not a slab page yet, when
+		 * its pageblock was isolated.
+		 */
+		if (PageSlab(page))
+			return -EBUSY;
+
 		folio = page_folio(page);
 		if (!folio_test_hugetlb(folio))
 			continue;
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 5aaad037384e..f4f0571607ab 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -74,6 +74,13 @@ bool page_is_unmovable(struct zone *zone, struct page *page,
 		return false;
 	}
 
+	/*
+	 * Slab pages are frozen: do not take their reference count of zero
+	 * for that of a free page.
+	 */
+	if (PageSlab(page))
+		return true;
+
 	/*
 	 * We can't use page_count without pin a page
 	 * because another CPU can free compound page.

