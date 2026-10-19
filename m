Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443356;
	b=T7yWTHHReB8Lmm2L4IDr3r2NxxLBhFes6evNyBZmScGDHJkMsZLnK84C+6PX1wQ7lh7S
	 Z0qGpchj2Mazl/scAWtb4asVzkyX/gPV2TCoSzhXA6enlKELls/uNtP76lyhMfvnASRpq
	 PnQ2DhQvfaEk5cQi+pRnPwAqPhNHwRbmN1VXM3n+i9do8AZQ1BLgh9M7w+w0FPK6fuPQc
	 E1fN3bzD5WlcPlE7CWRatUOcrHiq+Y+TC+/3Wru0RFLvjwJ9s2guHahE0P3BW7nT04yWh
	 CvYvvzj8djT7pBlSmDUwrURatQvfMVV6jU7vCPkKCeHRnVakL1XnSrj4Zl+jNwhwVeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443356;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=e6OqCyaRJ+RNQrqMXUtu6q96XwVHbtg/zKywa1y5RoM=;
	b=3RmEUOn9DRRESBHenhei9ej5hJrmzIP33pWdnkiaLVqjbBE4oCuEskn+wTqyPHgTFM0t
	 rNhqkMBjr/dlIDBuwp77fxsXbKvPSKsJw1+j0/KliUQzYk75xFTgPLxd5PrCOjhbNUfK+
	 +IhabPRnz3nKu/PFPpgXVQmeC3k+eq6Tt4SSADM+TXYAnuYfk9tGb24QdyAAACpxSC+K/
	 7D1pm9oOq+T0pdClsRle/A3Cr10FKMpGfv3kcpVvo8kLM62SWB9xvps7weVhwcJ7/i+um
	 331rzJ0uLjSwbwZeTcUSlnSFX7PTo+2aPLAkSE0g1XKP1IP0J3oW4KZhOqzIUfPkT6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="KsG861/X";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7AE6606A325;
	Mon, 19 Oct 2026 20:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KsG861/X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0958F1F000C7;
	Mon, 19 Oct 2026 20:55:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443355;
	bh=e6OqCyaRJ+RNQrqMXUtu6q96XwVHbtg/zKywa1y5RoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KsG861/XINh6P6UKNU0bF7U3sT06wMzAonp+IQpOlyKHjwOle9OKdRG6j3FzDvUh4
	 9GdtZODd0T/Go7yAv+WAI/i8NVQJuazNCJZG6MizX/OcwF4NvTSv6ej2nSv2hajXl5
	 +TasqFXCi9vdnrMsDgyQkBQFi5bO/4fw14SeUxkmIciAAdiH8AyZQCAWaVp/0Uxge4
	 e/YLjYVfbnQ0SRHZ3zlJvuDvcyxOoI0Z5SPVbIBXdnQ/CvtqqyQvqko1XDPqdnZ+1Q
	 3YJwko9xpM2z8tI2aN7qkuY8DoQTS87/7KfUC0QJYWEkG1QtZsKn2qKsbp8YC//lB5
	 vCapw8xerRu1A==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	kuba@kernel.org,
	linux-hams@vger.kernel.org,
	Bernard Pidoux <bernard.f6bvp@gmail.com>
Subject: Re: [stable request] ROSE memory-safety fixes for 7.0.y and earlier (merged out-of-tree in linux-netdev/mod-orphan)
Date: Mon, 19 Oct 2026 16:55:32 -0400
Message-ID: <2026-10-19-1-daily-reply-0006-rose-ax25-6-18-6-12-followup@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAFAa3YAx1VhVJw82fSK4OWTKZ8niDDRBdGYnngeCibZFqm04eA@mail.gmail.com>
References: <CAFAa3YAx1VhVJw82fSK4OWTKZ8niDDRBdGYnngeCibZFqm04eA@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Here are two more fixes for 6.12.y and 6.18.y.
> They were merged in mod-orphan in September, but I left them out of my
> earlier batches by mistake.

Queued for 6.18 and 6.12, thanks.

-- 
Thanks,
Sasha
