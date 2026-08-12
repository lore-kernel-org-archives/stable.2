Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE9531F9A8
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 07:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518177; cv=none; b=PPUuDf/8198t9lvBuTe8tFKf8GfNswmA2lJnROF2AqpbPL8k0tiAnqmEvf5kEmuiDpUENzF2TdxPsaPNlNRPnF6Hi9jelXzg6Na0OqV9bPwlGCSXXt+OMX22hLqXYqZB/5C7/mH+9mhuMllMbB7Na83lWHWvRDLmuykNYhsxwAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518177; c=relaxed/simple;
	bh=kI68SDoMimIic9AeS3DDIE58ZVgM/XM45kaV1d872BA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GdMsEIbIapsKlTlGScn1Dy2hx28QgYQtZMLVTAXN9A6UPpGPm6zBoD6yqepYPK8Hq1TJo+OlPaisqe3iAPqoj0IDRxl9N2EZQfvSIpX4fU8IA4D7fOU+gbsfWrYMYl0iWVGUjDZmIEqbQ9skjRtKq9vjkEBIKf8XPAUqaHCfFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dsZuovpd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dsZuovpd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786518175;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJaFvPKmU2GwsL+SqA7CTV1XGubSN85udrFOsiGWyqI=;
	b=dsZuovpdmjpVu5Y328FyOobhroL44T9s9/OOmvo2t7VQaCR5tMDSYtp+lHCs7scISmN9wD
	uQq0/TemcgwDCHvVMkyZL8p6EwS3SotPaxrYq7NT7+1RlxqOcSESobDo4ZEAew6JpGRS0Y
	n/fLT/IOIpWjsD7GxSxXQGeKZVEhZv0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-vFAsKSKIPKKISnMkRWp9Uw-1; Wed,
 12 Aug 2026 03:02:45 -0400
X-MC-Unique: vFAsKSKIPKKISnMkRWp9Uw-1
X-Mimecast-MFC-AGG-ID: vFAsKSKIPKKISnMkRWp9Uw_1786518163
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3671E1800366;
	Wed, 12 Aug 2026 07:02:43 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.44.32.55])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 14A8419560AB;
	Wed, 12 Aug 2026 07:02:37 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kuba@kernel.org,
	anthony.l.nguyen@intel.com
Cc: aleksandr.loktionov@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	doruk@0sec.ai,
	edumazet@google.com,
	grzegorz.nitka@intel.com,
	horms@kernel.org,
	marcin.szycik@linux.intel.com,
	michal.swiatkowski@linux.intel.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net 03/10] iavf: send MAC change request synchronously
Date: Wed, 12 Aug 2026 09:02:36 +0200
Message-ID: <20260812070236.10559-1-jtornosm@redhat.com>
In-Reply-To: <20260806172035.2935588-1-kuba@kernel.org>
References: <20260806172035.2935588-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

All the comments below fall into pre-existing issues, concerns already
addressed in previous versions, out-of-scope items, or extreme edge
cases. No code changes are considered necessary for a new version.
Details for each comment:

> [Severity: Medium]
> Can this callback report completion before the ADD_ETH_ADDR reply is seen?
>
> v_op is discarded, and iavf_poll_virtchnl_response() runs the callback after
> processing any received element, so an unrelated message satisfies it too.
>
> For a MAC that is already on mac_filter_list from an earlier successful add,
> iavf_mac_add_ok() left add_handled == true, and iavf_replace_primary_mac()
> only sets add = true.  iavf_add_ether_addrs() then clears f->add while
> packing the message, so iavf_is_mac_set_handled() is already true:
>
>     if (!f || (!f->add && f->add_handled))
>         ret = true;
>
> The first unrelated ARQ element (for example a VIRTCHNL_OP_EVENT link change
> that piled up while iavf_adminq_task() was blocked on netdev_lock) then makes
> the poll break with ret = 0.  netdev->dev_addr is only updated in the
> VIRTCHNL_OP_ADD_ETH_ADDR case of iavf_virtchnl_completion(), which has not
> run yet, so iavf_set_mac() falls into:
>
>     if (!ether_addr_equal(netdev->dev_addr, addr->sa_data))
>         return -EACCES;
>
> and userspace gets -EACCES for a request that is still in flight and will be
> accepted.  Would matching received_op against VIRTCHNL_OP_ADD_ETH_ADDR in the
> callback avoid this?

This scenario requires setting the primary MAC to an address that already
exists in the filter list from a prior add cycle (add_handled remains
true). This means the user previously added it as a secondary filter and
kept it, they could have removed it at any time. Re-purposing an existing
secondary MAC as primary is an unusual operation. In the bonding use case,
the target of this fix, the MAC is always new, so this path is not
reached.

Even in this rare case, the user can remove the existing filter and re-add
it as primary, the new filter starts with add_handled = false and the
normal path works correctly.

> [Severity: Low]
> What happens here when the pending add-filter list does not fit into one
> message?  iavf_add_ether_addrs() truncates the batch and returns 0:
>
>     if (len > IAVF_MAX_AQ_BUF_SIZE) {
>         dev_warn(&adapter->pdev->dev, "Too many add MAC changes in one request\n");
>         while (len > IAVF_MAX_AQ_BUF_SIZE)
>             len = virtchnl_struct_size(veal, list, --count);
>         more = true;
>     }
>
> iavf_add_filter() appends with list_add_tail() and the packing loop walks
> from the head, so the newly requested primary MAC is the entry most likely
> to be left out.  Its f->add stays true, so iavf_mac_change_done() can never
> become true, and the leftovers can only go out from the watchdog, which
> cannot run while iavf_set_mac() holds the netdev instance lock.
>
> That leaves the poll sleeping the full 2500 ms and returning -EAGAIN, which
> is the timeout plus -EAGAIN behaviour the commit message describes as fixed,
> with no way for the caller to tell that its filter was never sent.

Already discussed with Przemek Kitszel in v7 review. The multi-batch
scenario requires more than 200 pending MAC filters on a VF, which is
extremely rare in practice. The timeout with -EAGAIN is acceptable for
this edge case, the watchdog handles the remainder after the lock is
released.

> [Severity: Medium]
> Can this rollback drop unrelated unicast and multicast filters?
>
> iavf_mac_add_reject() is not a per-request rollback; it walks the whole
> mac_filter_list and unconditionally frees every entry with is_new_mac set:
>
>         if (f->is_new_mac) {
>             list_del(&f->list);
>             kfree(f);
>         }
>
> iavf_add_filter() sets is_new_mac = true for every newly allocated filter:
>
>     f->add = true;
>     f->add_handled = false;
>     f->is_new_mac = true;
>
> which includes addresses queued from iavf_set_rx_mode() -> iavf_addr_sync().
> Those returned 0 to __hw_addr_sync_dev(), so the core already marked them
> synced and will not ask the driver for them again:
>
>     if (iavf_add_filter(adapter, addr))
>         return 0;
>
> So a MAC change that fails locally (-EBUSY or -ENOMEM, where nothing was
> transmitted) appears to silently drop those addresses until a VF reset
> re-syncs everything.  The same sweep also forces add_handled on all filters
> with add == false, including ones belonging to a batch that is still in
> flight, and never restores is_primary on the previous primary filter that
> iavf_replace_primary_mac() cleared.
>
> The kernel-doc of iavf_mac_add_reject() still says "Remove filters from list
> based on PF response", which no longer matches these new callers where there
> is no PF response at all.

Same concern addressed in previous versions. This scenario only occurs when
setting the primary MAC to an address that already exists as a secondary in
the filter list, an extremely rare configuration. Even if the watchdog
later sends the MAC to the PF, it is harmless: the MAC is already
configured on the PF, so the redundant ADD_ETH_ADDR has no adverse effect.
A VF reset re-syncs all filters via __hw_addr_sync_dev().

> [Severity: Medium]
> Is the rollback complete when the requested MAC is already on the list with
> is_new_mac == false?  iavf_mac_add_ok() clears is_new_mac on all filters
> after any successful add cycle:
>
>     list_for_each_entry_safe(f, ftmp, &adapter->mac_filter_list, list) {
>         f->is_new_mac = false;
>
> On -EBUSY (iavf_add_ether_addrs() returns before touching the list) or
> -ENOMEM (returns before the packing loop), f->add and f->is_primary are
> still set from iavf_replace_primary_mac():
>
>     new_f->is_primary = true;
>     new_f->add = true;
>     ether_addr_copy(hw->mac.addr, new_mac);
>     ...
>     iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_ADD_MAC_FILTER);
>
> iavf_mac_add_reject() only touches filters with !f->add or is_new_mac, so
> this one survives untouched and IAVF_FLAG_AQ_ADD_MAC_FILTER is still armed.
>
> Once iavf_set_mac() returns the error and the lock is dropped, the watchdog
> sends VIRTCHNL_OP_ADD_ETH_ADDR with VIRTCHNL_ETHER_ADDR_PRIMARY for a change
> userspace was told had failed, while hw.mac.addr has been rolled back.  In
> the completion path netdev->dev_addr then equals the rolled-back hw.mac.addr,
> so dev_addr is not updated and the PF ends up using the new address as the
> VF primary MAC while the driver still reports the old one.

Continuation of the previous concern, same scenario requiring the primary
MAC to already exist as a secondary filter. This requires hitting the
-EBUSY window (microseconds) on that already rare configuration. Even
then, the state is recoverable on retry or VF reset.

> [Severity: Medium]
> On the new synchronous path, is this -EBUSY transient or permanent?
>
> current_op is set by every virtchnl send (for example the watchdog's
> iavf_request_stats() issuing GET_STATS) and is only cleared at the end of
> iavf_virtchnl_completion().  For the asynchronous path that runs from
> iavf_adminq_task(), which needs the same lock iavf_set_mac() is holding:
>
> iavf_adminq_task()
>     netdev_lock(netdev);
>
> So while iavf_set_mac() -> iavf_set_mac_sync() is running, an already
> in-flight command can never complete and current_op can never go back to
> VIRTCHNL_OP_UNKNOWN.  iavf_set_mac_sync() sends once and does not reach
> iavf_poll_virtchnl_response(), so the outstanding reply is never drained.
>
> iavf_set_mac() then takes the ret != -EAGAIN branch, runs the
> iavf_mac_add_reject() rollback and returns -EBUSY to userspace.  Doesn't that
> make a plain MAC change fail in exactly the workload described in the commit
> message, several VFs enslaved in quick succession while the watchdog is
> issuing virtchnl commands?  Would polling first, or retrying the send after
> draining the queue, be more appropriate here?

Same concern addressed in previous versions. Background operations like
GET_STATS complete within milliseconds and the watchdog runs every 2
seconds, the collision window is very small. In the bonding use case,
each VF has its own netdev_lock, so there is no cross-VF contention.

Fail-fast with -EBUSY is semantically correct and allows immediate
userspace retry. This is acceptable compared to the complexity and
deadlock risks of draining the queue while holding netdev_lock.

> [Severity: Medium]
> Does a return of 0 here always mean the message reached the admin send
> queue?  iavf_send_pf_msg() short-circuits:
>
>     if (adapter->flags & IAVF_FLAG_PF_COMMS_FAILED)
>         return 0; /* nothing to see here, move along */
>
> In that case nothing is posted, current_op stays at VIRTCHNL_OP_ADD_ETH_ADDR
> (it is only restored on an error return), and the filters have already had
> f->add cleared during packing.  iavf_poll_virtchnl_response() then polls a
> shut-down queue where iavf_clean_arq_element() returns IAVF_ERR_QUEUE_EMPTY
> every iteration (hw->aq.arq.count == 0) for the full 2500 ms under
> netdev_lock, and returns -EAGAIN.
>
> The comment in iavf_set_mac() says "the message was sent and PF will
> eventually respond" and skips the rollback, so hw.mac.addr keeps the new
> address while netdev->dev_addr keeps the old one, and current_op stays armed
> so every later command hits "Cannot add filters, command %d pending" until
> the watchdog's comm-failed path clears it.
>
> The window looks reachable: iavf_disable_vf() sets the flag, shuts the admin
> queue down, clears the reset flag and ends with __IAVF_DOWN:
>
>     adapter->flags |= IAVF_FLAG_PF_COMMS_FAILED;
>     ...
>     iavf_shutdown_adminq(&adapter->hw);
>     adapter->flags &= ~IAVF_FLAG_RESET_PENDING;
>     iavf_change_state(adapter, __IAVF_DOWN);
>
> while iavf_set_mac() only rejects state < __IAVF_DOWN and
> iavf_is_reset_in_progress().  Should the synchronous path check
> IAVF_FLAG_PF_COMMS_FAILED before sending and polling?

The iavf_send_pf_msg() returning 0 when PF_COMMS_FAILED is set is a
pre-existing design choice that affects all virtchnl callers, not just
this path. The scenario requires the PF to be unresponsive
(iavf_disable_vf() has run), the VF is non-functional at that point.
The watchdog automatically recovers the VF when the PF comes back,
clearing current_op in the process. Changing MAC on a non-functional
VF is not a normal operation.

> [Severity: Low]
> Can this function ever return the documented "error code"?  ret is only ever
> -EAGAIN or 0, and the status from iavf_clean_arq_element() (for example
> IAVF_ERR_ADMIN_QUEUE_ERROR for a descriptor with LIBIE_AQ_FLAG_ERR, or
> IAVF_ERR_QUEUE_EMPTY for an uninitialised ARQ) is compared against
> IAVF_SUCCESS and then dropped.
>
> The other poller on the same queue in this file does the opposite:
>
> iavf_poll_virtchnl_msg()
>     status = iavf_clean_arq_element(hw, event, NULL);
>     if (status != IAVF_SUCCESS)
>         return iavf_status_to_errno(status);
>
> Since iavf_set_mac() keys its rollback decision on ret != -EAGAIN, reporting
> admin queue errors as a plain timeout also feeds the "message was sent"
> assumption.  Could the kernel-doc and the implementation be brought in line,
> one way or the other?

The function returns 0 on success or -EAGAIN on timeout. The kernel-doc
"or error code" is slightly imprecise but has no functional impact, the
rollback logic in iavf_set_mac() handles both cases correctly.

> [Severity: Medium]
> What happens to this loop if a VF reset starts while it is polling?  There is
> no device-in-reset check, no IAVF_FLAG_PF_COMMS_FAILED re-check and no
> sanity check on the ARQ head, unlike iavf_adminq_task():
>
>     val = rd32(hw, IAVF_VF_ARQLEN1);
>     if (val == 0xdeadbeef || val == 0xffffffff) /* device in reset */
>         goto freedom;
>
> and unlike iavf_poll_virtchnl_msg(), which returns -EIO on
> VIRTCHNL_EVENT_RESET_IMPENDING.
>
> In iavf_clean_arq_element() the head is masked without a range check:
>
>     ntu = rd32(hw, IAVF_VF_ARQH1) & IAVF_VF_ARQH1_ARQH_MASK;
>
> The mask is 10 bits while num_arq_entries is IAVF_AQ_LEN (32), so a reset
> time read of 0xdeadbeef/0xffffffff yields ntu far outside the ring and
>
>     *pending = (ntc > ntu ? hw->aq.arq.count : 0) + (ntu - ntc);
>
> stays non-zero forever.  In the new loop that means "if (!pending)" never
> sleeps and "if (pending) continue;" keeps going, so it degenerates into a
> tight rd32 / 4 KiB memcpy / tail write / 4 KiB memset spin with no
> cond_resched() until the timeout expires, consuming descriptors firmware
> never posted and feeding stale contents into iavf_virtchnl_completion().
>
> All of that runs holding netdev_lock, which iavf_reset_task() and
> iavf_adminq_task() both need:
>
> iavf_reset_task()
>     netdev_lock(netdev);
>     iavf_reset_step(adapter);
>
> so reset recovery is delayed for up to 2.5 s, and since adapter->wq is an
> ordered workqueue the other iavf work items queue up behind it.
> iavf_set_mac() samples iavf_is_reset_in_progress() only once on entry, and
> nothing can update those flags while the poll holds the lock, so there is no
> way out of the loop early.  Should the loop bail out on the reset register
> pattern and on RESET_IMPENDING events?

The poll loop is bounded to 2.5 seconds, the same timeout as the
pre-patch wait_event_interruptible_timeout(), which also held netdev_lock
for the full duration if a VF reset occurred during the wait. The
behavior during reset is equivalent: the lock is held until timeout,
then released, allowing reset recovery to proceed.

The synchronous polling is a change in mechanism, not in behavior.

> [Severity: Low]
> Should this use event->buf_len rather than the hardcoded
> IAVF_MAX_AQ_BUF_SIZE?  struct iavf_arq_event_info expresses the size of
> msg_buf via buf_len, and iavf_clean_arq_element() honours it:
>
>     e->msg_len = min(datalen, e->buf_len);
>
> The only caller today, iavf_set_mac_sync(), allocates exactly
> IAVF_MAX_AQ_BUF_SIZE, so nothing overruns right now.  But the helper is
> exported in iavf.h and its kernel-doc invites reuse "for any future
> synchronous virtchnl operations", and other virtchnl call sites such as
> iavf_get_vf_supported_rxdids() and iavf_get_vf_ptp_caps() use much smaller
> event buffers.  Any such caller would get a 4 KiB out-of-bounds zeroing
> write into the heap.

The only caller allocates IAVF_MAX_AQ_BUF_SIZE, no issue today. A
hypothetical future caller would need to match the allocation to the
memset. Not a bug, just defensive coding for a reuse scenario that
doesn't exist.

