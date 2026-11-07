Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794057830;
	b=cTEZ+3fyOXCWYmGTA5rzPEjCdm1BDvnR4Z9viQeDL2eSiJ6otN7Y7JGLfCoFV6XQ6sl/
	 4hfG2ckLquPU80WhktapVudn9N0Qorjr3H6TtvMsEW3QvQCsHsfXbgdnwgp1fjBC3nNdw
	 lomPk26bzD/fpRn5ZBupNKE/XPw0auXVVVNlfX4UjLuS28MZj4DLCyfU27N/2+hD5Pvyg
	 2Y6OoUz/XZrMfhPLY1PU3r4RaQhou5DX7wkiEYNpRuFW8CAnyY/lNQE5cD2+wyrp3cgjP
	 fhRKqnq+mB2DkQ8IMD4rDGrmYC9Ltx7/LaxAUquP96MmZD5gV6ptWrFuLlIFi/c7C5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794057830;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=xjaYRwlA45zF6IjvB1O9To0Zltgb6ki7AR1cQ6X3meI=;
	b=a66fVj5HSYYgVxdIRMdR8xSbN3cwzJbEMxXv92yoQS3xUx609lI8GSMKG2YFHA9vp7Tf
	 YiPSTAC/o0sRWZi/18gdw9HFe6tCEbH7bM1HIy1p+sX/0pJuE3bBsofRJV7Fxeg+Nf15I
	 zXPi4ptrggAQ83Aiy9RkcNBbxDYcwWHhQODcz2NSlgUT8w4eH3FjjybTBvu2D/LIM9MtS
	 1tWdgpZJoIYxTL+gpFFgU+t6L+YLbB45gk5bF5AI13vGiJxbBhssGsmFaQFD8BUPf5nq4
	 LckdBWivZgGNLjgbOEpAIi8VMKqcVeM4a2nUQHn2qNyoa5/U97Ii9lvxwnP6C+kjXzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfAjOFef;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 9746F606A32E;
	Sat,  7 Nov 2026 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WfAjOFef
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id C04D31F008A3;
	Sat,  7 Nov 2026 13:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794057830;
	bh=xjaYRwlA45zF6IjvB1O9To0Zltgb6ki7AR1cQ6X3meI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WfAjOFefUlhSO8r9R9sE6a2vf44gPkYHjUmhPxakvQKrX8avCEWcF4Mmeo27B2zMR
	 WtfIiVzwnxiJAQty7O0OdGBjeofCWfT08I92qtONQnhfb8MHpUHjjcI0wwAdlVYYrM
	 b6JDJbAG4MwevbUPFWS+ptsb38GSoIAnMvtXen2j3ldi4PJq3+cP/5BUYih4UoQVbT
	 1pAXV0/bseRfrLmBhYcIeMVLGg5TsaDoTa6bkW+cw1+IKqVlwBSKX6T57Cyo7zmtT4
	 kvUVPsfto0pSEpPVfV2IwKBOuEBJkqUcgujHnAFOFeNjQeK+gx1KBspulnWWqDgPTT
	 rbpdNuBuHayFA==
Date: Sat, 7 Nov 2026 14:21:12 +0100
From: Nicolas Schier <nsc@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Rong Xu <xur@google.com>, Han Shen <shenhan@google.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] kbuild: rust: support stabilized flag
 `-Cprofile-sample-use` for Rust >= 1.100
Message-ID: <au8lyM5upSIKcEdr@levanger>
Mail-Followup-To: Miguel Ojeda <ojeda@kernel.org>, Rong Xu <xur@google.com>,
	Han Shen <shenhan@google.com>,
	Nathan Chancellor <nathan@kernel.org>, linux-kbuild@vger.kernel.org,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	rust-for-linux@vger.kernel.org, stable@vger.kernel.org
References: <20261106073528.93371-1-ojeda@kernel.org>
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
In-Reply-To: <20261106073528.93371-1-ojeda@kernel.org>

On Fri, Nov 06, 2026 at 08:35:28AM +0100, Miguel Ojeda wrote:
> Starting with Rust 1.100.0 (expected 2026-11-12), the
> `-Zprofile-sample-use` flag has been stabilized as
> `-Cprofile-sample-use` and the former is not available anymore [1].
> 
> Without this change, when building with `CLANG_AUTOFDO_PROFILE` set, one
> gets in the latest betas and nightlies:
> 
>     error: unknown unstable option: `profile-sample-use`
> 
> Thus pass the right name.
> 
> Cc: stable@vger.kernel.org # Needed in 7.3.y.
> Link: https://github.com/rust-lang/rust/pull/155942 [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> I can take it via `rust-fixes` to get it in for the release, but please
> let me know if you prefer to do something else. Thanks!

'rust-fixes' sounds good, thanks!

Acked-by: Nicolas Schier <nsc@kernel.org>


-- 
Nicolas
