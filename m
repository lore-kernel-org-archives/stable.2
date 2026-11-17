Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794914313;
	b=dSY00H6bnL+8gd74usTi3PInAku05ju5zdH9p7UljbAmZQmJQ43fZ9ut73Fkggo/dQjx
	 y9kSespgLv9hxXYCwDro/krSztRbu1RH5J1UaGNHlEXLKJXWRmYxmpNndZy1hWilf/rQI
	 76T5QgzI9xzRb0paJ3JcU4RWnaxoIDWmVcSuxkC8ERml4Bpq+CqTQ4OztT2dMBl1h+OQn
	 yaPxcPKUqhVjUc7rUQLUgo0Sxg/Rlh9yvXPeGYlUvMUUrZSC4fZEo3J35yofsxsl98aDd
	 T64xvVz2g7QIPsv/OMq8e9QawpSS54zb3RfbJzN1vPeYLd4+1S8/5zF4MEZGMk2QBVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794914313;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=k+kIo9jpV5KFdYWHjuEUw/DWKQDI9aOHBv+v3db2R3c=;
	b=Nm3etkqxZ0L7kiH4qBTnCgNMNkbX5VOASX9Hs9jfDChsa39gn1BLygKcrLZ32wTlhypv
	 s9QCxjGGCZfueTJDxcwa9YzGzj7hL0vdAlOaQTEZC2OUXjiue3RMULFeKJt8X30qV6mmB
	 no3kXaN/+r4Bd53PbBE5GNd8+2ioVwIOl64cwE6pPDseNWppMorpIOVQArH+6pVu/ihL1
	 ybJbfhqjkrqi762Ct9n3UC5p/biEHpgZsBj/7FRdoSh+65cNr7xRi5+rGFE9E6vFDryBW
	 oIFuRSc//jbHeaMX5GBS1+vmFvYPiB8N84qShuH1yyD2LYiyr2s/56Nj8gKpwgfb4Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odhwX6PN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526FF606A336;
	Tue, 17 Nov 2026 11:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=odhwX6PN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 329991F000C8;
	Tue, 17 Nov 2026 11:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794914312;
	bh=k+kIo9jpV5KFdYWHjuEUw/DWKQDI9aOHBv+v3db2R3c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=odhwX6PNDqnSOGmkajWFLLggKYsk1XXV6+pRNcyjje7CTi+d5WH1/dkHak2sQPRz8
	 Z1cKs/ThKki9H1NyHKgq896L5QtXa5usT6J0ZlEGol0oth06EudyYAw3h5M8qcjLc4
	 16hk4ejhvuC8sHMYO+OfRsqbrDyL3/8nyfTIuGEjHq2WhSa7J9Gr/ktRxBR6f9quW6
	 nBl1xbeZNr0opqe1pM5Ai8pU6CWOMZ8HiMfteoQtFLaNbSL855YdnzxLjWD+Kx/Iy8
	 03l0KGv61my8wT0O+2P7Kad7DDNBbzkgcQKtoIeQsrmT6l3mKXWCdQ1LkvmD//fCkU
	 33PHvxZW65N1g==
Subject: Re: [PATCH net 1/3] igb: fix RTNL assertion when resuming from
 runtime suspend
From: netdev-bot+sashiko@kernel.org
To: antonio@mandelbit.com
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 zheng.z.yan@intel.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Tue, 17 Nov 2026 11:18:31 +0000
Message-ID: <179491431170.3136.416423016654830307@kernel.org>
In-Reply-To: <20261113105835.3821433-1-antonio@mandelbit.com>
References: <20261113105835.3821433-1-antonio@mandelbit.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Commit "igb: fix RTNL assertion when resuming from runtime
  suspend" moves netif_set_real_num_queues() out of __igb_open() and…
- [High] The commit message says "The queue counts only change on paths
  that re-open the device under RTNL (ethtool -L, SR-IOV…
- [Medium] Concern (baseline decision: false, resolved later in the
  series).

--

igb: fix RTNL assertion when resuming from runtime suspend

This patch moves the netif_set_real_num_{tx,rx}_queues() calls out of
__igb_open() and into igb_open(). The runtime resume path runs without
RTNL, so it no longer triggers an RTNL assertion. igb_open() now publishes
the queue counts with netif_set_real_num_queues() before it calls
__igb_open().

Closes: https://bugzilla.ipfire.org/show_bug.cgi?id=13562

> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
> index 131df3e09ba14..028cdd90522cb 100644
> --- a/drivers/net/ethernet/intel/igb/igb_main.c
> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
> @@ -4178,17 +4178,6 @@ static int __igb_open(struct net_device *netdev, bool resuming)
>  	if (err)
>  		goto err_req_irq;
>  
> -	/* Notify the stack of the actual queue counts. */
> -	err = netif_set_real_num_tx_queues(adapter->netdev,
> -					   adapter->num_tx_queues);
> -	if (err)
> -		goto err_set_queues;
> -
> -	err = netif_set_real_num_rx_queues(adapter->netdev,
> -					   adapter->num_rx_queues);
> -	if (err)
> -		goto err_set_queues;
> -

[Severity: High]
The commit message says:

  The queue counts only change on paths that re-open the device under
  RTNL (ethtool -L, SR-IOV reconfiguration)

Does that hold for suspend and resume? Every suspend goes through
__igb_shutdown(), which calls igb_clear_interrupt_scheme(). That frees
the rings and sets num_tx_queues and num_rx_queues to zero in
igb_free_q_vectors().

On resume, __igb_resume() rebuilds them:

__igb_resume()
    igb_init_interrupt_scheme(adapter, true)
        igb_set_interrupt_capability()
            pci_enable_msix_range() fails
            msi_only:
                adapter->num_rx_queues = 1;
                adapter->num_tx_queues = 1;
                adapter->num_q_vectors = 1;
    __igb_open(netdev, true)

Before this patch, __igb_open(netdev, true) updated
dev->real_num_{tx,rx}_queues after that. Now only igb_open() does, and the
resume path never calls igb_open(). The same is true when the MSI-X to MSI
fallback in igb_request_irq() runs inside __igb_open(netdev, true).

In that case, can the stack keep a larger real_num_tx_queues while only
tx_ring[0] exists? igb_tx_queue_mapping() folds the stale indices onto
ring 0:

	if (r_idx >= adapter->num_tx_queues)
		r_idx = r_idx % adapter->num_tx_queues;

Each stack txq has its own _xmit_lock. Couldn't several CPUs then run
igb_xmit_frame_ring() on tx_ring[0] at the same time, racing on
next_to_use, tx_buffer_info[], the tail write and the BQL state of txq 0?

__igb_maybe_stop_tx() and igb_clean_tx_irq() also only stop and wake
subqueue 0. real_num_rx_queues would likewise stay larger than the single
configured RX ring.

Runtime resume happens on every link-up after a cable unplug, and each
cycle releases and re-acquires MSI-X, so this can happen more than once.

On system resume (rpm == false), __igb_resume() already holds RTNL around
__igb_open(). Did that path need to lose the update to fix the assertion?

[Severity: Medium]
Will runtime resume still hit an RTNL assertion with this patch applied?
Later in __igb_open(), igb_set_queue_napi() is still called
unconditionally:

	for (i = 0; i < adapter->num_q_vectors; i++) {
		napi = &adapter->q_vector[i]->napi;
		napi_enable(napi);
		igb_set_queue_napi(adapter, i, napi);
	}

igb_set_queue_napi() calls netif_queue_set_napi(), and that calls
netdev_assert_locked_ops_compat_or_invisible(). For igb, that check is
ASSERT_RTNL(). __igb_resume() only takes rtnl_lock() when !rpm, so this
chain runs without RTNL:

igb_runtime_resume()
    __igb_resume(dev, true)
        __igb_open(netdev, true)
            igb_set_queue_napi()
                netif_queue_set_napi()
                    ASSERT_RTNL()

It also updates the queue napi pointers without RTNL.

The next patch in the series, "igb: link queues to NAPIs under RTNL after
runtime resume", fixes this. It calls igb_set_queue_napi() only when
!resuming, and links the NAPIs under RTNL from a new igb_queue_napi_task
work item. So the problem is gone by the end of the series. With only this
commit applied, though, the "RTNL: assertion failed" warning from the
commit message still looks reachable on runtime resume.

[ ... ]

> @@ -4241,6 +4228,17 @@ static int __igb_open(struct net_device *netdev, bool resuming)
>  
>  int igb_open(struct net_device *netdev)
>  {
> +	struct igb_adapter *adapter = netdev_priv(netdev);
> +	int err;
> +
> +	/* Notify the stack of the actual queue counts. */
> +	err = netif_set_real_num_queues(netdev, adapter->num_tx_queues,
> +					adapter->num_rx_queues);

[Severity: High]
Can the queue counts still change after this call? __igb_open() calls
igb_request_irq(). If igb_request_msix() fails, it falls back to MSI and
rebuilds the interrupt scheme:

drivers/net/ethernet/intel/igb/igb_main.c:igb_request_irq() {
    ...
		/* fall back to MSI */
		igb_free_all_tx_resources(adapter);
		igb_free_all_rx_resources(adapter);

		igb_clear_interrupt_scheme(adapter);
		err = igb_init_interrupt_scheme(adapter, false);
    ...
}

When msix is false, igb_set_interrupt_capability() takes the msi_only path.
That sets num_tx_queues, num_rx_queues and num_q_vectors to 1.

Before this patch, the netif_set_real_num_{tx,rx}_queues() calls ran after
igb_request_irq() and saw the reduced count. Now dev->real_num_tx_queues
keeps the value set here (for example 4 or 8), while only tx_ring[0]
exists.

Would igb_tx_queue_mapping() then fold txq 1..N-1 onto tx_ring[0]? Each of
those stack txqs takes a different _xmit_lock, so igb_xmit_frame_ring()
could run concurrently on the same ring. real_num_rx_queues would also
stay larger than the single configured RX ring.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261113105835.3821433-1-antonio%40mandelbit.com
