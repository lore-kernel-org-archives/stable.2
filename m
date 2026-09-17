Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6647D58F080
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 14:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789655731; cv=none; b=m3cR5UAKc3hWygmakmyBvgQB4pWzmrWE7N0+cv5d+Ncuh+zdXNCjRXVZ4M5+V0rdKGU0xLCo4/6ZtJqDLlwevOj9zOCk2HFs4QpeacWL7WchP51bctob/doO/Ikrlb1xBTW7Df+NzvWvOABS4AeH9bdeuBAbUJttbij+msnjUvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789655731; c=relaxed/simple;
	bh=RXPUpqBV0EdVnMaslQGmJTUUacidp3JbY6/4OUJnovc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bwHWfRCMVMmaczRcJiKRKQr2n0+97WTkfoLWFIVHRhmR6u27xfubc39itLuq0Tx/bavPrkg1CCR0ydiKUci2Qa/2l/zrFBeR/JfkwXSlNqc9JG5wCY5O6RfK+x3XQrk/tuw/q78QS0y2wY0kRtCc92rXZjg+S0S1CtDF6l/D0xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=J9dnoowk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nW96NBMU; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="J9dnoowk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nW96NBMU"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 6C6681D000CA;
	Thu, 17 Sep 2026 10:35:28 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 17 Sep 2026 10:35:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1789655728;
	 x=1789742128; bh=W4mhKT180sx3H8YUpcgd2R3Z/cnF3MM1bECLEarhK7s=; b=
	J9dnoowkifI9ZSCTH59BZVDiwwRsXAUT4Z+LdAXEpVVcpcKXxYt1DVPTexgytlNU
	LgyvXYFFwnCLsHxYRdKMGQNSt4+evCfZ2JdpOXaTYlBW4b4u9IkPn4aJC4UH9422
	I/O2aNCnnIZ3GvRutfyuV8IYixBzeTTKnmkh8UJqBBU1ASAlEJb/1aYfkR+z4YtD
	ekAGxeEB4SSO8V8kX3EmSrg19I6gaESD2rZSPHekC6Dkoh5H2UUJuEog8epiaBrz
	qxo2pzrekU34D/kkdFe9X5bZ/e/9S3MN+YQMMS50cVgWnlgor3fRdJLTVECbNseD
	QtfvgncCvwOWELtDenI4Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789655728; x=
	1789742128; bh=W4mhKT180sx3H8YUpcgd2R3Z/cnF3MM1bECLEarhK7s=; b=n
	W96NBMUR7fCXEX4mZJhttRasTqA2miE4J4E3qv5xlJ46U0TcACHfk+Tz2zhRB4lI
	rggV4RnS9jmFc2fI3Le7MIlzwITmf7RA1X24qNw0GdGyvSBB53SqyoezCwh3aQNA
	vAXpyB7Mkbhdih+C+wlrkpPVRiqMBbsmpYEowoNs39w0flvXcgCZlGbW1ROUJww3
	XWyjCc4EUJsMVEN1wTIxu6IxV+r1L99k0bZwEclwR4mdrrYMDRB0E5PTIFT400Ez
	RjwUPPcbyWm06VbdMoIoTIK2Q50YCXIxFalW81g7TMPujJ6ifd/OM10czlA+kAlQ
	LXhuGC/kiDLQ+zFoXx91g==
X-ME-Sender: <xms:sPqragAKap0oCViLiLNKC0l5fAUO3_uxSBmJqfO-YZ9XS-HchQbxgQ>
    <xme:sPqrakxG8IGHbdI6axOABxAEWRrcf_7wZ9PiRbJWP3Ix3mZAt6mz8GsfQ9Sd5kDy8
    NjtZeLeKGotfpQQx44Ohtm3o5xyV6B6kxkP3bSsTDG3TZnh>
X-ME-Received: <xmr:sPqral0SytMOjxS1lXu8BI6zuRnenGRNpetiX-N_P9uFN3d_TWDh93jb1vA0>
X-ME-Proxy-Cause: dmFkZTFTPoz4QrNoLJ0PWVY/pNWcCyXmrTqGiGLTTyKFcLQQjV9eJrUKzMxYi/DhMQ+QcR
    Bt9DEX1HdVnWYX4egI0Rz8btIgqc0lDhWW4Z1l4z71ydXYihSin9J4UL3URIyRRtzVSUPH
    gK3ormbiryjUYKopiNDPkATMnVa89dqjEy8Pvxn56zaGM2rIFEC30+95jnWATvMzzl52C/
    RyJOafw5kfcoKFIF1N46Gv6ha94y7GT9NpKHDKS0/A9Gbqkgpfsr09y5VArToFf3obugzR
    VPjS8SUOr/LeSN2ZA9ZU65OlikshSy9EZAGuigY0BcYvOxFL/3dbTJtGWrtQ13R5UFC3dE
    cIml1nxoEpg+Ne0TXLC5ChxKgE4reyHeKYzSgd4HD9HskA+JgnYsKGXwQtWC5ph6qxHlH5
    hu78iLkYrC6umVVvmEm2DQzsARfsOWW7ZTfcfOLoI01OlkDH30jqi4jyE2EFPUzvaCFmPN
    Kz/LbnYXi08gI3luMSOkV8R0e8s5Qnp2zE/NRQFe7XNIFRLmfz/vpuRIbD0kb+o+oTQD4E
    /QIqWCtSu24ScJ5gl5rHJIq/UZzZkIiins0uyMeRE8FgC6uMLWiWhRgo9vQcyZZXjuUxsf
    /oQ5HG3wzcDQa4AHj/8LAsJVq+HBaxIeCmNZ60ClxP2SVm17cxacodW/vt/g
X-ME-Proxy: <xmx:sPqraszN9NvhqrqXZ0wCWSv9MVEs2HbxOIDTM62SiCKPmbHGYWyMDg>
    <xmx:sPqrakG85X89GzFq1nfLBMc_O9GpDjBimKaVIhLULeJPSfi271xlWQ>
    <xmx:sPqranbtLBgIAnNss7pEejc8wmGlL9oFl2TitKxbj-gGTBk3pnDlcQ>
    <xmx:sPqrauB6G1mgy5_i42IdITPYMxXl9WAp4x3w2EthlsdU74bdOlhcGQ>
    <xmx:sPqraqbqt8Q3na2Eb8gS3fvP9CdfwgVXKPuyoK-sGyorThxp-NSVXULV>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Sep 2026 10:35:27 -0400 (EDT)
Date: Thu, 17 Sep 2026 15:33:32 +0100
From: Greg KH <greg@kroah.com>
To: kernelci@lists.linux.dev
Cc: kernelci-results@groups.io, stable@vger.kernel.org
Subject: Re: [REGRESSION] =?utf-8?Q?stable-rc=2Flin?=
 =?utf-8?B?dXgtNi4xMi55OiAoYnVpbGQpa2VybmVsL3NjaGVkL2V4dC5jOjM4Mzg6MTM6?=
 =?utf-8?B?IGVycm9yOiDigJhzY3hfaW5pdF90YXNrX2VuYWJsZWTigJk=?= undeclar...
Message-ID: <2026091727-sterilize-hurler-7868@gregkh>
References: <178965354733.144182.3599012631280321500@kernelci.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <178965354733.144182.3599012631280321500@kernelci.org>

On Thu, Sep 17, 2026 at 01:59:07PM -0000, KernelCI bot wrote:
> New build issue found on stable-rc/linux-6.12.y:
> 
> ---
> kernel/sched/ext.c:3838:13: error: ‘scx_init_task_enabled’ undeclared (first use in this function); did you mean ‘scx_ops_init_task_enabled’? in kernel/sched/build_policy.o (kernel/sched/build_policy.c) [logspec:kbuild,kbuild.compiler.error]
> ---
> 
> Log excerpt:
> =====================================================
> In file included from kernel/sched/build_policy.c:63:
> kernel/sched/ext.c: In function ‘scx_cancel_fork’:
> kernel/sched/ext.c:3838:13: error: ‘scx_init_task_enabled’ undeclared (first use in this function); did you mean ‘scx_ops_init_task_enabled’?
>  3838 |         if (scx_init_task_enabled) {
>       |             ^~~~~~~~~~~~~~~~~~~~~
>       |             scx_ops_init_task_enabled
> kernel/sched/ext.c:3838:13: note: each undeclared identifier is reported only once for each function it appears in
>   CC      io_uring/poll.o
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
> - dashboard: https://d.kernelci.org/i/maestro:bea4dd538099462d8c92badd44596b9958bf40cc
> - giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
> - commit HEAD:  09da4c7d441294e4264cc4804d8bc76433d5e0c1
> 
> # Builds where the incident occurred:
> 
> ## defconfig+netdev+nfs-root-boot+kselftest on (arm64):
> - compiler: gcc-14
> - config: https://files.kernelci.org/kbuild-gcc-14-arm64-nfsboot-6aabeb25fc1857a999df12dc/.config
> - dashboard: https://d.kernelci.org/build/maestro:6aabeb25fc1857a999df12dc
> 
> #kernelci issue maestro:bea4dd538099462d8c92badd44596b9958bf40cc
> 
> --
> This is an experimental report format. Please send feedback in!
> Talk to us at kernelci@lists.linux.dev
> 
> Made with love by the KernelCI team - https://kernelci.org
> 

Now fixed, thanks.

greg k-h
