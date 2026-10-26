Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793016739;
	b=N633eDRHeFK+PrdqCA1+MOFTpKpi3+5XqNtQayLOk31nOjScel3NdNZKRvvzuaId2AC6
	 91fePYLv3gEA/yglVYiUZ1KdwH57Uv+xQrQbJ1jWNamI/Kxa4IUtGKE1D1yJoNWK6QhCa
	 OUHfOz+Vo1e28Lomp5+mPRDAVyOayKJso7iJWhTxR1dXGnbTqLzu3BPdy17pMa9q34SRX
	 jJqmG23qQ72pHeFHeWoq/DbRfuC8l9xOjTQYbgin8I3d0Q2b/Nz7WoVjKAMPgN7ujXvnq
	 EhPAEg8e6tYLKpRPN+uqpbgDWifkMcQhIoWvTQlHLoQLsiBDIQo0aqf4BNI0hEqW9wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793016739;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=EKPDpnDsxP95BvhQy6gMrx0mg3B9bgjTY7R3pORfF0o=;
	b=pqphRWTUFF//tXLanc4SXj8LlIcvoDdBfdsD/CRBHOV3lrJ+KmvRtcaaQQ6hfYcsEblH
	 FTLflBHzKvMx6xp8589iioXpfubCt8mMA/B5WtIDI1dyqsjxJudFY+4/LWJR55eLOSdL1
	 qEJDIME3JmaVOaBYgMvascInbG7YfjkxV9WjBjfy19+y1pCa/QwucqpqqwPpCkqXr9x5t
	 49XjcteoGcMcmFwa18Za+te+wQG4xGC8iDVY0eps5gEYoWLFP+9nCaNhn7uaNK2THT2vw
	 5Zts0zXk1cKKGfrOLL2hWAVPvUHlwzaRhK0TZs87AlxJdaeHb6U4AkDPYY4Q1UySjfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iBw406SW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5765B606A322;
	Mon, 26 Oct 2026 12:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iBw406SW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F041F031E1;
	Mon, 26 Oct 2026 12:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793016739;
	bh=EKPDpnDsxP95BvhQy6gMrx0mg3B9bgjTY7R3pORfF0o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iBw406SWNAyN0iypY6z9eMu7GvnlQWgx71O//+605r5yzwZ0nPS5QYtL2h4pXli4b
	 jQ/8nviFCI0Ni4rjvPmue0JD1nP7zd9iiL+Vbr+PT5RwYMUo5U4P8srFZooN8q67/O
	 OS5ASw439ShiiovDUOTFVjawzHGh8ZT0ZO79ney7YB8LWOCivypf9hPnO/TLbgVZ9Z
	 zwJMbwJIGNsuKg5xVyu63tT+4rAywuC2G/YzpOPeoC4QIpXEd80c0uIVBCaSr+jdfu
	 3MZtaCRlaL6j16jSTIDbjNvxRDP896Db8tLalPtJcZ7P+R43IhNMGOKbYVg7PygMDo
	 Lfd9/xbqy5Jqw==
Message-ID: <e3a1ae72-9370-4c3c-8935-6a410a74377b@kernel.org>
Date: Mon, 26 Oct 2026 12:19:21 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/mempolicy: recompute automatic interleave weights on
 memory hotplug
To: "Gregory Price (Meta)" <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 akpm@linux-foundation.org, ziy@nvidia.com, joshua.hahnjy@gmail.com,
 rakie.kim@sk.com, ying.huang@linux.alibaba.com, honggyu.kim@sk.com,
 stable@vger.kernel.org
References: <20261024170415.4121901-1-gourry@gourry.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261024170415.4121901-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/24/26 19:04, Gregory Price (Meta) wrote:
> In auto mode, weighted interleave derives each node's weight from its
> bandwidth, reduced over the nodes in N_MEMORY. HMAT and CXL report a
> node's bandwidth once, when the node first gains memory, and nothing
> else on the hotplug path recomputes the weights.
> 
> When a node loses its memory, the other nodes keep weights computed
> with its bandwidth until another node reports. If one does while the
> node is away, the reduction skips the node and resets its weight to 1,
> which it keeps once its memory returns.
> 
> With HMAT bandwidths of 100G for nodes 0-3, and 50G and 25G for kmem
> nodes 4 and 5, weighted_interleave/nodeN reads:
> 
>   event             node 0-3   node 4   node 5
>   node 4 online         7         3        -
>   node 4 removed        7         -        -
>   node 5 online         7         -        1
>   node 4 back           7         1        1
> 
> Toggling weighted_interleave/auto to 0 and back to 1 gives the correct
> 6, 3 and 1.
> 
> Recompute the weights from the recorded bandwidth whenever a node gains
> its first memory or loses its last.
> 
> mempolicy_set_node_perf() now only records the bandwidth and calls the
> same helper, so the bandwidth is kept even if allocating the new weights
> fails. wi_state_lock is dropped between the two steps, which should be
> safe because the helper reads node_bw_table and the mode under the lock,
> so a racing writer only makes it work from newer state.
> 
> With this patch, weighted_interleave/nodeN reads 6, 3 and 1 as soon as
> node 4 is back.
> 
> Fixes: e341f9c3c841 ("mm/mempolicy: Weighted Interleave Auto-tuning")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/mempolicy.c | 66 +++++++++++++++++++++++++++++---------------------
>  1 file changed, 38 insertions(+), 28 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 0884c629670d..ffb293a4cc56 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -238,27 +238,45 @@ static void reduce_interleave_weights(unsigned int *bw, u8 *new_iw)
>  		new_iw[nid] /= iw_gcd;
>  }
>  
> +/* Recompute the weights from node_bw_table, unless they were set manually */
> +static int wi_state_refresh(void)
> +{
> +	struct weighted_interleave_state *new_wi_state, *old_wi_state;
> +	int i;
> +
> +	new_wi_state = kmalloc_flex(*new_wi_state, iw_table, nr_node_ids);
> +	if (!new_wi_state)
> +		return -ENOMEM;
> +	new_wi_state->mode_auto = true;
> +	for (i = 0; i < nr_node_ids; i++)
> +		new_wi_state->iw_table[i] = 1;
> +
> +	mutex_lock(&wi_state_lock);
> +	old_wi_state = rcu_dereference_protected(wi_state,
> +					lockdep_is_held(&wi_state_lock));
> +	/* NULL wi_state assumes auto=true */
> +	if (!node_bw_table || (old_wi_state && !old_wi_state->mode_auto)) {


I was confused about the node_bw_table check at first. Maybe

/*
 * We can get hotplug events before any BW data was recorded.
 * ...
 */

>  
>  /**
> @@ -3900,8 +3903,15 @@ static int wi_node_notifier(struct notifier_block *nb,
>  	case NODE_REMOVED_LAST_MEMORY:
>  		sysfs_wi_node_delete(nid);
>  		break;
> +	default:
> +		return NOTIFY_OK;
>  	}
>  
> +	/*
> +	 * HMAT and CXL report a node's bandwidth only when it first gains
> +	 * memory, so recompute the weights whenever N_MEMORY changes.
> +	 */
> +	wi_state_refresh();

If the function fails, should we at least pr_warn_once() ?

Acked-by: David Hildenbrand (Arm) <david@kernel.org>

-- 
Cheers,

David
