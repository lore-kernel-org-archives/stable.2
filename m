Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B5C486652;
	Wed, 23 Sep 2026 10:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790159247; cv=none; b=e5BZAsygmFn+IQQ9XEktmsMQoUn0APdGGKk9254H1L15rnpgU27Y7sVK+1MIO3+XHLd5/WEU3T2KiKZV4hpMxl2NgU2YpmCYgi+H500sodHUMKySDk1LusMFPAb7jtYe7TRCxXB1hqdNMFSP99qp3US+8XxuwKlJBwHaP0sfP+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790159247; c=relaxed/simple;
	bh=d1a3ykPm2SH8c/S0Yc8/WqkMJhhbe1AV+59ty3tQXvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gQ6shAdF2/G4PkfEq7Vk4cg6Gm3DWC559qqcwcBll8D73XE0wv00iIYKW+S9yVJXAldF35nAmK0qzcrSRxjF4xckXkGzSY8YB5ANesEaNQoDID40oOQvkII1jJnnMx7QSYz/O6G/VEbQpN9agn0WItdM94nCfum0GYa+UEMyhQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XIB7Doa+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XIB7Doa+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D694F1F00893;
	Wed, 23 Sep 2026 10:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790159240;
	bh=S0UoGo5RIXnxCHfbdyXmcN3aVllbaZujcbAt4rQ8mN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XIB7Doa+d3L+zgYSQtMRIs6DomR3JCBE8JaDbgzSM1AWjN2Am84hYlGY6R93YtT6x
	 oZWw0HoIPX2iSBO8/ZG0djPtog+83HMlLkwx/QZR8tNo4rh/3ai0wXTod6B7fQfBxu
	 cghJvGDPkEfC9FhC9bWraqCwxQk2D6/5TG0lV9pE=
Date: Wed, 23 Sep 2026 12:27:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kusuma DS <kusuma.ds@alkira.net>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org,
	Chakradhar Kar <chakradhar.kar@alkira.net>,
	Ramakanth Gunuganti <ramakanth@alkira.net>,
	Sripathy Ramaswamy <sripathy@alkira.net>,
	steffen.klassert@secunet.com, sashal@kernel.org,
	dongchenchen2@huawei.com
Subject: Re: [6.12.y] Please backport 8045c0df98d4 ("xfrm: Fix dev
 use-after-free in xfrm async resumption")
Message-ID: <2026092338-almighty-cherisher-74e8@gregkh>
References: <CAMcJb7NLooAw=6Vyzbq-7JnE9L=gfTbLL0Y=L1pTFMTg3Vf76A@mail.gmail.com>
 <2026092316-mouse-scallion-6eb2@gregkh>
 <CAMcJb7OPfN3jSmaqW14CqBESDv=m7Lc+CQ9hms6kVKMWoeHfCw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMcJb7OPfN3jSmaqW14CqBESDv=m7Lc+CQ9hms6kVKMWoeHfCw@mail.gmail.com>

On Wed, Sep 23, 2026 at 03:26:31PM +0530, Kusuma DS wrote:
> Hi Greg,
> 
> Thanks for replying.
> 
> You're right - I had not checked whether it applies cleanly, I only saw the
> change was small. My mistake.
> 
> Is anything planned for bringing this into 6.12.y, or does it need a tested
> backport first?

As I stated (which is the problem with top-posting):

> > Please send a working and tested version if
> > you wish to have this applied.

thanks,

greg k-h
