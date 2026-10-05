Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFAC325B09C;
	Mon,  5 Oct 2026 23:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241364; cv=none; b=Luc46t6MBgu2tM55EPVxpZnnbLqS0S+ZS11a9bIC0wjm03nIwZdumzSzAOi7N+HVpt2M8M01g4jW795EMf6CqFYIeGKpMuLYwQGOrEf0j74Tzy+JCHJFAZcVYyLQ48PL8NARExJG+nwKDmhFTr+oEV43m6W7bPUJWGIZGGOaqDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241364; c=relaxed/simple;
	bh=iHi95ZDiLijymz4pZCroArkTOtb0sahTEj+cUlUymm8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=L7qo5aRvjQQS8e2puX/ip8RdT/2I5ZJdkY+YXsj5rjLr8VXw8lKW6ked7jjSdMxjzGdlsxP0SqFFmTuyK19P+c3e4p5YwkoMzwy3uJoA1mlSIMDHVukCT8rMk+x5O2PlmDYcdf5WMiLrh8Az1MA2RJEL+XJzNxuofgVX3fH0BV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CC0sxDnj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CC0sxDnj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684D01F000FF;
	Mon,  5 Oct 2026 23:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791241362;
	bh=S3+uHBtHckwHoKa8RkW6BgWrGydO/oj2plVXJciUR3w=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CC0sxDnjA4nml7wjL8UhSeFrvYme/qNBANSG9zhLrZ2VMMaBZWLP/usyK0RIl8Fmt
	 p6KIBYp2dyHb5hBMluuiRgYlp/Uv+x5B7w9Vb7fiAHdbauIyiklqt/ZoBZSgmy95BP
	 SrAPE6ZMKrhQ0sOuH85axXhEXENLMECI1V2W/bnCc/4DRv95bJ927opYrply/SiulP
	 fNvBaLjIrX3Hzoz3tCxmxqfMqGQracs4jggpzYZY/wjhhke08S5hSvdXGn2qe6uDMl
	 k3uYbjFuOjVU6ihjT/F00CsvbqMTyCtDSipmRC6awprecwEtoI7aFT2ufpqxokEiFL
	 CGB0o/cYhSlpA==
Subject: Re: [PATCH net 1/6] igc: Fix RX HW timestamp reporting when
 NET_RX_BUSY_POLL is disabled
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 florian.bezdeka@siemens.com, meng.ding@siemens.com, p@1g4.org,
 tkusters@aweta.nl, jiayuan.chen@linux.dev, pulehui@huawei.com,
 dima.ruinskiy@intel.com, raanan.avargil@intel.com, gil.fine@intel.com,
 stable@vger.kernel.org, javier.herrera@afronta.com,
 aleksandr.loktionov@intel.com
Date: Mon, 05 Oct 2026 23:02:40 +0000
Message-ID: <179124136093.434549.17617483948685542955@kernel.org>
In-Reply-To: <20261001222443.3500206-2-anthony.l.nguyen@intel.com>
References: <20261001222443.3500206-2-anthony.l.nguyen@intel.com>
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

Critical: 0 · High: 1 (3) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] When CONFIG_NET_RX_BUSY_POLL=n, the fix still returns wrong RX
  hardware timestamps to sockets bound to a PTP virtual clock…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the root cause
  the commit message names (get_timestamp() falling back to…
- [High] This problem wasn't introduced by this patch, but with
  CONFIG_NET_RX_BUSY_POLL=y (the common distro default)…
- [High] This problem wasn't introduced by this patch, but the
  CONFIG_NET_RX_BUSY_POLL=y branch of igc_construct_skb_timestamps()…

--

igc: Fix RX HW timestamp reporting when NET_RX_BUSY_POLL is disabled

When CONFIG_NET_RX_BUSY_POLL is disabled, get_timestamp() cannot find the
driver through the NAPI id. It then falls back to
skb_hwtstamps(skb)->hwtstamp, which igc never fills in. This patch makes
igc_construct_skb() and igc_construct_skb_zc() put the Timer0 timestamp
into hwtstamp directly in that configuration, and keeps the
SKBTX_HW_TSTAMP_NETDEV / netdev_data scheme when BUSY_POLL is enabled.

> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 1fb5f3cbe93c5..95f7747b347b1 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -1989,7 +1989,29 @@ static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
>  	return skb;
>  }
>  
> -static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
> +static void igc_construct_skb_timestamps(struct igc_adapter *adapter,
> +					 struct sk_buff *skb,
> +					 struct igc_xdp_buff *ctx)
> +{
> +#ifndef CONFIG_NET_RX_BUSY_POLL
> +	struct igc_inline_rx_tstamps *tstamps;
> +#endif
> +
> +	if (!ctx->rx_ts)
> +		return;
> +
> +#ifndef CONFIG_NET_RX_BUSY_POLL
> +	tstamps = ctx->rx_ts;
> +	skb_hwtstamps(skb)->hwtstamp = igc_ptp_rx_pktstamp(adapter,
> +							   tstamps->timer0);

[Severity: High]
With CONFIG_NET_RX_BUSY_POLL=n, can sockets bound to a PTP virtual clock
with SOF_TIMESTAMPING_BIND_PHC still get wrong RX timestamps?

This branch always stores the Timer0 value and does not set
SKBTX_HW_TSTAMP_NETDEV. igc_get_tstamp() normally chooses the timer for
each socket:

drivers/net/ethernet/intel/igc/igc_main.c:igc_get_tstamp() {
    ...
	if (cycles)
		timestamp = igc_ptp_rx_pktstamp(adapter, tstamp->timer1);
	else
		timestamp = igc_ptp_rx_pktstamp(adapter, tstamp->timer0);
    ...
}

With the flag clear, __sock_recv_timestamp() uses hwtstamp as it is. For
BIND_PHC sockets it then converts the value:

net/socket.c:__sock_recv_timestamp() {
    ...
		if (tsflags & SOF_TIMESTAMPING_BIND_PHC)
			hwtstamp = ptp_convert_timestamp(&hwtstamp,
							 READ_ONCE(sk->sk_bind_phc));
    ...
}

ptp_convert_timestamp() passes the value to timecounter_cyc2time() as a
cycle count from the vclock's counter. For igc that counter is Timer1,
which igc_ptp_getcyclesx64() reads from IGC_SYSTIML_1/IGC_SYSTIMH_1.

igc provides getcyclesx64, so ptp_clock_freerun() returns false. That
means Timer0 can still be adjusted while vclocks exist, and Timer0 and
Timer1 can drift apart.

The Fixes: commit 069b142f5819 was added so that taprio/etf offload could
coexist with PTP vclocks. Does that use case stay broken when BUSY_POLL is
disabled?

[Severity: High]
This isn't a bug introduced by this patch, but the root cause in the
commit message seems to affect the other in-tree ndo_get_tstamp user,
tsnep, too. With CONFIG_NET_RX_BUSY_POLL=n, skb_napi_id() always returns 0:

include/linux/skbuff.h:skb_napi_id() {
#ifdef CONFIG_NET_RX_BUSY_POLL
	return skb->napi_id;
#else
	return 0;
#endif
}

So get_timestamp() in net/socket.c always falls back to
shhwtstamps->hwtstamp. tsnep_build_skb() in
drivers/net/ethernet/engleder/tsnep_main.c does:

		skb_shinfo(skb)->tx_flags |=
			SKBTX_HW_TSTAMP_NETDEV;
		memset(hwtstamps, 0, sizeof(*hwtstamps));
		hwtstamps->netdev_data = rx_inline;

Wouldn't tsnep then report the rx_inline kernel address as the RX
hardware timestamp, which is the same symptom described here? Once
hardware timestamping is enabled, an unprivileged socket using
SO_TIMESTAMPING with RX_HARDWARE|RAW_HARDWARE can receive this value.

The workaround here is an #ifndef inside igc only. Was a fix in
get_timestamp() in the core considered, so that tsnep is covered as well?

> +#else
> +	skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
> +	skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;

[Severity: High]
This is a pre-existing issue, but with CONFIG_NET_RX_BUSY_POLL=y this
branch stores only the kernel pointer ctx->rx_ts in the
netdev_data/hwtstamp union. hwtstamp never holds a real ktime. What
happens to code that reads ->hwtstamp without calling ndo_get_tstamp?

tpacket_get_timestamp() in net/packet/af_packet.c does not check
SKBTX_HW_TSTAMP_NETDEV:

	if (shhwtstamps &&
	    (flags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
	    ktime_to_timespec64_cond(shhwtstamps->hwtstamp, ts))
		return TP_STATUS_TS_RAW_HARDWARE;

So it looks like a TPACKET_V2/V3 ring with PACKET_TIMESTAMP set to
SOF_TIMESTAMPING_RAW_HARDWARE (for example tcpdump -j adapter_unsynced)
gets the RX buffer's kernel address in tp_sec/tp_nsec. Opening such a
socket needs CAP_NET_RAW.

get_timestamp() in net/socket.c also falls back to shhwtstamps->hwtstamp
with BUSY_POLL=y when dev_get_by_napi_id() fails. That can happen if
igc_reset_q_vector() and netif_napi_del() have removed the NAPI before
recvmsg runs.

[Severity: High]
This is also a pre-existing issue, but can netdev_data outlive the buffer
it points to? ctx->rx_ts points into the RX page, or into the UMEM frame
on the XSK path. The skb takes no reference on the bytes that hold the
timestamp header. igc_get_tstamp() dereferences the pointer later, at
recvmsg time:

	tstamp = hwtstamps->netdev_data;

	if (cycles)
		timestamp = igc_ptp_rx_pktstamp(adapter, tstamp->timer1);
	...

On the non-ZC path, a frame of up to IGC_RX_HDR_LEN bytes is copied
entirely into the linear area, so igc_construct_skb() takes this branch:

	} else {
		rx_buffer->pagecnt_bias++;
	}

No frag is attached in that case. igc_put_rx_buffer() then either gives
the same page half back to hardware through igc_reuse_rx_page(), or
frees it with __page_frag_cache_drain() when the page is not reusable.
igc_clean_rx_ring() also frees the pages on ifdown.

On the XSK path, igc_clean_rx_irq_zc() frees the frame right after the
skb is built:

		case IGC_XDP_PASS:
			igc_dispatch_skb_zc(q_vector, desc, ctx);
			fallthrough;
		case IGC_XDP_CONSUMED:
			xsk_buff_free(bi->xdp);

Later, xdp_umem_addr_unmap() vunmaps the UMEM.

In these cases, could igc_get_tstamp() read another packet's timestamp
or the contents of a freed page, or fault on an unmapped UMEM address?
The new !BUSY_POLL branch reads the timestamp synchronously and avoids
this, but the BUSY_POLL=y branch keeps the old behavior.

> +#endif
> +}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261001222443.3500206-1-anthony.l.nguyen%40intel.com
