Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794241241;
	b=DalOzC0c51G62Kbda3WxV0Z43aak8jmqW4vRB8pMC+YBqAaP3jOU0qUHyWk5FnaYVprD
	 ofbo+lQ/RPnk7YNj3wr4Hqq5jpwwrNldO3EIDUzMVRSOfd6Ruu0o+Z30u5DMytiOLEfWL
	 DC4mh9tvUwHJr3BWHpi3sMgJK8Sus4OTt66Xznx9FBhjoiNXJrCBOtR32JEZFF6Nunv1C
	 xiMTWFNaE8Ke3RY6Hd5F+rB21tkkSg81Cgx1czET/T+m3VQRVIlWmLfokiJLsB373xVQF
	 dZVUwumuY9REuWKLP1x4q2nZcqa7yL+cuZ92JZCFhNm3QZPHctJOS1Tl03fwOVa0dwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794241241;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=uqVFKjEcCog+JIN449z7ZIC0LwC3/C6fpu8snb4XjSM=;
	b=F3UMYMHhgGxPJkTjWZD6ewWdIvwDNYJyHAilmVEm+0EsKf4DQapR2+If4h5lTOA+kETc
	 SqIs9c/TdddOi46qXQg1birlwVPtndLBG2VY7Ty4zdX6VH9GJtfpZASe/pHDjK/uVZLpO
	 z+H+sEod6cu73k+GzxJA6naLpWQk6UHkvqNcyFoCUHCsb1DWM5jGiKCGv4uh7l2ymKgRu
	 o5oeNWL24Lg0m5tQGQExstxrMhEyqxfDKSMmxVyBC0vSTdl90bYbEeW46ts6wFtPr7ivZ
	 5yAUM7kaoZY98JaVcUEqcF7UoCXU0VfpBb+XYN52jyBHqI/CZxnHfnh8inXvZYYQbGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="UQg/ml3v";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68D5606A31C;
	Mon,  9 Nov 2026 16:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UQg/ml3v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4D71F0089F;
	Mon,  9 Nov 2026 16:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794241240;
	bh=uqVFKjEcCog+JIN449z7ZIC0LwC3/C6fpu8snb4XjSM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UQg/ml3vIFo8HpMr7Un1QEbIs/vJ6wl2UdoNZra4DFwKqFXbkIUJ5yq3jbGNbUH4z
	 2vD+kXn0Ue6DHOrZtkrKehIytE3r+H8F17ZlaI/vXaKkJsNa3GCMojhsSGUt24tmpD
	 SrzANjJdqhu2SSBw6A/Fq9xkBmQ+BRq4GTsxhwgZLWcHnvrSWdZqeuHVSEPhrDsJ6N
	 uLHy6F+mqWG2fvfRKdaGczw5o2EgrSfIyC4mx4gdmI+2o/hYQMIrKd8C1xBrByRn3Q
	 pVAbJqndW/ZuHzCZzE8sRJk31EU6BO5vTMjM5KDzg2+exNWsLHLNh3GnuPyqo+Zk8f
	 qjLMoVQB4F92w==
Date: Mon, 9 Nov 2026 16:20:36 +0000
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
	stable@vger.kernel.org, shawnq1@163.com, davem@davemloft.net,
	edumazet@kernel.org, jiri@resnulli.us, kuba@kernel.org,
	pabeni@redhat.com, victor@mojatatu.com, thomas.goff@boeing.com
Subject: Re: [PATCH net v3 2/4] net/sched: act_ife: require a full Ethernet
 header on egress
Message-ID: <20261109162036.GN18859@horms.kernel.org>
References: <SER-NSBD.v3.r0.20261103064310-2@mojatatu.com>
 <179406301809.994134.18083601714109684155@kernel.org>
 <CAM0EoMkwapj0TzbhWPic_JYP8o7L0Hkdppx78PtAq1KoH1Go1w@mail.gmail.com>
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
In-Reply-To: <CAM0EoMkwapj0TzbhWPic_JYP8o7L0Hkdppx78PtAq1KoH1Go1w@mail.gmail.com>

On Sat, Nov 07, 2026 at 05:10:07PM -0500, Jamal Hadi Salim wrote:
> On Sat, Nov 7, 2026 at 9:50 AM <netdev-bot+sashiko@kernel.org> wrote:
> >
> > Thank you for your contribution! Sashiko AI review found 2 potential
> > issue(s) to consider.
> >
> > Critical: 0 · High: 0 · Medium: 1 · Low: 1
> >
> > If you believe none of the issues are legitimate, please reply to each
> > issue of Medium severity or higher and explain why the AI is wrong.
> > If any of them are legitimate and you plan to respin, please let patchwork
> > know by including "pw-bot: cr" as a separate line at the end of your reply
> > (one such reply per series is enough).
> >
> > - [Medium] The commit is titled "require a full Ethernet header on
> >   egress".
> 
> Yeah, that is a bit of an overclaim  - but i will not be resending
> just for this. If there are code changes needed in the next patches i
> will resend.
> 
> > - [Low] The commit message says "A short egress skb is now dropped
> >   instead of being encoded." The patch actually drops every egress skb…
> 
> Same here. No resend coming.

Reviewed-by: Simon Horman <horms@kernel.org>

