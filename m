Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDE93254BB;
	Mon, 14 Sep 2026 02:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789354174; cv=none; b=fWm1ENxc99oszOjNcdNC2o6D7zaC8srtX+NF//aaVdEuMBsXD4tq6WThGonMQyulFRtCZRnoBeDGVmNdr4QNFk9D0/pkZPU3/qA5Gn+E8GEbyBU4ZSUqJ6DqLsottbMnGg32qsByEJJzskvJVj0O7Wd5HotF1AVtJN64famNhqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789354174; c=relaxed/simple;
	bh=4r4gbZDX85l4TYEDjy7dfg9LOyLIrr6jG0MJC8g+qJo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hcev9Mt3wQvMPvBTzB97U4DtMszImx+k71fPhbvHysjKsk/EEOtnwdPhofQoFaHh/en110fFpbXORrBEjk/QrME755Z68665GCMDFGFv+xDO/MLEnNdnMTJ1iSJmtHmxtQZDmqE7E9ZQ/vq3AL15byEzPxaUW+e29tlhdCOe1N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AaTD2NyR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AaTD2NyR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B8471F000FF;
	Mon, 14 Sep 2026 02:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789354172;
	bh=WKfdq/2wQ5WysxUnF43hDIuwgvgk5lQoDU90FkHgo70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AaTD2NyR/GAGgaOZI7yYmDd5HDWebrJAfXpI+PZDi2DOwyUr01vKpoVCAXFP2CEz8
	 UcHt1eFyuXtuf9Aar+vEER74ooeVRrGOr5WnTQnIa1wYMqpqee1jCozS7Skdy9f+uL
	 sVpsy197//eCMVI8B+BkZf5ib09HT/HK+wRT18NQ=
Date: Sun, 13 Sep 2026 19:49:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matt Turner <mattst88@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alain Knaff <alain@knaff.lu>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] lib/decompress_bunzip2: fix off-by-one in run-length
 bounds check
Message-Id: <20260913194932.c36fad94a3a74fbed5cdb4a6@linux-foundation.org>
In-Reply-To: <CAEdQ38FOnZPmhc2LYOCXS4sqpi4gqLGnkUMA7EXyDFL_9A=X0w@mail.gmail.com>
References: <20260912-b4-bunzip2-blocksize-fix-v1-1-c7384bbfc954@gmail.com>
	<20260913190904.bd6811bc8e094047017c67f3@linux-foundation.org>
	<CAEdQ38FOnZPmhc2LYOCXS4sqpi4gqLGnkUMA7EXyDFL_9A=X0w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 13 Sep 2026 22:18:07 -0400 Matt Turner <mattst88@gmail.com> wrote:

> On Sun, Sep 13, 2026 at 10:09 PM Andrew Morton
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
> > >
> > >
> > > ...
> > >
> > > -                     if (dbufCount+t >= dbufSize)
> > > +                     if (dbufCount+t > dbufSize)
> >
> > Sashiko thinks there's also a potential overflow here which could be
> > addressed in this patch.
> >
> >         https://sashiko.dev/#/patchset/20260912-b4-bunzip2-blocksize-fix-v1-1-c7384bbfc954@gmail.com
> 
> What's the appropriate flow to/from busybox (from which this code
> originates)? Apparently we don't sync from busybox, but do we want to
> avoid divergences?

I'm not aware of any such process for any of the lib/ material which
mirrors some userspace project.  So I guess it's an ad-hoc "send them
an email" thing.  There's clearly risk that if we accept a new drop
from upstream, such kernel-first fixes will get lost :(



