Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795141325;
	b=WPKTiIVSfaum1RvTi+H7h/MEQ2rY9j3fA/8Rd9goXNcWw6W5u+uxrUnuGtzk71L1gcAD
	 mnamykGFEAzWo6ufJaXGzkQt78TJzco+TbwV7/e1tWUUd0nTEnsLiMGnqOlw9vjE7Wydw
	 YfJG7byZbCjafg5m9TEaIovf0QoIvXAbHLQJuhMcvfK06/Xfn+PC2PPZT8O3u01wb02U7
	 QU5zHR/HbYU/aweCg4AEq965iIx2V6ruFskp7k1o4wFjt0DkB8tVEAZ5NwrH1TYujAyyl
	 /78OWp5HMckOwFyOE8wDuj7wdEDYyE/tp0Mf6m/XI3j3cXHHaMz29vMAVhEhdnTD9ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795141325;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=bFBl93slCnnNDRuvqGW5M/JPZcyWyl35W0K2HpRlQYg=;
	b=RJCAM5XcVt2YeMY1JdD67Po4pxvSKfhj2NjQObMskI4bgIDMHuGmJVKjHhZB/nQz/iJY
	 jRkRHar+JHGVW+lNU5eYYlRpSpfDNxZ/NAmBnc88P9dApLzV+Qck0A2IfnwZrHkrH6oxf
	 goIPsp4XBKXcfQl57xvEVmP2NFn94k1ZQXSrLRQ/SDvPrT51IdJPzdZvgmumxlFkljZHt
	 7jiGHJ2TnjmMZzaXOaSIoNhIYKAi8OwhfIII5pMS58fMWe5nJgj/eUC+rqJcIRAD1vvvR
	 Plfa9vBcM4qp8xK1LWc9RRMFVCT1K1AyNupXs+FZYVWRu4gjO8aFfiW6C5f48FPiIRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gG2M71cB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A97606A325;
	Fri, 20 Nov 2026 02:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gG2M71cB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18EC01F000E6;
	Fri, 20 Nov 2026 02:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795141325;
	bh=bFBl93slCnnNDRuvqGW5M/JPZcyWyl35W0K2HpRlQYg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=gG2M71cBscSjViBbxE+PlolahxGfDD9MSXLIULV2JAbTs7dEHHBC+k4DB5BCABl5O
	 O50CbRfQXbcc9ZSTJ1sFGzU5NR63Pac0YVJQjTEiS77Q+nlhVY/1NKhrSkG3ETIBzD
	 wH45SPuBDJfbkVx+cYWcyT4On+Ap9KInZ400A2c5zcTEt6sjjDBCUYUXg7vsFtosQc
	 y7aWkU1HYwIYbO0Ha4am7nkpfd39MWD0lROHuArjo3VRCMbvtcY4LbTzRQ+klvBjR/
	 Um8U4qDa8OpvW6mIo4aqD195OqfqrO21B1WH5D+TNJERK7iRMFMYPr7Bss3aFUshaP
	 2M6An+V217zFw==
Subject:
 Re: [PATCH net v10 3/4] net: hsr: segment GSO before per-frame forwarding
From: netdev-bot+sashiko@kernel.org
To: xiexinet@gmail.com
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 shuah@kernel.org, kees@kernel.org, petr.wozniak@gmail.com,
 qingfang.deng@linux.dev, fmaurer@redhat.com, luka.gejak@linux.dev,
 bigeasy@linutronix.de, xiaoliang.yang_1@nxp.com, skhawaja@google.com,
 liuhangbin@gmail.com, stable@vger.kernel.org, sdf.kernel@gmail.com,
 lukma@denx.de, fmancera@suse.de, danishanwar@ti.com
Date: Fri, 20 Nov 2026 02:22:03 +0000
Message-ID: <179514132368.3136.11119943958824488606@kernel.org>
In-Reply-To: <20261117141922.20-4-xiexinet@gmail.com>
References: <20261117141922.20-4-xiexinet@gmail.com>
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

- [Low] This patch adds a second way of counting rejected input frames in
  net/hsr/hsr_forward.c, so the same kind of drop now lands in different…

--

net: hsr: segment GSO before per-frame forwarding

This patch adds hsr_forward_input() as a single forwarding entry for
master TX and for frames received on any port. GSO aggregates are
segmented outside seqnr_lock, and each segment is then numbered and
forwarded under the lock. Aggregates that cannot be segmented safely are
dropped and counted in the core per-CPU drop counters. NETIF_F_GSO_MASK
is removed from the master's hw_features.

> diff --git a/net/hsr/hsr_forward.c b/net/hsr/hsr_forward.c
> index 44f6d9c83180a..5e49f2bb9e39b 100644
> --- a/net/hsr/hsr_forward.c
> +++ b/net/hsr/hsr_forward.c

[ ... ]

> @@ -794,3 +797,156 @@ void hsr_forward_skb(struct sk_buff *skb, struct hsr_port *port)
>  	port->dev->stats.tx_dropped++;
>  	kfree_skb(skb);
>  }
> +
> +/* Master TX and interlink RX are numbered locally: number and submit
> + * one frame at a time under seqnr_lock, as before. LAN A/B input
> + * keeps its received number and needs no lock.
> + */
> +static void hsr_forward_frame(struct sk_buff *skb, struct hsr_port *port)
> +{
> +	struct hsr_priv *hsr = port->hsr;
> +	bool numbered = port->type == HSR_PT_MASTER ||
> +			port->type == HSR_PT_INTERLINK;
> +
> +	if (numbered)
> +		spin_lock_bh(&hsr->seqnr_lock);
> +	hsr_forward_skb(skb, port);
> +	if (numbered)
> +		spin_unlock_bh(&hsr->seqnr_lock);
> +}
> +
> +/* One count per rejected GSO input on its entry device. */
> +static void hsr_gso_drop_stat(struct hsr_port *port)
> +{
> +	if (port->type == HSR_PT_MASTER)
> +		dev_core_stats_tx_dropped_inc(port->dev);
> +	else
> +		dev_core_stats_rx_dropped_inc(port->dev);
> +}

[Severity: Low]
This isn't a functional bug, but this adds a second way of counting
rejected input frames in hsr_forward.c. The same kind of drop can now end
up in different counters.

For a GSO aggregate rejected by the hsr_forward_input() gate,
hsr_gso_drop_stat() counts once in the core per-CPU counters. Slave and
interlink ports get rx_dropped and the master gets tx_dropped.

Plain frames, and each segment produced by hsr_forward_input(), still go
through hsr_forward_frame()->hsr_forward_skb(). When fill_frame_info()
fails there, the existing out_drop path counts the drop in legacy
tx_dropped for every port type:

net/hsr/hsr_forward.c:hsr_forward_skb() {
    ...
out_drop:
	rcu_read_unlock();
	port->dev->stats.tx_dropped++;
	kfree_skb(skb);
}

So on a slave port, a rejected frame goes to legacy tx_dropped if it was
a plain frame or a segment. It goes to core rx_dropped if it was a whole
GSO aggregate. Segments that fail fill_frame_info() are counted once per
segment in legacy tx_dropped.

The commit message says:

    Drops are counted once on the entry device in the core per-CPU drop
    counters.

That covers only the gate drops, not the segment drops counted in
hsr_forward_skb().

hsr_forward_do() uses yet another convention, legacy rx_dropped on the
receive port:

net/hsr/hsr_forward.c:hsr_forward_do() {
    ...
		if (!skb) {
			frame->port_rcv->dev->stats.rx_dropped++;
			continue;
		}
    ...
}

Would it make sense to bring these drop sites onto one convention? At
minimum, could the commit message say that segments rejected later are
still counted in legacy tx_dropped?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261117141922.20-1-xiexinet%40gmail.com
