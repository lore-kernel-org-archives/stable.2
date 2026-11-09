Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.190.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227689;
	b=gnA/JVM59hh55IwmTFQ483rPBmtACZ4TLMaPX3lwYVSB9vAk2kQ6y9kIdCzWAZjEeuRe
	 ZmIL+FLPJkzEcSrtQkP5k7n5Q7NPvwRLDNZzjmFd4ChYRH6ZLDIcBx9bsL97WOJlP/DhY
	 MfKF4NXo6j/J46O6KSOwxWSsvFWq0TLdoSv5qgr7C29pw62O0hDAoxFxsasMG00jZM5jB
	 SJylJFG+Pp5d2JC0sDjtp2O06AbBstV7KsyjaflcttgFDE2v/93zN+FQ4i15rexY2x8iU
	 OekT59VoaI/Zd9ttf1FIUzU8KwCiYYv8sjcRb38TEUG0V/6bVI0FyQCdyPS751LwR0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227689;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=td1e4a4NYRjzlcoXNHPRcB5+Pke2f+Tg9BtofB06drE=;
	b=x3UeEGm7pU8E7K4muqgumqJEy3KeMaSrycIDIRRoZMM3dOH0TNdDPoMVCwKZEoIesQ9d
	 C1vV3NWr4OVn/7RuKKO6UEXvpi/CA8kERXoMVTHajm/VgeWoFcYRSunwxEGORsyUx0vWi
	 kjPeyltLMK/cFF/WKaoAJQJz+mOnqYdhsQglav1sPatBb8zC9Pm6BpWPGG+hpVAmLJYI4
	 cDZuXVwDd/XHzJwwCo0jE/019MvZPIXCMNbwozW3/rpD2sG/Vx2kGU6O+/+F11Py1VFRv
	 HX9nMEIHzLDgFLPmtlr+Khl7Gk4MNLsf4RcZ6Tv7yqeqHOSy/j2HIXYrwwhxTjnSPMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=netfilter.org;
	spf=pass smtp.mailfrom=netfilter.org;
	dkim=pass header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=Q1NHFNC2;
	arc=none smtp.remote-ip=217.70.190.124
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 316E1606A334
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 316E1606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=Q1NHFNC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1794227687;
	bh=td1e4a4NYRjzlcoXNHPRcB5+Pke2f+Tg9BtofB06drE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q1NHFNC20PK8M766Z/MQXVcGVcSQAFLYhOH7jFk0ocDpi3XEQlF9sMZYuyNsURPyl
	 Ol06bgWzzJ+5hzjjIL46SjYmObZHTcwPlYc+BdaF0HBFmSeLcqaMiTpsD34IS8MDlc
	 zo8b/W0j/EhzQaJWD6+IFrKpZNtdsJMciqfi07ckNmy19CViItPpwI+Pdu1fvUiaW4
	 XTIb9adygY9bjdxj4Ga+/E8PAK69lZ0jYadUNd3OVlyUcvbj5Zpwtv9vZpXc1Lg2o9
	 gl+Fgii1L/BaCpHOCSngXUnQ86Xokfmxe8JmBVIyc2vXMMeVYmgHgCx5+nWvGdneQH
	 i4PqkZ3YXQYxQ==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 0A53560058;
	Mon,  9 Nov 2026 13:34:47 +0100 (CET)
Date: Mon, 9 Nov 2026 13:34:44 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.12.y 1/2] Revert "netfilter: nft_byteorder: remove
 multi-register support"
Message-ID: <avG95PtnRweYD0KJ@chamomile>
References: <179422696909.5131.4005481731765358036@gmail.com>
 <179422697447.5131.3947908931395034167@gmail.com>
 <avG7oLUJ39PZCken@chamomile>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <avG7oLUJ39PZCken@chamomile>

On Mon, Nov 09, 2026 at 01:25:08PM +0100, Pablo Neira Ayuso wrote:
> Hi,
> 
> On Mon, Nov 09, 2026 at 03:22:54PM +0300, Abdifatah Suruur wrote:
> > This reverts commit 3c5fb3a6c8118d15e60295e76fb5b879021eef43.
> > 
> > The upstream change removes multi-register byteorder support and is
> > tagged stable+noautosel because nftables versions before 1.1.0 can
> > generate length/size combinations that the removal rejects.  Backporting
> > it to stable can make existing rulesets fail to load.
> 
> Yes, so why are you posting this as is?

Apologies, I got this all wrong.

I thought you wanted to pull in "netfilter: nft_byteorder: remove
 multi-register support" but this already slipped through -stable?

So your series look correct.

Sorry for the fuzz.
