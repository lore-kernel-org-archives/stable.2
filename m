Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33F53D9DAD;
	Thu, 10 Sep 2026 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789026755; cv=none; b=gqKILzleQDfA2sfshgP1Wq03pHLsoeslbeRQxsLJxeKfanEAhgcqczpHMwSXW1y/+Qs2ID40964gHTC+gZuME6zBvvziiRcN5baYg6xOg3+dCcfl1wjGHJ20amICJ0A9+YSIp/R7FizgcXAMxQgL58cBxoev0JyiKMNU+m7o7hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789026755; c=relaxed/simple;
	bh=k7QWAev1of4Qo1pZx6aLH3WYBxnZXfSsTRkXPXh2oT8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fbUEy9YfIldzp3s9hC2UnJPRiopf6h5FYfilWIsyMTf499X1ozexrzBOfRvBLOVvQH0uO+uoLr7k+AdCa3qaDhShJp1NQrcpzvUEJQCcRvpAOz+Fykaf3s9Lh9TJ6fUPKi/NTtu0u1VHCrbnXkVZmIeJS+Gb1BX2M5eEP6V3yx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkbgVlXF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkbgVlXF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82CD11F000FF;
	Thu, 10 Sep 2026 07:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789026753;
	bh=1pVWhZMGqI1p6cZUeIZCzL+vpwVRzrPUkM+O9rcKPwg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HkbgVlXFcmDCXUSMMh2H6w3joSEaotXxi7a83g2aQ1M4rAxtrmAdBBOabR2DRTe3o
	 wYkWky2PHe86d7Awzbk/UpndWf9HLYYZSKa7OEzWvcIEVfRORJMNMjh52TYsgVUUun
	 z7GfVPD2nXXHvoHYa+FazefkS4mI8i97JS9yQ12piDBd4eE1ZCq6cgAe9JV4vQ7Ybb
	 847Zbnb23DjZ6auRRLxbHZ8iayftsiYXZKlinQ26sBhBvsQckc7sFsfjBajmOrVW81
	 f0GGtE8UbMvHCI9u4zV0HI93OUKQC6Xxy6inpYXyJq+GRBf7VSi7jhjVGpgxMlRmiJ
	 1OvQDhYclEV+Q==
Subject:
 Re: [PATCH] net: wwan: mhi_wwan_mbim: validate datagram bounds before copy
From: netdev-bot+sashiko@kernel.org
To: elb12345@hotmail.co.uk
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 10 Sep 2026 07:52:32 +0000
Message-ID: <178902675202.219967.7469002481528493501@kernel.org>
In-Reply-To: =?utf-8?q?=3CAS8P251MB0001E25A247262552A62241BC8B22=40AS8P251MB?=
 =?utf-8?q?0001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
References: =?utf-8?q?=3CAS8P251MB0001E25A247262552A62241BC8B22=40AS8P251MB0?=
 =?utf-8?q?001=2EEURP251=2EPROD=2EOUTLOOK=2ECOM=3E?=
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

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

- [Medium] Commit message understates the severity of the bug being
  fixed.

Pre-existing issues:
- [High] The outer `while (1)` NDP walk in mhi_mbim_rx()
  (drivers/net/wwan/mhi_wwan_mbim.c) has no iteration bound and no…

--

net: wwan: mhi_wwan_mbim: validate datagram bounds before copy

This adds a bounds check in mhi_mbim_rx() so that an NDP16 datagram entry
whose offset plus length falls outside the received skb is skipped instead
of being copied.  The check mirrors the one in cdc_mbim.c.

A couple of questions below, one about the commit message wording and one
about the loop that encloses the changed lines.

> mhi_mbim_rx() copies datagrams from the NTB using skb_copy_bits() but
> never validates that the datagram offset and length from the NDP entry
> actually lie within the source skb. If a malicious or buggy modem sends
> an NDP entry with dgram_offset + dgram_len > skb->len, skb_copy_bits()
> returns -EFAULT and the destination skb is delivered with partially
> uninitialized data.

[Severity: Medium]
Is "partially uninitialized data" the right description of the pre-patch
behaviour?  skb_copy_bits() does the range test as its very first
statement:

net/core/skbuff.c:skb_copy_bits() {
	if (offset > (int)skb->len - len)
		goto fault;
	...
}

so on the out-of-range case nothing at all is copied into the destination
buffer.

In mhi_mbim_rx() the destination skb has already been allocated and
extended before the copy, and the copy's return value is discarded:

	skbn = netdev_alloc_skb(link->ndev, dgram_len);
	if (!skbn)
		continue;

	skb_put(skbn, dgram_len);
	skb_copy_bits(skb, dgram_offset, skbn->data, dgram_len);

netdev_alloc_skb() does not zero the payload area, so wouldn't every one
of the up-to-65535 bytes handed to netif_rx() be stale slab or page-frag
content rather than a partially filled datagram?  The protocol
classification that follows, skbn->data[0] & 0xf0, would also be reading
that stale content.

Would it be worth restating this as a full uninitialized kernel memory
disclosure driven by the modem-supplied wDatagramIndex/wDatagramLength
fields, so that stable and security triage see the real impact?

> diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
> index a949987125976..acdcaceebc488 100644
> --- a/drivers/net/wwan/mhi_wwan_mbim.c
> +++ b/drivers/net/wwan/mhi_wwan_mbim.c
> @@ -315,6 +315,9 @@ static void mhi_mbim_rx(struct mhi_mbim_context *mbim, struct sk_buff *skb)
>  			if (!dgram_offset || !dgram_len)
>  				break; /* null terminator */
>  
> +			if (dgram_offset + dgram_len > skb->len)
> +				continue;
> +
>  			skbn = netdev_alloc_skb(link->ndev, dgram_len);
>  			if (!skbn)
>  				continue;

[Severity: High]
This is a pre-existing issue and not introduced by this patch, but since
the change hardens the inner DPE loop against the same untrusted NDP data,
can the outer NDP walk in mhi_mbim_rx() still be spun forever by the
modem?

The loop back-edge takes wNextNdpIndex verbatim and zero is the only exit
condition:

drivers/net/wwan/mhi_wwan_mbim.c:mhi_mbim_rx() {
	while (1) {
		...
unlock:
		rcu_read_unlock();
next_ndp:
		/* Other NDP to process? */
		ndpoffset = (int)le16_to_cpu(ndp16.wNextNdpIndex);
		if (!ndpoffset)
			break;
	}
}

mbim_rx_verify_nth16() returns le16_to_cpu(nth16->wNdpIndex) unchanged,
and mbim_rx_verify_ndp16() only checks wLength against
USB_CDC_NCM_NDP16_LENGTH_MIN and that the DPE array fits in skb->len.
Neither places any constraint on wNextNdpIndex.

So for an NDP16 with wLength == 0x10 (nframes == 1) followed by a
{index=0,len=0} DPE, the inner for loop breaks immediately, and if
wNextNdpIndex points back at that same NDP the loop re-reads identical
bytes with no per-iteration state change (rx_seq is updated before the
loop, the skb is not modified), so is the !ndpoffset exit ever reached?

The function this patch takes its check from guards exactly this:

drivers/net/usb/cdc_mbim.c:cdc_mbim_rx_fixup() {
	int loopcount = 50; /* arbitrary max preventing infinite loop */
	...
	ndpoffset = le16_to_cpu(ndp16->wNextNdpIndex);
	if (ndpoffset && loopcount--)
		goto next_ndp;
}

MHI downlink callbacks reach mhi_mbim_rx() from a tasklet
(tasklet_schedule(&mhi_event->task) in drivers/bus/mhi/host/main.c), so
would an unterminated walk here wedge softirq processing on that CPU and
trip the soft lockup or RCU stall detectors?

Would adding an equivalent loopcount guard, or requiring wNextNdpIndex to
advance past the current NDP, be appropriate alongside this fix?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/AS8P251MB0001E25A247262552A62241BC8B22%40AS8P251MB0001.EURP251.PROD.OUTLOOK.COM
