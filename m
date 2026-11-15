Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794735578;
	b=swqdrz4+30OHPgv6cLkhj3va4E0s830pMMOZUd1wqLMmE9eaxuLDO1dNMfwSpdzBwV21
	 LHuF6qadXZF4XBQQImh1gxqSNdkLBnSqybhfKk2R/gHGutIev4pXd6lsBdvUCqN90eAq/
	 XFml607VPYtyNNwIylKZx99BW21yqL1e1YZL7lij+3s39GQTWyaGbXRCgOlpARtGy7w3S
	 XQyt7pjZD9SvSpmFdZ0Dtix6ZJ7pqWTxawXmZ62dp8hn6XcOjyHvMCGrx34pJm4ocZ1O2
	 +CJq9WV+IHDbbVi1qG07e6+ivz/hKyPyU+47LJrhRGtMiI54tQd9RItbu/H1+xISniQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794735578;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wyznBQGouKTKz8qr6f9Rju1zs8kXOgCrx7IgnhIi4QI=;
	b=qHVPm0JJliGbbA3dmVzxPRxsPMCu5kA8R7yZ60q9VBB6De+wiI7YBCdY6uRLDgaNaJvL
	 L0t3qL0AulEMcWyYmIgljYk+KGS8NDS+arWk2rVQllnetjRQG20UoZVO6Lg1BdmuEQwZG
	 I6ZvGVEYjaQyaVjf3fVvrI4bA4ihINLne4y/C/d4pcEKo6/T0Ti/ULsiblWCl8l8p55hL
	 WmuG7/ZaDuepqwwG55ia6f4RQacyhhonXXw8vKjoe2ReHwTyHREDub4pfqmQZcdFWYdN4
	 2mbxeWt2fLWdwIrhF7d1moCBoePbFC2Z4CNYH1xBWHI/P6CQboXreGTCfGDWWj2Vf4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nCirDnVt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 589D5606A883;
	Sun, 15 Nov 2026 09:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nCirDnVt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963881F000C4;
	Sun, 15 Nov 2026 09:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794735578;
	bh=wyznBQGouKTKz8qr6f9Rju1zs8kXOgCrx7IgnhIi4QI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=nCirDnVtKf1Ox41/VfqiewEzOOqEtF/anc0JIio+h4Qio00goTIwK/1jEWklekbWQ
	 qeOjRiEAUOyeC1gTVUPv7NJpr6m4Q33epRLf8G4yJFkd1b3lorVr2uW1UIWCbBeMDl
	 HkpoTb5OdKGoB2R8hem/Vwg0aPbAbJuKTfoyam1PRca4zj/DFrCmhV7DDIGxhv5zuU
	 Ihw6TAeNs//mMmskAhiyQXGPwREXZQfJHqr7IJnW6G4ZTj0PN95nH2RJYw0lQp2AIn
	 IAeZ889upK2jP2Ir/e4QkFth08ZeboY6e9cgdrb/xQ48PZrUkAgr6YCoT+iyzdq0RA
	 TlNVAcpk1C+dQ==
Subject: Re: [PATCH net v6 3/3] igb: do not split AF_XDP zero-copy frames over
 several Rx buffers
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
Date: Sun, 15 Nov 2026 09:39:36 +0000
Message-ID: <179473557614.2199510.972066447270237709@kernel.org>
In-Reply-To: <20261111-igb-rx-ts-fix-v6-3-ba5b9903859c@aweta.nl>
References: <20261111-igb-rx-ts-fix-v6-3-ba5b9903859c@aweta.nl>
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

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 (1) · Low: 3

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new XSK queue check sits in igb_sriov_reinit(), and that
  function is shared by the SR-IOV enable and disable paths.
- [Medium] The new -EBUSY return from igb_sriov_reinit() gives userspace
  a deterministic way into igb_enable_sriov()'s err_out path while the…
- [Low] This patch raises the XSK ring hardware buffer in
  igb_setup_srrctl() to 2 KiB or 3 KiB, while the XSK frame can be as…
- [Low] The new -EBUSY refusal in igb_sriov_reinit() runs after
  igb_enable_sriov() has already called igb_vf_configure() for each VF.
- [Low] The new restore `if (dmac) adapter->flags |= IGB_FLAG_DMAC;` in
  igb_enable_sriov() err_out is a non-atomic read-modify-write of…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it sits in
  igb_xsk_pool(), which the patch edits.
- [Medium] This problem wasn't introduced by this patch.

--

igb: do not split AF_XDP zero-copy frames over several Rx buffers

AF_XDP zero-copy Rx rings now get the same 2 KiB or 3 KiB SRRCTL buffer
size as the other rings, so frames are no longer split over two
buffers. The patch adds checks that refuse an XSK pool, an MTU change,
or VF enablement when a bound pool's frame size or queue would no
longer fit. When the frame does not fit at ring setup, igb_xsk_pool()
falls back to copy mode.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index e787095d3cdbe..c9351a8c4f5e5 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -3777,9 +3777,29 @@ static int igb_sriov_reinit(struct pci_dev *dev)
>  	struct net_device *netdev = pci_get_drvdata(dev);
>  	struct igb_adapter *adapter = netdev_priv(netdev);
>  	struct pci_dev *pdev = adapter->pdev;
> +	unsigned int i, rxq, txq, end;
>  
>  	rtnl_lock();
>  
> +	/* With VFs the PF gets fewer Rx queues and a single Tx queue, see
> +	 * igb_set_interrupt_capability(). Refuse that while an XSK pool is
> +	 * bound to a queue the PF would lose; the core refuses ethtool -L in
> +	 * the same case.
> +	 */
> +	rxq = min_t(unsigned int, igb_get_max_rss_queues(adapter),
> +		    num_online_cpus());
> +	txq = adapter->vfs_allocated_count ? 1 : rxq;
> +	end = max(netdev->real_num_rx_queues, netdev->real_num_tx_queues);
> +	for (i = min(rxq, txq); i < end; i++) {
> +		if (xsk_get_pool_from_qid(netdev, i)) {
> +			rtnl_unlock();
> +			dev_err(&pdev->dev,
> +				"Cannot change the number of queues, an AF_XDP socket is bound to queue %u\n",
> +				i);
> +			return -EBUSY;
> +		}
> +	}

[Severity: High]
igb_sriov_reinit() is shared by igb_enable_sriov() and
igb_disable_sriov(). Can this check also fire on the disable path? The
commit message only describes refusing the enable case.

igb_disable_sriov() calls igb_sriov_reinit() only after the VFs have
already been torn down:

igb_disable_sriov() {
    ...
		pci_disable_sriov(pdev);
    ...
		kfree(adapter->vf_data);
		adapter->vf_data = NULL;
		adapter->vfs_allocated_count = 0;
    ...
		wr32(E1000_IOVCTL, E1000_IOVCTL_REUSE_VFQ);
    ...
	return reinit ? igb_sriov_reinit(pdev) : 0;
}

One possible path is an i350 with the interface down.
real_num_rx_queues and real_num_tx_queues stay at 8 from
alloc_etherdev_mq(). Enable VFs, then bind a copy-mode XSK to queue 5.
The loop doesn't check pool->dev, so copy-mode pools count too. On a
host with fewer than 8 CPUs, writing 0 to sriov_numvfs then lands queue
5 inside [min(rxq, txq), end) and returns -EBUSY, even though the VFs
are already gone. On 82576, ethtool -L combined 2 on a 1-CPU host, or
offlining a CPU, gives a similar range.

The -EBUSY return skips igb_clear_interrupt_scheme(),
igb_init_queue_configuration() and igb_init_interrupt_scheme(). The PF
keeps a single Tx queue. The rings also keep the reg_idx offset that
igb_cache_ring_register() computed from the old vfs_allocated_count,
while vfs_allocated_count is now 0.

Would the next igb_configure() then program non-VT MRQC that steers to
hardware queue 0, while the only PF Rx ring sits at the old register
index, so PF Rx stops?

Could this check run only on the enable path, ideally at the start of
igb_enable_sriov() before any VF state is set up?

[ ... ]

> @@ -3933,6 +3954,8 @@ static int igb_enable_sriov(struct pci_dev *pdev, int num_vfs, bool reinit)
>  	kfree(adapter->vf_data);
>  	adapter->vf_data = NULL;
>  	adapter->vfs_allocated_count = 0;

[Severity: Medium]
The new -EBUSY return lets userspace reliably reach this err_out
teardown while the PF is still up. The check runs before igb_close(),
so the watchdog and rx_mode keep running. Here rtnl has already been
dropped inside igb_sriov_reinit(), and vfs_lock is not taken.

Some readers walk vf_data without either lock, for example
igb_watchdog_task()->igb_ping_all_vfs():

	for (i = 0 ; i < adapter->vfs_allocated_count; i++) {
		ping = E1000_PF_CONTROL_MSG;
		if (adapter->vf_data[i].flags & IGB_VF_FLAG_CTS)

igb_set_rx_mode()->igb_restore_vf_multicasts() does the same under
addr_list_lock only. rtnl-only VF ops such as igb_ndo_set_vf_mac() also
write vf_data[vf].

vf_data is set to NULL before vfs_allocated_count is cleared. Can a
concurrent reader see a non-zero count and either use the freed
vf_data or dereference NULL plus an offset?

This unsynchronized reader pattern also exists against
igb_disable_sriov(), but this patch adds a user-triggerable way into
it. Moving the XSK check before vfs_allocated_count and vf_data are
published would avoid that.

[Severity: Low]
The commit message says the MAC filter entries reserved for the VFs
stay reserved until the next reset. They come from
igb_vf_configure()->igb_set_vf_mac(), which runs before
igb_sriov_reinit():

	adapter->mac_table[rar_entry].queue = vf;
	adapter->mac_table[rar_entry].state |= IGB_MAC_STATE_IN_USE;
	igb_rar_set_index(adapter, rar_entry);

err_out does not release them. With vfs_allocated_count back at 0, the
PF loses up to num_vfs - 1 unicast filter slots.

If the check ran at the top of igb_enable_sriov() (the PF queue limit
can be derived from num_vfs), would this leak and the disable-path
problem above both go away?

[Severity: Medium]
This isn't a bug introduced by this patch, but when igb_sriov_reinit()
succeeds and pci_enable_sriov() then fails:

	if (!old_vfs) {
		err = pci_enable_sriov(pdev, adapter->vfs_allocated_count);
		if (err)
			goto err_out;
	}

err_out clears vfs_allocated_count without running igb_sriov_reinit()
again. The interrupt scheme, the ring reg_idx offsets and the VT
register programming all stay in VF mode while software believes there
are no VFs.

The new DMAC restore matches the intended no-VF state and does not
make this worse. Should err_out redo the reinit in this case?

> +	if (dmac)
> +		adapter->flags |= IGB_FLAG_DMAC;

[Severity: Low]
This is a non-atomic read-modify-write of adapter->flags from sysfs
context, and the interface is still up after the -EBUSY return.

igb_watchdog_task() updates the same word
(IGB_FLAG_NEED_LINK_UPDATE, IGB_FLAG_MEDIA_RESET, IGB_FLAG_EEE), and so
does igb_set_rx_mode() (IGB_FLAG_VLAN_PROMISC) under addr_list_lock.

Can an overlapping update lose either the DMAC bit or the other
context's bit? The earlier "adapter->flags &= ~IGB_FLAG_DMAC" in this
function already follows the same pattern.

>  out:
>  	return err;
>  }

[ ... ]

> @@ -4836,9 +4859,13 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
>  	u32 srrctl = 0;
>  	u32 buf_size;
>  
> -	if (ring->xsk_pool)
> -		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);
> -	else if (ring_uses_large_buffer(ring))
> +	/* SRRCTL.BSIZEPKT has a 1 KiB granularity, so programming the XSK
> +	 * frame size would round it down and split frames over several
> +	 * buffers. XSK rings use the same buffer size as the other rings.
> +	 * While XDP is attached, the receive length limit keeps frames
> +	 * within the XSK frame, see igb_xsk_frame_fits().
> +	 */
> +	if (ring_uses_large_buffer(ring))
>  		buf_size = IGB_RXBUFFER_3072;
>  	else
>  		buf_size = IGB_RXBUFFER_2048;

[Severity: Low]
This is only safe together with the receive length limit from the
earlier patch. The commit message says:

    This depends on "igb: do not let XDP frames span more than one Rx
    buffer" ... Without it, the hardware can write past the XSK frame.

The two patches carry different Fixes: tags (9cbc948b5a20 and
2c6196013f84), and the Cc: stable tag here has no prerequisite note. If
a stable tree takes this patch without the prerequisite, could the NIC
DMA up to 2 KiB or 3 KiB into a 1792-byte XSK frame and overrun the
next UMEM chunk?

Would a stable prerequisite annotation on the Cc: stable line make the
dependency explicit?

> diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
> index ce4a7b58cad2f..7f99e834c1edb 100644
> --- a/drivers/net/ethernet/intel/igb/igb_xsk.c
> +++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
> @@ -91,7 +91,21 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
>  	if (!igb_xdp_is_enabled(adapter))
>  		return NULL;
>  
> -	return (pool && pool->dev) ? pool : NULL;
> +	if (!pool || !pool->dev)
> +		return NULL;
> +
> +	/* igb_change_mtu() does not see a pool on a queue that is hidden, for
> +	 * example after a fallback from MSI-X to MSI. The hardware buffer can
> +	 * be larger than the XSK frame, so check again when the ring is set up.
> +	 */
> +	if (!igb_xsk_frame_fits(pool, adapter->max_frame_size)) {
> +		netdev_warn_once(adapter->netdev,
> +				 "XSK frame size is too small for the MTU, queue %d is not used in zero-copy mode\n",
> +				 qid);
> +		return NULL;
> +	}
> +
> +	return pool;
>  }

[Severity: High]
This is a pre-existing issue that was not introduced by this patch.
igb_xsk_pool() picks the pool from ring->queue_index alone.
igb_setup_desc_rings() in igb_ethtool.c never sets
test_rx_ring.queue_index, so it stays 0. It then calls
igb_configure_rx_ring(), which sets ring->xsk_pool from
igb_xsk_pool().

Suppose XDP is attached and a zero-copy pool is bound to queue 0. Then
ethtool -t ethX offline takes this path:

igb_diag_test()
  igb_loopback_test()
    igb_setup_desc_rings()
      igb_configure_rx_ring()   test ring gets the queue 0 pool
      igb_alloc_rx_buffers()    fills igb_rx_buffer page entries
    ...
    igb_free_desc_rings()
      igb_free_rx_resources()
        igb_clean_rx_ring()
          igb_clean_rx_ring_zc()

igb_clean_rx_ring_zc() then does:

	struct xdp_buff *xdp = rx_ring->rx_buffer_info_zc[ntc];

	xsk_buff_free(xdp);

Can this call xsk_buff_free() on words of the igb_rx_buffer array (DMA
addresses, struct page pointers) as if they were struct xdp_buff
pointers?

The test's pages would also leak and stay DMA-mapped. The live pool's
rxq info also gets pointed at the test ring's xdp_rxq. The new
netdev_warn_once() above can also fire for this test ring.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261111-igb-rx-ts-fix-v6-0-ba5b9903859c%40aweta.nl
