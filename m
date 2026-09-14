Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF9C246781;
	Mon, 14 Sep 2026 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789351629; cv=none; b=hsuELazW5M20N1oDJDhHzNHOeo6fW96tIOoIt99RwBlkBr+LQRCGU9MJ0I8TRqbcOp/7uLnc0KbK11ndVj2Twv/ZcFngCmAl5b9Yc9E6vTujqS8f4rKIjvIR110OPxLz2P4r+jDP/R0KTrishvBLWmTnCfse1o9SowkB36fm+34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789351629; c=relaxed/simple;
	bh=1kWL93cYnTqrnZmoXNldqUnHRWqFxrpYog9ia+Hn86U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=QFJKVeOybEHI4dMu4PE1G3DBc5N7dWTPz00MZjNhBRxyqQ8UP/MlFL36bflyNGSTbM06UHssTNaORVdhmeyS4YTP4aYJnH9MpkLmZTE+h44jQO7kw5+BhbszIwVnzIdOAZ7cYHwwwI5Nxh9ZaIjLcWMTpX9RRTcepDNaGPhFqls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=z48XcDsP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="z48XcDsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 371971F000FF;
	Mon, 14 Sep 2026 02:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789351628;
	bh=+pu/urSvpn4JmjwwRMYComRXTBcAZdt1t0xOxOdlET8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=z48XcDsPeJUkA+tKs8+pHKbuVFuz1PSbrEBYXJwq4XBqRzlUPivT+hjIV0fDwBuKx
	 V5qTljq1yvFNyi5bO2KdmcjjQ0iHzzlb3O5j1vpy4V4ZUyTTGGJP24uo19yixtMz0a
	 3pgrqhZ1ngzP1uKMILfG0dQAG4jAFxjYoSTzBPO8=
Date: Sun, 13 Sep 2026 19:07:07 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matt Turner <mattst88@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alain Knaff <alain@knaff.lu>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] lib/decompress_bunzip2: fix off-by-one in run-length
 bounds check
Message-Id: <20260913190707.413136686f78887287764f0a@linux-foundation.org>
In-Reply-To: <20260912-b4-bunzip2-blocksize-fix-v1-1-c7384bbfc954@gmail.com>
References: <20260912-b4-bunzip2-blocksize-fix-v1-1-c7384bbfc954@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 12 Sep 2026 14:17:35 -0400 Matt Turner <mattst88@gmail.com> wrote:

> The run-length path rejects a block when dbufCount+t equals dbufSize,
> but the loop that follows writes exactly t bytes starting at dbufCount,
> so a block that fills the buffer exactly is legal. bzip2 allows it too:
> its decompressor bounds a block at 100000 * blockSize100k and checks
> that limit per byte appended. Use > instead of >=.
> 
> bzip2's encoder stops filling a block 19 bytes early, so nothing it
> produces ever reaches the limit and the bug stays hidden. Compressors
> that use the full block size do reach it: an lbzip2 -9 image whose block
> ends on a run fails to decode, and a self-extracting kernel built that
> way does not boot.
> 
> This code came from busybox, which fixed the same line in 2013 in commit
> 932e233a491b ("bunzip2: fix off-by-one check").

Thanks.

> Fixes: bc22c17e12c1 ("bzip2/lzma: library support for gzip, bzip2 and lzma decompression")
> Cc: stable@vger.kernel.org

Why is a backport proposed?  Hopefully because downstream users need
this change, but the changelog doesn't tell anyone the reasons why.


