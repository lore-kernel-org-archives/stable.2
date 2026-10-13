Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D64E3D300D;
	Tue, 13 Oct 2026 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791879398; cv=none; b=JzGPhVGNTRXwgMH3anXsySEucaATchKoynOi8M0j6o/wbqVIjsGJUdFEJ/i9oemowssF1QR0x9UAgmrjMqIebrphqfCtU0NE6FyBvdSaCjEhv+pQEtmo6KY+StyBGn91i1E+0SVsJ9JsYZvCiYsqlCW4gdTPEg4DZUqf5vxSLhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791879398; c=relaxed/simple;
	bh=PzQ9rTXT4HT9wr3b69GLODLts5MwtAQNcF0m3Ns2vxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ex/5cQR8Sekx86fs9RlsLyZF6Cn6Ewa9+rhklQyYL0TcHdfPAV5OUvAtPJm7mrTJeKqzVwfwOa8lHd88N5TSvBF62s8gm9aKmiaEUF+yPuDUrq3jXOxMk/LvQHnpsgatcMXlKk3XdVN6P+rxM4G+RfA5b1JFP6I1ymSqDfrkiko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AqDbgD7R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AqDbgD7R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69301F000FF;
	Tue, 13 Oct 2026 08:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791879396;
	bh=10xqpOPjo9d02qrdR+y1QjD6wm0apoWOTLYxCcvp86U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AqDbgD7RPDZnA8yWlYoCzTaFRLOEfIfXzuIMKlCL0epBr0Q3gbAfflTnYwIztLzRJ
	 1GIASb+SV5fm+Wt6MXY0BlSjWTWYgCjYU6cR5YuG0eJyHI69gxSY70lyorCsP211Xx
	 4ut57CQ/1zfAAnpUaD51OQclSZdWPg5JoTu35UR5W2wJc6escRvVEKOJwduD/6jILN
	 ldUfK5O6TW3PM6fj3iL/ZkdIjm31vtT9H7502xcv3vCGKHJihsf9p7e1XMCwMX8bJh
	 ide58ONFM3JIvdrsvoZbUry/Ff2H9kJrzppM1DZBNC88QSLZfn4gGrjOW0TL1fDahr
	 PuPREpWrFOp7Q==
Date: Tue, 13 Oct 2026 10:16:29 +0200
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
Message-ID: <as3o3Q8X-2gK2HyF@XiangdeMacBook-Pro.local>
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
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2026101352-subtract-deflector-a77b@gregkh>

Hi Greg,

On Tue, Oct 13, 2026 at 09:59:58AM +0200, Greg KH wrote:
> On Tue, Oct 13, 2026 at 09:28:44AM +0200, Gao Xiang wrote:
> > Hi Sasha,
> > 
> > I'm not sure why we need to backport this into stable kernels, as there
> > are users who use EROFS over fscache on these stable kernels.
> > 
> > The functionality works and it's a breaking change.  Could you please
> > kindly tell why?
> 
> Why would you have a breaking change in Linus's tree?  We never break
> existing users, so how was this ever accepted in mainline?

Because the similar + better functionality "erofs over fanotify" is
already available in the recent upstream, and it has simpler interfaces
than "erofs over fscache.", so we don't actually break users as long
as one of those functionalities exist ("erofs over fanotify" or
"erofs over fscache".  Many stable kernels don't support "erofs over
fsnotify", so backport this commit will make existing users using
old stable kernels have no choice (no "erofs over fanotify" nor
"erofs over fscache").

The commit message is already described well I think. 

> 
> As this removal fixes known bugs, isn't that a good thing for those
> older users as well?  Why would you want them to run broken systems?

I think it depends on the importance of the bug, at least "erofs over
fscache" is usable (and it's used by vendors) on stable kernels, but
it's unneeded to address every edge case found by LLMs since I mostly
think it doesn't impact the real use case, and as I said, we have
a new unique interface ("erofs over fanotify") now, but only on very
latest kernels.

Also there could always be breaking changes for various reasons (e.g.
obsolete/dispute filesystem breaking changes these years like
bcachefs, etc), will these commits be backported to all stable kernels
too?

Thanks,
Gao Xiang


>
> thanks,
> 
> greg k-h
> 
