Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792511266;
	b=qTuG6EWYaMzb56zDRu72A24KU2ceclovRQJt5OMXdhyaB17gu+hgypqL7EzC7VhI+Ub5
	 LxArC9Y/lVS2rgdcHIuQ88Cvmr4MMWMFGn4dnLHtkVwlORxwxkSKOqC/wiJ1WGIhrTAAm
	 43MzCUow9E2pwJyyYW4/L6q7CaGtGHtcXkN6asZ5G4ocP36swD6HuFxhfHlyBwaWMigLX
	 Zwv7Cop3qkJCM/xmYWKhYjxnt+W7L9CXYyyEA+x3WI1Syju3HE5X+yFmfTCb5Ja/QzpWQ
	 J/tUYJsKzJTaAGDqekw3BSt1uBOq3mR2MkHJnne+LS6KSW34i1sQsNJs8ZL0BYdBE9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792511266;
	h=Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=fow0FGpeK3pOXfwYAYK+LUoL0fB27xHsVshPlxDrGIY=;
	b=voYiKnQax6snbqu7dMK845+kdrdFL9AD4GhpaRIDIh8hGfmB2NUi7BuWgCWMefYclIUa
	 07OcvflqxV9hIgg2alQCQEh6zVqpiV+u+/iYEfpMm7zjfsGAKS7hiVGaZnlQabCPiCqxd
	 8NFM+NnTOZFJ/i95lEEJC9TAjYnjBonc1rbreyuUVirGEWY/+8WtYFdTYI8a3mrCykhOA
	 K55MO4mdetWOwFhdLVOBBWg0KV/6aeGHTsABVa8k+DDCZ421DefisVIhK1uUi2a78tjSL
	 NjYmqBVQ+leaC8yF1bYhLw3HXHlE8nEOLKnHtEaEpZCvDCPfw5WKcfNL3AODNTu4wSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A2F606A325;
	Tue, 20 Oct 2026 15:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB101F000C4;
	Tue, 20 Oct 2026 15:47:45 +0000 (UTC)
Date: Tue, 20 Oct 2026 15:47:14 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: David Howells <dhowells@redhat.com>, keyrings@vger.kernel.org,
	stable@vger.kernel.org, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 1/3] KEYS: Expand key->{datalen,quotalen} to unsigned
 int
Message-ID: <20261020154714.GA699485@google.com>
References: <20261020013903.1244157-1-jarkko@kernel.org>
 <20261020013903.1244157-2-jarkko@kernel.org>
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
In-Reply-To: <20261020013903.1244157-2-jarkko@kernel.org>

On Tue, Oct 20, 2026 at 04:38:55AM +0300, Jarkko Sakkinen wrote:
> diff --git a/include/linux/key.h b/include/linux/key.h
> index e40b5267658f..26139c3adf62 100644
> --- a/include/linux/key.h
> +++ b/include/linux/key.h
> @@ -216,8 +216,8 @@ struct key {
>  	kuid_t			uid;
>  	kgid_t			gid;
>  	key_perm_t		perm;		/* access permissions */
> -	unsigned short		quotalen;	/* length added to quota */
> -	unsigned short		datalen;	/* payload data length
> +	unsigned int		quotalen;	/* length added to quota */
> +	unsigned int		datalen;	/* payload data length
>  						 * - may not match RCU dereferenced payload
>  						 * - payload should contain own length
>  						 */

fs/smb/client/cifsacl.c contains some debug logging that prints
key::datalen using the %hu format specifier.  Those need to be updated
to %u to match the new type.

- Eric
