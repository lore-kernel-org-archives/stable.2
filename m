Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793999910;
	b=WL49UFjhR4OLzXtdveM0H0d5bjYYblb6k/BasSvuQsK5zdoNYfrxklfOZBDkvnGCxqEH
	 l//6W6Uv1wfBJLGDfkTP2JCgeSLk+Sx8sq6TcSA1d6ScQnmh4bOa+GDpAX158DgepGpMt
	 XpYl40I0zTzMR08X4ythgirikk2dICNW6WjmEp0h8MXmLlsXD2eU7AwbrOUaR5ONCNvbJ
	 ZVPoTnYAQjB1h9/mf9hLqqp7d/N4RQZVjrP3vwY0chG+glCe8OARwWT8ZoewoJA4lVuET
	 y7xZrEYLCO9ymj5XzXjZY2H72lioG6gWSOwSb71nIIzMfXzUuRI+jPScm+Esy9iSA6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793999910;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=dsIj34Cu43OU8nAUF9nVgHZIUjZLU87Dom+4gQ74OIs=;
	b=vT8CKgVhHPeaEE/Z1TgPszVkwqQUeJ5PQc4TS2vQvKBy/GL/N547Fguey/8EZu4zL7cb
	 96Qj3ZvwHmKnyPWgXO4YdznxvnhntbBZERh4/ShL3P0WdoVmY4P5KtqodSZ8WfGeBNmt+
	 9p81eGmWeg69mB/y2W+js97DNhClu4VvI7t29Aj7uLc9wtsFxTouJJd3CUBs5cxPWfAvS
	 KZ3SoJSw9J20b4ludtzKp9rrbrLnAOLMnyK9YumSNm4GXNC7v861EVFs/pQx71ro2SW2H
	 LNNwObuuCKRXJe7fEb2ZeGWKZf96dMUtj8Q2JmjrEjInYzFTwlm/HH/iwdRNUecbCEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUrYolUN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6218606A330;
	Fri,  6 Nov 2026 21:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nUrYolUN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E36C1F008A3;
	Fri,  6 Nov 2026 21:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793999909;
	bh=dsIj34Cu43OU8nAUF9nVgHZIUjZLU87Dom+4gQ74OIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nUrYolUNu79sTI9HQCzgLYCON24rJi9xrm31WxOJg6SPF651K4sbjF8g9Neasyjmr
	 zO+Nr4Gb5rWTWejKr55D6onXVl9m8GncJ8BnyAwKypH3chakHPIHiEcqp8mAFLSn+R
	 7wVs6lLSsjQ4TVCHnflBkchnQetPAT/RmCFaZmIbkLAYVlhiV45OrHF+qliwTiWG7c
	 4pxNbUT+s5wcBJ3ULheZAE0SMl6qWEqVMfpIQi3F1KfL8/Nvwn8knFWoLr36iWUEYj
	 kgvNJEABKNB1128pJ9rwlqVovYrqSK1iaGMrs8RDGTnkAyEEADLDQPlA8codZq1uo7
	 Vd7QS9nio5Baw==
Date: Fri, 6 Nov 2026 13:18:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jure Rebernik <jure.rebernik@luxonis.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] r8169: enable the RxOverflow interrupt again
Message-ID: <20261106131828.2844d23e@kernel.org>
In-Reply-To: <20261101102720.702600-1-jure.rebernik@luxonis.com>
References: <20261101102720.702600-1-jure.rebernik@luxonis.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  1 Nov 2026 11:27:20 +0100 Jure Rebernik wrote:
> Commit 6994520a3328 ("r8169: disable interrupt source RxOverflow")
> removed RxOverflow (RxDescUnavail in the vendor driver) from the
> interrupt mask on the grounds that NAPI is scheduled anyway when the
> chip runs out of RX descriptors. On RTL8125B that does not hold.
> 
> When the RTL8125B runs out of RX descriptors it sets RxOverflow and
> stops receiving. It does not start again when the driver returns
> descriptors to it, only when RxOverflow is cleared in IntrStatus.
> rtl8169_interrupt() clears only the bits it read on entry. If the ring
> fills while NAPI runs with the interrupt mask cleared, RxOverflow is
> set after that read and stays set: NAPI empties the ring, unmasks the
> interrupts and completes, the stopped receiver raises no RxOK, and
> RxOverflow is no longer an interrupt source. Reception stays stopped,
> and every frame is counted in rx_missed, until another event such as
> TxOK makes the handler clear all status bits.

Not really following the explanation, TBH.
In general "ring empty" IRQs are discouraged because the host is likely
overloaded, so having the NIC force the NAPI is not helpful. But sounds
like you say there's some sort of a race?

> This was observed on a machine in real use: an RTL8125B (XID 641) on
> the PCIe bus of an arm64 Qualcomm QCS8550, running v7.2.6. With UDP
> at 800 Mbit/s inbound and nothing sent by the host, reception stopped
> for seconds in 13 of 20 30 s runs, losing 5% to 31% of the datagrams,
> and a single transmitted packet restarted it. To confirm the cause,
> a debugfs dump added to a test build of the driver showed, during each
> stop, IntrMask 0x2f, IntrStatus 0x50, NAPI idle and all 256 RX
> descriptors owned by the NIC. Writing only RxOverflow to IntrStatus
> from user space, through the sysfs PCI resource mapping and with
> nothing transmitted, restarted reception in 17 of 17 stops.
> Reproducing the stall itself needs no kernel modification.
> 
> With this change backported to v7.2.6, 0 of 20 runs stopped and the
> worst run lost 0.03%, on two RTL8125B boards. It was build-tested,
> not run, on this tree, where the single-vector path RTL8125B uses
> is the same as in v7.2. The multi-vector mapping used by RTL8127 is
> not changed and was not tested.
> 
> Restore the mask of the chips that had RxOverflow before that commit.
> Only RTL8125B was tested.
> 
> The investigation was done with an AI coding assistant (Claude Code):
> it wrote the HIL test scripts, the debugfs instrumentation and the
> register tools used above, proposed this change and drafted this
> changelog. I reviewed the change and the evidence, and the test
> results above come from runs on our hardware.
> 
> Fixes: 6994520a3328 ("r8169: disable interrupt source RxOverflow")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jure Rebernik <jure.rebernik@luxonis.com>
> ---
> 
> Notes:
>     This restores RxOverflow for every chip that had it before 6994520a3328,
>     but I could only test RTL8125B. If you prefer, I can send a v2 that sets
>     it for the RTL8125 family only (rtl_is_8125()).
> 
>  drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index cd4ebc654dd0..62709160d354 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -6086,7 +6086,9 @@ static void rtl_set_irq_mask(struct rtl8169_private *tp)
>  		tp->irq_mask = RxOK | RxErr | TxOK | TxErr | LinkChg;
>  
>  		if (tp->mac_version <= RTL_GIGA_MAC_VER_06)
> -			tp->irq_mask |= SYSErr | RxFIFOOver;
> +			tp->irq_mask |= SYSErr | RxOverflow | RxFIFOOver;
> +		else
> +			tp->irq_mask |= RxOverflow;

LLMs point out that you're adding the same bit on both sides so just
add it in the unconditional init of tp->irq_mask above
-- 
pw-bot: cr
