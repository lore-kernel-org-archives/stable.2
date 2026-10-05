Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4056A4766A7;
	Mon,  5 Oct 2026 10:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791196309; cv=none; b=tCdaCRLo7eYrIx9sAFh1HR9YaaCzy6t02PwvRSWzvg9Jemg7MP0x5yQ7/+ofy4de+KmPWE8oFMxlGEQuTMzBpcNAiRTnp8n+fzozxd0JMN/X0//GT0GyM5HwNrjf0RKZJsiNy9lED1To1jFKHvRWZAxM303nWjOIUhBsO5c7Be8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791196309; c=relaxed/simple;
	bh=HBsybNOrOY3gULj4eE89pif9VwXCEGYOequ2ONpJBXI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nPbQ9Xyzh64QCjpqsdgufJ7ghM208xMQItSvatx8L2dni76dJpO4/XIQd1hvSc53b82HSAcTnpltoAcNRbfPNRzExV7vXT2X/iDd7oo+/QcTdw6MbxJAta2Tnw1648Hs9CDzCq11x1mBCTKw371DUQQwDG7k/jFYorHNGXk6nZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HLAHMMcQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLAHMMcQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEAC21F000FF;
	Mon,  5 Oct 2026 10:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791196307;
	bh=tEfd9qvfu4QgzX2GQTcuW+Lz9TyVyf+UrSA9bp3at2U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HLAHMMcQ6HIEO3nGlszLZtyGbYScu/R0BiqYcNE9h+whlIRIQPtz5t6ISzbgnQ1m8
	 Szo22xfXnCTLVdvRE35+4Ady2U8tKIE+e4vS8ewzXpHlnOgRdiRM8Jm57Viae5tKyC
	 X84/dGoam+rQnYzspep21JbKs5NEbGM0s2sgrt1hCdlchpHL9DYa+3UxE4RwOCr5wE
	 b9OkEW4u2+Ec0gzmX99bltePK9MYIAwuTFfwzSJLwtJp+t24IToFbEh4NkJgQzHAgD
	 /GwA0LpjuAUbO6ILIR4HuvQHvVq6SdLUVfrBme3VMkg++4AEFbo7MzZvvp3k2zhQYz
	 mbMw6CnWBXnHQ==
Subject:
 Re: [PATCH net] net: ibmvnic: defer close from reset allocation failure
From: netdev-bot+sashiko@kernel.org
To: runyu.xiao@seu.edu.cn
Cc: haren@linux.ibm.com, ricklind@linux.ibm.com, nnac123@linux.ibm.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 chleroy@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, jianhao.xu@seu.edu.cn
Date: Mon, 05 Oct 2026 10:31:46 +0000
Message-ID: <179119630647.434549.14948305026621773339@kernel.org>
In-Reply-To: <20261004103131.1205618-1-runyu.xiao@seu.edu.cn>
References: <20261004103131.1205618-1-runyu.xiao@seu.edu.cn>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 (1) · Medium: 1 (4) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] A close requested while the adapter is still probing now runs
  after probe has finished, and it can leave the device in a state that…
- [Medium] The new `removing` flag does not deliver what the commit
  message claims, namely that "ibmvnic_close() cannot make removal look…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  __ibmvnic_reset() takes adapter->rwi_lock with plain spin_lock() from…
- [Medium] This problem wasn't introduced by this patch, but
  ibmvnic_close_work() calls the ndo_stop implementation ibmvnic_close()…
- [Medium] This problem wasn't introduced by this patch, but
  ibmvnic_remove() never calls flush_reset_queue().
- [Medium] This problem wasn't introduced by this patch, but rtnl does
  not serialize the link-state transaction in ibmvnic_close() against…
- [Medium] This problem wasn't introduced by this patch, but
  ibmvnic_close() can run twice for one open, which unbalances the sub-…

--

net: ibmvnic: defer close from reset allocation failure

ibmvnic_reset() can run from the CRQ tasklet. This patch moves the
ibmvnic_close() call it makes when the rwi allocation fails into a new
work item. It also adds an adapter->removing flag that is checked when
reset work is scheduled, flushes the new work in probe and remove, and
switches probe_done to complete_all().

> diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
> index 5a510eed335ea..4da3fd7ce0012 100644
> --- a/drivers/net/ethernet/ibm/ibmvnic.c
> +++ b/drivers/net/ethernet/ibm/ibmvnic.c
> @@ -2152,6 +2152,26 @@ static int ibmvnic_close(struct net_device *netdev)
>  	return rc;
>  }
>  
> +static void ibmvnic_close_work(struct work_struct *work)
> +{

[ ... ]

> +	/* The close path can sleep, so run it outside the CRQ tasklet. */
> +	wait_for_completion(&adapter->probe_done);
> +	rtnl_lock();
> +	spin_lock_irqsave(&adapter->rwi_lock, flags);
> +	removing = adapter->removing;
> +	spin_unlock_irqrestore(&adapter->rwi_lock, flags);
> +
> +	if (!removing)
> +		ibmvnic_close(adapter->netdev);

[Severity: High]
Can this close run on an adapter that was never opened and leave it in
VNIC_CLOSED?

ibmvnic_reset() does not reject VNIC_PROBING. During probe, the CRQ
tasklet can reach it through handle_crq_init_rsp() queuing
VNIC_RESET_FAILOVER, or through an XPORT_EVENT queuing VNIC_RESET_FATAL.
If the GFP_ATOMIC rwi allocation fails there, the close work is queued
and blocks in wait_for_completion(&adapter->probe_done).

ibmvnic_probe() then writes the final state and runs the close:

ibmvnic_probe()
    adapter->state = VNIC_PROBED;   /* or VNIC_DOWN */
    register_netdev(netdev);
    complete_all(&adapter->probe_done);
    flush_work(&adapter->ibmvnic_close_work);
        ibmvnic_close_work()
            ibmvnic_close()
                __ibmvnic_close()
                    adapter->state = VNIC_CLOSED;

The failover_pending shortcut in ibmvnic_close() also sets VNIC_CLOSED.

Probe never calls init_resources(), so adapter->napi is still NULL. On
the next open, ibmvnic_open() treats VNIC_CLOSED as already set up:

    if (adapter->state != VNIC_CLOSED) {
        rc = ibmvnic_login(netdev);
        ...
        rc = init_resources(adapter);

Then __ibmvnic_open()->ibmvnic_napi_enable() does:

    for (i = 0; i < adapter->req_rx_queues; i++)
        napi_enable(&adapter->napi[i]);

Would that dereference the NULL adapter->napi array?

Before this patch, the inline close ran while the state was still
VNIC_PROBING, and probe overwrote it with VNIC_PROBED or VNIC_DOWN
afterwards. The new flush_work() in probe reverses that order.

If probe ended in VNIC_DOWN, the VNIC_CLOSED state also makes
handle_crq_init_rsp() queue VNIC_RESET_FAILOVER instead of
VNIC_RESET_PASSIVE_INIT.

Should the worker only close an adapter that is actually open (for
example state == VNIC_OPEN)? Or should close requests queued during
probing be dropped?

[Severity: Medium]
The commit message says the new flag ensures "ibmvnic_close() cannot make
removal look active again after remove() has begun". Does this snapshot
of adapter->removing guarantee that?

ibmvnic_remove() sets removing and VNIC_REMOVING without holding rtnl, so
it does not serialize against this worker:

CPU1 (__ibmvnic_reset)
  passes the !adapter->removing gate
  do_reset() waits in rtnl_lock()

CPU2 (ibmvnic_close_work)
  holds rtnl, sees removing == false
  __ibmvnic_close()->set_link_state() sleeps

CPU3 (ibmvnic_remove)
  adapter->removing = true;
  adapter->state = VNIC_REMOVING;
  flush_work(&adapter->ibmvnic_reset);

CPU2
  __ibmvnic_close()
      adapter->state = VNIC_CLOSED;
  rtnl_unlock();

CPU1
  do_reset() takes rtnl and re-checks only the state:
      if (reset_state == VNIC_REMOVING || reset_state == VNIC_REMOVED) {

Several checks on the in-progress reset path still look only at
adapter->state:

  - the early VNIC_REMOVING return in __ibmvnic_reset()
  - the per-rwi REMOVING/REMOVED check in its loop
  - the re-checks in do_reset() and do_hard_reset()

Would the reset then go ahead on a device that is being removed?

Failed resets are retried:

    if (!rwi && rc)
        rwi = tmprwi;

There is also a 60 second sleep after three failures. Can
ibmvnic_remove() then block in flush_work() indefinitely?

[Severity: Medium]
This is a pre-existing issue, but can this close run twice for one open
and leave the sub-CRQ IRQ disable depth unbalanced?

Each close calls disable_irq() on every rx/tx sub-CRQ IRQ in
ibmvnic_disable_irqs(). __ibmvnic_open() enables each queue only once:

    if (prev_state == VNIC_CLOSED)
        enable_irq(adapter->rx_scrq[i]->irq);

The deferred close can run when the adapter is already VNIC_CLOSED. For
example, ndo_stop runs while the worker waits on rtnl, or the ENOMEM hits
an interface that was already down. The depth then reaches 2, and the
next open leaves it at 1.

Would RX/TX completion interrupts then stay disabled while the driver
reports VNIC_OPEN?

The old inline ibmvnic_close() on ENOMEM had the same behavior. A state
check in the new worker would also cover this.

[Severity: Medium]
This isn't a bug introduced by this patch, but ibmvnic_close() is the
ndo_stop callback, and calling it directly bypasses dev_close().

IFF_UP and the qdisc state are not updated, so the core still sees the
interface as up. It will call ndo_stop again on a later link down or in
unregister_netdevice(). The close also runs whether or not the core ever
opened the device.

Is calling ndo_stop outside dev_close() intended here? The old code made
the same direct call from ibmvnic_reset(), and this patch only moves it
into a worker.

[Severity: Medium]
This is a pre-existing issue, but does the rtnl_lock() taken in this
worker serialize ibmvnic_close() against a reset? do_reset() drops rtnl
around its own link-state change:

    rtnl_unlock();
    rc = set_link_state(adapter, IBMVNIC_LOGICAL_LNK_DN);
    rtnl_lock();

This worker, or any ndo_stop, can take rtnl in that window and start a
second set_link_state(). Both callers do
reinit_completion(&adapter->init_done), wait on that same completion and
read the shared init_done_rc. The CRQ response handler uses a plain
complete().

Can one caller's reinit_completion() wipe out the response meant for the
other? One waiter would then time out after 20 seconds, or read the other
transaction's result.

The same race was already reachable through ndo_stop and through the old
inline close.

> +	rtnl_unlock();
> +}

[ ... ]

> @@ -3265,7 +3288,7 @@ static void __ibmvnic_reset(struct work_struct *work)
>  	 */
>  	need_reset = false;
>  	spin_lock(&adapter->rwi_lock);
> -	if (!list_empty(&adapter->rwi_list)) {
> +	if (!adapter->removing && !list_empty(&adapter->rwi_list)) {

[Severity: High]
This isn't a bug introduced by this patch, but since this critical
section is being modified: is a plain spin_lock() safe here?

__ibmvnic_reset() runs from a workqueue with BH enabled, but rwi_lock is
also taken in softirq context:

ibmvnic_interrupt()
  tasklet_schedule()
    ibmvnic_tasklet()
      ibmvnic_handle_crq()
        ibmvnic_reset()
          spin_lock_irqsave(&adapter->rwi_lock, flags);

ibmvnic_tx_timeout() also reaches ibmvnic_reset(), from the netdev
watchdog timer.

Suppose a CRQ interrupt arrives on the CPU running the reset worker while
the worker holds rwi_lock. The tasklet can run on irq exit and spin on
the lock held by the task it interrupted. Would that deadlock the CPU?

The probe timeout block added above uses spin_lock_irqsave() on the same
lock. Should this one use spin_lock_irqsave() or spin_lock_bh() as well?

[ ... ]

> @@ -6629,6 +6660,7 @@ static void ibmvnic_remove(struct vio_dev *dev)
>  
>  	flush_work(&adapter->ibmvnic_reset);
>  	flush_delayed_work(&adapter->ibmvnic_delayed_reset);
> +	flush_work(&adapter->ibmvnic_close_work);

[Severity: Medium]
This is a pre-existing issue, but does ibmvnic_remove() leak the
ibmvnic_rwi entries still on adapter->rwi_list?

ibmvnic_reset() can add an entry and queue the reset work just before
remove() sets VNIC_REMOVING. The flushed __ibmvnic_reset() then returns
early in one of three places:

  - the VNIC_REMOVING check
  - the new !adapter->removing gate
  - the in-loop REMOVING check, which frees only the current rwi

release_resources() does not touch rwi_list, and free_netdev() frees the
adapter.

The probe failure path calls flush_reset_queue() after its flushes.
Should ibmvnic_remove() do the same?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004103131.1205618-1-runyu.xiao%40seu.edu.cn
