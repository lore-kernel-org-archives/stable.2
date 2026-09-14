Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED6A1E7660;
	Mon, 14 Sep 2026 02:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789353981; cv=none; b=tyiZadT6JyrAkBcLpumxBTC7ZekOTUMy2GjjJALDOtW6kjHtepnVKfQ35vaFb2qm/y+QcpXNrb4BzI3AVAZJjpUm0VuoHkH2M4Doavar29YFGLhAnmQH81JjF00NpjGO7fJyEMQWQd3yw4AOCuR+rJrgr67EWxg9k1uHssWzYas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789353981; c=relaxed/simple;
	bh=Ggv7iiKSnJ//YXcRsLNIhsICt70COz7t+5Va241/BH8=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VVhDnSikIK5h1KVB0TWkEx6y9ph2n3MaryDeG6sW4BWG5/V0RmRTkYQ7IosV3+J8qfEw+v7CnnhR4i0wbkQpe5P+KU48tCJhVudZq4wH6lPjDn5eRyR/P7ZtMudyifgavzoyQ+tVG78GdxfgevGCjhjgoSveYZ706lZAN79CmHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=vjTonrjZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="vjTonrjZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FC11F000FF;
	Mon, 14 Sep 2026 02:46:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789353979;
	bh=yv+aHnaOZ2/MmPPiwQdl4d3Iiw3sTv+0+gOwBC8ojuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=vjTonrjZGHAtABmztdeAkNyp2YCTSg1hcvPpxl2hGbuavMFxABpIw2SS42ROp4V+P
	 b/fM0/GPmW3vPLG7clxQaYRx1foWn4CkDoCAm4Bt9O5fnCMTZ2ZZSqHUiRi/si4cch
	 HEvHwkjxFWqLMoTC+cbr8q7OC1mRnKG65s/GpCBA=
Date: Sun, 13 Sep 2026 19:46:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matt Turner <mattst88@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alain Knaff <alain@knaff.lu>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] lib/decompress_bunzip2: fix off-by-one in run-length
 bounds check
Message-Id: <20260913194619.f495704b6d28bf67a50570cd@linux-foundation.org>
In-Reply-To: <CAEdQ38HY2wYptnqo_yF=GX9PsY7akUVB2z64HbErATOF=R5vKg@mail.gmail.com>
References: <20260912-b4-bunzip2-blocksize-fix-v1-1-c7384bbfc954@gmail.com>
	<20260913190707.413136686f78887287764f0a@linux-foundation.org>
	<CAEdQ38HY2wYptnqo_yF=GX9PsY7akUVB2z64HbErATOF=R5vKg@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 22:16:16 -0400 Matt Turner <mattst88@gmail.com> wrote:

> On Sun, Sep 13, 2026 at 10:07 PM Andrew Morton
> <akpm@linux-foundation.org> wrote:
> >
> > On Sat, 12 Sep 2026 14:17:35 -0400 Matt Turner <mattst88@gmail.com> wrote:
> >
> > > The run-length path rejects a block when dbufCount+t equals dbufSize,
> > > but the loop that follows writes exactly t bytes starting at dbufCount,
> > > so a block that fills the buffer exactly is legal. bzip2 allows it too:
> > > its decompressor bounds a block at 100000 * blockSize100k and checks
> > > that limit per byte appended. Use > instead of >=.
> > >
> > > bzip2's encoder stops filling a block 19 bytes early, so nothing it
> > > produces ever reaches the limit and the bug stays hidden. Compressors
> > > that use the full block size do reach it: an lbzip2 -9 image whose block
> > > ends on a run fails to decode, and a self-extracting kernel built that
> > > way does not boot.
> > >
> > > This code came from busybox, which fixed the same line in 2013 in commit
> > > 932e233a491b ("bunzip2: fix off-by-one check").
> >
> > Thanks.
> >
> > > Fixes: bc22c17e12c1 ("bzip2/lzma: library support for gzip, bzip2 and lzma decompression")
> > > Cc: stable@vger.kernel.org
> >
> > Why is a backport proposed?  Hopefully because downstream users need
> > this change, but the changelog doesn't tell anyone the reasons why.
> 
> I ran into this because my system uses lbzip2 as /bin/bzip2 -- a
> common thing on Gentoo I believe. As far as I can tell, anyone using
> lbzip2 as their system bzip2 would run into this and it's only because
> it's very uncommon these days to compress a kernel with bzip2 that no
> one has noticed. I only noticed because I was adding support for
> various compression formats on alpha.

OK, thanks.  A real-world i-hit-this is compelling.

> No strong preference for a backport from me. Just thought it would be desirable.

np, I;ll retain the cc:stable.
