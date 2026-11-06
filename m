Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793998444;
	b=ymIieI9ngEW+gzKHRv6zmOQeTseFUsClXOEzahKXoZ67fnCBMtvX3sqwZutjdyi1qULn
	 YGbXs29FqVejZkAh8hlZ+rxH6mUrrVDAGNb3x14UQN3qcBcKsV3rkAK7nybh5bn+qVUkO
	 8olb3gb8rWUQmhLtQ+74xYiXoxP2CY9v8jSmrdRr4v0+ogpUkYi6SCvKNgABkq/+wuwvL
	 +pIdygB2U7D9IPZmKBPS7HEXVyWZtm8SA5uXVZkO9nTvppe/fjNxH1ivDGaeFMsofVQHe
	 nTkE0433BVXuN7gY9RDveetpCXnV0w1w+Crk+ul3kijfFSaq9IXq16mxIQcOpduBrHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998444;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=GLqhz4fnwD2jbyndKPwTTlFLM1XVQgShCxmfx522pdY=;
	b=Vg3lhLTZw4RnpOgmZ8sJqbIetA5FnCt05SPe/MDQmPiNo1b7FZiekrNTyV3N7+Y09EIq
	 BCorua1AMK1IMHkpX6fhTAAUDFPeelPResh30zL3VNfqTIXqyKTn3IMLvgokwOJG5m3UL
	 hy3ispQvTbLf2blEfKKycHDeKO/IRKVbidMGACzieYdxuYD040uxWVYWjxV9F5uYNsLwX
	 O2tGdmOYq4Nv2Nz9eOkeZluX5Zr60Z84vW4rN8QETzDGV6fZudeoIGhjZrQuZOWBZmftK
	 Xnlr6ZnaMX4tm9EB3qxgJbPgzFXiX8W6X4q4BoCizyMTg9Jz7WocaOH5VVwtv4uS9vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgiNIKcY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBAD606A329;
	Fri,  6 Nov 2026 20:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WgiNIKcY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E771F0089F;
	Fri,  6 Nov 2026 20:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998444;
	bh=GLqhz4fnwD2jbyndKPwTTlFLM1XVQgShCxmfx522pdY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WgiNIKcYU46fmXcALNq5dW+kWmNQwgbEFrbWnO2ZAV1x66YPw6A6HiB8/V/qOMyWe
	 ZKBxL4aCb5/g0rzFTjOC3gpbaU/6w/AjdwbcsOkF5TrUreZK3twBW3nyN9HWNVcWwQ
	 /wsaKusT2xlDZW996Yyxl3ugm50gwg+nFw/w2+lMji7TVKMFwfI+NqinTmlLSWwnFh
	 dvZCBNtg/Tni5AvbmytlrSS3+NLxEPj3srVHnCbnECrOcy2Pv4eFJFBnZ0FnGMeMDV
	 224w2eDwgm64O82VMHvCVvHcMjRySDl6Jv7TCPAjKC9Xal7tpRALIjpgnHcaiAprVd
	 3c2EU+e2SNJ8Q==
Date: Fri, 6 Nov 2026 13:53:56 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
	Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>,
	Nicolas Schier <nsc@kernel.org>, linux-kbuild@vger.kernel.org,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kbuild: rust: support stabilized flag
 `-Cprofile-sample-use` for Rust >= 1.100
Message-ID: <20261106205356.GA21490@ax162>
References: <20261106073528.93371-1-ojeda@kernel.org>
 <20261106104546.2297584-1-aliceryhl@google.com>
 <CANiq72kSG61mTC3_0pPokoLbbE87oFrKHcNUZhxhbxpg24USYw@mail.gmail.com>
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
In-Reply-To: <CANiq72kSG61mTC3_0pPokoLbbE87oFrKHcNUZhxhbxpg24USYw@mail.gmail.com>

On Fri, Nov 06, 2026 at 12:04:08PM +0100, Miguel Ojeda wrote:
> On Fri, Nov 6, 2026 at 11:45 AM Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > Could we check for `-Cprofile-sample-use` directly using `rustc-option`
> > instead of checking the rustc version (e.g. testing
> > `-Cprofile-sample-use=/dev/null` or using `$(call rustc-option,...)`)?
> > That way toolchains that cherry-pick the stabilization (or older 1.100
> > nightlies from before the flag was stabilized) are also handled
> > properly.
> 
> It is definitely an option, as usual, but this file uses the version
> elsewhere, and we have preferred so far the version one where
> possible, because it is way simpler and spawns fewer processes
> (especially so in newer Make), which Kbuild has usually appreciated.

Yeah, there is always a fine line between deciding whether or not to do
a dynamic versus version check. Obviously the cost of querying the
compiler is not that high in the grand scheme of the total build time,
so I don't think we should be scared of doing dynamic tests, However, I
do think doing plain version checks is simpler to support, especially
since it makes cleaning up these changes as the minimum version is
bumped.

> Regarding old nightlies, those are not supported by upstream nor by
> us, and we intentionally never attempted to make flags work for
> particular binaries out there. I think the fact that we support even
> nightlies from Rust is already quite a success :)

Yeah, for clang, we have done our best to support prerelease versions
but once the toolchain stabilizes, we don't care about those old
versions. I generally try to do version checks against the stable
version (i.e., x.1.0, instead of x.0.0) to avoid breaking compiler
bisects but I guess Rust doesn't have such a scheme? That is the only
area where I feel friction with version checks.

> Same for custom `rustc` forks, if you mean "cherry-picking the
> stabilization". We can't really test those, and if someone really
> needs that properly working and can make a case, then we would need to
> take a look at all the version tests we do (and not just for Rust).
> Perhaps some folks only customize 1 or 2 flags and thus only care
> about those working, but we wouldn't know which ones.

To be honest, I would avoid supporting franken-toolchains if you have
the option not to. Presumably if a vendor has customized or vendored
their toolchain, they are likely working with a downstream kernel as
well, in which case they can just adjust the check in their tree as
needed. You could obviously deal with exceptions on a case-by-case basis
but reasoning about all the different options and their first supported
version is hard enough as it is.

-- 
Cheers,
Nathan
