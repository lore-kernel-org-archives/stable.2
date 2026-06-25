Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C18D243376;
	Thu, 25 Jun 2026 18:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782412697; cv=none; b=CLkI8QOrmk1GA4BTvzD0pV+pN8tL+xGT4bFUjupITbdBURGMUslJsHHcRTNpbDCGrYPZxC+fwLNUkfuCH1uGNT6qZaXZoDqk81Mu863lMw/xr82fKH5cr/sIMjynJbEzIEHRGlta78ePDU4dCcHJ0InJSNWWKVyxqqTij5fBc8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782412697; c=relaxed/simple;
	bh=EKvZxNyj99hDQmzLZk0Z1GtHlEhw8OB4cN2Ps4OkSpE=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=H5a+7jC8ow7mytvLPKd6jVBhGSFfgEThYQHlIwUujI6r1e00xr4saCEmG30OmeTjtG2wlZBjOvQgs8kzozqTNfedF+zj0J4MJfAblNrShgv7DCYR3g8Hn63wXb6j9+WeQm/Nuiwcdre/P3F8gOOAKU9P2J5DTfCKgjn4wNraevM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tLwaJIGd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tLwaJIGd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B15B1F000E9;
	Thu, 25 Jun 2026 18:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1782412695;
	bh=xHuTG/PvzMnxTSampUx+792v7zbUVHG83vmebKN74Wc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=tLwaJIGdu3vCcT7gq1t7pAtyOv9iJyUSpnLOVACdnNzPSBY03B+S6+64qmCX/b4au
	 ENS8DYoxuKdxluVxTywKyaJuW+Y80UXDHRfGHTSaR8owcHUhT8lLZZbHnj5RDwZEne
	 OHCWVsaJj20SOiJNx20LeC1ToR707vXDQd+udOdk=
Date: Thu, 25 Jun 2026 11:38:14 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Petr Mladek <pmladek@suse.com>
Cc: Bradley Morgan <include@grrlz.net>, Feng Tang
 <feng.tang@linux.alibaba.com>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>, Mukesh Kumar Chaurasiya
 <mchauras@linux.ibm.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Jinchao Wang
 <wangjinchao600@gmail.com>, Kees Cook <kees@kernel.org>, Rio
 <rioo.tsukatsukii@gmail.com>, Joel Granados <joel.granados@kernel.org>,
 Pnina Feder <pnina.feder@mobileye.com>, Petr Pavlu <petr.pavlu@suse.com>,
 Sergey Senozhatsky <senozhatsky@chromium.org>, Douglas Anderson
 <dianders@chromium.org>, Mayank Rungta <mrungta@google.com>, Tejun Heo
 <tj@kernel.org>, Zhenguo Yao <yaozhenguo1@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Michal Hocko <mhocko@suse.cz>, Miroslav Benes
 <mbenes@suse.cz>, Jiri Kosina <jkosina@suse.cz>
Subject: Re: Fixed tag magic: was: Re: [PATCH v2 1/4] sys_info: add helper
 for callers that handle all_bt
Message-Id: <20260625113814.9372b8a78b374560393fd879@linux-foundation.org>
In-Reply-To: <aj1Jh57McGH94gGY@pathway.suse.cz>
References: <9b8c96e291696815d3c7de5d3e199298dee0279d.1782228656.git.include@grrlz.net>
	<20260624133419.a2d566f50c44ee2d4e0fb395@linux-foundation.org>
	<aj1Jh57McGH94gGY@pathway.suse.cz>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Jun 2026 17:30:15 +0200 Petr Mladek <pmladek@suse.com> wrote:

> On Wed 2026-06-24 13:34:19, Andrew Morton wrote:
> > On Tue, 23 Jun 2026 15:34:58 +0000 Bradley Morgan <include@grrlz.net> wrote:
> > 
> > > Some callers handle SYS_INFO_ALL_BT themselves before calling sys_info().
> > > Add a helper that strips that bit without turning an all_bt only mask into
> > > a kernel_sys_info fallback.
> > 
> > I assume this patch wants a Fixes: and a cc:stable also.
> > 
> > It would be nice to have the conventional [0/N] cover letter to tell
> > readers what this is all about.
> > 
> > The patches all have different Fixes: targets.  This risks inviting the
> > -stable maintainers to merge only some of the patches into some
> > kernels, resulting in an untested combination and which might break
> > things.
> 
> I do not agree here. The Fixes tag should should point to a commit
> which introduced the regression into the given code. And finding
> some magic common point beause there is some magic undocumented
> process for maintaining stable kernels sounds like a way to hell
> to me.

Well, as said, this potentially asks -stable maintainers to cherrypick
individual patches from this series into various kernel versions. 
Potentially resulting in code combinations which nobody has tested. 
Heck, the individual patches may not even compile.

If we're to add the series to mainline as a single atomic lump then we
should add it to -stable as a single atomic lump, as that's the only
thing which has been tested.  To communicate this to -stable
maintainers we can choose a Fixes: target to which the series can be
added as a single atomic lump.

Of course, we could always discuss this with -stable maintainers ;)
