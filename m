Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794735576;
	b=D4VInM8Nr2by4dXjMzBvMnP/1KOR6EmjO2ossut822Gc+R2MynvPDllnlIL86szPdItq
	 nKjAm7p9y6Zxor6qbUGj8RpGXawghBaNVf5pJR9zfwb6E9JHxmDq3JdRGVtQFpEc9BSwv
	 TFp3e6HrCymAvXkPZd27yBTw/4IwhpM9RdfPdZtb7BhHJPBHX05XxRuoWwurC2v1sry1l
	 NCWRdCzYp8ybUmY02WUMYcBXQRHnMgRJlxeYPt0U2SCVMG72GkEah/YJNdrkzO+GKV9vo
	 2JQI2tfUZZJc20w7/7HPxzWp1zXpDvs3cjS7ckD/omvcm9LxBbjhUSjzshDyIbXvnqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794735576;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=JM6k01Ttm0jeBYqGpKvHxBo6u55v8KB/HBMFkcLSpXo=;
	b=mIlK0n4XdCLhP0k4b/lAVKz/OI2TLs0OEtFVodVxnw9bjlSS+lMMZ1gRJMr+T9UDmU16
	 CpAa7fEVCQSVQVwb1R5xPUP2/Ic5Pde1SpPt8TV0wjVO2dSUoeISxLYBLOYs6Q+V8/mbj
	 j42Si7v8hsscRX1PnAsjDRqVB0Z4LJR4m6HHcGxpdfkP8IJkrjDli16KsASJrkZTxpz4W
	 M50+F7DIvcC5h8kHKfyoG3JpQGQZIBxy3aI4kmFvi3sFC2hQy6MZxvmTQLtV5CUc4lEho
	 kHlvBaGyNTSIJ+nmnENoxQ7oRt/0kgtZL1egBQ9mnVboqh2MNu09nJFm4CYZLG5A6zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUtdOS9q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543AF606A31F;
	Sun, 15 Nov 2026 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dUtdOS9q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62091F000C4;
	Sun, 15 Nov 2026 09:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794735576;
	bh=JM6k01Ttm0jeBYqGpKvHxBo6u55v8KB/HBMFkcLSpXo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dUtdOS9qP3pJnvEH+AuAVWXe9+b4lkGivaNuSkrl90HG38yKW7pjWZHlXuZa/AMd1
	 UBN0jGDaqwvILNx2iE11KwQvW+CQgJSTfHgvLPlBYT2LZwo4lr+X6AowBRKraK8ulm
	 9uEPceTw0Jm8EYIkwdxFTEAhvy6i8SKC01MXVB+d1cMBWtcDZN0DgDNAA1QAUdt8g4
	 a4FyoFkEI+bKE/ubIsBwZlV1wL/qENSEQWvOyatg8WKMa2EqaE91yLEQ+jA2JWPPkr
	 xBq7cFiPUmRlJC08NvlzwDcjBAlsxxjCvyj+9n21pVTxK2LJISSGp1f5enUnYtp93b
	 /2VX26IAliwsA==
Subject: Re: [PATCH net v6 1/3] igb: do not let XDP frames span more than one
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
Date: Sun, 15 Nov 2026 09:39:34 +0000
Message-ID: <179473557433.2199510.15562599161772023793@kernel.org>
In-Reply-To: <20261111-igb-rx-ts-fix-v6-1-ba5b9903859c@aweta.nl>
References: <20261111-igb-rx-ts-fix-v6-1-ba5b9903859c@aweta.nl>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 (3) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] igb_xdp_setup() now calls netdev_update_features(dev) without
  first checking that the device is running or awake.
- [Medium] igb_xdp_setup() ignores the return value of igb_open() and
  then calls the new netdev_update_features(dev) unconditionally.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  igb_set_rx_mode() runs without netif_addr_lock_bh() from several paths…
- [High] This problem wasn't introduced by this patch, but
  igb_set_vf_rlpml() takes the VF-supplied msgbuf[1] (u32) into 'int…
- [High] This problem wasn't introduced by this patch, but on 2 KiB
  build_skb Rx rings (PAGE_SIZE < 8192, legacy-rx off,…

--

igb: do not let XDP frames span more than one Rx buffer

This commit limits the receive length to the configured maximum frame
size while XDP is attached, so XDP frames cannot span more than one Rx
buffer. The limit goes in RLPML, or in the PF pool's VMOLR when VFs are
allocated. The length programming moves from igb_set_rx_mode() into a
new igb_set_rlpml() called from igb_configure(), the XDP fit check now
reserves room for the Rx timestamp header, and rx-all and legacy-rx are
kept from changing while XDP is attached.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index ce91dda00ec0e..711a67f0bd801 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -1964,6 +1964,57 @@ static void igb_setup_tx_mode(struct igb_adapter *adapter)

[ ... ]

> +static void igb_set_rlpml(struct igb_adapter *adapter)
> +{

[ ... ]

> +	/* the PF pool's VMOLR is used on these MACs, see igb_set_rx_mode(),
> +	 * and with VFs it carries the only limit for the PF, also on i354
> +	 */
> +	if (hw->mac.type < e1000_82576 ||
> +	    (hw->mac.type > e1000_i350 && !vfn))
> +		return;
> +
> +	/* igb_set_rx_mode() also updates this register, and the core calls
> +	 * it under the address lock
> +	 */
> +	netif_addr_lock_bh(adapter->netdev);

[Severity: High]
This isn't a bug introduced by this patch, but the core is not the only
caller of igb_set_rx_mode(). Several others run it without
netif_addr_lock_bh(): igb_configure() just before this call,
igb_set_vf_multicasts() and igb_vf_reset() from the VF mailbox interrupt
path (holding only vfs_lock), and __igb_shutdown().

igb_set_rx_mode() walks dev->mc without the lock:

igb_write_mc_addr_list() {
    ...
	mta_list = kcalloc(netdev_mc_count(netdev), 6, GFP_ATOMIC);
	if (!mta_list)
		return -ENOMEM;

	/* The shared function expects a packed array of only addresses. */
	i = 0;
	netdev_for_each_mc_addr(ha, netdev)
		memcpy(mta_list + (i++ * ETH_ALEN), ha->addr, ETH_ALEN);
    ...
}

Suppose dev_mc_add() adds an entry between netdev_mc_count() and the
walk, for example on an IPv6 multicast join that holds only
addr_list_lock. Can this then write past the end of mta_list?

A VF can reach the unlocked path whenever it wants by sending
E1000_VF_SET_MULTICAST:

igb_msg_task()->igb_rcv_msg_from_vf()->igb_set_vf_multicasts()
  ->igb_set_rx_mode()->igb_write_mc_addr_list()

The unlocked __dev_uc_sync()->__hw_addr_sync_dev() can also race with a
locked __dev_uc_sync() on another CPU. Both update sync_cnt and refcount
and can delete entries on dev->uc. An entry freed with
list_del_rcu()/kfree_rcu() during the unlocked walk could also be used
after it is freed.

> +	vmolr = rd32(E1000_VMOLR(vfn));
> +	vmolr &= ~E1000_VMOLR_RLPML_MASK;
> +	vmolr |= pool_rlpml | E1000_VMOLR_LPE;
> +	wr32(E1000_VMOLR(vfn), vmolr);
> +	netif_addr_unlock_bh(adapter->netdev);
> +}

[Severity: High]
This is a pre-existing issue, but it sits next to the VMOLR length logic
reworked here. igb_set_vf_rlpml() writes the VF's own VMOLR from a
mailbox word that the VF controls:

igb_set_vf_rlpml(struct igb_adapter *adapter, int size, int vfn) {
    ...
	if (size > MAX_JUMBO_FRAME_SIZE)
		size = MAX_JUMBO_FRAME_SIZE;

	vmolr = rd32(E1000_VMOLR(vfn));
	vmolr &= ~E1000_VMOLR_RLPML_MASK;
	vmolr |= size | E1000_VMOLR_LPE;
	wr32(E1000_VMOLR(vfn), vmolr);
    ...
}

For E1000_VF_SET_LPE, igb_rcv_msg_from_vf() passes msgbuf[1] straight
through. A value of 0x80000000 or more becomes a negative int, skips the
clamp, and is ORed into VMOLR without being masked to
E1000_VMOLR_RLPML_MASK.

Can a malicious VF use this to set ROPE, AUPE, MPME, ROMPE, BAM, STRVLAN
and other pool bits that the PF otherwise controls? igb_set_vf_promisc()
explicitly clears ROPE, and igb_set_vmolr() clears AUPE when a port VLAN
is assigned.

With AUPE set on a port-VLAN VF, the pool would accept untagged frames.
With ROPE set and UTA all-ones (82576 with the PF in promiscuous mode,
or RAR overflow), the VF would receive unicast traffic for other MACs.

Would treating size as unsigned and masking it with
E1000_VMOLR_RLPML_MASK be enough here?

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

[Severity: High]
This is a pre-existing issue, but the comment's "even with the header"
compares against the 2 KiB SRRCTL buffer size. Does it also hold for
the build_skb data area?

igb_skb_pad() leaves exactly IGB_MAX_FRAME_BUILD_SKB bytes between the
DMA start (page_offset = IGB_SKB_PAD) and the skb_shared_info that
igb_build_skb() places at SKB_WITH_OVERHEAD(2048):

igb_skb_pad() {
    ...
		rx_buf_len = IGB_RXBUFFER_1536;

	/* if needed make room for NET_IP_ALIGN */
	rx_buf_len -= NET_IP_ALIGN;

	return igb_compute_pad(rx_buf_len);
}

On 82580 and later MACs, Rx hardware timestamping makes the MAC prepend
the 16-byte timestamp header. RLPML (or the PF pool limit) is
IGB_MAX_FRAME_BUILD_SKB here. A 1525 to 1536 byte frame from the wire
can then put up to 16 + (1536 - 4) = 1548 bytes after the DMA start on
x86_64.

Could this write up to 12 bytes into the shinfo area? Then
napi_build_skb(xdp->data_hard_start, truesize) zeroes shinfo over the
end of the payload, and __skb_put() in igb_build_skb() leaves tail past
end.

With XDP attached and the new RLPML of max_frame_size, data_end would
also land past data_hard_end at MTU 1510, or with QinQ frames at MTU
1500.

Since igb_xdp_frame_fits() now accepts this layout explicitly, should
the build_skb path also leave room for IGB_TS_HDR_LEN?

[ ... ]

> @@ -2935,6 +3020,10 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
>  	if (running)
>  		igb_open(dev);
>  
> +	/* rx-all may have been requested while XDP was attached */
> +	if (!prog && (dev->wanted_features & NETIF_F_RXALL))
> +		netdev_update_features(dev);

[Severity: Medium]
Can this new call touch a device that is runtime-suspended?

Take an interface that is down, where rx-all was requested while XDP was
attached. When XDP is removed, igb_fix_features() stops masking
NETIF_F_RXALL. igb_set_features() then sees it in changed and takes the
!netif_running() branch:

igb_set_features() {
    ...
	if (netif_running(netdev))
		igb_reinit_locked(adapter);
	else
		igb_reset(adapter);
    ...
}

igb_reset() accesses MMIO registers right away. The ndo_bpf path
(dev_xdp_install()->bpf_op()) does not take a runtime-PM reference. The
ethtool paths that reach igb_set_features() do take one.

With power/control=auto, a sequence like this seems to reach it:

  ethtool -K <if> rx-all on   (XDP attached, only wanted_features changes)
  ip link set <if> down       (igb_runtime_idle() schedules suspend
                               after 5s without link, device in D3hot)
  ip link set <if> xdp off
    igb_xdp_setup()
      netdev_update_features()
        igb_set_features()
          igb_reset()

igb_rd32() would then read all-F, set hw->hw_addr = NULL and warn about
the lost PCIe link. __igb_resume() does not restore hw_addr. Does the
NIC then stay unusable until the driver is rebound?

Before this patch, igb_xdp_setup() did not touch the hardware on a down
interface.

[Severity: Medium]
What happens here if igb_open() fails? Its return value is ignored, and
the new netdev_update_features() call runs anyway.

When XDP is removed from a running interface, igb_close()->igb_down()
disables NAPI on every q_vector and the rings are freed. __igb_open()
can then fail in Tx/Rx resource allocation, igb_request_irq() or
netif_set_real_num_*_queues(). Its error labels free the resources and
return without napi_enable(), but netif_running() is still true.

If rx-all was requested while XDP was attached, igb_set_features() then
calls igb_reinit_locked()->igb_down()->napi_disable() on NAPI instances
that are already disabled. napi_disable_locked() waits for:

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);
		val = READ_ONCE(n->state);
	}

Would this spin forever with RTNL held? Even past that point,
igb_up()->igb_configure()->igb_alloc_rx_buffers() would use rings whose
descriptors and rx_buffer_info were freed.

Ignoring the igb_open() error is older than this patch, and the broken
state would also hang on a later link down. This call, though, turns a
single failed XDP removal straight into the hang. Should igb_xdp_setup()
return the igb_open() error and skip netdev_update_features() when it
fails?

> +
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-igb-rx-ts-fix-v6-0-ba5b9903859c%40aweta.nl
