Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B113B2FF7;
	Sun, 12 Jul 2026 20:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783887945; cv=none; b=jlAxu55ICr4ep3tCGE6eJLwkUbzcjoifm3o3pCpFQwHu6caCf22lkxRKAo95ezA8aUg6UUlD8c2KzUC64VyaQDfQNspnYHHOL2O/2eFWkyU985Io08RVoTKeuz6zLk0IIDe3T/t77eZac7EsfocNzkoM5OoqNxWL2UXhlhZVN8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783887945; c=relaxed/simple;
	bh=w58RJbTM/XNuR7OJ1o1B9jjHItSmJL04yohbEsOHz1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti5LLi/c75YVdVjfqN2sIZFBHQEE+yzJ7PLcQEOfIDZWsFKCiSoGxL6RFsRhdFSGndomga4/7JsLWG63D/MPnGlXke8Noq0fckeeK+czrOqS08ahs63n3bNEL8pjVQ2yjnD1/+oDdhjQP06Y4mCyYkTQ5eZgz4xjzur1J99KYNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EeH8981M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EeH8981M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DCB1F000E9;
	Sun, 12 Jul 2026 20:25:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783887943;
	bh=fipz/1od8xfNsKCg/Ibc/FXmlJLUhV1vPNi1hbt9yNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EeH8981Mu2ZyWhFUea/KnxXkTzCwhvb3hkHfdImgDhZcb3+HVLnmg1nNfnS5ik+05
	 OzOZbVYT0FR0cEOK1O2zbYoFlceLiVaTx/+Okrp6nV0hshA/qylcmSZ8CdF5L2jIga
	 VC12M367CuANZ0hOcmEbLvov4PdTZiPRDjyLSl8p8PB60saYktN09wA03OT52qjYH0
	 FciXcet8XNJxLsR6obarGp1kxr6Yx/HNY8Qvjp7fkRwS3vQS5S2tkDZ1JSPlG3IMnX
	 nCuTkFZiZDhFJE87e1hnu6J+6fQJsh+h7WGfQUVTzvBDAnh4KCWzhrod8XnVs9ydFV
	 HUNupbsezIRog==
Date: Sun, 12 Jul 2026 16:25:38 -0400
From: Nathan Chancellor <nathan@kernel.org>
To: "Chang S. Bae" <chang.seok.bae@intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, Omar Avelar <omar.avelar@intel.com>,
	stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH] x86/build/64: Prevent native builds from generating APX
 instructions
Message-ID: <20260712202538.GA1697833@ax162>
References: <20260708211435.402426-1-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708211435.402426-1-chang.seok.bae@intel.com>

On Wed, Jul 08, 2026 at 09:14:35PM +0000, Chang S. Bae wrote:
> Omar reported this broad concern to me, when resolving a separate issue
> with his custom module. CONFIG_X86_NATIVE_CPU=y allows builds to
> opportunistically emit APX instructions when the build host supports APX
> since commit:
> 
>   ea1dcca1de12 ("x86/kbuild/64: Add the CONFIG_X86_NATIVE_CPU option to locally optimize the kernel with '-march=native'")
> 
> The kernel is not yet prepared to use APX internally. For example, there
> is no context-switch support for general in-kernel use of the extended
> GPRs.
> 
> Explicitly disable APX when building with `-march=native`.
> 
> Since GCC 14 and LLVM 18, both compilers support APX. LLVM 19 is already
> the minimum version to support native builds from:
> 
>   ad9b861824ac ("x86/kbuild/64: Restrict clang versions that can use '-march=native'")
> 
> RUST supports APX detection via XCR0 since v1.91 release. While the
> support is not official yet, conservatively set that version as the
> minimum.
> 
> Reported-by: Omar Avelar <omar.avelar@intel.com>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: <stable@vger.kernel.org> # v6.16+
> Cc: Miguel Ojeda <ojeda@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> ---

Miguel's comment aside:

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

Some style feedback below.

> ---
>  arch/x86/Makefile | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> index 598f178102ee..256948e65073 100644
> --- a/arch/x86/Makefile
> +++ b/arch/x86/Makefile
> @@ -161,7 +161,15 @@ else
>  
>  ifdef CONFIG_X86_NATIVE_CPU
>          KBUILD_CFLAGS += -march=native
> -        KBUILD_RUSTFLAGS += -Ctarget-cpu=native
> +        # Do not generate APX instructions as in-kernel use isn't ready
> +  ifdef CONFIG_CC_IS_GCC
> +        KBUILD_CFLAGS += $(if $(call gcc-min-version,140000),-mno-apxf,)
> +  endif
> +  ifdef CONFIG_CC_IS_CLANG
> +        # The minimum version for native build already supports the option
> +        KBUILD_CFLAGS += -mno-apxf
> +  endif

As the flag is the same between the two compilers, I think it would be
more readable to do something like:

  # Do not generate APX instructions as in-kernel use isn't ready
  # Supported by GCC 14+ and LLVM 18+
  KBUILD_CFLAGS += $(call cc-option,-mno-apxf)

I realize this was probably written to intentionally avoid calling
cc-option but I am not sure it is worth micro-optimizing the build like
this. Another option that avoids the separate blocks and cc-option would
be something like:

  KBUILD_CFLAGS += $(if $(call gcc-min-version,140000)$(CONFIG_CC_IS_CLANG),-mno-apxf)

That said, it is ultimately up to the -tip folks.

> +        KBUILD_RUSTFLAGS += -Ctarget-cpu=native $(if $(call rust-min-version,109100),-Ctarget-feature=-apxf,)

The trailing comma is not necessary for this if, it is implicit.

>  else
>          KBUILD_CFLAGS += -march=x86-64 -mtune=generic
>          KBUILD_RUSTFLAGS += -Ctarget-cpu=x86-64 -Ztune-cpu=generic
> -- 
> 2.51.0
> 

-- 
Cheers,
Nathan
