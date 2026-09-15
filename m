Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116063C1D63
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 08:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789460207; cv=none; b=ZC7aJkdx2VGOGhE4+5n6RRiHxaKIajKOISoMeUXh5A5Y1CXG1LBgCF9ZiiXx7BHiHBXJniFk0EP94CdKcCTvqTiL7BEV7GjmCd73zkmWWgkXFjNt3caZxSsScOIUkNip2YI+Hk0QPYTsGOlyP/yWNXCb0dUPRdWH3px+dy4EoyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789460207; c=relaxed/simple;
	bh=eSAEogWzs5zUpk6kk6LnRXQCgm8s2AHDkEdyx64jo7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FpKS7Xs3zonGSWfC8ETi2SFG1LpARsQhfq8UYcYdXQczvd8skjlpvyItObzVmlFvIsFF2P5eDBhiST6Y7zMRfq52c6RyyQQn1+KDk3rrfREZOJx1caokVGmbkK/Vbu70NB7IJSHMo+V2fLcEgbkziB4pluJq2SilfuPdDB/3LnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/6C7xQd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/6C7xQd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789460204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eSAEogWzs5zUpk6kk6LnRXQCgm8s2AHDkEdyx64jo7o=;
	b=H/6C7xQdKfavrDZYCQlqfu1UkmMLZTKMZJ1LLd0wv07ormEb+ZzkI86ED5ZnBx1Z4np6lA
	7eCJ8rZzFwsx+h0yJ6aTv6kDrJ1xVndSISuqR2wpOmhARS9vi5paPiFL+/T+f4Om0WL8cM
	7o50yoI2kPuahlebt+a6MLhcyPn/6h0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-4TVNOOonMpucPEx6upVL4Q-1; Tue,
 15 Sep 2026 04:16:42 -0400
X-MC-Unique: 4TVNOOonMpucPEx6upVL4Q-1
X-Mimecast-MFC-AGG-ID: 4TVNOOonMpucPEx6upVL4Q_1789460200
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5412E1865FDD;
	Tue, 15 Sep 2026 08:16:40 +0000 (UTC)
Received: from fedora.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 410D51955F78;
	Tue, 15 Sep 2026 08:16:36 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kuba@kernel.org
Cc: aleksandr.loktionov@intel.com,
	andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jacob.e.keller@intel.com,
	jtornosm@redhat.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	rafal.romanowski@intel.com,
	sdf@fomichev.me,
	stable@vger.kernel.org
Subject: Re: [PATCH net 3/4] iavf: send MAC change request synchronously
Date: Tue, 15 Sep 2026 10:16:34 +0200
Message-ID: <20260915081634.14281-1-jtornosm@redhat.com>
In-Reply-To: <20260824190149.2714547-1-kuba@kernel.org>
References: <20260824190149.2714547-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

All the comments below fall into pre-existing issues, concerns already
addressed in previous versions and comments, out-of-scope items, or extreme
edge cases. No code changes are considered necessary for a new version.
Details for each comment:

> [Severity: Low]
> Is the "timeouts" part accurate? iavf_poll_virtchnl_response() returns
> -EAGAIN on timeout, and iavf_set_mac() explicitly skips the rollback for
> that value.
>
> So on a timeout nothing is rolled back, which is the opposite of what the
> changelog describes (and matches the in-code comment). Could the changelog
> be adjusted to say send errors only?

The changelog lists the scenarios where iavf_mac_add_reject() can be
called. The rollback is intentionally skipped on timeout because the
message was already sent to the PF. The in-code comment explains this
clearly. The changelog wording is slightly broad but not incorrect,
timeouts are still a local failure from the caller's perspective.

> [Severity: Low]
> Now that iavf_add_ether_addrs() reports -EBUSY, -ENOMEM and send failures,
> should the watchdog side caller consume it too? iavf_process_aq_command()
> still discards it and returns 0 unconditionally.

The watchdog path is fire-and-forget by design, it retries on the next
cycle. Propagating errors there would require changing the watchdog state
machine, which is out of scope for this fix. The return value is only
meaningful for the new synchronous caller.

> [Severity: Medium]
> iavf_mac_change_done() ignores v_op and looks only at filter state, while
> iavf_poll_virtchnl_response() calls the predicate after every message it
> processes.
>
> Consider setting an address that already has a filter whose earlier add
> succeeded. Can an unrelated message processed by the poll loop then make
> this return true before the ADD_ETH_ADDR reply arrives?

Same concern addressed in previous comments. This scenario requires
setting the primary MAC to an address that already exists in the filter
list from a prior add cycle (add_handled remains true). This is an
unusual operation. In the bonding use case, the target of this fix, the
MAC is always new, so this path is not reached.

Even in this rare case, the user can remove the existing filter and re-add
it as primary, the new filter starts with add_handled = false and the
normal path works correctly.

> [Severity: Medium]
> Only one batch is sent here. If the just requested primary address ends up
> outside the first batch, can iavf_mac_change_done() ever become true? The
> poll loop has no way to send the next batch, so this would burn the full
> 2500 ms and return -EAGAIN.

Already discussed with Przemek Kitszel in v7 review. The multi-batch
scenario requires more than 200 pending MAC filters on a VF, which is
extremely rare in practice. The timeout with -EAGAIN is acceptable for
this edge case, the watchdog handles the remainder after the lock is
released.

> [Severity: High]
> Can this rollback destroy filters that belong to a different, still
> outstanding request?
>
> iavf_mac_add_reject() walks the whole list. One way to reach it with
> ret == -EBUSY is an ADD_ETH_ADDR batch the watchdog already sent and whose
> reply has not been processed yet. Should the rollback be scoped to the
> address that iavf_set_mac() itself queued?

Same concern addressed in previous comments. This scenario only occurs
when setting the primary MAC to an address that already exists as a
secondary in the filter list, an extremely rare configuration. Even if
the watchdog later sends the MAC to the PF, it is harmless: the MAC is
already configured on the PF, so the redundant ADD_ETH_ADDR has no
adverse effect.

> [Severity: Medium]
> Does the -EAGAIN assumption in the comment above ("the message was sent and
> PF will eventually respond") hold when IAVF_FLAG_PF_COMMS_FAILED is set?
> iavf_send_pf_msg() returns success without posting anything in that case.

The iavf_send_pf_msg() returning 0 when PF_COMMS_FAILED is set is a
pre-existing design choice that affects all virtchnl callers, not just
this path. The scenario requires the PF to be unresponsive
(iavf_disable_vf() has run), the VF is non-functional at that point.
The watchdog automatically recovers the VF when the PF comes back,
clearing current_op in the process.

> [Severity: Medium]
> Is this -EBUSY reachable as a hard failure from the new caller?
>
> iavf_set_mac() runs with the netdev instance lock held, and the only
> context that clears current_op is iavf_virtchnl_completion(). Can "ip link
> set dev X address ..." or bond_enslave() now fail with -EBUSY whenever the
> watchdog has a command in flight?

Same concern addressed in previous comments. Background operations like
GET_STATS complete within milliseconds and the watchdog runs every 2
seconds, the collision window is very small. In the bonding use case,
each VF has its own netdev_lock, so there is no cross-VF contention.

Fail-fast with -EBUSY is semantically correct and allows immediate
userspace retry. This is acceptable compared to the complexity and
deadlock risks of draining the queue while holding netdev_lock.

> [Severity: Medium]
> Is this helper able to roll back a filter whose is_new_mac is already
> cleared?
>
> If iavf_set_mac_sync() fails locally before the batch is built (-EBUSY
> or -ENOMEM), both branches in iavf_mac_add_reject() skip that entry.
> Does the PF then end up with a primary MAC that differs from
> netdev->dev_addr?

Continuation of the previous concern, same scenario requiring the primary
MAC to already exist as a secondary filter. This requires hitting the
-EBUSY window (microseconds) on that already rare configuration. Even
then, the state is recoverable on retry or VF reset.

> [Severity: Medium]
> The kernel-doc promises "or error code", but ret is only ever -EAGAIN or 0,
> and the iavf_clean_arq_element() status is dropped here.
>
> Should that be reported instead of spinning to the -EAGAIN timeout?

The function returns 0 on success or -EAGAIN on timeout. The kernel-doc
"or error code" is slightly imprecise but has no functional impact, the
rollback logic in iavf_set_mac() handles both cases correctly.

> [Severity: High]
> What happens to this loop if a VFR/EMPR lands while it is polling?
>
> With the reset sentinels, 0xdeadbeef & 0x3FF is 751 and 0xffffffff & 0x3FF
> is 1023, both well above hw->aq.num_arq_entries. Can this then "clean"
> descriptors the hardware never produced and busy-spin on MMIO for the
> remaining 2.5 s while holding the netdev instance lock?

The poll loop is bounded to 2.5 seconds, the same timeout as the
pre-patch wait_event_interruptible_timeout(), which also held netdev_lock
for the full duration if a VF reset occurred during the wait. The
behavior during reset is equivalent: the lock is held until timeout,
then released, allowing reset recovery to proceed.

The synchronous polling is a change in mechanism, not in behavior.

> [Severity: Low]
> Should this use event->buf_len rather than the hardcoded
> IAVF_MAX_AQ_BUF_SIZE?

The only caller allocates IAVF_MAX_AQ_BUF_SIZE, no issue today. A
hypothetical future caller would need to match the allocation to the
memset. Not a bug, just defensive coding for a reuse scenario that
doesn't exist.

