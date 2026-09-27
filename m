Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633722DFA3A;
	Sun, 27 Sep 2026 16:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790527119; cv=none; b=cNqqaYFVbYu3wsQgIs/8xAOcutnbfMt5DyM2vSNJ8QfpOf3fHC4UrBAcYyR91aWRDviLWxp/k/3Q4Fp/M0WRyyHgp8UonFYewJLh3q3GD1T/UG2Nv9reL0iCbZzFOh/AnmscG3oYGj4pLpIKrk4nWhXrBbdQghB+LQQHOIVGGko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790527119; c=relaxed/simple;
	bh=VRgALpw4h+oUkjSn6KJVL524jNGRnP3zspbgJnq0/fU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GJ1TVw5+bcxuWTL697hLOc2eidT3RftX/7gYXgiZFaF8W/yiLhWC8Gr0o2Y3nkdcdNSIQYBaIq6KPlXDw4aG0xSWvp4sF/l1NR0KjdM2G1f9H/Nm3QqGYdqeotlZUWtIn5Xeg+vLGJNSYrgFrvZy1copROM5UxUhYFNBf4xf5B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2Vpnje7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2Vpnje7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980011F000FF;
	Sun, 27 Sep 2026 16:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790527118;
	bh=3Moh5/Zz6s5vpyS8jKb+Mom9Osf9/exVwjsCnhd/yis=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=F2Vpnje7/0LyqpNqPCyn72Fou0rfhO3agf3EYB85bttQdX1ghhHaNCWRBKoibqJWH
	 hWms4iBWtL3SXmDwp3STpU1UykObYKXqz8NekElbrVqKnYpxrab+rCj5IKM/zNFs/c
	 1Atj+r8N2l2OIHG8g9sij/QbwSANzGTps0H8LdgnjkXgfmuN+K8hiFJ+4fnlfu6vQM
	 +TxKjdqvSucop8JHtCljdUBkSii/B9XUUSYGpWbeYYd6eMlulCQx7cFbyV2NVxdUi2
	 /BiQBzB8yZ2f905vBWJaR0QfleK2SdR/kqPS544sqiYyG1Ag+U7BdU9Tfznrcnu219
	 33UmODoSqqvfw==
Subject: Re: [PATCH] net: stmmac: guard FCS stripping against runt frames
From: netdev-bot+sashiko@kernel.org
To: qwe.aldo@gmail.com
Cc: maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, sashiko-bot@kernel.org,
 kuba@kernel.org
Date: Sun, 27 Sep 2026 16:38:37 +0000
Message-ID: <179052711717.2160803.7557770095013132453@kernel.org>
In-Reply-To: <20260923162339.1375698-1-qwe.aldo@gmail.com>
References: <20260923162339.1375698-1-qwe.aldo@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] stmmac_rx() still handles the FCS wrongly when the last buffer
  holds fewer than ETH_FCS_LEN bytes, which is exactly the case the…
- [Medium] The commit message gets the trigger, the scope and the stable
  targeting wrong.

Pre-existing issues:
- [Medium] Under the new guards, a complete frame shorter than
  ETH_FCS_LEN (0..3 bytes, no secondary buffer) is passed on rather than…

--

net: stmmac: guard FCS stripping against runt frames

This commit adds lower bound checks before the 4-byte FCS is stripped in
stmmac_rx_zc() and stmmac_rx(). A final buffer shorter than ETH_FCS_LEN
no longer underflows buf1_len or buf2_len. Such frames are passed
through without stripping.

> Neither path checks that the buffer actually contains at least
> ETH_FCS_LEN bytes. A runt frame delivered by the hardware with a
> buf1_len or buf2_len smaller than 4 underflows the unsigned
> subtraction, producing a very large value. In the XDP zero-copy path
> this wraps data_end backwards:
>
>     buf->xdp->data_end = buf->xdp->data + buf1_len;
>
> giving the XDP/BPF program an enormous data region that extends into
> adjacent kernel memory.

[Severity: Medium]

Is "runt frame" the right description of the trigger for the
stmmac_rx() hunk?

With Split Header active, stmmac_rx_buf2_len() returns the remaining
bytes of the frame:

    plen = stmmac_get_rx_frame_len(priv, p, coe);

    return plen - len;

On the last descriptor this is 1..3 whenever a normal-sized frame
leaves only part of the FCS in the last buffer. Two examples:

  - a frame of dma_buf_sz + 1..3 bytes
  - a frame of hlen + dma_buf_sz + 1..3 bytes that spills into a
    second descriptor

GMAC_CORE_INIT sets GMAC_CONFIG_JE, so the MAC accepts these lengths,
and any sender on the LAN can choose them.

Before this patch, buf2_len wrapped to about 4 GiB in the default
non-XDP receive path and was then passed to:

    if (buf2_len) {
        dma_sync_single_for_cpu(priv->device, buf->sec_addr,
                                buf2_len, dma_dir);
        skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
                        buf->sec_page, 0, buf2_len,
                        priv->dma_conf.dma_buf_sz);

Could the commit message describe this case? It looks like the one that
is reachable in practice.

In the zero-copy path, stmmac_xdp_set_prog() disables SPH while XDP is
active:

    priv->sph_active = priv->sph_capable && !stmmac_xdp_is_enabled(priv);

So buf1_len < 4 there needs a complete, error-free frame shorter than
4 bytes. stmmac never enables MTL FUP/FEP, and CRC errors set
RDES3_ERROR_SUMMARY, which gives discard_frame. That seems to need a
malfunctioning device.

Also, buf1_len is unsigned int. On 64-bit, data + buf1_len moves
data_end about 4 GiB forward, not "backwards". On 32-bit it does wrap
backwards, but then data_end < data and the region is empty, not
"enormous". Could that sentence be reworded?

> Fixes: bba2556efad6 ("net: stmmac: Enable RX via AF_XDP zero-copy")

This tag covers only the stmmac_rx_zc() hunk. The FCS stripping in
stmmac_rx() came from 88ebe2cf7f3f ("net: stmmac: Rework stmmac_rx()").
It was last changed by 0f296e782f21 ("stmmac_pci: Fix underflow size in
stmmac_rx").

Should there be another Fixes: tag, so that stable trees without
zero-copy support also pick up the stmmac_rx() hunk?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index d5a984ad864f2..d3e16a523abde 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5638,7 +5638,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
>  		len += buf1_len;
>  
>  		/* ACS is disabled; strip manually. */
> -		if (likely(!(status & rx_not_ls))) {
> +		if (likely(!(status & rx_not_ls)) &&
> +		    likely(buf1_len >= ETH_FCS_LEN)) {
>  			buf1_len -= ETH_FCS_LEN;
>  			len -= ETH_FCS_LEN;
>  		}

[Severity: Medium]

This isn't a bug introduced by this patch, but with this guard a
complete frame of 0..3 bytes is passed through rather than dropped. It
goes to the XDP program and, on XDP_PASS, to stmmac_dispatch_skb_zc().
The new check in stmmac_rx() does the same for a single-buffer frame
under 4 bytes.

The short skb then reaches two helpers that don't check its length:

  - stmmac_rx_vlan() reads h_vlan_proto and the TCI without checking
    skb->len.
  - In eth_type_trans(), eth_skb_pull_mac() ignores a failed ETH_HLEN
    pull, so h_proto is read from beyond the received data.

Later, eth_header_parse() can copy h_source bytes that were never
received into the AF_PACKET sll_addr.

To reach this, the device has to report a good, complete frame under
4 bytes. That should not happen, since FUP/FEP are not enabled and CRC
errors end up as discard_frame. Frames of 4..17 bytes already produced
the same kind of short skb before this patch.

Would it make sense to drop frames shorter than ETH_HLEN + ETH_FCS_LEN
instead of passing them through, perhaps as a separate hardening
change?

> @@ -5810,10 +5811,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  
>  		/* ACS is disabled; strip manually. */
>  		if (likely(!(status & rx_not_ls))) {
> -			if (buf2_len) {
> +			if (buf2_len >= ETH_FCS_LEN) {
>  				buf2_len -= ETH_FCS_LEN;
>  				len -= ETH_FCS_LEN;
> -			} else if (buf1_len) {
> +			} else if (buf1_len >= ETH_FCS_LEN) {
>  				buf1_len -= ETH_FCS_LEN;
>  				len -= ETH_FCS_LEN;
>  			}

[Severity: High]

When buf2_len is 1..3, doesn't the FCS straddle two buffers? The FCS is
always the last 4 bytes of the frame. In that case buf2 holds only the
tail of the FCS, and the other 4 - buf2_len FCS bytes sit at the end of
the previous buffer.

Take a single-descriptor frame with SPH active that is not header
split (hlen == 0), for example a non-IP frame of dma_buf_sz + k bytes
with k in 1..3:

  - stmmac_rx_buf1_len() returns min(dma_buf_sz, plen), which is
    dma_buf_sz.
  - stmmac_rx_buf2_len() returns plen - len, which is k.

The new else branch then trims 4 bytes from buf1, which removes k real
payload bytes. Later, the k FCS bytes in buf2 are still appended:

    if (buf2_len) {
        ...
        skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
                        buf->sec_page, 0, buf2_len,
                        priv->dma_conf.dma_buf_sz);

Does the skb end up with FCS bytes in place of its last k payload
bytes?

Now take a multi-descriptor SPH frame that spills k = 1..3 bytes into
its last descriptor. stmmac_rx_buf1_len() returns 0 there:

    /* Not first descriptor, buffer is always zero */
    if (priv->sph_active && len)
        return 0;

So neither branch runs and nothing is stripped. All 4 FCS bytes stay at
the end of the skb and are counted in rx_bytes. Is that intended?

Any LAN host can send these lengths, since GMAC_CORE_INIT sets JE, SPH
is on by default on capable cores, and no XDP is involved. Later, IP
frames may still be marked CHECKSUM_UNNECESSARY.

Would it be more correct to trim ETH_FCS_LEN - buf2_len bytes from the
preceding buffer or frag and set buf2_len to 0, or else drop the frame?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923162339.1375698-1-qwe.aldo%40gmail.com
