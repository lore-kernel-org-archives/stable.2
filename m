Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794417262;
	b=Fbe+Wpc6fRp5uwiLh2gIaAX9Ax++m3KiLVEvZcuuda7G38IKRRha76J66zhCeJKdveOW
	 MSO+toQvm6nw0WplnaTGoWYTrC1HjDHJKausTG8jCpLxo6YFQQJJaxoH8R5JZD2klAv9V
	 gs4GLUW2lvZHDrf5R/bEl/NMX2NaKGBEfwZztisN/Y3yIgBkccbSM8XXrZWDCjRobu5em
	 h+psj+cDQPLjx4FbO/+y2t9mOXT+8W7/iXHuqwGWugzb9fbHSzvMoWrZExAU5YhzrMEIb
	 zOqBIv6r2YZ5WNV/gC6jXSkjvCHM0K9ZthfNOPiezS7R8vhPw+YtuTlA6BwK3gHIpxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794417262;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=K0OUanBq+hsQdFZ3wody+MoiBGNzg1aTJa0o6x23ajI=;
	b=aeHAJpaxUfBNdPPN/care1Yh7kekQ4tK3GfJpdznes4XTfi/U+whcSqxIgglNmPtoJtC
	 ZpOc1ESMuT0OwQL9f0p3OVGLqMgwDf4OlrHVegoKNkPOJjlOy81urxqMHAXxaO2Rfh/vu
	 jtQm3mTyPe2+hTxBPkvhclQOpV9iapJ31xQJPvxQSucfWQ/SeGtQLsvtOstoxJ/kwpnSJ
	 iEv7TYTAHrGqOUqchObyHlQzCFZ47ZYK9mSKty++PLUu5o08bEWmS0r6xD/36O6mBx2R8
	 zV82Dl6bhHU2Brz64a4BLuZfriT5U6T/hwpAB0ju0MVFMEGIrS3RvbrRkGHpPxMaiDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nH1JAGr6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962D8606A31C;
	Wed, 11 Nov 2026 17:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nH1JAGr6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D8601F00A06;
	Wed, 11 Nov 2026 17:14:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794417262;
	bh=K0OUanBq+hsQdFZ3wody+MoiBGNzg1aTJa0o6x23ajI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nH1JAGr6uuk6lIu20lPUVYJov5jYScxDWYtnf7zo9eE3S2TnUVpVQc2m7yUa9zfRW
	 toANGDI6xl6733KtFkVbHEqWbuyJzbY8FVIdr3APnt6AqZcoqumlBXYSbKLkLYsw1P
	 CcMY1JzUpgP5zijw5iCX/+gsy0GKFE/qnGbbYgQ5iSxmndJ8ps+6ycBHs2TmDMIYv5
	 gLIYpwVCm6ILFKaWWFIjA6PoPkdaqPQjl2mzofBUh7kJm3VAO0tgR612U8Ay3yVipF
	 wDdoLOZA7LjMOmLJat3dWTiee8OaQrSsgKNBbHxkDHIO5fEKA9x5Ljbm6SdWSUDJ0f
	 BA19bUmhcxmmQ==
Date: Wed, 11 Nov 2026 17:14:18 +0000
From: Simon Horman <horms@kernel.org>
To: Yaohan Li <shunsheng1218@gmail.com>
Cc: netdev@vger.kernel.org, david@ixit.cz, davem@davemloft.net,
	kuba@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
	oe-linux-nfc@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] nfc: rawsock: serialize SEND_SHUTDOWN with the TX
 work requeue
Message-ID: <20261111171418.GG18859@horms.kernel.org>
References: <20261105113812.969651-1-shunsheng1218@gmail.com>
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
In-Reply-To: <20261105113812.969651-1-shunsheng1218@gmail.com>

On Thu, Nov 05, 2026 at 07:38:12PM +0800, Yaohan Li wrote:
> rawsock_release() sets SEND_SHUTDOWN before cancelling tx_work, but it
> updated the shutdown flag without the write-queue lock that
> rawsock_data_exchange_complete() holds while it tests the flag and
> re-queues tx_work.  A deferred completion could pass that check before
> the flag was set and still schedule the work after cancel_work_sync()
> had returned; the worker then ran on a socket that was freed right
> after release dropped its reference.  KASAN reports the
> slab-use-after-free in rawsock_tx_work().
> 
> Set SEND_SHUTDOWN under the write-queue lock, so the completion either
> queues the work before the flag becomes visible (and cancel_work_sync()
> then covers it) or observes the flag and does not queue.  The
> completion-side check from the previous submission is kept.
> 
> The remaining requeue window after the cancel-based teardown was
> previously raised in review of that change (CVE-2026-23372): an
> asynchronous NFC completion can queue tx_work after
> cancel_work_sync() has returned.  This change closes that window and
> does not claim to be the first report of a rawsock teardown
> use-after-free.
> 
> This issue was found during an AI-assisted source review of the socket
> release, TX work and deferred data-exchange completion paths.  It was
> reproduced on a KASAN kernel with a deterministic timing-injection
> harness for a deferred NFC completion callback: with only the
> completion-side check, stalling the completion between its shutdown
> check and schedule_work() while release ran produced seven
> slab-use-after-free reports in rawsock_tx_work(); with this change the
> same sequence and the original purge-window injection produce no
> reports.  The tests run in QEMU with a virtual NFC device; no NFC
> hardware is involved.
> 
> Link: https://lists.openwall.net/netdev/2026/03/24/271
> Fixes: d793458c45df ("nfc: rawsock: cancel tx_work before socket teardown")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yaohan Li <shunsheng1218@gmail.com>
> ---
> 
> v2:
> - Set SEND_SHUTDOWN under the write-queue lock, so a completion that
>   tested the flag before it was visible can no longer requeue tx_work
>   after cancel_work_sync() returned (v1 only added the completion-side
>   check, which left this ordering window open).
> - Added deterministic A/B testing of that window: stalling the
>   completion between its shutdown check and schedule_work() while
>   release runs reproduces the use-after-free on the v1 code and is
>   clean with this change.
> - Corrected the Fixes tag to the cancel-based teardown commit and
>   linked the earlier review thread for the remaining window.
> 
> v1: https://lore.kernel.org/r/179378590950.74297.14503648624087894519@gmail.com/

Thanks for the updates.

>  net/nfc/rawsock.c | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)
> 
> diff --git a/net/nfc/rawsock.c b/net/nfc/rawsock.c
> index f7d7a599fade7..dd8401e3402d3 100644
> --- a/net/nfc/rawsock.c
> +++ b/net/nfc/rawsock.c
> @@ -68,12 +68,23 @@ static int rawsock_release(struct socket *sock)
>  		nfc_sock_unlink(&raw_sk_list, sk);
>  
>  	if (sk->sk_state == TCP_ESTABLISHED) {
> -		/* Prevent rawsock_tx_work from starting new transmits and
> +		/*
> +		 * Prevent rawsock_tx_work from starting new transmits and

I don't think there is a need to respin just because of it.
But if there is a v3 for some other reason then I think the change
above can be dropped. Perhaps tooling flaged the existing style,
but it is acceptable for Networking code. And, for many years
it was required.

>  		 * wait for any in-progress work to finish.  This must happen
>  		 * before the socket is orphaned to avoid a race where
>  		 * rawsock_tx_work runs after the NCI device has been freed.
> +		 *
> +		 * Set SEND_SHUTDOWN under the write-queue lock so it is
> +		 * ordered against rawsock_data_exchange_complete(), which
> +		 * tests the flag and re-queues tx_work under the same lock:
> +		 * either the completion queued the work before we take the
> +		 * lock (cancel_work_sync() below then covers it), or it
> +		 * sees SEND_SHUTDOWN and does not queue.
>  		 */
> +		spin_lock_bh(&sk->sk_write_queue.lock);
>  		sk->sk_shutdown |= SEND_SHUTDOWN;
> +		spin_unlock_bh(&sk->sk_write_queue.lock);
> +
>  		cancel_work_sync(&nfc_rawsock(sk)->tx_work);
>  		rawsock_write_queue_purge(sk);
>  	}

...

Overall this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

