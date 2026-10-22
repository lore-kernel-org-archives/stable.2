Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634639;
	b=e4mTPTbiBJsMkEVxjfpDclZGRTx4rgPYmi+8JnsxLq1VPtT3xiI4eH0zFUT5IPiuRErp
	 QhJ4SvhWbFYftl9+T8Julx4pHywiLQ4UT/6gR39lmFG3US9X5Dt/7LJOXwYgwI1x4i8Yy
	 Y+YCPcG0zTy8bzLumVqufGZE/GtnUO3j5NGxxIOxF8/AXwNRrTMmEwkZnf/bBkVWoIud8
	 xzw80dAJOLtpNpJGFOyOXKtxR/uugqBeP9Me8Wy4YruCxX82fYilpZJvXIfMi8kssoO0D
	 pIujBV4oflhnDQvldJ3Tm3GNGnxQwn1rHN4U7V1s+Fs86hd+V0vF8m8mwRdDAKHsJeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634639;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T/Nx27uRFThE/ANQITswXzsFAHoFZDXxt4E8+ArdcbE=;
	b=27t+u+nCkZs6bM6mfCTlFe7q7wo9LTGenO+oy2xRX+fvWnsLOBW9P+/dqnMrcITNDBvf
	 DLH44SflUxCEz+1hZEzI/z7tUsiu9YHbB1nnMytp6D4rj7Mh9zH3fBwa5VkK90K7GBkF0
	 57Mfa7YL+SwXAC+RhHr7NsLo8cl8guKmXLF6vr3qV4SLGgW1iC1r5raTRjC0Z7z5T20NI
	 HTPlky9KFoEhIvv1yI48jSjrynizoAQHGLc5Rk4ksJmSP1HBjUJrvI4wOrBHRrCZq393T
	 Exvm0JMOQlvT23wsZN5yVcfztW+Zh6LPoUKep4syLSNIT/hnvyolx9rjAB15bt6+n5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1RUZRFC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE59606A31D
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m1RUZRFC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28231F000C2;
	Thu, 22 Oct 2026 02:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792634639;
	bh=T/Nx27uRFThE/ANQITswXzsFAHoFZDXxt4E8+ArdcbE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=m1RUZRFCXlfyJ3zODBRUYY9Y1OvDvQwBPhpVTt7QQCRaw15lwiOnCluTdbqcD5xhK
	 KnGyUfzRRaienOLaRDliI07RNp9HeBE0MR2LapBRn+l3ykwG2DZqKZigaSbuQwaAkb
	 Y5FbQ6V65foGApY/HpO5QNpcwsuks4z3kGNxMotx7f3Fjo2RSE2xvYE3EgWnjgPJWl
	 bloYLNewy7rWxvLD0s0lN2be9TAa/FkIVc45hV0VUxANn9klg+uyu0BikyV3qFhk5h
	 qodCI2wDg79Zu5FUn2PZbAl7aO0S58x7Q89ZUwrvj/psm1sDAMa/LIVDUoUd9CMGFC
	 vhdwjr6fgaczA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Subject: Re: [PATCH 5.10.y] mm/vmalloc: acquire init_mm lock on huge vmap to avoid ptdump UAF
Date: Wed, 21 Oct 2026 22:03:28 -0400
Message-ID: <2026-10-21-1-daily-reply-0003-vmalloc-ptdump-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019174730.284280-1-ljs@kernel.org>
References: <20261019174730.284280-1-ljs@kernel.org>
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

> Currently there is a nasty race between ptdump and ioremap when attempting
> to map a huge P4D, PUD or PMD entry:

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
