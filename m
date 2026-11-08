Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794156090;
	b=MK/Vf2WS6CmSYoHfP3rvc5tNe4f8nFeBOXNYTYCUCQG14WJxsVys1GCTRSc9/f0BwDkz
	 1jTrIM5A2FeFPEPMF+oYFXepk1Vk79R6BqWCCa1kT8HDKITz0BOcRwSyRu/It8XGwj+8i
	 TzH6h9VyjOPTLb26BujGCE8JhYS/K7CPRnG7dQ2x+k1KTOsXJ6ZXKDp2UP92aFxSfixmY
	 VT6xdIF+ZXiCR9Yi5Ll0EtuoQOGk3xWo0rbKYWW1KknoY6ShQKAP2iJfcNHrVSEqyV20b
	 CngBwSKlm4mepErQBI13h18E0iLXGxD0ac5vP7kJdHIX98/KDVrgxgiusjBkYWFs8og==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794156090;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=8p+obOcVF1fdDuK870AAimcBnbfvG6nq6EVBwa7vwpE=;
	b=hsUVXsqzDT3qLHa8lcmGh0yHGvTxKyoRlL7mdxiKrsiKq30lS/N5OO56UH9AkcY0F4a2
	 XktpPuFWcHrTKcXIxk802wkEcDYzB31n8hDeCbklQj0xlotrX4J0ceU5AG5JWZ9Hub2Yt
	 SLyhK1ERosBLt8O06T5mTNTQDztSaon1IsniMv1imbwt+74CtOTDggLQ8BvRsTcf/2+tO
	 ihWqssnwqjVw7jaJ0sVfOMbLufoCqvrzMLD1RxZtmtZtvOk0ldHskGd7LYGHIDtpeyeLs
	 lQfQMMBQPWvL1MJ255v2LT5HVXgmYI1t/76O3lSUB56IRgGwXDvspCZTSf0gvs9Ggqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmeKHKff;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480FA606A31C;
	Sun,  8 Nov 2026 16:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmeKHKff
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B3C51F0089F;
	Sun,  8 Nov 2026 16:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794156089;
	bh=8p+obOcVF1fdDuK870AAimcBnbfvG6nq6EVBwa7vwpE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=PmeKHKffv8q4Zx7AbyKAMg8R881khg2B56jHAEG2yv8cG5iWtOCO5UhM8BzZxuz8/
	 yOsdeN1a7kdXbDWprIihCi0iybtAIyopucl4IDqqrQYvw1BiMeiVf6o7k3p14JwFIl
	 SeuYbj6dGwQdaiUEaJcgEgYNACOSrVQbkG6lyf+J6SVTT3NJBqx9JZTTzp4i3kw8jc
	 TDe//jAVVN3qbkv0LfADetn4Qa7mumYD1NFmuO2yxqO+oTSe62LzMwfvIxIzGrpVtk
	 epMxKmg0Mh8goOsByD9jzOgawShilE7NDEOcmulZGwoqw/FT/TooNSEGtpdHUcFRlY
	 jp83omNu9K9Kw==
Date: Sun, 8 Nov 2026 16:41:26 +0000
From: Simon Horman <horms@kernel.org>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <jeremy.jean@oss.cyber.gouv.fr>
Cc: netdev-bot+sinfo@kernel.org,
	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: qualcomm: rmnet: fix TX aggregation teardown
 race
Message-ID: <20261108164126.GF18859@horms.kernel.org>
References: <20261101233427.2050688-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <179357635158.3286.10001576876397197758@kernel.org>
 <20261108150339.GC18859@horms.kernel.org>
 <05a24913bdea1ce4482cace6d9772564@oss.cyber.gouv.fr>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <05a24913bdea1ce4482cace6d9772564@oss.cyber.gouv.fr>

On Sun, Nov 08, 2026 at 04:18:25PM +0100, Jérémy Jean wrote:
> On 2026-11-08 16:03, Simon Horman wrote:
> > On Sun, Nov 01, 2026 at 11:39:11PM +0000, netdev-bot+sinfo@kernel.org
> > wrote:
> > > Hi!
> > > 
> > > This is an automated message. This series looks like a fix, but its
> > > commit messages seem to be missing some information:
> > > 
> > >  - How the issue was discovered, e.g. hit in production, hit during
> > >    development, syzbot report, manual code inspection, LLM or static
> > >    analysis tool scan.
> > > 
> > >  - Whether the issue was actually triggered, or is only theoretical
> > >    (e.g. found by code inspection). If it was triggered please include
> > >    the symptoms, like the stack trace or error messages.
> > > 
> > >  - What hardware the change was tested on. For driver fixes please
> > >    mention the device (and if relevant firmware version) used for
> > >    testing, or say that the change was not tested on real hardware.
> > > 
> > > Please do not repost the series just to address the above. Instead,
> > > reply to this email with the missing information, so that reviewers
> > > can take it into account. If the series needs another revision for
> > > other reasons, please include the information in the commit messages
> > > then.
> > > 
> > > The evaluation is done by an LLM so it may be wrong, if you think
> > > that is the case please reply and explain.
> > 
> > Hi Jérémy,
> > 
> > As per similar requests for other patches, I would appreciate it if you
> > could take a moment to respond to the questions posed by the bot above.
> 
> * The bug was found by LLM-assisted code review.
> * The bug was triggered by a software reproducer with a KASAN enabled
>   kernel under QEMU VM.
> * It has not been tested on real hardware.

Thanks for the update Jérémy, much appreciated.

Reviewed-by: Simon Horman <horms@kernel.org>

