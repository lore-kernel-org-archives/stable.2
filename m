Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344392;
	b=Q0ix1CSADz1evW3ikTcjnVVZCiU3rAqMYNcY3sLOI2Jpy9xedBPQ4KN15KL5UPrSkzzZ
	 YBFhtvUO5dZij3aJ06xCAkgnmn/e7u3PlAwchtqC+y1EEB6Xkq8ugWzkKtIhUkagLoshh
	 f4c4QHXKeFezhqKRvZaVztcEC0jXXIfKZnMUSroQz266XqHVx+LyqMoOAgY0JWbzNdUiO
	 NqYti9m+eJiHBgwB5XdJUAC6UxgUzj32g0apBuAzx/g6mSBPRiCD64l37APMYEI5KiUvc
	 m52CbhlXlPGl4YMw46y1K5thZxTelhbj/MVYpFTYuux+DLXEMyS0TghQkKN5ot2iB8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344392;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VTmcvENzKc61A8YpOqVl8LMJ28R7uvg0ZiK4Xlt8MHU=;
	b=J7WPa5z64M0x3ikA7neUj8yDv+RzQ48ezZRATBQ2JvE5504zIYdpBzz9a2AlyYchGvgX
	 KTjIOfmHg7egC6EZAuicnutjg3scYgGqNWhZ401Z0n/X4dY2iwQl4bsKyLUzmoN2Vnk8l
	 YHFRpHvlWF6RCJEhAQuPpvjg4n6Lhw7CwVnJq24HRgNHzBtTfD9RtQBvHAcRucxSMr6mt
	 2cR20WB0/F10Wik8eo9XJ2Cd0wCcgWLw9E6z5j8KbBKOKSvi1eu2EncJCT+Bz/eGNcB1G
	 mcl5ui93/kDMP8rwzRq18ZbmLon79epxibKz0VctcAm89jlHw/ITL8Ag/z8q1L/+I5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPOvHEgU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCC7606A339
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HPOvHEgU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824F51F008A2;
	Tue, 10 Nov 2026 20:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344392;
	bh=VTmcvENzKc61A8YpOqVl8LMJ28R7uvg0ZiK4Xlt8MHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HPOvHEgUqnKBkmIuAlxMzpZmUxzLh6jNCGmgM3uBt4wSFzD4d2nJS6Ff5JcKUL/oG
	 d1Dzq0TPTGxfwK9cZmAHxjHICsEZR83olIMNmnXbUSx85FK16y8juQKOkH+s0cFv3c
	 OaXRE6h7htyWABL4bZ+AW5DzsjE9XxHvD+oStchKWvlBYVkQ+tJAMzyWqhqKjFkkCR
	 tBNgVVx2SlCN0OM+NlyAE/1eXDxzxRuDkQmjHQoO5o7ezT8kjblTM8caQJVNk76t5G
	 CJhtKUkhJLSM7La0dAPDeGld2gTPGjcnF0+pyHUERIkiIcL0rdnFB/w59ACCRJNr7R
	 58aqQeBhGwmQg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.18.y] batman-adv: tt: don't drop local events queued during TVLV update
Date: Tue, 10 Nov 2026 15:59:15 -0500
Message-ID: <2026-11-10-1-daily-reply-0019-batman-local-events@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110185357.79794-1-sven@narfation.org>
References: <20261110185357.79794-1-sven@narfation.org>
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

> batman-adv: tt: don't drop local events queued during TVLV update

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
