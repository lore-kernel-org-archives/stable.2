Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93E639BFF8;
	Thu,  6 Aug 2026 17:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036838; cv=none; b=cAP8WolhQfcmoNJcLC4S93B98Tfy78SbDlOt53VgAVW2MYrJ7bWwDc+7hAL6TnUokSJ5saILBaOGN80UsuOcMwbPR4I+f8q5OlWXyf0bzAOLuHYUffP8d0hWfQIzpwvJKkd9J1AmX6wZzVKc8bQCKnmiQqMCkf8+dF/p1/btmfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036838; c=relaxed/simple;
	bh=rCdlDQllDtPji/GZBB47oWvFP2wNKDXyHUnrDBTG3GE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5ew8bEHsIP2EL/w4ptDI6ZHm0jmXVpC3SYZXm+XAgN4FXhsoR7Qc71J6zGSj61+q30aymQre8BWmzBBdQF2+z41YWTkdr6SxR9+5al5HDz6bPfrKxxHfo4KNeI7JGVMkEL7BxJrMD9y6PxSK8ESvEhs3snlvhWwPXDdIoXHbbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bpSQeg3M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bpSQeg3M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 003081F00A3A;
	Thu,  6 Aug 2026 17:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786036836;
	bh=uss2jx7mt+V1w2FjPjSEVaYLVEJWLTpJkR0FZfcsCKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bpSQeg3Mmah3SCDygfndACcpATrhu2Z6vYs1dejDgRf5zLa1GPdyke/WhBe/ZlySK
	 S2MXRte+SN10iugz3c6mboHLsiJT2Sp4Vv32Jdlb3zd1h/rpt8zKB30R4xeBAgzHDt
	 unz9hkJ8aJYF1nfM2ZVj9hrPoTGkcV1ka9QxHJ/rbHRzpW11W0oRCO7cPFOS0uN2Li
	 vx24+ufMCCw33TNlZI9IXZ3iDV8URjuuw8tmFSwb9w1uk/zHbx0hoVbOGcIgL3AGKl
	 pnPks3JNGvmNZ3jhCccj4nsDA2DEqiY+HSpKuoUCR0R+U/TyR3K1iG6aGlssfSv7jQ
	 eZKNVhVDH3Plw==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	doruk@0sec.ai,
	michal.swiatkowski@linux.intel.com,
	grzegorz.nitka@intel.com,
	horms@kernel.org,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org,
	aleksandr.loktionov@intel.com,
	marcin.szycik@linux.intel.com
Subject: Re: [PATCH net 03/10] iavf: send MAC change request synchronously
Date: Thu,  6 Aug 2026 10:20:35 -0700
Message-ID: <20260806172035.2935588-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260804222205.1580328-4-anthony.l.nguyen@intel.com>
References: <20260804222205.1580328-4-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
    iavf: send MAC change request synchronously

This converts iavf_set_mac() from waiting on vc_waitqueue for the watchdog
to send the ADD_ETH_ADDR message into sending it inline and polling the
admin queue with a new generic helper, iavf_poll_virtchnl_response().
iavf_add_ether_addrs() now returns an error code and iavf_mac_add_reject()
is exported so local failures can be rolled back.

A few questions about the new synchronous path below.

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 630388e9d28cb..3fa288e3798ae 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -1029,6 +1029,60 @@ static bool iavf_is_mac_set_handled(struct net_device *netdev,
>  	return ret;
>  }
>  
> +/**
> + * iavf_mac_change_done - Check if MAC change completed
> + * @adapter: board private structure
> + * @data: MAC address being checked (as const void *)
> + * @v_op: virtchnl opcode from processed message
> + *
> + * Callback for iavf_poll_virtchnl_response() to check if MAC change completed.
> + *
> + * Return: true if MAC change completed, false otherwise
> + */
> +static bool iavf_mac_change_done(struct iavf_adapter *adapter,
> +				 const void *data, enum virtchnl_ops v_op)
> +{
> +	const u8 *addr = data;
> +
> +	return iavf_is_mac_set_handled(adapter->netdev, addr);
> +}

[Severity: Medium]
Can this callback report completion before the ADD_ETH_ADDR reply is seen?

v_op is discarded, and iavf_poll_virtchnl_response() runs the callback after
processing any received element, so an unrelated message satisfies it too.

For a MAC that is already on mac_filter_list from an earlier successful add,
iavf_mac_add_ok() left add_handled == true, and iavf_replace_primary_mac()
only sets add = true.  iavf_add_ether_addrs() then clears f->add while
packing the message, so iavf_is_mac_set_handled() is already true:

	if (!f || (!f->add && f->add_handled))
		ret = true;

The first unrelated ARQ element (for example a VIRTCHNL_OP_EVENT link change
that piled up while iavf_adminq_task() was blocked on netdev_lock) then makes
the poll break with ret = 0.  netdev->dev_addr is only updated in the
VIRTCHNL_OP_ADD_ETH_ADDR case of iavf_virtchnl_completion(), which has not
run yet, so iavf_set_mac() falls into:

	if (!ether_addr_equal(netdev->dev_addr, addr->sa_data))
		return -EACCES;

and userspace gets -EACCES for a request that is still in flight and will be
accepted.  Would matching received_op against VIRTCHNL_OP_ADD_ETH_ADDR in the
callback avoid this?

> +
> +/**
> + * iavf_set_mac_sync - Synchronously change MAC address
> + * @adapter: board private structure
> + * @addr: MAC address to set
> + *
> + * Send MAC change request to PF and poll admin queue for response.
> + * Caller must hold netdev_lock. This can sleep for up to 2.5 seconds.
> + * Event buffer is allocated before sending to avoid state mismatch if
> + * allocation fails after message is sent to PF.
> + *
> + * Return: 0 on success, negative on failure
> + */
> +static int iavf_set_mac_sync(struct iavf_adapter *adapter, const u8 *addr)
> +{
> +	struct iavf_arq_event_info event;
> +	int ret;
> +
> +	netdev_assert_locked(adapter->netdev);
> +
> +	event.buf_len = IAVF_MAX_AQ_BUF_SIZE;
> +	event.msg_buf = kzalloc(event.buf_len, GFP_KERNEL);
> +	if (!event.msg_buf)
> +		return -ENOMEM;
> +
> +	ret = iavf_add_ether_addrs(adapter);
> +	if (ret)
> +		goto out;

[Severity: Low]
What happens here when the pending add-filter list does not fit into one
message?  iavf_add_ether_addrs() truncates the batch and returns 0:

	if (len > IAVF_MAX_AQ_BUF_SIZE) {
		dev_warn(&adapter->pdev->dev, "Too many add MAC changes in one request\n");
		while (len > IAVF_MAX_AQ_BUF_SIZE)
			len = virtchnl_struct_size(veal, list, --count);
		more = true;
	}

iavf_add_filter() appends with list_add_tail() and the packing loop walks
from the head, so the newly requested primary MAC is the entry most likely
to be left out.  Its f->add stays true, so iavf_mac_change_done() can never
become true, and the leftovers can only go out from the watchdog, which
cannot run while iavf_set_mac() holds the netdev instance lock.

That leaves the poll sleeping the full 2500 ms and returning -EAGAIN, which
is the timeout plus -EAGAIN behaviour the commit message describes as fixed,
with no way for the caller to tell that its filter was never sent.

> +
> +	ret = iavf_poll_virtchnl_response(adapter, &event,
> +					  iavf_mac_change_done, addr, 2500);
> +
> +out:
> +	kfree(event.msg_buf);
> +	return ret;
> +}
> +
>  /**
>   * iavf_set_mac - NDO callback to set port MAC address
>   * @netdev: network interface device structure
> @@ -1049,25 +1103,23 @@ static int iavf_set_mac(struct net_device *netdev, void *p)
>  		return -EADDRNOTAVAIL;
>  
>  	ret = iavf_replace_primary_mac(adapter, addr->sa_data);
> -
>  	if (ret)
>  		return ret;
>  
> -	ret = wait_event_interruptible_timeout(adapter->vc_waitqueue,
> -					       iavf_is_mac_set_handled(netdev, addr->sa_data),
> -					       msecs_to_jiffies(2500));
> -
> -	/* If ret < 0 then it means wait was interrupted.
> -	 * If ret == 0 then it means we got a timeout.
> -	 * else it means we got response for set MAC from PF,
> -	 * check if netdev MAC was updated to requested MAC,
> -	 * if yes then set MAC succeeded otherwise it failed return -EACCES
> -	 */
> -	if (ret < 0)
> +	ret = iavf_set_mac_sync(adapter, addr->sa_data);
> +	if (ret) {
> +		/* Rollback only if send failed (message never reached PF).
> +		 * Don't rollback on timeout (-EAGAIN) because the message was
> +		 * sent and PF will eventually respond. When the response arrives,
> +		 * iavf_virtchnl_completion() will handle rollback (on PF error)
> +		 * or acceptance (on PF success) automatically.
> +		 */
> +		if (ret != -EAGAIN) {
> +			iavf_mac_add_reject(adapter);
> +			ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
> +		}
>  		return ret;

[Severity: Medium]
Can this rollback drop unrelated unicast and multicast filters?

iavf_mac_add_reject() is not a per-request rollback; it walks the whole
mac_filter_list and unconditionally frees every entry with is_new_mac set:

		if (f->is_new_mac) {
			list_del(&f->list);
			kfree(f);
		}

iavf_add_filter() sets is_new_mac = true for every newly allocated filter:

	f->add = true;
	f->add_handled = false;
	f->is_new_mac = true;

which includes addresses queued from iavf_set_rx_mode() -> iavf_addr_sync().
Those returned 0 to __hw_addr_sync_dev(), so the core already marked them
synced and will not ask the driver for them again:

	if (iavf_add_filter(adapter, addr))
		return 0;

So a MAC change that fails locally (-EBUSY or -ENOMEM, where nothing was
transmitted) appears to silently drop those addresses until a VF reset
re-syncs everything.  The same sweep also forces add_handled on all filters
with add == false, including ones belonging to a batch that is still in
flight, and never restores is_primary on the previous primary filter that
iavf_replace_primary_mac() cleared.

The kernel-doc of iavf_mac_add_reject() still says "Remove filters from list
based on PF response", which no longer matches these new callers where there
is no PF response at all.

[Severity: Medium]
Is the rollback complete when the requested MAC is already on the list with
is_new_mac == false?  iavf_mac_add_ok() clears is_new_mac on all filters
after any successful add cycle:

	list_for_each_entry_safe(f, ftmp, &adapter->mac_filter_list, list) {
		f->is_new_mac = false;

On -EBUSY (iavf_add_ether_addrs() returns before touching the list) or
-ENOMEM (returns before the packing loop), f->add and f->is_primary are
still set from iavf_replace_primary_mac():

	new_f->is_primary = true;
	new_f->add = true;
	ether_addr_copy(hw->mac.addr, new_mac);
	...
	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_MAC_FILTER);

iavf_mac_add_reject() only touches filters with !f->add or is_new_mac, so
this one survives untouched and IAVF_FLAG_AQ_ADD_MAC_FILTER is still armed.

Once iavf_set_mac() returns the error and the lock is dropped, the watchdog
sends VIRTCHNL_OP_ADD_ETH_ADDR with VIRTCHNL_ETHER_ADDR_PRIMARY for a change
userspace was told had failed, while hw.mac.addr has been rolled back.  In
the completion path netdev->dev_addr then equals the rolled-back hw.mac.addr,
so dev_addr is not updated and the PF ends up using the new address as the
VF primary MAC while the driver still reports the old one.

> -
> -	if (!ret)
> -		return -EAGAIN;
> +	}
>  
>  	if (!ether_addr_equal(netdev->dev_addr, addr->sa_data))
>  		return -EACCES;

[ ... ]

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index ec234cc8bd9db..e6b7e8f82c7c1 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c

[ ... ]

> @@ -555,20 +556,23 @@ iavf_set_mac_addr_type(struct virtchnl_ether_addr *virtchnl_ether_addr,
>   * @adapter: adapter structure
>   *
>   * Request that the PF add one or more addresses to our filters.
> - **/
> -void iavf_add_ether_addrs(struct iavf_adapter *adapter)
> + *
> + * Return: 0 on success, negative on failure
> + */
> +int iavf_add_ether_addrs(struct iavf_adapter *adapter)
>  {
>  	struct virtchnl_ether_addr_list *veal;
>  	struct iavf_mac_filter *f;
>  	int i = 0, count = 0;
>  	bool more = false;
>  	size_t len;
> +	int ret;
>  
>  	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
>  		/* bail because we already have a command pending */
>  		dev_err(&adapter->pdev->dev, "Cannot add filters, command %d pending\n",
>  			adapter->current_op);
> -		return;
> +		return -EBUSY;
>  	}

[Severity: Medium]
On the new synchronous path, is this -EBUSY transient or permanent?

current_op is set by every virtchnl send (for example the watchdog's
iavf_request_stats() issuing GET_STATS) and is only cleared at the end of
iavf_virtchnl_completion().  For the asynchronous path that runs from
iavf_adminq_task(), which needs the same lock iavf_set_mac() is holding:

iavf_adminq_task()
	netdev_lock(netdev);

So while iavf_set_mac() -> iavf_set_mac_sync() is running, an already
in-flight command can never complete and current_op can never go back to
VIRTCHNL_OP_UNKNOWN.  iavf_set_mac_sync() sends once and does not reach
iavf_poll_virtchnl_response(), so the outstanding reply is never drained.

iavf_set_mac() then takes the ret != -EAGAIN branch, runs the
iavf_mac_add_reject() rollback and returns -EBUSY to userspace.  Doesn't that
make a plain MAC change fail in exactly the workload described in the commit
message, several VFs enslaved in quick succession while the watchdog is
issuing virtchnl commands?  Would polling first, or retrying the send after
draining the queue, be more appropriate here?

>  
>  	spin_lock_bh(&adapter->mac_vlan_list_lock);

[ ... ]

> @@ -594,8 +598,9 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
>  
>  	veal = kzalloc(len, GFP_ATOMIC);
>  	if (!veal) {
> +		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
>  		spin_unlock_bh(&adapter->mac_vlan_list_lock);
> -		return;
> +		return -ENOMEM;
>  	}
>  
>  	veal->vsi_id = adapter->vsi_res->vsi_id;
> @@ -615,8 +620,15 @@ void iavf_add_ether_addrs(struct iavf_adapter *adapter)
>  
>  	spin_unlock_bh(&adapter->mac_vlan_list_lock);
>  
> -	iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR, (u8 *)veal, len);
> +	ret = iavf_send_pf_msg(adapter, VIRTCHNL_OP_ADD_ETH_ADDR, (u8 *)veal, len);
>  	kfree(veal);
> +	if (ret) {
> +		dev_err(&adapter->pdev->dev,
> +			"Unable to send ADD_ETH_ADDR message to PF, error %d\n", ret);
> +		adapter->current_op = VIRTCHNL_OP_UNKNOWN;
> +	}
> +
> +	return ret;
>  }

[Severity: Medium]
Does a return of 0 here always mean the message reached the admin send
queue?  iavf_send_pf_msg() short-circuits:

	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
		return 0; /* nothing to see here, move along */

In that case nothing is posted, current_op stays at VIRTCHNL_OP_ADD_ETH_ADDR
(it is only restored on an error return), and the filters have already had
f->add cleared during packing.  iavf_poll_virtchnl_response() then polls a
shut-down queue where iavf_clean_arq_element() returns IAVF_ERR_QUEUE_EMPTY
every iteration (hw->aq.arq.count == 0) for the full 2500 ms under
netdev_lock, and returns -EAGAIN.

The comment in iavf_set_mac() says "the message was sent and PF will
eventually respond" and skips the rollback, so hw.mac.addr keeps the new
address while netdev->dev_addr keeps the old one, and current_op stays armed
so every later command hits "Cannot add filters, command %d pending" until
the watchdog's comm-failed path clears it.

The window looks reachable: iavf_disable_vf() sets the flag, shuts the admin
queue down, clears the reset flag and ends with __IAVF_DOWN:

	adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
	...
	iavf_shutdown_adminq(&adapter->hw);
	adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
	iavf_change_state(adapter, __IAVF_DOWN);

while iavf_set_mac() only rejects state < __IAVF_DOWN and
iavf_is_reset_in_progress().  Should the synchronous path check
IAVF_FLAG_PF_COMMS_FAILED before sending and polling?

[ ... ]

> @@ -2950,3 +2960,72 @@ void iavf_virtchnl_completion(struct iavf_adapter *adapter,
>  	} /* switch v_opcode */
>  	adapter->current_op = VIRTCHNL_OP_UNKNOWN;
>  }
> +
> +/**
> + * iavf_poll_virtchnl_response - Poll admin queue for virtchnl response

[ ... ]

> + * Return: 0 on success (condition met), -EAGAIN on timeout, or error code
> + */

[Severity: Low]
Can this function ever return the documented "error code"?  ret is only ever
-EAGAIN or 0, and the status from iavf_clean_arq_element() (for example
IAVF_ERR_ADMIN_QUEUE_ERROR for a descriptor with LIBIE_AQ_FLAG_ERR, or
IAVF_ERR_QUEUE_EMPTY for an uninitialised ARQ) is compared against
IAVF_SUCCESS and then dropped.

The other poller on the same queue in this file does the opposite:

iavf_poll_virtchnl_msg()
	status = iavf_clean_arq_element(hw, event, NULL);
	if (status != IAVF_SUCCESS)
		return iavf_status_to_errno(status);

Since iavf_set_mac() keys its rollback decision on ret != -EAGAIN, reporting
admin queue errors as a plain timeout also feeds the "message was sent"
assumption.  Could the kernel-doc and the implementation be brought in line,
one way or the other?

> +int iavf_poll_virtchnl_response(struct iavf_adapter *adapter,
> +				struct iavf_arq_event_info *event,
> +				bool (*condition)(struct iavf_adapter *adapter,
> +						  const void *data,
> +						  enum virtchnl_ops v_op),
> +				const void *cond_data,
> +				unsigned int timeout_ms)
> +{
> +	struct iavf_hw *hw = &adapter->hw;
> +	enum virtchnl_ops received_op;
> +	unsigned long timeout;
> +	int ret = -EAGAIN;
> +	u16 pending = 0;
> +	u32 v_retval;
> +
> +	netdev_assert_locked(adapter->netdev);
> +
> +	timeout = jiffies + msecs_to_jiffies(timeout_ms);
> +	do {
> +		if (!pending)
> +			usleep_range(50, 75);
> +
> +		if (iavf_clean_arq_element(hw, event, &pending) == IAVF_SUCCESS) {

[Severity: Medium]
What happens to this loop if a VF reset starts while it is polling?  There is
no device-in-reset check, no IAVF_FLAG_PF_COMMS_FAILED re-check and no
sanity check on the ARQ head, unlike iavf_adminq_task():

	val = rd32(hw, IAVF_VF_ARQLEN1);
	if (val == 0xdeadbeef || val == 0xffffffff) /* device in reset */
		goto freedom;

and unlike iavf_poll_virtchnl_msg(), which returns -EIO on
VIRTCHNL_EVENT_RESET_IMPENDING.

In iavf_clean_arq_element() the head is masked without a range check:

	ntu = rd32(hw, IAVF_VF_ARQH1) & IAVF_VF_ARQH1_ARQH_MASK;

The mask is 10 bits while num_arq_entries is IAVF_AQ_LEN (32), so a reset
time read of 0xdeadbeef/0xffffffff yields ntu far outside the ring and

	*pending = (ntc > ntu ? hw->aq.arq.count : 0) + (ntu - ntc);

stays non-zero forever.  In the new loop that means "if (!pending)" never
sleeps and "if (pending) continue;" keeps going, so it degenerates into a
tight rd32 / 4 KiB memcpy / tail write / 4 KiB memset spin with no
cond_resched() until the timeout expires, consuming descriptors firmware
never posted and feeding stale contents into iavf_virtchnl_completion().

All of that runs holding netdev_lock, which iavf_reset_task() and
iavf_adminq_task() both need:

iavf_reset_task()
	netdev_lock(netdev);
	iavf_reset_step(adapter);

so reset recovery is delayed for up to 2.5 s, and since adapter->wq is an
ordered workqueue the other iavf work items queue up behind it.
iavf_set_mac() samples iavf_is_reset_in_progress() only once on entry, and
nothing can update those flags while the poll holds the lock, so there is no
way out of the loop early.  Should the loop bail out on the reset register
pattern and on RESET_IMPENDING events?

> +			received_op = (enum virtchnl_ops)le32_to_cpu(event->desc.cookie_high);
> +			if (received_op != VIRTCHNL_OP_UNKNOWN) {
> +				v_retval = le32_to_cpu(event->desc.cookie_low);
> +
> +				iavf_virtchnl_completion(adapter, received_op,
> +							 (enum iavf_status)v_retval,
> +							 event->msg_buf, event->msg_len);
> +
> +				if (condition(adapter, cond_data, received_op)) {
> +					ret = 0;
> +					break;
> +				}
> +			}
> +
> +			memset(event->msg_buf, 0, IAVF_MAX_AQ_BUF_SIZE);

[Severity: Low]
Should this use event->buf_len rather than the hardcoded
IAVF_MAX_AQ_BUF_SIZE?  struct iavf_arq_event_info expresses the size of
msg_buf via buf_len, and iavf_clean_arq_element() honours it:

	e->msg_len = min(datalen, e->buf_len);

The only caller today, iavf_set_mac_sync(), allocates exactly
IAVF_MAX_AQ_BUF_SIZE, so nothing overruns right now.  But the helper is
exported in iavf.h and its kernel-doc invites reuse "for any future
synchronous virtchnl operations", and other virtchnl call sites such as
iavf_get_vf_supported_rxdids() and iavf_get_vf_ptp_caps() use much smaller
event buffers.  Any such caller would get a 4 KiB out-of-bounds zeroing
write into the heap.

> +
> +			if (pending)
> +				continue;
> +		}
> +	} while (time_before(jiffies, timeout));
> +
> +	return ret;
> +}
