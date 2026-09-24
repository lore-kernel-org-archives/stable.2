Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6853D35F5E5;
	Thu, 24 Sep 2026 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790264467; cv=none; b=rCXoMs+2ZJj9eltjAYP+TwcdvTiBLYf081E1J0kBfGEscPdgTDfp5qeJe1UFsasei3GWY9WqLYJ8tywzMw/N4KU1CQESj1fdp6Q+Qw9iMOhSEpL9diEmKgESc63MsAk4rx7nstEsY0wOhCe7G3M9WR2yBQfqxT2TjrBHsO7UMIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790264467; c=relaxed/simple;
	bh=LtHn9P4uY6JY/xbhTzibkgwLNpSB34X1PxZc9W7PLBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YSjVuE/quU3aPLPJv2KfI0DpIqIroF3lwe3SQHovO8KA7afBniSeRfNH1s+GbZTt3BD2fyJsbH3KGx6RukdYJv6JYpt0nif8qJKoTq1L0WEjyJQONV29moMkwD8LCbtiBbVA/1OCRAB/77UcSYC8uV/rH+X+ZYfraCREUnIdaWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzHiL3yL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzHiL3yL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7189D1F000FF;
	Thu, 24 Sep 2026 15:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790264466;
	bh=737AHlLWlTvpEJAWRPNz2w3MkgeoOAn9THRqVlYYKfU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VzHiL3yL6TbkX02oxLYwhTHjuCB+ABnYwszp742O3ieNIF5kD0chiqNwDvXGaIgq0
	 1HH/rC+n/tdGlGABUny71B6+hdOCwHntEIAeySK0qQTi/GoWFnQn4nokg60L2dhHOj
	 rde87vj6fE7KFV3zMAe6//yD8/ukbVtVE0OV6XWNxfHeV1N4hEzuEArV58bRQ/B4iG
	 qgprjZbKLTH6Gdq6p8nK88xBy+AIJr6PB0Mn1HLw3kIp7idczA/Cm8Ke4X7GrkRNcv
	 C3b/2mN/s7TPsEsUm37CyhNxL1ADxQ2td4s5aJPPsGfMEEOrHVo4ZDsJtlPtWSv24H
	 +f2g3ME6L8BRg==
Date: Thu, 24 Sep 2026 08:41:04 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: <netdev-bot+sashiko@kernel.org>, <conor.dooley@microchip.com>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <horms@kernel.org>, <nicolas.ferre@microchip.com>,
 <sean.anderson@linux.dev>, <atenart@kernel.org>, <linux@armlinux.org.uk>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <nb@tipi-net.de>,
 <vladimir.kondratiev@mobileye.com>, <gregory.clement@bootlin.com>,
 <tawfik.bayouk@mobileye.com>, <thomas.petazzoni@bootlin.com>,
 <maxime.chevallier@bootlin.com>, <stable@vger.kernel.org>
Subject: Re: [PATCH net 1/3] net: macb: never give hardware a NULL RX buffer
Message-ID: <20260924084104.25099f60@kernel.org>
In-Reply-To: <DLNN7LYYGP7L.3OSN8JZNC37PS@bootlin.com>
References: <20260918-macb-close-v1-1-05e32ce98813@bootlin.com>
	<179010942002.2160803.8691011751847108495@kernel.org>
	<20260923184756.16ce33a7@kernel.org>
	<DLNN7LYYGP7L.3OSN8JZNC37PS@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 24 Sep 2026 17:13:58 +0200 Th=C3=A9o Lebrun wrote:
> > If the AI interprets the rx poll side correctly these seem like a major
> > flaw in setting the USED bit :( =20
>=20
> Yes the AI is correct (unsurprisingly). But two things:

If it's correct then patch needs to be changed.
Please don't write puzzles for me to solve.

>  - before this patch what happened was that HW read the NULL descriptor,
>    so not much better
>  - we can detect in gem_rx() using our ring buffer cursors that tell us
>    what we've managed to allocate, that we gem_rx() doesn't iterate
>    over descriptors that haven't been allocated

Grammatically dubious puzzles at that.
