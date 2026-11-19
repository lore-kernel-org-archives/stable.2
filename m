Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080583;
	b=1BwglBiNR3OTBgBcuUgTcGFe2LOH4VBotTfAK0mn6VWaYs4UKy2f0HSRDgS9ZtnOc46v
	 /EojVg+Ah7EoCTq2J0b0oijgDXXEDxTL4Jt9REpW4wxuhAYowyF039DtKJBTOaRlh/Fez
	 9TGzXRPNm5CkSn39dnVwiQk7w47xlg4sOVQGFbu+hXlf3udhv70NRmdoqoXiN2aK08Dr4
	 GMOhZUnArNPqYKixECQe6ZPppysyJpF1rTHxYS9AUkxnNChx4oKNjpsNB1s9TvVAOuZo1
	 mvYwudHoc0k3YZLQVQs7WtZNL+83PIlkx0K3Q+J8vOqpzmoysDwP/hNw9ydA455N8Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080583;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=M8mPdgBHFdZobcFPbL7sLmZy9mM9xoLGSzou09PYUxc=;
	b=kZWLT3tpJ0aPD8Ec2SLZGqN94SLo+oDlSmlkmRLWQo/tWefm1+FL9V0eHfV15io2nkwT
	 LvHRe71iI/PV7M7tuLK8G0uzFKdcF0kpckLdY4tib3N4K5tveog1EMFAFpGexnld/qdR7
	 gJiwyoR0+qJT6PKlwwmW2qEA/RwAz/p8QNH0ptf9Ac0VNXwiX0mxmHNR8jHwnfIqcDfdv
	 TiNVNaZV9yJKTb0K2PMz/bhsbTek9qffdWVFmgKQqgKedly8SRTtSYOjmR8jp7RRpxDy0
	 AQrojEbfIyawyUF+FVkqui7DSQCi7c3YAnv9gxMnpPOpTnlzk38TWg9v/p9Q26tW95w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eEmUjGmE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F05606A320;
	Thu, 19 Nov 2026 09:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eEmUjGmE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE451F000C4;
	Thu, 19 Nov 2026 09:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795080583;
	bh=M8mPdgBHFdZobcFPbL7sLmZy9mM9xoLGSzou09PYUxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eEmUjGmEnUyzfp67uSU1+6t0zSUPSTnPPj83skMJMPgTbTxPINs0tKHPcp9PuI5LO
	 yt5iW1DuuEHTtNKNiIy2fxtqwcH6yRJ0t6ncxaUjsx27/3YbKJxTpjvTH51LUeDjTF
	 I7QF0g9JOJkkLDLx5Iz3aaYzZxXx9YUdmYLVzitNYDG5l36que+RhWWcpEiRRmYvU5
	 BHMN1uf3pfyYNRZmRlheo69bzs990/Msjs7uQs/W63bRIc/MsfEJkCH4mOMRHofmpo
	 d1qQ2AFHi1fWFk9Sw/3LXa6usCDvTktpczUndy0sGAAQDwRBEo2BL5E68csqu7YTuT
	 YPp+MJdq7ISWw==
Date: Thu, 19 Nov 2026 10:29:38 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
	stable@vger.kernel.org, x86@kernel.org
Subject: Re: [tip: x86/urgent] x86/build: Do not allow X86_NATIVE_CPU to be
 enabled when compile testing
Message-ID: <av7BgoDGvN15sdNq@gmail.com>
References: <179480914308.3191731.6125228756396043444.tip-bot2@tip-bot2>
 <avrPcQ4sOkgJPbkZ@gmail.com>
 <20261116130159.GA1327949@ax162>
 <CAHk-=wgmkoWHWwaQ6nsGoCiBp0hrpJuiwmoVbQ=Efun8JyUNKw@mail.gmail.com>
 <20261116204517.GB1037705@ax162>
 <20261119031635.GFav5qExslqQpbK2Oj@fat_crate.local>
 <20261119041205.GA1218811@ax162>
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
In-Reply-To: <20261119041205.GA1218811@ax162>


* Nathan Chancellor <nathan@kernel.org> wrote:

> On Wed, Nov 18, 2026 at 07:16:35PM -0800, Borislav Petkov wrote:
> > On Mon, Nov 16, 2026 at 01:45:17PM -0700, Nathan Chancellor wrote:
> > > Hmmm, not a bad idea. That does seems to work based on my initial tests,
> > 
> > So I'm going to zap what I had queued until we figure out what we really wanna
> > do here.
> 
> If there are no objections, I'll send v3 within the next few days. Let's
> take it for 7.5 instead of 7.4 just to give it time to soak, I don't
> think this is really high priority (and I am testing -next most of the
> time anyways).

Sounds good to me (and v2 looks pretty good as well) - and this bug
is pretty old, so you are probaby the first one to trigger it and
trying to do something about it. Sorry about penalizing your diligence. :-)

Thanks,

	Ingo

