Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A14391855
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 06:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789021029; cv=none; b=VJDgrBO/VcRrYKnV+/DyGXk9O8tRhnqeKkcS1+15+wgZpohAHjJNwF+xdaKAfrf5A6R1PFuwzvCcigd7Mi0dQLRZWV58R3ygD5vDjGOj322UMtEDffkNOk6u/I3vS/3qhIP7VwtUkql8EUP7MVQ3cLeczGhSdaGUQC0FsJ+fA2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789021029; c=relaxed/simple;
	bh=ax7iAItCZxhp4U77ALZrLCStzQORbjOVlFCPe8cAHxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tW57DCyby7pWMaIk7aplswfVYLgCwgr7wesMImuMRlJ9eztJT7NpRV9PtT+i/n+ERI8nvb2FzB1VGWH/WzaJEYe/MqF5ge//jDw8Ra59vRGPGONRs9VQy7r9zHILrpqqlexUbQ22Gl1M6NjdBeAhr2F5xtpJMOY8u4THFSVrfXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=HmZPtklR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xLxhpp7P; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="HmZPtklR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xLxhpp7P"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 118F514000EC;
	Thu, 10 Sep 2026 02:17:01 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 10 Sep 2026 02:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1789021021; x=1789107421; bh=xFWtt2eHg+
	oZnfJ3PfjUfyENZxtN7vqiiamMOKqGF74=; b=HmZPtklR4A9knrQOOcBqn6G2Ar
	c7WatLkg73f8w6KW4hP2+iPxHB/JJJE1nk/DWrUxp5JO0viCxo0l1j1RhZJ/bKYD
	d7CTBYvlgSu2Y8Q0GNhsrkej8XJ45tGCtw6kE/Bn4nOtNoHzFYZ7As1hmdv9zfcd
	tro7ao3YMTMc+njrVBAwmM+Y8gxrcRFEt6hTwab23QSS6H5dDItQX7WCit23Cesu
	oguLfV0AXYm8JAcHitfTNnSYuLwMyTZ/tRsRrNhBNsWCJeXb2xVX7MrrkS9OFm0J
	7SWWRIeeWDxrq5OGlCtNYSmCgus9IUpSdF3crc1JXzAfBwbAdTRX87at6lfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789021021; x=1789107421; bh=xFWtt2eHg+oZnfJ3PfjUfyENZxtN7vqiiam
	MOKqGF74=; b=xLxhpp7Pm2N1qN4TM7gpalt2ib0I8sebaWUsHOdym3vV+LYJ2/D
	65/pH8gvoOQKbIOtAF7IOnvuAkggiNizmQ4T24pYapK+5RKXkdZfZII5ZOxK0q0G
	7S28G4OWTtTbzxpNd0rXhOjHElK3dnNeN5/+2aWigBGFSVY4WG3sZ+gJwlpWdt4x
	pPGTOcODm0gSmK+pXw1xEEYbltwUriQgUYYSSt3NfXNIpxKEJ+k9HAaUawUaeJxl
	KEznM2y9GoThdujmxKbYoYVg2sP2XscimN9+Y4L4dXO+x6vp/O4iRkKYz5pDF2OM
	YTKaMsfKwehwG8b90Vn0WTdkDir0IfdUeWg==
X-ME-Sender: <xms:XEuiamDlkUFKjDd8wGzFFvlTyIFt6xwnuUFWMEnzqNJhHXl1fCEzcQ>
    <xme:XEuiajHKZuaMiiPMJEnB4QhBy2PVMpJTjr2Zf1XEH2xSjYJSHpbwFJKOQ-WNks73J
    wpSTB8sgqt967PeigxuRmsNem5yFVHmDXQ6uwY5tOm2Zjzh6lI>
X-ME-Received: <xmr:XEuiatPxtd3ihGH_o0nIWynQRpayiAbt1S7F-so3nNozczCQKpj5ABTajFcuEcNNjYO-TtuwtsZPI7HtKMmv_uObpNEipDGxUQZofQCkhFc>
X-ME-Proxy-Cause: dmFkZTG3nOssro9I0zqEyPaTpfkjsS1VYtxU9VsZgd4z++2dxU5uKj69mrC64FkeWFoQpf
    zHGGEJ3/3DmMaetFztzdnl11j83g/DBT9N7TOeaLG+e3IdPL/Lk4m7xHp0qt3koZH4AR8x
    IdTXvXTOeY8teVt0we3JFRFG/ezzUIkcPQGOJCYwdevX2GO/vSJoTb+mggbxwD91Bin5NK
    3Z7wVZH2Pm/erWLmwH70K09feFejys1lICswGSPnrVlU5oYDM7GOMQCX2A1XYkX5o5C/7z
    yq2pvXoDRIM6dCLsrawicXuWjbbBqzTG/iVnFpBBEgT7aWm5u1+v7fH2N93Y7UKSq0oPXm
    7WtBSjAycEZkPS0CV0frq7byZHIcfpty2GdxJxOKIsXtFwP7jGwOfv0e62HAZ1zUyeYtmt
    pV1FHsoiXG7XikLp0ykOLwwGYLt1fAU1pHrtVd29bSL8FiWv8v/6hYxE3b4wnuCg2G99qI
    zI2pz9+f3+Hl0T7N/RczZTvmv6EjCQR3A7SGlRdUioHslE7Dt52E5+f4vwCjWhzAe8+PpG
    dgR2SABxZqWVmeOpFk7hrg+uijJSXQwOTB+BiPJYrh6pXKt64g9Oge54JNQ0nebINI6c+u
    aVmXDhd4T2k4bRxY3S1hl6JPhBKCOpa3Whvtsk04jPQuhHfF2Z+fhkdBlWTg
X-ME-Proxy: <xmx:XEuiak4-zNMCTPB1WWH-I_dq0Up0E7sbccjMTS77XtOXp-fZFSr-qA>
    <xmx:XEuiagjLWEODFANLHHhHbOjsyaHCMWU_e0-qa29MWNIXTKEMTnu5Tg>
    <xmx:XEuiapdYOaC36nUMR8QX_nWPTVBZi1G6qrvujIKIAex8PIkpxPKhuw>
    <xmx:XEuiaoxePSRUkKwhrUX1MTKMLp_C5koACwd8TzZ3Y0fMS18l0dV3DQ>
    <xmx:XUuialRpN51T53sWBNnZnjrmpv7oY_DCIcW90_qWJoMEorqKwMR1vzgk>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Sep 2026 02:17:00 -0400 (EDT)
Date: Thu, 10 Sep 2026 08:15:05 +0200
From: Greg KH <greg@kroah.com>
To: SJ Park <sj@kernel.org>
Cc: stable@vger.kernel.org, damon@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 7.2.y] mm/damon/core: skip aging from repeated aggressive
 merging
Message-ID: <2026091032-outright-varsity-64d9@gregkh>
References: <2026090918-relic-padded-3b25@gregkh>
 <20260910010209.126591-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910010209.126591-1-sj@kernel.org>

On Wed, Sep 09, 2026 at 06:02:09PM -0700, SJ Park wrote:
> On Wed, 9 Sep 2026 14:19:27 +0200 Greg KH <greg@kroah.com> wrote:
> [...]
> > Does not apply to the latest 7.2.y queue :(
> 
> Thank you, just rebased the patch to 7.2.5-rc1 and posted as another reply [1].
> 
> As number of stable patches for DAMON is increasing, this kind of patch
> applying-order based conflict might be even more common in future.  Maybe I
> could reduce this kind of issues if I could post fixed patches as single patch
> series, instead of replying to this kind of individual failure report.
> 
> I was initially worried if your workflow is dependent to the guided workflow
> (replying ported patch as a reply to each failure report), and hence if this
> could make your job more difficult.  But I know the stable patch submission
> rules are quite flexible.  And you may already have good enough automation for
> such small change.s  So as long as I keep the essential stable patches rule
> (use 'cherry-pick -x' option and add target branch name as patch subject tag),
> that might not really make your work worse?

A patch series is great, and much simpler for me to apply, otherwise I
have to just guess and go by the email date/time stamp to order them.

thanks,

greg k-h
