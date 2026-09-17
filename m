Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A04E4F5DF0;
	Thu, 17 Sep 2026 17:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667595; cv=none; b=ZK2wu14JiP2qBxpjGdz3Db+/TcwxpJFeEVWWrVcRth4bDS60yIVaX+7K+bnvTiz0Qvr0rnZPJl+TNF8BYSSdUzJ/5gyW5AOFvis0ihZwZ/s+kSNoPU14LmiJ/8DFOh24LmGtaFZmLUygrG2UwJvzMpJu6jXih92UgF/5UK0qgvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667595; c=relaxed/simple;
	bh=ACvVjwYB75s1lVSQWdFsqx2NNIOG6BkGems6B2DGCCk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vl79ZABxTaX2OIVVkMIqkpMTUvuugPBtxU1rFen+O2PJJeQNOCjewJQRiT5Z6MzE8CvDWkdYzpsWrLkmp8j/rLwodHxepdMa5l0oyRpduI+2H0mQ6s/hr8mvrMfWqfPy9YodF1hgOwWjmDMAFE69KGX2th5kqEVkAAkoqZwmf/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2vLeQ1w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2vLeQ1w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E89A1F00893;
	Thu, 17 Sep 2026 17:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789667592;
	bh=WBjpHHIGHL1eZnD2HbrCvnClWBRNyRwoFmj9ip1gQvs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=e2vLeQ1w7JUoE0TnzQYWz1IrIkoJYoxPcJSVOf3Xi+lb92mnMJDLEBGKABGOzfHRM
	 TFPD8SWNM8uEKzikduA/7PmkY96+sHlsScirgY+ndsLCytKGr6C/lGr4GmSHj0GuP/
	 Wd7x7CY18YegTeNHtwyXVLf7q4hCQ1NEWdQfGwp0k2JFOnFHtG4VB6N3qZ4XkduPne
	 oWFbHwnfIzkfDkqKR3qwwoR50lS+ij7iwZ+hDqfDmDiLm2h/vO/uQPAtpf15+WNsOT
	 Co0EV7ErdOBieIYeDz4dCmUwO+n234utg0UaNSSFDYgzAf51ZaBLAj512UFVLl2a1O
	 pizx/8t/E8WOA==
Subject: Re: [PATCH] cxgb4: fix FW SGE queue cleanup on remove
From: netdev-bot+sashiko@kernel.org
To: lgs201920130244@gmail.com
Cc: bharat@chelsio.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ganeshgr@chelsio.com,
 arjun@chelsio.com, leedom@chelsio.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Thu, 17 Sep 2026 17:53:11 +0000
Message-ID: <178966759183.22033.12309574104783604934@kernel.org>
In-Reply-To: <20260916025215.2780658-1-lgs201920130244@gmail.com>
References: <20260916025215.2780658-1-lgs201920130244@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] Incomplete fix: the CXGB4_FULL_INIT_DONE-gated release of the
  probe-time FW SGE queues is corrected only in remove_one(); the…

--

cxgb4: fix FW SGE queue cleanup on remove

The patch adds a branch to remove_one() so that the FW SGE queues
allocated by setup_fw_sge_queues() during init_one() are released when
CXGB4_FULL_INIT_DONE was never set, for example when no interface of the
adapter was ever opened.

> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> index 1ced6df6eac8c..146419c663488 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> @@ -7116,6 +7116,9 @@ static void remove_one(struct pci_dev *pdev)
>  
>  		if (adapter->flags & CXGB4_FULL_INIT_DONE)
>  			cxgb_down(adapter);
> +		else if (adapter->sge.fw_evtq.desc ||
> +			 adapter->sge.intrq.desc)
> +			t4_free_sge_resources(adapter);

[Severity: Medium]
The same CXGB4_FULL_INIT_DONE assumption that this patch corrects in
remove_one() also exists in the PCI reset pair eeh_reset_prepare() /
eeh_reset_done().  Should that path be fixed too?

eeh_reset_prepare() only releases SGE resources through the same gate:

	for_each_port(adapter, i)
		if (adapter->port[i]->reg_state == NETREG_REGISTERED)
			cxgb_close(adapter->port[i]);
	...
	if (adapter->flags & CXGB4_FULL_INIT_DONE)
		cxgb_down(adapter);

cxgb_close() does not free SGE resources and does not clear
CXGB4_FULL_INIT_DONE, so on an adapter that was probed but never opened
the FW queues stay allocated across the reset.

eeh_reset_done() then re-runs the allocation unconditionally:

	err = setup_fw_sge_queues(adapter);
	if (err) {
		dev_err(adapter->pdev_dev,
			"FW sge queue allocation failed, err %d", err);
		return;
	}

Does this leak the previous fw_evtq (and intrq in the MSI/INTx case)
ring?  setup_fw_sge_queues() overwrites s->fwevtq_msix_idx after taking a
fresh index from cxgb4_get_msix_idx_from_bmap(), and t4_sge_alloc_rxq()
overwrites the ring pointer without looking at or releasing an existing
one:

drivers/net/ethernet/chelsio/cxgb4/sge.c:t4_sge_alloc_rxq() {
	...
	iq->desc = alloc_ring(adap->pdev_dev, iq->size, iq->iqe_len, 0,
			      &iq->phys_addr, NULL, 0,
			      dev_to_node(adap->pdev_dev));
	if (!iq->desc)
		return -ENOMEM;
	...
}

So the old dma_alloc_coherent() ingress ring becomes unreachable, the
previously reserved bit in adapter->msix_bmap is never returned via
cxgb4_free_msix_idx_in_bmap(), and the old firmware ingress queue context
is never released with t4_iq_free().  This repeats on every reset of the
pf == 4 function (sysfs reset, FLR, VFIO reset), and once the msix bitmap
is exhausted setup_fw_sge_queues() returns -ENOMEM and eeh_reset_done()
bails out, leaving the adapter unrecovered.

The new branch in remove_one() cannot recover those allocations, since
their only pointers were already overwritten during the reset.

Would an unconditional t4_free_sge_resources() at both teardown sites be
simpler?  t4_free_sge_resources() already performs the same checks
internally:

drivers/net/ethernet/chelsio/cxgb4/sge.c:t4_free_sge_resources() {
	...
	if (adap->sge.fw_evtq.desc) {
		free_rspq_fl(adap, &adap->sge.fw_evtq, NULL);
		...
	}
	...
	if (adap->sge.intrq.desc)
		free_rspq_fl(adap, &adap->sge.intrq, NULL);
	...
}

and init_one()'s out_free_dev label already calls it unconditionally:

 out_free_dev:
	t4_free_sge_resources(adapter);

Could the changelog also mention the reset path, so that a backporter
knows whether the identical lifecycle mismatch there was considered?

>  
>  		if (adapter->flags & CXGB4_USING_MSIX)
>  			free_msix_info(adapter);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260916025215.2780658-1-lgs201920130244%40gmail.com
