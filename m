Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757850;
	b=oHxY34IfjQ+4itU5xwVRtekteH9ubS4IB1a7yz+Iwnniur5LfxkebkkTpg3aOfug/cKM
	 LBhNVMWw97AS1jjk301FtYRxPTURYwdQb/4451k4s3Ax3JiYBthqbLNq51jzyhrEMl5v0
	 DjZYMDtkKAsFDvNZuHahA2krvza89LW+rRVH3io7cTn6vqW/T0JtmyLqwydGPP041s5L3
	 gYflRn1SlCUyXkiBZCJTRMqviXf6lYXpXNzwwTnmWYETkUgwgiGrZejOdgitpgZ8IWIrG
	 gWKRUGHy8Uoq6RQWubFEqt7YLygj0htQGtSRsNxJhgVlTkUScQefCDbAdkN3qvIHFEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757850;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=zZpTPkiBERa1gkk+1x09PUsmxHeLtWaobOySTB7HP+s=;
	b=tIrCGBOtlHZ4eBT8U5ze9ChrvU9qx3gIN0Wybg6xtX9nWMiuTX+QpYyi9jabcmeAh7jz
	 htPJ/YYAT9R4GmENb7ByIe1q36qbfuxlJvLFnW4UwPjqhNvO9nahdA6mJ2ctS/ZDfocJY
	 EM1rlvrrmZtZd3RGuXfo3QoUJ8nt+Jv22n+XhV7abkK3tK4e7wY/Hppb+WPntJQIzcXFE
	 J+DRqaHUF0yRoDZlPzeLl5DoQPI3l3trWy1bNbn5A5lXsG+k+9wvJxaqi/zGPMZamsvvo
	 MvCSfFl0x+GwtWLDVFdSNNjmMLfJrZYJ1lrzO/r7luG6uNVJLW+jZFNzL8BzbcAs2kQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FiM3ICOG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B6960A3829;
	Fri, 23 Oct 2026 12:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FiM3ICOG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD531F01825;
	Fri, 23 Oct 2026 12:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792757849;
	bh=zZpTPkiBERa1gkk+1x09PUsmxHeLtWaobOySTB7HP+s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FiM3ICOGK1rGA1r/nlGEPefMmZqLMGTbrct+EQ717pyZ3VMIPn2inPXnpYEKvJX6K
	 lcvpmMbxCfBkjANbcZgjz+wJXfg4PIaQLJsl2VpG/SitlNEnaArNLTAbrIbI1jvnbO
	 aR6bY3h5w9jErqk2aATc9C7y969ObzngS5iPk40mn8h3eD5k3bGa3Twsb2cD03LTsH
	 uIPjIlZjVBZm5EhzHwtw1DDJ0f0Qdr8xOXO6NpbafUYv6eJ6YrF7cGgwWMpgOLxePB
	 wWH5ZPa9NShabcpmqEPYUm9duJuLQv9MTkuktQs3O+zNe4rPxZlezkuX9i2Ntu7yQx
	 osRc3CmBIlRLg==
Subject:
 Re: [PATCH net 6/7] ovpn: fix TCP TX accounting for locally dropped packets
From: netdev-bot+sashiko@kernel.org
To: antonio@openvpn.net
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, stable@vger.kernel.org
Date: Fri, 23 Oct 2026 12:17:28 +0000
Message-ID: <179275784882.3134.8206640580518712230@kernel.org>
In-Reply-To: <20261022121606.732029-7-antonio@openvpn.net>
References: <20261022121606.732029-7-antonio@openvpn.net>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix leaves a TCP local-drop path with the same wrong
  accounting.

--

ovpn: fix TCP TX accounting for locally dropped packets

With this patch, ovpn_tcp_send_skb() and ovpn_tcp_send_sock_skb() return
an error when TCP cannot take the skb, instead of freeing it. On error,
ovpn_encrypt_post() keeps the skb, counts the drop and frees it, without
updating peer TX stats or last_sent. The TCP release and sendmsg paths
now count and free the skb themselves when these helpers fail.

> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
> index ce1993b243e6f..eb9ba709523ee 100644
> --- a/drivers/net/ovpn/io.c
> +++ b/drivers/net/ovpn/io.c
> @@ -287,7 +287,9 @@ void ovpn_encrypt_post(void *data, int ret)
>  			goto err_unlock;
>  		break;
>  	case IPPROTO_TCP:
> -		ovpn_tcp_send_skb(peer, sock->sk, skb);
> +		ret = ovpn_tcp_send_skb(peer, sock->sk, skb);
> +		if (unlikely(ret < 0))
> +			goto err_unlock;
>  		break;
>  	default:
>  		/* no transport configured yet */
> diff --git a/drivers/net/ovpn/tcp.c b/drivers/net/ovpn/tcp.c
> index 5340860c0b822..a3165580e97b5 100644
> --- a/drivers/net/ovpn/tcp.c
> +++ b/drivers/net/ovpn/tcp.c
> @@ -319,28 +319,39 @@ void ovpn_tcp_tx_work(struct work_struct *work)
>  	release_sock(sock->sk);
>  }
>  
> -static void ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sock *sk,
> -				   struct sk_buff *skb)
> +static int ovpn_tcp_send_sock_skb(struct ovpn_peer *peer, struct sock *sk,
> +				  struct sk_buff *skb)
>  {
>  	if (peer->tcp.out_msg.skb)
>  		ovpn_tcp_send_sock(peer, sk);
>  
> -	if (peer->tcp.out_msg.skb) {
> -		ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
> -		kfree_skb(skb);
> -		return;
> -	}
> +	if (peer->tcp.out_msg.skb)
> +		return -EBUSY;

[ ... ]

> @@ -348,16 +359,16 @@ void ovpn_tcp_send_skb(struct ovpn_peer *peer, struct sock *sk,
>  	if (sock_owned_by_user(sk)) {
>  		if (skb_queue_len(&peer->tcp.out_queue) >=
>  		    READ_ONCE(net_hotdata.max_backlog)) {
> -			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
> -			kfree_skb(skb);
> +			ret = -ENOBUFS;
>  			goto unlock;
>  		}
>  		__skb_queue_tail(&peer->tcp.out_queue, skb);
>  	} else {
> -		ovpn_tcp_send_sock_skb(peer, sk, skb);
> +		ret = ovpn_tcp_send_sock_skb(peer, sk, skb);
>  	}

[ ... ]

> @@ -388,8 +400,13 @@ static void ovpn_tcp_release(struct sock *sk)
>  	__skb_queue_head_init(&queue);
>  	skb_queue_splice_init(&peer->tcp.out_queue, &queue);
>  
> -	while ((skb = __skb_dequeue(&queue)))
> -		ovpn_tcp_send_sock_skb(peer, sk, skb);
> +	while ((skb = __skb_dequeue(&queue))) {
> +		ret = ovpn_tcp_send_sock_skb(peer, sk, skb);
> +		if (unlikely(ret < 0)) {
> +			ovpn_dev_dstats_tx_dropped(peer->ovpn->dev);
> +			kfree_skb(skb);
> +		}
> +	}

[Severity: High]
Can skbs that ovpn_encrypt_post() already counted as sent still be
dropped here?

When sock_owned_by_user(sk) is true, ovpn_tcp_send_skb() only puts the skb
on peer->tcp.out_queue and returns 0. ovpn_encrypt_post() treats that 0 as
a successful send:

ovpn_encrypt_post() {
    ...
	ovpn_peer_stats_increment_tx(&peer->link_stats, orig_len);
	/* keep track of last sent packet for keepalive */
	WRITE_ONCE(peer->last_sent, ktime_get_boottime_seconds());
    ...
}

Later, release_sock()->ovpn_tcp_release() drains out_queue through
ovpn_tcp_send_sock_skb(). Suppose peer->tcp.out_msg.skb is still pending
because skb_send_sock_locked_with_flags() returned -EAGAIN under TCP
backpressure. Then every drained skb gets -EBUSY and lands in this new
branch.

The packet is then counted in the peer link TX counters
(OVPN_A_PEER_LINK_TX_BYTES/PACKETS) and also in the device tx_dropped
counter. peer->last_sent was also refreshed for a packet that never left.
That pushes back the keepalive deadline in
ovpn_peer_keepalive_work_single().

Isn't this the "another output skb is still busy" case the commit message
says it fixes? Several contexts can hold lock_sock() here. One is
ovpn_tcp_tx_work(), which gets queued exactly when out_msg is stuck.
Others are ovpn_tcp_sendmsg() and a userspace setsockopt(). A remote peer
that stops reading (zero window) can keep out_msg stuck.

The commit message also says:

    Handle the same helper errors locally in TCP release and
    sendmsg paths, which do not go through ovpn_encrypt_post.

That doesn't look right for the release path. Only ovpn_tcp_send_skb()
fills out_queue, and only ovpn_encrypt_post() calls ovpn_tcp_send_skb().
So every skb dropped here was already counted as sent. The same goes for
queued skbs freed by skb_queue_purge() in ovpn_tcp_socket_detach().

The selftests change later in the series does not touch this code, so
this is still present at the end of the series.

Could the peer link TX accounting and the last_sent update move to the
point where TCP actually accepts the skb into out_msg or sends it?
ovpn_tcp_send_sock() already does this for dev_dstats_tx_add().
Alternatively, the accounting could be undone when a queued skb is
dropped.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022121606.732029-2-antonio%40openvpn.net
