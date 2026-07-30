Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B0F448B99;
	Thu, 30 Jul 2026 17:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785434395; cv=none; b=joAJH7b5wgBos8PhPIKpdEyXt1Pc5oDd2vvsVbWJtRurv+nOnIkldpcS39bYzoaVQoBvJgw9C0I8KWcsFiVW5IGk2hzw/MZWR+7Jl6qdJovo2VloJJ/Auj/E6CrmBLbimjUDOOrW9YY6sAjHi+WPYkJOTsMSz1ft8ocQMxtW4lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785434395; c=relaxed/simple;
	bh=OOgJ48JRxMdktncZONk8v+GiWtu/r5iK09h3e4g98SM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ZGh+8lUinsPa1G86C01dhcxsHERX1SIeV5uAk1EJIKDZzaejWorLMfA60f8tyiJK/rpTuI4QyYserljveU8kKfjIxB20ecnT8PwAGYtw75EhDaDmj9aJASD61G/QEhkOu6s9A3Pvsze7u/HwvTq+w64bbwdGbeagkEMLIlACyb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UshECIue; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UshECIue"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ACE51F000E9;
	Thu, 30 Jul 2026 17:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1785434393;
	bh=YZrCgdyXy0gel21g6+l3wAl91/gQK/6PxbGO/1UYQNI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UshECIueGJWRMP+SZQFVcW0KEfohxvJ8oK09e7hIWV+2DIe4dmG2UVxZALb6bPcT5
	 0U1hW+6R6guYUtI0aiN5wXC8mVznh7PRZkBVADUy807+Y/d5CepvjAv+YyE6B+dn2q
	 66ns3oQYRRGuNTh6RCVt577rqxUpB9uVhkPVSXhs=
Date: Thu, 30 Jul 2026 10:59:52 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Hao Jia <jiahao.kernel@gmail.com>, tj@kernel.org, hannes@cmpxchg.org,
 shakeel.butt@linux.dev, mhocko@kernel.org, mkoutny@suse.com,
 nphamcs@gmail.com, chengming.zhou@linux.dev, muchun.song@linux.dev,
 roman.gushchin@linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, Hao Jia <jiahao1@lixiang.com>,
 stable@vger.kernel.org
Subject: Re: [PATCH v3 1/2] mm/zswap: Fix global shrinker when memory cgroup
 is disabled
Message-Id: <20260730105952.7878a648c43c32b5e649d96d@linux-foundation.org>
In-Reply-To: <CAO9r8zMPxdn=MOFD9mbrzed+C9HhOB5DpHG4QS0OJzqV_gLvsQ@mail.gmail.com>
References: <20260729084206.77793-1-jiahao.kernel@gmail.com>
	<20260729084206.77793-2-jiahao.kernel@gmail.com>
	<20260729155858.c7aabff48166a9bca4d68ac3@linux-foundation.org>
	<CAO9r8zNhBCghP8T_98z2p==Cfs_=kamcRN_3ROxaj3R8PN2Qvw@mail.gmail.com>
	<20260729181756.a37e0cc7ea3f6013959d1d25@linux-foundation.org>
	<CAO9r8zMPxdn=MOFD9mbrzed+C9HhOB5DpHG4QS0OJzqV_gLvsQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 09:52:38 -0700 Yosry Ahmed <yosry@kernel.org> wrote:

> > > >
> > > > How does this affect users?  What behavior do they observe when it
> > > > occurs?
> > >
> > > I think the first paragraph sums it up pretty well, especially the
> > > last sentence "hotter pages with higher fault latency".
> >
> > How do users observe that?
> >
> > See, what I'm looking for here is an explanation for why we're
> > proposing a backport.  How are our users harmed by the current code and
> > how does this change benefit them?
> 
> It's a potential performance regression when using zswap with memcg
> disabled. Sorry I just realized you were looking for a high level
> description not detailed symptoms :)

Are we able to guess how significant this is?  It should have
significant impact to justify a backport.

Sorry to push - I'm forever trying to train people to describe the
userspace-visible effects so we can make these backporting decisions!

And to justify those decisions to -stable maintainers

And so that someone who is experiencing a slowdown in some private
kernel branch can look at the changelog and decide whether this might
fix it for them.

