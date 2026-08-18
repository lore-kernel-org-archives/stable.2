Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B737399340;
	Tue, 18 Aug 2026 03:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787023147; cv=none; b=rP0fe6wwWZj5OW1iXfeWmm6rGw+zTKW3uTgQa6anfgi+iY/HPKxoUxKHZlu+sUE9AsVHHDP0k/mp4WfbkJBCiUvfp7cGnEq4HaRgGeFnScGYY++d+6oi29EdTo9oEH/woOAp2IX9H3upmf9t73GIhYegIJk6/ppaCrBEkpZxt40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787023147; c=relaxed/simple;
	bh=M7nK/BDMt221/8ySEcVLrg0F9Qmrx5PFjXR4bfgIMkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+GPQacJMA7DGRkGaH5dsJDswNDbhV8wuQLNQtwxxIVlhzKysw1qvKjJcenP3a6JzaQb+scVQULG3XScfpZlB5w3mw0fSVghsmbPqRJAPdvAlKRRfRvfNaT0Eq6SxzEXdOBjMsPUdjhE6x6JyINmXamDoZ63U+BikxzXHaE0Haw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lF/nfk85; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lF/nfk85"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AC371F000E9;
	Tue, 18 Aug 2026 03:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787023137;
	bh=2OabeSSgWwkzgU1SdEqJbtWTcmRAHriuqL3q9Yldcl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lF/nfk85NXGUzOv/O1J+ARtnNVR656bsw3qctsheMCLeQeNriMv3ztXlU9unch9bX
	 CkIF2nd4h0M1wPkVUiYeLewTZOUeelBl4e3Xdep6ispc+d7tA+ZnC7CupkBqYyRPKk
	 Luo9+NkPSwjwKq15eTsEMt3BhKVTdneQo9Hl1mabLiobLEG/1+RkwCKNdgvV6ojeyA
	 DAf/SgkODR0RND5YwnClq2t4RbVI9+gWVSraFrz6FBPqspflYEArQTf7RNYx/jxf17
	 U/a/BncFHZ2nn5EdV27wgxkf5HXpRDJkV2w5zo2oDEcD6+8YiuJDuJACquqs6OLJIv
	 LreYwTe2n14aQ==
Date: Mon, 17 Aug 2026 20:18:54 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, Matthew Maurer <mmaurer@google.com>, 
	Alice Ryhl <aliceryhl@google.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kbuild@vger.kernel.org, =?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, 
	Alexandre Courbot <acourbot@nvidia.com>, Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, 
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] kbuild: rust: preserve unreachable traps with inline
 helpers
Message-ID: <aoPOqlGAlLOJ3wgx@jpoimboe>
References: <20260816133233.197500-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260816133233.197500-1-ojeda@kernel.org>

On Sun, Aug 16, 2026 at 03:32:32PM +0200, Miguel Ojeda wrote:
> When `CONFIG_RUST_INLINE_HELPERS` is enabled, it is possible to hit
> `objtool` warnings like:
> 
>     vmlinux.o: warning: objtool: _R..._4cmdq12CommandToGsp4init()
>     falls through to next function _R..._4core5array4iter8IntoIterRShKj3_EEEBa_()
> 
> `rustc` normally emits traps for unreachable paths. However, under
> `CONFIG_RUST_INLINE_HELPERS=y`, `rustc` emits LLVM bitcode and Clang
> performs final code generation after the helper bitcode is linked,
> but Clang does not trap unreachable IR by default.
> 
> In turn, this means `objtool` follows compiler-generated impossible Rust
> `enum` paths through alignment padding into the next function, resulting
> in fallthrough warnings.
> 
> Thus pass the LLVM `trap-unreachable` option to the final Clang invocation
> and suppress traps immediately after `noreturn` calls, which `objtool`
> already recognizes as dead ends. The combination of both flags makes it
> match `rustc`'s behavior.
> 
> Rust 1.85.0 (the minimum supported one) supports LLVM >= 18, and both
> flags are available in LLVM 18.

FWIW, I've been working on some patches that should hopefully let us get
rid of all the objtool hard-coded noreturn lists altogether.  I'll try to post
those soon.

-- 
Josh
