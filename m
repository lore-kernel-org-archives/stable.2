Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB20628541A
	for <stable@vger.kernel.org>; Sat, 25 Jul 2026 05:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784956681; cv=none; b=YgCCIQCsZP90cghjUloF4xN07PQwuLb4TsJf7a5YJSqZBp4xw95v5kashxoZS9XK+ZDtEgpdsQJsoMOnSVyAD9/6rc14qrMszjKIrsFGfaKx8pjYCWA4VAUNrR8xAoiPoSLHDnLOWAUY4nBQ4AiH6c0yQG0mVz74YL8xsxXnLwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784956681; c=relaxed/simple;
	bh=Wn9TOkwl29wsIFWlXliymy6w9sEt3MiXC27VH8gNQmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEMvVkHs82xBQBppIbU5AsS3RXiGYQsVWm09yOjNgXQWroJ+hrveD932kwYZHCKMmmwMTbg0NBgRw/r01BoBVHdpb80aiUalskDyjW1TYShYzZD3mZ82r4SpdYcVz/dDqQjzKhyldDIa50e6kUeN0S+B11BFc3P4ND7EXJ7tSVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iKf5xPnl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iKf5xPnl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C25571F000E9;
	Sat, 25 Jul 2026 05:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784956680;
	bh=FfR347+TtVoQk0O66DHUGY+AmifaT6czud4rAUP4VZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iKf5xPnlVL922r6YGCpKpmTzouGs4LUGbzpah3Q8wxMWiRN4pwubttXdvHwtH75GQ
	 5rJWond3Ou+BBWOKEO0PffGZNgc47ghitImkF2Iuf4LKa37DfUM0SSDwVoa53SYxI5
	 /+q6SOZA8pkS5uDpI5A4/qdYSJSxVreqlvG81/e8=
Date: Sat, 25 Jul 2026 07:17:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Marcus Seyfarth <m.seyfarth@gmail.com>
Subject: Re: Please apply 90dfeef1cd38 to 6.1 through 6.18
Message-ID: <2026072534-strife-astronomy-3122@gregkh>
References: <20260725011342.GA2792705@ax162>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260725011342.GA2792705@ax162>

On Fri, Jul 24, 2026 at 06:13:42PM -0700, Nathan Chancellor wrote:
> Hi stable folks,
> 
> Upstream commit cc39f3872c08 ("seqlock: Introduce
> scoped_seqlock_read()") was backported in several stable branches (6.18
> through 6.1) recently without a necessary fix, commit 90dfeef1cd38
> ("seqlock: Cure some more scoped_seqlock() optimization fails"),
> breaking the build for certain configurations
> 
>   https://github.com/ClangBuiltLinux/linux/issues/2178
> 
> Please consider applying 90dfeef1cd38 to 6.18 through 6.1 to avoid this,
> it applies cleanly to all those trees for me. You may also want to
> consider taking
> 
>   b94d45b6bbb4 ("seqlock: Allow KASAN to fail optimizing")
>   88331c4ec23a ("seqlock: Allow UBSAN_ALIGNMENT to fail optimizing")
> 
> but I did not test if they were clean cherry picks.

they do seem clean, so I've taken them all now, thanks!

greg k-h
