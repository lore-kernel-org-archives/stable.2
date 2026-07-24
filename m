Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F0F339364;
	Fri, 24 Jul 2026 08:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784882184; cv=none; b=SUYxSXNlXou1Rj8hEc5agHEgmJnQ9bN5mDoZw42NN9OhfXDzOjWwa2CC/CnCOK9/VlrCPR1ff/IN8QRIi6ET7haUCENFdxKG0c7vAY9W6xg3R48qP1PPJIOIjF0YJLqai2SgnPKTGlu8jDHwsz57H6QUbwGcG4XWhQh85UY5kSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784882184; c=relaxed/simple;
	bh=Md7cixl4RBTovBkhjC4bZiiVq4vrW0xK8I9PT2eDgBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBn8TYxe82eVoOKBR12QtiocQlIJ1O2uAnQy6qiyqZYKC5upsL9i5yNY662woH54Q4iLaldcCc7SOmxo156gG98K8HzcNUQJKMIR+EotEgAnk7cui1VpFtWk2L279ZLDns43JTxavtDJieRjjsGA3aDC7g48aN78Z7VK8yen7oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EB5ivsV2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EB5ivsV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FDD1F000E9;
	Fri, 24 Jul 2026 08:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784882171;
	bh=isYTbbCDqqs7rgcDcmNpXwH7cjXQjptNsocP9lUq12A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=EB5ivsV2VucohyzHgG6aVFIYunGmbZAq6K4bNRefJ/s31wfk8SsWa8/juoLFIz8eA
	 ZC39gAbg+eMjkgJmFvmhymaT93LTaowF2ur2CjKZi+MXmcvpZ9HeyltSa4ogWCSlhQ
	 2/5SmSUzJhgAQJXkKM3Pbf5K4KgqAZlU0z/NjaYc=
Date: Fri, 24 Jul 2026 10:34:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Vincent Mailhol <mailhol@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v2 1/2] lib/ucs2_string.c: fix out-of-bounds read in
 ucs2_strnlen()
Message-ID: <2026072427-sushi-grief-29ee@gregkh>
References: <20260723-fix-ucs2_strnlen-v2-0-9ea94e32a358@kernel.org>
 <20260723-fix-ucs2_strnlen-v2-1-9ea94e32a358@kernel.org>
 <2026072454-riverside-nuzzle-39e2@gregkh>
 <e7327736-219c-4475-84db-a25a25d1ec1d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7327736-219c-4475-84db-a25a25d1ec1d@kernel.org>

On Fri, Jul 24, 2026 at 08:59:02AM +0200, Vincent Mailhol wrote:
> On 24/07/2026 at 07:54, Greg KH wrote:
> > On Thu, Jul 23, 2026 at 09:40:31PM +0200, Vincent Mailhol wrote:
> >> ucs2_strnlen() checks the current character before checking whether the
> >> caller-provided maximum length has been reached. If the input is not
> >> NUL-terminated within that bound, the loop can read one ucs2_char_t past
> >> the limit.
> >>
> >> Test the length before dereferencing to prevent an off-by-one
> >> out-of-bounds read.
> > 
> > That's fine, but doing that read doesn't actually "hurt" anything,
> > right?  So this shouldn't be needed in stable kernels.  Or am I missing
> > something?
> 
> I had a similar feeling and didn't CC stable on the v1. But following
> my exchange with Andrew here:
> 
>   https://lore.kernel.org/all/CAMZ6Rq+Ax5MTs0Ke=XAB2JFX1KXuFas3B2eEMv+nQ4x7up2BLA@mail.gmail.com/
> 
> I think there *might* be some risk and finally CCed stable in v2. If
> you prefer to not backport, that's OK for me. As you can see in my
> above message, even if the risk exists, it is more theoretical and I
> don't think it would provide much leverage to turn it into a real
> exploit.

"turning into a real exploit" is not a requirement for stable backports
at all.  I was just thinking "is this even a real bug that needs to be
changed at all" given the lifetime of this issue, and the location from
where these strings come from (i.e. firmware images).

But yes, from a logical "this code should not be doing this" it does
seem correct to make.  Maybe someday we'll even be able to drop these
extra string functions entirely as we already have ways to convert from
utf16 to utf8 in the kernel already, so maybe we should just "normalize"
them all to start with after read from the firmware?

thanks,

greg k-h
