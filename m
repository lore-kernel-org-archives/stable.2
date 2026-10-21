Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586277;
	b=rHC5OYlhBYB94POmvtgAdvXxG4hHSm5Vt5jj2ekXRRnypVRC/gRq+hbfG8RmOjhcINIp
	 1P5YhmHMEvwUHU/7UbNqgrFlVyCT8y+JEsmbD3icyLmRuMD253MtQu2dE/9457JuV8QdN
	 We/T8yCn94GafrOAd6AyO4ZatjzQIJ0abFo4blsMCf1R4NRuKAt7CcJnD3AGY0RofkHGt
	 INuKvtSRDl5ReK/Mr2znMYo3nRbSpR2u5aH+7pfO0jbkRijACgUVu8Ta1mzkSzv5c90o+
	 JdQ8QHbGCGi0/XM+mc/SIMQ1QyF2R6ukMqvYjXX7cggdHYHRE4xkTCVNsofo9RTQ3xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586277;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=j4wNxT2Jicxfwguu54sbOsv/vnn7quYx+PA11c7hVRA=;
	b=bmfhySstPxsffqdY8XNTxpyrt8Jfz5n0STTjZMhwQVmspUhiViLfuuggPWYdfbcGJHSk
	 HbAlJkCru3ssW+ioEudVXhl9rK0TJ24TqDFXW3wnSbK1rlKZtTD4+Q5yZVmlRuofJz6b7
	 qw919Zf3ZeQdzMrosflXrs1QOP7CFzur0HlCK8oOQnKh/9bV90TrB3jlvYhCcER5snM5Q
	 FxhvmUS2syamBvzn9yssPzuxeZ21FeW1Hk13fZwwyfLKnVpwSAASUrzS04K4g1Qa04NRJ
	 cm+8WSoHB8zsbJfurrqTl3P/ZBCm972iN2zmG+hMtYlyHChmYHUYzAK3gRzaptbmKkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=weissschuh.net;
	spf=pass smtp.mailfrom=weissschuh.net;
	dkim=pass header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=tGwT1iSe;
	arc=none smtp.remote-ip=159.69.126.157
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1FE606A320;
	Wed, 21 Oct 2026 12:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD1FE606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=tGwT1iSe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1792586273;
	bh=MDzqjayLh/aCOpngdlyENnTIYyHSay9mE8a/uUgJ7j8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tGwT1iSezgzCm5hyegWTShWYsGzTQCloBeWBey4WUGmm0TrPPny0Yrmac8nJ9tswV
	 HI7LhUBi/ucEi1SEVksZ5GnLAZvIWC6LCTA9wxAm79HL1r22qSMUjhqIfeVfAk1UGh
	 7htzW+tXTXmZUne7NjjqbJXx2fpO9cJL3+U4h0ik=
Date: Wed, 21 Oct 2026 14:37:52 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>, 
	Sebastian Reichel <sre@kernel.org>
Cc: stable-commits@vger.kernel.org
Subject: Re: Patch "power: supply: core: implement extension API" has been
 added to the 6.12-stable tree
Message-ID: <5fba6144-ffc8-457f-ba29-6c95f81b0e63@t-8ch.de>
References: <20261021115355.4175993-1-sashal@kernel.org>
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
In-Reply-To: <20261021115355.4175993-1-sashal@kernel.org>

On 2026-10-21 07:53:55-0400, Sasha Levin wrote:
> This is a note to let you know that I've just added the patch titled
> 
>     power: supply: core: implement extension API
> 
> to the 6.12-stable tree which can be found at:
>     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> 
> The filename of the patch is:
>      power-supply-core-implement-extension-api.patch
> and it can be found in the queue-6.12 subdirectory.
> 
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.

This backports a whole feature series to enable a single backport.
I don't see how commit 5b4bd13e0552 ("power: supply: core: prevent
unregistering a power supply while a callback runs") functionally
depends on power supply extensions.

From my PoV the power supply extensions backport patches should be
dropped. Sebastian, what is your opinion?

(...)
