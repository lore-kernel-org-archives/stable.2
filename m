Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487822F12A1
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 10:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787826741; cv=none; b=bxd2UO24IAmijKs55emH5Z3T4neySCYhrCig9+9Q07HvQo4nQDeju7+stBVMhF0SeMVaTW9y1Cy6z6K3I8XPsNe8rJ5PLsKm2yxVTYZPTYs7MVQHI008pJGC2MaULj3jmibe1KHn/rJ1ga2wc3FNfKsh2eLUUq/rl2ST4ybqh9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787826741; c=relaxed/simple;
	bh=fwZHIwSplveFSmQWr3koH9DnipJjFLr+RqhkrFfdFlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RqJ3NVmnGr/SmN150xUMITMXaE2xufoR9ULPIFE/yTXq5N21wiBjzVQSJluFP6KLYKEE/fv/6tIjQkQ9ehvxhxPuu3mYgk1EtK0O87kS/RuoFvieQwJQO9+Mb7T+8ghy4YkT+4maFXUX6Eyz+jDVwJPOhCIFVOZubVcQzIgiIHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WeaIItxv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WeaIItxv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5C191F000E9;
	Thu, 27 Aug 2026 10:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787826736;
	bh=eK2ZSuM0fyItyCEGONTFd3/lC9MP0EMjSORxr/2uVH8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WeaIItxvX/DasLmsew4cf7UD3P09I8vZsV6qpJvOfk82yglD9s4AgJshWXlX34m3m
	 ZebL2RWu1o7SVQ1Nqc17iIePAqtPY48B15urmGD0VWEcjOYmJR5dt7TMVYKGcsryKF
	 taaRZpvv3AuO2Fz8ttn+CEIumgTYEQ8gvkUjQt6s=
Date: Thu, 27 Aug 2026 12:32:14 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Wentao Guan <guanwentao@uniontech.com>
Cc: hexlabsecurity@proton.me, paul@paul-moore.com, sashal@kernel.org,
	stable@vger.kernel.org, stephen.smalley.work@gmail.com
Subject: Re: [PATCH 6.18.47-rc1 01/10] Revert "selinux: require a class's
 permission values to cover its permission count"
Message-ID: <2026082752-aviator-isolating-5239@gregkh>
References: <2026082735-footbath-absolute-3048@gregkh>
 <20260827093227.4050399-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827093227.4050399-1-guanwentao@uniontech.com>

On Thu, Aug 27, 2026 at 05:32:27PM +0800, Wentao Guan wrote:
> > On Thu, Aug 27, 2026 at 05:07:59PM +0800, Wentao Guan wrote:
> > > Sorry for prev email title is garbaged...
> > > 
> > > > Why?  And this is not a real git id in the linux-stable tree.
> > > in stable-rc git tree.
> > > 
> > > > 
> > > > Do you want me to just drop all of the selinux patches from the 6.18.y
> > > > queue right now before I do the release?  I'll be glad to do so, but I
> > > > need to know why.
> > > 
> > > fair,
> > > 
> > > What happened in my side is Github Copliot review point out the issue:
> > > "This validation runs after symtab_insert(), so the table already owns key
> > > and perdatum. On an out-of-range value, the bad path frees both while leaving
> > > dangling pointers in the hash table, and rc is still 0, so malformed policy
> > > data is accepted and later accesses can use freed memory.
> > > Validate the value before inserting it and return -EINVAL."
> > 
> > I have no idea what that means at all as I can't parse LLM output well.
> > 
> > > In continues review, there LLM point out the mainline don`t had the issuse,
> > > for correct sequence is that git log --oneline
> > > (v6.18.46-1) selinux: require a class's permission values to cover its permission count
> > > selinux: reject a class permission count below its inherited common
> > > selinux: reject a permission value exceeding the class permission count
> > > selinux: more strict policy parsing
> > > selinux: use u16 for security classes
> > > Revert "selinux: reject a class permission count below its inherited common"
> > > Revert "selinux: reject a permission value exceeding the class permission count"
> > > (tag: v6.18.46, stable-gh/linux-6.18.y) Linux 6.18.46
> > > 
> > > This instead of Sasha`s series:
> > > 2026-08-24 22:00 ` [PATCH 6.18.y 1/3] selinux: use u16 for security classes Sasha Levin
> > > 2026-08-24 22:00   ` [PATCH 6.18.y 2/3] selinux: more strict policy parsing Sasha Levin
> > > 2026-08-24 22:00   ` [PATCH 6.18.y 3/3] selinux: require a class's permission values to cover its permission count Sasha Levin
> > 
> > Ok, I'll drop these for now, and wait for your backports.
> > 
> > But note, I'll drop this for 6.18 and older, so I need backports for ALL
> > of those branches.
> 
> for 6.18.y:
> 1. https://lore.kernel.org/stable/20260825100338.4039846-1-guanwentao@uniontech.com/
> 2 .https://lore.kernel.org/stable/20260825100338.4039846-2-guanwentao@uniontech.com/
> 3 .https://lore.kernel.org/stable/20260825100338.4039846-3-guanwentao@uniontech.com/
> 4 .https://lore.kernel.org/stable/20260825100338.4039846-4-guanwentao@uniontech.com/
> 5 .https://lore.kernel.org/stable/20260825100338.4039846-5-guanwentao@uniontech.com/
> 6 .https://lore.kernel.org/stable/20260825100338.4039846-6-guanwentao@uniontech.com/
> 7 .https://lore.kernel.org/stable/20260825100338.4039846-7-guanwentao@uniontech.com/
> 
> for 7.1.y:
> 1. https://lore.kernel.org/stable/20260827054709.4027356-1-guanwentao@uniontech.com/
> 2. https://lore.kernel.org/stable/20260827054709.4027356-1-guanwentao@uniontech.com/
> 3. https://lore.kernel.org/stable/20260827054709.4027356-1-guanwentao@uniontech.com/
> 4. https://lore.kernel.org/stable/20260827054709.4027356-1-guanwentao@uniontech.com/
> 5. https://lore.kernel.org/stable/20260827054709.4027356-1-guanwentao@uniontech.com/
> 
> There only different between 6.18.y and 7.1.y are 6.18 revert which applied not
> cleanly:
> 62be2361da29505d3183da854f1c98d2e208e852
> 9f721b5d9e1d956ffe965bc09375989eb51881fd
> and next reapplied in next series cleanly.

Again, I am totally confused.  I'll go drop ALL of the selinux changes
in ALL of the queues and wait for the next round of releases before I
pick up the above ones (and we need that same series for older trees
too.)

thanks,

greg k-h
