Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793461146;
	b=S9I+ELeDfeugWJI53LSlnW3S1iFJ5mDGza/fqaugpyiRSs+usmnl5C7W1Av028sLF+83
	 LLhQjKk8TITQHx3KPLm6grG3A1NezgzHFZ/dLtcUlRUs2bVa3R990RABIYDz93FACaNHA
	 FYwLDtI4uPLa16RMA69H+9rKURbg2whBO6HNWIMpt+4A+7dwO+UPoPbtJVLwFLE5zx63p
	 wJwrqCO1t5PcgcRrjHaCHibYRR2+fhyI6t6BoRzWxEHRSjzRuqX8Mp3KUhPNp7lWnF/7R
	 FxeFdtddY660FqQvG+Iyl2yN7NYj8SXC6eni+8dF8y1rZBoiXm8rqGIJ/Is/xFaa5dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793461146;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mspr96Dyew9GjRaqoBbyrqZlGPtbBgXGKI0UbOV96jY=;
	b=3eShpcVzs14sMK/J0iweBfj1RNLWja/WRKkkuHdPupJB0AFL38jgWV70BDYjyDRzFX1a
	 KHfm68CrSlfNreZPvjiLIeKEKGhu5DAyremwxExcI6OdUkwSmy9DaWFIzhvyi6YsMwCF8
	 SZTutptZdVqAsaX9LRqFh9haVwuFIDuoHXkj/6UHDeoKCj1iUMuwvQa0PvKBEUXTATsY4
	 GUn2yjme+taYOx71BWS5vezhKMF6QQoBtXvo+r7znJ505J2V4bumPH+fJiMy1Oxz+qNZX
	 B07lEcbRgK4VYAky4xt7iabyyvmCSRa1WZgs2jGx/eHsLSUFaGA9XK6P6iWfQQqNvdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0J1TNFm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57B87606A31C;
	Sat, 31 Oct 2026 15:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H0J1TNFm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B8AB1F000C1;
	Sat, 31 Oct 2026 15:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793461145;
	bh=mspr96Dyew9GjRaqoBbyrqZlGPtbBgXGKI0UbOV96jY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H0J1TNFmCNYiAaFJK3l778Sec+Hp9f+EaEq+OwIJelwCvKAoviR/oJ/AwqW2uX0eh
	 DOQYTnZkkAZrE1lNg40zKR0xskJGJHuYNsak5zGpvSYKj6TDSe2+mXfhYqofh9oekW
	 5DwDeOWc5UaWPHYoi32coQ9zA+UNG2Z29bomBoA2wMxr1YBLpWZVlzWFQhsJ0wZpaL
	 JOuU3/IPyvkeSPih3Rehvx+awd5FmK4Jtcx6NAsXRsN3fXcZF7I9D8azpNQKrFeHEP
	 jJy+794UZvO/0ALsOGfzrDcHdcpVFTbgRi/M320PH8eVYUgdphYPjpp8hJvEjIlayv
	 1yWbNNv1uIArg==
From: SJ Park <sj@kernel.org>
To: Aveline Noir <jm5905938@gmail.com>
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-mm@kvack.org,
	sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	Shuah Khan <shuah@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [RFC PATCH] selftests/damon/sysfs_memcg_path_leak: define ksft_skip
Date: Sat, 31 Oct 2026 08:38:58 -0700
Message-ID: <20261031153858.84302-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179342136087.2.16978105493403840270@gmail.com>
References: 
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

On Sat, 31 Oct 2026 15:36:00 +1100 Aveline Noir <jm5905938@gmail.com> wrote:

> Hi SJ,
> 
> On Thu, 29 Oct 2026 21:46:42 -0700 SJ Park wrote:
> 
> > Define the value at the beginning of the test.
> 
> Makes sense to me.

Thank you for reviewing, Aveline.  No pressure, but have you forgot giving your
Reviewed-by: tag?


Thanks,
SJ

[...]
