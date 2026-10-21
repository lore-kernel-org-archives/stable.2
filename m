Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792565578;
	b=OSWjPoBHcuuy2Hf263RNLuvxw0p6H5q5km7d/a8S8ANy1WWImjfcpPsmoI+qhj7kJuXi
	 G7Wc169q2T7NQvYzy4+4hWQgQDtR6bMEDQ+5CUKedz23FTGNf1sD3787EXfnVGF3c7ChV
	 DTpeUAgSxnBqpDZF9uUhf/TRIkX/iFH1z5hhIkj45rszIHdkVIdi8kzAfAkdA7SE+2jBc
	 vEgcSzqdnYhFNDfLf3PsyjdHrbTPyv0naxLDpitAkvtCQtvMf6Up4GMpT5NthuE4s7kWP
	 xunYme1u88o/wOXvDieiyZlPzJgSS/AifzvT3lKoMKRFJOyOkyGcNqF9ZL0a4fZWhxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792565578;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=83IFGnmgPfwXL2SJmPqP3e9cOIxkzV3X81QB3jUeQ98=;
	b=JJfb/kDy+d3sS/ijm9RCR+kjy6rH0ekUwCCyC+af2A1T7SGViCitmx3giClWaYklovfQ
	 UHju5FbA0E0yfhhxkDcsfy3uFoN+MrW7IeObFH3zKJczFlSFuFmzwQw0KeHNC282L8Cpj
	 WpudcDxhN2SxNBxkLqBXEpIT28oYRTAgiSfDnpKUod9wnCy7Hv/hn1u+KIhvi6d500Efp
	 7PMHDXiXxn/qMxdh0zJk52eSeNhBoQAuYaatTHrwlJdixMw502AlogebNn7pq/YeEurlF
	 5ze/HBnhonwyjeezDFRih10P5DEf2sgp73XHbIVpVEwXD1Mwo8GfCvT/aAlPWDY+LXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=EXsUL6YJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA7E606A31A;
	Wed, 21 Oct 2026 06:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=EXsUL6YJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9F81F000CD;
	Wed, 21 Oct 2026 06:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792565577;
	bh=83IFGnmgPfwXL2SJmPqP3e9cOIxkzV3X81QB3jUeQ98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EXsUL6YJRZFhtO3UkTSX4Eg+AMeyN5J3AlMzLZ1jRiG1ocwPGrhnbD9QQz4IeMtmr
	 kAnAe4xjVVSwsBO1qa1X4Hegiu7mzzaWGZd6n45zOuqjPo4Rvb9Zh9z/IKy96lc/zj
	 PMFStBQlnb1e7ICuaob8gL+sWwF2I9kTsqRwkWPY=
Date: Wed, 21 Oct 2026 08:44:11 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
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
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH] docs: stable-kernel-rules: mention Rust soundness issues
Message-ID: <2026102155-hence-semifinal-b827@gregkh>
References: <20261020163358.176088-1-ojeda@kernel.org>
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
In-Reply-To: <20261020163358.176088-1-ojeda@kernel.org>

On Tue, Oct 20, 2026 at 06:33:58PM +0200, Miguel Ojeda wrote:
> Back in 2023 I asked the stable kernel team whether we could consider
> Rust soundness issues for backporting, since we wanted to be able to
> protect (as much as possible) downstream users of stable kernels.
> 
> Since then, we have been doing our best to backport patches for Rust
> soundness issues.
> 
> After the Rust experiment ended, I documented it in the "Submit checklist
> addendum" in our "Subsystem Profile document" [1] (i.e. `P:` entry in
> `MAINTAINERS`):
> 
>     #### Soundness issues and backporting
> 
>     In general, fixes for Rust soundness issues should be marked for
>     backport, unless there is a reason not to (such as situations where
>     the backport may require a lot of effort but the risk of users
>     hitting UB is low).
> 
>     For context, while the stable kernel rules mention "theoretical
>     issues" should not be backported (which one could argue Rust soundness
>     issues are if no existing users hit UB), we discussed the topic of
>     Rust soundness issues with the stable team and decided that we would
>     do our best to backport them.
> 
>     The goal is to help to prevent actual issues for downstream users,
>     distributions and vendors that patch the kernel further or even
>     add completely new code on top, since those modifications could
>     hit UB. In other words, the idea is to maintain the "extra layer"
>     of protection in stable kernels too, as much as reasonably possible.
> 
> Thus make it clearer by briefly mentioning it as well in the stable
> kernel rules.
> 
> Link: https://rust-for-linux.com/contributing#soundness-issues-and-backporting [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> As requested, here is the following embedded patch as an independent
> thread:
> 
>   https://lore.kernel.org/all/20261016160030.118973-1-ojeda@kernel.org/
> 
> I added a small paragraph above to make it clear it is what we have been
> doing in practice since then.
> 
>  Documentation/process/stable-kernel-rules.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/stable-kernel-rules.rst b/Documentation/process/stable-kernel-rules.rst
> index edf90bbe30f4..ffa7905543a6 100644
> --- a/Documentation/process/stable-kernel-rules.rst
> +++ b/Documentation/process/stable-kernel-rules.rst
> @@ -17,7 +17,7 @@ Rules on what kind of patches are accepted, and which ones are not, into the
> 
>    - It fixes a problem like an oops, a hang, data corruption, a real security
>      issue, a hardware quirk, a build error (but not for things marked
> -    CONFIG_BROKEN), or some "oh, that's not good" issue.
> +    CONFIG_BROKEN), a Rust soundness issue, or some "oh, that's not good" issue.
>    - Serious issues as reported by a user of a distribution kernel may also
>      be considered if they fix a notable performance or interactivity issue.
>      As these fixes are not as obvious and have a higher risk of a subtle
> 
> base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
> --
> 2.56.0

Looks good, thanks, I'll queue this up after my first batch of -rc1
patches get merged.

greg k-h
