Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794733363;
	b=JOZOS91caO5Oh5MjkwRXdguWehV3XdlfqkdPkf4FNVjGSz4dt2s9hG7hLeORtVHpLsY5
	 AgEQG/J+Jfaz+PwXTHcAHbEHEPUbgiFW0zsdO6haAaUVSNf7TRrfjPDSTxa1L9q04VJuT
	 FVQ5DNboyDIIZ0+xmrUWMWNO6QyrsSIlc5wYMPB1X9u3zokcAdYHwON6QI8Rzkj/YhSQ+
	 68N/2tWqJLqTR/IqZmrpDLYWCbOORfhc8J4uvJbNrbLV6piE2CEe4W52H9QghTqoSaeyr
	 y7sE5JAI9sVx0FKmKd8WGnc2yiLi+rX0Ef87xhSII/Dhy/iXWY3RuvJnc6X9x5UN6Og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794733363;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=IECuPvYqDvrPjFIwkCwuFMCKIO5iJNpL4meqkxu4bcg=;
	b=5ACSkokmALoMWwZ1z59F2cXlSTvGh8DMGtC3rj3Kea8p8hGTkerXaPMSB2LSGxDKqYKk
	 R62AkhYkixYfsu/PSNw9guy4o6OupReL1BiLNF3A1gOcFh8vchT4mvB8r6YUEpdQK0Ve2
	 ro/nBHwqdJuvat3DnxtjQhTMd+ZixotBkKlKFB650/dCXUCxTFgcD7bkl4OD2Ym9sZwpY
	 PRuwE1M5CexxhJXRi70TDC3th76qMrGpcsnukWNBfbi+5rWep10xf+RiMUY5LfiF9bE+T
	 vARCHx+xlhWlUIKmkFXcSqXQIhGxzbMjy/S0KKtHWYYP9XQL0o96yHMD8zGeTVJ23xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="OlMJF/PT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD478606A31A;
	Sun, 15 Nov 2026 09:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OlMJF/PT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D351F000C4;
	Sun, 15 Nov 2026 09:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794733363;
	bh=IECuPvYqDvrPjFIwkCwuFMCKIO5iJNpL4meqkxu4bcg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OlMJF/PTCRHcGPHcQfjfaw+o92mAEoZTFwOFGpkjbU6IEQ1fryoEPfgB6agfDmaRX
	 zCAVDCZlE4DJkgOw3Buy7/cj39S7AoU8NOOAke72savCIM+uYiykYQm91P4RX8kcma
	 AN3psKsvprZ0Eb5fUSMKOBfr4C6MPM4+mRGPC8oUXfR+OGwgk/vrPutjr+RF1EHeYc
	 k18skX/CVS1vwF0qeIlLfTGVikGbroWv5rSu8FFDWB6SjbCGwXnYzW2VVovZWBspWB
	 RKVKsx9bNtbdhq3xpVzzC6UTq9HfOA01XgDc9KFcpOFs9tuvzbBlIRKbmby7xq1ppR
	 frFb3OTZxy7jA==
Subject: Re: [PATCH net 1/1] af_packet: Fix wrong timestamps in tcpdump
From: netdev-bot+sashiko@kernel.org
To: khai.wen.tan@linux.intel.com
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 richardcochran@gmail.com, vinicius.gomes@intel.com,
 anthony.l.nguyen@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 yoong.siang.song@intel.com, hong.aun.looi@intel.com, khai.wen.tan@intel.com
Date: Sun, 15 Nov 2026 09:02:42 +0000
Message-ID: <179473336203.2199510.3698244415513534220@kernel.org>
In-Reply-To: <20261111053728.2611070-1-khai.wen.tan@linux.intel.com>
References: <20261111053728.2611070-1-khai.wen.tan@linux.intel.com>
X-sashiko-severity: Critical
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

Thank you for your contribution! Sashiko AI review found 6 potential
issue(s) to consider.

Critical: 1 · High: 1 · Medium: 1 · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] Wild pointer dereference (oops) in
  igc_get_tstamp()/tsnep_netdev_get_tstamp() reached from…
- [High] Kernel pointer leak to user space through tp_sec/tp_nsec is
  still reachable for stacked devices.
- [Medium] In tpacket_get_timestamp() (net/packet/af_packet.c:465-471)
  the patch derives `cycles = sk_tsflags & SOF_TIMESTAMPING_BIND_PHC`…
- [Low] The commit message understates the impact and does not cover the
  full scope of the change.
- [Low] The Fixes: tag points to a later user, not the root cause.
- [Low] The new early return in tpacket_get_timestamp()
  (net/packet/af_packet.c:467-472) no longer falls back to the software…

--

af_packet: Fix wrong timestamps in tcpdump

This commit makes the mmap'ed AF_PACKET RX and TX ring paths get hardware
timestamps through netdev_get_tstamp(). That way, drivers that implement
.ndo_get_tstamp(), such as igc, report correct values. tpacket_get_timestamp()
now takes a net_device and the socket's sk_tsflags, and uses
SOF_TIMESTAMPING_BIND_PHC to pick cycles mode.

> Since commit 97dc7cd92ac6 ("ptp: Support late timestamp determination"),
> timestamps may need to be retrieved with input from the driver
> .ndo_get_tstamp(). Support was missing from mmap'ed AF_PACKET sockets.
>
> The problem was noticed using the igc driver, that since commit
> 069b142f5819 ("igc: Add support for PTP .getcyclesx64()") has migrated to
> use .ndo_get_tstamp() that timestamps were wrong on the receiving side,
> when using tcpdump.

[Severity: Low]
Is "wrong timestamps" the whole impact? For igc and tsnep, the
skb_shared_hwtstamps union holds netdev_data, which is a kernel virtual
address into the RX buffer. Before this patch, tpacket_get_timestamp()
wrote that pointer value into tp_sec/tp_nsec in the user-mapped ring.

Could the message say this is a kernel pointer disclosure, so stable and
security triage can see it?

The message also only mentions the receiving side. The patch also changes
__packet_set_timestamp() on the TX ring completion path, which now calls the
driver's ndo_get_tstamp() through skb->dev. Could that change be explained
as well?

> Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")

[Severity: Low]
Should this Fixes: tag point at 97dc7cd92ac6 instead? The commit message
names that commit as the origin of the problem. tsnep has also implemented
.ndo_get_tstamp() with netdev_data since 0abb62b68252 (2022), which is older
than the igc commit named here.

Stable trees that have tsnep's ndo_get_tstamp() but not 069b142f5819 would
not pick up this fix from the current tag.

> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index cf6429f094772..7197236c8a3b3 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -456,15 +456,20 @@ static int __packet_get_status(const struct packet_sock *po, void *frame)
>  	}
>  }
>  
> -static __u32 tpacket_get_timestamp(struct sk_buff *skb, struct timespec64 *ts,
> -				   unsigned int flags)
> +static __u32 tpacket_get_timestamp(struct net_device *dev, struct sk_buff *skb,
> +				   struct timespec64 *ts, unsigned int flags,
> +				   unsigned int sk_tsflags)
>  {
>  	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
>  
> -	if (shhwtstamps &&
> -	    (flags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
> -	    ktime_to_timespec64_cond(shhwtstamps->hwtstamp, ts))
> -		return TP_STATUS_TS_RAW_HARDWARE;
> +	bool cycles = sk_tsflags & SOF_TIMESTAMPING_BIND_PHC;

[Severity: Medium]
Is a ptp_convert_timestamp() step missing here? With cycles set,
igc_get_tstamp() returns a value based on the free-running timer1:

drivers/net/ethernet/intel/igc/igc_main.c:igc_get_tstamp() {
    ...
	if (cycles)
		timestamp = igc_ptp_rx_pktstamp(adapter, tstamp->timer1);
    ...
}

tsnep returns rx_inline->counter. In net/socket.c, __sock_recv_timestamp()
and skb_get_tx_timestamp() always follow this with a conversion into the
bound vclock:

		if (tsflags & SOF_TIMESTAMPING_BIND_PHC)
			hwtstamp = ptp_convert_timestamp(&hwtstamp,
							 READ_ONCE(sk->sk_bind_phc));

af_packet never reads sk_bind_phc. A packet socket using SO_TIMESTAMPING
with SOF_TIMESTAMPING_BIND_PHC would then get the raw counter in
tp_sec/tp_nsec, marked TP_STATUS_TS_RAW_HARDWARE. That value matches neither
the physical PHC nor the bound vclock.

Drivers without ndo_get_tstamp() ignore BIND_PHC on this path. So the same
socket setting would give timestamps from different clock domains depending
on the NIC.

> +
> +	if (shhwtstamps && shhwtstamps->hwtstamp &&
> +	    (flags & SOF_TIMESTAMPING_RAW_HARDWARE)) {
> +		ktime_t tstamp = netdev_get_tstamp(dev, shhwtstamps, cycles);

[Severity: Critical]
Can this treat a ktime value as a pointer and dereference it?
netdev_get_tstamp() is called for any non-zero hwtstamp. However, the union
only holds a driver cookie when SKBTX_HW_TSTAMP_NETDEV is set. Both
ndo_get_tstamp() implementations dereference netdev_data without any check:

drivers/net/ethernet/intel/igc/igc_main.c:igc_get_tstamp() {
    ...
	tstamp = hwtstamps->netdev_data;

	if (cycles)
		timestamp = igc_ptp_rx_pktstamp(adapter, tstamp->timer1);
	else
		timestamp = igc_ptp_rx_pktstamp(adapter, tstamp->timer0);
    ...
}

tsnep_netdev_get_tstamp() does the same with struct tsnep_rx_inline.

One way to reach this: a packet arrives on a NIC that stores a plain ktime
RX hardware timestamp (igb, ixgbe, mlx5, ice, ...). It is then routed,
bridged or mirred out an igc or tsnep port. Nothing on those paths seems to
clear skb_hwtstamps(), and the clone made in dev_queue_xmit_nit() shares
shinfo:

ip_forward / br_forward / tcf_mirred
  dev_queue_xmit()
    dev_queue_xmit_nit()
      deliver_skb(skb2, pt_prev, skb->dev)    /* dev is the igc port */
        tpacket_rcv()
          tpacket_get_timestamp()
            netdev_get_tstamp(dev, ...)
              igc_get_tstamp()
                tstamp->timer0                /* tstamp is a ktime */

Take an mmap'ed capture on the igc port that asks for raw hardware
timestamps, for example tcpdump -j adapter_unsynced. On x86-64, wouldn't
this dereference a non-canonical address in softirq or xmit context?

A forwarded igc-to-igc or tsnep-to-igc skb would also decode another
adapter's cookie with the wrong PHC or struct layout. That is because dev
here is the tap's device, not the device that produced the timestamp.

The socket path guards against both cases in net/socket.c:

		if (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP_NETDEV)
			hwtstamp = get_timestamp(sk, skb, &if_index);
		else
			hwtstamp = shhwtstamps->hwtstamp;

get_timestamp() then finds the producing device with
dev_get_by_napi_id(skb_napi_id(skb)) under rcu_read_lock(). Could
af_packet do the same?

Before this patch, af_packet only copied the union value and never
dereferenced it.

> +
> +		return ktime_to_timespec64_cond(tstamp, ts) ? TP_STATUS_TS_RAW_HARDWARE : 0;

[Severity: Low]
Is skipping the software fallback here intended? The old code fell through
to skb_tstamp() when the hardware branch failed. Now, if ndo_get_tstamp()
converts the cookie to 0, this returns 0 and never tries the
SOF_TIMESTAMPING_SOFTWARE branch.

In that case tpacket_rcv() falls back to ktime_get_real_ts64(), and
__packet_set_timestamp() writes no timestamp. That doesn't match the comment
in tpacket_rcv():

	/* Always timestamp; prefer an existing software timestamp taken
	 * closer to the time of capture.
	 */

The driver conversion has to produce exactly 0 for this to happen, so it
should be rare.

> +	}
>  
>  	if ((flags & SOF_TIMESTAMPING_SOFTWARE) &&
>  	    ktime_to_timespec64_cond(skb_tstamp(skb), ts))

[ ... ]

> @@ -2424,9 +2434,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>  	/* Always timestamp; prefer an existing software timestamp taken
>  	 * closer to the time of capture.
>  	 */
> -	ts_status = tpacket_get_timestamp(skb, &ts,
> +	ts_status = tpacket_get_timestamp(dev, skb, &ts,
>  					  READ_ONCE(po->tp_tstamp) |
> -					  SOF_TIMESTAMPING_SOFTWARE);
> +					  SOF_TIMESTAMPING_SOFTWARE,
> +					  READ_ONCE(sk->sk_tsflags));

[Severity: High]
Can the netdev_data kernel pointer still leak into the ring when dev is not
the device that produced the timestamp? For igc and tsnep RX skbs,
skb_hwtstamps(skb)->netdev_data points into the RX buffer.

The same skb can reach tpacket_rcv() with dev set to an upper device. One
case is vlan_do_receive() or an rx_handler returning RX_HANDLER_ANOTHER in
__netif_receive_skb_core():

		if (vlan_do_receive(&skb))
			goto another_round;

This walks skb->dev->ptype_all again for the VLAN, macvlan, ipvlan, bond or
bridge device. Forwarding to a non-igc egress port or a veth peer does the
same.

Only igc and tsnep implement ndo_get_tstamp(). For any other device,
netdev_get_tstamp() falls back to:

	return hwtstamps->hwtstamp;

That is the pointer read back as a ktime, and tpacket_get_timestamp()
reports it with TP_STATUS_TS_RAW_HARDWARE. A direct-map address is a small
negative s64 in nanoseconds, so the full pointer looks recoverable from
tp_sec/tp_nsec.

__packet_set_timestamp() passes skb->dev the same way. Would gating on
SKBTX_HW_TSTAMP_NETDEV and finding the producing device with
dev_get_by_napi_id(), as get_timestamp() in net/socket.c does, fix both
callers?

>  	if (!ts_status)
>  		ktime_get_real_ts64(&ts);
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111053728.2611070-1-khai.wen.tan%40linux.intel.com
