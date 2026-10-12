Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48F32D7DF1;
	Mon, 12 Oct 2026 23:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791848438; cv=none; b=KhnidG0+G93lciP6Q2cwmHnkXg0BmE9/KtVs+TgjoNohiG1qxhFIGnAmnX9sJWqIb7w3hsz4AAQw1ln7Lb/XcQv8YLW3ZJyiJXr1494Bqlfdzlc9Puu0NF+r2GOEX2oMnlczDv5E5XIk2pKnXDXRHWcBl2R8beZbHoXsY7d+BZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791848438; c=relaxed/simple;
	bh=F0E2j6PGEzPye5mq/EBquSlpNvmXqrAlrro85QvwcDU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tsn6p5HsxD5DRt6dkJ8EDR0H9EWuXKwDnELjpcUV4tfPAv+bDpXgOas0yXk+YmlnXiO2dHGPfnGmMO1f/wP6CrsFRd04BAASp5Qups4Uu+9vylXfsC35eHKMf2TizWm5RFbFuwXCVjzd6Cq4n9eRQvMBZ0GnSySfBW2z+jBI7lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KMXtAoex; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KMXtAoex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB4881F0089B;
	Mon, 12 Oct 2026 23:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791848437;
	bh=SkL4KSx7/JrnyI8uokV77XjaC15YS+tpdhJZzA9rC+c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KMXtAoexMJSpx9XhKfCHkDaODNmCzED43DLdBN6kHLRJriWZgMHA1/5DkpWDMHS6E
	 dwuiFzFyMaBak3WpH4synd47Yb86bpj/kCKDfnM3q/WL7sII2J5JjCFBspWEFklunr
	 eFPT8CktRdxW45ysm3YtDzcThukdmj8acwYb3k/IOuL0RYeJPISUy6MMuL2NLN/Q7h
	 z42qt6C3HzeoM9qSf9HoNy6Swc26dFbBPWA1h5zYcCUR4KuGS5h4VP3XKrqpkPcgtR
	 HKTjcrguskmuuNRT1NEiPz6ZZ6BR17bd/wvy7rqATVoU9o8ET/KLyJQatwZYSHmubC
	 M1Z/YN9NGiohQ==
Subject: Re: [PATCH net] ipv4: fib_trie: prevent speculative out-of-bounds
 child access
From: netdev-bot+sashiko@kernel.org
To: datrujillo@nvidia.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 alexander.h.duyck@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Mon, 12 Oct 2026 23:40:36 +0000
Message-ID: <179184843631.434549.15060926014237489772@kernel.org>
In-Reply-To: <20261008-fib-trie-nospec-v1-1-fa18726d485e@nvidia.com>
References: <20261008-fib-trie-nospec-v1-1-fa18726d485e@nvidia.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The Spectre v1 mitigation in fib_table_lookup()
  (net/ipv4/fib_trie.c) is incomplete: the raw index is copied into…

Pre-existing issues:
- [High] fib_find_node() in net/ipv4/fib_trie.c has the same Spectre v1
  gadget the patch fixes in fib_table_lookup(), and the patch leaves it…

--

ipv4: fib_trie: prevent speculative out-of-bounds child access

This patch adds array_index_nospec() in fib_table_lookup(). It clamps the
child index before get_child_rcu() reads n->tnode[]. The goal is to stop a
mispredicted bounds check from loading past the child array with an
index derived from flp->daddr.

> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> index 248514dce0cdd..bd8a368c55026 100644
> --- a/net/ipv4/fib_trie.c
> +++ b/net/ipv4/fib_trie.c

[ ... ]

> @@ -1474,6 +1475,7 @@ int fib_table_lookup(struct fib_table *tb, const struct flowi4 *flp,
>  			cindex = index;
>  		}
>  
> +		index = array_index_nospec(index, 1ul << n->bits);
>  		n = get_child_rcu(n, index);
>  		if (unlikely(!n))
>  			goto backtrace;

[Severity: High]
Does the clamp run too late to cover cindex? In the Step 1 loop, the raw
index is saved into cindex before the new array_index_nospec() line runs:

		if (n->slen > n->pos) {
			pn = n;
			cindex = index;
		}

		index = array_index_nospec(index, 1ul << n->bits);

Suppose the "index >= (1ul << n->bits)" check is mispredicted for an
out-of-bounds index and n->slen > n->pos. Then cindex and pn keep the
unmasked value. The clamped index then loads tnode[0].

Execution can reach backtrace with those values still in place in two
ways: tnode[0] is NULL, or Step 2 later fails prefix_mismatch(). cindex
is non-zero, so the while (!cindex) loop is skipped, and this runs:

			cindex &= cindex - 1;

			/* grab pointer for next child node */
			cptr = &pn->tnode[cindex];

That only clears the lowest set bit, so cindex stays out of bounds and
its high bits are still the ones the attacker chose. For example, 0x10003
becomes 0x10002 with bits = 4.

The slot is then loaded and used as a node pointer at the top of Step 2:

		while ((n = rcu_dereference(*cptr)) == NULL) {
		...
		if (unlikely(prefix_mismatch(key, n)) || (n->slen == n->pos))

Isn't this the same "load past the child array, then dereference the
value as a node pointer" sequence the commit message describes?

Would moving the array_index_nospec() line above the
"if (n->slen > n->pos)" block clamp both cindex and the index passed to
get_child_rcu()?

[Severity: High]
This is a pre-existing issue and was not introduced by this patch.
fib_find_node() in the same file seems to have the same gadget, and this
patch leaves it as is:

net/ipv4/fib_trie.c:fib_find_node() {
	do {
		pn = n;
		n = get_child_rcu(n, index);

		if (!n)
			break;

		index = get_cindex(key, n);
		...
		if (index >= (1ul << n->bits)) {
			n = NULL;
			break;
		}

		/* keep searching until we find a perfect match leaf or NULL */
	} while (IS_TNODE(n));
	...
}

If that bounds check is mispredicted, IS_TNODE(n) is still true. The next
pass then calls get_child_rcu(n, index) with the unmasked index and
dereferences the loaded value through get_cindex().

The key is ntohl(cfg->fc_dst), set in fib_table_insert() and
fib_table_delete(). Both call fib_find_node(t, &tp, key), and they are
reached from RTM_NEWROUTE and RTM_DELROUTE. That needs CAP_NET_ADMIN over
the netns, which an unprivileged user can often get by creating a user
namespace.

The subject line says "prevent speculative out-of-bounds child access".
Should fib_find_node() get the same array_index_nospec() clamp before
its child load?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008-fib-trie-nospec-v1-1-fa18726d485e%40nvidia.com
