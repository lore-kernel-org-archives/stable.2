Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912AF343887
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 22:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781821691; cv=none; b=YV6BNIRpQk0voQjPHsVJJmhTcJ58zPP3VYFQ5Lqt5rq77Y6k17tu26FQLBXQy7oOyfUTeSu+Vjldb9uQztVVozi569vlAvolVDO4kYOLfCHT1r2pA1/Ri0bfOQPQfmijSQZi4uXK1SBz5ikA1d8ZmM1P6FTah2vwbJ/H4IOAKP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781821691; c=relaxed/simple;
	bh=wGzd5TcRk20wb5u1ZAIHSG+b4mG714ryqsYnba3vn9k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f4+RrWC5eIgslk9XMGpmw8oLQLET4E07RIUqshGUYEWdbXcZ5k90NMCHO6v5jSeVkKuj4N5dFGra5ynFUiXoEmpTujLSZsKseBPIUWmaa2z7PIZI9/Y8gRGxizR0b0Dm4+MbQBt9KP68LzJdZNAYRg4nZK+PixlYSK3S8qOs4Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIke4GGd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIke4GGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A44491F00A3D;
	Thu, 18 Jun 2026 22:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781821690;
	bh=53AONM242mK+6eb3FuThZWnsXmEvOSNBBigW80iMu1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PIke4GGd+vJM3QV97hW+iVmdNjegdiFhHM1kh2W8XVShb64kwPJD7LdCaR2azJghX
	 4IYlD5adS5/SFm7iSxEQhGPq5eLMaBLPZDESB5uAEx5W8SGLn95IennGS2rkEAOZ0o
	 6BcSp4aAc7FvyGbedQTvycVAyG8RTZlbNKo9UoSuQ//zYmA1qGt7GKD77oGyofido1
	 3vXlhcm2XTuR1gEbRlaNeiPWvGSe/DX0uC17FwHnHx5wPEzNJ960fS4cEtPZl6iBxx
	 FMEtAb/qhElsEie3r+Tbqit/FZuzpgGhqaOXRbhcXEZWmLhO0XHWyHayl4f1BKpQqb
	 Zn04f3jbZM9Og==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id EBE71F40075;
	Thu, 18 Jun 2026 18:28:08 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 18 Jun 2026 18:28:08 -0400
X-ME-Sender: <xms:-HA0alMVO2ldmq07U0rZ4Llf_gJarqCLUweAuSoIR1XNrmFVwmNnJA>
    <xme:-HA0av5cy4m8MBZzVSI8dUbRs3xc-GtoZ1_5AhIZAWwvHC-wGSflQQLP4oH7-ooYh
    6tNiXqEJM--dV96oPpiN1cMHJKcAV-v-E6KUvvg7U0_Art8p8NP7w>
X-ME-Received: <xmr:-HA0arfV8HSMF3220P0w5A4lepc7fivJaGXx-6gpe-UI1-aaILW6Dc_VCO7AzojIdAgRwHg0dleUt_-cvWmAtPL4z0YK02zK>
X-ME-Proxy-Cause: dmFkZTEZ7/IK0sqZbZR3pK5+aXiLEMDUV96gs+oTsA8c00umM1+K3xBt04nHrkbXL0ldPx
    nmrnulV+VeTf9TnMtPsIVB9Z6LP47XSUDmExpqOSR9izUKc9ULlFnsMYLgT/A3Hb8FMVfc
    79F4cHGW6WYdXEiErqD9MI8jz2Co6JU1iudGtCEj2bT97Isas9c/FsEFdtzturDfT0wtvX
    Do1AmwPqgbOxTGqzQQD1ctMOK44ANI/narg/48O4jJJ1Cxsv8Z0ksxJytcghdIxk6yKdIE
    5N9i9W9HTK8JPWQ02H9Nt/KGp3qBDQSHO9TdxoTnqu/ViJ+axglEmTdckoKzQOFbot4mt9
    OE9Xa78ewL0gbiofDyVGVLdP4kuDPpUmil94xbyfTuMY/OxzEj5qevrniMf/bM/q3QpvlB
    bhtBRmKuUF20txFmTtxHMx9aCU1Up4zrvibi0RKU9ohAYL4j9byEdMgj/ry2IdSKe2FMmv
    eEiW3zfWrW3WqkJAa2mRMTDDUej8Oia28bL+AL1zdLR0e83G5Awtl40H7nt11xP7kM9tBe
    cNCxdUTF5oYPDGz3FFpOyuyiSfBn8m+JWX+zDDgSofudRBXOL7B3qIg5UiswC2Irp13mDv
    sm+8jshHhq2bB3rNJvuBiHYSWs6r8aZlEGBTySRpS5qXVfEhFFkRp71/RSjw
X-ME-Proxy: <xmx:-HA0aoLGJPb0aOrxwxLHTT8WrR0Q57gtpYwZ7fPAhgim7xpez9-tLA>
    <xmx:-HA0apmjyEX0_DAAAjL1v2eTwI9GeC4Ph8g8C-MRupWetFo_6kolCg>
    <xmx:-HA0akFWK510mY49y5oS_fVAmf6MSgh3MZCPjN7co53Kc4nPuFqPbg>
    <xmx:-HA0aicUPdcLwcMas27Y9TQHkCtX2UbrLZCLl-bun5o0mVA0SX92Tw>
    <xmx:-HA0ahF24me-4MB6YYGXoVugz4JONuokgg6gyVCRb6C0bIeuvxXMbPgy>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 18 Jun 2026 18:28:08 -0400 (EDT)
Date: Thu, 18 Jun 2026 15:28:07 -0700
From: Boqun Feng <boqun@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: lossin@kernel.org, gary@garyguo.net, ojeda@kernel.org,
	bjorn3_gh@protonmail.com, a.hindborg@kernel.org,
	aliceryhl@google.com, tmgross@umich.edu,
	daniel.almeida@collabora.com, tamird@kernel.org,
	acourbot@nvidia.com, work@onurozkan.dev, lyude@redhat.com,
	deborah.brouwer@collabora.com, rust-for-linux@vger.kernel.org,
	driver-core@lists.linux.dev, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 2/2] rust: revocable: fix race between concurrent revokers
Message-ID: <ajRw93vKgkPwXcCN@MacBook-0RXW5>
References: <20260618193951.601239-1-dakr@kernel.org>
 <20260618193951.601239-3-dakr@kernel.org>
 <ajRknQIsXaHtDzzJ@MacBook-0RXW5>
 <DJCIZMUFKMTK.BO46M40UO3XY@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DJCIZMUFKMTK.BO46M40UO3XY@kernel.org>

On Fri, Jun 19, 2026 at 12:24:12AM +0200, Danilo Krummrich wrote:
> On Thu Jun 18, 2026 at 11:35 PM CEST, Boqun Feng wrote:
> > This issue happens particularly when we want to save the extra refcount
> > (and indirect reference), and I think this is the issue that `Foo`
> > should handle instead of `Revocable`. So maybe we should move the fix
> > into `Devres` layer? Thoughts?
> >
> > (I'm still hoping there could be some lightweight usage of Revocable
> > other than Devres, hence the ask.)
> 
> I agree that a "lightweight" usage of Revocable is reasonable, and we can still
> have that; nothing prevents that (see below).
> 
> We could also turn it around and have revoke_wait() and make no wait the
> default, but I think it is a bit of a footgun.
> 
> Another alternative would be a new type over Revocable, which may be a bit
> cleaner. (Although in that case I can also just move it into Devres for now, as
> it is the sole user of Revocable anyway.)
> 
> >> If needed, a revoke_no_wait() variant that does not wait for concurrent
> >> revocations to complete can be added in the future.

I'm worried about the space cost of this fix on Revocable as well. So a
new type or moving it into Devres feels better to me.

Regards,
Boqun
