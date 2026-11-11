Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.117.254.33
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398083;
	b=ixYGHNGFLcyipRgbjZyRcJ9lW8quPXDV0KO/R5QTaDdD/rdp/khoNOzhp4WLNUkYwwRN
	 sw6/HcfGLqNnyHaYQIG//E7W1Fxbk+DX+4QpP067dak+rKANYNs9qSeGkx830hyiq1VWc
	 TBOSFelzzXPBCXzeoRImOQfYF2nVw66XAaJwOUCxREq01/ZICfOHbRU5DOugQAR43y04l
	 ChIKJx3PIebmyB5UiH3t+GARrUkP3EXnXE4bVxG/ze86+Ez2hNFhUkIkbeiaG3+6G7zBP
	 ZKW0MRC8igVCAwbJ4r41WiTCwRJc1TY3VSekywMnzB6Zr2ptKHHIHVd3BkXQs4CRj8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398083;
	h=DMARC-Filter:DKIM-Signature:Received:Received:X-UD-Smtp-Session:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=bk/xtUL0TQa1hkGHi57+F0vnkupo2qPX6iYJ2SnqDe4=;
	b=GLsjIxpCMHaHa9DNniINFRKYxlpaMJ50NQCRLF3Na9juF6dxFze9FC/G4MA2lWYm0ZU/
	 nrlVkmyy0KNLjGi78aCGi7YLOx43M11PRLkBr6HxBFvfMSEy2lMElggWZTkgeoZdIYypi
	 IjDPFJKiVBZDAkyeSURzsgbnNNIVi1fOQWd8hhjIYJ+sCOB3K/rA2FnRGK9hImia1wuy6
	 tN6KeFJ++L6hOiKIq2M96F5+kcOxm7WLYaFwslrbUOYkBe9sc/I7llnYEM3XRIlIs0td2
	 yB6CwtYJMV65pMWu5O1VgCrS5uy7fTlqThpo5QLJ4vGMswIn1sEB5x9SU9NMySAtAyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sang-engineering.com;
	spf=pass smtp.mailfrom=sang-engineering.com;
	dkim=pass header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=khnIYuOL;
	arc=none smtp.remote-ip=194.117.254.33
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48064606A33C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:54:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 48064606A33C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sang-engineering.com header.i=@sang-engineering.com header.a=rsa-sha256 header.s=k1 header.b=khnIYuOL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=date:from:to:cc:subject:message-id
	:references:mime-version:content-type:in-reply-to; s=k1; bh=bk/x
	tUL0TQa1hkGHi57+F0vnkupo2qPX6iYJ2SnqDe4=; b=khnIYuOLGFscxVwD2A2f
	Pikm3TGugPqReJTjPxxakdZ/vMxwRm0e24O3jzg+Y8IVMJUuZ9otGGzPmDn0xgDi
	ZWXNJ717x9IHhh7F2v4qAdVKxcH5h3w0ZFUNfXyWy/CcxhwaQB3LGg43rAnnP8zW
	bPHP88yr5UK7bDYDTSAKCh799LNYkKbrPd9vvZXGnbFKs24j441Ri0al+ZLjA60H
	sd4JKKk8LIGr/5hFNrzdNrJukUUgUFaLHXI1sNFsOcC0erynx/Q6paPZSsJEb18z
	nqy1MN+/IFAla5ELrJFgwRVi//R+D1TalBrTke2mVpsasBtT/wiMnPP5Fu8zpJmB
	9A==
Received: (qmail 598728 invoked from network); 11 Nov 2026 12:54:40 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 11 Nov 2026 12:54:40 +0100
X-UD-Smtp-Session: l3s3148p1@Mi0k3P5f8Lsujnun
Date: Wed, 11 Nov 2026 12:54:39 +0100
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: BeaCox <0xbeac@gmail.com>
Cc: Ulf Hansson <ulfh@kernel.org>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH] mmc: tmio: disable dma_issue work before releasing
 DMA
Message-ID: <avRXf6SJuXxslsbx@ninjato>
References: <20261101063739.89331-1-0xbeac@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261101063739.89331-1-0xbeac@gmail.com>

On Sun, Nov 01, 2026 at 02:37:39PM +0800, BeaCox wrote:
> tmio_mmc_host_remove() drains done and delayed_reset_work, but leaves
> dma_issue pending or running when it releases the DMA resources. Its
> backend callback accesses the host, controller registers and DMA state.
> 
> Disable dma_issue synchronously before releasing DMA. This also rejects
> late queue attempts from an interrupt handler that is still running;
> cancel_work_sync() alone does not provide that guarantee.
> 
> Some DMA backends fall back to PIO before initializing dma_issue. Move
> their work initialization ahead of the fallible setup so the work is
> always initialized when a DMA backend is present. Skip the disable call
> when no DMA backend is configured.
> 
> The analysis, patch and validation were assisted by OpenAI Codex.
> 
> Fixes: 85683fb39d9b ("mmc: sdhi: Convert from tasklet to BH workqueue")
> Cc: stable@vger.kernel.org
> Signed-off-by: BeaCox <0xbeac@gmail.com>

Real name, please.

