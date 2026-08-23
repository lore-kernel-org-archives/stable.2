Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C539184C
	for <stable@vger.kernel.org>; Sun, 23 Aug 2026 16:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787501451; cv=none; b=XQmuXOUtkW2XZXHnYbNqz+7BJi6kjJYwxJZNH7EZWbhu9X5/1Qze9s7YsbNensT8V9LsFFFdVknwtW6TQV3kREdaF6RCdeRxMHn8eacPP54UIFnhKzk0BWGL6o2P6xwQhFtJPNzDnr2m+Pt9AgsYV7D8CeQoqCn4w3abG4tMSHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787501451; c=relaxed/simple;
	bh=lbWmABHhb9TMAF2Ok/ofP++jFSdI06DXNKBawGkc4oQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dRAGGS3kYxOgMHcLORoo7M47gIox0937SpdHXNvp5SSKKMepZfAiLNzlECGJ2m1J6iUAsydcf9mM/YGO5Cblr+R8yVk18LlY9DUX1k0SYk9A7ex9Z37vxPwVZNi9YP9PxxKOFSENeFEFugDAsxan0sHFeLCOg+D8HQvjIxUeWD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FRcZ+hnZ; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FRcZ+hnZ"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c1c50c1e29bso424440666b.3
        for <stable@vger.kernel.org>; Sun, 23 Aug 2026 09:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787501445; x=1788106245; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TyORu0icZu5goeOAIcax6J1V8GVbm7LatmMPeHFdvPo=;
        b=FRcZ+hnZ4/1kTvqEa88jiV6ORlMHUDNUZTbLqRBOPi+Jmhq/AyjEM46tVwslbc4VkF
         guL0yj+I+9bJiG+QHaRQ9dod5Rrw0mcmavwh6NLr7Nb1YIcVOBV/x1Fh3sibEitC7u87
         m/EIPT14VffQDEUGyCzlqjdeqxCdW45yG5iJWp3NPnyJL16GhZRTpZuymZ3d3OgEHpeC
         2CnLg+Ip9etcSSGHesbGUWBI1KGnPtdT8AC2a7LTNbDXzrv25vNkUtDRs6gMrqsKDZ3R
         x+nPrkfM1FpGuho4ZN2Pfh4+qhbqrsu5fuIGf/8qh2cBS7VtvwNU15/Jv6wF4/06W3UW
         Fmnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787501445; x=1788106245;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TyORu0icZu5goeOAIcax6J1V8GVbm7LatmMPeHFdvPo=;
        b=iY6gYnM/OcTetcR2TEapo0E6Dzssnd9NUTcLj2AAJqJ3NUPdxong1ZR1P3fxEncxcO
         Ys01llMm1bMVL9RnWqFGN/XQHjb3SDtdQYViPFDAfDyA0MW6SHbTTmVbCvfqqYNt/bC6
         d6SdLXosuIarlMw/EcsGWL+5qaGbFvPvn4GPrLs4Q24n0JoRa/MCTO40889+JerT7wNe
         tftG5jG68zv1uR+rUHnMgn4cHDz9JkmGm4VhftUe9T/KrH9pXkU/4Y/fntngvno98xNq
         hEb+JalAUmhwdlB6/CYFcIWWueTRFpcH2/xnLBf3Z6j1m47+KeiWwASWjW/cummLxrfh
         vI5w==
X-Forwarded-Encrypted: i=1; AHgh+RrBIHEofKCjEqSlcOPzXfHRaTuwglEvYtzi30i+tY2xovrXx74m6kEFtTM3/Bp3F8FQD6qURUk=@vger.kernel.org
X-Gm-Message-State: AFuF++kfQC3duWkyay7rDg8qOzYk020lzusdFnBXWTk1XnnbpCskWGXH
	3g2A+ol+4ns23RqE9m3WMuFYfActbB4XuGu5Yd/RpcIW3ImQ9MNk1CL1
X-Gm-Gg: AR+sD12M8zYGJALEaEp4F9fOvOs/eIdtzxUVzuKjG1Vrj+HdelZIL3iK/OcLluXraih
	+axIHcgE8Dr18SIWyvHnNSPQGcvwX+Rccetiud9sXmQ2RZUEs2Xc7krxK0l3ZpSpMqBom7v6SQH
	mkdmSM9Vk5vH477ec/MkXg0IDgQAopkZ7ej7ati1nwmeGNksdUfFHmbmf2/FKQWcNZ1ctbKpmwx
	ODNvcZxzRA23PC7NJhiUyodlkDdzzXf8bkQDR5cq/ZlCVnhJ0QT0cA6lCnG7HKSaGT43lpg0kzh
	JlLLwaTOW69wWF9998Qwh36qCtU+GlqTzWET3I5kX62ASkK0/99NH+SHur8fx7Yp6DIJr03GNiu
	kXCmXV0ZkSWNUYlax/+x9fPyEvsqkdP7TKaffkgYRMOAqbNyosRC4Kt9GGi4aLR1xOMzwFhQlzK
	bZ13iqJg4q/eeTCUDsibY8JEY7rq9vcInmHi1JN1f6TC6+K18L9kNV0iGbrvhLwCvhhjk=
X-Received: by 2002:a17:906:ba97:b0:c12:9b98:209e with SMTP id a640c23a62f3a-c246a692891mr2208059466b.23.1787501444843;
        Sun, 23 Aug 2026 09:10:44 -0700 (PDT)
Received: from foxbook (bfk5.neoplus.adsl.tpnet.pl. [83.28.48.5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2496738e7esm921183566b.46.2026.08.23.09.10.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 23 Aug 2026 09:10:44 -0700 (PDT)
Date: Sun, 23 Aug 2026 18:10:41 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathieu Fluhr <mathieu.fluhr@gmail.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, Mathias Nyman
 <mathias.nyman@linux.intel.com>, linux-usb@vger.kernel.org,
 regressions@lists.linux.dev, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mario Limonciello
 <mario.limonciello@amd.com>, Forest <forestix@gaga.casa>, Slavik Dev
 <developer.slavik@gmail.com>
Subject: Re: [REGRESSION] 6.12.36+: usb: hub: post-resume delayed work
 triggers > uncorrected MCE / data fabric sync flood on Threadripper 7970X >
 (bisected to aec11e5f9c45)
Message-ID: <20260823181041.4eb74365.michal.pecio@gmail.com>
In-Reply-To: <CAPyJwA-eNSbVGV0uhy0-2w2_Gs0dWdOeJLRpBSLVO_a01-ZPxg@mail.gmail.com>
References: <CAPyJwA_D9qw0T72f8zwM1yKjP+To=maVANbcdsWM7yRmbBxYvw@mail.gmail.com>
	<CAPyJwA9R=p8_uxyYODb00g_nUq26SRsWHBGgAAJnR0YMTRRo4A@mail.gmail.com>
	<CAPyJwA9P48LDcOr7u_iT1WPFBCHxh9w6cxFvyi5GS3syM6crbQ@mail.gmail.com>
	<07435e6b-ee30-4c85-8c8b-0ce3a4ead1d9@leemhuis.info>
	<CAPyJwA-eNSbVGV0uhy0-2w2_Gs0dWdOeJLRpBSLVO_a01-ZPxg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 23 Aug 2026 13:44:53 +0200, Mathieu Fluhr wrote:
> Yes, looking at the reports, this looks definitely related.
> What is happening when the emulator starts is that it also starts adbd
> if not running on the Linux side, to communicate with the emulator
> later on.
> 
> [...]
>
> Ok, here you lost me a little: Looking to all the links provided, yes,
> this looks very similar to what I am experiencing. But (and correct me
> if I am wrong)
> 1. reverting the "bad commit" is not really an option, since it was
> originally authored for a specific purpose (other than annoying AMD
> owners :)

It does seem so, even if the specific issue report isn't known.

It also isn't clear (at least to me) whether the intended behavior of
the patch is causing this, or if the patch simply has some bug which
causes unintended side effects that can and should be fixed.

> 2. the patch that Mario proposed is very recent, and would address the
> issue not on the USB but on the PCI level?
> 
> Thanks again for the swift answer here and all the informative links!
> I must admit that I researched a lot debugging this issue, but I never
> thought about looking to the USB side of the problem, focusing more on
> the CPU side.

The issue is obviously a severe HW malfunction (you mentioned MCEs, the
Ryzen CPUs simply totally locked up), triggered by poking certain xHCI
controllers on the I/O die of these CPUs in some wrong way.

The minimum known trigger is this loop from bugzilla comment 8:

	while sleep .1 ; do true </dev/bus/usb/010/001 ; done

Opinions seem to vary on whether CPU load must be present or absent.

The minimum known workaround is disabling xHCI PCI function suspend,
see bugzilla comment 16. This knowledge has spread on distribution
forums and many users stopped caring about this bug, but clearly new
people are still running into it.

It seems USB devices and even the root hub can be suspended safely, as
long as the PCI function remains on full power. The influence of CPU
C-states was previously unknown. May be specific to Threadripper.

Regards,
Michal
