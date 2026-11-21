Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795289528;
	b=QeQBNBX7nLDyr8NRXiG9qI6YYavf8MKbc0/Bcktm1aBwfqfnCrvuHweqqrFD1g07wfWs
	 cih0DeE127lw67mNpwKtRiah0W33c6ElmJsw3VVFh1OeiqgwaaGcW+77un6R4cTDR+Qu4
	 2HltdgrPAKg7/WimAIwbfm3IoXjlYTBaYOx72Q/vEdn9ejEDmXhoYoYBOjHTrPu6m4bsD
	 OOk2cjD76e32RRLwtaDs+K8ycEIxe4euFQC+f39NPdWsJedcjGZavMQQ6v4pKvpB9Iw1i
	 Rh3vtJdlnDh1324+8oaXCTar4fV/QC5EnpJmOsD1/OS1lD0t3xybowqjrVTEUoZkx1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795289528;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=CQBtHlq7OAC+Fc+WWsyNcjGGZe4Bhg14j+hMnifWPI0=;
	b=JqQHjM4RhDX2jQsnvg/dp8NxuB9+a7EUNCkT/Cp3RTGajhiDpCUqMavLhG60hvDg16j0
	 Htd+6O3hIdoi6lmZwK+G8XykLQUSKOtPHjeeo64upqOE7E59cKK+IN3OQWWFwbeqbnWOk
	 8pzjwQxq6ygaNQ/2lHPfZeb8kUtUiipAxZZP/8LXFq7esemlalBsikKY/elngUb0SgTHS
	 sTzDkYroIdC7oHz5kk63QAfJke3qM5yhXyC7EbUjlNCrI4SyWaqWV1KQPYMjw4iIukrdY
	 9v5WA5N1RiUcAYjq29Rl26LMDBKIEzVtQsTt5xnKNYUvcUYp5It8Q7z7OjTndi/rLOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fzDk+fsK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BAD606A32A;
	Sat, 21 Nov 2026 19:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fzDk+fsK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 582E81F000CA;
	Sat, 21 Nov 2026 19:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795289528;
	bh=CQBtHlq7OAC+Fc+WWsyNcjGGZe4Bhg14j+hMnifWPI0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fzDk+fsKC5LsK/Z/u9Mw5k7KVNkiq/RbCpiWmyfpVAR0wUygCqsbrD0/5JBldSVFa
	 YK03MD+1b+KzZnanUsJ6giW0FKkoHZUEvHyOTrQfkRh3h62aNV4kqIzYXrmywMZJgP
	 shOUxqPpi+1SwH5z8WtkeoEYFEgCn1eK3yQAwDtZ85rbiZocgqIDOZAMPk2iIp+eGF
	 BU6Ys2rZC7WNnmsBq+/T6PvGHCNzdWDyIpdMn2IEeG4cXF3nvwDj5aB6ydnoOWjdxC
	 FCutcixTiSDp0EkCzHfdcfVLR2aEm3DZJNzwvW5Q8ysR4mgnCVW8M5J10OGoRl0gV2
	 tBqVwWcVwKZ7A==
Subject:
 Re: [PATCH net v2 2/2] ionic: limit TSO segments to the minimum Tx ring size
From: netdev-bot+sashiko@kernel.org
To: nikhil.rao@amd.com
Cc: brett.creeley@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, leitao@debian.org,
 eric.joyner@amd.com, abhijit.gangurde@amd.com, stable@vger.kernel.org
Date: Sat, 21 Nov 2026 19:32:06 +0000
Message-ID: <179528952688.3135.14288832479047375578@kernel.org>
In-Reply-To: <20261117-b4-ionic-tso-max-segs-v2-2-f9792566c5d5@amd.com>
References: <20261117-b4-ionic-tso-max-segs-v2-2-f9792566c5d5@amd.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix only works when skb_shinfo(skb)->gso_segs is already
  correct at the moment the core checks the device limit.
- [Medium] tso_max_segs is now IONIC_MIN_TX_DESC - 1 = 127, so on a
  128-entry Tx ring a 127-segment TSO skb can only be posted when the…

--

ionic: limit TSO segments to the minimum Tx ring size

The patch raises the minimum Tx ring size to 128 descriptors, and uses
that size for the hwstamp and kdump Tx rings too. It then sets
tso_max_segs to IONIC_MIN_TX_DESC - 1 so the stack never hands the
driver a TSO skb with more segments than a Tx ring can hold. The Rx
minimum is kept at 64 and renamed to IONIC_MIN_RX_DESC.

Link: https://lore.kernel.org/all/20261112082753.6ee90fc8@kernel.org/

> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 7f0da2b0defdf..1f24c00334bd0 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c

[ ... ]

> @@ -1642,6 +1642,8 @@ static int ionic_init_nic_features(struct ionic_lif *lif)
>  	netdev->features |= netdev->hw_features;
>  	netdev->vlan_features |= netdev->features & ~NETIF_F_VLAN_FEATURES;
>  
> +	netif_set_tso_max_segs(netdev, IONIC_MIN_TX_DESC - 1);
> +

[Severity: High]
Is this limit enforced on every path that reaches ionic_start_xmit()?

The core applies it in gso_within_dev_limits():

    if (skb_shinfo(skb)->gso_segs > READ_ONCE(dev->gso_max_segs))

This check only works if gso_segs is already accurate. For SKB_GSO_DODGY
skbs, gso_segs is recomputed early by qdisc_pkt_len_segs_init(), and
only __dev_queue_xmit() calls that.

AF_PACKET with PACKET_QDISC_BYPASS and PACKET_VNET_HDR goes around it:

packet_snd()
  virtio_net_hdr_to_skb()          /* SKB_GSO_DODGY, gso_segs = 0 */
  packet_xmit()
    dev_direct_xmit()
      __dev_direct_xmit()
        validate_xmit_skb_list()
          validate_xmit_skb()
            netif_skb_features()
              gso_features_check()
                gso_within_dev_limits()   /* 0 <= 127, passes */
            __skb_gso_segment()
              tcp_gso_segment()

ionic does not set NETIF_F_GSO_ROBUST, so netif_needs_gso() is true. But
tcp_gso_segment() then takes this branch:

    if (skb_gso_ok(skb, features | NETIF_F_GSO_ROBUST)) {
        skb_shinfo(skb)->gso_segs = DIV_ROUND_UP(skb->len, mss);
        segs = NULL;
        goto out;
    }

So the original skb reaches the driver with its real gso_segs.
virtio_net_hdr_to_skb() only clamps gso_size to TCP_MIN_GSO_SIZE, so a
64KB frame can carry thousands of segments.

A tc/tcx egress BPF program that calls bpf_skb_adjust_room() or
bpf_skb_net_grow() does the same thing. These run in sch_handle_egress()
after qdisc_pkt_len_segs_init(), reset gso_segs to 0 and shrink gso_size.

In the driver, ionic_tx_descs_needed() returns gso_segs and never
compares it with q->num_descs - 1:

    if (skb_is_gso(skb)) {
        ndescs = skb_shinfo(skb)->gso_segs;

ionic_start_xmit() then does:

    if (!netif_txq_maybe_stop(q_to_ndq(netdev, q),
                              ionic_q_space_avail(q),
                              ndescs, ndescs))
        return NETDEV_TX_BUSY;

On the qdisc path the skb is requeued and retried forever. On the direct
path, if the ring was idle, no completion arrives to wake the queue. It
stays stopped until dev_watchdog() -> ionic_tx_timeout() resets the
queues.

Isn't that the same stall the commit message says is fixed? The commit
message says:

    so that every Tx ring can hold the largest TSO skb. Larger GSO
    skbs are segmented in software.

Should ionic_start_xmit() also drop or software-segment skbs where
ndescs > q->num_descs - 1, or does this need a fix in the core?

[Severity: Medium]
With tso_max_segs at 127, a 128-entry Tx ring can only accept a
127-segment TSO skb when it is completely empty. 128 is the new minimum
and the kdump default. Can a deferred doorbell keep the ring from ever
draining?

The core produces 127-segment skbs on purpose when it splits oversized
guest GSO skbs, since skb_gso_output_max_segs() caps at gso_max_segs.
TCP also produces them at an MSS of about 516 or less.

Consider a bulk dequeue on the same txq:

1. ionic_tx() posts a non-TSO skb A with ionic_txq_post(q, false). If
   netdev_xmit_more() is true and the queue is not stopped,
   __netdev_tx_sent_queue() returns false and the doorbell is deferred:

    ring_dbell = __netdev_tx_sent_queue(ndq, skb->len,
                                        netdev_xmit_more());

2. The next skb B is a 127-segment TSO skb. ionic_start_xmit() sees
   avail < gso_segs, stops the queue and returns NETDEV_TX_BUSY. The
   doorbell for A is never rung.

3. The descriptors that were doorbelled complete, and
   ionic_tx_cq_service() wakes the queue. B is retried alone with
   xmit_more false. It fails the space check again before anything is
   posted, so the doorbell is still not rung.

4. The NIC never fetches A's descriptor, so it never completes. avail
   stays below 127 and the queue stays stopped.

The periodic doorbell poke in ionic_queue_doorbell_check() would recover
this, but it starts with:

    if (!ionic->lif->doorbell_wa)
        return;

ionic_doorbell_wa() only sets doorbell_wa for asic_type 0 or ELBA. On
other ASICs the queue stays stalled until the watchdog resets the
queues.

The NETDEV_TX_BUSY path already skipped the doorbell flush before this
patch. But with no slack on the minimum ring, a single deferred
descriptor is now enough to trigger the stall.

Would it make sense to ring the doorbell before returning
NETDEV_TX_BUSY? Or to leave some headroom between tso_max_segs and the
minimum Tx ring size?

>  	netdev->priv_flags |= IFF_UNICAST_FLT |
>  			      IFF_LIVE_ADDR_CHANGE;
>  

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117-b4-ionic-tso-max-segs-v2-0-f9792566c5d5%40amd.com
