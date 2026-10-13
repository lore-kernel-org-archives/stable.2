Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55FE4AE128
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 06:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872435; cv=none; b=dytDX4gfzgkHKmA1WNbzz4p2wn8000TVCml26nuz0CIlbMZwy2cjKOx6Hc2ZttZ86HtNh1lgtsQ3jkxeLKU2ihexuVw/e40gVC7uRu3BU7gYMwLyAH3ENbRzjQwNHati42+wZYnICAg3WOAQaa8SPdTPht+axCSjKlFE5K8L2sM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872435; c=relaxed/simple;
	bh=U66D6HcLqcKePOOjsO9KFfUmLwd3P1S5ZpwrjSIUuak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L71ZaXX+Aooh0zcW0yJxDKw8cSy5eyfyGtbTRqC2uonePQ07EwnKzj2C2zymjbi/U9OzzMCtL12M/aEcFr7gJdd3aQmT3syqIZskrWRRqjitg3RlXJAvDnHoW3Sh84NHYLMdPRiMVIqHHUzUg21GCdPS3PYi7/gFaAL3KGWGUXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C6HvDOu/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C6HvDOu/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24961F000FF;
	Tue, 13 Oct 2026 06:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791872434;
	bh=NgBnyCGER/9FF7nSKcvfxRVKzmSBkX6pjnGVv6W7F8I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=C6HvDOu/tUSJcfaZnvfHnoygrzitHHe84DQV9E4A/55OJqGIXwTOuW2QfDq2Zgq3O
	 c42FjhaC657NHeMIjnE5cqMi32C9K6+n1iOUIXpNxbGPXlxTxzOB5wIIOspkVH2xi/
	 vHT2yGlz/1qICgXvcj3YFa0u8tq5Q8oGSIEJKTOU=
Date: Tue, 13 Oct 2026 08:20:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Borislav Petkov <bp@alien8.de>
Cc: ljs@kernel.org, riel@surriel.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] x86/CPU/AMD: Fix AMD TLBI Erratum #1718"
 failed to apply to 6.18-stable tree
Message-ID: <2026101331-muck-supremacy-62da@gregkh>
References: <2026101206-disparity-thrive-6c91@gregkh>
 <20261012192911.GBas01B5yAgDcJnPjz@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012192911.GBas01B5yAgDcJnPjz@fat_crate.local>

On Mon, Oct 12, 2026 at 12:29:11PM -0700, Borislav Petkov wrote:
> On Mon, Oct 12, 2026 at 01:36:06PM +0200, gregkh@linuxfoundation.org wrote:
> > The patch below does not apply to the 6.18-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> 
> Try this one:

that worked, thanks!

greg k-h
