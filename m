Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792766767;
	b=EcLiaIvTt62y4+S5w/6+DglaSYOURUi+IseTdnCiP0HaXrmPTPb9Jv6uScBNFHHx8QAs
	 adM66QoTeQJIEzLCyD9DVYSE5tY5deCP3n4rlg/awLp6Ffl2ihpxI9Ikwy5PXqRoNHnHu
	 BCXoNT5Y6tubQUo534A9aTSTujjCXUV64zrwEzRH95uBmI65FSQhxJX7fdaBBFiRj6RhJ
	 9bOrVclVdcwouc/7F1gvu2rrO8sADuovv3pihthueqL0SnZYV7Bx3T4SI+svmOBe4ZM5p
	 +ATQnD4/gvAN5RlRjBoHp2oi7AvjLGsd87kdutOTp15wkoH6dKTFUdmnMTnaKyYFBLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792766767;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=/fiO3+QdsE/BfanTbW7upLzdgUQUluHoCjZtUMQ3uBk=;
	b=dOhBv6zIJlOscHx1uMY0OWRK/3g7Y8s0oYKYhDLhNAq9Zvu+HS8HelOgl/Fg4aa2W91J
	 jw+7aU/SHxj4b7iJTqApnf2P0HXej35izVfn8fAUsFysA1LIb3X23R00ERoKf4s6JBUwY
	 OqlWNRYJo+3PyT/n79cb77sNVGir9V+FfxHGppK4E9cGmxQ+of+gL1cVgWzBhtHK0x+ua
	 P3Q8rXB++yOFirh9j+1qfuk/QqSWdm6Qk7eMLw/g/UlNpFTxjLTLkyUOoV1M5yP87X8Pw
	 ER1e0PTreB00YCFiQp6Z60FjD7HyIwY3bB7Yqw7s913vT55wLJP2XksuJI9+V69HE6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=kMkUSEcD;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56984606A31A;
	Fri, 23 Oct 2026 14:46:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56984606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=kMkUSEcD
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/fiO3+QdsE/BfanTbW7upLzdgUQUluHoCjZtUMQ3uBk=; b=kMkUSEcD/LSfqTU7gNyl/t4tZF
	zdvV22g3LYXk8cowEg4+mfo+xrqqvN48gAscXUOli6NUPVPGIk3knPM8cFUNCVB3ISM9a6F+t5f/k
	9vKDliaAhsHfqVaJqWcH4TIl25cesWtdJtXyG+3/Rtcug72SVWSsUJKfJuqVP6oS0TquTIkAz+dD5
	FDQWoMgjvTAxG5ar2cABmn/NW1JprWWG7txkNiQP3pBwABKI8wk4PAbRpa7xi5YCAQjg92aYp22G6
	9DHf3VZZgnYUxt4hEaDnpqA42SLa4Gk2HH+L5/NKY1RwnwyB+G+I8uWmnJLJRZ3RiYF1aSUi2gCm4
	KlBsWx1A==;
Received: from willy by casper.infradead.org with local (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKGWq-0000000CF1Z-05ce;
	Fri, 23 Oct 2026 14:45:56 +0000
Date: Fri, 23 Oct 2026 15:45:55 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1] xarray: clear the new head's parent before freeing
 the old head
Message-ID: <attzI4sj2Pagmvkd@casper.infradead.org>
References: <20261012202549.772887-1-nickolai@csail.mit.edu>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012202549.772887-1-nickolai@csail.mit.edu>


If you must have your AI write the commit message, please tell it to
be less verbose.  I start losing the will to live after about three
paragraphs of this.

On Mon, Oct 12, 2026 at 04:25:49PM -0400, Nickolai Zeldovich wrote:
> When xas_shrink() replaces the head node of an array with the node in its
> slot 0, it stores the child in xa_head, passes the old head to
> xa_node_free(), which queues it with call_rcu(), and only then clears the
> child's ->parent pointer.  In between, a lockless walker can still reach
> the old head, not from xa_head but upwards from the new head:
> xas_find(), xas_find_marked(), xas_next() and xas_prev() climb through
> xa_parent() when they step past the end of a node.  RCU does not protect
> a walker that gets there: call_rcu() waits only for the read-side
> critical sections that were running when the callback's grace period
> started, and that grace period can start before the parent pointer is
> cleared.
> 
>   CPU 0: xa_erase(), xa_lock held   CPU 1: RCU walker, e.g. xa_find()
> 
>   xas_shrink()
>     xa->xa_head = child
>     xa_node_free(old head)
>       call_rcu()
>                     <grace period starts>
>                                      passes a quiescent state
>                                      rcu_read_lock()
>                                      xas_find(): loads xa_head (child),
>                                      steps past its last slot,
>                                      child->parent is still old head
>     child->parent = NULL
>   xa_unlock()
>   quiescent state
>                     <grace period ends>
>   radix_tree_node_rcu_free(old head)
>                                      reads old head's slots[], shift,
>                                      offset and parent
> 
> The grace period does not wait for CPU 1, which reported its quiescent
> state before its critical section began; holding xa_lock delays the end
> of the grace period, not its start.  The start can fall inside the
> window when an interrupt arrives in it (interrupts are enabled under
> xa_lock(), and RCU core processing may run on interrupt exit), when
> callbacks are offloaded (rcu_nocbs=) and the rcuog kthread on another CPU
> handles the callback, when many callbacks are queued, or while the
> writer is preempted under PREEMPT_RT.  Interrupts, and in a guest a
> preempted vCPU, also stretch the window.
> 
> After the climb, xas_find(), xas_find_marked() and xas_next() resume in
> the old head at the slot after the child and read its slots[] and shift
> (xas_find_marked() also its mark bitmaps); xas_prev(), for which the
> child is the first slot, steps past the old head at once and reads its
> offset and parent, as the others do when they reach its end.  Nothing in
> the walk notices that the node is gone.  The climb takes ->parent as it
> is, no lockless path looks at node->array (XA_RCU_FREE), and
> xas_shrink() stores XA_RETRY_ENTRY in slot 0 of the old head only when
> the head shrinks to a single entry, not to a node; the walker does not
> look at slot 0 anyway.  radix_tree_node_cachep is not
> SLAB_TYPESAFE_BY_RCU, so the walker reads freed memory.  Once the object
> is reused for a node of another array, the walker returns that array's
> entries or descends and climbs into its nodes.
> 
> The order dates from the introduction of xas_shrink() in the commit
> below, which reimplemented radix_tree_shrink().  radix_tree_shrink()
> clears the child's parent pointer before it replaces the head and frees
> the old node, and still does in lib/radix-tree.c.  The commit gives no
> reason for the different order and nothing depends on it: xas_update()
> and xa_node_free() only touch the old head.
> 
> Clear the child's parent pointer before freeing the old head, as
> radix_tree_shrink() does.  The stores are the same, the tree and the
> xa_state the caller sees are the same, and a walker that starts after
> the callback's grace period has begun sees the cleared pointer, like
> every store before call_rcu(), and ends its walk at the new head, which
> covers every index that the old head had an entry for.
> 
> A check in the radix-tree test harness that no node passed to
> xa_node_free() is still the parent of a node reachable from xa_head
> fails in xas_shrink() 4731 times in the XArray tests without this patch
> and never with it.  No test is added: the race is not deterministic and
> the check needs a hook on xa_node_free().  A harness race test (readers
> walking the whole array with the four climbing walkers while a writer
> stores and erases an entry that adds three levels above the leaf) did
> not hit the window in 20 runs of 200000 erases; with a 1 ms sleep
> injected after xa_node_free() in xas_shrink(), every one of 20 runs
> reported a heap-use-after-free in __xas_next() or __xas_prev() under
> AddressSanitizer, and none did with this patch and the same sleep.  On a
> kernel (x86_64 defconfig + KASAN, QEMU), with a 100 ms delay injected at
> the same place, a walk that starts on another CPU 20 ms into the window
> climbs to the old head in each of 20 rounds, and KASAN reports a
> slab-use-after-free of the radix_tree_node freed from rcu_core() when
> the walk takes its next step; with this patch, the walk ends at the new
> head.  The XArray and IDA self-tests pass on x86_64 and riscv64.
> 
> Found while formally verifying xas_store() against the kernel binary.
> 
> Fixes: 58d6ea3085f2 ("xarray: Add XArray unconditional store operations")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Nickolai Zeldovich <nickolai@csail.mit.edu>
> ---
> 
> Notes:
>     Reproduction details: the ordering check wraps each xa_node_free(node)
>     call in a copy of lib/xarray.c with a function that walks the tree from
>     xa_head and reports the node if it is still reachable or still the
>     ->parent of a reachable node.  The harness race test links a copy of
>     lib/xarray.c with a hook right after the xa_node_free() in xas_shrink()
>     that sleeps 1 ms in the writer; 32 threads, liburcu-registered readers.
>     Without that sleep, this patch alone still showed a use-after-free in 3
>     of 20 runs; those come from the xas_delete_node() bug (the race test
>     also erases nodes), and with both patches 20 of 20 runs were clean.
>     With only the xas_delete_node() fix, the sleep still gives 20 of 20
>     failures.  The kernel demonstration is a test build with mdelay(100)
>     after xa_node_free() in xas_shrink() for one test array, a writer
>     kthread on CPU 0 doing xa_store()/xa_erase() and a reader kthread on
>     CPU 1 doing xas_load()/xas_next() under rcu_read_lock().  The window
>     has not been hit on an unmodified kernel.  I can send any of these if
>     useful.
> 
>  lib/xarray.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/xarray.c b/lib/xarray.c
> index bfe7bef80f34..ae9d7fc68861 100644
> --- a/lib/xarray.c
> +++ b/lib/xarray.c
> @@ -471,11 +471,12 @@ static void xas_shrink(struct xa_state *xas)
>  		if (!xa_is_node(entry))
>  			RCU_INIT_POINTER(node->slots[0], XA_RETRY_ENTRY);
>  		xas_update(xas, node);
> +		if (xa_is_node(entry))
> +			xa_to_node(entry)->parent = NULL;
>  		xa_node_free(node);
>  		if (!xa_is_node(entry))
>  			break;
>  		node = xa_to_node(entry);
> -		node->parent = NULL;
>  	}
>  }

I think the patch is fine.  I understand the infeasibility of adding
a test into the test suite.  I've had a good think about other ways we
might spot this happening and haven't come up with anything.
