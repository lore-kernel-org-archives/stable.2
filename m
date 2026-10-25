Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971006;
	b=r4iTXDBKMPEth2UEeRMWCI7WEulz0xWf3uzN8Uhv+5tOf2VuPbNSNanrj5v8jImDq5Kw
	 KOYfKxn6LQeUJ6Pe56W/XjTxVt/YrEk+rTMvy1R9AIYsH0JAN/DKmWWbdiX+QEuWJv3gA
	 jigigzafpZn3Pufejri+KBqVb0uUHJ64nrSi6682dkM7wrVUEwOyRZofjI/WpvxoQgMwO
	 SfiPApOKlW6Rx3J7876m4Xclfw1/AP90Lb8pWN9MeEhnugpKfX/TGi8hPy+XH9Q7r7Eyz
	 qBS8JIPYZl2B23rHVlWykUQWr7FZCojNn5odsyf8w9j8smYVbgmvaydIrKALIWTLpUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971006;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sWx6l1uH67lmRdxqqC1BqRd2rIEg3mHZHVhaXIsbxyw=;
	b=B4lq8MrfnAH3T///q+Gb19NYolQGvGcDsyCppUWSO4+mxf5apdj4uNtFufrIR56hrEDw
	 DZn3tCEM6iGJ9DoVgEI3lxNyHnxHB07VkHzvSkphr/l23wC6mlx2w7X3eZY15FOcpLVId
	 /yUrE19bMSWkvbK1Ea0r1EFz5YwxtVI2ARNoPZUHfc0JXvyTYtiU6UtuJdeVPahiQNbaq
	 pgyW/rtfmybHCivt+UiMUSmi8P8aiZY0JxjPHe66BNplAjnUcfehSjBvR6EjCc7I2D3vu
	 W/oKAu6TXBt+k0ywTp/saPRrNmss6zMIEhVLalt8hBC3uMsfGXOhc4EWZgxeHoR3V8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="X/n6M6Ga";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D18B606A329
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 23:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X/n6M6Ga
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47DA1F031E2;
	Sun, 25 Oct 2026 23:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971006;
	bh=sWx6l1uH67lmRdxqqC1BqRd2rIEg3mHZHVhaXIsbxyw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=X/n6M6Gak7qTGuZ0sZGYSKvc2PxcFkoGCnKt7+53wtrwPR7J6riwEySx7xxnOK2qg
	 sApWJT9kXgrYRi4WQZGO39X5F/PkGhEpPEu6KY4J3dHQzF/mpp4OEP9hB4HmzbedBX
	 42hhQB1z0+hbyQMSlu9rzd/IjPlDIRiBwgRb910FFI9SxZk6wju/bgver+aREj5THD
	 RIaJR17CIm9/Ehdp7HcK4oYmFNV0DLxnC7+rHKnq901Ve70ycNlYpIkIB6/N2XHn1P
	 sqZYSHaCK5RASMIR3fsYzbNBaL9jp+JugYxdbGibVMPRd/D2mVpIsDdTplj3E0dl9/
	 KcmvkdkXLMg6A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	JongHyuk Kim <malhyuk97@gmail.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	linux-mm@kvack.org
Subject: Re: Please backport aedf2efd1897 ("mm/pagewalk: fix stale walk->action escaping walk_pmd_range()") to 6.12.y
Date: Sun, 25 Oct 2026 19:29:52 -0400
Message-ID: <2026-10-25-1-daily-reply-0006-pagewalk-stale-action-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261025054505.1448278-1-malhyuk97@gmail.com>
References: <20261025054505.1448278-1-malhyuk97@gmail.com>
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

> Please consider aedf2efd1897 ("mm/pagewalk: fix stale walk->action escaping
> walk_pmd_range()") for 6.12.y.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
