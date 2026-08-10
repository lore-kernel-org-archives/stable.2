Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344D3DC4DE;
	Mon, 10 Aug 2026 18:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388269; cv=none; b=rNC324ThhTSGNxWJAaiCHQG+NrF2JSj5P8+gfGaH0Uwt8gQ9s7vToPOMwA0XjClPRSJi/+PuZxArDal2sIpoz1nFAExHSbSeKbJ4HrqEOWu2P8BHpVFbBvvbkSIIJvQToeRukPB6Ke35mGDhNfenRKWEbIca5hCOBaSNpLHA/PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388269; c=relaxed/simple;
	bh=sUA7o6uqu3DbfNtzMcQIsZUGo/XFhqxhTQzqn/ZfvOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PpOH0e/S4C8EpaVtyYCwFqskS++0gLjqvbYGrz5iN5+h/UAGYRXdqdmZoq657fpHJUAcvXY8Rp3XY4dZO1vqZoYGmbMKpUZjL4y642SDu0W7dMtXqzaujdnxSxcW41CaI/WK+ZsuFN7GT4rz2TrY6Qi0+WHTi+2HhwPkxALP2u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K0Pp57y3; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K0Pp57y3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786388267; x=1817924267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sUA7o6uqu3DbfNtzMcQIsZUGo/XFhqxhTQzqn/ZfvOM=;
  b=K0Pp57y35pKqmSnTw3Vpj+XUkoxfHfD9JAUfat5imIi6biqJN13JeUk4
   wC8pZgr8KCi/gq7uwm/UJrXUtK7bLQg7pNiCtPjxmDbN8oiTrvsC3JcOP
   yiN9yrj5fNkJ5U2BIqqhcdJDwbMkJE4WIHoETrX9cFCvoyrH9hbeZXwah
   VClSgpFWLaFl0Fjbwk1f3vMsm+slvcIPowNLIGoHi3WDa6bER9BqMmhD/
   X2dlijX7b2UL2aUF/ozPssJD2WwOEOP8pu0QkSKAmr3EeYI4jIMZnX/vW
   rExhPsjE4yheOACMOZoXg6jV1na7Z0wR0lBImJ2jZLGXCR7Cv4P/q+viW
   w==;
X-CSE-ConnectionGUID: sUyyWYZhT521PrxyeW5aUQ==
X-CSE-MsgGUID: /ELTKVsSRU6htC7QNXYj3w==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="89438663"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="89438663"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:57:47 -0700
X-CSE-ConnectionGUID: zP0fTVf9RT2i59Jk0PG1tA==
X-CSE-MsgGUID: 0xuMegtOQPKk2RozfTw1Tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; 
   d="scan'208";a="286534218"
Received: from conormcd-mobl2.ger.corp.intel.com (HELO localhost) ([10.245.244.99])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2026 11:57:44 -0700
Date: Mon, 10 Aug 2026 21:57:41 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: fy15309206903@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Mika Westerberg <westeri@kernel.org>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH net v2 2/2] net: thunderbolt: Mark the connection down
 when bringing it up fails
Message-ID: <anofJY04NQTmaFxo@ashevche-desk.local>
References: <20260810-b4-tbnet-hopid-v2-0-0eee557e75df@gmail.com>
 <20260810-b4-tbnet-hopid-v2-2-0eee557e75df@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810-b4-tbnet-hopid-v2-2-0eee557e75df@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Aug 10, 2026 at 09:39:15AM +0000, Fan Ye via B4 Relay wrote:

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

Same recommendation, try to squeeze this saga to the point.

-- 
With Best Regards,
Andy Shevchenko


