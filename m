Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443416;
	b=qyDkbA+jMqUwjxcBWrj5kX8V1PAZB9V+0Ee1AMUdnt1CUhH/wISSIXnmgue4uy8HQZvX
	 iC4yd1jCXPCnI2pVyJgrdM2o7k4H4hGGLG7Cp3gTnXlKDy4br/LCQZkI0dFzlVhIneflX
	 kpkEWO4TohFkWOmP5HRUStF9aETaisl8245IeDico8Aofjqxosa61eE8o5ytXP+RBCeMi
	 2pCmBCCD2N+k7XTaHSZe/f1pjfd1vFjV5znDfpI0RDlkQCtgNjHNkTNN4I2iuVjiMRbLw
	 ihJeOu84HYZ+QRCEOiCpuf0FsqcfbQcUVXinkAL7C01jvGA8dwe/xVZKUUE9aawWrPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443416;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AN05D8Yt+mlMjUBN9ChH3pDuXIogzb18Y01sfQRIakQ=;
	b=sX9LJH5ZsM96khS9l2sEehqHpqTETsQk1yyuikIKpNhgSsT+bjIUAts3U9b37quH85K0
	 W7jS/B+/saI9OoSd8Gg9LUgCcLZ9TNoTz0hHtTrAbVDRoS6+/qTtlGynfx5Z+9k38BB1k
	 5eS7ZgRxNzF2NjpG64tYpdsuLv+VLIV2vtwYKHQbTMqDGpuqDwss0F4H1/2L67npKH+Vq
	 oOIfe1UKL84aTZeFcNoAtYOoyViMRQptm2xqiTmDZ1Re6YdHB6GZ1r2n4j8aabhiyPGbs
	 7t3KbEcODfUP4004+jIWUqSADjASe42nG1/jICgkUCr/O1pt/FVfz+bSOoTLLoaxnGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRrYToiX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id C63A5606A31A;
	Mon, 19 Oct 2026 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IRrYToiX
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id EA52E1F000C4;
	Mon, 19 Oct 2026 20:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443415;
	bh=AN05D8Yt+mlMjUBN9ChH3pDuXIogzb18Y01sfQRIakQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IRrYToiXyL7ShWFuQq7DqdYv0fCjQkJIqSRfrfFNDPiKs/S5n8phDXci2iyV1aovm
	 7RNO+E4cYj1uFAX9DHd7cRwbTRAQlc8UQPa0nRE8I8Pkh2t2P7U+7JTURTY7B0cvzn
	 Stvb42FRwkRQ82ndoJfo/dqn6jL2Ig0rTstaqC9jmpTe4JBat7nzMmCxlP+pwEi4Hf
	 JzQROI29FONXYOj19HPdtbPIJqt6IEhjIVKf8y7akKFU/WxQdBkqJWjRQ+yf1E+8TZ
	 5AkHoFbuirHJZzES6m/FX0pPoI09pqwyh4Sj5yHLkaW1VwcYkQuOwkGkRSE1zP6HDW
	 ezmNGvsq0ocyA==
Date: Mon, 19 Oct 2026 23:56:51 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Andrew Morton <akpm@osdl.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] KEYS: Prevent overflow of quota in key_alloc()
Message-ID: <ataEE0zcWy8ILlms@kernel.org>
References: <20261019181732.449591-1-jarkko@kernel.org>
 <20261019181732.449591-5-jarkko@kernel.org>
 <20261019192545.GD65095@quark>
 <ataDs4TMkbRjxc_G@kernel.org>
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
In-Reply-To: <ataDs4TMkbRjxc_G@kernel.org>

On Mon, Oct 19, 2026 at 11:55:19PM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 19, 2026 at 12:25:45PM -0700, Eric Biggers wrote:
> > On Mon, Oct 19, 2026 at 09:17:24PM +0300, Jarkko Sakkinen wrote:
> > > Check that the calculated quota length does not go over INT_MAX.
> > > 
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: LLM
> > > Fixes: 7e047ef5fe2d ("[PATCH] keys: sort out key quota system")
> > > Reviewed-by: David Howells <dhowells@redhat.com>
> > > Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> > 
> > Seems this should be merged into patch 3?
> > 
> > Also is this reachable?  I.e. do any of the key types actually specify
> > def_datalen > INT_MAX - KEY_MAX_DESC_SIZE + 1?
> 
> This is very good question and my *guess* is that no there is not.
> 
> That said, when not treated as a bug fix this patch is a great
> safe-guard e.g., to block corraterall effects of some other
> bugs.
> 
> So yeah, that's I would propose here. Let's not call it a bug fix
> but still merge.

Or actually: no let's not do this. I'm making my life only more
difficult.

I think it is totally sane to squash this to patch 3 and it
is reasonable for that fix have this additional safe-guard.

Br, Jarkko
