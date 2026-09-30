Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC374D9908;
	Wed, 30 Sep 2026 13:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790774987; cv=none; b=Kpz8uUBYi85fHaVoCDn0kGCNpj9uiKqB8dTJ/19Oi309dKJT3Vfepx/qG4PO9qeu5N69JW3hnC8izWYpb9GZHaf1qFuLRgo10tybj9TMGPUksa3Rd2EMEBZRBjOAT2j+wOs7ZcmKW5FcVoN/T2InRLcPoh3cOEUBIIJ9DZ5ArS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790774987; c=relaxed/simple;
	bh=B+yxc3/GLtwQ41l2ba0Op50Bux1DgWw6KZZnjERpTs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i2YkeQW78/ZNlKCmykix3tss4CabqRHFi256OJWLmNauSVrltiQA1IZV3r9OO/kmGevZp896godgeBad4j3EYHV5Uc4MrTQcjOV6FxPqe0VAtsD6lWHOZBWF6/uCQ82qY+r9ju5tqnmzLzANKt7S/5+Sc3IjNo1+eVVBMjJkr38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRfgvWHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRfgvWHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B447D1F000FF;
	Wed, 30 Sep 2026 13:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790774976;
	bh=Xe3Gyu68rkXUkmZtfF62UzY8eYhNR3uRfFJyFqhsFcc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FRfgvWHU+AKPzmofszJG2IUPjz23YPt9ioIt4OSSsMpVxnIXAhgXYxcucEhzyLVQh
	 byk/wcgacA7vIk+a6K90cAsKNfjToZHpChI5iJM91+VNPtkcv8u66vFbEaF83QfPR8
	 NLn84mYqHNjwZBaSR1W2ybGHwymC728LhgY6+GO0Ds4PPGrPdNPTRozvFnfp84L+1j
	 sw6GDlUCJXmZgrHOtFnYvt9+xOQG3FYlMbMUm1avl2rKpOAOY9oquJ8Sov25sAIUAP
	 ELXsyty/QbPgnD4PHHHMIoqy0jB6DJFQrNa0ALGMXKlwPmSJu2fW04WuMcGhJEuhyP
	 i8zWCsMdxFA9A==
Date: Wed, 30 Sep 2026 14:29:29 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, 
	"Liam R . Howlett" <liam@infradead.org>, linux-mm@kvack.org, rust-for-linux@vger.kernel.org, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	Onur =?utf-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, stable@vger.kernel.org
Subject: Re: [PATCH] rust: bindings: fix VM_MAYSHARE blocklist entry
Message-ID: <ar0OoDPMy3CetLMa@gremlin>
References: <20260930123645.302318-1-ojeda@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930123645.302318-1-ojeda@kernel.org>

On Wed, Sep 30, 2026 at 02:36:45PM +0200, Miguel Ojeda wrote:
> Commit 2b6a3f061f11 ("mm: declare VMA flags by bit") added constant helpers
> for the VMA flags and blocklist entries to suppress their direct bindings.
> However, it listed VM_MAYEXEC twice and omitted VM_MAYSHARE.
>
> Thus fix it.
>
> Fixes: 2b6a3f061f11 ("mm: declare VMA flags by bit")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Oops! :) LGTM so:

Reviewed-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

> ---
>  rust/bindgen_parameters | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/bindgen_parameters b/rust/bindgen_parameters
> index 8402b0c93545..93e622aaaf78 100644
> --- a/rust/bindgen_parameters
> +++ b/rust/bindgen_parameters
> @@ -50,7 +50,7 @@
>  --blocklist-item VM_MAYREAD
>  --blocklist-item VM_MAYWRITE
>  --blocklist-item VM_MAYEXEC
> ---blocklist-item VM_MAYEXEC
> +--blocklist-item VM_MAYSHARE
>  --blocklist-item VM_PFNMAP
>  --blocklist-item VM_IO
>  --blocklist-item VM_DONTCOPY
>
> base-commit: 7b5ba47d845f35b04937748a191a1772ffc1f288
> --
> 2.55.0
>

--
Cheers, Lorenzo
