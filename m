Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A574C8C54
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 12:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770751; cv=none; b=YReC/l0P1i9Ptx8Yw7j/SnAJzUS0cBTVrOZB+KH3fMofkzHUw/FiR4mOG1dP9zKKe9/WM+LZs24Na4Cmsp685ePE02Ugv+Em0XTgjfXcCVi8a7Hv9s68aYZqggnwwNvINOtZTf1dHtwhZmphcilcR9sKTXY7lNgXSpNoATW1UwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770751; c=relaxed/simple;
	bh=cEPOcLIhDsG9yAVqrucN9c63Rz5nAR8uXwTBJhyycf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XcXER06GfAD4kSv6myS2CXe1wJ6jqLEN6JVS0KYbd0tx6B6WDQeWaP2RwwwahJyX2oiZ7bjEbI0YNWOkV1GfLeOWsmEvpTV+Tp8jEMFsEb9xnqXqXWm9Y7ZW7QYuHuncfSqAMxUVP9ZKuCXCHnKVnSKHgzSRJHtCl4NSA9b5C7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=BXn2SoZB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nIQ6/x7p; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="BXn2SoZB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nIQ6/x7p"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A008F7A067B;
	Wed, 30 Sep 2026 08:19:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 30 Sep 2026 08:19:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1790770746;
	 x=1790857146; bh=93fEvmygXy1a830WnQ28ouLDLUf/1ujnpfyOH7veeEw=; b=
	BXn2SoZBg5YfWZ6V1jEo/fSmdkS1e+28m5Gel790R88bAlLTTMo3WUeQEZ40JyZy
	BHSyUrQNLC1+yM6G7v1PfmbTSkV9aPQ85mATkgQKCYOBQPs32Z5XPE4YB4CiWKeb
	aOE4wqWE+sI2chruMUGU4VKdOlK5lsQFnEG48WfivbcGKjHVF0iuKAg177kSdzXF
	Z+0iRWkIyhEiLnoWsDDVFCGhozZBEM2FyZURIxlf6J2NPXg9PAAglSM8LfVjNshe
	zIPeDUiRVfAHBcv0pfGAFCUjTsYUlL+0x+iv9CZuCh75xxl48PLkXgnlBXVKOU2s
	9GKnwe/Uq0xC9yZNwLJ/Ug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790770746; x=
	1790857146; bh=93fEvmygXy1a830WnQ28ouLDLUf/1ujnpfyOH7veeEw=; b=n
	IQ6/x7po8CTLf8seQXCtjwkB40AHC+XG69z1PaMlKod4HZVSKK7hx23sGTheSYuu
	83+mWKa7ydCZnC2jisA/Sxhdd2XI2NkoX1wxDr+9UpjeiOKB1IzMuB3XPc9fUI2w
	whEioeqa7s1sqfHcJc9IUluZla3eDPhF2hXD8zjmZzAbHLEhEBcItrvAOiUKakmO
	6K8UptRKy8EJs/ovVK6mM85BeKl3LBNPUv30A2M20O+M/7Vri3SMmHuTQBSPb5Fz
	zpQfn8BjkTa9yluqpJ8/JnbncPa5TBStd2X8ospj7r7St8D1GVWKnfuD0/Ht78X/
	q2Tndy7AvcxAynDKbFN6g==
X-ME-Sender: <xms:Ov68aicjMs1Xcsu11xBlHUzQ4zbeyZbzEVdEeRhENeI4CITfl-oBVg>
    <xme:Ov68arolSb8snFelstFib-XZw5C4Z4YziOF9spT3F8yrQiKyqrTZ-H2PfHNVDl3AT
    GfCo8bJQLlVpT0I1m-21jDSY6lJQTqOIqFc-DonDqOdivjtXA>
X-ME-Received: <xmr:Ov68akkxrdHEhqWt1xAarszklVCo2EFRzRQB2--SJ4bGFa3di3uH67VhEu2_kmZHRNKaEbW4BzaZBxK_bkLWnp9LzUMY14J8glxUAZBzFFs>
X-ME-Proxy-Cause: dmFkZTE+YQfAZ1GXvwIHXjCKugo6ZHj5OQfqS02H11hnBkV7/3fZ6Mk0WOxswdQ7Sm8MVf
    2l5sK+oRX59j6K5xF2bsrQETpNmXwAu6fXQz6lsOwcihf/s8jUDOi2REu3q9kN5gen1msf
    +kt5AKAevz37TECl31k5GX3Ax9Mk+S+sfMj1WAow/MA+OtZWHBt8EoMw6h+GU3CHYZEAd+
    qNVpxxo+5UvVN45ckFMaOPSHYbLagnT8wEeYJUIO5Lq70in6wGFGGAPRwWtyvWllJhAyPa
    jsvc8AXVXTDwbGCnAlmPqe49weGkl6GFMlCci0bOH4yxT1JduUovG/SWfsOWaz5TrgK4ZT
    JoqDZhMn3FEmqTskfUfgdmyWd6XVpvNZLDTm06r6vtO4c1OGbHKFc6ALUpGT95zh8D5ydk
    ARnz6CZwv5gM52Yv4IIOL67PxPgcvRymwdE+KAdoThd+SuF5Kw+4rvsHMfKbwpAad1TXWK
    pZ3UuqWZ/wJl4VmVLlh0bcCVHX9JQ8sVIePvCUgMSH4qkfRMscUx+QMi6pG52avJ1pW7U9
    3WvKY1Jcr6d5aR/i9k5un3tn0dbVnxeedIRQVqlHcEJ64fDWEld9KdEnkL+tZGAyIaxX+m
    SSNSbGpjdx0BAtvtXgDiehfcPV474dVOsCMdMGfzzdG2XlpMTnQwcmMkEK2g
X-ME-Proxy: <xmx:Ov68akQF_NF32lurcbvr1Z4Op_tamIOM08gj-qZM_hi5Kxo5SeEX7g>
    <xmx:Ov68aibGnAg5weFdkSJMlgmdAneODlPwlVPtgqyHPCgthSU1kv1ywA>
    <xmx:Ov68as9RYHpK2yi7ZeO0UaOO3Nuioi_LzB6b784ocp7oMfJcOi5xwQ>
    <xmx:Ov68asnZAayoXzDj3gzMyJCoUAdkDwyUiRW2Q4yVnA1_gxB7dDdbdQ>
    <xmx:Ov68ajc66-mgGHNiL0XiXmSFfMm5m8NTtdz-couIaTzfHQkWHx1TAt_F>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 08:19:05 -0400 (EDT)
Date: Wed, 30 Sep 2026 14:19:01 +0200
From: Greg KH <greg@kroah.com>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Chunfeng Song <springbreeze@stu.pku.edu.cn>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.18.y 1/2] Revert "rust: net: phy: fix off-by-one bit
 positions in device status accessors"
Message-ID: <2026093051-donor-veteran-4f99@gregkh>
References: <20260928104855.205416-1-ojeda@kernel.org>
 <2026-09-28-2-daily-reply-0004-re-rust-phy-revert-6-18-left-to-greg@kernel.org>
 <CANiq72nM2+vHeiB3aHBHJfigEm75UYoNEMxX4dmdsRqw23LLHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72nM2+vHeiB3aHBHJfigEm75UYoNEMxX4dmdsRqw23LLHg@mail.gmail.com>

On Tue, Sep 29, 2026 at 07:14:40AM +0200, Miguel Ojeda wrote:
> On Tue, Sep 29, 2026 at 12:39 AM Sasha Levin <sashal@kernel.org> wrote:
> >
> > One fix for when it's applied: the SHA above is the stable-rc one. The
> > commit in v6.18.54 is f22d349940cb ("rust: net: phy: fix off-by-one bit
> > positions in device status accessors").
> 
> Ah, right, sorry about that. f22d349940cb is indeed the correct one.

Ah, will use that, thanks.

greg k-h
