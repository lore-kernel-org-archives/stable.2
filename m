Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDA0361DA6;
	Mon, 21 Sep 2026 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789971535; cv=none; b=uKE8GW/npKc+DjFuc5hH3oGEyScuCs2FVpSSW8S5l4QPdPQlnW+4WZ50mTk/EQnw0u4zAPjzu3HItmSnhAxQAWGMZEMQsn7XQnHJ3F/iw6hFH+eoD/iX8RDuYpqPn/ZMcjI9l54yX16mjJCw9cK/3KxkuN4lEKVx1BVHo3/YXGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789971535; c=relaxed/simple;
	bh=zQwdudy+/e6uVIiCTCuEoYe5+im3otbNBYOfnHzW0hI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J7zk7idh/7RDJu9nt2mRDuBBz7CD3JIzByY8MD5vs15L7ll5GaRnbptmrEIKKWBsWrALqMas3HGkHdNrNN9ZdzBX8CqqhKFHTT3kSVSsE+2fstPqmWsFojOpX6yPwquoGBa5NCqV2nMIOZsh+FSE+cN2DrecqR4cp2BUmWyuoBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CY2RMC+D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CY2RMC+D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B581F000FF;
	Mon, 21 Sep 2026 06:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789971534;
	bh=4cTrkejZqjO54vzP9W02sQt9N5PF/Wx2jSHjrZFM5k4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CY2RMC+DNz9xNIoZK14hBmxfCcFt6QyKdMK/xwH5iNIzCNzArlB984Q+Wfv6djmVw
	 CBv/hUadhRgr8wviJST5L7mhqEb7aE2XqFrn438zP2nipDhlChd/kdatBBSyIoomeG
	 DegjBaIaAaEXCVxmgvEno4PK7FbEfhqDjHRBsfdUoIlf2AUM+rNuHmUj6W6a90E+df
	 LjDFF2Di7jyxTwpYJZxzLPj1DS/Pz3Y5DxUTEHQoC9g2OxbPOiXE4e2nBgVOuAfLk+
	 zPXijxa2lrTKU3HN41BSqZhwz7Q8G+1D29b3oN/qZqzME2iPDzPSAnUHKXd4ftqfXH
	 TKzTisJAeiT1w==
Subject: Re: [PATCH net v2] net: stmmac: do not cache the new TSO MSS before
 it reaches the DMA
From: netdev-bot+sashiko@kernel.org
To: xiaolinkui@126.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xiaolinkui@kylinos.cn, stable@vger.kernel.org
Date: Mon, 21 Sep 2026 06:18:53 +0000
Message-ID: <178997153300.2160803.9722094587431911734@kernel.org>
In-Reply-To: <20260920061609.1919876-1-xiaolinkui@126.com>
References: <20260920061609.1919876-1-xiaolinkui@126.com>
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message of "net: stmmac: do not cache the new TSO
  MSS before it reaches the DMA" describes a failure mode that cannot…

--

net: stmmac: do not cache the new TSO MSS before it reaches the DMA

The patch moves the tx_q->mss update in stmmac_tso_xmit() so it happens
only after the MSS context descriptor gets its OWN bit, keeps tx_q->cur_tx
parked on the context descriptor slot while the frame is being built, and
releases that descriptor explicitly on the error paths.

The code change itself looks fine; the question below is only about the
changelog.

>     The next skb carrying the same MSS then compares equal to the cached
>     value, so no context descriptor is emitted and the hardware segments the
>     TCP stream with a stale MSS, generating frames whose payload size does
>     not match what the stack accounted for.

[Severity: Medium]
Can that on-the-wire symptom actually be observed before this patch?

Before the patch, the abandoned context descriptor sits at the slot that
tx_q->cur_tx had when stmmac_set_mss() was called, and cur_tx was already
advanced past it, so every later frame is queued behind that descriptor.
Neither dwmac4_set_mss_ctxt() nor dwmac4_release_tx_desc() ever sets the
OWN bit, so the slot stays at OWN=0.

The error paths in stmmac_tso_xmit() return without calling
stmmac_flush_tx_descriptors(), and that is the only place the tail pointer
is written:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_flush_tx_descriptors() {
	...
	stmmac_set_queue_tx_tail_ptr(priv, tx_q, queue, tx_q->cur_tx);
	...
}

so the engine stays parked on the abandoned context descriptor. When a
later xmit bumps the tail, the DMA re-fetches that slot, finds OWN=0 and
suspends again.

Meanwhile stmmac_tx_clean() reclaims the OWN=0 context slot in software and
then stops at the first descriptor the DMA still owns:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_tx_clean() {
	...
		if (unlikely(status & tx_dma_own))
			break;
	...
}

which pins dirty_tx just past the stuck slot, so cur_tx can never wrap
around and rewrite it.

Doesn't that mean no frame queued after the mapping failure is segmented at
all, stale MSS or otherwise, and that the real pre-patch consequence is a
wedged tx ring recovered only by the watchdog / stmmac_tx_err() path, which
resets the channel and clears tx_q->mss via stmmac_reset_tx_queue()?

The patch does fix that by keeping tx_q->cur_tx on the context slot and
releasing mss_desc on the error paths, but the changelog does not mention
the stall. Since this carries a Fixes: tag and Cc: stable, could the
changelog describe the tx stall and controller reset instead of the
mis-sized segment description?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260920061609.1919876-1-xiaolinkui%40126.com
