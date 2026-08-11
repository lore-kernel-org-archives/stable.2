Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64AE427A0A;
	Tue, 11 Aug 2026 09:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786439759; cv=none; b=Io4MxO0sPBUvQI4yk4bqun8V9hNcUwB+vJTeKTPxgzxT0egozktbL+jaYjv6HZFLs16hWJ4TxRx/2/BZEpX/ukTS4ha3vnm/Pwez5ayMZiTO7c2sGg97+qqswWbRRiHPZTMRQp2PyblkifCNEiA5DxhtXKrSbT874Uuxy8LgNPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786439759; c=relaxed/simple;
	bh=4U7ngFBu5NsM481oid+uETkGR5AVE9VJzURPBfGDsH8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ecJ4Ytm5P4O0hDI0mNNx3WgEROUpckl5l/MckyaQNEGEV3MENAzVSW7bMcMs14mCuIVsyCcG6TsN6SrUtAEc49ucEDjH6HCJK9TatUnXOXN7uRYIPmK+n7xZZ1UON8zSDus0IiJDd1lCXyX6HTs/FC+V1IlTMDgUKuf+z5fkHDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W08dAEDU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W08dAEDU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F211F00A3A;
	Tue, 11 Aug 2026 09:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786439757;
	bh=kec89GY4d6bVnwtGkZlqCDVtcDGTNRDATy+E2YuM6e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W08dAEDUh1Tb4XuKnYJJi5ET1hoRro7J1kmpmN1yObp1vONSfW+GOUMt6uOKiosss
	 5LWLe9QDTEYCvNV/j4nZTVx+quIaW13RfE95nw6yXSaT0S5ST/dth0+/gH3qaLRcbO
	 QLSwTusiqf8bH4IQa46nz5S+idHu9GKu7UERSgjQFJRo6yYcdJfCQ5F5SS4RcSwYVH
	 lAywF7HWoPBpFzI76UP8r0mx/OsE4qk0ZrEJ8iIz2FO4auGpXJ08E7fKy4TE4W9LVB
	 U0e/+CiUtVZkhbzJu3TGhQ7pbeynLzmJ3UDExhMGPhqq+T3Z1n9reB9eYur3MfwZyS
	 L43TtsM4wYRVA==
From: Simon Horman <horms@kernel.org>
To: runyu.xiao@seu.edu.cn
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	sashal@kernel.org,
	zilin@seu.edu.cn,
	kory.maincent@bootlin.com,
	marco.crivellari@suse.com,
	felix.manlunas@cavium.com,
	ricardo.farrington@cavium.com,
	linux-kernel@vger.kernel.org,
	jianhao.xu@seu.edu.cn,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: liquidio: lock upstream bridge for function reset
Date: Tue, 11 Aug 2026 10:15:39 +0100
Message-ID: <20260811091539.815827-1-horms@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260809105715.3669436-1-runyu.xiao@seu.edu.cn>
References: <20260809105715.3669436-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260809105715.3669436-1-runyu.xiao@seu.edu.cn?part=1
---
--- Patch [1]: [PATCH net] net: liquidio: lock upstream bridge for function reset ---
commit 2860fd8a604e5a859143abde28004c138ba9f2fa
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

net: liquidio: lock upstream bridge for function reset

This adds a pci_cfg_access_lock() on the upstream bridge around the
__pci_reset_function_locked() call in octeon_pci_flr(), and moves
pci_save_state()/pci_restore_state() inside the locked region so both
locks are held across the reset and the state restore.

> diff --git a/drivers/net/ethernet/cavium/liquidio/lio_main.c b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> index e303956b4bf1..9aab310ba229 100644
> --- a/drivers/net/ethernet/cavium/liquidio/lio_main.c
> +++ b/drivers/net/ethernet/cavium/liquidio/lio_main.c
> @@ -914,12 +914,15 @@ static bool fw_type_is_auto(void)
>   */
>  static void octeon_pci_flr(struct octeon_device *oct)
>  {

[Severity: Low]
[Finding: gpt-5-6-sol-2-3]
[Sources: gpt-5-6-sol, opus-5]
This isn't a bug introduced by this patch, but the kernel-doc directly
above octeon_pci_flr() still says "PCI FLR for each Octeon device" while
the body calls the generic helper, which can pick any of the methods in
dev->reset_methods:

drivers/pci/pci.c:__pci_reset_function_locked() {
	for (i = 0; i < PCI_NUM_RESET_METHODS; i++) {
		m = dev->reset_methods[i];
		...
		rc = method->reset_fn(dev, PCI_RESET_DO_RESET);

and one of those methods ends in a secondary bus reset:

drivers/pci/pci.c:pci_reset_bus_function() {
	rc = pci_dev_reset_slot_function(dev, probe);
	if (rc != -ENOTTY)
		goto done;

	rc = pci_parent_bus_reset(dev, probe);

Since the changelog's premise is exactly that the bus-reset method may be
selected, would it make sense to update the doc string in the same patch?

> +	struct pci_dev *bridge = pci_upstream_bridge(oct->pci_dev);
>  	int rc;
>  
> -	pci_save_state(oct->pci_dev);
> -
> +	if (bridge)
> +		pci_cfg_access_lock(bridge);
>  	pci_cfg_access_lock(oct->pci_dev);

[Severity: High]
[Finding: gpt-5-6-sol-5-8]
[Sources: gpt-5-6-sol, opus-5]
Can this acquisition order deadlock against the PCI core?

octeon_pci_flr() is only reached from octeon_destroy_resources():

	if (atomic_read(oct->adapter_fw_state) == FW_IS_PRELOADED)
		octeon_pci_flr(oct);

which runs from liquidio_remove() and from the liquidio_remove(pdev)
calls on the probe-failure paths in liquidio_probe(). Both of those run
with device_lock(&pdev->dev) already held by the driver core, which is
why __pci_reset_function_locked() can be used at all:

drivers/pci/pci.c:__pci_reset_function_locked() {
	might_sleep();
	device_lock_assert(&dev->dev);

So after this change the driver holds device_lock(endpoint) and then takes
the bridge config-access lock. The core takes those two objects in the
opposite order:

drivers/pci/pci.c:pci_reset_function() {
	bridge = pci_upstream_bridge(dev);
	if (bridge)
		pci_dev_lock(bridge);

	pci_dev_lock(dev);

drivers/pci/pci.c:pci_dev_lock() {
	/* block PM suspend, driver probe, etc. */
	device_lock(&dev->dev);
	pci_cfg_access_lock(dev);

__pci_bus_lock() does the same bridge-first walk before locking each
child.

That gives an AB-BA pattern:

CPU0 (liquidio remove or probe failure)
  device_lock(endpoint)             [held by driver core]
  octeon_pci_flr()
    pci_cfg_access_lock(bridge)     -> blocks in pci_wait_cfg()

CPU1 (echo 1 > /sys/bus/pci/devices/.../reset, or AER/DPC recovery via
      pci_bus_error_reset() -> pci_bus_reset() -> pci_bus_lock())
  pci_dev_lock(bridge)              [sets bridge->block_cfg_access]
  pci_dev_lock(endpoint)
    device_lock(endpoint)           -> blocks, held by CPU0

Both waits look uninterruptible and untimed:

drivers/pci/access.c:pci_cfg_access_lock() {
	might_sleep();

	raw_spin_lock_irq(&pci_lock);
	if (dev->block_cfg_access)
		pci_wait_cfg(dev);

Since block_cfg_access is not lockdep-tracked, would this show up only as
a hung task, with the bridge's config-access flag left blocked?

Before this change the driver took only the endpoint's own config-access
lock, which the core also acquires after device_lock(endpoint), so there
was no inversion. Would deferring the bridge lock to a path that does not
already hold the endpoint device lock, or using the core's
pci_reset_function() style bridge-first sequence, avoid the cycle?

>  
> +	pci_save_state(oct->pci_dev);
> +
>  	/* Quiesce the device completely */
>  	pci_write_config_word(oct->pci_dev, PCI_COMMAND,
>  			      PCI_COMMAND_INTX_DISABLE);
> @@ -930,9 +933,10 @@ static void octeon_pci_flr(struct octeon_device *oct)
>  		dev_err(&oct->pci_dev->dev, "Error %d resetting PCI function %d\n",
>  			rc, oct->pf_num);
>  
> -	pci_cfg_access_unlock(oct->pci_dev);
> -
>  	pci_restore_state(oct->pci_dev);
> +	pci_cfg_access_unlock(oct->pci_dev);
> +	if (bridge)
> +		pci_cfg_access_unlock(bridge);
>  }

[ ... ]
