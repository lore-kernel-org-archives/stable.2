Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795466368;
	b=hbpIUnH6ZRnRg9gg7SDcAGSLGNgf5lFeeeOh91iLAzYJLtPeHwFoOt+KSdM6LhywnWw9
	 9wk/UCIooCeMc/bKkcupxE9W8KdwVKPgi7aviOFcCgDZGJEWCktfyuqOF1cQhGtzVq5PB
	 6grRFgzf351jicknMB31kppjVO/4P6+6I3QmsAZqO7rTE0s0cp4sIBgY3qSN47WynOeIt
	 V+qBtipQulyXxcwAlFVuXgi45HdbHVMgpszQG9qkm+bhKn0+HrxzZcaaTKy+W3dT+1ri/
	 CJzvuFxorDidHMnm+ZqluUcCtj2l8Lo1hS+8evbkgJAG9s+AVDMA4iQqo6HIjZoY1ZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466368;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=uYHZ9xBPT+FC2JvbmkS0mkpOSIDYPq7bEQsGc7x1jrs=;
	b=UwLj+6rU6Y23rFCJm0qmOWfKkoqYW0cQxNpxuYRdssujfWlTFO5yFjAS9OlPXq2rHau/
	 Wc9sd7To+tOSJIOTmzx4XQMrNGLHXwroF42VeQj1jEWUPhOpErOBjixvokUNeuNZY0xrQ
	 bGgUrTEca5ibJB575pr03pgi/8GZ60O1e+cSCLYxzEsqSiS0lOODGOgUAo7kKlOb0m6xx
	 1DdrA9W6P40L/a0s5LlhXL3ISx1z3wPgDE2xHMuEpru1hNJZ2ryiTn8yT3CB/+hB7ChuE
	 l4X0ZS+rVMXBABU6tCKreMS7PqBRXtXONCguIlON5F3crHkliIXBXH9kAAYr1timcyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y1cOvA/3";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9574606A31E;
	Mon, 23 Nov 2026 20:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y1cOvA/3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCC91F000CF;
	Mon, 23 Nov 2026 20:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795466368;
	bh=uYHZ9xBPT+FC2JvbmkS0mkpOSIDYPq7bEQsGc7x1jrs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Y1cOvA/3nz30UZogGyFzZjrVjryx7oc7wKW6obzWqBB3TWb4RMIOg0Ao6mc8e2gpm
	 Omgs8pdxzANnqA1L6RAKqzsNzpJLetu/IFHidIpD/zWuu21tuNhSuc0pYFwM0ermHx
	 lqxuBsU6oU2sZmmNF97TqkRHMXq6w9UF0g+QPYbUQ74SKmAXzWFoWo01G8h4L11i6e
	 RjPBNuOeWAGVwlFtHn+yzgnI/K5Ers+K1ki0vCqQ8HuyTJjrXGSM5a/131eFH89ZAo
	 zCCD2DoH+oTc5O6MXUm9b9k3r92G11RhMWp606G6mkEhChpZ5TmUH60gsmk0m6foTo
	 69TECRTRKapeQ==
Subject: Re: [PATCH net v2 1/3] tls: device: keep tls_sw_fallback() from
 encrypting its own output
From: netdev-bot+sashiko@kernel.org
To: rjethwani@purestorage.com
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, john.fastabend@gmail.com,
 kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, tariqt@nvidia.com,
 alice.kernel@fastmail.im
Date: Mon, 23 Nov 2026 20:39:27 +0000
Message-ID: <179546636707.3135.15103841065368039377@kernel.org>
In-Reply-To: <20261119191341.4089157-1-rjethwani@purestorage.com>
References: <20261119191341.4089157-1-rjethwani@purestorage.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch makes skb->decrypted the marker for 'still needs TLS
  encryption': tls_sw_fallback() now skips skbs with…
- [Low] The new early return in tls_sw_fallback()
  (net/tls/tls_device_fallback.c:377-379, '/* Already encrypted, e.g. by…

--

tls: device: keep tls_sw_fallback() from encrypting its own output

This patch makes tls_sw_fallback() pass through skbs that do not have the
decrypted bit set, and clears that bit on the output of complete_skb(). The
aim is to keep a second software fallback pass (for example at the bond
master and then again at the slave) from re-encrypting ciphertext with the
same rcd_sn and IV.

> diff --git a/net/tls/tls_device_fallback.c b/net/tls/tls_device_fallback.c
> index b547027cc879f..57d8f6b50e4dd 100644
> --- a/net/tls/tls_device_fallback.c
> +++ b/net/tls/tls_device_fallback.c
> @@ -192,6 +192,9 @@ static void complete_skb(struct sk_buff *nskb, struct sk_buff *skb, int headln)
>  	skb->destructor = NULL;
>  	skb->sk = NULL;
>  
> +	/* nskb is encrypted now */
> +	nskb->decrypted = 0;
> +

[Severity: High]
Does this also cover the hardware offload path?

complete_skb() keeps nskb->sk = sk. The driver side check for hardware
encryption does not look at skb->decrypted:

include/net/tls.h:tls_is_skb_tx_device_offloaded() {
	...
	return sk && sk_fullsock(sk) &&
	       (smp_load_acquire(&sk->sk_validate_xmit_skb) ==
	       &tls_validate_xmit_skb);
}

So drivers still treat software fallback ciphertext as offloaded.

Take a TLS_HW socket offloaded on mlx5 eth0 whose route later moves to
vlan@eth0:

vlan@eth0:
  tls_validate_xmit_skb()
    dev != netdev, not a bond master
    tls_sw_fallback()->complete_skb()    /* ciphertext, decrypted = 0 */
  vlan_dev_hard_start_xmit()
    dev_queue_xmit(eth0)

eth0:
  tls_validate_xmit_skb()
    dev == netdev, skb returned unchanged
  mlx5e_accel_tx_begin()
    tls_is_skb_tx_device_offloaded() returns true
    mlx5e_ktls_handle_tx_skb()
      state->tls_tisn = priv_tx->tisn;   /* in-order seq */

In that case, would the NIC encrypt the software ciphertext a second time
with the same record keystream and put plaintext on the wire?

mlx5e_ktls_handle_tx_skb() only checks skb->decrypted in the
MLX5E_KTLS_SYNC_SKIP_NO_DATA branch. nfp_net_tls_tx() also decides only
through tls_is_skb_tx_device_offloaded(), and it attaches ntls->fw_handle
when ntls->next_seq == seq.

This path existed before this patch. However, the commit message says the
bit is cleared "so its output is not encrypted again", and that doesn't
seem to hold for the hardware path.

Should tls_is_skb_tx_device_offloaded() also require skb_is_decrypted(skb)
so that it follows the same rule?

[ ... ]

> @@ -371,6 +374,10 @@ static struct sk_buff *tls_sw_fallback(struct sock *sk, struct sk_buff *skb)
>  	s32 sync_size = 0;
>  	u64 rcd_sn;
>  
> +	/* Already encrypted, e.g. by the bond master */
> +	if (!skb_is_decrypted(skb))
> +		return skb;
> +

[Severity: Low]
This isn't a bug, but is this comment accurate for every skb that takes
this return?

Data written before setsockopt(TLS_TX) also has decrypted = 0, because
tcp_sendmsg_locked() does:

	skb->decrypted = !!(flags & MSG_SENDPAGE_DECRYPTED);

Only tls_push_data() and tls_device_write_space() pass that flag, so that
data was never encrypted by kTLS.

Also, the existing bypass further down in tls_sw_fallback() no longer
seems reachable for the packets it describes:

	if (fill_sg_in(sg_in, skb, ctx, &rcd_sn, &sync_size, &resync_sgs)) {
		/* bypass packets before kernel TLS socket option was set */
		if (sync_size < 0 && payload_len <= -sync_size)
			nskb = skb_get(skb);
		goto put_sg;
	}

Three things make it unreachable for those packets:

- Only decrypted = 1 skbs reach fill_sg_in() now.
- Those skbs are created after the start marker set in
  tls_set_device_offload().
- tcp_skb_can_collapse() refuses merges across a decrypted mismatch.

Should the new comment also mention pre-offload plaintext? And should the
start marker bypass, along with the matching start marker handling in
fill_sg_in(), be updated or removed?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261119191341.4089157-1-rjethwani%40purestorage.com
