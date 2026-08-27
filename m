Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCA4429028;
	Thu, 27 Aug 2026 19:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857652; cv=none; b=lInVx8jzEiZejxMnHBVbRr4EvNpAF95wOws5SJ1PRv13xXCrNQMU3qfXwW/8uI1w4Dct/mWkz0u4zsDbILZNz7/fVkF2XYn3tRJt67pxqUka06zyypQUxCRU1VuoTPav9wUcREHkpVIv8SBNVBlfLyrDQJ44vCHiQnPRaRHAnmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857652; c=relaxed/simple;
	bh=YpYSES87WPrgAdE7OrzEO6FtBE+7w8+kLhZwaOxLLJc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l347oThg3bxTDYp5qwKlnidKkblERhbRjUfd00kADoxvt1RqgV+2qmSNZQKB+KeS84cT6CMTTPK+iBSCP+CChfqSw8b9EUaWW2xCM6QA3FR4pGTQCxcPMimBJQFJQbl9xoMK33UUTH6Pc+G305G0hj6zegTvqjZX2Hh5nyVK3M8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YU+ce9Tn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YU+ce9Tn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF90C1F00A3D;
	Thu, 27 Aug 2026 19:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787857647;
	bh=vIQJNH2KLqYBzZvmfQ5tpu5nrmZ5vzmiIncZrLnScqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YU+ce9TnejCuIOPtUC0NIl7jqYHK+iQv4059Ruuj8LkA0Ic15CM4f5hXddG4Od97m
	 hVf9DaWBG9Dohto9l/2l/OhND5/CDnxyDMy9uhwAS9JlB/MQuKxeaLj2O//piZ+5zd
	 IJTG9hBizPOa5nGge6Rw78fwotV/gxefC91jIhcZzf7mglw3bJ6glhV6wjvMdOofEK
	 Bcv+PYhBf5X4LKZXne26ZB6RD5HCUH4He3E6sf65rTiCE5sIMuGRxNU45rHTSAbz7R
	 HBbEQxQ1g6lRCJCuhAM/6EhIJClaudCqM3QlzWU327M6Dh0+nM8IrGCVp6e4vmY7+7
	 0bmZxLc6133+Q==
From: Jakub Kicinski <kuba@kernel.org>
To: matttbe@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	martineau@kernel.org,
	geliang@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 04/14] mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0
Date: Thu, 27 Aug 2026 12:07:26 -0700
Message-ID: <20260827190726.3998256-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-4-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-4-a92309d121ca@kernel.org>
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
mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0

This makes the in-kernel path manager's id 0 removal path tear down a
pending ADD_ADDR announcement, matching what the non-zero id path already
does, and decrements pm.add_addr_signaled when an entry was removed.
The lookup key is built from the msk local address with the port forced to
zero.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/620

A few questions on the changelog and on the new lookup key.

> When the PM later reselects id 0 after adding another signal endpoint, it
> finds the stale anno_list entry and hits WARN_ON_ONCE(mptcp_pm_is_kernel())
> in mptcp_pm_alloc_anno_list().
>
> Root cause: asymmetry between removal paths.
> - Non-zero id path: mptcp_nl_remove_subflow_and_signal_addr() calls
>   mptcp_pm_remove_anno_addr() to clean up.

[Severity: Low]
Do these two helper names exist in this tree?  Grepping for
mptcp_pm_alloc_anno_list and mptcp_pm_remove_anno_addr at this commit
returns no matches.

The WARN_ON_ONCE(mptcp_pm_is_kernel(msk)) described here lives in
mptcp_pm_announced_alloc() in net/mptcp/pm.c, and the non-zero id path
calls mptcp_pm_remove_announced() from
mptcp_nl_remove_subflow_and_signal_addr() in net/mptcp/pm_kernel.c.

The mechanism described looks right, so should the names be updated to the
current spelling?

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 424f1a7f92482..1a77508132354 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c

[ ... ]

> @@ -1146,7 +1148,13 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
>  			goto next;
>  
>  		lock_sock(sk);
> +		/* Drop a possibly pending ADD_ADDR for this address. */
> +		anno_addr = msk_local;
> +		anno_addr.port = 0;
> +		announced = mptcp_pm_announced_remove(msk, &anno_addr);

[Severity: Medium]
This isn't a bug introduced by this patch, since before it the id 0 path
removed no announcement at all, but does forcing the port to zero here miss
signal endpoints that carry a port?

The commit message says:

	Subtle detail: signal endpoints are stored in anno_list with port 0

Is that always true?  mptcp_pm_nl_add_addr_doit() explicitly accepts a
non-zero port for signal-only endpoints:

	if (addr.addr.port && !address_use_port(&addr)) {
		NL_SET_ERR_MSG_ATTR(info->extack, attr,
				    "flags must have signal and not subflow when using port");

and mptcp_pm_nl_append_new_local_addr() only zeroes the port when
!address_use_port(), so an endpoint A:P can end up announced as A:P in
anno_list.  mptcp_pm_announced_lookup() always compares the port:

net/mptcp/pm.c:mptcp_pm_announced_lookup() {
	list_for_each_entry(entry, &msk->pm.anno_list, list) {
		if (mptcp_addresses_equal(&entry->addr, addr, true))
			return entry;
}

For an msk accepted on an MPTCP listener bound to A:P, msk_local is A:P and
mptcp_mpc_endpoint_setup() -> __lookup_addr() can match that endpoint
(use_port = entry->addr.port), so mpc_endpoint_id becomes its id and the
announcement is stored with port P.

In that case the port-zeroed key never matches, announced stays false and
the entry stays linked, while __mark_subflow_endp_available(msk, 0) still
re-arms the mpc_endpoint_id bit.  On the next pass select_signal_address()
reselects that endpoint (port-carrying endpoints are put at the head of
endp_list by mptcp_pm_nl_append_new_local_addr()), and
mptcp_pm_announced_alloc() finds the surviving entry:

net/mptcp/pm.c:mptcp_pm_announced_alloc() {
	add_entry = mptcp_pm_announced_lookup(msk, addr);
	if (add_entry) {
		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
			return false;

Is that the same splat the patch is meant to remove, and would a
port-insensitive lookup (or a second lookup with the original port) close
this case too?

>  		spin_lock_bh(&msk->pm.lock);
> +		if (announced)
> +			msk->pm.add_addr_signaled--;
>  		mptcp_pm_remove_addr(msk, &list);

[Severity: Medium]
Can the entry freed here belong to a different id than the RM_ADDR that is
queued right after?

mptcp_pm_announced_remove() passes check_id == false, so
mptcp_pm_announced_del_timer() unlinks whatever address matches, regardless
of the announced id:

net/mptcp/pm.c:mptcp_pm_announced_del_timer() {
	entry = mptcp_pm_announced_lookup(msk, addr);
	if (entry && (!check_id || entry->addr.id == addr->id)) {
	...
	if (!check_id && entry)
		list_del(&entry->list);
}

while mptcp_nl_remove_id_zero_address() always queues id 0:

	list.ids[list.nr++] = 0;

With a signal endpoint A:P (id M) matched as mpc_endpoint_id, and a second
signal endpoint A with port 0 (id N), mptcp_pm_create_subflow_or_signal_addr()
keeps id N because endp_id != mpc_endpoint_id:

	endp_id = local.addr.id;
	if (endp_id == msk->mpc_endpoint_id)
		local.addr.id = 0;

so anno_list holds {A, port 0, id N}.  A following del id 0 A matches this
msk and the port-zeroed, id-agnostic lookup frees that id N entry and
decrements add_addr_signaled for it, while the peer is only told id 0 was
removed.

If endpoint N is deleted later at a moment when no subflow in conn_list has
saddr A, mptcp_pm_remove_announced() sees announced == false and force ==
false, so no RM_ADDR is sent:

	announced = mptcp_pm_announced_remove(msk, addr);
	if (announced || force) {

Does the peer then keep advertising that address indefinitely?  The commit
message describes the change only as making the id 0 path symmetric and does
not mention this cross-id effect.

>  		mptcp_pm_rm_subflow(msk, &list);
>  		__mark_subflow_endp_available(msk, 0);
