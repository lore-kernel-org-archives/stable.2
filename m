Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEA630F534;
	Tue,  2 Jun 2026 16:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418432; cv=none; b=r47KrzP0wd/Ld11+4jJV9mDvp/Gdmswm1zphquAKwS677IMX7495kOccOKvg6FBWMgVrtookbGFHvWtzTuII+63SqoWZvQe8bp7SecBk7kSMjkDr3FLKEydLzgmFhgp13iUcKM9hGo/G0PbjcDP8l+ZJcvP6jN9sn6fcUBpFnJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418432; c=relaxed/simple;
	bh=x70aRejfgX2cxb7w3VGI/xc6d8p5rkt7CL+nKWJwhYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODC7A/bzxKlWSLVdMzr+XnvWHPCwjd9D0p1End8qnhhy6B/ilA+857DBtZ1wAHjyipy4wMhpa1uJCWDDLRruFlGnYMsSMKCeudahf5zYjpPrbUv8c6bV+HTOHcP04zYlpsZznnaUG0A26TSVJuOf3TMpEhIWAShvt5LuNxhNVro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eTBoEsQt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eTBoEsQt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0065A1F00893;
	Tue,  2 Jun 2026 16:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780418431;
	bh=pthzjou5VnEIFW943eVQNP4GPV1KatXgvb/b+r7o584=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eTBoEsQtA9V6JRo/CIBU3FRnoj8BHT9aU3GDa3IK7s/a/CRWRlWYlRe2r2+UCyyqj
	 u/UKMgWpIqTUmatsFMPXd+sfvytxSC+cqO9vJwxhbEU6IzqK9x7iRuwof49I0EWZ6b
	 wKoUoirqKGvPyt5odO+flqU9ymrtJ2MVkVa7xhX8=
Date: Tue, 2 Jun 2026 18:39:35 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: rafael@kernel.org, dakr@kernel.org, cornelia.huck@de.ibm.com,
	tom.leiming@gmail.com, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] driver core: enforce device_lock for
 driver_match_device()
Message-ID: <2026060209-virtual-sabotage-bbd1@gregkh>
References: <20260602160829.560904-1-runyu.xiao@seu.edu.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260602160829.560904-1-runyu.xiao@seu.edu.cn>

On Wed, Jun 03, 2026 at 12:08:29AM +0800, Runyu Xiao wrote:
> Currently driver_match_device() is called from three sites. The
> __device_attach_driver() path already runs under device_lock(dev), but
> bind_store() and __driver_attach() can still enter bus match()
> callbacks without that lock held.
> 
> That inconsistency leaves bus-private driver_override readers exposed.
> Several buses still read private driver_override strings from their
> match callbacks while the write side relies on driver_set_override()
> under device_lock(dev). If bind_store() or __driver_attach() reaches
> such a match callback without that lock, it can race with
> driver_override replacement and old-string free.
> 
> This issue was first flagged by our static analysis tool while auditing
> driver_override match paths, then manually confirmed on Linux v6.18.21.

That is very old, please test on the latest 7.1-rc release as things
have changed in this area recently.

thanks,

greg k-h
