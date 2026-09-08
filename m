Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174B352E043;
	Tue,  8 Sep 2026 11:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788866598; cv=none; b=Zz5HBNtuDeMwgaUIIsBw0dqpxvo/zeWdq8h8MXz2ojlZJIrrrzv+wjASobUiIqasrWJdC6VqZbkDu/x9cZG9/CSDYHvHQw9PLFwI1zJ0HIGooqNWdpXmgu5GQlSRup12eG/nPHZpGI53c2Rw9GKGGCDC/aSdIKLnkYY11HGZpg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788866598; c=relaxed/simple;
	bh=siV8bNpqGhmNRgficFzglJPRqdrOZc12xFzX4y+El7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYIc2TFR0N/PC9kL6WPOCW8YG6kjpAsS7FObu4CUcT9S/yu+50KnB/AmuQJelUv77WASpztzKUCFCod9H9ZI6vWjMgJZ2cLuSqFH+qBmVB780s84xnXx2dsGPNryFHCD9BjEY0AejPXit4QW015GUutbyN67NJ03H4U4gF70518=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQlS5Q/o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQlS5Q/o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 039EC1F00A3A;
	Tue,  8 Sep 2026 11:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788866582;
	bh=/g3yH9sO4jhmFg1zXfeMzwExNmVTfncyZAZ4DIa+jWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DQlS5Q/oFNHmgouSuPKwB4Mtk15Xnvzwf59NC/BIlsAp762vmM74nzYJzb7Ku90qR
	 4EVfCbJLBtVpWFKA7u5Y1V4GNTre8kqmMmxcZyE9iGzAQ3Do87jev46hz8DrKwLSzE
	 g4Q9mgZJc03SfV9n9L2JBTgNg9e2Mer+l8cJFNFBN+Lq+r8V0Rdc6aLhyq4J+FW4hU
	 E6XSq/5oc3trMNPN5e6PvO87m13fZrLLCdvIzDiCWBfyOEVT+bz+PPesRTTj0kWyqs
	 9ILp3RTF93uXEHrnYcs0SPLoZH7jlzEGkreBhNv3MNehWrZQvY7sfLEVY2Nm5HYii+
	 OobBNWwauzfIw==
Date: Tue, 8 Sep 2026 12:22:57 +0100
From: Simon Horman <horms@kernel.org>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: netdev@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Song Li <songl@zju.edu.cn>
Subject: Re: [PATCH net v2] net: mana: fix reset work race with device removal
Message-ID: <20260908112257.GU40544@horms.kernel.org>
References: <20260905023602.425827-1-fanwu01@zju.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260905023602.425827-1-fanwu01@zju.edu.cn>

On Sat, Sep 05, 2026 at 02:36:02AM +0000, Fan Wu wrote:
> The reset service work is queued on the system workqueue and can
> outlive mana_gd_remove(), which frees the GDMA context. It may
> then dereference gc through the stale service work.
> 
> Embed the service work in gdma_context and make GC_IN_SERVICE describe
> whether it may still access gc. Removal and probe unwind close new
> admission with GC_REMOVING and wait for an admitted cycle to retire
> before clearing drvdata and freeing gc. Service exits retire before
> taking the PCI rescan/remove lock, avoiding a lock-cycle with remove.
> 
> Do not admit service work while probe is still constructing or
> unwinding the device. Latch reset events seen during probe and let
> the probe rollback/recovery path handle them; a boundary recheck
> preserves events racing probe completion.
> 
> The service work stays on the system workqueue because a reset cycle
> destroys and re-creates gc->service_wq.
> 
> This issue was found by an in-house static analysis tool.
> 
> Fixes: fbe346ce9d62 ("net: mana: Handle Reset Request from MANA NIC")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6
> Co-developed-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Song Li <songl@zju.edu.cn>
> Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
> ---
> 
> Changes since v1 (<20260805143812.220509-1-fanwu01@zju.edu.cn>,
> https://lore.kernel.org/netdev/20260805143812.220509-1-fanwu01@zju.edu.cn):
> 
> - Dropped the device_lock() serialisation: holding the driver-core
>   device lock across mana_gd_suspend() + msleep() + mana_gd_resume()
>   blocks unbind, reboot, device PM and all PCI hotplug for up to a
>   full reset cycle, and can deadlock against the
>   flush_workqueue()/destroy_workqueue() of gc->service_wq.
> 
> - Replaced it with admission/drain gates: GC_REMOVING closes new
>   admission and the freeing paths wait for an admitted cycle to
>   retire (clear_bit_unlock/test_bit_acquire pairing) before clearing
>   drvdata and calling vfree(); the failed-resume rescan no longer
>   reopens admission, and mana_tx_timeout() also skips queue-reset
>   work during removal.
> 
> - No longer admit service work before the probe completes (the
>   reset-event handler no longer overloads GC_PROBE_SUCCEEDED with a
>   mid-probe latch); the FPGA reconfig exit and the probe-failure
>   recovery path are gated as well.
> 
> - Reference series for the HWC lifecycle model:
>   https://lore.kernel.org/netdev/20260813174243.3044348-1-longli@microsoft.com

Thanks for the updates and reference.

...

> @@ -2558,19 +2611,36 @@ static int mana_gd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  
>  	err = mana_rdma_probe(&gc->mana_ib);
>  	if (err)
> -		goto cleanup_mana;
> +		goto service_quiesce;
>  
>  	/*
>  	 * If a hardware reset event has occurred over HWC during probe,
> -	 * rollback and perform hardware reset procedure.
> +	 * rollback and perform hardware reset procedure.  Storing the
> +	 * success bit before the latch check pairs with the handler's
> +	 * latch-then-recheck, so an event racing probe completion is
> +	 * admitted rather than lost.
>  	 */
> -	if (test_and_set_bit(GC_PROBE_SUCCEEDED, &gc->flags)) {
> +	set_bit(GC_PROBE_SUCCEEDED, &gc->flags);
> +	if (test_and_set_bit(GC_SERVICE_DURING_PROBE, &gc->flags)) {
>  		err = -EPROTO;
> -		goto cleanup_mana_rdma;
> +		goto service_quiesce;
>  	}
>  
>  	return 0;
>  
> +service_quiesce:
> +	/* The stats work can admit a service cycle once mana_probe()
> +	 * has run: close admission and retire an in-flight cycle
> +	 * before any teardown, like mana_gd_remove() does.  Earlier
> +	 * failure points cannot have admitted service work.
> +	 */
> +	set_bit(GC_REMOVING, &gc->flags);
> +	/* Pairs with the ordered test_and_set_bit(GC_IN_SERVICE) in
> +	 * mana_schedule_serv_work().
> +	 */
> +	smp_mb__after_atomic();
> +	wait_var_event(&gc->flags,
> +		       !test_bit_acquire(GC_IN_SERVICE, &gc->flags));
>  cleanup_mana_rdma:
>  	mana_rdma_remove(&gc->mana_ib);
>  cleanup_mana:

The cleanup_mana_rdma and cleanup_mana labels are now unused.
They should be removed.

With that addressed feel free to add:
Reviewed-by: Simon Horman <horms@kernel.org>

...
