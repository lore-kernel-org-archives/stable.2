Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9336632B9B5;
	Mon, 24 Aug 2026 19:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787598112; cv=none; b=BqvxhEjyH4N6p0hgknq5CCT1qegAkxl9dEDyuYetHiS50ewaGJHopSpAkQ0tjJP+oEHEDjR94eQ409ZgHaqXBhb1ixI4aHG3tQSdKP5J4tKirEKF9bdeANU8i8GUR5S3FN9+GvQGxrxYaoeG6EhCU0efB2qMFDpchEoGYgeteIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787598112; c=relaxed/simple;
	bh=933u73QWdpzZaBze9u9KiUkCiWNielYyFE59mdotBAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oxlp8E3uR8S9QqSmNqEoCzCIFFwhAjM/qNIKTk8sol8pv4YnPcFHyrqSfIYZ673tYp4i712Zq9JM7vIL6QBFOei+idS9+sGf61vhdtNS8gcPTvTaJCxEZEpdwwq9EQLYPpVpZjxRt08AXyzX8bOew4rZt6xYP1Y6dCxfmsn/aC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjhlpZC4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjhlpZC4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F4D11F00A3D;
	Mon, 24 Aug 2026 19:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787598110;
	bh=p3pGLBZRSwh5yRsmnzTTKhLQV7JpbpiY680jV/tG03k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DjhlpZC4SJ9XW3yBFQrQtzo3TzjNR0YB7KVpnx7DvsAwB/bZUzKJqpZnl8CvjZ5Fc
	 IixUo1vPFUDm7jNJyvdXmm7WMFnI9C2+XnfDebN/M+G4annp/0sP5Y03jkCCTe/Q9g
	 Ij4VOIKjDgKraUhg/bTQNs1bQ4U062BcpM/HJE0CAGH4Xiv/FRxvoHYH9iBNp4Vnht
	 4o3D7ytoIUKUK0tw5si72rVjVhAxhnAUqGyTPThznmcP3yWGOXEhl53JgIl/D2JlUW
	 /c6ozDj8XSzHG+G3dti0g2hUBSssNjdBClL0dZzuSMa5O1QawgvKzRN6nTZq8JDGuX
	 Wgwpqf9l1VC1g==
From: Jakub Kicinski <kuba@kernel.org>
To: anthony.l.nguyen@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org,
	jtornosm@redhat.com,
	przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	aleksandr.loktionov@intel.com,
	sdf@fomichev.me,
	horms@kernel.org,
	stable@vger.kernel.org,
	rafal.romanowski@intel.com
Subject: Re: [PATCH net 3/4] iavf: send MAC change request synchronously
Date: Mon, 24 Aug 2026 12:01:49 -0700
Message-ID: <20260824190149.2714547-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260821204537.2189112-4-anthony.l.nguyen@intel.com>
References: <20260821204537.2189112-4-anthony.l.nguyen@intel.com>
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

This converts iavf_set_mac() from queueing the ADD_ETH_ADDR request for the
watchdog and waiting on vc_waitqueue into sending the virtchnl message
directly and polling the admin receive queue for the reply. A new generic
helper iavf_poll_virtchnl_response() is added, iavf_add_ether_addrs() now
returns an error code, iavf_mac_add_reject() is exported for rollback, and
vc_waitqueue is removed.

A few questions about the new synchronous path below.

First, about the changelog text:

>     export iavf_mac_add_reject() to enable proper rollback on local failures
>     (timeouts, send errors) - PF rejections are already handled automatically
>     by iavf_virtchnl_completion().

[Severity: Low]

Is the "timeouts" part accurate? iavf_poll_virtchnl_response() returns
-EAGAIN on timeout, and iavf_set_mac() explicitly skips the rollback for
that value:

	if (ret != -EAGAIN) {
		iavf_mac_add_reject(adapter);
		ether_addr_copy(adapter->hw.mac.addr, netdev->dev_addr);
	}

So on a timeout nothing is rolled back, which is the opposite of what the
changelog describes (and matches the in-code comment). Could the changelog
be adjusted to say send errors only?

> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
> index dc31202b2a94..8c45536fd502 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h

[ ... ]

> @@ -588,8 +587,9 @@ void iavf_configure_queues(struct iavf_adapter *adapter);
>  void iavf_enable_queues(struct iavf_adapter *adapter);
>  void iavf_disable_queues(struct iavf_adapter *adapter);
>  void iavf_map_queues(struct iavf_adapter *adapter);
> -void iavf_add_ether_addrs(struct iavf_adapter *adapter);
> +int iavf_add_ether_addrs(struct iavf_adapter *adapter);
>  void iavf_del_ether_addrs(struct iavf_adapter *adapter);
> +void iavf_mac_add_reject(struct iavf_adapter *adapter);

[Severity: Low]

Now that iavf_add_ether_addrs() reports -EBUSY, -ENOMEM and send failures,
should the watchdog side caller consume it too? iavf_process_aq_command()
still discards it and returns 0 unconditionally:

	if (adapter->aq_required & IAVF_FLAG_AQ_ADD_MAC_FILTER) {
		iavf_add_ether_addrs(adapter);
		return 0;
	}

which also disagrees with that function's own kernel-doc ("Returns error
code if no command was sent or error code if the command failed").

[ ... ]

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 630388e9d28c..3fa288e3798a 100644
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

iavf_mac_change_done() ignores v_op and looks only at filter state, while
iavf_poll_virtchnl_response() calls the predicate after every message it
processes.

Consider setting an address that already has a filter whose earlier add
succeeded, so add_handled is true and is_new_mac is false.
iavf_replace_primary_mac() sets add = true but does not reset add_handled,
and iavf_add_ether_addrs() clears add again while building the batch:

iavf_is_mac_set_handled():
	f = iavf_find_filter(adapter, macaddr);

	if (!f || (!f->add && f->add_handled))
		ret = true;

Can an unrelated message processed by the poll loop, for example a
VIRTCHNL_OP_EVENT link change, then make this return true before the
ADD_ETH_ADDR reply arrives? netdev->dev_addr is only updated from
iavf_virtchnl_completion(), so iavf_set_mac() would return -EACCES for a
request that is still in flight and later applied.

The old code only re-evaluated the condition on
wake_up(&adapter->vc_waitqueue), which was issued exclusively from the
VIRTCHNL_OP_ADD_ETH_ADDR completion paths.

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
> +
> +	ret = iavf_poll_virtchnl_response(adapter, &event,
> +					  iavf_mac_change_done, addr, 2500);

[Severity: Medium]

Only one batch is sent here. iavf_add_ether_addrs() truncates the request
when it does not fit the admin queue buffer:

	len = virtchnl_struct_size(veal, list, count);
	if (len > IAVF_MAX_AQ_BUF_SIZE) {
		dev_warn(&adapter->pdev->dev, "Too many add MAC changes in one request\n");
		while (len > IAVF_MAX_AQ_BUF_SIZE)
			len = virtchnl_struct_size(veal, list, --count);
		more = true;
	}

The remaining filters keep f->add == true and IAVF_FLAG_AQ_ADD_MAC_FILTER
stays set, and iavf_add_filter() appends new filters to the tail of
mac_filter_list. If the just requested primary address ends up outside the
first batch, can iavf_mac_change_done() ever become true, given
iavf_is_mac_set_handled() requires !f->add? The poll loop has no way to send
the next batch, so this would burn the full 2500 ms and return -EAGAIN to
userspace while the watchdog applies the change afterwards.

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

[Severity: High]

Can this rollback destroy filters that belong to a different, still
outstanding request?

iavf_mac_add_reject() is a completion time helper that walks the whole list:

	list_for_each_entry_safe(f, ftmp, &adapter->mac_filter_list, list) {
		if (f->remove && ether_addr_equal(f->macaddr, netdev->dev_addr))
			f->remove = false;

		if (!f->add && !f->add_handled)
			f->add_handled = true;

		if (f->is_new_mac) {
			list_del(&f->list);
			kfree(f);
		}
	}

One way to reach it with ret == -EBUSY is an ADD_ETH_ADDR batch the watchdog
already sent and whose reply has not been processed yet. Those filters are
exactly in state add == false, is_new_mac == true (is_new_mac is only
cleared by iavf_mac_add_ok() on a successful reply), so they are freed here
while the PF still has the adds pending.

Newly queued unicast/multicast filters from iavf_addr_sync() are in the same
boat, since iavf_add_filter() sets:

	f->add = true;
	f->add_handled = false;
	f->is_new_mac = true;

The netdev core already considers those addresses synced, so once they are
dropped here nothing programs or retries them until a reset. Should the
rollback be scoped to the address that iavf_set_mac() itself queued?

[Severity: Medium]

Does the -EAGAIN assumption in the comment above ("the message was sent and
PF will eventually respond") hold when IAVF_FLAG_PF_COMMS_FAILED is set?
iavf_send_pf_msg() returns success without posting anything in that case:

	if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
		return 0; /* nothing to see here, move along */

iavf_add_ether_addrs() then reports 0 while current_op stays
VIRTCHNL_OP_ADD_ETH_ADDR and f->add has already been cleared, so the poll
spins for the full 2.5 s under rtnl_lock plus the netdev instance lock,
returns -EAGAIN, and no rollback runs. adapter->hw.mac.addr and the filter
bookkeeping then diverge from netdev->dev_addr, and current_op stays pending
so later virtchnl requests hit "Cannot add filters, command %d pending".

iavf_disable_vf() sets IAVF_FLAG_PF_COMMS_FAILED, clears
IAVF_FLAG_RESET_PENDING and moves the state to __IAVF_DOWN, so the guard at
the top of iavf_set_mac() still passes in that window:

	if (iavf_is_reset_in_progress(adapter) || adapter->state < __IAVF_DOWN)
		return -EBUSY;

>  		return ret;
> -
> -	if (!ret)
> -		return -EAGAIN;
> +	}
>  
>  	if (!ether_addr_equal(netdev->dev_addr, addr->sa_data))
>  		return -EACCES;

[ ... ]

> diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
> index ec234cc8bd9d..e6b7e8f82c7c 100644
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

Is this -EBUSY reachable as a hard failure from the new caller?

iavf_set_mac() runs with the netdev instance lock held, and the only context
that clears current_op is iavf_virtchnl_completion() as called from
iavf_adminq_task(), which starts with netdev_lock(netdev). The watchdog does
the same. So while iavf_set_mac() holds the lock, an outstanding command's
reply cannot be consumed and current_op cannot go back to
VIRTCHNL_OP_UNKNOWN.

iavf_set_mac_sync() sends once and gives up:

	ret = iavf_add_ether_addrs(adapter);
	if (ret)
		goto out;

Before this change iavf_set_mac() only set IAVF_FLAG_AQ_ADD_MAC_FILTER and
the watchdog retried the send after the previous command completed, so the
operation succeeded. Can "ip link set dev X address ..." or bond_enslave()
now fail with -EBUSY whenever the watchdog has a command in flight, for
instance the VIRTCHNL_OP_GET_STATS request it sends every couple of
watchdog ticks?

[ ... ]

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
>  
>  /**
> @@ -712,8 +724,8 @@ static void iavf_mac_add_ok(struct iavf_adapter *adapter)
>   * @adapter: adapter structure
>   *
>   * Remove filters from list based on PF response.
> - **/
> -static void iavf_mac_add_reject(struct iavf_adapter *adapter)
> + */
> +void iavf_mac_add_reject(struct iavf_adapter *adapter)
>  {
>  	struct net_device *netdev = adapter->netdev;
>  	struct iavf_mac_filter *f, *ftmp;

[Severity: Medium]

Is this helper able to roll back a filter whose is_new_mac is already
cleared?

Setting an address that was programmed successfully before leaves
is_new_mac == false, and iavf_replace_primary_mac() then does:

	old_f->is_primary = false;
	old_f->remove = true;
	...
	new_f->is_primary = true;
	new_f->add = true;

If iavf_set_mac_sync() fails locally before the batch is built (-EBUSY from
the current_op check, or -ENOMEM from the veal kzalloc), both branches in
iavf_mac_add_reject() skip that entry: f->add is still true, and
f->is_new_mac is false. So f->add and IAVF_FLAG_AQ_ADD_MAC_FILTER survive,
and the watchdog later sends ADD_ETH_ADDR for the address whose change was
just reported as failed. Since f->is_primary is still set,
iavf_set_mac_addr_type() marks it as primary:

	virtchnl_ether_addr->type = filter->is_primary ?
		VIRTCHNL_ETHER_ADDR_PRIMARY :
		VIRTCHNL_ETHER_ADDR_EXTRA;

Does the PF then end up with a primary MAC that differs from
netdev->dev_addr, with no filter marked primary for the address the
interface is actually using, since old_f->is_primary is never restored?

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

The kernel-doc promises "or error code", but ret is only ever -EAGAIN or 0,
and the iavf_clean_arq_element() status is dropped here. The sibling helper
in this file does convert it:

iavf_poll_virtchnl_msg():
	status = iavf_clean_arq_element(hw, event, NULL);
	if (status != IAVF_SUCCESS)
		return iavf_status_to_errno(status);

For the IAVF_ERR_ADMIN_QUEUE_ERROR case, iavf_clean_arq_element() has
already consumed the descriptor, re-posted it and advanced IAVF_VF_ARQT1:

	flags = le16_to_cpu(desc->flags);
	if (flags & LIBIE_AQ_FLAG_ERR) {
		ret_code = IAVF_ERR_ADMIN_QUEUE_ERROR;

so the awaited reply no longer exists. Should that be reported instead of
spinning to the -EAGAIN timeout, which iavf_set_mac() reads as "still
outstanding, the PF will respond later" and therefore skips the rollback,
leaving current_op pending?

[Severity: High]

What happens to this loop if a VFR/EMPR lands while it is polling? The other
ARQ consumer checks for that explicitly:

iavf_adminq_task():
	if (iavf_is_reset_in_progress(adapter))
		goto freedom;

	/* check for error indications */
	val = rd32(hw, IAVF_VF_ARQLEN1);
	if (val == 0xdeadbeef || val == 0xffffffff) /* device in reset */
		goto freedom;

and it also clears the sticky ARQVFE/ARQOVFL/ARQCRIT bits. None of that
happens here, and iavf_clean_arq_element() takes the producer index straight
from the register without validating it:

	ntu = rd32(hw, IAVF_VF_ARQH1) & IAVF_VF_ARQH1_ARQH_MASK;
	if (ntu == ntc) {

With the reset sentinels, 0xdeadbeef & 0x3FF is 751 and 0xffffffff & 0x3FF
is 1023, both well above hw->aq.num_arq_entries and never equal to
next_to_clean, so IAVF_ERR_ADMIN_QUEUE_NO_WORK is not returned. Can this
then "clean" descriptors the hardware never produced, rewrite them, do
wr32(hw, IAVF_VF_ARQT1, ntc) on a disabled queue and advance
next_to_clean/next_to_use?

*pending would also come back as hundreds, so the throttle is skipped:

	if (!pending)
		usleep_range(50, 75);
	...
		if (pending)
			continue;

Does that busy-spin on MMIO for the remaining 2.5 s while holding the netdev
instance lock and the caller's rtnl_lock, which is what iavf_reset_task()
needs to recover? Note the loop itself can process
VIRTCHNL_EVENT_RESET_IMPENDING, which only schedules the reset and does not
stop the polling.

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
IAVF_MAX_AQ_BUF_SIZE? The buffer is caller owned and its size is described
by event->buf_len, which iavf_clean_arq_element() honours:

	e->msg_len = min(datalen, e->buf_len);

Today's only caller allocates exactly IAVF_MAX_AQ_BUF_SIZE so nothing is
overwritten, but the helper is exported in iavf.h as generic, and this file
already has ARQ polling callers with small buffers, e.g.:

	event.msg_buf = (u8 *)&rxdids;
	event.buf_len = sizeof(rxdids);

Such a caller would get a 4096 byte memset of a few bytes of storage.

> +
> +			if (pending)
> +				continue;
> +		}
> +	} while (time_before(jiffies, timeout));
> +
> +	return ret;
> +}
