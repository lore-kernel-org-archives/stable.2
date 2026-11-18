Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795022771;
	b=D9StqWvhFP+dLk4dil/8127TxtURlCJvuKmQXP/c2y/IkgOvMYspcZi73uy/GpWM8sfV
	 EFoy0asauYNciSjmsElQgbFQSYd3BfRURSbH4mpvDv5clSbUmJuvW3CSHI3dwvkUAOX1/
	 2OfstvsckHMzMSc1PagZS0yC2mIkkF5ncja5/x6Kuen1WcfA7SC1YUuRlfIwCWjIBgtzs
	 UKDg8JVMAPOrms+mVq0H7NyuPovdL7gUZH0YHI5er7elFCkttdVdYWPxkpypVggF/xK4z
	 d9l4mRIm0kCqGMnmcAumRuV/m0hr8YX9Cix+vEAhSfX7ynolCUQcDmjgNzQnLNq1mBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022771;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=ssKNU/z5Vf5ezfQe9+t8GBDFiuU8VYizXFRB6pc5X5Q=;
	b=OlJpssC6Vvr/dEVRieRBGBUtru32KpIZDsds1uG01H4t3Oow2v6wl9zKG6JWkp5CxH8u
	 P7BzPo5LugsKRXX3QTnum+MF4qr3oN6JEHcIC7KLVuLif4Oiisvb64jSd9FrP5qniALGx
	 70qQUKGBbreLksWtlqusTuUvwrPLeLsM4mKlA3+tSQ1q+4510ZwpXHgPH7dmYH6CpQlHR
	 AziY38S8rr+3ivvVjNu199Cg+piSVwS7zHer1R+7VdJbcdicLPrbfnHktwpXve8kLc5kF
	 qKdXHvIgxXDAJ9UeJbzh9pwEYD/effaf5T6O+nW3f2Hry9xufpuUBwYyzowiQAyuDMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OhkBwqUd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA34606DABF;
	Wed, 18 Nov 2026 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OhkBwqUd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43CD1F0030B;
	Wed, 18 Nov 2026 17:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022771;
	bh=ssKNU/z5Vf5ezfQe9+t8GBDFiuU8VYizXFRB6pc5X5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OhkBwqUdAwEkWXUbXYCq1qwK7hKu020RRVpe/qOpr6iYfuUJwsiUngB3KEze02/M/
	 1LXnnLiUvy+eBr/ClXfyC3zSau6MPiyl7XsKf1oRJY2jT0q5AQgqzdOUh/6GOXKX+5
	 HqPnyPJwwBDIHkwRmVk+GtX9Ca2DWDSOK9rAde4lbbpMuRaDemsYayt4XIOM0rSGSk
	 mpDUJ+V5136s3F7VYb2IAksTUYJLd073cIYCpbduyeNpi1CtY2awCWQjUI/k3YsIa7
	 RINZz8R3txoYR7crTIrcRS1uR+8fADfk83eGGSwfyc0HTalW2zEZRyInWI62Kq/P47
	 /Leh6WZ3lRYNg==
Date: Wed, 18 Nov 2026 17:26:07 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <jeremy.jean@oss.cyber.gouv.fr>
Cc: netdev-bot+sashiko@kernel.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] udp_tunnel: fix GRO callback mismatch during setup
Message-ID: <20261118172607.GL860048@horms.kernel.org>
References: <20261111214622.2482547-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <179478310543.3136.4977357785981182737@kernel.org>
 <20261118153221.GG860048@horms.kernel.org>
 <1d7deb845ffc57994cfc86c317d9958d@oss.cyber.gouv.fr>
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
In-Reply-To: <1d7deb845ffc57994cfc86c317d9958d@oss.cyber.gouv.fr>

On Wed, Nov 18, 2026 at 04:36:50PM +0100, Jérémy Jean wrote:
> On 2026-11-18 16:32, Simon Horman wrote:
> > On Sun, Nov 15, 2026 at 10:51:45PM +0000, netdev-bot+sashiko@kernel.org
> > wrote:
> > > Thank you for your contribution! Sashiko AI review found 4 potential
> > > issue(s) to consider.
> > > 
> > > Critical: 0 · High: 1 · Medium: 2 · Low: 1
> > > 
> > > If you believe none of the issues are legitimate, please reply to each
> > > issue of Medium severity or higher and explain why the AI is wrong.
> > > If any of them are legitimate and you plan to respin, please let
> > > patchwork
> > > know by including "pw-bot: cr" as a separate line at the end of your
> > > reply
> > > (one such reply per series is enough).
> > > 
> > > - [High] The fix still lets receive and completion use different
> > > tunnel
> > >   parsers on the same packet, so the out-of-bounds write the commit…
> > > - [Medium] udp_tunnel_gro_count only describes how the head skb of a
> > > GRO
> > >   entry was parsed, not the packets merged into it, so packets in the…
> > > - [Medium] The Fixes: tag blames only 5d7f5b2f6b93 ("udp_tunnel: use
> > >   static call for GRO hooks when possible", v6.16), but part of what
> > > the…
> > > - [Low] The new synchronize_net() in udp_tunnel_update_gro_rcv()
> > >   (net/ipv4/udp_offload.c:139) runs with the global…
> > > 
> > 
> > Hi Jérémy,
> > 
> > I would appreciate it if you could provide feedback on
> > the concerns raised in this AI-generated review.
> 
> Hello,
> 
> I intend to do this at some point, but I have been busy with other
> non kernel things recently. I hope to get back to this at some point when
> I find time.

Ack, thanks in advance.
