Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF9C4DD3DA;
	Wed, 16 Sep 2026 20:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789591551; cv=none; b=qdzzuy1GID6d7tRNKuleu2bbppPeI0R9hcO3CiU6TLABXSf6WdUM5y3er5KfpS8TI9jaawETzZEEGysCKh0HrHdjEg34TDraOq5NqPBFi1mW9wdXAIi+uK8gW90SGWELjypsOO9olJZ6Ri9Q9p90DZJqG9wum7Gel017++feHrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789591551; c=relaxed/simple;
	bh=CWKuP5r8xDTe6E0qb7CyJ+VJFunqCa1RY3vZrTo+tmY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C6JT/d2cR6aTtsQ3IJpKhMNlHG8OLcx+SHp1s3BDh9ble3j/9+Qy76/sH3QAJArsK4z4cts4krkoFScqU3iiWL3Y0DC5z226HuHfySh+//CE/7Xbfi+QpL9DtaDDTrdFQSn9qQ+GgGrGHg/eW2RHtQXVswwIxAhEeobXapFnEO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GmQZ/0Gu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GmQZ/0Gu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6735E1F000FF;
	Wed, 16 Sep 2026 20:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789591536;
	bh=JENMVUe9HN/FgEP03O39GozF7pCmLG3+StFuKHHviLk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GmQZ/0Guo2nM7SdlmGlE+oDalH+m9A/YsSgcaa7FCjj98s6AsfifOcnT1imR6OP5x
	 UklXWtSPGxkKhPlh1z/103cMwqn0Gxenq8mOBwrzqh3B7VxNe4ueF+7/oTXb4IIN3n
	 v5J4dMbioV6zcAXc5QQFohDjhDQKLdLiaBwIdMNrG+p99tJd8D712B/ydJUEOGYqpa
	 n2fcLywX84h9zgvF3xhEO6Sqgo+OqaaeT3F0ITiXt53y6310rDh9w0w4C12bKDus4w
	 pzeRR6Pn9ZopSTpQzLaT5iD82vt/u0zUyWXxIau+vMDxlszLMlly7B9QoG84a2NV5c
	 kZHHQ+gpFrUyg==
Subject: Re: [PATCH net 1/2] mptcp: avoid unneeded actions on subflow reset
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, stable@vger.kernel.org,
 shardul.b@mpiricsoftware.com, xinyang@anthropic.com
Date: Wed, 16 Sep 2026 20:45:34 +0000
Message-ID: <178959153492.22033.1944011998010756543@kernel.org>
In-Reply-To:
 <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-1-a257797dd5d0@kernel.org>
References:
 <20260915-net-mptcp-misc-fixes-7-3-rc4-v1-1-a257797dd5d0@kernel.org>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 2 · Medium: 1 · Low: 0

- [High] The new unconditional `if (subflow->resetting) return;` in
  subflow_state_change() (net/mptcp/subflow.c:1891) removes the last…
- [High] mptcp: data race in bitfield resetting and close_event_done
- [Medium] The new early return in subflow_state_change()
  (net/mptcp/subflow.c:1891) is justified by an in-code comment claiming…

--

mptcp: avoid unneeded actions on subflow reset

This adds a new subflow->resetting bit, set in mptcp_subflow_reset() before
tcp_done(), and uses it to return early from subflow_state_change() so the
nested mptcp_data_ready() recursion is broken. The early return also skips
the data-available check, the error report and subflow_sched_work_if_closed().

> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
> index 01db7edce18a6..cbe227d218449 100644
> --- a/net/mptcp/subflow.c
> +++ b/net/mptcp/subflow.c
> @@ -438,6 +438,7 @@ void mptcp_subflow_reset(struct sock *ssk)
>  	/* must hold: tcp_done() could drop last reference on parent */
>  	sock_hold(sk);
>  
> +	subflow->resetting = 1;
>  	mptcp_send_active_reset_reason(ssk);
>  	tcp_done(ssk);
>  	if (!test_and_set_bit(MPTCP_WORK_CLOSE_SUBFLOW, &mptcp_sk(sk)->flags))

[Severity: High]
The new bit is carved out of the same 32-bit bitfield word as
closeing/close_event_done/mpc_drop, and a C bitfield store is a
read-modify-write of that whole word, not of the single bit.  So the
question is whether that word is only ever written under one lock.

mptcp_subflow_reset() now writes subflow->resetting.  On the
mptcp_mp_fail_no_response() path the caller is mptcp_worker(), which
holds the msk socket lock and then lock_sock_fast(ssk), so both locks
are held.  But the DSS-corruption path -- mptcp_dss_corruption() ->
mptcp_subflow_reset() -- runs from get_mapping_status() /
mptcp_subflow_data_available() in the ssk receive path, i.e. with only
the subflow socket lock (and possibly in BH context).  Meanwhile
mptcp_close_ssk() writes subflow->close_event_done = true holding only
the msk socket lock.  Those two locks do not exclude each other, so
the two load/or/store sequences can interleave on the same word.

If the msk-side store wins, the resetting = 1 store is silently
dropped, subflow_state_change() takes the old path and we are back to
the recursive mptcp_data_ready() and the data lock re-acquisition this
patch is meant to break -- the failure mode is the same deadlock, just
rarer and harder to reproduce.  If the reset-side store wins,
close_event_done is lost and the post-close event handling runs twice.
KCSAN should be able to flag this write/write pair.

Is there serialization here that I am missing for the
mptcp_dss_corruption() caller?  If not, would you consider keeping
resetting out of the msk-owned bitfield word -- a plain bool next to
data_avail/scheduled, or a bit in a flags word updated with set_bit()
-- so that setting it under the ssk lock cannot clobber bits owned by
the msk lock?

[ ... ]

> @@ -1883,6 +1884,13 @@ static void subflow_state_change(struct sock *sk)
>  
>  	__subflow_state_change(sk);
>  
> +	/* Rx queue processing is unneeded, error reporting will take place at
> +	 * __mptcp_close_ssk() time and subflow reset can't happen in case of
> +	 * fallback: subflow_sched_work_if_closed() would be a no-op.
> +	 */
> +	if (subflow->resetting)
> +		return;
> +

[Severity: High]
Can a reset subflow with a non-empty ssk->sk_receive_queue still get
cleaned up after this early return?

mptcp_subflow_reset() calls tcp_done(ssk), and tcp_set_state(TCP_CLOSE)
unhashes the socket, so subflow_data_ready() cannot fire again for this
ssk.  That makes the tcp_done() -> sk_state_change() ->
subflow_state_change() path the last remaining entry into
mptcp_subflow_data_available() for this subflow, and the new return skips
it.

The flush that exists for exactly this case lives in validate_data_csum():

net/mptcp/subflow.c:validate_data_csum() {
	...
	if (skb_queue_is_last(&ssk->sk_receive_queue, skb)) {
		/* if this subflow is closed, the partial mapping
		 * will be never completed; flush the pending skbs, so
		 * that subflow_sched_work_if_closed() can kick in
		 */
		if (unlikely(ssk->sk_state == TCP_CLOSE))
			while ((skb = skb_peek(&ssk->sk_receive_queue)))
				sk_eat_skb(ssk, skb);

		/* not enough data to validate the csum */
		return MAPPING_EMPTY;
	}
	...
}

With the skbs left in place, does __mptcp_close_subflow() keep skipping
the subflow forever?

net/mptcp/protocol.c:__mptcp_close_subflow() {
	...
		/* 'subflow_data_ready' will re-sched once rx queue is empty */
		if (!skb_queue_empty_lockless(&ssk->sk_receive_queue))
			continue;

		mptcp_close_ssk(sk, ssk, subflow);
	...
}

mptcp_worker() has already cleared MPTCP_WORK_CLOSE_SUBFLOW at that point,
and recvmsg() only spools msk->backlog_list in mptcp_move_skbs() /
__mptcp_move_skbs(), so it never touches ssk->sk_receive_queue.

A concrete path with net.mptcp.checksum_enabled=1: a bad DSS csum arms
subflow->fail_tout in mptcp_subflow_fail(); a later partially received
mapping returns MAPPING_EMPTY leaving skbs queued on msk->first; the
MP_FAIL echo never arrives, so mptcp_worker() calls
mptcp_mp_fail_no_response():

net/mptcp/protocol.c:mptcp_mp_fail_no_response() {
	...
	slow = lock_sock_fast(ssk);
	mptcp_subflow_reset(ssk);
	WRITE_ONCE(mptcp_subflow_ctx(ssk)->fail_tout, 0);
	unlock_sock_fast(ssk, slow);
}

fail_tout is then cleared, and since __mptcp_close_ssk() is never reached,
mptcp_start_tout_timer() is never called either.  Does that leave the msk
in TCP_ESTABLISHED with its only, dead subflow, no pending timer, and a
reader blocked in mptcp_recvmsg() that is never woken with EOF or an
error?

The same early return also appears to leave reset join subflows (the
'reset:' label in check_fully_established() and __mptcp_flush_join_list())
with their context and queued skbs pinned on msk->conn_list.

For reference, the DSS-corruption path itself looks unaffected, because
__mptcp_move_skbs_from_subflow() re-calls mptcp_subflow_data_available(ssk)
in its own loop.

[Severity: Medium]
The comment states "subflow reset can't happen in case of fallback:
subflow_sched_work_if_closed() would be a no-op".  Is that premise
enforced anywhere?

mptcp_mp_fail_no_response() resets msk->first purely on fail_tout expiry,
with no __mptcp_check_fallback() test.  fail_tout is armed by
mptcp_subflow_fail() while the msk is not yet in fallback, and nothing
seems to clear it when a later fallback succeeds: __mptcp_try_fallback()
only touches allow_subflows / MPTCP_FALLBACK_DONE, and the pm.c side clears
fail_tout only on an MP_FAIL echo.

With net.mptcp.checksum_enabled=1: a middlebox mangles the MPTCP options,
MAPPING_BAD_CSUM with valid_csum_seen sends MP_FAIL and arms
fail_tout = jiffies + TCP_RTO_MAX; the echo never arrives; a subsequent
MAPPING_NODSS on the same first subflow makes mptcp_try_fallback() succeed,
so MPTCP_FALLBACK_DONE is set while fail_tout is still armed.  The tout
timer then runs mptcp_worker() -> mptcp_mp_fail_no_response() ->
mptcp_subflow_reset(msk->first) with __mptcp_check_fallback(msk) true.

In that state tcp_done() sets SHUTDOWN_MASK/TCP_CLOSE, so subflow_is_done(ssk)
is true and msk->first == ssk, which is precisely the branch that is not a
no-op:

net/mptcp/subflow.c:subflow_sched_work_if_closed() {
	...
	/* when the fallback subflow closes the rx side, trigger a 'dummy'
	 * ingress data fin, so that the msk state will follow along
	 */
	if (__mptcp_check_fallback(msk) && subflow_is_done(ssk) &&
	    msk->first == ssk &&
	    mptcp_update_rcv_data_fin(msk, subflow->map_seq +
				      subflow->map_data_len, true))
		mptcp_schedule_work(sk);
}

Skipping that call means mptcp_update_rcv_data_fin() is never invoked, the
msk never moves to CLOSE_WAIT/RCV_SHUTDOWN, and blocked readers get no EOF
until the close timeout (net.mptcp.close_timeout, 60 s by default) fires
and mptcp_do_fastclose() sets TCP_CLOSE and purges the backlog instead of
delivering a clean EOF.  Should the comment be qualified, or should the
check be narrowed so the fallback DATA_FIN injection still runs?

>  	/* as recvmsg() does not acquire the subflow socket for ssk selection
>  	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
>  	 * the data available machinery here.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260915-net-mptcp-misc-fixes-7-3-rc4-v1-0-a257797dd5d0%40kernel.org
