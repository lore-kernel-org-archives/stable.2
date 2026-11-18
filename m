Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795015945;
	b=x+CgiJIPdCQzfIXuuwsDKyVaLTXOfQVpGriUPCiYmaeTQTp9mSqpujIs6gt4WStLwIN/
	 FDDselCvPSoqOGb0SmAaJmnctpxH8deIStnbhQBlksBrmmT4yB/UUipnOiiR5+Kc/23f/
	 hSRc0Ych3Sq1FScnbcSmFBMYqVbvlCftMAobrB1vD9X+KqgqxfReIsvN3IvUPOXMKtF9g
	 hmeWgkVqGh4hMeRGbEdr1Grcgu/Iu7H3F3AUtp4GT+OnDSGoLfTCU0h0cyvpeWVZKDmXv
	 ot7g7QTMzOyZYTE2/MMJ+ntreVNq4e4LRk7h3ooRgvpW3eiU8SH3WW12+ElvkgTuTyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795015945;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=CUTDYfj/NI7vPhfySbvU/8wA3af+cG4HXcFhDsJtznQ=;
	b=19dWOsgTUc7HGh7gc21V/DfZKaQ1DlprMlV2AQbIDm1iXMhzZPS0JV7xLoy34Yu4Yfyh
	 47GVqWc+SJStOoZFwhqMbAUVlHeHB6DzssGBa8lqlh2Lj50hNuflqRvSTU8dGT+VTpua3
	 aI4c3r5EQCjd+X461nKeih1ZhNBmnAMPzbsrmdqFCSgFdnzovgg1eyKwzQZonofbovXQf
	 SMtzMR5YIW7WcRmG3sEQfwPG8nElk53+eNxnFBFa5fJ/QElqfE1KB4hsYxzsMZaILdHtv
	 9wE2r+Bpn0tqDrNk7jllFNnh9b62Oby3VP+AJesSE5daxlg4z1/tYjgODVftD9qXzVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZxyL1JMC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C8D606A31C;
	Wed, 18 Nov 2026 15:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZxyL1JMC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8071F000C5;
	Wed, 18 Nov 2026 15:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795015945;
	bh=CUTDYfj/NI7vPhfySbvU/8wA3af+cG4HXcFhDsJtznQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZxyL1JMCOvrqNjwR/CLKPpAzeQNk+OwfnkiPVrJTJ0zeD9IY2bLRl+Tv8DUSHtEtR
	 0391ymAd+beaNlleASnPtaCjq8N+iJfNvWuE+TX3WJ98zvecdjJa1Mru8rpF0YcpLl
	 1CqH7bMYwtxc1ULTndPr8d+jXCoZeg3vXrRd+S+KEAHoOvVK1goW0tsKT4mRxDk5U4
	 9GKIzzBAk3Bz/USLkWhl5rw3GhKoQCo4Bkei/PVRBRo6erP1J0t8XLoRqhRTUpry0m
	 5fhJwJevar3t3AmZO69EG9lVmdcxtBarW+eJJVJhhD5VnW13V6vB7QcqWNX757gkd8
	 cYHRsZebWoS1A==
Date: Wed, 18 Nov 2026 15:32:21 +0000
From: Simon Horman <horms@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: Jeremy.Jean@oss.cyber.gouv.fr, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] udp_tunnel: fix GRO callback mismatch during setup
Message-ID: <20261118153221.GG860048@horms.kernel.org>
References: <20261111214622.2482547-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <179478310543.3136.4977357785981182737@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179478310543.3136.4977357785981182737@kernel.org>

On Sun, Nov 15, 2026 at 10:51:45PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 1 · Medium: 2 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [High] The fix still lets receive and completion use different tunnel
>   parsers on the same packet, so the out-of-bounds write the commit…
> - [Medium] udp_tunnel_gro_count only describes how the head skb of a GRO
>   entry was parsed, not the packets merged into it, so packets in the…
> - [Medium] The Fixes: tag blames only 5d7f5b2f6b93 ("udp_tunnel: use
>   static call for GRO hooks when possible", v6.16), but part of what the…
> - [Low] The new synchronize_net() in udp_tunnel_update_gro_rcv()
>   (net/ipv4/udp_offload.c:139) runs with the global…
> 

Hi Jérémy,

I would appreciate it if you could provide feedback on
the concerns raised in this AI-generated review.
