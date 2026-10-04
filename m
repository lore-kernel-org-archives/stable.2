Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEC8246774;
	Sun,  4 Oct 2026 05:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791091350; cv=none; b=oEktBwiZa7PZDp+RXPhB5fNJStMZ8Vbtr24aO5Y2gmXcRVPg7LXvrV3zOeuyX0C9bKVeZ3XwZYa15CvUeJ7ntF8jPzQx1Vk9ghYHAgzyVMOewccQ4j+zhyoZEk4UQBSDTRmBfEGVGseCfn9vywVH4JsHCPzJQVyf+jyyepUMMwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791091350; c=relaxed/simple;
	bh=gFCSsZKGqyX+BtvkYmkzgjI0ln+y5zYPo6lpFHkd2i0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pE9IHAzL7AnHVBRBaGD/NvsDfrnim/OqudsOYGmuiIVVJ5s1QvELEwWBkD6TxlruKSzQKGdSrX1TSPJDgoZZZA7Ds6+g3S1MqxOCzJ+li5CbavHsboQCC+R2UyePWRF5LlWrDsUAM2HB/ikVywW3L/z/ys2F2THYOR2k4Fe9MeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRN04K3v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRN04K3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31B0D1F00893;
	Sun,  4 Oct 2026 05:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791091349;
	bh=bLv2OJdfnAx8JZtbHtlongojMY5gvUcTMUVTpzHUFW8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MRN04K3v56bEAUDejekHs3Kj4fAYg/UTFCkP61xvnSp5CY7c9BlN7++fnUjToDeL2
	 l3gLxisFn/LPr/qWLr0cITKezASKHlJKonvvO8T9oUqlvFB3lp1/SWFUZXOAHAm8uY
	 pX70aHUyCtgUnSVU30AE1j7GUsDL6l5jKvvYdSO9+75WUtjb0UR0TXu5Qc7BDBTIBE
	 XuEfNWA9s5ZZmcctBsDVuIBAuu2UKWDIUNgcawZ6n569g4shSRQYPbMf4x/UBQu9KL
	 MPBgw7y5hPYJ9a4s9WNsa+waqcFzi/OINGSweGg6Cce5yfJPAeRV+fNEhghwohw+G1
	 2XsngeM2JKo2Q==
Subject: Re: [PATCH net v3 2/2] xfrm: iptfs: hold a device reference while
 packets are queued
From: netdev-bot+sashiko@kernel.org
To: roshaen09@gmail.com
Cc: netdev@vger.kernel.org, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, chopps@labn.net,
 linux-kernel@vger.kernel.org, lilly@aronleigh.au, shubham@octane.security,
 gio@octane.security, robert@octane.security, paolo@octane.security,
 stable@vger.kernel.org
Date: Sun, 04 Oct 2026 05:22:27 +0000
Message-ID: <179109134778.434549.14695158385773009033@kernel.org>
In-Reply-To: <20260930050307.1978654-3-roshaen09@gmail.com>
References: <20260930050307.1978654-3-roshaen09@gmail.com>
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
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch stops the stale skb->dev use-after-free by pinning the
  ingress net_device with netdev_hold().
- [High] The new reference counting depends on xtfs->ra_newskb having a
  single owner, but nothing serializes ordered processing.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a
  remotely triggerable memory leak.
- [Medium] This problem wasn't introduced by this patch, but there is an
  off-by-one in __reorder_drop() (net/xfrm/xfrm_iptfs.c).

--

xfrm: iptfs: hold a device reference while packets are queued

This patch takes a net_device reference whenever an skb is stored in the
IP-TFS reorder window or becomes the in-progress reassembly skb. The
reference is released after ordered processing, and on the timeout, abort
and state destruction paths. The goal is to stop a stale skb->dev access
after the ingress device is unregistered.

Link: https://lore.kernel.org/netdev/20260921084743.817859-1-roshaen09@gmail.com/
Link: https://lore.kernel.org/netdev/179023970333.2160803.2776986020964028023@kernel.org/

> diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
> index e538cc98e2572..954d28e7ec2e5 100644
> --- a/net/xfrm/xfrm_iptfs.c
> +++ b/net/xfrm/xfrm_iptfs.c

[ ... ]

> @@ -957,7 +971,7 @@ static u32 iptfs_reassem_cont(struct xfrm_iptfs_data *xtfs, u64 seq,
>  		xtfs->ra_wantseq++;
>  	} else {
>  		/* We are done with packet reassembly! */
> -		iptfs_reassem_done(xtfs);
> +		*dev_to_put = iptfs_reassem_done(xtfs);
>  		iptfs_complete_inner_skb(xtfs->x, newskb);
>  		list_add_tail(&newskb->list, list);
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but the completed reassembly skb
put on the list here can be leaked. The list is the sublist local in
iptfs_input_ordered(), which is then passed to __input_process_payload().

In __input_process_payload(), three error exits in the parse loop jump to
the done label:

	if (skb_copy_seq_read(skbseq, data, hbytes, iphlen)) {
		XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
		goto done;
	}
	...
			if (iplen < iphlen || iphlen < sizeof(*iph)) {
				XFRM_INC_STATS(net,
					       LINUX_MIB_XFRMINHDRERROR);
				goto done;
			}
	...
		} else {
			XFRM_INC_STATS(net, LINUX_MIB_XFRMINBUFFERERROR);
			goto done;
		}

The done label comes after the send loop:

	/* Send the packets! */
	list_for_each_entry_safe(skb, next, sublist, list) {
		skb_list_del_init(skb);
		if (xfrm_input(skb, 0, 0, -2))
			kfree_skb(skb);
	}
done:

In that case, are the skbs already on sublist leaked?
__input_process_payload() returns true, so iptfs_input_ordered() frees
nothing, and nothing walks sublist afterwards.

Three kinds of skb would leak:

  - the reassembled skb queued here
  - inner packets built by iptfs_pskb_extract_seq() or
    iptfs_pskb_add_frags()
  - the reused root skb, which sits on sublist with defer == NULL and
    first_skb != NULL, so the cleanup after done does not free it

One ESP payload that holds a valid inner IPv4 packet followed by a byte with
version nibble 5 seems to leak one skb per packet. A peer on the SA can
repeat this.

With this patch applied, dev_to_put still drops the device reference of a
leaked reassembled skb, so only the skb memory leaks.

> @@ -1189,6 +1203,7 @@ static bool __input_process_payload(struct xfrm_state *x, u32 data,
>  			spin_lock(&xtfs->drop_lock);
>  
>  			xtfs->ra_newskb = skb;
> +			netdev_hold(skb->dev, NULL, GFP_ATOMIC);
>  			xtfs->ra_wantseq = seq + 1;
>  			xtfs->ra_drop_time = ktime_get_raw_fast_ns() +
>  					     xtfs->drop_time_ns;

[Severity: High]
Can this overwrite an existing ra_newskb and leak its device reference?

xfrm_input() calls xfrm_inner_mode_input() after spin_unlock(&x->lock).
iptfs_input(), iptfs_drop_timer() and the reorder_win_size == 0 fast path
all run iptfs_input_ordered() outside drop_lock. So two CPUs can do ordered
processing for the same SA at the same time.

In iptfs_input_ordered(), this check runs before __input_process_payload(),
and drop_lock is released in between:

	if (blkoff || xtfs->ra_runtlen || xtfs->ra_newskb) {

Say CPU0 handles seq N and CPU1 handles seq N+1, both with blkoff == 0 and a
truncated inner packet. Both can see ra_newskb == NULL and both reach this
"Start reassembly" block:

CPU0                                  CPU1
xtfs->ra_newskb = skbA;
netdev_hold(skbA->dev, ...);
                                      xtfs->ra_newskb = skbB;
                                      netdev_hold(skbB->dev, ...);

The runt path in iptfs_reassem_cont() has the same problem. It also assigns
ra_newskb and takes a reference without checking for an existing one. In
addition, iptfs_input_save_runt() updates ra_runtlen and ra_wantseq without
holding drop_lock.

Before this patch, the overwrite leaked skbA. With it, every release path
only sees the current ra_newskb:

  - __iptfs_reassem_done()
  - iptfs_reassem_done()
  - iptfs_drop_timer()
  - iptfs_destroy_state()

Wouldn't skbA's device reference then leak for good? That would leave
unregister_netdevice() and netns cleanup waiting forever.

The commit message says references are released "on all completion,
timeout, abort, and state-destruction paths", but this overwrite path does
not seem to be covered. Should the existing ra_newskb be aborted before it is
replaced, or should ordered processing be serialized?

[ ... ]

> @@ -1490,6 +1509,7 @@ static void __reorder_future_fits(struct xfrm_iptfs_data *xtfs,
>  	}
>  
>  	xtfs->w_saved[index].skb = inskb;
> +	netdev_hold(inskb->dev, NULL, GFP_ATOMIC);
>  	xtfs->w_savedlen = max(savedlen, index + 1);
>  	iptfs_set_window_drop_times(xtfs, index);
>  }

[Severity: High]
Once this reference is held, what releases it when the ingress device is
unregistered?

xfrm_iptfs.c has no netdevice notifier. The only xfrm NETDEV_UNREGISTER
handling is xfrm_dev_unregister():

net/xfrm/xfrm_device.c:xfrm_dev_unregister() {
	xfrm_dev_state_flush(dev_net(dev), dev, true);
	xfrm_dev_policy_flush(dev_net(dev), dev, true);
}

That only flushes offloaded states whose xso.dev matches, and
xfrm_net_pre_exit() only flushes policies.

This reference, like the ones taken in __reorder_future_shifts(),
iptfs_reassem_cont() and __input_process_payload(), is only released by the
drop timer, by ordered processing, or by iptfs_destroy_state(). Would
unregister_netdevice() then wait in netdev_wait_allrefs_any(), printing
"waiting for X to become free", until the drop deadline passes?

The deadline comes from XFRMA_IPTFS_DROP_TIME, which is a plain NLA_U32 with
no range check:

iptfs_user_init() {
	...
	if (attrs[XFRMA_IPTFS_DROP_TIME])
		xtfs->drop_time_ns =
			(u64)nla_get_u32(attrs[XFRMA_IPTFS_DROP_TIME]) *
			NSECS_IN_USEC;
	...
}

So the deadline can be as long as about 4295 seconds.

The stall can also last about twice that. When the timer fires,
iptfs_drop_timer()->iptfs_input_ordered()->__input_process_payload() can
start a new reassembly. That takes a new netdev_hold() on the same
unregistering device, with a fresh deadline of now + drop_time.

During netns teardown, default_device_exit_batch() runs before the xfrm state
cleanup, so cleanup_net() would block on these references. cleanup_net()
runs on the single-threaded netns workqueue. Could this stall namespace
destruction for the whole host?

The commit message says an unprivileged user can build this setup in a user
and network namespace. That user also picks the drop time.

Other code avoids pinning the device. IPv4 defrag stores the ifindex and
looks the device up again with dev_get_by_index_rcu(). nf_queue flushes
queued entries from a netdev notifier. Would one of these approaches work
here?

The commit message also does not mention this change in unregistration
behaviour.

[ ... ]

> @@ -1721,13 +1745,20 @@ static enum hrtimer_restart iptfs_drop_timer(struct hrtimer *me)
>  
>  	spin_unlock(&xtfs->drop_lock);
>  

[ ... ]

>  	if (count) {
>  		list_for_each_entry_safe(skb, next, &list, list) {
> +			struct net_device *dev = skb->dev;
> +
>  			skb_list_del_init(skb);
>  			iptfs_input_ordered(x, skb);
> +			netdev_put(dev, NULL);
>  		}
>  	}

[Severity: Medium]
This is a pre-existing issue, but is there an off-by-one in
__reorder_drop(), which builds the list processed here?

__reorder_future_fits() uses index = inseq - w_wantseq - 1, and
__reorder_this() shifts by count + 1. So w_saved[0] stands for
w_wantseq + 1.

When __reorder_drop() stops at an empty slot that has not expired, it runs
this:

	count = s - xtfs->w_saved;
	if (count) {
		xtfs->w_wantseq += count;

		/* Shift handled slots plus final empty slot into slot 0. */
		__vec_shift(xtfs, count);
	}

w_wantseq was already incremented once before the loop, so it now equals the
sequence number of that empty slot. The shift, however, leaves the empty slot
at index 0. Doesn't that put every saved entry one index too high?

For example, take w_wantseq = 10 and w_saved = [11, NULL, 13], where the slot
for 11 expires first:

  - __reorder_drop() sends 11 and stops at the empty slot for 12. It sets
    w_wantseq = 12 and shifts by 1, which leaves [NULL, 13].

  - Packet 12 arrives. __reorder_this() finds w_saved[0] empty and flushes
    nothing. It shifts by 1 and sets w_wantseq = 13, so 13 now sits at
    index 0.

  - Packet 13 is not delivered, even though it is the expected sequence.

  - Packet 14 arrives. __reorder_future_fits() finds index 0 occupied and
    frees 14 as "a dup of a future".

Can ordinary reordering cause legitimate packets to be dropped this way, or
held until the next timeout?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260930050307.1978654-1-roshaen09%40gmail.com
