Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2335678CD;
	Wed,  9 Sep 2026 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788965376; cv=none; b=o8s2wrS3AiZyNg/1J3TPlJZcalAnmYb4ocM+hNsdlObQw9fs1ejy6Kn7K6QiuAsJIYtJClgV3VSQBEDzvrKYRts8ychWVEW3oisjz8A1aGzKuTY4Ari2GLm773gaGDpjpOg2HyiekN7WQaH+/8o4pxWIPdao4OO6j0Sin4Bo8HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788965376; c=relaxed/simple;
	bh=svpvyxJoOYUE/p2bOahdn8UH/V4ch+OGO34T3F3HdRM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VDQAGUMk0LSN31IJqnftjWousQhogKLp6xa6HDkPif2qvl8PCbXCIDj1BC5PpbQSBddUjdocLoPP5GtKyyRotQ5Pmmve64GITBq40gEvI+Br88j4tCaT/U6OdxLq9GuN5ayle474wVsYjqCJLG9PrNdXXy1zG4Oi0uwjYSPiTWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fWRmHeWG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fWRmHeWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5323C1F00A3D;
	Wed,  9 Sep 2026 14:49:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788965375;
	bh=f6LHlJ+/3Z7eUFdi6OJakO12BixT7sX6bMAx2KkmAW8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=fWRmHeWG4lF/gHBsS9RuLl4MAL+yj55IAp7Y/pXV4YFDYtNMLHWr0ekhMIXbQBTzz
	 6ecNFsJharINhTPFvEh7tl7A8VzvDnGxCuYNygxMukvKHhtGT567EnxbaYsWMDoNGi
	 XiJYTLuuJs7Q4qx4iLORniH7zYLSIQZoyoimqvwywzM2Y3v0dOz63gRUmsnYk2PGTE
	 TpXGO1EiSqPfbiZl3/wQ/5nPkLC7MZl5DGm9aIIgvmJ51s3Ko/XcHc6WTvadySjqwf
	 6XrWpQBfG6r2wnAufNHcdCBIWDzpeb9h7f6Rp3WCmrGHJuJQeYsnzxYez61P2oGv1x
	 BBfOMRH7suT2Q==
Subject: Re: [PATCH net v2 04/15] mptcp: pm: kernel: drop pending ADD_ADDR
 when removing ID0
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Wed, 09 Sep 2026 14:49:33 +0000
Message-ID: <178896537388.219967.5173915953995910937@kernel.org>
In-Reply-To:
 <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-4-df1de70348b6@kernel.org>
References:
 <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-4-df1de70348b6@kernel.org>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 1 · Low: 0

- [High] Incomplete fix: in mptcp_nl_remove_id_zero_address()
  (net/mptcp/pm_kernel.c) the new cleanup forces `anno_addr.port = 0`…
- [Medium] Newly introduced wrong-entry teardown in
  mptcp_nl_remove_id_zero_address() (net/mptcp/pm_kernel.c:1152-1157):…

--

mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0

This makes the in-kernel path manager's id 0 removal path symmetric with the
non-zero id path by dropping a pending ADD_ADDR announcement and decrementing
add_addr_signaled before queuing the RM_ADDR.  The lookup key is the msk local
address with the port forced to 0.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/620

> diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
> index 424f1a7f9248..1a7750813235 100644
> --- a/net/mptcp/pm_kernel.c
> +++ b/net/mptcp/pm_kernel.c
> @@ -1137,6 +1137,8 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
>  	while ((msk = mptcp_token_iter_next(net, &s_slot, &s_num)) != NULL) {
>  		struct sock *sk = (struct sock *)msk;
>  		struct mptcp_addr_info msk_local;
> +		struct mptcp_addr_info anno_addr;
> +		bool announced;
>  
>  		if (list_empty(&msk->conn_list) || mptcp_pm_is_userspace(msk))
>  			goto next;
> @@ -1146,7 +1148,13 @@ static int mptcp_nl_remove_id_zero_address(struct net *net,
>  			goto next;
>  
>  		lock_sock(sk);
> +		/* Drop a possibly pending ADD_ADDR for this address. */
> +		anno_addr = msk_local;
> +		anno_addr.port = 0;
> +		announced = mptcp_pm_announced_remove(msk, &anno_addr);

[Severity: High]
Does zeroing the port here make the lookup miss the announcements this
patch is meant to remove?

The commit message says:

    Subtle detail: signal endpoints are stored in anno_list with port 0, but
    msk_local carries the connection's local port. In other words, entries
    linked to ID0 paths should have port == 0. A follow-up patch will ensure
    that.

Since that invariant does not exist yet, a SIGNAL-only endpoint keeps its
port.  mptcp_pm_nl_append_new_local_addr() only clears it when
address_use_port() is false:

	if (!address_use_port(entry))
		entry->addr.port = 0;

and address_use_port() returns true for SIGNAL-without-SUBFLOW endpoints.
mptcp_pm_create_subflow_or_signal_addr() then copies that endpoint verbatim
from select_signal_address() and only rewrites the id:

		endp_id = local.addr.id;
		if (endp_id == msk->mpc_endpoint_id)
			local.addr.id = 0;

		if (!mptcp_pm_announced_alloc(msk, &local.addr))
			return;

so the anno_list entry can be {A, port P, id 0}.  The removal side compares
with the port:

net/mptcp/pm.c:mptcp_pm_announced_lookup() {
	list_for_each_entry(entry, &msk->pm.anno_list, list) {
		if (mptcp_addresses_equal(&entry->addr, addr, true))
			return entry;
	}
}

msk_local is A:P and would have matched that entry exactly, but the zeroed
key does not.  In that case announced stays false, the entry stays linked and
add_addr_signaled is never decremented.

__mark_subflow_endp_available(msk, 0) then re-sets the endpoint's id bit, so
after another signal endpoint is added the PM reselects the same endpoint,
rewrites its id to 0, and mptcp_pm_announced_alloc() still finds the stale
entry:

net/mptcp/pm.c:mptcp_pm_announced_alloc() {
	add_entry = mptcp_pm_announced_lookup(msk, addr);
	if (add_entry) {
		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
			return false;
}

Is the syzbot-reported warning therefore still reachable for port-based
signal endpoints, both here and in the stable backport of this patch alone?
A diff over the rest of the series shows nothing later touches
mptcp_nl_remove_id_zero_address() or normalizes anno_list ports.

Would matching on the entry id 0, or passing msk_local unmodified, be closer
to what the non-zero id path does?

> +		spin_lock_bh(&msk->pm.lock);
> +		if (announced)
> +			msk->pm.add_addr_signaled--;
>  		mptcp_pm_remove_addr(msk, &list);

[Severity: Medium]
Can the address-only key match and free the pending ADD_ADDR of a different
endpoint?

mptcp_pm_announced_remove() passes check_id=false, and in that case the id of
the found entry is never verified before it is unlinked and freed:

net/mptcp/pm.c:mptcp_pm_announced_del_timer() {
	entry = mptcp_pm_announced_lookup(msk, addr);
	if (entry && (!check_id || entry->addr.id == addr->id)) {
		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
		stop_timer = true;
	}
	if (!check_id && entry)
		list_del(&entry->list);
}

Two endpoints with the same IP can coexist when they differ only by port,
because mptcp_pm_nl_append_new_local_addr() compares them with:

		if (mptcp_addresses_equal(&cur->addr, &entry->addr,
					  cur->addr.port || entry->addr.port)) {

So with E1 = {A, port P, SIGNAL} as the msk's mpc/ID0 endpoint and
E2 = {A, port 0, SIGNAL, id N} owning a pending announcement stored as
{A, port 0, id N}, the zeroed key matches E2's entry and destroys it.  The
same happens if msk->mpc_endpoint_id stayed 0 because no endpoint matched
when mptcp_mpc_endpoint_setup() ran.

The RM_ADDR queued right below carries only id 0 (list.ids[0] = 0), so the
peer is never told about id N.  __mark_subflow_endp_available(msk, 0) only
sets the bit for msk->mpc_endpoint_id:

	if (!__test_and_set_bit(id ? : msk->mpc_endpoint_id, msk->pm.id_avail_bitmap) &&

so id N stays cleared in id_avail_bitmap and is never re-announced, and a
later DEL_ADDR of endpoint N takes mptcp_pm_remove_announced() with
announced == false.  Do the local and peer views of announced addresses
diverge permanently in that case?

The peer call site keeps the key and the signalled id paired:

net/mptcp/pm_kernel.c:mptcp_pm_remove_announced() {
	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);

	announced = mptcp_pm_announced_remove(msk, addr);

Would matching on the entry's id 0 instead of a fabricated port preserve
that pairing here too?  The id 0 path touched no anno_list entry before this
patch, and this collateral teardown is not covered in the commit message.

>  		mptcp_pm_rm_subflow(msk, &list);
>  		__mark_subflow_endp_available(msk, 0);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6%40kernel.org
