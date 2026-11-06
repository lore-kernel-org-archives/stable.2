Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980641;
	b=j6Pt76tV9tzt9nWaFHb4m4aAV2FatiX9dhnteEXvEYVI+Gok1BqdbXn0rdzW+jbXv2Iz
	 7/54mvP9gSaxuL52wIidtQs38f0lHlBOhIJYyJd8AyK+L2FjWCRgrTeNEwtrE5SfVruDn
	 pbrrr2a0hsp6+2odseLgz0EjvenOZ9aDdyou7O0fRfEv5tPPkCZQaCy/4wGdxYwwcR1lE
	 fNPcCaEl79n1HvRKuhcayssyIMoFP4kM01tkkFWvQHjn+Ju6YoMdBHAYoDSKEcB6zujmj
	 5SX1AAK4Q1HBVLRQ4BPGULsaq3fRXc+HK+EeU3Kl5N0NVq1YxcUwHBH3K7QbGCphRKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980641;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=kGLkV2arTsITsFBFDWHaARE2+eYeJRko9HB2FvywEtA=;
	b=5qsQ0SNWyEcxgfJVlQjqdsZjVnePeb/2pRraOhrOQQjB24gbLRkpNpClBawsJXyxok9p
	 lgCdOuWKSafjgevRQ0c8YMbP0Z0cr2Y9d2VE653v6oNCDTg4umbLfEd0Y7Yp415+5ukmm
	 Bh3yjD+D0KYe40KtXJdkpHXlyM7KLZ9y1kTcMcbHbaqFm4WkYVRQI7nN3yGoaVa16TMjq
	 oJ/vECfCiCf69WDWFLdGG+LlxA48CQQJfqFYnYiP2yjAZq1wE/IBwF9FXXEDb0YoxBoRo
	 XtUlrp6BU0bG8riPF5Ch4/N1fXPGxU8OdY0cZTGMMxsIaANOCk/75sHHTAawLC9ygVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=iicvIvre;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA7606A329;
	Fri,  6 Nov 2026 15:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=iicvIvre
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E850F1F0089F;
	Fri,  6 Nov 2026 15:57:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1793980640;
	bh=kGLkV2arTsITsFBFDWHaARE2+eYeJRko9HB2FvywEtA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=iicvIvreJ71pkcvw1woL/L4zbavYkDErAVrArRIp0dsEjS5KXngMPY+bjbp3m/FKb
	 c036lM6d9y2HoPzyRIKUUF/5Wiq9g9Q/PPMtAupq43FycCfj8H/teRDPmstoA13Uf8
	 FnWskYgGKvCK7CeatILM3S21WjlcHZAT6gBX4HoM=
Date: Fri, 6 Nov 2026 07:57:19 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Cc: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>, Pedro Falcato
 <pfalcato@suse.de>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan
 Kara <jack@suse.cz>, David Hildenbrand <david@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/filemap: stop fault-around when the walk steps
 back
Message-Id: <20261106075719.5ae53a9d248c9219381ee60e@linux-foundation.org>
In-Reply-To: <4284c2d3-75cb-4e41-aa45-f7311e60ab4a@gmail.com>
References: <20261031-jf-mm-filemap-map-pages-lower-bound-v2-1-21029744e589@linux.dev>
	<aunPI5eOUOAEUa8d@pedro-suse.tail5790ac.ts.net>
	<20261104-jf-filemap-v2-pedro-reply-r2-74c87c6fbcf@linux.dev>
	<auxvLCiljPhy0n_q@pedro-suse.tail5790ac.ts.net>
	<au0GBdGqu6cv5PMy@linux.dev>
	<4284c2d3-75cb-4e41-aa45-f7311e60ab4a@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Nov 2026 12:36:05 +0100 Krystian Kaniewski <krystianmkaniewski@gmail.com> wrote:

> Andrew, Jose's Tested-by for the xarray patch is on the filemap patch
> in mm-hotfixes-unstable.

So it is, thanks.  I've moved that into "xarray: fix index jumping
backwards in xas_find()":


From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Subject: xarray: fix index jumping backwards in xas_find()
Date: Fri, 4 Sep 2026 14:12:59 +0200

A bug in the XArray iterator xas_find() causes the iterator's index
(xas->xa_index) to jump backwards when iterating over a multi-index entry
(like a THP) that resides in a non-leaf node and is concurrently split.

When iterating over a multi-index entry in a non-leaf node, xas_load()
sets xas->xa_offset to the base offset of the entry, but leaves
xas->xa_index at the requested index.  When the caller subsequently wants
to advance to the next entry, xas_find() is called.  xas_find() attempts
to synchronize xas->xa_offset with xas->xa_index before advancing. 
However, the fixup logic was incorrectly restricted to leaf nodes
(!xas->xa_node->shift).  Because the THP resides in a non-leaf node, the
fixup is skipped.

As a result, xas_find() simply increments xas->xa_offset and recalculates
xas->xa_index based on this new offset.  This causes xas->xa_index to jump
backwards.  If the THP was concurrently split, the entry at the new offset
is a node pointer, so xas_find() descends into it and returns the folio at
the backwards index.  The caller (filemap_map_pages()) then calculates the
PTE pointer based on this backwards index, resulting in an invalid memory
access such as an out-of-bounds read or use-after-free on a page-table
page freed via tlb_remove_table_rcu().

A userspace access that faults in a file-backed mapping can trigger this
path.  When the index moves backwards, filemap_map_pages() can calculate a
PTE outside the page locked for fault-around and dereference a freed
page-table page, resulting in a KASAN-detected use-after-free read.

To fix this, check if xas->xa_offset matches get_offset(xas->xa_index,
xas->xa_node).  If it does not and the node is a non-leaf node, set
xas->xa_offset to get_offset(xas->xa_index, xas->xa_node) before
advancing.  Also add test cases in test_xarray to verify xas_find()
behavior when iterating over and splitting multi-index entries.

Link: https://lore.kernel.org/20260904121301.200049-1-krystianmkaniewski@gmail.com
Fixes: b803b42823d0 ("xarray: Add XArray iterators")
Reported-by: syzbot+b72767277f29b6407083@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b72767277f29b6407083
Closes: https://syzkaller.appspot.com/ai_job?id=a01c56bd-74d0-411c-afb4-ee6f0cb6cb61
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Tested-by: Jose Fernandez (Anthropic) <jose.fernandez@linux.dev>
  Link: https://lore.kernel.org/20261104-jf-filemap-v2-pedro-reply-r2-74c87c6fbcf@linux.dev
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: <stable@vger.kernel.org>
---

 lib/test_xarray.c |   70 ++++++++++++++++++++++++++++++++++++++++++++
 lib/xarray.c      |    8 +++--
 2 files changed, 75 insertions(+), 3 deletions(-)

--- a/lib/test_xarray.c~xarray-fix-index-jumping-backwards-in-xas_find
+++ a/lib/test_xarray.c
@@ -1247,6 +1247,75 @@ static noinline void check_multi_find_3(
 	}
 }
 
+static noinline void check_multi_find_4(struct xarray *xa)
+{
+#ifdef CONFIG_XARRAY_MULTI
+	unsigned int order = XA_CHUNK_SHIFT + 1;
+	unsigned long next = 1UL << order;
+	unsigned long start = next - 1;
+	XA_STATE(xas, xa, start);
+	XA_STATE_ORDER(split, xa, 0, 0);
+	void *entry;
+	unsigned long i;
+
+	/* Multi-index entry in two slots of a non-leaf node. */
+	xa_store_order(xa, 0, order, xa_mk_index(0), GFP_KERNEL);
+	XA_BUG_ON(xa, xa_store_index(xa, next, GFP_KERNEL) != NULL);
+
+	rcu_read_lock();
+	entry = xas_find(&xas, ULONG_MAX);
+	XA_BUG_ON(xa, entry != xa_mk_index(0));
+	XA_BUG_ON(xa, xas.xa_index != start);
+
+	entry = xas_find(&xas, ULONG_MAX);
+	XA_BUG_ON(xa, entry != xa_mk_index(next));
+	XA_BUG_ON(xa, xas.xa_index != next);
+
+	entry = xas_find(&xas, ULONG_MAX);
+	XA_BUG_ON(xa, entry != NULL);
+	rcu_read_unlock();
+
+	xa_erase_index(xa, next);
+	xa_erase_index(xa, 0);
+	XA_BUG_ON(xa, !xa_empty(xa));
+
+	/* Split the multi-index entry after a lookup begins inside it. */
+	xa_store_order(xa, 0, order, xa_mk_index(0), GFP_KERNEL);
+	XA_BUG_ON(xa, xa_store_index(xa, next, GFP_KERNEL) != NULL);
+
+	xas_set(&xas, start);
+	rcu_read_lock();
+	entry = xas_find(&xas, ULONG_MAX);
+	XA_BUG_ON(xa, entry != xa_mk_index(0));
+	XA_BUG_ON(xa, xas.xa_index != start);
+	rcu_read_unlock();
+
+	xas_split_alloc(&split, xa_mk_index(0), order, GFP_KERNEL);
+	if (xas_error(&split)) {
+		XA_BUG_ON(xa, true);
+		goto out;
+	}
+	xas_lock(&split);
+	xas_split(&split, xa_mk_index(0), order);
+	for (i = 0; i < next; i++)
+		__xa_store(xa, i, xa_mk_index(i), 0);
+	xas_unlock(&split);
+
+	rcu_read_lock();
+	entry = xas_find(&xas, ULONG_MAX);
+	XA_BUG_ON(xa, entry != xa_mk_index(next));
+	XA_BUG_ON(xa, xas.xa_index != next);
+
+	entry = xas_find(&xas, ULONG_MAX);
+	XA_BUG_ON(xa, entry != NULL);
+	rcu_read_unlock();
+
+out:
+	xa_destroy(xa);
+	XA_BUG_ON(xa, !xa_empty(xa));
+#endif
+}
+
 static noinline void check_find_1(struct xarray *xa)
 {
 	unsigned long i, j, k;
@@ -1370,6 +1439,7 @@ static noinline void check_find(struct x
 		check_multi_find_1(xa, i);
 	check_multi_find_2(xa);
 	check_multi_find_3(xa);
+	check_multi_find_4(xa);
 }
 
 /* See find_swap_entry() in mm/shmem.c */
--- a/lib/xarray.c~xarray-fix-index-jumping-backwards-in-xas_find
+++ a/lib/xarray.c
@@ -1410,9 +1410,11 @@ void *xas_find(struct xa_state *xas, uns
 		entry = xas_load(xas);
 		if (entry || xas_not_node(xas->xa_node))
 			return entry;
-	} else if (!xas->xa_node->shift &&
-		    xas->xa_offset != (xas->xa_index & XA_CHUNK_MASK)) {
-		xas->xa_offset = ((xas->xa_index - 1) & XA_CHUNK_MASK) + 1;
+	} else if (xas->xa_offset != get_offset(xas->xa_index, xas->xa_node)) {
+		if (!xas->xa_node->shift)
+			xas->xa_offset = ((xas->xa_index - 1) & XA_CHUNK_MASK) + 1;
+		else
+			xas->xa_offset = get_offset(xas->xa_index, xas->xa_node);
 	}
 
 	xas_next_offset(xas);
_

