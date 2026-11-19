Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104539;
	b=SXvm3S98pJWIW8FScf0nL+H9/BYhcImSSzD1RFfca6dY+04wLE7+oVwgYfU+MpGpdX8l
	 cXBAvsdcvImgi2YE//3f25B9EhyZeOOGt5K8oW0zKslNX2I2WvtnXyOC9m+BTev0/f3O4
	 JFAqW3N7m4nIRWlJ/podJFRJdqrA29lMjio5zmNkC04lUjx+leXtDaLNrGwiBSNKsL3OS
	 y4zwQJNCB/xhz+ZAN7p5wONvxLZBz7Y+rtgtCIVEoGzc7NgYvDEQdMRhZ6y+zVCNk6WeQ
	 gh2EvbKnydhy55vHkt5DUuOofnvIvcUWe3faKEbRU9PeEbFInA2i4UgKn11PbDypQdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104539;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=b1bZUSt2AcEgnnFIoI5rdzuQK8wRR8BoHG9JOY3iNcE=;
	b=iKr1MXbK41WKKYqAh4fgfCEEacbFCXifJaVf06hx14Y/f9n8F4UywZMdyRc8pViDz4yl
	 UWnHcL5wTUuMmzN19phh8Iii96kWz4ZEyPf+KbkkcPLJkb0r45udS0SHM7vlLRF+msvtA
	 TLqOS6FHfcYm2mwNP/1WyJlyvCr+xepyN/YidTToWWsBKujiObWAd5gFGgKQNuTKgDzJC
	 rG5Tb/4WrDgPXw1J2lgp0SXJM6NY/2GHKde6GdzrAXcPHtozvyDbim6eLfgQl0T+WZWZQ
	 K1vWPZ3/xYxD9MWL8fWnnVCvpSqAu/7TNc/kmf3sD6mgZxL0heqiv4lNXs37zeqMZVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yil5f3Pe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D34606A333;
	Thu, 19 Nov 2026 16:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yil5f3Pe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A3D1F000C8;
	Thu, 19 Nov 2026 16:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104539;
	bh=b1bZUSt2AcEgnnFIoI5rdzuQK8wRR8BoHG9JOY3iNcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yil5f3PevPiHRyf8sBRrCZZ4a2JYJws28PsJpFmFZbQDeJZHRUpkc25rcKVec8Oo2
	 p+SfpA097u/vKQhDGlAK6obf+TMJPvJg0JRAjVHtxE3LYhFsDN2xf22ZUTUZV3CsFy
	 uUiLLWVxSpTMPunoUEBtFk60jd5ZRn+VDoBdCnI+Odia+MJdVhANQoER+7QKlGHerj
	 PhNLwsqNp2O4bcwHOr1RtRSwfD7vH4Q6RmaQD6MW3voOZMGCbFx4Dnfhl9zluwH+dn
	 IC7AvBqmQCUd0Ti1IwWO+kXLQ4JzOws4T7vT4fRu/mRxL4K5Ube6uaKK8kvuhex7PJ
	 T/9QO2+77xYsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Vinod Koul <vkoul@kernel.org>,
	linux-sound@vger.kernel.org,
	Sergey Lebedev <lsa.uz@pm.me>
Subject: Re: [STABLE REQUEST] soundwire: dmi-quirks: drop the ghost RT1320 on the Surface Pro 11 (Intel)
Date: Thu, 19 Nov 2026 11:08:26 -0500
Message-ID: <2026-11-19-1-daily-reply-0024@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119064745.65211-1-lsa.uz@pm.me>
References: <20261119064745.65211-1-lsa.uz@pm.me>
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

> Please consider for 7.3.y and 6.18.y:
>
>   d32e04c05234 ("soundwire: dmi-quirks: drop the ghost RT1320 on the Surface Pro 11 (Intel)")

Queued for 7.3 and 6.18, thanks. It needed the two Lenovo quirk entries before
it in the table, so those went in with it.

-- 
Thanks,
Sasha
