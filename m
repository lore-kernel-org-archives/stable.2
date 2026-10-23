Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792757849;
	b=DQ0QSUwMc/5PaUC+ElNXI4HDXqdJ6sPk0xrHaQ1WXI5nr/GTcyeQHNrq81LRYfwvHxIz
	 KsIcPyHY/p6hJLRh67qqLztz96pZcw6w8EybtM+GTQWWIKtF/IWerfRsnv8TDpYdYsb4u
	 u11O4PYQjbLXsapqTjdbYTpuwEEDWkHyPCmkxug20BE6/K2zFYY66/WhPJ1/D5jhDcRMb
	 pKda8EU/rnU4ghOv5UF3FzKhqDqBFOiH6rpBq1rT9sCpTmMBYw9pD2XHHcmPIpd3jJKB+
	 gEuVV0YfLmr6tLuqI0U5VIlzxYSka9+mVFm4clG735qrWOmWjpvWx4SrBqP/FNeLltQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792757849;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=09Vq/dvOEjTdg1TF0hNYuv2uxb3k+yB/kedD6kH/lMc=;
	b=uVRygYIi88vx3GFzq2RZB0gnsJLoCz1NwQYpCu1L89ADgRpHXV3bX96goESLTu82UtIj
	 zmfEPSateNk6KZAs58+aJSUhqLGwoSgZsnQes35tf8TmSJFzLejgBqRA8c1SjzQih3Z9I
	 lrI8MqzDmUIGdC4DmdfYDPJLhKtLwULyamGyEoMQ6EToqnek05lPsy0UR7I9WqP6+BvN4
	 9rjx+j8H/O6xZRSB3x+BydNb3SfeZxuVOBHodqiMkc6MDBKH+V/dUuuArDH4qrbA/UI7Q
	 uJbnctMADk47VJFz01A5ipLoNkTxiRwOx8INcxLeY+nKAwLAod8WTJNHAUslguXjIrQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PACwXXG1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE2260A260F;
	Fri, 23 Oct 2026 12:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PACwXXG1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE011F01828;
	Fri, 23 Oct 2026 12:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792757848;
	bh=09Vq/dvOEjTdg1TF0hNYuv2uxb3k+yB/kedD6kH/lMc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PACwXXG1TqCIxK2y0rvgIbd7t+zgdQHuERe0sCXSrY/mnF2NXKSb37GfMBoFkJkKC
	 50yqOPhzcfC0f8ORJjx+jAVKgLG/Zv+KxDv2J3b4u2igeFyOOQBhmcrp6BKUvebMDh
	 3/HZmb9INuxTH5y7gCZ2MTSthm+uckh6msDUGvynNsnwi44nTp+y3WCKsyz1bEau7p
	 rL6KP2JLrlWHy7QRbsz3koLoya3cTwWKB52bg8GElgo7TogamiAl38yKoFBrAJQzUO
	 Zri6gJKktYd4RSrUOEK2FoOWzzeXckbgOdmTXanMb8T3NGlcWBUnoWYRNJj+lW4bfK
	 rfW5Qw/7ypeRw==
Subject: Re: [PATCH net 5/7] ovpn: fix UDP TX byte accounting
From: netdev-bot+sashiko@kernel.org
To: antonio@openvpn.net
Cc: netdev@vger.kernel.org, ralf@mandelbit.com, sd@queasysnail.net,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, stable@vger.kernel.org
Date: Fri, 23 Oct 2026 12:17:27 +0000
Message-ID: <179275784775.3134.7765670827133808012@kernel.org>
In-Reply-To: <20261022121606.732029-6-antonio@openvpn.net>
References: <20261022121606.732029-6-antonio@openvpn.net>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] After this patch, the ovpn netdev's rx_bytes and tx_bytes
  measure different layers.

--

ovpn: fix UDP TX byte accounting

This commit resets the inner network header in ovpn_udp_send_skb() before
the skb is handed to the UDP tunnel helpers. The goal is for the ovpn
netdev TX byte counter to include the OpenVPN data-channel header and the
authentication tag.

> diff --git a/drivers/net/ovpn/udp.c b/drivers/net/ovpn/udp.c
> index 7672094a67668..05e10a2ed1791 100644
> --- a/drivers/net/ovpn/udp.c
> +++ b/drivers/net/ovpn/udp.c
> @@ -495,6 +495,9 @@ int ovpn_udp_send_skb(struct ovpn_peer *peer, struct sock *sk,
>  		return -EADDRNOTAVAIL;
>  	}
>  
> +	/* the encrypted openvpn packet is the UDP tunnel payload */
> +	skb_reset_inner_network_header(skb);
> +

[Severity: Medium]
With this change, do rx_bytes and tx_bytes on the ovpn netdev now measure
different layers?

UDP and TCP share the same RX path, and it counts the decrypted plaintext
length:

drivers/net/ovpn/io.c:ovpn_netdev_write() {
    ...
	pkt_len = skb->len;
    ...
	if (likely(ret == NET_RX_SUCCESS)) {
		/* update RX stats with the size of decrypted packet */
		ovpn_peer_stats_increment_rx(&peer->vpn_stats, pkt_len);
		dev_dstats_rx_add(peer->ovpn->dev, pkt_len);
	}
    ...
}

UDP TX goes through iptunnel_xmit() / ip6tunnel_xmit(), which compute:

	int pkt_len = skb->len - skb_inner_network_offset(skb);

The inner network header now sits at the start of the encrypted packet.
So TX counts the opcode/peer-id (4 bytes), the packet-id (4 bytes), the
auth tag (16 bytes) and the ciphertext. That is about 24 bytes per packet
that TX counts and RX does not.

In effect, netdev TX now follows the per-peer link_stats semantics, while
netdev RX follows vpn_stats.

TCP TX uses yet another convention. ovpn_tcp_send_sock() calls
dev_dstats_tx_add(peer->ovpn->dev, skb->len) after ovpn_tcp_send_skb() has
pushed the 2-byte length prefix:

	*(__be16 *)__skb_push(skb, sizeof(u16)) = htons(len);

Other users of the same UDP tunnel stats helper do the opposite. WireGuard
sets the inner network header before it pushes its own header, so that
header is not counted:

drivers/net/wireguard/send.c:encrypt_packet() {
    ...
	skb_set_inner_network_header(skb, 0);
	header = (struct message_data *)skb_push(skb, sizeof(*header));
    ...
}

Take the case the commit message calls an undercount, where the inner
header still points at the plaintext. Before this patch, UDP TX counted the
ciphertext length there. Since the tag sits in front, that equals the
plaintext length, so it matched RX.

Is TX meant to include protocol overhead when RX does not? If so, could
the commit message explain why? If not, should RX and TCP TX be changed
to use the same convention?

The mismatch is still there at the end of the series. "ovpn: fix TCP TX
accounting for locally dropped packets" leaves both the TCP TX
dev_dstats_tx_add(skb->len) call and the RX accounting unchanged.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022121606.732029-2-antonio%40openvpn.net
