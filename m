Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299420;
	b=BNRDkfXmG7DuaejhTRZhpNrL+9uAZQjF8Vhd7g6zqoQ2gUvqoSE7Owu3Q9HNJXYl98ec
	 HMtfHxznZSYWzs2gVq/OmOuY7NADupDFmq4Y6GHbTgOJHdicBsMqaV/A2D+9e5QVrJaNI
	 33wZL562CTdfw+udrthbj3+/YrSmdSc+uJXirKi0G+1J26la1Ep9m5gM5dQztWe/c+9bp
	 K2LkDh9cMxV1G7GUkegm1ESJd5Lg6qBTZlULssy99IyNToz6viBLUIvaxJSIT4/rovRQj
	 1yvhPvVmfx9v+kT5944cMqFhlyFfFpfZl8zq/yK9FF45/+nPeYF7fuC2zrjaKowFltA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299420;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=R1SdJzNEd0WJTYOQy7QqwXa1uADKOSf5U6Uq/NgrxKU=;
	b=cA/y+fnRR/TaUAnbX7LIOvA3Fj4+AYqXmqSgczCFFSKewFcVI1sq8kq6sKYjwlT1RySu
	 CX8RXPEUHA5uGHeu9FOBA/iXIpbHjcD3thigV4cC7If5rz4zDwIvU7tjOEsJY8IAXqF4B
	 LsqwCuuFLEAgpLZRYCFrXNFFv4hA5P3VT1QQW5SlBsthzGEnBV/fQ1qKfS/AQF3YZgqKS
	 WOmyjckPrF6RmMPPenvjJdv9BwAnQ+jZahE/bf/2lG6Tw0zwNVZfWtesr1TK6ZOhVU01f
	 HHpSSS1xkEFOpnC3qJ5+76a8iOiK+ZVTTjdEY+qWZWdE+OLAwPCBY/ipoJF15KbeKlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3V+mBvJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 405DA606A322
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B3V+mBvJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B411F01824;
	Thu, 29 Oct 2026 18:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299420;
	bh=R1SdJzNEd0WJTYOQy7QqwXa1uADKOSf5U6Uq/NgrxKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B3V+mBvJfjtQy+sQzUjI3kNAVEbJhRoN/2U5mH/HwyieSC2BHvIs0IHqwVckk26yQ
	 AIX61dMZi3hynRzayCgdGgsFQWhU/rhHnm6ZyGTXxUlhcpNHd8cQY7DMtK13VWq1Ap
	 yMbQ6anbkUkc0gqgX1j3b2A3entj8a/1lP/Qw/wS+glh/XvmJhn50IuKGOxrWTzkpp
	 /ftVgwa13TwD0G9ifyC473jKJGs6WoJDRgu8GZR96QofpmzWEfrHX7irMeHd/wJTBQ
	 YBRm9EVLBBKqLdhGFm9qYVmEsXsb8POfZ9GiEl07hCejqZK9kVVh4uwsNTTSupWsi6
	 Isa2UBVcjyUTQ==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: Re: [REGRESSION] stable-rc/linux-6.12.y: (build)implicit declaration of function ‘__kvm_faultin_pfn’ [-Wimplicit-fu...
Date: Thu, 29 Oct 2026 14:43:13 -0400
Message-ID: <2026-10-29-1-daily-reply-0006-kernelci-s390-kvm-faultin-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179321034574.43309.13193962355801801982@kernelci.org>
References: <179321034574.43309.13193962355801801982@kernelci.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> /tmp/kci/linux/arch/s390/kvm/kvm-s390.c:4776:15: error: implicit declaration of function ‘__kvm_faultin_pfn’ [-Wimplicit-function-declaration]

The s390 KVM faultin commits that came in with v6.12.114 need
__kvm_faultin_pfn() and kvm_release_faultin_page(), which 6.12 doesn't have.

I reverted the chain from the 6.12 queue. The reverts will be in the next 6.12.y
release.

-- 
Thanks,
Sasha
