Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A22380FE3;
	Mon, 10 Aug 2026 04:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786336686; cv=none; b=KP8FHHB7Zi8UAQfF3J7N0IF6otB3f0BrHSQd7GxxNePpTAalKe41yCw1g9TfNDVsVoyeIz0ABIxbXPHeo5xARBQr79TWC3gGuy8wS+B/jzLEsKc7zBduO6Gk2SJ9bYAon5UpDRLQ7vsSUKki8VqmIHazY4rkmzLZrqH+E2RjCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786336686; c=relaxed/simple;
	bh=k3FDNCcV7Xdy30ackBpClCQfvX7BTUkOGU8n1i+22AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWxfzlx0dn3TuKmw2qyqK1cWdszoKpEcdpq7e1DUdRuH6WaG5/GV9Xulx/xGwN/cgYrzOJJxZEwUg3Enw7PVr61mlRxVE5fuwjpAbTmCiCxJqCZxrU8cOEzEQF1561c0HhDVb5zCa18mP0jreqmhSK9MkLhE4MUqLcwwCuudmC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CRppu4T4; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CRppu4T4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786336685; x=1817872685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k3FDNCcV7Xdy30ackBpClCQfvX7BTUkOGU8n1i+22AA=;
  b=CRppu4T4mB3AcQkBm4COaCborui6tDZZkyd8xrZfMTM4AAuTdOuuQbON
   nTyIaZlRDX1dkplTRkTxLRh82DDkN46CEEMt/5QZY1sJc5jQBlJfGdd5/
   aLMBBnWqo/5vPW6/1DteYxdkZYKbwGJCDFz1SZQ0ImHSXAqO+ka5mk2Hi
   lQShsOOheYmfIOJyYFt35r3OLEHegRydnzys4jZsXH3CoAbYrAWtVQwA4
   V73kZuuZpL/S244qjALtspD+gE6hpgMeeZIvdjqJG2CJJZK9SED61fu58
   wlf4ibnBox6r9+FyT105FFGXJM/e0voU9KnM5DhA9SMPydyjaQ+T8jHd2
   g==;
X-CSE-ConnectionGUID: UpuGYWICSbq5VnuyFwUw6g==
X-CSE-MsgGUID: 8K/A9WpBT0W7AGVZ3qm+Kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11870"; a="97441165"
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="97441165"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2026 21:38:04 -0700
X-CSE-ConnectionGUID: b+Dw/RExSQW5iUFlhWdrKg==
X-CSE-MsgGUID: WFtn2c4qQ0W26lgSdRmFjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,215,1779174000"; 
   d="scan'208";a="267184675"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa005.jf.intel.com with ESMTP; 09 Aug 2026 21:38:01 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id BE14E99; Mon, 10 Aug 2026 06:37:59 +0200 (CEST)
Date: Mon, 10 Aug 2026 06:37:59 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: fy15309206903@gmail.com
Cc: Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: thunderbolt: Mark the connection down when
 bringing it up fails
Message-ID: <20260810043759.GB893316@black.igk.intel.com>
References: <20260809-b4-tbnet-hopid-v1-0-9a8c7f5f0ba9@gmail.com>
 <20260809-b4-tbnet-hopid-v1-2-9a8c7f5f0ba9@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260809-b4-tbnet-hopid-v1-2-9a8c7f5f0ba9@gmail.com>

On Sun, Aug 09, 2026 at 02:28:01AM +0000, Fan Ye via B4 Relay wrote:
> From: Fan Ye <fy15309206903@gmail.com>
> 
> Every failure path in tbnet_connected_work() undoes its own work and
> returns, but none of them clears login_sent/login_received. The
> connection therefore still looks established, and the next
> tbnet_tear_down() takes its main branch and runs the whole teardown a
> second time over work that was already undone:
> 
>   thunderbolt-net 0-1.0 thunderbolt0: failed to allocate Rx HopID
>   thunderbolt 0000:78:00.0: RX ring 1 already stopped
>   WARNING: CPU: 0 PID: 235 at drivers/thunderbolt/nhi.c:773 tb_ring_stop
>    tbnet_tear_down -> tbnet_stop -> __dev_close_many
>   thunderbolt 0000:78:00.0: TX ring 1 already stopped
>   WARNING: CPU: 0 PID: 235 at drivers/thunderbolt/nhi.c:773 tb_ring_stop
> 
> (line 773 is the dev_WARN in tb_ring_stop() as of v6.17, which is what
> this was captured on; it is line 760 in current mainline)
> 
> It stops rings that were never started, which is what the two warnings
> above are, and on a kernel booted with panic_on_warn those are fatal.
> 
> It also releases net->remote_transmit_path. On the HopID mismatch path
> that one was never successfully allocated by this connection - the
> allocator handed out a different id precisely because the wanted one was
> already taken by somebody else - so this hands back an id the connection
> does not own, and it does so silently. The id is then free to be handed
> out again while its owner is still using it.
> 
> Mark the connection as no longer established on those paths. Only
> login_sent is cleared, which is enough for tbnet_tear_down() to leave the
> already unwound state alone; login_received records that the peer has
> logged in with us and carries the transmit path it gave us, and nothing
> on this side can make the peer send that again.
> 
> Skipping that block skips two things that are not just a repeat of the
> unwind. One is the logout request it would have sent to the peer. The
> other is net->remote_transmit_path = 0 at the end of it; that field is
> only read under the same login_sent && login_received guard and the
> peer's next login request overwrites it, so leaving it stale is
> harmless, but it is a clear that no longer happens. The rest of the
> block is either already undone by the unwind that just ran or was never
> done in the first place - the rings are not started and no buffers are
> allocated when the HopID mismatch is hit, and the paths are not enabled
> on any path that reaches err_stop_rings. The parts outside the block -
> carrier off, queue stopped, login stopped, and the state reset at the
> end - keep running as before.
> 
> Clearing login_sent also changes what the peer's next login request
> does: tbnet_handle_packet() re-queues our login work when it sees
> !login_sent, where before it would only have queued connected_work. That
> is the direction I want - it gives the connection a fresh login instead
> of retrying the bring-up on stale state - but it is a behaviour change
> beyond keeping tbnet_tear_down() out of the way.
> 
> Measured on a link between two ASMedia ASM4242 hosts by cycling the
> interface down and up 200 times from one of them over 80 minutes, and
> counting what the kernel logs on both.
> The mismatch is reached on its own during that, no fault injection, and
> both runs were started from a cold boot with no module reloads in
> between. Only the thunderbolt-net module differs between the two:
> 
>                                         without      with
>     failed to allocate Rx HopID          11 / 12     9 / 13
>     ring already stopped + WARNING       22 / 24     0 / 0
>                                      (host A / host B)
> 
> The race still happens as often as before - it is not what this patch
> addresses - but it no longer leaves a warning splat behind, and no longer
> releases a HopID that belongs to someone else.
> 
> Fixes: e69b6c02b4c3 ("net: Add support for networking over Thunderbolt cable")
> Cc: <stable@vger.kernel.org> # 5.13+
> Signed-off-by: Fan Ye <fy15309206903@gmail.com>

Same comments here about LLM. The fix looks reasonable to me.

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> ---
> These four came out of one investigation on a pair of ASMedia ASM4242
> hosts wired to each other. Apply them in this order: the second one
> touches lines the first one adds, so it needs that one underneath to
> apply at all, and the last two want the first two under them for the
> reason below.
> 
>   1 net: thunderbolt: Release the Rx HopID that was handed out on mismatch
>   2 net: thunderbolt: Mark the connection down when bringing it up fails
>   3 thunderbolt: Report DMA path teardown failures to the caller
>   4 thunderbolt: Stop waiting on a path pending bit that never clears
> 
> This one is number 2 on that list.
> 
> 1 and 2 fix two separate things that happen to be reached through the
> same branch. Neither depends on the other for correctness - each leaves
> the other's defect in place - but 2 edits the lines 1 adds, so it will
> not apply on its own.
> 
> 3 and 4 do want 1 and 2 underneath: the warning splat that 2 removes
> fires throughout any prolonged run of link cycling, which is what 3 and 4
> have to be measured across. 3 makes teardown failures visible to the
> caller at all; 4 stops the teardown paying for one that cannot succeed.
> Note what that pair does on this particular router - 4 leaves the first
> failure to be reported and silences the rest, so 3's new signal fires
> once per adapter here rather than on every teardown. 4 is the one I am
> least sure of, for the reasons in its own notes.
> 
> Sits on top of "net: thunderbolt: Release the Rx HopID that was handed
> out on mismatch". The two fix different things - that one releases the id
> the allocator actually handed out, this one stops the teardown that
> follows from running a second time - but this one edits the lines that
> one adds, so it will not apply without it.
> 
> An earlier version of this also rearmed the login from the failure paths,
> on the assumption that the connection would otherwise stay down. It does
> not: every one of those failures was followed by the XDomain connection
> being torn down and rebuilt, and the interface came back on its own. Of
> the 60 occurrences across three runs, 59 had a tunnel set up again
> afterwards that I could time - 42 of them 19 seconds later, 14 at 20, one
> at 21 and two at 43 - with and without the patch alike. That is the
> re-enumeration, not a login retry; a retry would have shown up as a
> multiple of TBNET_LOGIN_DELAY. The rearm bought nothing and needed a
> retry bound of its own, so it is gone.
> 
> What I am not claiming: that this makes the link survive longer. I have
> run the 200 cycles four times, on four different combinations. Two of
> them stopped coming up after 65 and 69 minutes and two ran to the end.
> Both of the ones that finished had this patch, and neither of the ones
> that died had this version of it - one had no part of it at all, the
> other an earlier version. On the face of it that reads the way I would
> like it to, which is exactly why I am not reading it that way: four runs,
> four different combinations, one run each. What I can say is that the
> race this patch is about is not what ends a run - it fired 22 times in
> the run in the table above and the link came back from all 22.
> 
> One question I cannot answer from here. Skipping the block also skips the
> logout request that would have gone to the peer. Everything else in it is
> either already undone or was never done, but the logout is a real thing
> the peer no longer hears about. I could not measure a difference - the
> XDomain connection is torn down and rebuilt right afterwards in every
> case I logged - but whether that is good enough, or whether the failure
> paths should send one explicitly before returning, is a call I would
> rather leave to you.
> ---
>  drivers/net/thunderbolt/main.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/net/thunderbolt/main.c b/drivers/net/thunderbolt/main.c
> index e5199a87ea7a..b6aec215a8e9 100644
> --- a/drivers/net/thunderbolt/main.c
> +++ b/drivers/net/thunderbolt/main.c
> @@ -626,6 +626,20 @@ static int tbnet_alloc_tx_buffers(struct tbnet *net)
>  	return 0;
>  }
>  
> +static void tbnet_connect_failed(struct tbnet *net)
> +{
> +	/*
> +	 * Mark the connection as no longer established so that
> +	 * tbnet_tear_down() does not run over the unwind we just did.
> +	 * Only login_sent is cleared: login_received records that the peer
> +	 * has logged in with us and carries the transmit path it gave us,
> +	 * and nothing on this side can make the peer send that again.
> +	 */
> +	mutex_lock(&net->connection_lock);
> +	net->login_sent = false;
> +	mutex_unlock(&net->connection_lock);
> +}
> +
>  static void tbnet_connected_work(struct work_struct *work)
>  {
>  	struct tbnet *net = container_of(work, typeof(*net), connected_work);
> @@ -649,6 +663,7 @@ static void tbnet_connected_work(struct work_struct *work)
>  		netdev_err(net->dev, "failed to allocate Rx HopID\n");
>  		if (ret >= 0)
>  			tb_xdomain_release_in_hopid(net->xd, ret);
> +		tbnet_connect_failed(net);
>  		return;
>  	}
>  
> @@ -693,6 +708,7 @@ static void tbnet_connected_work(struct work_struct *work)
>  	tb_ring_stop(net->rx_ring.ring);
>  	tb_ring_stop(net->tx_ring.ring);
>  	tb_xdomain_release_in_hopid(net->xd, net->remote_transmit_path);
> +	tbnet_connect_failed(net);
>  }
>  
>  static void tbnet_login_work(struct work_struct *work)
> 
> -- 
> 2.43.0
> 
