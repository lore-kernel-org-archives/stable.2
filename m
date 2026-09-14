Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5CF3093DB;
	Mon, 14 Sep 2026 02:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789351746; cv=none; b=hF7YV0abI+KGE3c0umNQhDyTfe6rphi+TqovJEx5ea2W/bt7zs4H2F7oF1d05JEI5idjP52nQOSb0Io/5uuciioeH5A4cENhOUL1+ip7kZn73ng8/4yiLB1A1QD7LQSmsnCiVWEkwINvcZNZGMnp5ISJ6Fa6KEDOoFB/9colgWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789351746; c=relaxed/simple;
	bh=SUG0gRcwIwx7xb1Sq6AbiLh4LtwOleskY6QzrVhzXTo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VtDLcAuVykq7vXHyrFvTYtsx9maiG5ogYr7b8I9uyictv45x/GHgytzJur2M2h37a/LxGKF7PFF/mVNQ8Pky2oXSDLHfvMDCZavnLd99lnmGpS+6OWFgq/LYA9gfNJRSaWmnrU68c6WpZ/Tm3aizAmKKmAydEnUZVgCAPVL5VT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=pVTrcPpn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="pVTrcPpn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7604B1F000FF;
	Mon, 14 Sep 2026 02:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1789351744;
	bh=4c2kwoTlVBuviedQUKOgCdQEqDl7W039UgsSLYcKHuA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=pVTrcPpnDKVlJLAAClxYSaXiJ3K7UDo+H+KWjx3hHaJaI8flsqgMLqlOmeaUy9ihb
	 7FHGA+PwsRLZScwgRxTG14c0/2YvnBrq9jc+HEdwcFQoNMyizL++CL/+cscKtFh0Z9
	 M8vqJfxMN9c0w6+AZahUNkc4pQP3rVw2m8CRDzBs=
Date: Sun, 13 Sep 2026 19:09:04 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Matt Turner <mattst88@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alain Knaff <alain@knaff.lu>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] lib/decompress_bunzip2: fix off-by-one in run-length
 bounds check
Message-Id: <20260913190904.bd6811bc8e094047017c67f3@linux-foundation.org>
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
> 
>
> ...
>
> -			if (dbufCount+t >= dbufSize)
> +			if (dbufCount+t > dbufSize)

Sashiko thinks there's also a potential overflow here which could be
addressed in this patch.

	https://sashiko.dev/#/patchset/20260912-b4-bunzip2-blocksize-fix-v1-1-c7384bbfc954@gmail.com
