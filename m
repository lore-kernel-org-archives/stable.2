Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793221582;
	b=inj9Jx5RSEDSDULbcLzmQA0Qzgtn16fjFvc+E0r3a+ya6ZUgtWpD31xVjaf23SOz1J7j
	 oweFQ8zxE9ch1+9I2F/qpim+onzgf1+BSGHSGApphEgGBHTcL0DcqOJ1LWx/lLyXRXqq+
	 2qCNVy7CK8NAur2L5xb5fjNuJ9Y2IH7nPE/FobaHaelTvnAeJpNHaeIg0z777Sg04ICtX
	 AUESTtmb9NrUWFymMJJnW9mu1CwbW7n8Is2QVDFMZmuwE0x75bgBFszVppK2OAPDHn7ev
	 Y2zq0q/rM14okO1MTi8uOUaQzVrjiQnVJjbdceHHZVzUOsUuHJviFhFQUmhDkdXRBXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793221582;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
	bh=1U4kkjWGgsDvjjFH6rA1YeOtK+lamjZuaWRgy38Z+iY=;
	b=xsKnDdOF6DY8bPNPK0U/YoRG7Udhh/v5Mx/BGRF7rpNQ+TuAzokKxMbV3VvOKX8WwLer
	 NvqFu70AooF89NeQlzcUhEeEe+xV/Yg+XC+M0zuy1YQUECuXfPmc7TjLDQzA0aA5yxWsL
	 Z1duQgfHjZeJQ0w6PKLoS5ZRoyPOFeHJ5ReLg79w32PRD9W6dgzHXaeknN4+IEwn5N3aP
	 T3iVNBKanIwnK42x5jo9hnpwwfAGdXH3k5SdE0pHTOgU5s97kgouSJZIOcXvTKd9jHh1A
	 7FlS61ELvkhSOSmemtEXNSTAItLIy3OH461m2YK5BoOk2gQiGlHMmdLbh2bezMBf5AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=zfhRCywQ;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746F2606A31D;
	Wed, 28 Oct 2026 21:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 746F2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=zfhRCywQ
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id 5555814C2D6;
	Wed, 28 Oct 2026 22:06:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1793221579;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1U4kkjWGgsDvjjFH6rA1YeOtK+lamjZuaWRgy38Z+iY=;
	b=zfhRCywQm397mApgZmVGmGOur7Ab9RM9b73cQf81jpGS2JpQ0H7LFelfeZ4xziGR9tqxHP
	eDS26RIkkmvE5T86bUJaddC82b3ABEnmrM1VyXQ/stLD7xs/vOBRRa/dm9zBWVUC2tr8my
	69fePCmEK4ZpsJgOSjtVQy1vFbroO359N4t166tnP2k9lb+Z0gijXGRWaNHCqGcH2FVznb
	viEeBDt5KuHOjXWo+po/nipEwiduyWk8qXen61oyTtfudYvFmKw09Enfx6fGT11LpMSKRk
	jv9h3nVBT5IqkNsJsGiM4RZS5TtLF03h2KjdPG3RKk14e2JPPFFhaC4fIMQG9w==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 370ff9f9;
	Wed, 28 Oct 2026 21:06:13 +0000 (UTC)
Date: Thu, 29 Oct 2026 06:05:58 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Juergen Gross <jgross@suse.com>
Cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>, v9fs@lists.linux.dev,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
	Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
	Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>,
	Stefano Stabellini <sstabellini@kernel.org>
Subject: Re: [PATCH] 9p/xen: drain response work after unbinding IRQ
Message-ID: <auJjtiJbYfZnVxbC@codewreck.org>
References: <20260609155202.1706-1-zhaoyz24@mails.tsinghua.edu.cn>
 <aqagvTnrIOGl8nfi@codewreck.org>
 <4d97500e-a489-4e64-aa11-29c3430909f3@suse.com>
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
In-Reply-To: <4d97500e-a489-4e64-aa11-29c3430909f3@suse.com>

Juergen Gross wrote on Thu, Oct 08, 2026 at 12:42:21PM +0200:
> > This one makes sense to me and I've picked it up, but I think
> > "9p/xen: fix use-after-free in p9_xen_request"[1] adding a refcount to
> > the front_priv is too much complexity vs. my understanding of the
> > current threat model -- I can pick it up if someome who understands xen
> > better than me has a proper look.
> > 
> > Stefano or Jürgen if you care / have time?
> > 
> > [1] https://lore.kernel.org/r/20260529103416.81378-1-zhaoyz24@mails.tsinghua.edu.cn
> 
> I think [1] should be taken.
> 
> We try to harden frontends against potentially malicious backends running
> in a driver domain. Such a backend could cause the device to be removed on
> the frontend side, so the attack vector is present.
> 
> The only reason this doesn't qualify as a Xen security issue is that the
> 9pfs frontend hasn't been yet declared to be security supported regarding
> attacks by the backend. Hopefully we will get there.

As said above I'm happy to take it under the condition that someone who
can validate the patch has a proper look; I don't have much time for 9p
right now and my setup doesn't include any test for xen so I'd rather be
cautious

Thanks,
-- 
Dominique Martinet | Asmadeus
