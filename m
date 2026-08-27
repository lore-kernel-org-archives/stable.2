Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 740C54DBD6B;
	Thu, 27 Aug 2026 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787857657; cv=none; b=LdskBy5/8X/sTEd1g0N0qn10HBY5CXDzBssblH6oXdQVhz9Io1IACRom/ExHnnOWbsxTzMd3De+sTWaHRn6ZxqDxURC+yObSdOmtDA5huNzymSAo5vFjVo7ZI3zvFGVphWUJQBzdjij6K2H3nN/3YcWPpAiZA1Y7YzHXbFC3JA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787857657; c=relaxed/simple;
	bh=KkdxcIZKprn2SFoi+QLVfX4qZUuOLk0CJyhIUgbyh8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AoOhXcwaAfwGgcsMl8XNxZvJdobrcEika1jJbfboimpjZDFYB44FbIf5WXKFTSREtdgE8tVLuTi0kNKE/+6Y/3MkOi3o6OKc70gZhY2xEsPqgH4Ug7PqdsvIcXFO+AClgc9a0/cGr8BaKzN9q+iIA+uW/PsFHhnQQjRYkCu1sCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Si0YVzBe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Si0YVzBe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE671F000E9;
	Thu, 27 Aug 2026 19:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787857649;
	bh=C8VpFOlmPgffnFEeX8nl5YuUn5qSwQ0vYhndKu61bvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Si0YVzBe90Bo6kyWp/sK37715ykrLbOvSo9HnYmzKA1AsiW9+q2MVkNvKF15JfvlZ
	 fxFmCyLimA9VAxgypmcWkd3UHi/h+iXgGUqdoXjgmrZy6iVSyVG7Xdpe50una8VkuJ
	 Wrg+1YnxWa06CsET/F1QTK6yYmSqKpHzG0QRn/XHEAEewbVvmBJGO/ykHyyTbUCuh8
	 lRXBy+Njms89v9AloiHGZRrB41X2ljpUrIsbuAF0Rj6TvDQ2DboED7gBIo6AyhJw5Q
	 gwbnd2dOeDiRFNR28O+EK5r+Q0QpW5jLEn6O3U8Ozoq547ul3jEecLUaXp245+FVg/
	 WMiODP8DUE58g==
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
Subject: Re: [PATCH net 08/14] mptcp: pm: reset retrans_time when ADD_ADDR entry is reused
Date: Thu, 27 Aug 2026 12:07:28 -0700
Message-ID: <20260827190728.3998323-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-8-a92309d121ca@kernel.org>
References: <20260824-net-mptcp-misc-fixes-7-3-rc1-v1-8-a92309d121ca@kernel.org>
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
mptcp: pm: reset retrans_time when ADD_ADDR entry is reused

This moves the retrans_times reset from the fresh-allocation path into the
shared reset_timer block of mptcp_pm_announced_alloc(), so a reused
ADD_ADDR entry gets its retransmission budget back when the timer is
re-armed.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260803-net-mptcp-misc-fixes-7-2-rc6-v2-0-b8f496d71664%40kernel.org?part=4

> diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
> index 8b68868255c50..b0b71adefb8fe 100644
> --- a/net/mptcp/pm.c
> +++ b/net/mptcp/pm.c
> @@ -462,10 +462,10 @@ bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
>  
>  	add_entry->addr = *addr;
>  	add_entry->sock = msk;
> -	add_entry->retrans_times = 0;
>  
>  	timer_setup(&add_entry->timer, mptcp_pm_add_addr_timer, 0);
>  reset_timer:
> +	add_entry->retrans_times = 0;
>  	add_entry->timer_done = false;
>  	timeout = mptcp_adjust_add_addr_timeout(msk);
>  	if (timeout)

[Severity: High]
This isn't a bug introduced by this patch, since the reset_timer block
already contained the timer_done = false plus sk_reset_timer() pair, but
since the patch adds another store into exactly this block, is the block
sufficiently serialized against the timer callback?

The reuse path runs from mptcp_pm_nl_announce_doit(), which holds
lock_sock(sk) and msk->pm.lock:

net/mptcp/pm_userspace.c:mptcp_pm_nl_announce_doit() {
	lock_sock(sk);
	spin_lock_bh(&msk->pm.lock);

	if (mptcp_pm_announced_alloc(msk, &addr_val.addr)) {
	...
}

mptcp_pm_add_addr_timer() writes timer_done under bh_lock_sock() only, and
its TCP_CLOSE early-out comes before the sock_owned_by_user() deferral:

net/mptcp/pm.c:mptcp_pm_add_addr_timer() {
	bh_lock_sock(sk);
	if (unlikely(inet_sk_state_load(sk) == TCP_CLOSE))
		goto out;

	if (sock_owned_by_user(sk)) {
		/* Try again later. */
		timeout = HZ / 20;
		goto out;
	}
	...
out:
	if (timeout)
		sk_reset_timer(sk, timer, jiffies + timeout);
	else
		/* if sock_put calls sk_free: avoid waiting for this timer */
		entry->timer_done = true;
	bh_unlock_sock(sk);
	sock_put(sk);
}

In TCP_CLOSE the callback reaches out: with timeout == 0 and stores
timer_done = true even when a process-context task owns the socket, since
lock_sock() only sets the owned flag and bh_lock_sock() still succeeds.
The reuse path does not take slock and the callback does not take pm.lock
around that store, so can the two stores interleave like this?

CPU0 (MPTCP_PM_CMD_ANNOUNCE re-announce, msk in TCP_CLOSE)
mptcp_pm_announced_alloc()
    add_entry->timer_done = false;
    sk_reset_timer()   /* timer becomes pending again */

CPU1 (previously armed timer expiring)
mptcp_pm_add_addr_timer()
    bh_lock_sock(sk);
    inet_sk_state_load(sk) == TCP_CLOSE -> goto out
    entry->timer_done = true;   /* lands after CPU0 re-armed */

That would leave the timer pending with timer_done == true, and teardown
via mptcp_pm_destroy()->mptcp_pm_free_announced_list() skips the sync stop
in that case:

net/mptcp/pm.c:mptcp_pm_free_announced_list() {
	list_for_each_entry_safe(entry, tmp, &free_list, list) {
		if (!entry->timer_done)
			sk_stop_timer_sync(sk, &entry->timer);
		kfree_rcu(entry, rcu);
	}
}

Can the still-queued timer then fire on the freed entry after the RCU
grace period, reading entry->sock and calling sock_put() on it? The
remaining expiry can be as long as the add_addr_timeout value, which is
much longer than a grace period.

For reachability, mptcp_pm_announced_alloc() only rejects
MPTCP_PM_DESTROYING, and mptcp_pm_nl_announce_doit() does no socket-state
check, so an msk sitting in TCP_CLOSE with a live token and an open fd
still reaches the reuse path.

Would stopping the timer (or taking bh_lock_sock()) before re-arming in
the reset_timer block, or moving the TCP_CLOSE check after the
sock_owned_by_user() check in mptcp_pm_add_addr_timer(), close this?

Also noting that no later patch in this series touches net/mptcp/pm.c, so
this state persists at the end of the series.
