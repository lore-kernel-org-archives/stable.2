Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E403A2544;
	Thu, 10 Sep 2026 09:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789033905; cv=none; b=h0U2gHSxMlyRuS0uuG4ksNQkFpyfUU8sVWuZM2xXkg6zc4dBxvdg4SDSnX6fCT4JjK3RhrwsGuAAoeAfe/wUkxjlBV4xCqmjRgBFH5nJXAm4rnBUf0Db7OW8cn0/08jmJwwGzPlzMxaBfAFYu/IFcU/69jyQDZj9nPj7r3VSWYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789033905; c=relaxed/simple;
	bh=RQcHYqBugJ/Sid5K13Cf0ZgOX+p5J2xQrczyISiM5xc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lWcXIxlxZYmUkkrVklsE+0+rOkbiD2OymYFGpeSNj6p/xFPzvRzVF18YSgaRJktoqvEBU5Z2GcwJ1QfOZQhq1jP32zb6raBiOMaeRgQIBoaOCJ5QzJiIZ011eBWwbtLJuLaeVjdef8ku5ev5kklolgj4oifcIAC8UNTC93/POPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4JwGSuY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4JwGSuY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE9991F000FF;
	Thu, 10 Sep 2026 09:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789033904;
	bh=pR+ZZngK0UPDV1dXrQk98rJQmPY1iQ3UXV802dKNK8s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R4JwGSuYETgfZBOwBYhdf+DH5MM4+Ts2LkkM5RtPy/A7KtjM2bD+34flw5c9FVL4U
	 bX/lt6ijbzHPl8vveyyehCI+5egZfLMwXtD/qjPqFQm/Hv/Ge4ZvqbtIT9jk+9nxct
	 DY5zduqzeOygbP0a5MBB/6WLOcpJW0mBrw6VZ6qaPhW/iuWvIpecvAVjN9Oa+Dq8lp
	 ksy4mwB1R0CJ+eguQ4XC1H2SfGz7F3ipG6RL2t0V76JkoBjBVapQkrH71c/Bop+X8b
	 PHYh25tezXksNxGzPDkG7G6yUpzfz9deoWzizOBeKA2NY6a6xF5Md+sKBTz61vBPCi
	 gbeOdMS4Do1zg==
Subject: Re: [PATCH net] loopback: orphan zerocopy frags before releasing the
 sender in loopback_xmit()
From: netdev-bot+sashiko@kernel.org
To: doebel@amazon.de
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 10 Sep 2026 09:51:43 +0000
Message-ID: <178903390340.219967.14631556073294686161@kernel.org>
In-Reply-To: <20260909085542.3370986-1-doebel@amazon.de>
References: <20260909085542.3370986-1-doebel@amazon.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 1

- [High] Incomplete fix: the bug class the commit claims to close
  (AF_PACKET PACKET_TX_RING zerocopy frags being released to userspace…
- [Low] No in-tree test pins down the newly fixed behaviour.

--

loopback: orphan zerocopy frags before releasing the sender in loopback_xmit()

This adds a skb_orphan_frags_rx() call at the top of loopback_xmit() so that
AF_PACKET PACKET_TX_RING zerocopy frags are copied into kernel memory before
the bare skb_orphan() runs tpacket_destruct_skb() and returns the ring slot to
userspace.  On allocation failure the skb is dropped and the tx_dropped
counter is bumped.

> diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
> index 1fb6ce6843ad..31ae10a9d791 100644
> --- a/drivers/net/loopback.c
> +++ b/drivers/net/loopback.c
> @@ -72,6 +72,23 @@ static netdev_tx_t loopback_xmit(struct sk_buff *skb,
>  {
>  	int len;
>  
> +	/* The skb_orphan() below will run the skb's destructor, which
> +	 * for AF_PACKET TX-ring senders marks the slot as TP_STATUS_AVAILABLE
> +	 * again, even though it still has zerocopy frags pointing to it that
> +	 * will only be copied later in the receive path's
> +	 * skb_orphan_frags_rx(). As such, if the receive path gets deferred,
> +	 * for example by RPS steering the packet to another CPU, this creates
> +	 * a race where userspace may fill in new data into the frag before the
> +	 * old data gets copied out.
> +	 *
> +	 * Take a kernel-private copy.
> +	 */
> +	if (unlikely(skb_orphan_frags_rx(skb, GFP_ATOMIC))) {
> +		dev_core_stats_tx_dropped_inc(dev);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_SKB_UCOPY_FAULT);
> +		return NETDEV_TX_OK;
> +	}
> +

[Severity: High]
Is loopback_xmit() the only local reinjection site with this pattern?
vrf_local_xmit() in drivers/net/vrf.c looks like the same sequence, and its
comment even says it reinserts "similar to loopback handling":

drivers/net/vrf.c:vrf_local_xmit() {
	unsigned int len = skb->len;

	skb_orphan(skb);

	skb_dst_set(skb, dst);
	...
	if (likely(__netif_rx(skb) == NET_RX_SUCCESS))
		dev_dstats_rx_add(dev, len);
	...
}

There is no skb_orphan_frags_rx() before that skb_orphan(), and the path is
reachable from an AF_PACKET TX-ring send on a VRF device:

  tpacket_fill_skb()      /* skb_zcopy_set_nouarg(skb, ph.raw) */
    -> dev_queue_xmit()
      -> vrf_xmit()
        -> is_ip_tx_frame()
          -> vrf_process_v4_outbound()   /* rt->dst.dev == vrf_dev */
            -> vrf_local_xmit()

vrf_process_v4_outbound() only pulls ETH_HLEN + sizeof(struct iphdr), so the
payload stays in the user pages, and __netif_rx() can again defer the read to
another CPU through RPS/backlog after skb_orphan() has already marked the slot
TP_STATUS_AVAILABLE.

Would it make sense to mirror this hunk in vrf_local_xmit(), or to do the copy
once in the common receive-injection path (netif_rx_internal() /
enqueue_to_backlog()) so that all local reinjection sites are covered?

>  	skb_tx_timestamp(skb);
>  
>  	/* do not fool net_timestamp_check() with various clock bases */

Regarding the reproducer in the changelog:

>       ip netns add ns && ip -netns ns link set lo up
>       ip netns exec ns sh -c \
>           'echo 100 > /sys/class/net/lo/queues/rx-0/rps_cpus'
>       taskset -c 0 ip netns exec ns ./txring_overwrite

[Severity: Low]
Could the rps_cpus and taskset setup be added to the in-tree harness as well?

tools/testing/selftests/net/txring_overwrite.c binds the TX ring to "lo" in
setup_tx() and main() sends the two frames through the reused slot, but
nothing configures rx deferral:

tools/testing/selftests/net/run_afpackettests:
	./in_netns.sh ./txring_overwrite

tools/testing/selftests/net/in_netns.sh:setup() {
	ip netns add "${NETNS}"
	ip -netns "${NETNS}" link set lo up
}

Without the rps_cpus mask and the CPU pinning, __netif_rx() consumes the frags
in line on the sending CPU, so txring_overwrite passes both with and without
the new skb_orphan_frags_rx() call in loopback_xmit().  As it stands, removing
that call again would not make any in-tree test fail.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909085542.3370986-1-doebel%40amazon.de
