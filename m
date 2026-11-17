Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794954591;
	b=SHyDZ6vQNmrRnxwMJy8tNT761ekL3uVbxWt+7I78/RFiWaFgtwbiUN8DGV24H4DJ/O+I
	 L8hOio11HlfxKvW9rVTkhiPrdD1P/hj/gFkANOJqcxGg54MLbdUMOOu5rSXKtDiHbpvUC
	 KQjUbG41jI3Znifi2e4MMNsvqvzzaEcRAsQr0VdVYbzLicyLK8K3hiQ4y9pxzDiUVCNx+
	 q8TpXrD3N6EYz7T1fGhZkQwS3+kXfFle5noz+6x3HMhQmY19ChcjHuq5Jt5yhyM1rmoZw
	 7OlTslH6eqlN06ZtFW/TBuOdAf8tOnMP8nLyWNHjI8+P1sM9LKQuSS1zkifbBJxNlHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794954591;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=heh1kZ+qgjKo/AgXK7ewjk75P489JDGfLaGMmKnq1aQ=;
	b=l/eIHQbUHGvuxqEjmVd6lM+H1ewjA7zQfzLDwWz5QZjpb/KYaalaHxjNdwO6VhjOTE/B
	 IBaL+JSE0+dq2mIKn3aBnC+bYXkaX8r/fHDRKNhSLo4gi9LcmJxPcrEcqYUlXyArDDluu
	 hO6wUHGn/7tGKnt7Ws6mX7hZKvzVcBWWRTTmf9XUouqOvRnyI9qxzaerU+PFZZdggcte/
	 64zPMJBJNTxLTklT9Q3cqFnPIh9M+2QnhU+NRepyJfIG3qe3Y5vYE+f4ZyyQAwHNMzDEv
	 osY/LzUvpafHapkgXP6xBR2p9oolAq+zBsa6eWdsF4z6672NkY8ZGOLtkK7BA/4Hggw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KtHkIJpK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB52C606A89D;
	Tue, 17 Nov 2026 22:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KtHkIJpK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E73601F000CF;
	Tue, 17 Nov 2026 22:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794954590;
	bh=heh1kZ+qgjKo/AgXK7ewjk75P489JDGfLaGMmKnq1aQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KtHkIJpKdbvxPV5VSpqfs60sYKIwf8OO81qJqLVZEjOcPv9TyF1UdkC/gLQ3JMdm2
	 Hs33WbfXbDp0VLd811I6Oeo83qiFNrKmoL8VsgeM/nDLbQRzqx30p6Zyn4Mjt97jOy
	 oAZ51/bD8DanPwUswTJLdf40xt5DOhlreYqbziGLR3Xecsem8LmYHAZTeTnZQDG9M9
	 T4bf9mdi2J67pPLY6VccFnWzUA2Tytb0dFmNGi6vuDXkBPXYKrKtRyZ+SITNQBj2zY
	 KmniKyytqLQW0DRp989Wjle89CpcpWsNne4csDWhFKSGHNmNSLQvh4jQEONNNGZhQ5
	 l6/zVu2Pelztg==
Subject: Re: [PATCH net 5/7] mptcp: push queued data on subflows falling back
 at the handshake
From: netdev-bot+sashiko@kernel.org
To: matttbe@kernel.org
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, dmytro@shytyi.net, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 mason@kernel.org
Date: Tue, 17 Nov 2026 22:29:49 +0000
Message-ID: <179495458948.3136.10805605417711396515@kernel.org>
In-Reply-To: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-5-bf7656de653e@kernel.org>
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-5-bf7656de653e@kernel.org>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] check_fully_established() (net/mptcp/options.c) now pushes
  pending MPTCP data in its fallback branch every time that branch runs,…

--

mptcp: push queued data on subflows falling back at the handshake

This commit pushes pending MPTCP data from check_fully_established() when
a subflow that is not yet fully established falls back to TCP, because
the first established packet carries no MP_CAPABLE option. This covers
both passive TFO subflows and clients with data held back by a small
SYN+ACK window.

> diff --git a/net/mptcp/options.c b/net/mptcp/options.c
> index bcf3440d1901b..617358ff7f990 100644
> --- a/net/mptcp/options.c
> +++ b/net/mptcp/options.c
> @@ -1035,6 +1035,10 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
>  			MPTCP_INC_STATS(sock_net(ssk), MPTCP_MIB_FALLBACKFAILED);
>  			goto reset;
>  		}
> +		/* this ACK will not reach the fallback path: push from here */
> +		mptcp_data_lock(sk);
> +		__mptcp_check_push(sk, ssk);
> +		mptcp_data_unlock(sk);
>  		return false;
>  	}

[Severity: Low]
Can this push also run while an incoming RST is being processed?

tcp_reset() calls into MPTCP before it tears the subflow down:

net/ipv4/tcp_input.c:tcp_reset() {
    ...
	if (sk_is_mptcp(sk))
		mptcp_incoming_options(sk, skb);
    ...
	tcp_done_with_error(sk, err);
}

Take an active client whose mp_capable subflow has sent the third ACK but
has not yet received a DSS DATA_ACK, so subflow->fully_established is
still 0. Suppose an RST arrives with seq == rcv_nxt == ssn_offset + 1.
tcp_validate_incoming() accepts it and calls tcp_reset().

A plain RST from a middlebox, or an RST that only carries MP_RST, has no
OPTIONS_MPTCP_MPC. So check_fully_established() enters this fallback
branch, and mptcp_try_fallback() succeeds.

The new code then goes through:

__mptcp_check_push()
  __mptcp_subflow_push_pending()
    mptcp_sched_get_send()
    __subflow_push_pending()
      tcp_push()
    mptcp_reset_rtx_timer()

In fallback mode, mptcp_sched_get_send() only checks
__tcp_can_send(msk->first) and sk_stream_memory_free(). The subflow is
still TCP_ESTABLISHED at this point, so it gets picked.

Right after this returns, tcp_done_with_error() purges the subflow write
queue and closes the subflow.

Usually TCP's own snd_wnd keeps the data off the wire. The work is still
wasted, though: dfrags are copied into a queue that is purged at once,
msk->snd_nxt moves forward, and the msk rtx timer is armed during
teardown.

What if the TCP window allows more than the msk window? For example,
data could have been left behind by an allocation failure, or snd_wnd
could have been updated by a segment without a DSS. Could data segments
then go on the wire after a valid RST was accepted?

The fallback block at the top of mptcp_incoming_options() already does
this for an msk that fell back earlier. This patch makes the same thing
reachable from the not-yet-fully-established case.

The comment says "this ACK", but the packet here can be an RST. Would it
make sense to skip the push when the skb has the RST flag set?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e%40kernel.org
