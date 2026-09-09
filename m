Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1477E56E064;
	Wed,  9 Sep 2026 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965380; cv=none; b=e9PInqc0qsMvfULHPkS9dzpTT4FIqobBm26dPXJUbObhSk+GolIcl68dUR2rBztC71jL9gbCwRzL9UbN6VGRfcgsp4dsL45lFusAgpoJHNSQs5mgVlism/Oe4ck/QfN2b4Fw/bq3ne9bkNU8IOI0rcrFHX35ibSOOo20ldSn7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965380; c=relaxed/simple;
	bh=dcNwO1TYVpK5SNRrKzs9DWCDwgPxaNcw92EdPFzLX+g=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gq4pYeEY7dDMO4revFKJ4fKNa8PmGULDkExz0zNy09y92/68W1iwvc8O1v53/qkG314db1udxrP/dwvQ5Jpjmd1jXrsw04J/yb3MX/4gXwA7//P8aBbXi80WqYIGaAkxQi5EPV3E0WfIsW7AeHxId/FTGq9ctFYrp75VvrtAJKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1qx79m4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1qx79m4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AB951F00A3A;
	Wed,  9 Sep 2026 14:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965379;
	bh=suKghUytwOCgojehO3dIizfwMN4e7CnlgjHO63gS76c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=K1qx79m4vmpGT2FgBXpZBUXCPkVtB7fIW79mllIVB2oa31NsUhqD0FVdO1MXLcm36
	 NQYLy8FNT6JXYWTrwTPZTSDOBSR/RTClcznZFqnro9sx75HWuo66tSfapWvv8/YYI0
	 AoX8lJ/pRWB2S4oovMfOMRfoairQsWMhw9MSTG+1Uj0rONJeowqIhSmmwcxB09sUYS
	 +35sm0IIvJszHF7hXODc3R5B1+ZNSksgg0+d4G8smQWXEocNsL+H+o4mxGPImHLP0C
	 9fwwvvan3aSKfPEID/SYlGZfuyc6vTG9j6SxDSsniDRinpyOkqRAOv3yuTVRi76hqW
	 HKQXKziT6Ih8w==
Subject: Re: [PATCH net v2 15/15] mptcp: avoid pruning for OoW data
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Wed, 09 Sep 2026 14:49:37 +0000
Message-ID: <178896537782.219967.1022060629733006428@kernel.org>
In-Reply-To:
 <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-15-df1de70348b6@kernel.org>
References:
 <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-15-df1de70348b6@kernel.org>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Incomplete realization of the patch's stated principle ("do it
  only when we expect to accept the skb triggering the cleanup"): after…

--

mptcp: avoid pruning for OoW data

This moves the mptcp_try_rmem_schedule() call in mptcp_data_queue_ofo()
so that it runs after the out-of-window check instead of before it, which
avoids running the destructive OoO queue pruning for skbs that are going
to be dropped as out of window.

> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
> index 4309fca6b119..0098e2830931 100644
> --- a/net/mptcp/protocol.c
> +++ b/net/mptcp/protocol.c
> @@ -313,12 +313,6 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>  	u64 seq, end_seq, max_seq;
>  	struct sk_buff *skb1;
>  
> -	if (!mptcp_try_rmem_schedule(sk, skb)) {
> -		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
> -		mptcp_drop(sk, skb);
> -		return;
> -	}
> -
>  	seq = MPTCP_SKB_CB(skb)->map_seq;
>  	end_seq = MPTCP_SKB_CB(skb)->end_seq;
>  	max_seq = atomic64_read(&msk->rcv_wnd_sent);
> @@ -335,6 +329,12 @@ static void mptcp_data_queue_ofo(struct mptcp_sock *msk, struct sk_buff *skb)
>  		return;
>  	}
>  
> +	if (!mptcp_try_rmem_schedule(sk, skb)) {
> +		MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_RCVPRUNED);
> +		mptcp_drop(sk, skb);
> +		return;
> +	}
> +

[Severity: Medium]
The commit message says pruning should be done "only when we expect
to accept the skb triggering the cleanup".  Does the new placement
fully match that, given the duplicate-data check still happens later in
the rbtree walk of mptcp_data_queue_ofo()?

Consider an OoO queue holding A (map_seq 1000, end_seq 2000), B (2000,
3000), C (3000, 4000) with ooo_last_skb == C, and an in-window skb
(map_seq 1200, end_seq 1500) arriving while sk_rmem_alloc exceeds
sk_rcvbuf.  mptcp_prune_ofo_queue() walks back from ooo_last_skb:

net/mptcp/protocol.c:mptcp_prune_ofo_queue() {
	...
		/* Stop pruning if the incoming skb would land in OoO tail. */
		if (after64(MPTCP_SKB_CB(in_skb)->map_seq,
			    MPTCP_SKB_CB(skb)->map_seq))
			break;

		pruned = true;
		prev = rb_prev(node);
		rb_erase(node, &msk->out_of_order_queue);
		mptcp_drop(sk, skb);
	...
}

after64(1200, 3000) and after64(1200, 2000) are both false, so C and
then B are erased and freed; the loop only breaks at A.

mptcp_can_ingest() then succeeds, and the tree walk reaches:

			if (!after64(end_seq, MPTCP_SKB_CB(skb1)->end_seq)) {
				/* All the bits are present. Drop. */
				mptcp_drop(sk, skb);
				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_DUPDATA);
				return;
			}

so the incoming skb is discarded as duplicate after two already queued
segments were destroyed for it.  Since neither the rbtree walk nor
rb_link_node()/rb_insert_color() allocates memory, would it work to move
the mptcp_try_rmem_schedule() call below the duplicate and coalesce
classification instead of only below the out-of-window test?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6%40kernel.org
