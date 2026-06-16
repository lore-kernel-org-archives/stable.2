Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C15872FFDD5
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 13:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617343; cv=none; b=dMIXp/9FpOnVO7YKSnpvyMW+gzaC6fdFtpYJbWIJlI+krcALKcqqzdxncWRinvDRYRs30UIpDK5HQLxfIZDwbAYdjdmiHe9Lar+ayi2oc2wljDE66qlp5HMlCsWVUZPPkGgNdwle+iH3sflOG6aN7lAPnYGKGqdfa4oGihRkplg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617343; c=relaxed/simple;
	bh=Z8+M+jTBdZz/kRhZ192LUFh35c9m2dFZgLP2oibWc2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQME3eYcOEd5qUX+NO916OkxjJr3bPZBkOEogzRPznIr4DKLs0JevSZBXwaLMs2O05wa5o+8yHakP6kdUkv6orOSFPV/LX9/CGOlhBidFyak6g0MzrMnKMX/5VGpxhz4+HEFaofntaKa2ZQki/YiapjdpgzxUjL0EIFx+0rWGfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XbIE9m3L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XbIE9m3L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92931F000E9;
	Tue, 16 Jun 2026 13:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781617342;
	bh=oN+0E2Rjlm3CCS859ehWVQ4Ska16Q6Sa9rLFmIDGXKM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XbIE9m3LctY6JxcCuz5QCuJIlNBJrXg9dobkvsDojalJozDbhK7zwyAnuKSaKmWAX
	 IE1iKVO+F5zA1AjX+J+xj71H+Uh62SJeyNPS38RDZTZVFqTiFfgn5x+8EA7PKTSLPp
	 EhHmkpw/Iu+BqKRhxGvIQbks7dnU+dsSTMeVq+XA=
Date: Tue, 16 Jun 2026 19:11:16 +0530
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Ben Hutchings <benh@debian.org>
Cc: Sasha Levin <sashal@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Nikolay Borisov <nik.borisov@suse.com>, stable@vger.kernel.org
Subject: Re: [6.6] x86/CPU/AMD: Move the Zen3 BTC_NO detection to the Zen3
 init function
Message-ID: <2026061610-mustard-marmalade-4319@gregkh>
References: <ahhd83m8AruYGvOc@decadent.org.uk>
 <1d128ddf72c7c42d47e1348b9dc74f7f829621fd.camel@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d128ddf72c7c42d47e1348b9dc74f7f829621fd.camel@debian.org>

On Thu, May 28, 2026 at 05:35:50PM +0200, Ben Hutchings wrote:
> For 6.6, please cherry-pick commit affc66cb96f8 "x86/CPU/AMD: Move the
> Zen3 BTC_NO detection to the Zen3 init function" as stable dependency of
> commit 0da91912fc15 ("x86/CPU/AMD: Move erratum 1076 fix into the Zen1
> init function").  This seems to be applicable without changes.

Now applied.

> It seems like 6.6 should also get backports of:
> 
> cfbf4f992bfc x86/CPU/AMD: Call the spectral chicken in the Zen2 init function
> 7c81ad8e8bc2 x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common()
> 
> which have already been applied to the older branches.  But these don't
> apply cleanly.

I've applied them now, thanks.

greg k-h
