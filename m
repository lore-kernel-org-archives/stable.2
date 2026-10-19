Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444615;
	b=5bex/JwYmb45VCnewVwbWIoIRLI3cWR6aBppivfaWdCxW4umRYwrrfBQBT/sgBombeMU
	 zznioMfwWAM+2Kul5b9Dj+OtIXfKoDrDxtI8OiDOVwzqwAv2+/6sMtdxWK8WdG8ts5drM
	 VhM1skeZFZSGxBjhpFyHW53Yy5tGARTkoV2Q5XY/wHZCgb+6KIwYU0F3SGeDaa16K+yn+
	 fXFtjU/vGa55w7vfbYHJwgpF10FPi8wuXu1P91CyW35Vsps55sYxmR+FD2mIB6fCIa60Q
	 prKC9maNUvHdeJzkia2Qeu4C70vgRv0DGim3mbPlo0lMMVxKMSe+mwqGlzUtlS9aozw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444615;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KSvVZT5VL1jajWhdlJW0RYEn8BnmHvXSXJY9pj46ymU=;
	b=U4wnw4nnKl4tkmerNmOKqL2Gzo+gWL0ftuo9WkDQJ5F+OHKPfM2YsOGUZM7Mo6bovChT
	 lENRWZwmbJsRpxsW/fZHQcktAVM7HgJOlM8D6ov5Nvv5mtIQHXp4JXclj5sU0UALcywQq
	 74UCkbeq68VnbqGmHH69sEsH44pG5jeA4r/its5IodggsDw439qP6425KmedCCnha7QhO
	 iSz1n7p4qcODae2pTg/aTuhViTe9rP0ZlJ5tHPjt80Yw/e0v6vZH8oMY9m9s51G+ZRMKv
	 I4bxfZdmC6aMiY4ECWRrt4N6+ynt47xLdvnCQ3imZ/npnORT7Aa8Xs4bSzrSJGXkQIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKyapir4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 76773606A331;
	Mon, 19 Oct 2026 21:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kKyapir4
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BFBF01F000C4;
	Mon, 19 Oct 2026 21:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792444615;
	bh=KSvVZT5VL1jajWhdlJW0RYEn8BnmHvXSXJY9pj46ymU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kKyapir4miVPKj4TmF0vBKOiEB39TZPZlYSw4O+Tg7HtDbojJ6MFoXdgm2dntQyTU
	 5NPGPhH4wNV5iXWSJDhvkHQEws8LKWcrZM6YxpVi/74OlHWZBPjIygl0m359PQ0H2C
	 5ghou0OozVI7vaO30WKd8N74TOSUQaOhzRqjQSYRkorSjY+hvTCVjUwAhPvBiJ5BT/
	 PSINHqPnSA/rxQT59RxXnEX7P2Txxl2KQ1SHQyKjJHVDNNO37DNN/x0m6R7LFafGiy
	 e3lhDpigUkipfCZQjp9wvHL0kZaWPmvguHr7TejRghJd1aRRssH/vN4xtxN47a1pnG
	 7c6EEBWVB230g==
Date: Tue, 20 Oct 2026 00:16:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] KEYS: Verify the key identity in __keyctl_unlink
Message-ID: <ataIwzGfUyiY1rSB@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-7-jarkko@kernel.org>
 <20261019193502.GF65095@quark>
 <ataGVmTZooWzJYMP@kernel.org>
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
In-Reply-To: <ataGVmTZooWzJYMP@kernel.org>

On Tue, Oct 20, 2026 at 12:06:30AM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 19, 2026 at 12:35:02PM -0700, Eric Biggers wrote:
> > On Mon, Oct 19, 2026 at 09:17:26PM +0300, Jarkko Sakkinen wrote:
> > > [PATCH v2 6/6] KEYS: Verify the key identity in __keyctl_unlink
> > 
> > There is no __keyctl_unlink.  Seems you mean __key_unlink_begin.
> 
> This is definitely my typo :-) I was looking at the implementation
> in other terminal while writing this and apparently lost focus.
> 
> > 
> > > Let's define the following preconditions:
> > > 
> > > - Two keys: A and B.
> > > - R is a keyring.
> > > - Both have the same type/description/domain.
> > > 
> > > Then:
> > > 
> > > 1. KEYCTL_LINK(A, R) => {A}
> > > 1. KEYCTL_LINK(B, R) => {B}
> > > 2. KEYCTL_UNLINK(A, R) => {}
> > 
> > Should be 1, 2, and 3?
> 
> I tried to describe the scenarion but apparently was not so successful.
> 
> I.e. unlinking A removes B given the match in attributes while you would
> expect getting -ENOENT and B retained. Or this is the idea.

Here's a little bit tweaked version of David's example:

#!/bin/sh

set -e

keyctl new_session >/dev/null
keyctl newring ring_a @s
keyctl newring ring_b @s
A=`keyctl add user A ss %:ring_a`
B=`keyctl add user A qq %:ring_b`
keyctl newring R @s
keyctl show
keyctl link $A %:R
keyctl link $B %:R
keyctl unlink $A %:R
keyctl show

What I get is:

77968717
178740336
781765689
Session Keyring
 952124334 --alswrv      0     0  keyring: _ses
  77968717 --alswrv      0     0   \_ keyring: ring_a
  32558793 --alswrv      0     0   |   \_ user: A
 781765689 --alswrv      0     0   \_ keyring: R
 178740336 --alswrv      0     0   \_ keyring: ring_b
 907061159 --alswrv      0     0       \_ user: A
Session Keyring
 952124334 --alswrv      0     0  keyring: _ses
  77968717 --alswrv      0     0   \_ keyring: ring_a
  32558793 --alswrv      0     0   |   \_ user: A
 781765689 --alswrv      0     0   \_ keyring: R
 178740336 --alswrv      0     0   \_ keyring: ring_b
 907061159 --alswrv      0     0       \_ user: A

What I would expect is -ENOENT.

Br, Jarkko
