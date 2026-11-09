Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.70.190.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794227723;
	b=fzxkdAbooPKxrmGILJYmT6Xh0ESfD3jVVnOPag58UXBMM0J/UpNAJWKJ2hhqV6ktlStC
	 c8CcKETRP3yseDnC56hsHX5kq+SrdI28wg3MJUTo2qo+8lPbdzcg3CvnRAA1X9uCTbYSE
	 CC94Bs6q5LJpAawfEehyKGaMbSScC5rS9Pa+/I0oeS8GxjLLz3HPfZpNReH7v54IJc/59
	 PidWLhQ4QLPWQXxiRXOZPGgAnZL82SNgi0TOlYmnIUdP+9wstBymIr4bb7yfbzu5SkmqC
	 3N/BKrxoIeVBcrvPLtn38HVYBs+PlGyKOQlLC6Cj/6hFt0YB2Cf5LWsVQk9NgnGjL/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794227723;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Status:X-Spam-Checker-Version;
	bh=oxHdGlhi4cZ/jhlBUDoZrZFRSMU9x1K2uotAGDmaO5c=;
	b=eopmXTpofGSrZmHo7eeExjdce5eiWheMp5VZIcmhoYeblutgjxLbwo2wURJ+19j33u0l
	 BzAQbG1payXn1BgyzmaejT/VArQ9kN/gdF4oJT7eijn+P7EGq+NpHuh909Pfg3Q9KhGA9
	 MwfADYFaGZBSdZVGqOqLjma7LnZsx9JT7OMzKSALnjiOYFxOzbR01BhUszYDjBzIE3YyQ
	 EVjQ4jr6oRTF7GkYHzN18fmDBr9yjH/c/YkB61tQ72amqQ0HWK6eNIuCNn3wxNz9ZPwlV
	 1BBeKWm8TuDQ7ajZdEaoi76yGhutQia8jnTFJg3QV+guSWInBKbkNKH4pquxC0oS5bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=netfilter.org;
	spf=pass smtp.mailfrom=netfilter.org;
	dkim=pass header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=eROZzNMA;
	arc=none smtp.remote-ip=217.70.190.124
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 59E75606A322
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 12:35:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59E75606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.a=rsa-sha256 header.s=2025 header.b=eROZzNMA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1794227720;
	bh=oxHdGlhi4cZ/jhlBUDoZrZFRSMU9x1K2uotAGDmaO5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eROZzNMAly+9Uq3U7zSS6oaIQXNOSLfvd50OshK+DNA5z3tTPNejgt5XNzODXW3pd
	 CherxxeTaASHt5ojxfrhfC8KPaSuEO+td5MUV7Zhdh7lszvSoap1zjedsd7m1Z+Lgo
	 zxx41Qt59zMZFGsH8qfar+fDV9Xz5otwiqVeN30zAjWuSb2XdFMWVwmN/6mx6rpy7j
	 LomOWrE9cW2RrhvbkZxuDA9jHKd+EQaVBqSUiCNVORN+IAYPAWeY09E2Qvy717P88g
	 FSBToUMM9uDXBpfH33cSK6HHkx8v150kjSDe6rFJjTVLVylYw6oSYVl4kCxQ8l0CxQ
	 M8agnCQvMIzzw==
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id A697560058;
	Mon,  9 Nov 2026 13:35:20 +0100 (CET)
Date: Mon, 9 Nov 2026 13:35:17 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Abdifatah Suruur <suruurism@gmail.com>
Cc: stable@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.18.y 1/2] Revert "netfilter: nft_byteorder: remove
 multi-register support"
Message-ID: <avG-BZ1c3lcjyZuG@chamomile>
References: <179422702104.5131.8115555421206983838@gmail.com>
 <179422702651.5131.4174988605567778384@gmail.com>
 <avG71wG3PHvRQT0B@chamomile>
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
In-Reply-To: <avG71wG3PHvRQT0B@chamomile>

On Mon, Nov 09, 2026 at 01:26:02PM +0100, Pablo Neira Ayuso wrote:
> On Mon, Nov 09, 2026 at 03:23:46PM +0300, Abdifatah Suruur wrote:
> > This reverts commit dc29c0478b8564feb9371e715b5a0016eb8903fd.
> > 
> > The upstream change removes multi-register byteorder support and is
> > tagged stable+noautosel because nftables versions before 1.1.0 can
> > generate length/size combinations that the removal rejects.  Backporting
> > it to stable can make existing rulesets fail to load.
> 
> Same thing here, if this can break stuff, this cannot be taken as is.

Apologies, please, withdraw this comment I made.
