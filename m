Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C61948BD54;
	Wed, 16 Sep 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789551155; cv=none; b=rNDv1jFgRvjrSIryjnCrKp3IV1I15SPiXxyYyGbIJqZxn3kUXj+Y1pRbLBPmXN4ZvkTlNgMVLRTNDxCzn5v+g+e0WKjRhLRypTCMMzu5cEfqqomczJN573IF5vr7vblPlvB0lZ6AI26DW9LD5NqJQEWZoZCMn0i06U9KNvniKwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789551155; c=relaxed/simple;
	bh=hu4BuH1cQdRVEJ1jJbRZ8GoJqJJvOJ4nSYQiQUsbp8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CVDFJkRjdlIHMyfptd5sZXX4SbBX3ush5rj/JKcn9Zm4SSVYLsjtCaZj7aokDQOUGQqoEwsiIQlNGjJX5tcCJzraWgFPBBBNzLKp9sKzSqH2s81jguXYROE9dP6QYeBQHaDRBgpmaWGBv4pA3xtQH6YlQwcDpBiy5uT7gUBC26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net; spf=pass smtp.mailfrom=jannau.net; dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b=mrAso95w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=B5GpTbll; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jannau.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jannau.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jannau.net header.i=@jannau.net header.b="mrAso95w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B5GpTbll"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7A0607A00A4;
	Wed, 16 Sep 2026 05:32:26 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 16 Sep 2026 05:32:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789551146; x=1789637546; bh=n+Nib39VXX
	A5iK7EsTney4u0A/eOskGXnz+cLsmv+Zs=; b=mrAso95w6FNGmI3Y4jPMDHZlS0
	vFHyybBRfDoqg4pDHo1PLBGAm62nfIJ3OBC7cTOObQA42AU2et6+K1rKtRu5MNZm
	3HzBPrRPkmeC+D5YumwYaIowuULN9RWpwwEUytiQDqDAHZyClZOTBGsGjXsZQ5hr
	JxvlkrEuu8uttAx42JmCGwZqpG5Xc72DJtzAY9cJ3/pnwOfhCVjbkmQ2WOtNXOPF
	J3gWurLunN0TnEFFpAbhPHy0jvuzDqzQWCLzkH3QGVZsj5oGaqHgVYph3MK2AK4H
	iwisVP6QnWu6Rk9ZGjsiLeCVnQ1y9diE3sAyyd7IUlM9vMl8zbVYnoUazkEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789551146; x=1789637546; bh=n+Nib39VXXA5iK7EsTney4u0A/eOskGXnz+
	cLsmv+Zs=; b=B5GpTbllK9VizhmOXcK2Tb8GCYBjku66zMm5U4/xbxA62GfbVOu
	4FT5KQ5qTrG4NaQ+kATSysAgRhz8wdw1uMje/sBuG74Ed6hAwC/cZb2//pDZG3GU
	A6AJGVezzVa6WHRrl912ue1327UfoxTJP0C/Ca5bLm6CIwlb4xri36uPnejVh1ky
	H+uR91Ykd7d8IHduxQpXgS4nvbNU0i28xe+viEirdvT+0/XSYpYzyBc9YmKk1uNa
	G77rY4A34WmiQtt7MoI6GY7MjkI5hU34T2b36f+DCo1ZEwD+x1ya+ZGQ7WOjZ8Fv
	vlYDLPBUOTnY1aI+bzIzKBNb/BhQPaTo0aw==
X-ME-Sender: <xms:KmKqalykJKQ4P10d2gK0h8_SVSLU80h6UkFi0NwKaRQbeCxb5EHsUw>
    <xme:KmKqarxCgoEwFHoKd9gL1sJKPsUSzUt7o21N1Iv9xOVCD9K2mUCUWt62F89vE9r7g
    5FDNcsrvw9IXa1jMb7hDFeVHAc8OTOSCZguV6Hmt923Psz2EYvzzoU>
X-ME-Received: <xmr:KmKqatVcpVKJVCR_i0rKuwJaqA-zGcylnCusgu3S28ht1Mok_NokciATDulT6ZTKgNxQdjWiBhBs6jmD8XqgP4LmGamAQPE7FCI>
X-ME-Proxy-Cause: dmFkZTF+oMnapl6+ZEZ7rqXpvtPkdYXLNy3CQAjNF2hGqQGKxr1a2xOEDBhi5APyjFS9+E
    DBoM79i1SO460kazsDa/ZJxITmQN4S4pqjHST2L0Gbcoa6t29c2xSnwKp0QLXWH9oVg5jl
    1urCwduJSFnYdlHXgBphRvQmzkycwjuvX1cqYmC0hZEMcnOaF7Qbe7reQtXm4I+n6p24/R
    Btp8ZiqoLIvarZ5Lmwmofqf3AJhDMaFkkhSaZrxN3KDeHki7HFuVHBKdJBWimJd1HK7dFo
    XeAs4NC9/qVJU4KSufYms80WKbIqv9jKw+vSbifCF+Zq2MRUpH8CWFxIAsA8TQ5IhKmsGd
    q4Y5gWlwD1feQC+MVakjnQgiyCN3ufIVJ656uRiB0x+Ut9zQ17rs/J9WtyZ2bo/Lv6kh1T
    BbSfmcCrqD7rX2F6TqfZuAnWMAVcp+qJfqY7iCJpeclQXRxXEoEDFAYSKE6cYt3Kr1qC32
    nxPR2USAwsDKbvRVTBY15TmkhK+ULSjFevy7o3P65bgJl9dU0yx9uaWHzdDZl9Br2fZveb
    6OnknmqSzYKrX0EZgBuOO+zKtyN39OilK6mnh9HTIyNWV3xUlH68ViZppYgOCp3ZIl7SkF
    lmZzf9pmhXQ2MkNERaxFx8CSp+ioDozgv70CQz+Xukk2v/WmVEQzjxzNZ4cQ
X-ME-Proxy: <xmx:KmKqaqQw1hn-LW6lbFJTwAUbUlkQzOwC6fJcBF5JBUgwrCwdcqCCyg>
    <xmx:KmKqatTwA_nb_6R2WdRniSPXWeyXHkIdxFSNYzG4lIBAfRju51nYSg>
    <xmx:KmKqaqf1QQrOYcnIi1UFXObRmZ86ueXGnU806-VLMJ9JRhOs-stWlg>
    <xmx:KmKqarfvNLBAVmVzLSyGbGfj8RpB8HGcUfduUFu0Z3fsRqdFgNekBg>
    <xmx:KmKqamsqfu3-G20tay6k73ZNWwPY3TBd6meXYCyK4noTdG5AnYjOyZ5k>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Sep 2026 05:32:25 -0400 (EDT)
Date: Wed, 16 Sep 2026 11:32:23 +0200
From: Janne Grunau <j@jannau.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Arend van Spriel <arend.vanspriel@broadcom.com>,
	Hante Meuleman <meuleman@broadcom.com>,
	Kalle Valo <kvalo@kernel.org>,
	Pieter-Paul Giesberts <pieterpg@broadcom.com>,
	Jason Huang <jason.huang2@infineon.com>,
	linux-wireless@vger.kernel.org, brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com, asahi@lists.linux.dev,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: brcmfmac: cfg80211: Report port_authorized for
 4-way HS offload
Message-ID: <20260916093223.GB212312@robin.jannau.net>
References: <20260912-brcmfmac-4way-handshake-offload-authenticated-event-v1-1-e41a6a8281a2@jannau.net>
 <3422e0b3b7d4889d2a728c41b0b02f6c80fa71bf.camel@sipsolutions.net>
 <20260915190527.GA212312@robin.jannau.net>
 <b07d37cbb90b6132df0aebc1c603bad903d8d0cb.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b07d37cbb90b6132df0aebc1c603bad903d8d0cb.camel@sipsolutions.net>

On Wed, Sep 16, 2026 at 10:32:38AM +0200, Johannes Berg wrote:
> On Tue, 2026-09-15 at 21:05 +0200, Janne Grunau wrote:
> > On Tue, Sep 15, 2026 at 03:22:50PM +0200, Johannes Berg wrote:
> > > On Sat, 2026-09-12 at 11:40 +0200, Janne Grunau wrote:
> > > > 
> > > > This will conflict with the "brcmfmac: add FT/OKC roaming offload
> > > > support" [3] series but is written in a way to easily resolve the
> > > > conflicts.
> > > 
> > > I ... no, I'm not going to take that conflict, and I applied the FT/OKC
> > > series to wireless-next. Please create this patch on top of wireless-
> > > next, if needed at all, and then you can backport something later to
> > > stable if needed.
> > 
> > That is very unfortunate. I hoped this change could merged as a fix for
> > 7.3.
> > 
> > The change is required. wpa_supplicant 2.12 (and unpatched 2.11) will
> > run into its authentication timeout and disconnect WPA2/3 PSK networks
> > on brcmfmac devices with firmware offload support.
> > 
> > I'll rebase onto wireless-next and send a v2 but I think it's serious
> > issue in the process that it will take until after v7.4-rc1 (7+ weeks
> > from now) before this fix will land in stable kernel releases.
> 
> That process issue is yours - wpa_s 2.11 was released *well over two
> years ago*, and nobody cared to fix the issue since. AFAICT this could
> have been fixed in kernel 6.11 or so, but now it's suddenly urgent
> enough to make life more complicated for everyone? ...

yes, the kernel change fell of the table 2 years ago. Nothing can be
done about that anymore.

The issue became urgent due to the wpa_supplicant 2.12 release. That was
more than one month ago but I became aware of it and the reintroduction
of the authentication issue last week after Gentoo shipped
wpa_supplicant 2.12.

The patch to avoid this issue in wpa_supplicant 2.11 does not apply to
wpa_supplicant 2.12. So distributions either drop the patch and are
broken or adept it for 2.12. One distro maintainer was reluctant to
carry a patch for a second release. Based on this I disagree that fixing
the issue quickly in stable kernels makes life more complicated for
everyone. It would make life easier for distro maintainers and users of
distributions shipping unpatched wpa_supplicant 2.12.

Janne
