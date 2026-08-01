Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D983928CF5F
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 21:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785618149; cv=none; b=LoXcizxs6Dj2X1MtSOV14lik6AVwatUuJT91Eu82R7Ehuw/CJzBjhg8zghDO4vlOE6z2QLGY7G4FBcyTeaHMK8CmpR1FpWH3BunfizFSgCivnxBk++URfXYtBRC8dIyiI7m+MVkWe0ELQOM4Ftq+q8UIl+rm3iFw0c6PlyTv8Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785618149; c=relaxed/simple;
	bh=rXI+JVrxD5XloZ/VK/fxowfKybqVprXe/tm2KRECu9o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KMwLnkc/icet1xX9XMB+XBu/Gb3D4mDubrzEcskIrP5p9OdHN1V4IMg7WVEjqTmzfkS+JQ8+C+J61F43L8/2EbqcL1gnXeftBeOcB7hpYU1x9eXBrAUvzeDGPLNqf3DQ+fnXjFS8UuiCf9CJwhPyhuo1bynvxNWEF3quPR/2ctI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Id3E8A5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Id3E8A5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8353A1F01560
	for <stable@vger.kernel.org>; Sat,  1 Aug 2026 21:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785618147;
	bh=olJ0nI/U++jYX/fIvyreb0oMFqIN3HKNoT2JSmFRmag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Id3E8A5K5BZ8XyCMAmVcCZ/cEnq7S8bWh5bziNR7CL/jCBR61LJ/ZQj+cEgCjBfSB
	 iNQJXO+nejSiRXKaiNFCnrcmsiLawV31K524M+99RkIn340b9kade3odPo29AVAU9W
	 wIUSAlZvPyJHamwC5I/ekBmNh6PSzXo8p/WrLi8RHUVffEfx3WoRcQgpiKwkSTgXGC
	 RpNbs/kvgYXxh8p4V8jWzEMkhzmr5HF79ePRbScwIvL1nXHDx7axByh27qDMoXRQeS
	 XgoaD3MHuNf3NHCLwq6YEBcWX+mRHqbM3e0NM5uqv8YXpL39UHWLwJvvaxE6w9yfyH
	 hY5BSuw5vejmw==
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8f18d92172aso22651856d6.2
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 14:02:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrmGIHSIb2mRDfgsmMMSkdNbevt/QbpnZpeWR8GMzsBppo52Z7FASdD8QudbxACkhlImdvCNLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSz5pGCWwI9WX9qq+qsaYpRsxJPyJe33sNsqaXVqvYKM1K23w5
	yAcMVW0Xuq5ZhymICI/RaVXjgkMnVMvFuLdtQ/G5YbU333yGL8mnxU+YlfoXZ5yWuUAwHZk61Rj
	fSVPX/hKOFXtCs3aZK2FF4MJ9UC3yHvw=
X-Received: by 2002:a05:6214:4991:b0:8db:1179:d180 with SMTP id
 6a1803df08f44-9084969b912mr106846486d6.23.1785618146711; Sat, 01 Aug 2026
 14:02:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731003925.2728977-1-ebiggers@kernel.org>
In-Reply-To: <20260731003925.2728977-1-ebiggers@kernel.org>
From: Song Liu <song@kernel.org>
Date: Sat, 1 Aug 2026 14:02:15 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6dpxd56e3QT8AfwYPsNs3JCS_Tk8waWzNiX0en8Hha3w@mail.gmail.com>
X-Gm-Features: AUfX_mx5--PdLH1zOLLDs7nuXsIDH9KC1pKH374bXlAZD87qQfYeyh1BypiJFJ4
Message-ID: <CAPhsuW6dpxd56e3QT8AfwYPsNs3JCS_Tk8waWzNiX0en8Hha3w@mail.gmail.com>
Subject: Re: [PATCH] fsverity: Fix bpf_get_fsverity_digest() dynptr assumptions
To: Eric Biggers <ebiggers@kernel.org>
Cc: fsverity@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 30, 2026 at 5:43=E2=80=AFPM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> The BPF verifier and the dynptr abstraction ensure that the memory space
> referenced by a dynptr remains valid.  They do not, however, provide any
> guarantee that the contents of the memory are stable.  kfuncs are
> expected to remain memory-safe even if concurrent modifications occur.
>
> bpf_get_fsverity_digest() didn't follow that: it could crash if
> arg->digest_size was concurrently modified.
>
> Fix that by using the known-good value hash_alg->digest_size instead.
>
> Also correctly handle sizes over INT_MAX, which previously caused an
> integer overflow and crash.  __bpf_dynptr_size() returns a u64.
>
> Fixes: 67814c00de31 ("bpf, fsverity: Add kfunc bpf_get_fsverity_digest")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Looks good to me. Thanks for the fix!

Acked-by: Song Liu <song@kernel.org>
