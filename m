Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 870253E1681
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 21:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785189505; cv=none; b=COpsaErh67qvDed11pjZcZ+buqJe1nAnCmj0QFRQ9KBej+0GbIZZSN8BhmIXQ5R3Ky7ihtgKVx+B8pjjCFq0R479xkYxRpaVzoJOQPuJpCtiHmEtqFmb5agXvrwTjjh+VNF5bm7rVrhKsBVHly8LgAlTiaYN00ZNuF56605ju6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785189505; c=relaxed/simple;
	bh=kESnsyOHbXakauxHwlH6Xh9Oz9wyeFG3JBgR1dyZ7lQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lTUoG1xE8tRCl0kONP5Jg6r62PCl/LPfsPibYC8IyCoWc3BTuo1cgN5OMyf3Bf1K6wJ59jGBkBPR8faDfEk9fF+Im6oATEURb8UtfH/+8efWu5FqfNqaNEM9FHX9Yz/4L4WLuwCXSU2+2KAWT+S6+ArX+VqO8LLdlQugjcpTqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=A7rpJQNX; arc=none smtp.client-ip=195.121.94.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="A7rpJQNX"
X-KPN-MessageId: 43e2a7fd-8a06-11f1-9e8e-005056999439
Received: from mta.kpnmail.nl (unknown [10.31.161.191])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 43e2a7fd-8a06-11f1-9e8e-005056999439;
	Mon, 27 Jul 2026 23:58:13 +0200 (CEST)
Received: from mtaoutbound.kpnmail.nl (unknown [10.128.135.190])
	by mta.kpnmail.nl (Halon) with ESMTP
	id 43e135c6-8a06-11f1-91ce-00505699891e;
	Mon, 27 Jul 2026 23:58:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:subject:message-id:to:from:date;
	bh=kbVWiCOnciwPOgW2IJVqPwmQd6+/KbTHtd51p0uPjE0=;
	b=A7rpJQNX3I4W3P2GahNM4wr6Ik4+icLwhtghF8CztQFEFNCkEGoLFYFrqTiXTt6N8udVR3+4T5RR0
	 QfPJeYvd/meHkK7s5JS0eydOfJMmUFzRB5iFA/l4E04uncxgzgxt/JHEwuuvqlIDyBeAm7Vbfgg4qA
	 sWEDxL2LeAYkITn7uxDCags1dp2a26aP8Qm9+4RaTMidE9uspK5r5m63V3n2+7MXJTf1PVUjBiAFKZ
	 fTCC9DMSxlaE5iRO/qUTUg+tT+19orZrJaLWnGn/E+bE5UgYRBKY22xIk8rtVRCRbgjdfcdv12Lh3B
	 74FOQa2T2TU/QOiJdIZzgOzjwZwrN3A==
X-KPN-MID: 33|PTEeDplm1cnWA906pLvPrZh4h4TH02u4wSAoZNiMJnaNdL/ZxEbkbc3H1W9cWmj
 NlCfSFpIN+hzcE5wj4eCxqyVXx0sOkEWQAw/KtPEIosk=
X-CMASSUN: 33|T4ywy3E8DjAslRqqFuSgjNDbFQ/cOjqB84OKTnQCEVM82lKDQlDEfkYLtQNBo49
 Y3VPikqJ0CSpEW7t/cexCWw==
X-KPN-VerifiedSender: Yes
Received: from cpxoxapps-mh08 (cpxoxapps-mh08.personalcloud.so.kpn.org [10.128.135.214])
	by mtaoutbound.kpnmail.nl (Halon) with ESMTPSA
	id 43cf5023-8a06-11f1-916a-005056995d6c;
	Mon, 27 Jul 2026 23:58:13 +0200 (CEST)
Date: Mon, 27 Jul 2026 23:58:13 +0200 (CEST)
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>, linux-mm@kvack.org,
	Farid Zakaria <farid.m.zakaria@gmail.com>, jannh@google.com,
	stable@vger.kernel.org
Message-ID: <1934849422.317115.1785189493726@kpc.webmail.kpnmail.nl>
In-Reply-To: <20260727-lauthals-peitschen-aufopfern-1bfd12376820@brauner>
References: <20260710-work-binfmt_misc-locking-v3-0-a162f7cb58d6@kernel.org>
 <20260710-work-binfmt_misc-locking-v3-3-a162f7cb58d6@kernel.org>
 <amTXwUK2FXu2sHI2@lt-jori.localdomain>
 <20260727-lauthals-peitschen-aufopfern-1bfd12376820@brauner>
Subject: Re: [PATCH v3 03/24] binfmt_misc: reject a flag character as the
 field delimiter
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal


> Op 27-07-2026 09:35 CEST schreef Christian Brauner <brauner@kernel.org>:
> 
>  
> On 2026-07-25 17:37 +0200, Jori Koolstra wrote:
> > On Fri, Jul 10, 2026 at 11:33:04AM +0200, Christian Brauner wrote:
> > > The registration string starts with a user chosen delimiter that
> > > separates the individual fields. So that the field parsers terminate
> > > even on a truncated string create_entry() pads the buffer with that
> > > same delimiter:
> > > 
> > > 	memset(buf + count, del, 8);
> > > 
> > > Most fields are scanned for the delimiter with strchr()/scanarg() and
> > > happily stop on the padding. The flags field is different: instead of
> > > scanning for the delimiter check_special_flags() consumes the flag
> > > characters 'P', 'O', 'C' and 'F' and stops at the first byte that is
> > > none of them, relying on the trailing delimiter to end the scan.
> > > 
> > > If the delimiter is itself a flag character the padding no longer acts
> > > as a terminator. The scan swallows all eight padding bytes and keeps
> > > reading past the end of the allocation until it hits a byte that is
> > > not a flag character. For example registering
> > > 
> > > 	PaPEPPxPPiP
> > > 
> > > with 'P' as the delimiter (name "a", type extension, magic "x",
> > > interpreter "i", empty flags) leaves the flag scan running off the end
> > > of the buffer. The registration is rejected in the end because the
> > > parser does not stop exactly at buf + count, but only after the out of
> > > bounds read has already happened. With an unlucky allocation layout the
> > > scan can walk into an unmapped page; under KASAN it is reported as a
> > > slab out of bounds read. binfmt_misc mounts are available to
> > > unprivileged users in a user namespace so the read is reachable without
> > > privileges.
> > > 
> > > Reject a delimiter that is one of the flag characters up front. Such a
> > > registration was always rejected anyway, only after the out of bounds
> > > read, so no valid registration string changes meaning.
> > 
> > 
> > Looks good, I see no user visible changes.
> > 
> > Can't we support a less arcane and impenetrable format, like JSON
> > or YAML?
> 
> Adding a json parser into the kernel is something I had played with but
> that has a bunch of very subtle pitfalls as the spec is underspecified
> in various ways. Also, having the kernel produce json is one thing.
> Having it _consume_ json is a whole other discussion. Ideally it would
> be done in Rust.

I might be interested in this, apart for the binfmt_misc stuff, this can
be also used in other places inside the kernel. And I would like to get
into Rust4Linux more. We could talk about it at Plumbers or MAINTAINER
SUMMIT (if I get an invite, but that's not too likely... :) )

Btw, could you CC me (if you think about it) for any of this binfmt_misc
stuff and the other such as failfs. I am very much interested and would
like to review more going forward. It's just been a bit of a slow process
as I am slowly picking up the pieces of VFS I am not familiar with yet.

Best,
Jori.
