Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3F43ADB92
	for <stable@vger.kernel.org>; Sat, 17 Oct 2026 05:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215946; cv=none; b=CE2S+oHzm2kMg+elMii2u4UCKK+izuMiQgFFD+hGD0TDJVSattYYNut7OXsNkofL9WZ35dRf9SFTn6RgEvX04ySRdrwIEiVEKADpY67SDWsht+eOdOL8PZklYOTXa6QYRbJLpq00n3aPVucyM8hwLuqEACSh5RkNSK64cALUJAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215946; c=relaxed/simple;
	bh=0XYqx1u7sKZSYQBwv0k4QkPS7678JlLvdTHPTrgLbzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvUmsDl6HdcRdYkwUi1/7F5n+GLDFN/La//lmsEqEU+3BxQErj5WFnUm/eMmUf3TNqCokYqhmmqL1PXFTKBpYXq6o2Xjb24YUC2MJH+1Jy8MVQl9saFbXwS5eniOtGM3WJrhcJGoiDs3F6VmX7hdA2PiQqSEJ2J3ABusqvW8Ugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dUC9L9Bm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dUC9L9Bm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 462281F000C4;
	Sat, 17 Oct 2026 05:45:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1792215944;
	bh=Irp1w6YXigrOn5sn/xl8Ctx0KqHC6GO3GLBC0DMTFEI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dUC9L9BmOL1ZbQE0YeH2r8jpJLJ/DKNZqHL5iYclhHbp7v58ECvF196Pq+3UVVR3/
	 O3iuCbjqs4lWd0oTwCbfNXmCeUyix1Nw4VYdAR80B2BwjhUy4kLACJfV+6HA0VKHt4
	 WYc2EO0EiWwrvWaM+aZ4ePwsttjQIjL8MWYU7/aU=
Date: Sat, 17 Oct 2026 07:45:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Dave Airlie <airlied@gmail.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Vadim Nikitushkin <bub4z0r@gmail.com>, stable@vger.kernel.org,
	thomas.hellstrom@linux.intel.com, dri-devel@lists.freedesktop.org,
	skainsworth@gmail.com
Subject: Re: [PATCH 7.2.y] drm/ttm: fix swapped-out resources never leaving
 their bulk_move range
Message-ID: <2026101737-broker-output-d845@gregkh>
References: <2026092253-dimness-unethical-2515@gregkh>
 <20260922153334.136648-1-bub4z0r@gmail.com>
 <2026092320-reentry-lyricist-330b@gregkh>
 <32446a55-070d-4739-bd3a-d56c4b628e29@amd.com>
 <2026092332-alkaline-overthrow-494f@gregkh>
 <CAPM=9tyVcUdb-wjv2unksLV-BVcOxswqB0Y+H7agBU5vYGFKDw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPM=9tyVcUdb-wjv2unksLV-BVcOxswqB0Y+H7agBU5vYGFKDw@mail.gmail.com>

On Sat, Oct 17, 2026 at 08:19:46AM +1000, Dave Airlie wrote:
> So I got a report that
> 
> "the backport of "drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on
> swapout failure" to yesterday's 6.18 missed "drm/ttm: fix swapped-out
> resources never leaving their bulk_move range",
> 
> So can we make sure this patch is in the stable branches the other one
> went into?

Sure, any hint as to what git id that is?

thanks,

greg k-h
