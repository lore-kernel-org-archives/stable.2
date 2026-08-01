Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB9C2C2360;
	Sat,  1 Aug 2026 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785615514; cv=none; b=Eh7ARxRW9MmMJ83Pvs3icfZpl/W0qknHc/IircOPvH2/daItOEnopJSKPTCMRRONkDtacUYybZDAh0xwXFgQLMLJriOZX7WR23d9IgZtQZNNIEEfHV9x5KY0vR0H0S7wwjZB09/H5e+hNrKiQmPcQDtVuVuErgZaHiv8Loilzpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785615514; c=relaxed/simple;
	bh=ORqOFxcmP7W+8xf43eRYVlUUkbINFDttzQ1b4Bh7ajE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MHNaRajFb9GgyiaMxI6reeD74CLYG+pggd63q9NhY9QjCVobnRAMOTh3hpTdrYPf7AatMr085BJvJWowVzAbayUk5R2DOZRNnPO7y0QNfG1FAQSbRmP/Daw68MseUOQ7nRgG2T4QFxffrIYBvG7ClHti6KKvtNy0De+jM36l4R4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mrjz4Oh0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mrjz4Oh0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4927B1F00AC4;
	Sat,  1 Aug 2026 20:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785615512;
	bh=TNsAoc6kje7keok3Y5v1NqQsGebnf+Ddve9U5xp0O7Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Mrjz4Oh0tdY7PpOqfWrCGLc4tgrc6EzTH2F8umr/l/a0rbUY8pka7RcbdYyEtaZot
	 795PE0XyzK5fYg2o+iHD0mc478K9bXTmWeQ+fOsi7wDZ4U1az9NN+k0G3tsklYPBV0
	 ZWVQl6w6P4qUIKtY0TPhVWwz4sdWPMVfaz529y6dn8CADH1JfxOH8t2gyR9D2XdHwD
	 7djIMGy8J3lFmJLBXFfDKqoaOtFnV4gBuhp58WvjpDLmH4zARRzHeVcUwIncfXWy/a
	 Wd+/12+cqMvQWzloml96TYJH7UoiZ7vXB1e50tHt/LHLDfVieN/XO/K7dcbCWrYG9f
	 HzfjrmemUDvjA==
Date: Sat, 1 Aug 2026 13:18:30 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: fsverity@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Jiri Olsa <jolsa@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] fsverity: Fix bpf_get_fsverity_digest() dynptr
 assumptions
Message-ID: <20260801201830.GA9537@quark>
References: <20260731003925.2728977-1-ebiggers@kernel.org>
 <DKDRHTVNMQ2E.1FCTWQZO2EB7Z@gmail.com>
 <20260801171549.GB3567@quark>
 <DKDSE8AVM7Q3.3KZHCSNL4NT4L@gmail.com>
 <DKDSGKU7WKI2.3UV1GEZW2VZWY@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKDSGKU7WKI2.3UV1GEZW2VZWY@gmail.com>

On Sat, Aug 01, 2026 at 07:38:08PM +0200, Kumar Kartikeya Dwivedi wrote:
> On Sat Aug 1, 2026 at 7:35 PM CEST, Kumar Kartikeya Dwivedi wrote:
> > On Sat Aug 1, 2026 at 7:15 PM CEST, Eric Biggers wrote:
> >> On Sat, Aug 01, 2026 at 06:52:45PM +0200, Kumar Kartikeya Dwivedi wrote:
> >>> > Also correctly handle sizes over INT_MAX, which previously caused an
> >>> > integer overflow and crash.  __bpf_dynptr_size() returns a u64.
> >>> >
> >>>
> >>> I guess this occurs when using file dynptrs? Otherwise the size is capped to
> >>> DYNPTR_SIZE_MASK.
> >>
> >> Yes, though it looks like __bpf_dynptr_data_rw() excludes file dynptrs.
> >> So this particular issue might be unreachable.  Still seems like a good
> >> idea to match the u64 type that __bpf_dynptr_size() returns though.
> >>
> >
> > I don't see this in patchwork, so you might have to resend this with [PATCH
> > bpf-next] subject again to trigger CI if you want this to go through bpf tree.
> >
> 
> Sorry, [PATCH bpf], rather.

Sure I can do that.

Would it be okay to also make this function return -EOVERFLOW if
out_digest_sz is too small, similar to FS_IOC_MEASURE_VERITY, instead of
silently truncating?  The silent truncation is a footgun.

- Eric
