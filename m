Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.137.202.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202170;
	b=uA6Uo1rLXdS9CM5QcleRKoIcQ/PLdwtViIEwjsw0WThDhoDwEL9EDW5jhnMbbnXXXCe6
	 9M1KnEf/df4SKgrP2inFufKEWEgpJAR7Fap4c4Mzsrb/+5Nujf0CCtopg5fy+k25p0kgB
	 xlwxel9mLyGEmgZ1nKHI4UFFHCRrteOFhJ2M3B6UGUJHtJ75IQHfDGdhToNLciikC7l2+
	 sHpxLNyqEy55rJTWcItC93CtexdxPzO9wfKTgYHsgPIo7UlM9I5lghMzwFtrLJZGXzPoM
	 6DshE+4qvqV69qopoQBnnbmqhDwU7KcL8cepg0ay34GfnVhs8dZgklrw6dd+eNu3Ijg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202170;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=laIB3FyK7mnPgkdSTmIIOXUp7l8bl3ekGNuGdqFlOuU=;
	b=1ejr+rEF0I5ZZogo/eKbKcrsU0zXl6iqamiwViu1BJCVfoIxjreoCpSkzHYCt79uN2Dl
	 I8Cm/AuEMQKVMXgfAx3BUi/VmqjXRlLG0/y1dsNdCw5OEyJtDMRcIxtOpIzKAc7dZ4yi7
	 5U3XrZaFizcWzsAblt0bfq26mS2jhHqXEMOsz/MdGMVjtObVEAjTDs++lRBUGg8qLRCOh
	 AfI7/FIXv5ZdgFsrr20qpnalR7iMhR1FZAjkaTnrk01pvzhtEfNlo1uZdGLr85Rv3foVT
	 bVQfd8ceEuN9RfTQHz49zH55XyOnASmEpl/VIFiAwA0NXMDt+XlT620YMART9oNqxgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nkmMZXJf;
	arc=none smtp.remote-ip=198.137.202.133
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F7C606A323;
	Wed, 28 Oct 2026 15:42:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66F7C606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=nkmMZXJf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=laIB3FyK7mnPgkdSTmIIOXUp7l8bl3ekGNuGdqFlOuU=; b=nkmMZXJfeGqa7UScd2rHUQdC+A
	dsV0cxZYlPh1r37Yh6z4vUoKYuinfS+v/XHrjmBV7mEZo4VeAzSz/TsOjw62Wn7wXMX3KhU3cEDX5
	hZWyvcOirsc/PgH4DmrxNkhFOqShkMGDGO7RszWaDIVl6kCdkO6gvZIf6ZEJyZwXmwFitw5o4jm77
	bFEN//pS/GhetmM5UMMKQFYnhrG5TJ14Xa0zJt/7rtq8AP/OgPPJU6v+FpaPWnRmtR8rhHQ8sMGt3
	xb+C/W5TwSGBfVGmxLGp+0vU9g+JCd7533QORT3HzIcEjcMWzGE7rBsf01364yRKvXO/ruZWWT5Z2
	fZDQfB4g==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5nc-00000007Qqk-3bP3;
	Wed, 28 Oct 2026 15:42:49 +0000
From: "Liam R. Howlett (Google)" <liam@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Graf <tgraf@suug.ch>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	Lorenzo Stoakes <ljs@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Andrew Ballance <andrewjballance@gmail.com>,
	stable@vger.kernel.org,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	"Liam R. Howlett (Google)" <liam@infradead.org>
Subject: [PATCH 4/4] rhashtable: fix vmalloc() deadlock in atomic rehash
Date: Wed, 28 Oct 2026 11:42:18 -0400
Message-ID: <20261028154218.1668182-5-liam@infradead.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028154218.1668182-1-liam@infradead.org>
References: <20261028154218.1668182-1-liam@infradead.org>
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

From: Chris Mason <mason@kernel.org>

An unprivileged user can deadlock two CPUs by filling the forwarding
database (FDB) of a bridge in their own network namespace. A peer that
floods a bridge port with frames from new source addresses can fill the
FDB too. The flood alone was never seen to cause a deadlock. Together
with local tasks that call vmalloc() in a loop on the CPU that receives
the frames, it can deadlock that CPU. Other CPUs that call vmalloc() or
vfree() after that can hang too.

The FDB holds the MAC addresses that the bridge knows. It is an
rhashtable, a hash table that grows as it fills.

An rhashtable normally grows from a worker. If an insert finds the table
too full before the worker has run, rhashtable_insert_rehash() allocates
the larger table immediately, with GFP_ATOMIC, in the context of the
insert. bucket_table_alloc() uses kvmalloc() for that.

kvmalloc() tries kmalloc() first. Since v6.19, if kmalloc() fails, it
falls back to vmalloc() for non-blocking GFP flags too, and kmalloc()
always fails above KMALLOC_MAX_SIZE.

vmalloc() and vfree() take their spinlocks with bottom halves enabled.
Such a lock must not be taken in a softirq, or while holding a lock that
a softirq takes. In the bridge, an insert that falls back to vmalloc()
breaks the second rule: the bridge inserts into its FDB under
br->hash_lock, and its receive softirq takes br->hash_lock as well.

Below, one CPU adds an FDB entry for an RTM_NEWNEIGH netlink request,
while another CPU is inside vmalloc() or vfree():

    RTM_NEWNEIGH                      vmalloc() or vfree()
    ============                      ====================
    spin_lock_bh(&br->hash_lock)
                                      spin_lock(&vn->busy.lock)
    rhashtable_insert_rehash()
      kvmalloc(GFP_ATOMIC)
        vmalloc()
          spin_lock(&vn->busy.lock)
            waits for the other CPU
                                      softirq: a frame for the bridge
                                        spin_lock(&br->hash_lock)
                                          waits for RTM_NEWNEIGH

The receive softirq also inserts into the FDB itself: on a learning
port, br_fdb_update() adds the source address of a frame if the FDB does
not have it yet. If that insert falls back to vmalloc(), it breaks the
first rule. The CPU then deadlocks with itself if the softirq has
interrupted a task that holds the same vmalloc lock.

Reproduced on x86-64 under emulation, with three things going on at the
same time:

- RTM_NEWNEIGH requests filled an FDB past 262,144 entries, where the
  next table is too large for kmalloc() on x86-64.
- Frames arrived on a veth port.
- Tasks called vmalloc() in a loop.

Two CPUs ended up spinning on each other's lock.

The softirq path was reproduced too, on x86-64 under emulation and with
RPS set by root. Repeated floods of 280,000 source addresses on a veth
port, while tasks called vmalloc() in a loop on the CPU that received
the frames, ended in a soft lockup in alloc_vmap_area() in 6 of 6 boots.
Without these tasks, on a kernel with no debug options, none of 33
floods reached vmalloc().

Fix this by calling kmalloc() instead of kvmalloc() in
bucket_table_alloc() if the GFP flags do not allow blocking.

Known gaps:
- By code inspection, bpf_iter_tcp_realloc_batch() and the dm-bufio
  clients that set no_sleep also call a non-blocking vmalloc() under
  spin_lock_bh(), and can still deadlock in the same way. The later
  commit "mm/vmalloc: fix deadlock in softirq and BH-off callers" fixes
  them.
- If kmalloc() fails, the atomic rehash falls back to a nested table, as
  before v6.19. A nested table is built from single pages, so it needs
  no large allocation. An insert then fails in two cases. If the nested
  table cannot get a page, the insert fails with -ENOMEM or -EBUSY. If
  the new table has 512 buckets, that is too few for a nested table, and
  the insert fails with -ENOMEM.
- A lookup in a nested table follows up to three more pointers until the
  worker has rehashed once more.

Changes from the LLM patch:

Dropped the __GFP_NOWARN from the kmalloc_noprof() when
gfpflags_allow_blocking() is false since the only non-blocking caller
already sets the flag.

Tried to make the alloc_hooks_tag() multi-line call more readable
(whitespace changes only).

Cc: <stable@vger.kernel.org>
Fixes: c6307674ed82 ("mm: kvmalloc: add non-blocking support for vmalloc")
Assisted-by: LLM
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
Signed-off-by: Liam R. Howlett (Google) <liam@infradead.org>
---
 lib/rhashtable.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/lib/rhashtable.c b/lib/rhashtable.c
index 6362896e4f099..f8ec85bc6e8af 100644
--- a/lib/rhashtable.c
+++ b/lib/rhashtable.c
@@ -193,9 +193,21 @@ static struct bucket_table *bucket_table_alloc(struct rhashtable *ht,
 	int i;
 	static struct lock_class_key __key;
 
-	tbl = alloc_hooks_tag(ht->alloc_tag,
-			kvmalloc_node_align_noprof(struct_size(tbl, buckets, nbuckets),
-					     1, gfp|__GFP_ZERO, NUMA_NO_NODE));
+	/*
+	 * vmalloc() takes locks that are not safe against interrupts, and the
+	 * emergency rehash runs in whatever context the insert runs in. So a
+	 * caller that cannot block gets slab memory, or else a nested table.
+	 */
+	if (gfpflags_allow_blocking(gfp))
+		tbl = alloc_hooks_tag(ht->alloc_tag,
+				      kvmalloc_node_align_noprof(
+					struct_size(tbl, buckets, nbuckets),
+					1, gfp | __GFP_ZERO, NUMA_NO_NODE));
+	else
+		tbl = alloc_hooks_tag(ht->alloc_tag,
+				      kmalloc_noprof(
+					struct_size(tbl, buckets, nbuckets),
+					gfp | __GFP_ZERO));
 
 	size = nbuckets;
 
-- 
2.47.3

