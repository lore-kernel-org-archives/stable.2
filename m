Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793469244;
	b=kEAECIpqxqsBmW2pOW4V4NOeLpXshBf/IIDw6MLMmPlR/B6ahgRGLggLQ8jQxOpvkRk8
	 478CXItMVutktO9enJ6Ax7TQgacL7h6YwexNebVJ091z6xFeBMRj0jUfal4SZ+3bqVHKN
	 3dVKfMwJVOm/k3WFYUk8MIqEltW9eaQ4xdLgAWL7s2r9HXaIhbfg+ZMOBtEWxixRCqS7s
	 BqROWjB31xZfOfJhPRSxFV+HR3iFs/JBKiT/fysPmwkKxzomIB4EIehRd2zSB4241NHx/
	 cjFnewuuwyv/gU7cW//db7/Tfpp/Im+7IOGIAsak7uA8rhiOoNkEy97hxK2TZeDF9oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793469244;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/MwNJYTzhevleVLT0wB4o/dVQzk0Vd5QdLxqWEpD0FQ=;
	b=TGQz558JAF0AykvsM0JBOaygPyZ0bGlv9sZf9fYkoWMhtj/MFWtbrPSR+k2WaH2pmlOR
	 MDmlcggPyxe23brVNmSkXDpk8ic/JNSHDjvt0hB7EOF6oLq/yN2DQ5SXo1LFWj0ALwc8j
	 wNHKXVkYzduRrBnQLYtENqpjs79DWhUqWdC8X0IGr0wct8iZMNby7FjrtzjZ+Hx6arC1z
	 /ITJevEQentgAz9D0kQPUErUk+F46M+AJZ/xCZGt9e392R1CtBZ9eRWH4dkAG2ftDa4Dh
	 ubEfUCKLJVeNSArzzCC87J1NwnNLH8z1MYrJsD3KjZ/p7EbuU7z+1NrbpDrnllRa1lA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTCFNsmG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1540D606A31A;
	Sat, 31 Oct 2026 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kTCFNsmG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 594DB1F000C1;
	Sat, 31 Oct 2026 17:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793469243;
	bh=/MwNJYTzhevleVLT0wB4o/dVQzk0Vd5QdLxqWEpD0FQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kTCFNsmGcTJfyOV1keEj1/p0CdrFp2vaz+QLyJrN5JCQVApzXwW2K3eOn1LFIPLKt
	 eox3mYq5wnO/o1+BUQ/N6UDTQ2RBbkteTpg0UMFwyS++Lc1xr3ZoHLcoV1lz/m/qV1
	 0cTyQWCDJfoGDFMVwJ/NvMZOdHsFLAX0yfQPnARVrnFPlVZ3YjqbzgUQFQIYbnXO4w
	 VDCuMuUX2BWe8Mlav84GNSKYeoZGh0g0MvICYdxirCX+jsqv5p2paC5UuDvyikBjqP
	 xjngLZl2Ep2eGBRYY810aGFUm0fFFYZ+eEaikyNY6JtfcBrPNlSopJNv7eqU1z3rfO
	 PeWW7LSZVo7JQ==
Date: Sat, 31 Oct 2026 17:53:59 +0000
From: Simon Horman <horms@kernel.org>
To: Tristan Madani <tristmd@gmail.com>
Cc: David Heidelberg <david@ixit.cz>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"John W . Linville" <linville@tuxdriver.com>,
	Samuel Ortiz <sameo@linux.intel.com>, oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: Re: [PATCH v2 net] nfc: llcp: use disable_work_sync and
 timer_shutdown_sync in local_cleanup
Message-ID: <20261031175359.GT257209@horms.kernel.org>
References: <20261029162419.2420980-1-tristmd@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029162419.2420980-1-tristmd@gmail.com>

On Thu, Oct 29, 2026 at 04:24:19PM +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> local_cleanup() tears down timers and work items before
> local_release_work() frees the nfc_llcp_local structure.  The current
> code has two ordering problems:
> 
> 1) timer_delete_sync() does not prevent timer callbacks from re-arming
>    the timer via mod_timer().  nfc_llcp_tx_work() unconditionally
>    re-arms link_timer, and nfc_llcp_sdreq_timeout_work() conditionally
>    re-arms sdreq_timer.  A work callback that runs during
>    cancel_work_sync() and calls mod_timer() causes the timer to fire
>    after the structure is freed.
> 
> 2) cancel_work_sync() does not prevent work items from being
>    re-queued.  nfc_llcp_rx_work() queues tx_work via
>    schedule_work(), and the timer callbacks queue their associated
>    work items.  Since tx_work is cancelled before rx_work, a
>    running rx_work instance can re-queue tx_work after its
>    cancel_work_sync() has returned.  The re-queued tx_work then
>    runs on the freed structure.
> 
> Switch the timers to timer_shutdown_sync() which rejects subsequent
> mod_timer() calls.  Switch the work items to disable_work_sync()
> which rejects subsequent schedule_work() calls.
> 
> Reorder the teardown sequence so that both timers are shut down
> first (their callbacks queue work items), rx_work is disabled
> before tx_work (rx_work queues tx_work), and data structures are
> freed only after all asynchronous callbacks are quiesced.
> 
> Fixes: d646960f7986 ("NFC: Initial LLCP support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
> v2:
>   - Switch work items from cancel_work_sync() to disable_work_sync()
>     to prevent re-queuing after cancellation, as identified by the
>     automated review and confirmed by Simon Horman
>   - Reorder teardown: shut down both timers first (their callbacks
>     queue work items), then disable rx_work before tx_work (rx_work
>     queues tx_work), then disable remaining work items
>   - Move data structure cleanup (skb_queue_purge, kfree_skb) after
>     all asynchronous callbacks are quiesced

Thanks for the updates.

Reviewed-by: Simon Horman <horms@kernel.org>

