Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E13441DE0A;
	Fri, 16 Oct 2026 23:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792194040; cv=none; b=Lij43iaFgYkxZsjJDs/2Jjj7/fJUlGNhqYNDpM51vrO6rOv6gvDNhbmMgpm9vIJ1qj7u5X062Bo4y1L0eSl3f5nZlbpxbp/hiMXdcq8VFCzJavigQhYvw1Wwvh8S+tRUvcUTODNMbEDLWPsgE+vM56PdjIp2lwyCykGKKuy8tHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792194040; c=relaxed/simple;
	bh=s0iunntDN0XEq2X9Nv4lZuldL3wNpmLyYQqgLUfAlU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8dr3tbtBFb1x7eeavO+krkXPOLa8s/70LbbeVAa8XnyjCGrUV4N7FoIR3DznvT9eAk3mJebo/m9+5BkuHY3ZfaKk7wqDg3EtzquW+bVV0mL+Bk5YaPruepT3aU9M65MfVQppNJguhFdGINEARGD5u/SLr/KTdGp49/56mqLsaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTLKjrPl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTLKjrPl"
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 2BCDA1F000C4;
	Fri, 16 Oct 2026 23:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792194038;
	bh=tDHuuTvJquMWwJ2tkqi+ArsBHnlPtm/XZaOoe9H1IcM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CTLKjrPlWRQyy+kNSUUqEyfVPUsB6aGQXPy1coQsGu2uRe4wnFBQk8mTg9jSnIGK8
	 Qf6AS8+sF7G3LDFx5VY1sGLT2x3ZWvlfg6IKo48+POWv/qWiRAPRP2almoynukLQ1O
	 B77+sI/aMlKKanxunEYqma89zbJGl4cLUDxkbpoCmRu569AAbtMOCTorkKpMYqlS7L
	 pe7eov2QZUhBu/cYSQ6hdtB9Kepgyu4mk3d6Yk/q6NuVbQNCJwBFwvZ2YRucBQ1fVj
	 3SdSehcGRSBLU8tAZoQ2mS9NEQdOJJ5DYP2vhrHDCTiP9Xl0yOb3p3IPak5kk2xE3m
	 68KBoxNHyXxLg==
Date: Sat, 17 Oct 2026 02:40:35 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] keys: big_key: Reserve the final quota before destroying
 the payload
Message-ID: <atK186hMPBhYyPCN@kernel.org>
References: <20261016040004.324286-1-4ncienth@gmail.com>
 <atK0MnGM2h9IH6FD@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atK0MnGM2h9IH6FD@kernel.org>

On Sat, Oct 17, 2026 at 02:33:10AM +0300, Jarkko Sakkinen wrote:
> On Fri, Oct 16, 2026 at 01:00:04PM +0900, Daehyeon Ko wrote:
> > A big_key is charged a fixed 16 bytes of key quota, regardless of the
> > actual payload size.  big_key_update() currently reserves the actual new
> > payload length before destroying the old payload, while the subsequent
> > generic_key_instantiate() reserves the fixed quota length.
> > 
> > For an update to a payload shorter than 16 bytes, the first reservation
> > temporarily returns quota.  Another key operation by the same user can
> > consume that quota before generic_key_instantiate() tries to reserve it
> > again.  If that second reservation fails, the key remains instantiated but
> > its old big_key payload has already been destroyed.  Reading a
> > buffer-backed key or revoking a shmem-backed key then dereferences a NULL
> > payload pointer.
> 
> Even at the risk that I'm saying something stupid, makes me
> wonder why the call exists in big_key.c? I.e. why not remove
> the call instead of doing what the patch does?
> 
> If I'm now missing something out, that's cool, just correct
> me.

So the way I see it this patch has the right bug and a wrong fix.

I.e. if you still want to move forward with this fix, explain
why two repeated calls are still a necessity. Then we can ensure
that the fix addressing the root cause.

Alternatively rewrite the patch so that it makes the call path have
only a single call site for key_payload_reserve().

Br. Jarkko
