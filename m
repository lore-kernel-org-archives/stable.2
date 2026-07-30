Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F29C36F909;
	Thu, 30 Jul 2026 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785445058; cv=none; b=LlnjwgIkxC8JskmQXhJAXTb67F2HCpB3fsBY6B1nXLcipUZDwr7JFFi6hCgll75CKzL9gErf/xMTcWbO+uEPuFUKb6VRwUkoB3RQOjhlxpCwMuhHRZLg2+UQI90rlwQZdTsBEMXCn8NvAiO+pzQX7JRgaJHYvZeXDWw5wBm41jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785445058; c=relaxed/simple;
	bh=9M1BoGClEHtRQjpp7QmSvBAMy0926/5Sb2c+J2JLCEM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HHEtipC3SSD6A/FI+m4QHUlaUuj5KlnKxAyAWHDqhylxtGfy6VxU0rDnVWgmSjnu21jB8oUz5crcSOolbgQpO8SfAW4ZSZrWyTuQqAulzKF59YZlR6cUzHMr1+1EPvowVeNyXioJebtKlFUfY/CIKQq4iZfv/AhkHqq1Hm+f5V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkzbIk8O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkzbIk8O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAF2F1F00A3A;
	Thu, 30 Jul 2026 20:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785445057;
	bh=IX/6o90+8h04SXwvpSu/GbJI8gZhu+oy4pv4k4OllqU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fkzbIk8O+8GdKUV9jGZOmxdZQVjC+uerkISxQhVLif1hCbElX5yOPThIlDIKCxkfX
	 c0BwsQIplHeu/iXXn3gz4KK4G13U0Th1LcHH0s1/yyimMR5o1DcIitP3dNUsYAQh/7
	 SYzTzU4ycyPbaEAsW0eee0PRLPNlJybbDgYo8sAFf5fUX3rfPsdWkj6uDm/YL6zLOX
	 JJFMCoGHbZreyAEsVvfBwTJ5AFHhusGZxp5+qNcU/KFzrnUfXytStc9tZRxFMC0orn
	 kEE3akftVp1qZf/w/D4BFwEr5HXfwJPYlcJOSBhYpwI2gSTBAy+RQQ0gU81LEk8jzw
	 edkewFF10NZSA==
Date: Thu, 30 Jul 2026 13:57:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Laurent Vivier <lvivier@redhat.com>
Cc: linux-kernel@vger.kernel.org, Stefano Brivio <sbrivio@redhat.com>,
 netdev@vger.kernel.org, Oliver Neukum <oneukum@suse.com>,
 linux-usb@vger.kernel.org, jarod@redhat.com, stable@vger.kernel.org
Subject: Re: [PATCH net v2] usbnet: cap max_mtu for drivers without bind
 callback
Message-ID: <20260730135736.7bbe0767@kernel.org>
In-Reply-To: <d81babcf-a4aa-423b-90d7-9b4037872c5e@redhat.com>
References: <20260727072304.154608-1-lvivier@redhat.com>
	<20260729175218.15b5d081@kernel.org>
	<d81babcf-a4aa-423b-90d7-9b4037872c5e@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 09:30:57 +0200 Laurent Vivier wrote:
> On 7/30/26 02:52, Jakub Kicinski wrote:
> > On Mon, 27 Jul 2026 09:23:04 +0200 Laurent Vivier wrote:  
> >> -		if ((dev->driver_info->flags & FLAG_NOMAXMTU) == 0 &&
> >> -		    net->max_mtu > (dev->hard_mtu - net->hard_header_len))
> >> +		if (dev->driver_info->flags & FLAG_NOMAXMTU)
> >> +			net->max_mtu = ETH_MAX_MTU;
> >> +		else
> >>   			net->max_mtu = dev->hard_mtu - net->hard_header_len;  
> > 
> > Sashikos point out that this will causes issues for existing drivers in
> > both directions. Some drivers explicitly set max_mtu. So we need to move
> > the
> > 
> > 	net->max_mtu = ETH_MAX_MTU;
> > 
> > line before the call to ->bind ?  
> 
> So you mean like my v1?

No, there should be no conditional stuff on the non-bind path.
Init the max_mtu to net->mtu like you do in v2.
Override it to ETH_MAX_MTU _under if (info->bind)_
And I think that's it - the conditions can stay as they are right now?

What I'm getting at is after the patch the code should say "we have
some extra MTU discovery path for drivers with info->bind, all
remaining drivers get net->mtu". I think the change I described above
will make that clear.
