Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793210777;
	b=I5ow7wNrYBxtOSJAT9wyQHUE6d/Ex4yULRBRX2qpt8sZFiO2+8YpFir2QX3ba4uU+dbK
	 TDSR/ahgsgYS0vA7/p+7oU2gb24BEXqF9GIEG3XhJzAi6VFfMQKxNaqWxjAGstD2YqgPc
	 qQjNPgQqAuuvznzTR6cqzpNmdt0n6SUCYUjnz9xe/tH2dYrKj9fWbTRdYUaPRXeRke2p6
	 exU0v9z4kgkWYVXTzDhyEW7JhaX7dih/BqgXmo1NF5zbdHv4My60JxmAeCVTiTBf14H4M
	 2w2SCCTSBq6WTO0mEqDGfxqAGjOY30rb/Lzlw+WzI4QmFmED2CqecPWFLOH2S58H6Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793210777;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=k/LxOHxPUGFXqyOsB9Z3CmBuJ424stUjz+6NUgATtt0=;
	b=J/wMl0tD43DbvSMxTafuR3zGq7lMr8aG73+6U1ad70ZdiIo3Vw2HOBgWQDS0oJ6lerVR
	 rcY3NwiW6zYsGMO1huhmWB3sQVLuSitg9S7AOwK0mZVevThxtu3xJRxV93Rbo1TO2Zie/
	 /oXekkdZfbGb+dmXEO+0Z5eQp+HST+oNVV/u5p0nX9XYBb3mA9qnFribhe6Ghvv3fQh+M
	 fP0zTUZtMFHEkqlPcAuSceCOxxnoPKOg+kX/VbdOUO/bePuKI7TdbmjiAwR2yXa4itvYH
	 nYXqGqmVYTRWHOYMBpAh6CiIZC0uXN0Dlf8WZ4MN02DK7NnnrEyjaT1WvCiPqxh3v6Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IY3D3g8d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01A3606A31C;
	Wed, 28 Oct 2026 18:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IY3D3g8d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50EB51F01825;
	Wed, 28 Oct 2026 18:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793210776;
	bh=k/LxOHxPUGFXqyOsB9Z3CmBuJ424stUjz+6NUgATtt0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IY3D3g8dZN5RJ428jAworZHlOZrt4hT69OHQijvtIJH9szLSP7xKrAP2adhXoAjBa
	 Eo6/HlYxhymUnI9u63X45PUmZ3smdikp9FAhsbqGaRm694ycpMalATvZ3rH6cYXW/G
	 O2M21peS1d+dgIqLkv9aqirgxGiC2y1C5f1cIZRxY36wGAVAyrqdzpTh31faj9JQko
	 Mq4mx2Nr1mgFj7dkhO6x8DWhOI9e9tTbqUuuRLQwGgi6Jr57D8A4yo1YuX63aN9Ob0
	 4H+aN2xfFpj5QaAwbzO63dPUPzeZ1yIibyVgp2BUGL5kAmlQ6aABZpv9Og3YNIxoR6
	 947c3WSAQE7uQ==
Date: Wed, 28 Oct 2026 11:06:12 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: fsverity@lists.linux.dev
Cc: linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org,
	Andrey Albershteyn <aalbersh@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH] fsverity: Explicitly require FMODE_READ to retrieve
 hashes
Message-ID: <20261028180612.GA1876@quark>
References: <20261022211522.1489943-1-ebiggers@kernel.org>
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
In-Reply-To: <20261022211522.1489943-1-ebiggers@kernel.org>

On Thu, Oct 22, 2026 at 09:15:22PM +0000, Eric Biggers wrote:
> Therefore, just disallow these ioctls on ioctl-only file descriptors,
> similar to what was already done with FS_IOC_ENABLE_VERITY.

Applied to https://git.kernel.org/pub/scm/fs/fsverity/linux.git/log/?h=for-current

Acks from the LSM maintainers would be appreciated as well, given that
this patch fixes the interaction with certain LSMs.

- Eric
