Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C413DC84C;
	Thu, 10 Sep 2026 09:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789031699; cv=none; b=QkXeqESvFEm4t6Cz2Ur68PpD1tK3SlR0g1RogpKVTh3hRhRvD3YIhAU0ezUT+Mjgy0/1W+KKVo/50Djr2fG6pcO3MXfaumbIAdd6oZcUNYMjrn4DWZbc2k/TAbmLfRPEplvp3cLGIbvra9g4fbpn6ID1jqfNpb/EP0VzTsoakrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789031699; c=relaxed/simple;
	bh=+sMiq+HIGM87jQ/5RSUOFRphnhrIq2E7pgR8EgnTWRA=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=GtMPyTcWyR4mRuErcxq3cvTxVmP1pkn0t719kiPKldDwCEQZREKnuZL/YqszNjmjkiuaTvfz/V6cq4Nvhqawqedb3R8hG7cytXyuWQDF+KcqRpTTwycE3mzSro+KSfnSLm6uWok16TwbgixX9px7sVZ1Kl8srWiCDcCE9EU2pHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=FiAsJ+ns; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=risyzqbT; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="FiAsJ+ns";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="risyzqbT"
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D83A51400093;
	Thu, 10 Sep 2026 05:14:55 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Thu, 10 Sep 2026 05:14:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1789031695;
	 x=1789118095; bh=WmyYGlLJ4HV+ah11VEaf5EpA13EGUApuca9HZd1EWRI=; b=
	FiAsJ+nstRvjg6RRQ8P9u/hlxRsueJIWNuCARKfZpRCtDW5cx2JKFVhhOcSGdgBe
	e4P3qdb+z2cuxmkn3OQWael/w5TLkk75zEcujLQ+LdG32wd4ZpF1I9QrRjh8+Qc1
	Jk4etcGhT2SPTqGIzOF2P52+B5v4DOdm/tjxUs8Yb8MLbNyhtTFijZNbqDO1HZln
	BGv5ghywZgzbP3fJetTKMQ/eP/sewMF4XcBXKY9/GYsoZqvd41UH/RFs7NFXV/ro
	53sm9FbkXvCVTK7nDwsaTZdg3LjIx4G11kdd8v6SpQeqQSvCyKoUroOIH0V57j4Q
	AqL0jF3FvmaYncuVT1l+sg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789031695; x=
	1789118095; bh=WmyYGlLJ4HV+ah11VEaf5EpA13EGUApuca9HZd1EWRI=; b=r
	isyzqbT64YUC05GbjC/zSRHAhLC6c0NiSGKUQBBkqqw6VtVZfdfMORnhAumBTyUX
	kao/F0zZsj8uLT/AQjX+1BlUSBIV19eNfFmH58nANK2lGx9kKIwLvLSgNcxtVgEL
	kFK1it6j1PyooMNCK8s3ZOTNjgqdanNtK3TlC88ct2qujOoPtDhBxBd+UU4ZE0Dz
	k4VjBjR2N4Tf9s3QhBP29iu23KlXReBspnf4Cu7RGtYaH4BnzLZ+11zZw7wE+b4T
	ILXcG2xV3fY0XpidQGdjXzCT947KFtpfO7qZF5Tv+j1S9gh8ekMji/mXIE1il7b5
	NowIKj8cv+JQS9iiCBcgg==
X-ME-Sender: <xms:CXWiamAbJlFcbMlKyo_HhkUQT6XRDKcjKn_Ayqptdmv6M5zeLkXyWA>
    <xme:CXWiarW74CEVCs48t3iKAdxXtTH3yt_IyIPuV9oU0GZoUu0uWxKy0k9ym2e7iFVJ8
    CpoFkon07hGGL-JJsjUbRtzZuNW4x_AQKvOC0Nv4KqQMAGjLDveDz4>
X-ME-Proxy-Cause: dmFkZTFUOKlcU60ThRN8O2zTSnwr5YCeqBhIzIYzfk5A0CrNKVififq7g0N7UP/8cRF8tW
    yarKG/7vyzEil6c5ClBf7vc9houwglmD3QffSxML4twCsP1Wj3Chea8ZVXu2fN+HOdSIbj
    uk0mqe2Nn53TZ8YnP8qnFHW3hMWW+0ufmB7zU99oUSU0+XXr3PnldZT2U82XFn2aAMr3ze
    hbhY19WEqXPTMwYvN4KbvZ0hFmZNlB56E0L+U2Fg40hN2UymczLx7ApUMA57Mu+LQaojNX
    sl7k3Dt/DyNSP/owSMjlMyx3v0vA568rICZhwCC7pkGMofmLt7T7moI3UowUAvJDNumglm
    C/MFAeVSUQ6A7ekRZqQiyc44M0ZEYq+4cDmiMugkFXxpgpr5OlzmyU70YkMZSgYUNb65lH
    AzjHmGhoamB2m5cgFBP9m+P50cX8OoBalBioGTTYaOFw3V4E6l4VwL05UuBVMZxaOrAP0C
    bqI47ngIDqZkpzJQnBWSqsXEeJL9klDu00x/INOwM+3+3eovl0RDyrj3HLKl0plcQERkmx
    kG02P/9DYGSDIKuDAv5vlhgzi9s+QoWOQORA+2naJPZkB6Mb30TayqqtwVBE5m1bIipkMS
    ggB2WRsbwLE02NUYIHCym0P05mdjYB92Y6yOrusFGbcwaMgc/1WBkO5GhBpg
X-ME-Proxy: <xmx:C3WiajSzkXT9br1hiKL81uZmz4pDFtgyt73BBeusKbH1VGrCPDFDNw>
    <xmx:DHWiarSkZzouTDTSO-KH5mVuc9R_lE4gS7N9fYnX9TfilKvQtxDN1g>
    <xmx:DHWiam3j9IKfyuCCLbBvIMAfRF6NFAYEB4nMRJblwE7Je12l_4YXig>
    <xmx:DHWialwPvwIeve1-y-XsO3shQboP-Dbi5sLE0IFcWq3pW3UzX25Ukg>
    <xmx:D3WiauXQT2K6VWx_Zlqpk0Vl6dMq5AApJoMNI55TBVliJtNGpSMBAILN>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id C941632A007B; Thu, 10 Sep 2026 05:14:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ATaKlDvsEa83
Date: Thu, 10 Sep 2026 11:14:28 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Karl Mehltretter" <kmehltretter@gmail.com>,
 "Russell King" <linux@armlinux.org.uk>
Cc: "Hans Ulli Kroll" <ulli.kroll@googlemail.com>,
 "Robin Murphy" <robin.murphy@arm.com>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>,
 "Will Deacon" <will@kernel.org>, "Christoph Hellwig" <hch@lst.de>,
 "Ard Biesheuvel" <ardb@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 "Linus Walleij" <linusw@kernel.org>
Message-Id: <2ea28a17-f36f-4dfb-8e2a-375e7a3a4d6b@app.fastmail.com>
In-Reply-To: <20260910063620.17768-1-kmehltretter@gmail.com>
References: <20260910063620.17768-1-kmehltretter@gmail.com>
Subject: Re: [PATCH 0/2] ARM: preserve DMA_FROM_DEVICE buffer contents
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, Sep 10, 2026, at 08:36, Karl Mehltretter wrote:
> This series prevents a DMA_FROM_DEVICE map from discarding CPU-written
> buffer contents on non-coherent 32-bit ARM. It is based on
> v7.3-rc1-324-g986c24e0fe44.
>
> ARM currently invalidates these buffers before the device writes them.
> If the device writes only part of a buffer, discarded dirty cache lines
> can expose older memory contents in the untouched bytes. A stock USB
> webcam demonstrated this through usbfs. Short isochronous packets left
> gaps, and usbfs returned non-zero data to userspace from bytes it had
> cleared.
>
> arm64 changed this handoff from invalidate to clean in 2022 with commit
> c50f11c6196f ("arm64: mm: Don't invalidate FROM_DEVICE buffers at start
> of DMA transfer"). Arnd Bergmann's 2023 ARM32 cache-maintenance series
> left DMA_FROM_DEVICE preservation unresolved [1]. This series keeps the
> existing ownership hooks.

Hi Karl,

I think the main problem here is that we remain inconsistent about the
rules across CPU architectures, and changing Arm on its own does not
mean we have a solution if another architecture decides to change it
in the opposite direction at some point.

I see this as a tradeoff that can go either way:

- the current 32-bit Arm approach (also arc, hexagon, microblaze, mips,
  nios2, openrisc, powerpc32, sh) is obviously faster as it avoids
  the writeback, but it relies on device drivers to ensure no stale
  data can leak back into userspace.

- Will's patch changed arm64 (later copied into riscv) to avoid that
  risk by adding the overhead out of caution, and avoid having to
  audit and fix all drivers.

Clearly the current state is suboptimal, as most drivers are shared
across architectures and should expect a clear interface. Portable
drivers now get extra overhead on arm64/riscv for doing both the
zero-pad and writeback.

If we decide to align with arm64/riscv and take your series, I think
we need two more parts:

- actually measure the performance overhead: you already did the
  work to test this on three separate arm implementations but did
  not share performance numbers.
  Can you quantify how much this costs us on the hardware you used?

- change the remaining architectures the same way: right now, both
  variants are common enough across supported embedded systems
  on all architectures, but changing over arm32 means that all
  only a vanishingly small set of users gets the invalidate-only
  version and we're much more likely to miss future driver bugs
  when driver writes assume the arm/riscv behavior is universal.

       Arnd
