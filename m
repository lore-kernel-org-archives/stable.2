Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F8C2DECA8;
	Fri,  7 Aug 2026 18:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786128786; cv=none; b=IWnB8qZf/p0WGIXK1GIPOounoWGohw9GdE5wsKemiqMy7DQ/QKsKQmAzSi/gN4GtY+B6JKo6iO0UCdfoCas5f6qDvEZacHJmsXbExs8PtysNXTPLJT6wD06poAM0NKePaQIm9334oK3JH2j6ukwEc7kVDVnroktwnxluH+A9QsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786128786; c=relaxed/simple;
	bh=ryJT95DzXsdd2uoqyzmsHAFOzQZfXhQBctnNe8VxD7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcL3QdLAxF0zCRIDNrTYY0QECee4QZotNO+bmXMtgeThuT05j5yPjroqotJPLBOf7MSp6DitqkNqA9tyss1DWGJspY9EYkviXfYCvdhFPTip5P5LuYyHeF019aC1W1OIcL22hCtUX27csriKpsVnGwLp2fBE626KpxNOBeNLLto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HbALYNT+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HbALYNT+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451691F000E9;
	Fri,  7 Aug 2026 18:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786128785;
	bh=RtE4Ffj2sOQDLMNirE1V0XAHKtAHOYS1QiMsPe57FSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HbALYNT+65gDDX5gHgWsLacTJ3iLwSX1KuPae5lUA/6j25rlkXHVMtIeUcwIvPoUa
	 Or2R+UQQFx2Zf5gWebXY88/gXpM7sfp4RX9dVbKRhqzQoHoDAPAfdKMjuw1t5UUKB5
	 X7BSqhWJYbMome6B53o0mTBljlMNShzz4Rqw0qTStnA9qPiO6iS5KBfrNBZ2eY1Yp6
	 8vTjmqsvR/+cERCADuo4u09npFPVb94Y67sgnFd77ZGEP6A2HW/nEhBY3OMgvUSlW4
	 0VzIh2ilfAe7pWcjHyt4GpvWFIY8n31X1yeC41nOimDcrY08NOKSbI+c2t2zuvP9vh
	 y4mAi+asSxxOw==
Date: Fri, 7 Aug 2026 11:52:59 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Akari Tsuyukusa <akkun11.open@gmail.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Russell King <linux@armlinux.org.uk>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Yingjoe Chen <yingjoe.chen@mediatek.com>,
	"moderated list:ARM SUB-ARCHITECTURES" <linux-arm-kernel@lists.infradead.org>,
	"open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
	"moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>,
	"open list:CLANG/LLVM BUILD SUPPORT:Keyword:b(?i:clang|llvm)b" <llvm@lists.linux.dev>,
	stable@vger.kernel.org, Ard Biesheuvel <ardb@google.com>
Subject: Re: [PATCH] arm: mediatek: fix secondary CPU boot on Thumb-2 kernels
 with Clang
Message-ID: <20260807185259.GA941196@ax162>
References: <20260722172443.534251-1-akkun11.open@gmail.com>
 <CAKwvOdnbPKoTy72EvfpKtT9Ne-r+O0j99KFX8OvjGk8ZxsuEGw@mail.gmail.com>
 <amHYO1c-5vzqSekt@buffalo-ssd>
 <ef007a23-46bd-41d6-83ff-264831341093@app.fastmail.com>
 <amWfjDyn0jrnIf63@buffalo-ssd>
 <c4e9a566-baf7-4df6-b874-30c68a5c67f6@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4e9a566-baf7-4df6-b874-30c68a5c67f6@app.fastmail.com>

On Sun, Jul 26, 2026 at 10:00:35PM +0200, Arnd Bergmann wrote:
> Working around it in the kernel is fine, but I'd prefer to wait for
> the fix to first get merged into llvm so we can reference the
> bugfix in the kernel commit.

This is now fixed in LLVM main:

  https://github.com/llvm/llvm-project/commit/261c025a03732ac6d3a26ad80e962481237de052

> A trivial workaround would be to have a dependency in
> CONFIG_THUMB2_KERNEL for !AS_IS_LLVM||CLANG_VERSION>=24
> (or whatever version), though fixing the .S code in all known
> instances is probably better if we want to ever have a chance
> to require IAS on all architectures.

I guess it is a question of how much maintenance will keeping up the .S
code take over time. Presumably this issue is not too common if we are
just now discovering it but maybe that is because CONFIG_THUMB2_KERNEL
is not too common? Is there a way to flag this at compile time? I don't
really have a strong opinion.

-- 
Cheers,
Nathan
