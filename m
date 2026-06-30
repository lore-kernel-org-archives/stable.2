Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5B3243367;
	Tue, 30 Jun 2026 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782851443; cv=none; b=f804gMt49hsQY8k2JarUkH6NcLzQR0RqN7hsnNkBTc5Gi/4+46DnOJisCgWRSCp4jN8dTiFRD9gAUOiu4I4d8NPmZmwQ2L5gQAeHDXf4JUMy/2hGvO1pJuvqa4OPPd9KddPMjnxpzLXTswjAn14ZE5xojmYqRmOh1WDza0TGXrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782851443; c=relaxed/simple;
	bh=N7YxzN8QAHzOTRjrqPBYvPuAQvgxClHSYHdMXxAXvDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4dSP0Vua/WTOKPwtoxgdWZDlrTgeLpwPS7SMciVhMwrB0rEbtZLGoibX22ODaLMyC33QZ3zK2u2G5KSB7Ydnim8BgF63hmDa+G/2m241aNbEH5fVXqCNh2cixK9NIpO3PQuP4jqiZPBo3PjrNTRHDeU32SvXqJ3XcYNqut9YfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=G0pLmH91; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cDYSWU8y; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="G0pLmH91";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cDYSWU8y"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 066D41D000D1;
	Tue, 30 Jun 2026 16:30:41 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 30 Jun 2026 16:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1782851440;
	 x=1782937840; bh=bEmKaF/mWTazaoAG0lVKHqHXydq3O35JbDhcIvj/Y1s=; b=
	G0pLmH91luv2LfAlEWCtnvwi45rkQSIgdfT6ZhTeYKxAnXajUFk59Y24CpB4J/bM
	glbkvD4tlpIWJvDZr60rHHZk9Lj/VSOl1k+7uPtCi8rYf2lghk4MN/Ot+/dm8wie
	QhFop1GJiemTG6Je0miK8meBiCCJhzeMw1YGB/9CKsTfy1V+CRP2zTBi4L6vlI4M
	Q8zTXf+O1rB2HT40n68vP86NxHQnaAMG1/3AhUNqfDEo48XxGFKQnMC6sLdgoH/x
	9gIg/SYdWAOOGwEGDY0QdZIzCWdcBl+uLDONMxGwRc9TD70uuy/n+uWqKLaJ28hL
	ZcWUnBoNgivBoazjWuyn1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1782851440; x=
	1782937840; bh=bEmKaF/mWTazaoAG0lVKHqHXydq3O35JbDhcIvj/Y1s=; b=c
	DYSWU8ylgh0WuKDRtcGLwn6Gjyz2ta8z/toNHaPa82aM+tp6KMm8L5hNXB1wGRk7
	Uv2jelfKrAfuZ4RYFIOh/qP5O6p25l+/+NcQlyYzUhoiFylAT3Prt7LoRRLli4gE
	6bEgrByGgji1MGInAJlSbCg8ocRJDyoKGXjGQA31T/xOP5PDk+c+rEUwwwtFRt6w
	NfmBvyl/oTJRWDJYoBmeFiJocFAduNPZy8kwgXCQR0FdJuRMvZo9y2ui75nsFSLm
	1EVFH0TT3qOJgmfh7MSe8ZM0aygPXmgpr1J48qbie7FIZZc4CwHRHC8i1EnbWjQf
	NI0DIrwnWe0pdBRPFH6LQ==
X-ME-Sender: <xms:cCdEalWOd6gI8vOdY_eHTEW9nEGtRKIHJSUoMUvRec6gv139Z7i74A>
    <xme:cCdEagthl1WpGRxVFFhRjzNQyab9PIlfSvXSeHDS8V5keQBh3rrVQgMuW21RL1qAR
    LcKqx0Wj0a0wzByuCEctVfgYl9-fbQ5JMRPOfoizhyIFg-s_E4>
X-ME-Received: <xmr:cCdEanzadQWwTMxECXj7qLzVCpeZOIxOzh3dBeqIUnPH_8jIio4o2oJ0QYKuOZvqOCwckUcBHf-ptcRnmuad5aUotw>
X-ME-Proxy-Cause: dmFkZTFPbMYa3UrMstpQ+++z9Rr80bW5m1jbp1QicDpHjIwx+Hg/aNNrh2+4yTfzLL1K2x
    q6A4F9nBbVpBDrsTcObfnTsvxrypUaqvHokBp4l2nwVlXv+sj55LtObgqgh/y3ECIk7uUf
    w3fZ0h5RiXj6eyyZghkgz04VRntP82R1I5BTQNyObqE9ra/3BlPcUGKFrFzmHQ0/s1e+eB
    HkuEno4uYofyqpiIo1in0bk+eawNcNaI76TWa8mtHFVM+hGfU3CeVkf/JIhYSXcYyw4M0L
    XpsVgq4Itd3i80hDKH9VZvnWtTttJCBcXyAKmbAkdQ+pTi4ojWYxJ1CmMaSZ12un22yrMQ
    4pd9MMPaBHE1xOIpe/GRRQCahRPLnC0P/La7/QtzTpvzlNFrZsY6tFS3XSyasBzdvWeOtR
    R3AYPJ6vObsMFXiIEKxmSgvnzjzx1absUYpiobe91WWWvC8qlr5pW0BZE9iTqSrxvFBTk8
    A8QYQzROyb2OtNaPF4aMmoR2tW+lROdnljI+AtK52l2EfTWwKuQ8JM5OSLwd/dj84ihy29
    uL76uP5n84NtCcwOI2el3ZZ2aQDkDzSU7lGhCQqRiteCMZ9oIZciCAzRlnxOWd3UruGrSp
    74bCMYO90EPIXQjuMZb2xscogC0IntbOdInaRV8RX66ntb8T3dRSgOXDvnkw
X-ME-Proxy: <xmx:cCdEajRfXGppUa_e07ysJrmbyREQ1oMkOfuC0n0juNG57Xj8HW2JKQ>
    <xmx:cCdEah92ffa790esdKPdesa4Us9qGScvgeX6s0nLlLaF2D1Ts9UNIQ>
    <xmx:cCdEahZzIgeQ4siJCV0UkRRtXs0ugl-j7zw1pXtzwHQV6iVJNbjWyw>
    <xmx:cCdEaipilOOfsOSMFvcfe1YakMcswhi-Jrez0_w1nt0hxaikRwhsig>
    <xmx:cCdEaoieTlYX9habJUq2HxbmUPkfQM4YbwP1wcMExVdsSxqJfyEpfmH4>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 Jun 2026 16:30:39 -0400 (EDT)
Date: Tue, 30 Jun 2026 22:29:25 +0200
From: Greg KH <greg@kroah.com>
To: Ujjal Roy <royujjal@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>, Andy Roulin <aroulin@nvidia.com>,
	Yong Wang <yongwang@nvidia.com>, Petr Machata <petrm@nvidia.com>,
	stable@vger.kernel.org, Ujjal Roy <ujjal@alumnux.com>,
	bridge@lists.linux.dev, Kernel <netdev@vger.kernel.org>,
	Kernel <linux-kernel@vger.kernel.org>,
	linux-kselftest@vger.kernel.org
Subject: Re: Please backport bridge multicast exponential field encoding fix
 series to stable kernels
Message-ID: <2026063019-crummy-mosaic-d9bb@gregkh>
References: <CAE2MWknz4X_gcNo6jkR87Lg8F0zfubkOc4Ujr57CS3aBMWrjEA@mail.gmail.com>
 <20260625054005.0016.bridge-mcast@kernel.org>
 <CAE2MWkn=azz3gUKGBYc1jjvVnLxDHuHk9M7wAJHdAW8v=dP5GA@mail.gmail.com>
 <CAE2MWkkON7HuB+Szc1VhaPL8ZTYMAyfzmPM_7FkXvOPnjnF5rQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE2MWkkON7HuB+Szc1VhaPL8ZTYMAyfzmPM_7FkXvOPnjnF5rQ@mail.gmail.com>

On Wed, Jul 01, 2026 at 01:33:07AM +0530, Ujjal Roy wrote:
> On Thu, Jun 25, 2026 at 8:20 PM Ujjal Roy <royujjal@gmail.com> wrote:
> >
> > On Thu, Jun 25, 2026 at 4:12 PM Sasha Levin <sashal@kernel.org> wrote:
> > >
> > > > Please backport the 5-patch bridge multicast exponential field
> > > > encoding series (726fa7da2d8c, 12cfb4ecc471, 95bfd196f0dc,
> > > > e51560f4220a, 529dbe762de0) to the stable kernels.
> > >
> > > I tried, but it doesn't apply to 7.1. Could you provide a backport please?
> > >
> > > --
> > > Thanks,
> > > Sasha
> >
> > I will create patches on top of 7.1. But tell me what about all other
> > stable releases? I have to create patches to all stables and how to
> > share the patches to you? Via this email or any other process? I am a
> > fresh on backporting my changes to all stables.
> 
> I have prepared the patches for stable releases mentioned in kernel.org.
> 
> And I am waiting for your response so that I can send you the patchset.

Please just send the patches :)
