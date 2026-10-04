Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC67D43711B;
	Sun,  4 Oct 2026 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121923; cv=none; b=OaAcJkdWBxyFmpY6M2sUeknSwj3q9nTKJ8gK7KnXw2M8sDNGNhZJNwFrlAQ2h23jdsH/RcFwN+SUNMVoQGK9LxzRSDp+5rWapRD/5bM0k25FBWFKV0YyA1tOJW86+lk9KortHGdxWWLgZKu0YTUxDO2KakpXVcwIRuopiAiiUko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121923; c=relaxed/simple;
	bh=eh4JmCl2z9v5o/njO6EO9oQWrrTNVlmYZ3s0b+sxhu8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BDoKgT3EMnUM/yg91Zaah2vQXYQIJcS/VUvxv+a/I8pZP2nJ4F3FV6cICI+CoeocTSH4pascZXD/O0wBmk0JU77fiQDyJtsWQj+yYb+0KKFgcfHzNM5e9OMYTjvbbdNv+xsIPup9VzImfjmfD4RQUK/mhly68AdfV+xsqtvmOU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Toy1Xkr/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Toy1Xkr/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE3C01F00893;
	Sun,  4 Oct 2026 13:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791121921;
	bh=0Tyn+idJA29Oyha2JL7pM0fMPsUIj8MxRZ7brWvzlec=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Toy1Xkr/EPH5xSvY20V5Z7YYtw2juIV4lhszynUFJjv1IKBZTycsUiL6yYTFrA0rq
	 n4oRta/sAN9/ZQeTC0YC/E9RfNOHR5Ig4lNCg9wj9rHF9zJYBypdvfmbGBBc7/w1B/
	 hbhrJcppP6Cxp9lSocBW8bVw6kOgVUQ+N0OBV9CiIJNAWbFw3jV+ZiR82Xy4KV0PBF
	 PanXscRi3//JuPASmG9d2YtlchRy9+KEM/DTmTP1T8Zi5E35xzf3+333JIQ130h7sF
	 I7ORRxbDcYF3lo996jW18WBTG2DXBdzjcUrdDmzHAKgN1s5X8jaElTDE+rM06l7IG/
	 1LRjU7VPsOREw==
Subject: Re: [PATCH net v13 2/2] llc: create listener children only for SABME
From: netdev-bot+sashiko@kernel.org
To: zihanx@nebusec.ai
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kees@kernel.org,
 ernestas.k@iconn-networks.com, leitao@debian.org, tim.bird@sony.com,
 shuangpeng.kernel@gmail.com, luoxuanqiang@kylinos.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, vega@nebusec.ai,
 root@tr0jan.top
Date: Sun, 04 Oct 2026 13:52:00 +0000
Message-ID: <179112192029.434549.16529360000343263003@kernel.org>
In-Reply-To:
 <6d816ade8765b81d69d06af0d1970f3f09504a48.1790688018.git.zihanx@nebusec.ai>
References:
 <6d816ade8765b81d69d06af0d1970f3f09504a48.1790688018.git.zihanx@nebusec.ai>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 1 · High: 0 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] In llc_conn_rcv_existing_sabme() (net/llc/llc_conn.c), the
  patch calls bh_lock_sock_nested(newsk) on whatever socket…

--

llc: create listener children only for SABME

With this patch, an LLC listener creates a passive-open child only for a
SABME command. It answers DISC and other P=1 commands with DM and drops
all other frames. A duplicate SABME that matches an existing connection
now goes to that child through the new llc_conn_rcv_existing_sabme()
helper instead of being dropped, and llc_backlog_rcv() checks backlog
packets more strictly.

> diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
> index 349a7c5b9bb1a..79c29c57cd471 100644
> --- a/net/llc/llc_conn.c
> +++ b/net/llc/llc_conn.c

[ ... ]

> @@ -801,7 +801,64 @@ static struct sock *llc_create_incoming_sock(struct sock *sk,
>  	return newsk;
>  }
>  
> -static int llc_conn_rcv_listener(struct sock *sk, struct sk_buff *skb,
> +/* The listener is locked and bottom halves are disabled. */
> +static int llc_conn_rcv_existing_sabme(struct sock *listener,
> +				       struct sock *newsk,
> +				       struct sk_buff *skb)
> +{
> +	struct llc_sock *llc = llc_sk(newsk);
> +	int incoming_state;
> +	int rc = 0;
> +
> +	bh_lock_sock_nested(newsk);

[ ... ]

> @@ -812,8 +869,9 @@ static int llc_conn_rcv_listener(struct sock *sk, struct sk_buff *skb,
>  	newsk = __llc_lookup_established(llc_sk(sk)->sap, saddr, daddr,
>  					 dev_net(skb->dev));
>  	if (newsk) {
> -		sock_put(newsk);
> -		goto drop;
> +		rc = llc_conn_rcv_existing_sabme(sk, newsk, skb);
> +		local_bh_enable();
> +		return rc;
>  	}

[Severity: Critical]

Can __llc_lookup_established() return the listener itself here?

Listeners are hashed in the same sap->sk_laddr_hash, and
llc_estab_match() does not check sk_state:

net/llc/llc_conn.c:llc_estab_match() {
	...
	return net_eq(sock_net(sk), net) &&
		llc->laddr.lsap == laddr->lsap &&
		llc->daddr.lsap == daddr->lsap &&
		ether_addr_equal(llc->laddr.mac, laddr->mac) &&
		ether_addr_equal(llc->daddr.mac, daddr->mac);
}

A listener that was bound but never connected has an all-zero daddr.
llc_ui_bind() relies on that zero daddr in its clash check.

A socket whose connect() failed keeps llc->daddr set to the peer, because
llc_ui_connect() fills it in before the attempt. llc_ui_listen() only
requires SS_UNCONNECTED, so that socket can then become a listener that
still matches the peer.

Suppose a peer sends one SABME command to the listener's MAC and SAP,
using SA 00:00:00:00:00:00 and SSAP 0. The softirq path then looks like
this:

llc_conn_handler()
  __llc_lookup() returns the listener
  bh_lock_sock(sk)
  sk_state is TCP_LISTEN, !newsk, frame is SABME, not owned by user
  llc_conn_rcv_sabme(sk, skb, &saddr, &daddr)
    __llc_lookup_established() returns the same listener
    llc_conn_rcv_existing_sabme(sk, sk, skb)
      bh_lock_sock_nested(sk)

Wouldn't this CPU spin forever on sk->sk_lock.slock, which it already
holds? SINGLE_DEPTH_NESTING only changes the lockdep subclass. It does not
stop a real recursive acquisition.

Before this patch, a lookup hit here just called sock_put(newsk) and
dropped the skb without taking any child lock.

The deferred path does not deadlock, because __release_sock() has already
dropped the slock. In that case the skb is queued again on the listener as
LLC_PACKET, and llc_backlog_rcv() drops it because the listener's
llc->state is ADM.

Should llc_conn_rcv_sabme() drop the frame when newsk == sk (or when
newsk->sk_state == TCP_LISTEN) before taking the child lock? The
established match could also skip listening sockets instead.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1790688018.git.zihanx%40nebusec.ai
