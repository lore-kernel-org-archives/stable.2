Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795061529;
	b=xKP2WsWzIZI2QJbNmHlrn8y377hp9GKXyai3xdaK4XmbDen8WpDcdDlT4mgcXhQyrDUy
	 yy1wiyLiz04ibZvk5a6/o/hsHA8NYcoaWvh0ztdfL0B6tCxTu6Lh/feOwkuPWj0gIzBy3
	 00A1V41bq5p+CUMA/bHISfpTVuRtyOHdisYLW20R9uvYVdNugz+KmRuLVZK16hsoSEW4b
	 qvj8KC/eg9vAsPte5w71b10BTZe8jPmvj3cfH1PKytlpf6JnkfyNmz1bcqQ+B7O3b+EHw
	 Jw1Pl6Db0p5DrF+tSMU8rNrlH1Yap57JGWT0YZ8TFcNhnzYhj+cvxhSKmVSk3du4G/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795061529;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Cd/IXAd36BHiEDGk7QEjHc+1HbQrSiTqxqdslEATza4=;
	b=qZicgLPC69YWD7McmlFUKFoebYkn2i+UkFelQgMZkBYgSgj60u7FMo6Dblx91m5ukevW
	 KGS0Gpx9Kh0lfwxXRGzFNxEWUltzsrjj7jIYgePqtL6Ehkl9jsNXvJ77o99o7BUduQQvy
	 oX5kVhSl7MoAHdJbYQL2Gc+a/DG6UXjxUQoKXTiogb8neVcprJ0Pf9plpxRH2ZTeg4tCL
	 Qq0A98K80h/XfDxOf1R6XZTsnqRP4pqbvifgMfCS9MsVbEq3cw8K6UCTEewd9ePOm0umB
	 MlaqKB1/t7/6YgmLfqsUnlE/WfIDiOG6lMWjtjZc4qZ3yC9tSKov6GEPpNBEeGWKFBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVmduHop;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D311C606A330;
	Thu, 19 Nov 2026 04:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RVmduHop
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 032011F000C4;
	Thu, 19 Nov 2026 04:12:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795061529;
	bh=Cd/IXAd36BHiEDGk7QEjHc+1HbQrSiTqxqdslEATza4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RVmduHopSC66FMRf2Ta7rbnscP97GeAHYr1J87nQCFQOQTip0W2JXhKgMVIkMTGFF
	 dq1SqQcNt6tGlhrlBzPxLw6hwHkx56VeRVAbLSOazeG6pmLKGAmo0keF0YfD+krVS4
	 mnd6Ls1aBjkYAkQw8fxyLxbIqxdHs94D3LNf1Sk2L3s3sXSL7xuYP9r7LhiMkgCTCD
	 94d82Z+5+W5eGCotK4hnydTT3Hd1qwvr6t2d7CIrems5qXgqqfpUEtkinZfLMFV6wf
	 b2MGQNVr6jctzXOApjnOLw8bCCvFC4Oxh4T7ClnWGbanzyrdai+zwn/cwS6Fzhjete
	 BRwm6KUFpLxKQ==
Date: Wed, 18 Nov 2026 21:12:05 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org, stable@vger.kernel.org,
	x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/build: Do not allow X86_NATIVE_CPU to be
 enabled when compile testing
Message-ID: <20261119041205.GA1218811@ax162>
References: <179480914308.3191731.6125228756396043444.tip-bot2@tip-bot2>
 <avrPcQ4sOkgJPbkZ@gmail.com>
 <20261116130159.GA1327949@ax162>
 <CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com>
 <20261116204517.GB1037705@ax162>
 <20261119031635.GFav5qExslqQpbK2Oj@fat_crate.local>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261119031635.GFav5qExslqQpbK2Oj@fat_crate.local>

On Wed, Nov 18, 2026 at 07:16:35PM -0800, Borislav Petkov wrote:
> On Mon, Nov 16, 2026 at 01:45:17PM -0700, Nathan Chancellor wrote:
> > Hmmm, not a bad idea. That does seems to work based on my initial tests,
> 
> So I'm going to zap what I had queued until we figure out what we really wanna
> do here.

If there are no objections, I'll send v3 within the next few days. Let's
take it for 7.5 instead of 7.4 just to give it time to soak, I don't
think this is really high priority (and I am testing -next most of the
time anyways).

-- 
Cheers,
Nathan
