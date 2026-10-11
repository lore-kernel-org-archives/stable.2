Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A75934D93B
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 07:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791704852; cv=none; b=UqAJRHnqAHLc/k65bhSVj3ns/0UvMP/sbH/Rk/uELeJpMOmai9hpZ3GQnXNz8CB+rDsEgvBWeB6ZQDQxdpCs2Fo8M2JLrVYT7ljpAJPz+WSZu83YWWacLtEc9mj6f0W4h3IKE5swx5CCzCEc1ADKuqmo5gLxJT8I5Cy11OlTQtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791704852; c=relaxed/simple;
	bh=uT+lyM2buOzsSPCfnCJbWWFK+g5D9PAvb+0Z+qhMdcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BV96XUPVgJKQX/yT8ujNxjtIlOHm+jLgl+IDDr7sLIH+AtG4Q87xKgiNI822PB/LDdSOcuVolisBrEtj0Cicv9Ub/DA0DvbeWl8afr1XBqWtouGakqsGyXtDtEprDospvNl9cd1AqUkOYPYFyfKL04scEKLHvWZAFHfxKbwtQHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfNI+E/d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfNI+E/d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5D21F0089D
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 07:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791704851;
	bh=JlRrshqoncb1nPc1YH8iKssdhdAAi72cR+g7ttfhdUY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nfNI+E/dTSNIroxxRtO8T9R1PI+d3ZqG6O/vhF5YJFFlA8vS3sI8rSIrCUUwFLpo/
	 OiKzrr4WuRmMFc9CbIBqjcskPUbxclMDCtmI8Y8QhawMkuRBOyjHi4dSuhwPk2w/Ex
	 7v1Y9+IFdYfmwBAy0fM9pyafPjgW6D9cwy0j8CibQoRbwN2OKweNpIpbUYbUzh/yBd
	 Zqj4DguZkzs40dGfx0wCPOfIc+RRK0BHQYs+yac1a+U14sL3SwR1BzL6vYwgrH/yAc
	 BNgRJz7GDb2L4AeTPrGQHgzqSegm75Ck2kNpcKwYsXKrPdh0MA58MGZ7V3G+HOefKX
	 W47aSiS/5r4IA==
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93cc1ab5f6cso133297185a.0
        for <stable@vger.kernel.org>; Sun, 11 Oct 2026 00:47:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwlo+j8gLABfvzvMMIxf2gA7ZfVugakbqbCD8ukaD5JWlWVKAqIsKfsw6+E7aVmHyRb/U8GcLA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvateP+lCzXrx2MbxWiaHzaUbGlYrLeX7J1mbsFMayHmYAmNMa
	MOSIeCid0oKBh4Dc4UfUWTCul2E2MgPc+dWy/0++tdN856hHToVQ18vhprTFcTUfrxh2CXXdRu7
	m1+LL6ovHZ822C5gRnUK/fdMiI7OsLLs=
X-Received: by 2002:a05:620a:44c1:b0:93e:9927:fd34 with SMTP id
 af79cd13be357-93ebd2244camr1017488585a.28.1791704850198; Sun, 11 Oct 2026
 00:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011040232.2940423-1-zhaonanzhe@xiaomi.com>
In-Reply-To: <20261011040232.2940423-1-zhaonanzhe@xiaomi.com>
From: Barry Song <baohua@kernel.org>
Date: Sun, 11 Oct 2026 15:47:18 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4y-9mmwjjb3UAb4=meONcn_SjYVgDuQJJ5QbdA-3Y=XeQ@mail.gmail.com>
X-Gm-Features: AclHuK9sQwDYiz6jpVGp-nkoQLz8HOVchDFynrkGu0-9gSXFWAXjND2_2qgQY40
Message-ID: <CAGsJ_4y-9mmwjjb3UAb4=meONcn_SjYVgDuQJJ5QbdA-3Y=XeQ@mail.gmail.com>
Subject: Re: [PATCH v2] f2fs: remove mappedtodisk flag usage in mmap write path
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, Chao Yu <chao@kernel.org>, 
	Jaegeuk Kim <jaegeuk@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 11, 2026 at 12:02=E2=80=AFPM Nanzhe Zhao <zhaonanzhe@xiaomi.com=
> wrote:
>
> PG_mappedtodisk was inherited from the nobh/buffer-head era.  However,
> f2fs has no buffer heads and the flag is no longer meaningful.  The only
> user of the flag is the "no holes" shortcut in f2fs_vm_page_mkwrite(),
> which makes mmap write faults skip marking the folio dirty.  Chao Yu
> pointed out that this is not only a cleanup: it causes the following
> race condition with filesystem freezing:

Somehow, I feel that "Remove this shortcut in
`f2fs_vm_page_mkwrite()` and stop setting it in
`f2fs_read_single_page()`" should come before "Chao Yu
pointed out that this is not only a cleanup: it causes
the following".

We're saying that removing this shortcut is both a cleanup
and a fix for the race, right?

>
>  CPU0 (write fault)     CPU1 (freeze_super)
>  ----                   ----
>  f2fs_vm_page_mkwrite()
>  sb_start_pagefault()
>  /* shortcut: no dirty */
>  sb_end_pagefault()
>
>                         sb_wait_write(SB_FREEZE_PAGEFAULT)
>                         /* no waiter, passes */
>                         sync_filesystem()
>                         /* folio not dirty, skipped */
>
>  finish_fault()
>  /* PTE writable */
>  fault_dirty_shared_page()
>  folio_mark_dirty()
>  /* dirty folio on a frozen fs */
>
> It will also skip APP_MAPPED_IO iostat/REQ_TIME updates and post-EOF
> folio zeroing.
>
> Remove this shortcut in f2fs_vm_page_mkwrite() and stop setting it in
> f2fs_read_single_page().

I mean, this sentence should be moved earlier, or the
preceding sentences should be reworded.

>
> Reported-by: Chao Yu <chao@kernel.org>
> Link: https://lore.kernel.org/linux-f2fs-devel/496b913c-eb81-4fa8-be72-c6=
a06a10aba2@kernel.org/
> Fixes: fbfa2cc58d53 ("f2fs: add file operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>
