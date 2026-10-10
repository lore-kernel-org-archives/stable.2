Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C54C3793D5;
	Sat, 10 Oct 2026 23:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791674761; cv=none; b=TWomXymzhF0i9Flkz36ymYmlX8M5bTS8tnHogCLc4U13L1HFU51UPDN21B+cqYxxtK6oa7C3wZ5crJMPLHEQldWnD2b7rhaMywZbbWf7MReSjKl9qaM9/LgYJNPxHTT66bZKASn4Hudj4GiZ3Yhk5kDvl4GVoOeKBF23clCo/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791674761; c=relaxed/simple;
	bh=6yFR9zUdaIfYHBE3nKTn5NqrJlDKhHqf2wVO0SrEgF0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=mI8ZpJQtCtUs1uK3ymnjcYBE1OHAvOy6y2tXnF5Nzk1LEP9MBiaooX1f3+YrERL9nJBR/ssuWs3QLVf8bOjfM/VRUXx2e5J7gI1tavmiKoK4mX1iiUubm5LJmdrzmHv44jQDOlYUgjxM9pVDdo8934a8yuB5mUYhesxyjVphaOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MGqXdeYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MGqXdeYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CE01F000FF;
	Sat, 10 Oct 2026 23:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1791674759;
	bh=lX06ug4ZlwaTEtFe/+FOH0wFcyQJV2GLnOlTR4H9yEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MGqXdeYHpyqnP1J5PQ5E2qWuOvv2i1SG2Z0PSZkOeYJbfAi6hmx1DDJ5P2qnbFABt
	 mXfZdxi9/01bwNyJa5xnSHNNQfO4UJxnvWs0mrspJq3s/tFw7oKsukUjrwaX9cABGj
	 67S3u687VB7GBdwVK2B7R3vMktHrxSxO8tyrVk1o=
Date: Sat, 10 Oct 2026 16:25:58 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nickolai Zeldovich <nickolai@csail.mit.edu>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, I Hsin Cheng
 <richard120310@gmail.com>, Ching-Chun Huang <jserv@ccns.ncku.edu.tw>, Chris
 Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Barry Song
 <baohua@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] lib/plist: fix plist_requeue() shortcut inserting the
 node at the list head
Message-Id: <20261010162558.62abcd2ec967b009d0cb3bbb@linux-foundation.org>
In-Reply-To: <20261009051857.758182-1-nickolai@csail.mit.edu>
References: <20261009051857.758182-1-nickolai@csail.mit.edu>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  9 Oct 2026 01:18:47 -0400 Nickolai Zeldovich <nickolai@csail.mit.edu> wrote:

> plist_requeue() moves a node to the end of its priority run.  Since commit
> 95d4b3450ebe ("lib/plist.c: add shortcut for plist_requeue()"), when the
> node was the head of its run it skips the scan of the remaining nodes of
> that run and takes node_next from the prio_list of the node's successor,
> which replaced it as the run head in plist_del():
> 
> 	iter = list_entry(iter->prio_list.next, struct plist_node, prio_list);
> 	node_next = &iter->node_list;
> 
> prio_list is a ring of the first nodes of each priority run, without a
> sentinel.  For every run but the last one, iter->prio_list.next is the
> head of the next run and the shortcut is correct.  For the last run it
> wraps around to the head of the FIRST run, and list_add_tail() then
> inserts the node in front of the whole list, ahead of nodes with a lower
> prio value.  The list is no longer sorted:
> 
> 	before requeue(B):  A(1) B(2) C(2)
> 	after  requeue(B):  B(2) A(1) C(2)
> 
> The condition is: at least two priority runs, the node is the first node
> of the last run, and it has a successor with the same priority.  A single
> run is unaffected, because a one-element prio_list ring is list_empty()
> and the slow path runs.
> 
> The only caller is swap_alloc_slow() in mm/swapfile.c, which requeues a
> swap device within its priority group.  With several swap devices on more
> than one priority level, where the lowest priority level has two or more
> devices, rotating the first device of that level moves it ahead of all
> higher-priority devices, so subsequent swap allocations go to a
> low-priority device first.
> 
> Only take the shortcut's node_next when the next ring entry really is a
> higher-priority run; otherwise append the node at the end of the list.
> 
> The CONFIG_DEBUG_PLIST self-test did not catch this because it only
> requeues nodes it has just added, which are always the last of their run,
> so plist_requeue() returns early every time.  Add a deterministic test
> case for the failing shape; plist_test_check() verifies the ordering and
> the prio_list ring after it.
> 
> The bug was found while attempting to prove plist_requeue() against a
> specification stating that the list stays sorted, in the MachCSL
> verification of the Linux kernel on RISC-V; the proof failed at this
> arm and the prover produced the counterexample above.  The fix and the
> test case were drafted with Claude Code (Claude Fable 5.1) and reviewed
> and tested by hand: the three functions were transcribed to a userspace
> harness that reproduces the misordering before the fix and the expected
> order after it, and lib/plist.o builds with CONFIG_DEBUG_PLIST=y.

Thanks.

I recently queued a fix for this problem from Alex:
	https://lore.kernel.org/20260903222456.1881786-1-handyhandyman.adam@gmail.com

The two patches are rather different.  Please review Alex's change and
and let us know of any alterations/improvements which you see.

> --- a/lib/plist.c
> +++ b/lib/plist.c
> @@ -174,11 +174,17 @@ void plist_requeue(struct plist_node *node, struct plist_head *head)
>  	/*
>  	 * After plist_del(), iter is the replacement of the node.  If the node
>  	 * was on prio_list, take shortcut to find node_next instead of looping.
> +	 *
> +	 * prio_list is a ring of the first nodes of each priority run, without
> +	 * a sentinel: if node's run is the last one, iter->prio_list.next wraps
> +	 * around to the first run, and node must be appended at the end of the
> +	 * list instead of being inserted in front of it.
>  	 */
>  	if (!list_empty(&iter->prio_list)) {
>  		iter = list_entry(iter->prio_list.next, struct plist_node,
>  				  prio_list);
> -		node_next = &iter->node_list;
> +		if (iter->prio > node->prio)
> +			node_next = &iter->node_list;
>  		goto queue;
>  	}
>  
> @@ -276,6 +282,25 @@ static int  __init plist_test(void)
>  		plist_test_check(nr_expect);
>  	}
>  
> +	/*
> +	 * Requeue a node which is the first of the last priority run and has
> +	 * a successor of the same priority, with an earlier run present: the
> +	 * shortcut in plist_requeue() must append it at the end of the list,
> +	 * not in front of the first run.  The random test above never
> +	 * exercises this, since it only requeues nodes it has just added,
> +	 * which are always the last of their run.
> +	 */
> +	plist_head_init(&test_head);
> +	for (i = 0; i < 3; i++) {
> +		plist_node_init(test_node + i, i ? 2 : 1);
> +		plist_add(test_node + i, &test_head);
> +	}
> +	plist_test_requeue(test_node + 1);
> +	plist_test_check(3);
> +	BUG_ON(plist_last(&test_head) != test_node + 1);
> +	for (i = 0; i < 3; i++)
> +		plist_del(test_node + i, &test_head);
> +
>  	printk(KERN_DEBUG "end plist test\n");
>  
>  	/* Worst case test for plist_add() */
> -- 
> 2.56.0
