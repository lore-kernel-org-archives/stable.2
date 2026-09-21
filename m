Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5AA3BB113;
	Mon, 21 Sep 2026 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789997710; cv=none; b=sk6/g+76pCE3GUzvA4U8GLktzDq4L4Np0QEgEFc6UEBEUs7FQAdoKi5stgRbcUGhANyd8eysRKSD94fVMaWPvZEl951UXQP4MGsBhc6bbDmCPZHfTAdu/GAtH4TxHsKkizaUGkaE3rRLKnwvR1hvBC2Dcn8+6K/uwYHmdfbOvOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789997710; c=relaxed/simple;
	bh=UWC88YrCSjuBEAYv6YmW2Vz2vGkRxAVkZItvmE4GaUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H91PowNPO4WFj1603If/jH6GMiwpd0S2zF3RUWkE/3OmgxMGLy3fKSuqrDBa9af5jGqzbwXVKar3Ocl9qveQLJD5TaTjAMzZDnalp09wiXjonEqvZdOo00ushD3LMyuMZnWRQ60j89iXGVwx38kYNctvn0Wx7FHyBaHRM2JJe94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=NaDMSG2A; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="NaDMSG2A"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=XEhYqIMshobqJ5nP45/is74QQI1p741fQ2FIDVZGPoY=;
	b=NaDMSG2Ah0e/mu5fVfFCmB1PPXMamt0K5AvjyuxytV80IrdKdQxfCLh73J2dtS
	ff4eHx5CkSICr1DosMBRsR8AQ+9UcmtREfQltqIk2tOtQ6Z/skzlw47RtlumAFaw
	un/oJv6Qj5HA3ulhmRFwZLllgx5uKINrLFXXviUwvIjtI=
Message-ID: <b6b2a6bb-e00c-4bcf-8359-525730c5ea33@126.com>
Date: Mon, 21 Sep 2026 21:31:30 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: ethtool: validate TX coalesce before
 reprogramming RX
To: netdev-bot+sashiko@kernel.org
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xiaolinkui@kylinos.cn, stable@vger.kernel.org
References: <20260920015647.1783574-1-xiaolinkui@126.com>
 <178995636352.2160803.2776927980309704252@kernel.org>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <178995636352.2160803.2776927980309704252@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_+CzMbFqX1l4Bw--.17993S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF48ZFyfuF4rtFy5GF48Zwb_yoWxWF45pF
	W5CFZrtw1ktrWFk3s7Ca18Wrya934fKFsxJw1rtr92k3W5uryYvr1fKr1jgFZ7Cr4kZw1j
	kF4FqFZrCwn8A3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UxDGOUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlRSAV2qxMbSNHQAA3Y

 > Thank you for your contribution! Sashiko AI review found 1 potential
 > issue(s) to consider.
 >
 > Critical: 0 · High: 1 (1) · Medium: 0 · Low: 0

Both issues are legitimate, thanks for the detailed analysis. v3 reworks
the fix and adds a second patch; details inline.

 > - [High] Incomplete fix: the TX validation relocated to the top of
 >   __stmmac_set_coalesce()...
 >
 > Does this reordering actually fix the per-queue case described in the
 > changelog? [...]
 > On a device with rx_queues_to_use > tx_queues_to_use (dwmac-intel
 > tgl_common_data sets 6 RX and 4 TX queues, so queues 4 and 5 are 
RX-only),
 > does ethtool -Q ethX queue_mask 0x10 --coalesce rx-usecs N still return
 > -EINVAL here?

Yes, it still does. tgl_common_data() sets rx_queues_to_use = 6 and
tx_queues_to_use = 4, __stmmac_get_coalesce() reports tx-usecs and
tx-frames as 0 for index 4 and 5, ethtool feeds those zeros straight
back into the setter and the relocated test rejects the request. v2
changed when such a request fails, not whether it succeeds.

 > If so, is the net effect for that queue not worse than before? 
Previously
 > the RX watchdog and rx_riwt[]/rx_coal_frames[] were programmed and 
-EINVAL
 > was returned; now the early return means the RX part is never applied, so
 > per-queue RX coalescing on an RX-only queue index has no effect at all.
 >
 > There is a second consequence in the ethtool core. [...]
 > For an RX-only queue the saved backup necessarily carries 
tx_coalesce_usecs
 > == 0 and tx_max_coalesced_frames == 0, so the new first check rejects the
 > replay before the RX block runs.  Can the RX watchdog and rx_riwt[] 
of that
 > queue therefore stay at the values of the failed request after a 
later queue
 > in the mask fails?

Correct on both counts, and the roll-back one is the more serious of the
two: ethtool_set_per_queue_coalesce() discards the return code of the
replay, so an early -EINVAL there silently leaves the RX watchdog of an
already-applied queue at the value of the failed request.

 > Would making the validation direction-aware, so the TX checks only 
apply when
 > all_queues || queue < tx_cnt and the rx_riwt check only when
 > all_queues || queue < rx_cnt (plus the getter reporting ~0 instead of 
0 for
 > the inapplicable fields), address both directions rather than reordering
 > alone?

That is what v3 patch 1/2 does, minus the getter change:

	has_rx = all_queues || queue < rx_cnt;
	has_tx = all_queues || queue < tx_cnt;

	if (has_tx &&
	    ec->tx_coalesce_usecs == 0 && ec->tx_max_coalesced_frames == 0)
		return -EINVAL;

	if (has_tx &&
	    (ec->tx_coalesce_usecs > STMMAC_MAX_COAL_TX_TICK ||
	     ec->tx_max_coalesced_frames > STMMAC_TX_MAX_FRAMES))
		return -EINVAL;

	if (has_rx && priv->use_riwt) {

has_rx also gates the application, so the "else if (queue < rx_cnt)"
inside the RIWT block becomes a plain "else", and the TX store keeps its
own has_tx test. All validation still runs before the first
stmmac_rx_watchdog() call, so the property v2 was after is retained: a
request is either applied completely or rejected without touching the
device.

The mirrored case is fixed by the same change. With use_riwt set and
queue >= rx_cnt, has_rx is false, so stmmac_usec2riwt() is never asked
to convert the rx-usecs 0 that the getter reported and the MIN_DMA_RIWT
test no longer rejects per-queue TX requests for a TX-only index.
tx_queues_to_use > rx_queues_to_use does not occur in the in-tree
platform data - dwmac-intel is the other way round - but
stmmac_probe_config_dt() parses snps,rx-queues-to-use and
snps,tx-queues-to-use independently and clamps each one on its own, so
DT can produce it.

I left __stmmac_get_coalesce() reporting 0 rather than ~0. Once the
setter ignores the inapplicable fields the read-modify-write round trip
works either way, and ~0 would show up as 4294967295 in
"ethtool --per-queue ... --show-coalesce" for the indices that print 0
today. If the ~0 convention is wanted it should be a separate change,
together with whatever displays it.

 > [Severity: High]
 > This isn't a bug introduced by this patch, but since the validation 
is being
 > moved anyway, is the zero tx_max_coalesced_frames case worth handling 
here
 > too? [...]
 > That is reached from stmmac_xdp_xmit_back() for XDP_TX and from
 > stmmac_xdp_xmit() for ndo_xdp_xmit, so does this divide by zero in 
softirq
 > context on x86?

The divide by zero is real and reachable. tx_coal_frames[] starts at
STMMAC_TX_FRAMES in stmmac_init_coalesce() and can only become 0
through ethtool, and dwmac-intel TGL/EHL is exactly the x86 platform
where the modulo traps.

The fix belongs in stmmac_xdp_xmit_xdpf() rather than in the setter,
because tx-frames 0 is a supported request: it only stops the frame
count from raising TX completion interrupts, while the coalescing timer
that stmmac_xmit(), stmmac_tso_xmit(), stmmac_finalize_xdp_rx() and
stmmac_xdp_xmit() arm through stmmac_tx_timer_arm() keeps reclaiming the
descriptors. That is why those paths test the divisor - the test came
with c2837423cb54 ("net: stmmac: Rework TX Coalesce logic") and was
extended to the zero-copy path by 132c32ee5bc0 ("net: stmmac: Add TX via
XDP zero-copy socket") - and why __stmmac_set_coalesce() rejects the
request only when tx-usecs is zero as well, since then nothing would
complete the transmissions. Rejecting tx-frames 0 outright would break
that configuration.

So v3 adds patch 2/2, giving stmmac_xdp_xmit_xdpf() the missing test,
with be8b38a722e6 ("net: stmmac: Add support for XDP_TX action") as the
Fixes tag.

 > The other TX sites do test for zero, but the guard and the divisor are
 > separate unannotated loads of the same plain u32 with no lock [...]
 > Can a concurrent ethtool store of 0 land between the guard and the modulo
 > reload?  Would a single READ_ONCE() snapshot per transmit path be
 > appropriate?

In principle yes: nothing forces the two loads to observe the same
value. They are adjacent in all four chains with no call or barrier in
between, so compilers are likely to CSE them, but that is a favour and
not a guarantee. Annotating it properly means one snapshot per transmit
path plus WRITE_ONCE() on the stores in __stmmac_set_coalesce(), i.e. a
conversion of all four sites at once, which does not belong in a stable
fix. Patch 2/2 therefore uses the plain test that matches the existing
three; I will send the READ_ONCE()/WRITE_ONCE() conversion separately if
it is wanted.

pw-bot: cr

