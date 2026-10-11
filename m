Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2DF3D3D00;
	Sun, 11 Oct 2026 05:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791697997; cv=none; b=DbW5qE59mPucJD6ksdaOV3iD04F4NE1FIAvGTmG2QOHHeJxhZ0mAWYcHG5NCzo25/41UIUdiDllGD0MJAGfq3K1+eklZL4O2/9aqkyCreLQlElSiNCVvnmq19F8V1A4M+JVIj6TynNAuWb4nhoJfml3yDnzN6p4NgZXh45SGwJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791697997; c=relaxed/simple;
	bh=/JEOgZ3eYmFSe3KoSY7A5cJK3JwgsNSncPcoS7dJKzM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QCGVHs9O8Cw1KVG53IO3DAFQ1JbSNT3ZOUcHbohLdMWQNSX/qVF0UrlYqTk8Va/TmrsoCM3KEh57KOww5a6Ls2KMvmhxx8iJWMILq8l7ti42gNgQdLdVjeri0nlrUCjcvJV1mcYlVDqrucq0dVqGZEX44GKZOIcW1y1CBut4GxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ul96iwhu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ul96iwhu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6346D1F0089B;
	Sun, 11 Oct 2026 05:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791697996;
	bh=a3FOLcjIN8evxZyxygCISj6Dhd32z8kPF603HHjyYtA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Ul96iwhutDBjmTJxQj+Y6/GUXs2dt+jhcKmvybQsH5fyC82w8jLjIcCRao3js1kn7
	 V9svvuocJDI/TAlgtdMm51Ktve5N3D1RtfjDCr/PubIKlF4FXNQIrvXmo6FxWHM9Yk
	 GEW2oVnOhqkehvJuJUtmnaVWkaJMTL5dWIZMPgBC6xCTmAr5yf/c8RhWMr8GjZOXm1
	 TQXJSJZ1l0iC29JvepFFWBQlmCVaSISafjMLXCIQPx+BNuqwM5NyErF0CMmU+tqMyo
	 nEJXzwPAfWC71R0558gdZyy9G2KzuZtHCxAwTzYrh+I3PC27Q4HELXF8pmNarFJAWj
	 McPC2HEYU5lcA==
Subject: Re: [PATCH net v2] ipv4: fib_trie: prevent speculative out-of-bounds
 child access
From: netdev-bot+sashiko@kernel.org
To: datrujillo@nvidia.com
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 alexander.h.duyck@redhat.com
Date: Sun, 11 Oct 2026 05:53:14 +0000
Message-ID: <179169799489.434549.6127227149225091641@kernel.org>
In-Reply-To: <20261010-fib-trie-nospec-v2-1-30319b4db8d0@nvidia.com>
References: <20261010-fib-trie-nospec-v2-1-30319b4db8d0@nvidia.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch's Spectre-v1 hardening leaves out
  fib_trie_get_next() in net/ipv4/fib_trie.c, which is the depth-first…

--

ipv4: fib_trie: prevent speculative out-of-bounds child access

This patch adds array_index_nospec() sanitization of the child index
before get_child_rcu() in fib_table_lookup(), fib_find_node() and both
loops of leaf_walk_rcu(). It closes a Spectre-v1 gadget where a
mispredicted bounds check lets an out-of-bounds tnode[] slot be
transiently used as a node pointer.

> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> index 248514dce0cdd..bdffeff58c950 100644
> --- a/net/ipv4/fib_trie.c
> +++ b/net/ipv4/fib_trie.c

[ ... ]

> @@ -1787,6 +1794,8 @@ static struct key_vector *leaf_walk_rcu(struct key_vector **tn, t_key key)
>  			continue;
>  		}
>  
> +		cindex = array_index_nospec(cindex, 1ul << pn->bits);
> +
>  		/* grab the next available node */
>  		n = get_child_rcu(pn, cindex++);
>  		if (!n)

[Severity: Medium]

The commit message says "leaf_walk_rcu() has a similar checked cindex
before get_child_rcu(), and the traversed state can be influenced by
userspace actions". Should fib_trie_get_next() get the same treatment?

It has the same shape as this sibling walk in leaf_walk_rcu(). The only
bound is the loop condition:

net/ipv4/fib_trie.c:fib_trie_get_next() {
    ...
	while (!IS_TRIE(pn)) {
		while (cindex < child_length(pn)) {
			struct key_vector *n = get_child_rcu(pn, cindex++);

			if (!n)
				continue;

			if (IS_LEAF(n)) {
    ...
		/* Current node exhausted, pop back up */
		pkey = pn->key;
		pn = node_parent_rcu(pn);
		cindex = get_index(pkey, pn) + 1;
    ...
}

Suppose the cindex < child_length(pn) check is mispredicted on the last
iteration. Could pn->tnode[child_length(pn)] then be loaded transiently
and dereferenced as a node pointer by IS_LEAF(n)? This hunk sanitizes
the same one-past-the-end case in leaf_walk_rcu().

fib_trie_get_next() is reachable from the 0444 /proc/net/fib_trie and
/proc/net/fib_triestat files, via fib_trie_seq_ops and
fib_triestat_seq_show()->trie_collect_stats(). Any local user can drive
it, and an unprivileged user and net namespace can shape the trie
contents.

Here the out-of-bounds index is always one past the end, so an attacker
can't choose it. That makes exploitation speculative. Would something
like this keep the hardening consistent?

		while (cindex < child_length(pn)) {
			struct key_vector *n;

			cindex = array_index_nospec(cindex, child_length(pn));
			n = get_child_rcu(pn, cindex++);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261010-fib-trie-nospec-v2-1-30319b4db8d0%40nvidia.com
