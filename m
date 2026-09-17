Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37898598C1D
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655587; cv=none; b=f/REDSpCw8wrSlme7a+Ji9OTgc2kI/A5UzL17YieliDF/pt+taf/uGaYM3qCszvevdMkdeHJh7apNmISKxskrFMw3ja04IWRBkhFz4T8/osMIqo36NgPudzJSOTr+mYPuzmsghRKXMYI1JSB7Lo2hMT65EImMEoOpZ3CpopucwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655587; c=relaxed/simple;
	bh=vPVgmDiDDtwo5zhkLZsV8LO1+WdOYVqm1EEMNK0zPvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDagJCOnH6sEGufYvfqrdbxhVv9U+Yys3uUe2HKLsJrB/S1eXkwsQPTWD5V3gvED+eLqQUoTWHx0ST4SDqJhNUCdRBnncgacJL8C7RXaixD0Aci7G/I3Hi3nTWzLG7C/3UjRcrFmC2EbG9m3428pS6kpGqaig7q68jNyoVjrlOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=cMXjDCEm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t0ta6Bnf; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="cMXjDCEm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t0ta6Bnf"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 2052B1D00132;
	Thu, 17 Sep 2026 10:33:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 17 Sep 2026 10:33:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789655582;
	 x=1789741982; bh=IS4czLJ5SOp6rGL3kS+PS3pp+tKF7nr2OEX4ALKkM3w=; b=
	cMXjDCEmn6K8EJ0mfGagfhwH0lEcGTS75tnb9YxLZVQ74iGEDQs5qI6ieFcLjDHF
	06V8J+43EwR1sjaujM0GMLNgwHDQ85fUVEXal8jtR2Ao2IK/DAoUZDBl5S17UjI3
	3UyAeJoF/naVLzKi9UWielHitY3dHD36q1DrlwoTCkWa4/nnHFItj59eK5taXLay
	aGFspCEAJS/JdUW1nilVpamXbFrXKxadD14bQetFLb/z0aK0DeKMM6y2ep981Evw
	AgE1zIBUD5AD1m6KsmyEqNQTPTVs4hg3xGqLMmCSmXkr1sA7IhknC3cF2+E7DUAE
	vrdNFLywhHJsuqaAr4rUSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789655582; x=
	1789741982; bh=IS4czLJ5SOp6rGL3kS+PS3pp+tKF7nr2OEX4ALKkM3w=; b=t
	0ta6BnfHzrexkOu7tV/HWTIzYPnkb9j+/83GQsRPt6RITwV/a1x0KhPu0YD/HGCn
	1sNxhXTFP5eOtEkYRwKewScd5OdrfQbmXz6kCjo99KMTeOiYkjHrtSvDtCzaXEyR
	UfOJUpSqu1GFftl4WuNJRdKnmnSQMt42CskvN3vR+NPIOxhGJ/3WMAVrf2I8Qynk
	78k854LxZfrD3jdKLRV5NHT7H2AEVuD5BVTWD9/4+tjbsXXnHSkkx/Us0sQ1NisH
	2lzp0QV4FPP2AE5eiA9lg5spKRKQuJakEJCsON4bOAMLyBzmEv17kM9Q5z4OV3cd
	XVY2C9ITIadd89r16k6MA==
X-ME-Sender: <xms:HvqranCdgJXH2LVXUhfoeiaWradyLaynU5Soe4mDEqXW8AfR5T7_QA>
    <xme:HvqravysQ3djd4VT0QUzscOAiybXckf4KKGR8kEpXGJI54Ju9tdb-3MyNKNosqJ_W
    N6lCfzqlurL4OaFmydi6LgDpOBRbrOBnjgzu_jp0y2mmEbn>
X-ME-Received: <xmr:Hvqrak3rzoA6wCnJ_XYnv90ZqWN16iCDbvtco7ZsM2HZK06tSR08fJ2wI_LW>
X-ME-Proxy-Cause: dmFkZTFTPoz4QrNoLJ0PWVY/pNWcCyXmrTqGiGLTTyKFcLQQjV9eJrUKzMxYi/DhMQ+QcR
    Bt9DEX1HdVnWYX4egI0Rz8btIgqc0lDhWW4Z1l4z71ydXYihSin9J4UL3URIyRRtzVSUPH
    gK3ormbiryjUYKopiNDPkATMnVa89dqjEy8Pvxn56zaGM2rIFEC30+95jnWATvMzzl52C/
    RyJOafw5kfcoKFIF1N46Gv6ha94y7GT9NpKHDKS0/A9Gbqkgpfsr09y5VArToFf3obugzR
    VPjS8SUOr/LeSN2ZA9ZU65OlikshSy9EZAGuigY0BcYvOxFL/3dbTJtGWrtQ13R5UFC3QK
    oqv8zoV6mpVM+b9G+Gtsby6mcmrfhtL0Xt4EwgTzC4PMIJDnhNdFzvEVyPYNmV9ZPZE4bA
    mh9Lvf86p9VueCr89iFUymXga+K55/Rh/Wnk5LwuRCfSCS5AKRjnC64eUceexOklJCJMCY
    IyoeBfBvxhPEI4ogWPPTvW/XdWlv9cQHQwFmqVmUfX5PjLajQPGmfg8xWx7EUiiwdjsdyC
    JdkDsYfo495x15+z4wsRKtYmkdHWbP+bP6GiJfL1APrMsFaGvw5gyFpkGmKA8xzT/APMIt
    c7R/dbRaN77o6+c+fW7EYpgjHOJ1nxj6uh0NXQlRXDGA5xwg2rRR7GdlQ9bQ
X-ME-Proxy: <xmx:HvqravzLLP8q6NV9HttZ6Meg7P8g7tgtGj16QyHnEq4vjnVM1EDNMQ>
    <xmx:HvqrarEWXMGhWczRQTLdC3T0BEBESVNLw3PUTliYqG2ZmegftP3uuQ>
    <xmx:HvqraiYPEswjKh3ZLhq9kaYlrpv-UopSvJ2eFDZPqQ7M--wRFC982w>
    <xmx:HvqratDyLnyRnb_ZNwlPO-XU9glsaAgjatZfAd5SEwQRdgp1qUJlcQ>
    <xmx:HvqrahY9HBqUstl_-hC5uOzVcGsL4OW6IXsBxAqjN_Ek-5zZweUr36MY>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 10:33:02 -0400 (EDT)
Date: Thu, 17 Sep 2026 15:31:06 +0100
From: Greg KH <greg@kroah.com>
To: kernelci@lists.linux.dev
Cc: kernelci-results@groups.io, stable@vger.kernel.org
Subject: Re: [REGRESSION] =?utf-8?Q?stable-rc=2Flin?=
 =?utf-8?Q?ux-6=2E12=2Ey=3A_=28build=29passing_argument_1_of_=E2=80=98link?=
 =?utf-8?B?bW9kZV9maWxs4oCZ?= makes pointer from integer wi...
Message-ID: <2026091702-widely-stubble-44f6@gregkh>
References: <178965354504.144182.1209886168149833440@kernelci.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178965354504.144182.1209886168149833440@kernelci.org>

On Thu, Sep 17, 2026 at 01:59:05PM -0000, KernelCI bot wrote:
> New build issue found on stable-rc/linux-6.12.y:
> 
> ---
> passing argument 1 of ‘linkmode_fill’ makes pointer from integer without a cast [-Wint-conversion] in drivers/net/phy/phy_device.o (drivers/net/phy/phy_device.c) [logspec:kbuild,kbuild.compiler.error]
> ---
> 
> Log excerpt:
> =====================================================
> /tmp/kci/linux/drivers/net/phy/phy_device.c:3059:29: error: passing argument 1 of ‘linkmode_fill’ makes pointer from integer without a cast [-Wint-conversion]
>  3059 |         linkmode_fill(phydev->eee_broken_modes);
>       |                       ~~~~~~^~~~~~~~~~~~~~~~~~
>       |                             |
>       |                             u32 {aka unsigned int}
> In file included from /tmp/kci/linux/include/linux/mii.h:13,
>                  from /tmp/kci/linux/include/uapi/linux/mdio.h:15,
>                  from /tmp/kci/linux/include/linux/mdio.h:9,
>                  from /tmp/kci/linux/drivers/net/phy/phy_device.c:23:
> /tmp/kci/linux/include/linux/linkmode.h:13:49: note: expected ‘long unsigned int *’ but argument is of type ‘u32’ {aka ‘unsigned int’}
>    13 | static inline void linkmode_fill(unsigned long *dst)
>       |                                  ~~~~~~~~~~~~~~~^~~
> 
> =====================================================
> 
> When fixing this issue, please attribute this report according to the
> patch submission rules:
> 
> Reported-by: kernelci.org bot <bot@kernelci.org>
> 
> For complete logs and details about the environment used, see the issue
> on the KernelCI dashboard:
> 
> - dashboard: https://d.kernelci.org/i/maestro:bdb28b77374b282063c23c44b336428b1a4691fb
> - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> - commit HEAD:  09da4c7d441294e4264cc4804d8bc76433d5e0c1
> 
> # Builds where the incident occurred:
> 
> ## defconfig on (riscv):
> - compiler: gcc-14
> - config: None
> - dashboard: https://d.kernelci.org/build/maestro:6aabeb69fc1857a999df1355
> 
> ## defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y on (arm64):
> - compiler: gcc-14
> - config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-6aabeab8fc1857a999df0f48/.config
> - dashboard: https://d.kernelci.org/build/maestro:6aabeab8fc1857a999df0f48
> 
> ## x86_64_defconfig+aws-ec2 on (x86_64):
> - compiler: gcc-15
> - config: None
> - dashboard: https://d.kernelci.org/build/maestro:6aabeb88fc1857a999df1404
> 
> #kernelci issue maestro:bdb28b77374b282063c23c44b336428b1a4691fb
> 
> --
> This is an experimental report format. Please send feedback in!
> Talk to us at kernelci@lists.linux.dev
> 
> Made with love by the KernelCI team - https://kernelci.org
> 

Now fixed, thanks!
