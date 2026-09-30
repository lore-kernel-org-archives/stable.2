Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722C33E7BAD;
	Wed, 30 Sep 2026 06:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790750316; cv=none; b=NAtB1fmlUcoFZXWqV1enfDEmyG9Mf3rz1Syqa2XDI+aORTDw/ar49zz3ScOZ3JGWM5UVjoNxAB1FRSm97axJslncsHAGgOqeMT01xtR9nTCsws3kzzWsINLpNNI0CvmLfR88kIfFDCy4dmRs7Ke/q+F727an7yh+ec/p43FTfn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790750316; c=relaxed/simple;
	bh=2mWfXzVQ0wFbUgDXb0z3as+IJLD0NLDeL4Zp9YaiZPc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkwsdnJlTfnwxTcUiHVKW78UcKRYidtPRyYCdTISnKkfbWAmdrXrIb/5Eh3fcokoPvrLwjijY++PKD4r1V47EGCNm60Pu+hHS/V0aB0lSizhOvBOicTI8WZ5BMlExF/MEGxoAKQbO8ISE3WCp0sh/0qI7VwXp5hv9MD2x6MJLP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I8PTEoG1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I8PTEoG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A221F000FF;
	Wed, 30 Sep 2026 06:38:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790750315;
	bh=mAapfqsVmhY158vFhfbv9M/7PuYnyMLG882EyG0k0pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=I8PTEoG1kZ5X2W32m8dDCd7PuLqKfLssyoSWG9eq8ccpjYLguvEOZvTncgU4iZTvw
	 ByM6vxAStphg/H0p/Z7zgvw4oPthuudkxbaBdkq1Jpl8dJY1iVA42HA15I4lnso2LJ
	 z8oDvckA1jK21QqbopA5AJ0a3uYJtclEo9C0TjYs=
Date: Wed, 30 Sep 2026 08:38:31 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Gongwei Li <13875017792@163.com>
Cc: linux-staging@lists.linux.dev, Hans de Goede <hansg@kernel.org>,
	Dan Carpenter <error27@gmail.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8723bs: fix scan-abort timeout in
 rtw_scan_abort()
Message-ID: <2026093011-diner-presuming-5b33@gregkh>
References: <20260930015024.3627275-1-13875017792@163.com>
 <2026093048-thrive-phoney-5b9e@gregkh>
 <20260930062708.1585771-1-13875017792@163.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930062708.1585771-1-13875017792@163.com>

On Wed, Sep 30, 2026 at 02:27:08PM +0800, Gongwei Li wrote:
> > How was this found and tested?
> 
> Every other jiffies_to_msecs() call in this driver passes an elapsed
> time (jiffies - x), but this loop hands it the absolute start value,
> and the check never passes.
> 
> I haven't tested it on real hardware. I don't have an rtl8723bs device.

Ok, let's wait until you can do that as I don't want to break anything
as obviously this works as-is today.

thanks,

greg k-h
