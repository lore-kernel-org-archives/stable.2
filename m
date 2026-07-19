Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA8F17BA2;
	Sun, 19 Jul 2026 05:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784438339; cv=none; b=EztsDCCsMyg1XEgcl8AkgZj2E1lEDUjJ6wiC8y0K2TFE5kinpNiMBoonIL8Bj3zdDLGWiPDRYqdXA/OBEKso7wda4tCxdURrcDkpSr8/4EiD6MvWM/5wasQiGQSbJNwecCoDAofUc44329RrymfzSPYl2PccBTKsaukToFYufuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784438339; c=relaxed/simple;
	bh=2aOoMpNTjgDq7HGrnUJMu7u6z3gkMqPBB6DAE/Gy9dY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iGM+m8/8Hxz3qhakCUfq+dUpfFM/N0WOmB2tUVoYyZMFEUk8qvFBoF2/C0pmT6o8pPXIm5ai5bkD+W4Xj3aJZgAfOJGmXcG/tOpDK//pkOVZ/Qh+6iBxIrjAR5xux/mszhboxdI2pyvcWrdT7KVjt2DVGvOjolAwRa1d4yGZqn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1vTToIOo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1vTToIOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BC21F000E9;
	Sun, 19 Jul 2026 05:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784438338;
	bh=rDj/qYdOo4Qc+0y4Y/ZXxhCsSHwoWJEiH/YTmP3S5SI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=1vTToIOohMpiFwySBEaLu1mon0/E/NgJAoBkPy0rNeaPgiT7yZSve7bLhb61TWqoL
	 G/bb+xTaZShqOiCW5EKZ52gLoOZN8GQayU6FpMjt9udmzpYMY0EyDzRIW9VZUIxb06
	 LyJIxykemFmU+GoufjrJikl3jR/Qx+X0R1F3HzdI=
Date: Sun, 19 Jul 2026 07:18:49 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Muhammad Bilal <meatuni001@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/5] staging: rtl8723bs: fix multiple OOB reads in IE and
 frame parsing
Message-ID: <2026071933-unsigned-deflector-3e34@gregkh>
References: <20260718185445.63070-1-meatuni001@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260718185445.63070-1-meatuni001@gmail.com>

On Sat, Jul 18, 2026 at 11:54:40PM +0500, Muhammad Bilal wrote:
> This series fixes five out-of-bounds read and buffer overflow bugs
> in the rtl8723bs staging driver where length or offset fields from
> untrusted wireless frames are used without validating that enough
> bytes remain in the buffer.
> 
> Patches 1-4 are reachable remotely through crafted management frames
> (beacons, probe responses, scan results). Patch 5 is reachable
> locally via raw frame injection on a monitor-mode interface.
> 
> Impact:
> 
>   1/5  OOB read of IE length byte and OUI data in rtw_get_wps_ie()
>   2/5  OOB read plus stack buffer overflow via attacker-controlled
>        memcpy length in rtw_get_wps_attr()
>   3/5  OOB read of action frame category and action bytes
>   4/5  OOB read of next-IE length in the non-matching fallthrough path
>   5/5  skb->len underflow after unchecked skb_pull in monitor TX path
> 
> All fixes are single-hunk bounds checks following the same pattern
> already used in the sibling functions in these files.
> 
> Tested: CONFIG_RTL8723BS=m with CONFIG_KASAN=y, checkpatch clean.

How did you find these, and how were they tested?  Do you have this
hardware?

thanks,

greg k-h
