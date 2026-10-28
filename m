Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210797;
	b=VrCMG1HPNHnBobV/l0hNgAnnBwmHWkGwLwsU4S1jXqsV+sq8kFaVe3aK+yb3LSnviQ+2
	 J69lQf3i/nxNR/QXtvPdrXAnSoyw1FYn7o4INiTZlhk1wkGtMvvSrfraljv3ahU4XKbVk
	 DG0s6Nmko73PjJca60ZH3FT5F0Ucg5SG+6b/jT/v2xkfMGze4kSMoxRdF+vfhKZKPiS7q
	 42+2fqYDsNvC0xbseERSeSuaimVAuFg/fQVUmCVNap7x7/ZwqRRJY4f4nyDI9mo2vYd0S
	 M2UnJzggA1U6S8Ah76jZZgUL7HyjZFhoULJgdikM4Lh523xkbwd+0F02pIl4gQziMmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210797;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=k78neRH3ibX4+Wk6MgKdGnSjaeMI7/ipuLrsNVS2Pkg=;
	b=wN0IIElUcYm0LAuurgH5w7LHWV8qANuFSzzOaziBMN11+lUZRY7gizdz5pLveYx/HR6T
	 IFwn/tSQZ/4bM77d/JMFTKi570o5AorLV/dWM016JlkrbQi2qBwW1jJ7OJuBfA6ALrzqi
	 aVYLoL09xcWrS6IkbrqocB5keaNGAJ5n/1NNFR+uT+NzjBemuEPSgXBDQXnTXX/y8wP4a
	 hUytD7DBuGwW0Rq7jSq6XHUyIcSVjhe884NjFgOr7YQMnrdFpFI0KB9i2jfZe0K0VhRyC
	 eJugeByCOeTZ/0uGDwzJbr9ig2Us219WNpZEs+Ru6C0Jip4i/gAE020yMyyR50ry1/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c3quYTY+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A324606A31A;
	Wed, 28 Oct 2026 18:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c3quYTY+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96951F01828;
	Wed, 28 Oct 2026 18:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793210797;
	bh=k78neRH3ibX4+Wk6MgKdGnSjaeMI7/ipuLrsNVS2Pkg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=c3quYTY+Yipdjoo7yv4khoIjJv3+bmdrTIpnAA5wZj9M4Pesvk3lOpPH/HCspCpzn
	 1a4kCLXYYCcdGQsRO81tpjhHZLqm/7F9qGJDUTWyEoA65KJQZaVPSQATXH1r/NCAza
	 6BA3ffoubxaPbNzzMcc7qGP01XG7GSed6M/odK0AhwskO2MFAupPoqCBuz2P5sFNwZ
	 kAT+miKusGKCbuLeiLOXkb2iL8f5Y43o115qFK7/nznJA4pQXKFgDZhpkchImaFwOH
	 su4zHqzWLBBXceCeeYIcfA5zyUU22SyqO/46Yc+hQINh4rhvKLu77vUhrQWPeGGcFl
	 Di1m8XX1cVQjQ==
Date: Wed, 28 Oct 2026 11:06:35 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-security-module@vger.kernel.org, Fan Wu <wufan@kernel.org>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>, stable@vger.kernel.org
Subject: Re: [PATCH] fsverity: Tell LSMs about signature only after verity is
 enabled
Message-ID: <20261028180635.GB1876@quark>
References: <20261025204534.122506-1-ebiggers@kernel.org>
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
In-Reply-To: <20261025204534.122506-1-ebiggers@kernel.org>

On Sun, Oct 25, 2026 at 01:45:34PM -0700, Eric Biggers wrote:
> FS_IOC_ENABLE_VERITY calls security_inode_setintegrity() before verity
> has finished being enabled.  That's broken because enabling verity can
> still fail at that point, e.g. due to insufficient xattr space.
> 
> Afterwards, arbitrary contents can be written to the file, which doesn't
> actually have verity enabled.  The in-core inode stays the same, so the
> LSM considers it to have verity enabled with a valid signature.  (Or
> rather, in the case of IPE, which is the only LSM that implements
> security_inode_setintegrity(), it also checks IS_VERITY(), which can be
> bypassed by enabling verity with no signature after the file writes.)
> 
> Fix this by moving the call to security_inode_setintegrity() out of
> fsverity_verify_signature() and into a new function that is called from
> the appropriate places.
> 
> Fixes: 7c373e4f1445 ("fsverity: expose verified fsverity built-in signatures to LSMs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-current

- Eric
