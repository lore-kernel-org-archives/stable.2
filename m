Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275373;
	b=QZVWTFqEDuSsUYU7z241AeQS/m0QNWmPS6W6LagtRhYhAnlWlwrCIDY84anc+Q/HX8wV
	 XZUj/hnbtHOrUmWmRhYJhOJWvT/kcklz/ppDNtpFreAXXaH62Mz7oVlJwKYDZU4BT/pyo
	 1DY2Xs97bIw2tvv9XxH23RD9V/nYE7zVxPF1qE1YSvWg5wpwrJpEuxZ2ryj1SIB9Tu+Lw
	 4ss6pMsH0W3DV6ZIJ4CzoRVsjRHlUs3cpPEXg/BR1DkzbREo3VGqFEbOSSWmfdqCYvlbh
	 YuJeIo6xwVGArryaCTKiF2LRvHRdoShkcrcwKm/7bZk+gN6PbMeZxel0bVSZUhVLewQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275373;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eE5gb7EtrWTfyx7BevUO+hpzMrO9f1d0/5w09FWhSbc=;
	b=rVdlxL8JzTH6mCRgkr9/V6rm+zVHVdO9LxfptDHxkgMZT9Aupbw2lo6y7xa4CkkCBk0m
	 dt5hWuBXOgfILadNvCritUSiEQO5C8/WM7j4/vL4YmDwhMjFRCySquiCTFdDFFCqdJtn3
	 0+8mCI24KIVQL+k5g8fcBkH197kurm54ajju+75VLDoitcnyPd2je7SR7hkE2mtdUHy7F
	 FktsemUkVsb41h8ImHHfifBJRmJJnalN83MbGEl7jqvOA/g6C+34ceM//UZf4ypgPg8ZM
	 fjayPJD83m/5A7iZOxXGiHw/eEXwmAzsgSCZpv26kFdO4itYw3cUWxqEeC2wx5Bz+XA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BT9s6ZE4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id A391E606A33B;
	Tue, 10 Nov 2026 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BT9s6ZE4
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id BFD161F0089F;
	Tue, 10 Nov 2026 01:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794275372;
	bh=eE5gb7EtrWTfyx7BevUO+hpzMrO9f1d0/5w09FWhSbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BT9s6ZE4nswEn6Gaj7D/T7SvhmRuIOS4NxeJ9MePy74ai3F2l+h68YjMGvJeP2tjE
	 gpGAMydL641f9InsoQ9kabxRfbE2Y36puRUEC1lWfA25/c8Z7Gzawgdyu9lIk3msTe
	 V9Uyh2YmU2EpPn9RzY3mp/yk1LmSkbFF8eUkFbwcQ6cnf/0rrsXt9DMFQ9UT8NbEKA
	 AqBbQdhjwTRs4RbdYRZu1NXLpcQCAg3YncyeyJy+hrkdqcu2oeFuVhmurFpD50V3cB
	 sqzJigQhDiFKpEnUjYtMbusj5Pz3Nz4d3CWYCn6xecf32bVKQBvAnHKGDECPMwO0RO
	 gA4nFwXSf21qg==
Date: Tue, 10 Nov 2026 03:49:28 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Yuansheng Yang <0xbeac@gmail.com>
Cc: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v6] KEYS: Protect pkey method checks against type removal
Message-ID: <avJ4KM-Erci0FkgZ@kernel.org>
References: <avCZIMCsZ4um18e-@kernel.org>
 <20261109055204.31673-1-0xbeac@gmail.com>
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
In-Reply-To: <20261109055204.31673-1-0xbeac@gmail.com>

On Mon, Nov 09, 2026 at 01:52:04PM +0800, Yuansheng Yang wrote:
> diff --git a/security/keys/keyctl_pkey.c b/security/keys/keyctl_pkey.c
> index 15b6bf6399..5ac049b71a 100644
> --- a/security/keys/keyctl_pkey.c
> +++ b/security/keys/keyctl_pkey.c
> @@ -100,9 +100,6 @@ static int keyctl_pkey_params_get(key_serial_t id,
>  		return PTR_ERR(key_ref);
>  	params->key = key_ref_to_ptr(key_ref);
>  
> -	if (!params->key->type->asym_query)
> -		return -EOPNOTSUPP;
> -
>  	return 0;
>  }

I think I asked to remove this. I need to revoke my reviewed-by from
this version.

It's not relevant for the bug fix.

Also if possible try to make a bit more compact description of the
fix. I did not ask this for reviewed patch because did not see it
relevant enough but now that this needs a new round, you could
address this part too.

Br, Jarkko
