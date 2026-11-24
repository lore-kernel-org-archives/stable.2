Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795519737;
	b=St6xMMKz7eC8fGBaaWK+PVql7TAMLG0zEdT4zATcPBD+Mr0l7IjSECuSwTzcxvoJ0xCs
	 3m//zWIhHjXGD0MxVDZe8waoaJK1GnJEgImHDb8T4QGCfStU/Y+qwbB1tofgWb8+stPD+
	 CB/fkuLSQ0exL9HBT7wfcWWX5GDbD8LPKBVggnhKImz01YIYOOV0VUeko1yzi0PiwIaX4
	 DJUe4euDqenliFasDpQvrBrongH+KcbIXzPrIUQOQhSeNmYWqfnj7Q6qRW8ZaGZUCPVUn
	 SetOXAaKPXJqiK7WJTUvrbv4gtgLSszk78Mq12v+vWXl7FYg9+1eGxR7WDxYIjqNCGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795519737;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=QF7Z4ahA77tf4AHsZkjR7QnsK6GbHcCfwX/ToF0HL3U=;
	b=ZwjMc1Q9Lxx370LkG7e5X/2kCAorai0DntmXo0tbWOEoZjBWkRgeGiHZtXP1K/kTeFKh
	 RVspUR9XudvQrVtcq44ojPLOBcGSnVC65hHLP+0T/UwnUzefgFK1cgdzPsVCrTKtwSjDV
	 D5I0xjkb7Q+LuXZSIGGeVqwLVgoiDkC+PpTBwbsODSPYBOs8DEvkP+4nyMAHt5HKb3hIK
	 v+HUurQPTDcN0nmN7UxC8j3eUm8ornCILU7OFFdy/Q8tXAdnjPCMKAngaf8aRKV4TwvNo
	 h5SPcIUEtl3peAD31ZAH+HyipbTJ5EbITpvZTeWnRwOwkGqr8Od+GIdmJEETcObsKCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JW700L9I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421B8606A31E;
	Tue, 24 Nov 2026 11:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JW700L9I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA891F000C0;
	Tue, 24 Nov 2026 11:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795519737;
	bh=QF7Z4ahA77tf4AHsZkjR7QnsK6GbHcCfwX/ToF0HL3U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JW700L9IsGvqCpLi8XBcYh5DMneKnWfDPewXC89iUf7f837UEswqFt+SdiqSP8l+S
	 1eSzhPcjym5IPYIZ2A0mhPoGb9W8/1n1BpSlZEb9fzVul7QB0YPBtv4jhG3ZjvoqwT
	 nWQ3xzFXuewPR7QaYPzaQRXIUeihHEcmNZ+V8jyQt9XppgNiyD9SVlroEaniQ2tkzx
	 yOYTJe/qJxAs8gZRpiQ9Zqtm14qGmtzqZ77NfLCu9e18TsgoejL9RGcZc+PfF3D8XQ
	 w+FCY9jzAAbv5E5g/mnpJNeIqQUm8Uttb1YQJorYNYHErL6u9Q64atRwjVu9EmUbR0
	 myfhz2FhC06kw==
Subject: Re: [PATCH net v7 1/3] igb: do not let XDP frames span more than one
 Rx buffer
From: netdev-bot+sashiko@kernel.org
To: tkusters@aweta.nl
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 sven.auhagen@voleatech.de, richardcochran@gmail.com, kurt@linutronix.de,
 sriram.yagnaraman@ericsson.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 maciej.fijalkowski@intel.com, p@1g4.org, stable@vger.kernel.org
Date: Tue, 24 Nov 2026 11:28:55 +0000
Message-ID: <179551973551.3135.7270095499525377709@kernel.org>
In-Reply-To: <20261120-igb-rx-ts-fix-v7-1-63b03045978e@aweta.nl>
References: <20261120-igb-rx-ts-fix-v7-1-63b03045978e@aweta.nl>
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

Critical: 0 · High: 1 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] igb: missing IGB_TS_HDR_LEN room in 2 KiB build_skb buffers with
  XDP
- [Medium] igb_xdp_setup() now calls
  pm_runtime_get_sync(&adapter->pdev->dev) while holding RTNL (ndo_bpf…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it touches the
  same VMOLR.RLPML field the patch now manages, and it crosses a guest-…

--

igb: do not let XDP frames span more than one Rx buffer

While XDP is attached, this commit limits the receive length (RLPML, or the
PF pool's VMOLR when VFs are allocated) to the configured max frame size,
so a frame cannot span more than one Rx buffer. It moves the RLPML/VMOLR
programming out of igb_set_rx_mode() into a new igb_set_rlpml() called
from igb_configure(), leaves room for the Rx timestamp header in the XDP
buffer size check, and blocks rx-all and legacy-rx changes while XDP is
attached. If rx-all was requested while XDP was attached, removing XDP
runtime resumes the device and calls netdev_update_features().

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index ce91dda00ec0e..5f1a5e2240e64 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -1964,6 +1964,57 @@ static void igb_setup_tx_mode(struct igb_adapter *adapter)

[ ... ]

> +	/* igb_set_rx_mode() also updates this register, and the core calls
> +	 * it under the address lock
> +	 */
> +	netif_addr_lock_bh(adapter->netdev);
> +	vmolr = rd32(E1000_VMOLR(vfn));
> +	vmolr &= ~E1000_VMOLR_RLPML_MASK;
> +	vmolr |= pool_rlpml | E1000_VMOLR_LPE;
> +	wr32(E1000_VMOLR(vfn), vmolr);
> +	netif_addr_unlock_bh(adapter->netdev);
> +}

[Severity: High]
This issue was not introduced by this patch. It is in the VF pool
counterpart of the VMOLR.RLPML programming that igb_set_rlpml() now does
for the PF pool, so it seemed worth raising here.

igb_rcv_msg_from_vf() hands the VF-supplied mailbox word directly to
igb_set_vf_rlpml():

igb_rcv_msg_from_vf()
    retval = igb_set_vf_rlpml(adapter, msgbuf[1], vf);

In igb_set_vf_rlpml(), size is an int and only the upper bound is
checked:

static inline int igb_set_vf_rlpml(struct igb_adapter *adapter, int size,
				   int vfn)
{
	...
	if (size > MAX_JUMBO_FRAME_SIZE)
		size = MAX_JUMBO_FRAME_SIZE;

	vmolr = rd32(E1000_VMOLR(vfn));
	vmolr &= ~E1000_VMOLR_RLPML_MASK;
	vmolr |= size | E1000_VMOLR_LPE;
	wr32(E1000_VMOLR(vfn), vmolr);
	...
}

Suppose a VF sends E1000_VF_SET_LPE with msgbuf[1] = 0xFFFFFFFF. Then
size is negative and passes the signed check. It is also ORed into VMOLR
without being masked with E1000_VMOLR_RLPML_MASK.

Could a malicious VF use this to set AUPE, ROPE, BAM, MPME and the other
high VMOLR bits on its own pool? For a VF with an administrative port
VLAN the PF clears AUPE through igb_set_vmolr(adapter, vf, !vlan), and
igb_set_vf_promisc() never lets a VF set ROPE. This path seems to get
around both restrictions.

This looks like it goes back to commits 7d5753f08c5b and d3836f8e2517.
Would masking size with E1000_VMOLR_RLPML_MASK, or handling it as
unsigned, before the write be enough here?

[ ... ]

> @@ -2933,7 +3019,20 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
>  	}
>  
>  	if (running)
> -		igb_open(dev);
> +		err = igb_open(dev);
> +
> +	/* rx-all may have been requested while XDP was attached. A failed
> +	 * igb_open() leaves NAPI disabled, so do not reconfigure then. A down
> +	 * interface can be runtime suspended; resume it first, as ethtool
> +	 * does before it changes features.
> +	 */
> +	if (!prog && !err && (dev->wanted_features & NETIF_F_RXALL)) {
> +		pm_runtime_get_sync(&adapter->pdev->dev);

[Severity: Medium]
igb_xdp_setup() is called through ndo_bpf with RTNL held. Can this
pm_runtime_get_sync() deadlock with a runtime suspend that has already
started?

On a down interface, igb_runtime_idle() and the watchdog schedule a
runtime suspend with pm_schedule_suspend(). Suppose the pm_wq worker has
already set the device to RPM_SUSPENDING. It then runs:

rpm_suspend()
  igb_runtime_suspend()
    __igb_shutdown(pdev, NULL, 1)
      rtnl_lock();    <- waits for the RTNL held by igb_xdp_setup()

At the same time the XDP removal thread is in:

igb_xdp_setup()
  pm_runtime_get_sync()
    rpm_resume()
      sleeps TASK_UNINTERRUPTIBLE while runtime_status == RPM_SUSPENDING

Neither side can make progress, and RTNL stays held, so all network
configuration on the host would hang.

To hit this, rx-all has to be requested while XDP is attached, and the
XDP removal on the down interface has to race with the start of the
delayed runtime suspend.

The same pattern of RTNL plus pm_runtime_get_sync() already exists in
__igb_open() and in the ethtool core. So the root cause is __igb_shutdown()
taking RTNL from the runtime suspend path. This patch still adds a new
place on the XDP removal path that waits on runtime PM under RTNL, which
that path did not do before.

> +		/* still detached if the resume failed */
> +		if (netif_device_present(dev))
> +			netdev_update_features(dev);
> +		pm_runtime_put(&adapter->pdev->dev);
> +	}
>  
>  	return 0;
>  }

[ ... ]

> @@ -2886,6 +2946,27 @@ static int igb_setup_tc(struct net_device *dev, enum tc_setup_type type,
>  	}
>  }
>  
> +/* Check that a frame fits in one Rx buffer together with the inline Rx
> + * timestamp header, for the buffer size igb_set_rx_buffer_len() selects.
> + * The ring flags are only updated when the rings are configured, so they
> + * are not used here. For build_skb rings the frame is limited to
> + * IGB_MAX_FRAME_BUILD_SKB, which is below the 2 KiB hardware buffer size
> + * even with the header.
> + */
> +static bool igb_xdp_frame_fits(struct igb_adapter *adapter, int max_frame)
> +{
> +#if (PAGE_SIZE < 8192)
> +	if (!(adapter->flags & IGB_FLAG_RX_LEGACY)) {
> +		if (max_frame <= IGB_MAX_FRAME_BUILD_SKB &&
> +		    !IGB_2K_TOO_SMALL_WITH_PADDING)
> +			return true;
> +
> +		return max_frame + IGB_TS_HDR_LEN <= IGB_RXBUFFER_3072;
> +	}
> +#endif
> +	return max_frame + IGB_TS_HDR_LEN <= IGB_RXBUFFER_2048;
> +}
> +
>  static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
>  {
>  	int i, frame_size = dev->mtu + IGB_ETH_PKT_HDR_PAD;

[Severity: High]
The comment above igb_xdp_frame_fits() says IGB_MAX_FRAME_BUILD_SKB is
below the 2 KiB hardware buffer size even with the timestamp header.
That holds for SRRCTL.BSIZEPKT. Is that the limit that matters on a
build_skb ring, though?

On a build_skb ring the DMA starts at page_offset = IGB_SKB_PAD.
igb_skb_pad() computes IGB_SKB_PAD as SKB_WITH_OVERHEAD(2048) minus
IGB_MAX_FRAME_BUILD_SKB. That leaves exactly IGB_MAX_FRAME_BUILD_SKB
bytes (1536 on x86_64) before skb_shared_info, with no room for
IGB_TS_HDR_LEN. Only RLPML keeps the DMA inside that area.

With Rx timestamping on an 82580 or later MAC, the MAC prepends the
16-byte header and strips the 4-byte FCS, so it writes wire_len + 12
bytes. With XDP attached at MTU 1510, igb_set_rlpml() programs
min(IGB_MAX_FRAME_BUILD_SKB, max_frame_size) = 1536. Frames of 1525
to 1536 bytes on the wire are then accepted, and xdp.data_end in
igb_clean_rx_irq() ends up as much as 12 bytes past
xdp_data_hard_end(). At MTU 1500, max_frame_size is 1526, so double
tagged frames of 1525 and 1526 bytes still overflow.

For XDP_TX and XDP_REDIRECT, xdp_update_frame_from_buff() hits the
"missing reserved tailroom" XDP_WARN and the frame is dropped.

For XDP_PASS, igb_build_skb() calls napi_build_skb(), which zeroes
skb_shared_info over the last bytes of the payload. __skb_put() then
moves skb->tail past skb->end.

Once an admin has enabled hardware timestamping, for example through
ptp4l, any peer on the link can send such frames.

The non-XDP build_skb path has the same layout and an RLPML of
IGB_MAX_FRAME_BUILD_SKB, so part of this predates the patch. But the
commit message says the header room is reserved on all MACs, and the
build_skb branch in igb_xdp_frame_fits() is the one case where it is
not.

Should that branch also require max_frame + IGB_TS_HDR_LEN <=
IGB_MAX_FRAME_BUILD_SKB, with the build_skb RLPML and VMOLR limits
lowered to match? Or would you rather reserve IGB_TS_HDR_LEN in
IGB_SKB_PAD, or fall back to 3 KiB buffers while Rx timestamping is
enabled?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261120-igb-rx-ts-fix-v7-0-63b03045978e%40aweta.nl
