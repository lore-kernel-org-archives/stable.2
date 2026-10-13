Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8234DAFA4;
	Tue, 13 Oct 2026 11:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791891028; cv=none; b=HfKMT7xiPaKHA6Fr6ycnbZFc1SK70h2YZTgLRBBbIuoo2dK8AzPLm9+XMGccW/9PuaOmqUt9ze5zgUGyRmYLv8QFBtWeaKJacAGpaIaZALAwjBKQ3XHvGuWru7eA7Wte+AHTG6W+eC0HT/ZA0h7O/6yqAoyA71SX/x6q5tw3BkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791891028; c=relaxed/simple;
	bh=CDk5aeYqL49hq69LHhq919ssqTtoyNd2GzITub2kPm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/baP7gUBmD9miaiVnm69wc5qyAYJ8BvY0ZspVWaQKN8Uu0iOuJnGB3U1JHsGD4DdbN6KXWgVsbeB4hdIzdC/ESKSfVh2qCS9yenFM2Ef8I6kTuM3uZo06VWmy2BDq9zYPNpedd9SctjdrvQM214TvozAQuvazV0embGYOUKnJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5hcsCUD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5hcsCUD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3BE1F000FF;
	Tue, 13 Oct 2026 11:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791891026;
	bh=AbuubQMqIWURa7xcEbVazmv8Iuf/praRkVi4La8Wohk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R5hcsCUD+0eCdv9NN4nVV9gF7Adq/8hoJYhkSW0Yc7Fnrm9yKSN/5jYQXr6b3cQAQ
	 m7b3qgWKFpAMNP1u1LPLaQomj8Iz8rQI/pu9R5HPaTQ7ezc9cEPGGBzb8f7DODKQXJ
	 kI9lOJYOKWHo50TO0QHiPQegeVDb7zESky9eVS+ztKIfDzh+9E1W/HsNivAcY5rZ+l
	 jlikqKQmEYRJJclxbEvivy/XhiqaTNQQkCQkj1NM2jI9rtNFQL8QP9R/wAJhs0gg11
	 txYr7UFZ6ReXzpAGsEC/xqBl8iF9u9cS2eVNtnwBg/2aNkZGMNxJBDctaZVF/ZzJnO
	 yKBwQy4srEcVg==
Date: Tue, 13 Oct 2026 13:30:20 +0200
From: Gao Xiang <xiang@kernel.org>
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	stable-commits@vger.kernel.org, xiang@kernel.org,
	Chao Yu <chao@kernel.org>, Yue Hu <zbestahu@gmail.com>,
	Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <hongbohbli@tencent.com>,
	Chunhai Guo <guochunhai@vivo.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-erofs@lists.ozlabs.org
Subject: Re: Patch "erofs: remove fscache backend entirely" has been added to
 the 6.18-stable tree
Message-ID: <as4WTEbunXMcOIvc@MacBookPro>
Mail-Followup-To: Greg KH <greg@kroah.com>, stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>, stable-commits@vger.kernel.org,
	xiang@kernel.org, Chao Yu <chao@kernel.org>,
	Yue Hu <zbestahu@gmail.com>, Jeffle Xu <jefflexu@linux.alibaba.com>,
	Sandeep Dhavale <dhavale@google.com>,
	Hongbo Li <hongbohbli@tencent.com>,
	Chunhai Guo <guochunhai@vivo.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-erofs@lists.ozlabs.org
References: <20261013020044.2527207-1-sashal@kernel.org>
 <as3drCZLoTUPS_oC@XiangdeMacBook-Pro.local>
 <2026101352-subtract-deflector-a77b@gregkh>
 <as3o3Q8X-2gK2HyF@XiangdeMacBook-Pro.local>
 <2026101340-upcountry-wildland-6ebf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026101340-upcountry-wildland-6ebf@gregkh>

On Tue, Oct 13, 2026 at 12:37:56PM +0200, Greg KH wrote:
> On Tue, Oct 13, 2026 at 10:16:29AM +0200, Gao Xiang wrote:
> > Hi Greg,
> > 
> > On Tue, Oct 13, 2026 at 09:59:58AM +0200, Greg KH wrote:
> > > On Tue, Oct 13, 2026 at 09:28:44AM +0200, Gao Xiang wrote:
> > > > Hi Sasha,
> > > > 
> > > > I'm not sure why we need to backport this into stable kernels, as there
> > > > are users who use EROFS over fscache on these stable kernels.
> > > > 
> > > > The functionality works and it's a breaking change.  Could you please
> > > > kindly tell why?
> > > 
> > > Why would you have a breaking change in Linus's tree?  We never break
> > > existing users, so how was this ever accepted in mainline?
> > 
> > Because the similar + better functionality "erofs over fanotify" is
> > already available in the recent upstream, and it has simpler interfaces
> > than "erofs over fscache.", so we don't actually break users as long
> > as one of those functionalities exist ("erofs over fanotify" or
> > "erofs over fscache".  Many stable kernels don't support "erofs over
> > fsnotify", so backport this commit will make existing users using
> > old stable kernels have no choice (no "erofs over fanotify" nor
> > "erofs over fscache").
> > 
> > The commit message is already described well I think. 
> > 
> > > 
> > > As this removal fixes known bugs, isn't that a good thing for those
> > > older users as well?  Why would you want them to run broken systems?
> > 
> > I think it depends on the importance of the bug, at least "erofs over
> > fscache" is usable (and it's used by vendors) on stable kernels, but
> > it's unneeded to address every edge case found by LLMs since I mostly
> > think it doesn't impact the real use case, and as I said, we have
> > a new unique interface ("erofs over fanotify") now, but only on very
> > latest kernels.
> > 
> > Also there could always be breaking changes for various reasons (e.g.
> > obsolete/dispute filesystem breaking changes these years like
> > bcachefs, etc), will these commits be backported to all stable kernels
> > too?
> 
> Sometimes, yes they are.
> 
> But this makes sense, I'll go drop this patch now, thanks.

Thanks, Greg.  As I said, "erofs over fscache" is still used by
Xiaomi on old stable kernels for example:
https://lore.kernel.org/all/20260923084823.496741-1-hwenwur@gmail.com

But we prefer to use fanotify in recent kernels and it has
a simpler and unique interface than the old one.

There is no need to leave two same functionality features within
the same codebase, so we deprecated fscache two years ago, and
removed it months before so that we could sunset the old
interface over time.

I think another similar example is XFS v4 format, The kconfig says
that it will be removed in 2030 as well:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/xfs/Kconfig?h=v7.2#n51

Thanks,
Gao Xiang

> 
> greg k-h
> 
