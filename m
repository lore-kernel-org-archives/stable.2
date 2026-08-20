Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6435833A711
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787234415; cv=none; b=VW0UiO6nD+Gi9t7WNS6KPpm4vAYiVTOKVi2xxgzv9GUKjoCHWnc2w2ZRnvrQ9wNgAws3iOb+MStuTykyzgl4rvCYCTLafWIldyl1SGZjkN0fc+O0jivMWfH6FDH+ZIEKbJlbsVCaAmBqCTjrTnkYKVLwXQF4bPeWA9Tr9GjmUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787234415; c=relaxed/simple;
	bh=E+zF8fmPDb1uSfCUIcFVLD38dzzKps+5xmdXajrv6fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIjDEMRCzyyuQcFhFVv1s3kruh5IfnHrMIJ0vFNDG7eX5u2j3WGliObt7aa15I+wi+fjiLSOaQW8BKtYLG+MY88fA393st82vALrz/5rtcOoMjGBPkwzRXw7Zjkg7sop9LrUHGNkia0TIlLYBqoUBzhVUAG/jAHX9rIEIJyuzec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ie/PHuYb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ie/PHuYb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2921F00A3A;
	Thu, 20 Aug 2026 14:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787234414;
	bh=9K4JPu3uuLUS70xIi164iWoNx7vKp8xC+clydQnLcFE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ie/PHuYbAd1MpwneBFBFrpxWt8hO4BtYbKkL9n8GdZly7c6uqKDmgZmbioTBEPyxt
	 hs/lUtKgrivFbmLp8Ik5+Ed2eTZt9UqiZ5GiQnult4+ZfGU6P/c+AB4tup7OqDe695
	 L3S/JARYSK1OgtSTAvm5t5985EGDdp5euMyQ0Ulk=
Date: Thu, 20 Aug 2026 15:46:04 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	vegard.nossum@oracle.com
Subject: Re: Question: Why don't I see FAILED patch notifications for commit:
 622ebfac01ba4f9c0
Message-ID: <2026082055-outgrow-attractor-a60e@gregkh>
References: <5b4ec416-804a-4bd6-aa12-5c317741977c@oracle.com>
 <2026081210-lugged-bleep-94ba@gregkh>
 <7b89b098-61cc-4788-b7b6-69bd232f770d@oracle.com>
 <075a8087-1cf7-4b45-98c5-6a4c717549b8@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <075a8087-1cf7-4b45-98c5-6a4c717549b8@oracle.com>

On Wed, Aug 12, 2026 at 05:16:47PM +0530, Harshit Mogalapalli wrote:
> Hi Greg/Sasha,
> 
> ...
> > > > So I am wondering why FAILED patch notifications are not seen on
> > > > stable@vger.kernel.org.
> > > > 
> > > > https://lore.kernel.org/all/?
> > > > q=KVM%3A+nVMX%3A+Hide+shadow+VMCS+right+after+VMCLEAR
> > > 
> > > Because it is in a bunch of released kernels already:
> > >     6.6.148 6.12.101 6.18.42 7.1.6
> > > And queued up for the next 6.1, 5.15, and 5.10 releases, it's in the
> > > queue.
> > > 
> > 
> > Very sorry about this.
> > 
> > I made two mistakes here:
> > 1. I should have specified I was looking for 5.10.y and 5.15.y, 6.1.y
> > 2. I should have checked stable-queues.
> > 
> > Source of my confusion was it got applied to 6.6.y+ kernels on August
> > 03, 2026. And we had a stable kernel release for 5.15.y -> 5.15.214 on
> > August 06, 2026. But I just realized that we can have few urgent fixes
> > queued up and released faster.
> > 
> > thanks a lot for explaining. Will be cautious next time.
> > 
> 
> I checked a few more cases for eg:5.15.y:
> 
> eg:
> 1. commit: 7258770e5814 ("KVM: arm64: vgic: Handle race between interrupt
> affinity change and LPI disabling")
> 
> the broken commit is:
>   rev              : 5dd4b924e390af426e424d5e52c1b4d1566af817
>   subject          : KVM: arm/arm64: vgic: Add refcounting for IRQs
> 
> In Branches:
>   mainline             : v4.8-rc1 - 5dd4b924e390 KVM: arm/arm64: vgic: Add
> refcounting for IRQs
> 
> so fixes tag(broken commit) in upstream commmit(fix) is in stable-5.15.y.
> 
> Don't see FAILED patch for this commit: 7258770e5814 ("KVM: arm64: vgic:
> Handle race between interrupt affinity change and LPI disabling") or
> stable-queue patch.
> 
> Was searching for FAILED patch like this:
> https://lore.kernel.org/stable/?q=7258770e5814f15e8308ebda82ac9acf6964ba8e

No idea.  We added it, and then dropped it for some reason.  Dig in the
stable-queue.git to find out why?

If you think it needs to come back, please submit it for inclusion and
 cc: everyone on the patch, maybe someone will remember why we dropped
it?

> 2. commit: b240f792ae02 ("drm/amdkfd: free MQD managers on DQM init
> failures") fixes Fixes: b7cccc8286bb ("drm/amdkfd: fix a memory leak in
> device_queue_manager_init()")
> 
> 
> Commit Data:
>   rev              : b7cccc8286bb9919a0952c812872da1dcfe9d390
>   subject          : drm/amdkfd: fix a memory leak in
> device_queue_manager_init()
>   stable patch-id  : b77e273174d23e67b63515c660e3bff7d5d133ea
> 
> In Branches:
>   mainline        : v7.0-rc1          - b7cccc8286bb drm/amdkfd: fix a
> memory leak in device_queue_manager_init()
>   stable-5.15     : v5.15.199         - e11e8a29b304 drm/amdkfd: fix a
> memory leak in device_queue_manager_init()

Look at that 5.15 commit, it shows it is commit 80614c509810
("drm/amdkfd: fix a memory leak in device_queue_manager_init()"), NOT
commit b7cccc8286bb ("drm/amdkfd: fix a memory leak in
device_queue_manager_init()").

Yes, the DRM tree sucks rocks, and is totally broken, and they get to
keep the pieces because of their "we will cherry-pick patches BACKWARDS
IN TIME" policy.  They know this will cause things to get lost, and are
somehow ok with it.  That's on them, not us, sorry.

We keep "talking" about this every 6 months or so, came up again
yesterday on the ksummit-discuss list.  They know it, it's up to them to
change to make any of this work if they actually want it to.  So far
they seem to think that DRM users only use the latest stable kernel
release, which frankly, I happen to like as that's what I think should
be done too :)


thanks,

greg k-h
