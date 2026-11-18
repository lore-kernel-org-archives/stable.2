Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.69.126.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794995273;
	b=foPkHrbbXn/7H5yQkkg/DE3ZVxiKl1OWFT3/Q7biWotFVtp+V6OTRGMV9FYW3LbeS5M9
	 E79cGoWR/HCA4FUrIrcLu2Nrs79xkiRGhCKoruYgnjryMW/NdNe54e6yJerV6ezaT1q1F
	 a+z0qHYvsyaf1JY9VtRsDZSRRQYDWHHEcN/p3HwCPdyeZhttyvjymlYTgiYhEbXKZPtMK
	 +xdNRC+ikhZKGNP/+wgVaClmzSnuHBs63E0Hlh0m73KVOIc/VTRdJanT9D9A5/d4+BUsb
	 l97HpvVYtJByj9gOj9qfQlw8yZs8QO5xcpB3CIISvCRjPoBldV7OWU7OeQHd1y+AA0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794995273;
	h=DMARC-Filter:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZBE67jsXGXZ+AyJ9HJif6efsTSaE31zODWFL9+XggTQ=;
	b=n5KTcijqc1H6QCPhTDfQLgU95xBUcwdZEPH+edJoVx9DJouO3f8mIFIOkHVgt2fDLawv
	 LgcbKgy/fkKeZwBp/0UMkU2VFC2ilPx0WXzs3DD6WPRkj+7tTG1e4jEbGK3YrNiKiC+5J
	 ewAeyMLE0A1zzuGQdzVorZiRrKe4mYi6TrE89mzTT43VMGDqq83oRiPwAU63r9VkVA8SX
	 stNAfzPKxJqvoPelt2MP9FiTzYAU9jqRgj7/zMYn2zSoFyq/ikIYbliN+O7pSCTk/H2LK
	 JI1q6TN2xAIQRqH2yc3Ncw78jMt3rvmTqp23Q1PlHA9S7KLdWi+yhRpWgkCufWrQwSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=weissschuh.net;
	spf=pass smtp.mailfrom=weissschuh.net;
	dkim=pass header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=pKKhnFQ3;
	arc=none smtp.remote-ip=159.69.126.157
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCD2606A31C;
	Wed, 18 Nov 2026 09:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BCD2606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=weissschuh.net header.i=@weissschuh.net header.a=rsa-sha256 header.s=mail header.b=pKKhnFQ3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1794995264;
	bh=jOfVSjIFAmNCVG5O2UVe1nC8DBW73Y/efAgaKg0wrHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pKKhnFQ33Ynmt/QgDcyLFwCGSUSjDI5Z+2bUZdPp2DB+bWq0pp0AZiRW4x9w/1w+W
	 EC7NPUQucEKg8HQ0EdHZzj/6Hk2SeG/T8bFINmABrnnkiMGu18u6oqTAtLCb7qYRrJ
	 rRn6Zjs/L76/0eW793n7vLrTwacVrvy6Kgob+0+g=
Date: Wed, 18 Nov 2026 09:47:41 +0000
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc: stable-commits@vger.kernel.org, Sebastian Reichel <sre@kernel.org>
Subject: Re: Patch "power: supply: core: implement extension API" has been
 added to the 6.12-stable tree
Message-ID: <6ffbbf17-c105-4ff3-94bb-ede950f574c2@t-8ch.de>
References: <20261117173125.2151200-1-sashal@kernel.org>
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
In-Reply-To: <20261117173125.2151200-1-sashal@kernel.org>

On 2026-11-17 12:31:25-0500, Sasha Levin wrote:
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

This feature backport should not be necessary.

See the same discussion at
https://lore.kernel.org/all/5fba6144-ffc8-457f-ba29-6c95f81b0e63@t-8ch.de/


Thomas
