Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794184494;
	b=Wm/cGKzgwpSrflSIUUMPYE8bFw2Cvq5DQANv4D8HqaO1GCBrTvvcWKcs7ANCfS2/APGA
	 C69/iorwRvm0AC6UaczvPJjEbYJTwpm3Sp3dSkMA8t4gfJHfvPgBDoMjpOGNIqLwSu8uA
	 YH8DX0eckdNrRN6+DqF8pTIuW6kivKuVoyJhSY1mjgTPog7tXlzGPWWEIWQzqg/veCdEz
	 ZY8GcvhkkFjtg7cmMy1pIj1bWds6taV5ijhOZARh8wTrrolxu1EMnX1bR2D12wkpsq4Sq
	 A07X1V2AlhB/dhvlOCqMpEM5lJk0Uz6NH6wuIQ6yz2s0AVrEBBLUl3CjVcO+b2e8XRg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794184494;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xl1uHkh0YFazEsJHZdHR/BuAnw8mD4ZxAEBabTwSKvk=;
	b=B0hx28qC5w2OglH55aMoAM++IoO22odyBDpOCl71JQbcRn7b2TTCh+cM+7QB49anLU1J
	 hB/Iaw4OnqNEaGituQ6m5Rs+olcuVmpCnFuEZa9H89MhlhxVxvDFYJF6rAo6JvzN2PIJX
	 AbJ2ngiwTBZKf++jBTZemz4Ip6/oyyOi+ZeqRW64vU7Si2gv8p1N3+9xfmA6eb5TqSJyE
	 M7COoD8o/rjFAvgK5Ut0cvLc5aQV51PDiKx9b/mU3w2nKKcFZzE6byVInTGTNxj6wZxpg
	 7GB4MafNgjK4PbXYrJZc2f/xyb/9lqyuW4OW+vqmZLsziUgBeUbGQ1gQeYPwm7evMgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rrjv6iwi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D7A6082BEA;
	Mon,  9 Nov 2026 00:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rrjv6iwi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C00F1F00933;
	Mon,  9 Nov 2026 00:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794184494;
	bh=xl1uHkh0YFazEsJHZdHR/BuAnw8mD4ZxAEBabTwSKvk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rrjv6iwiOsdMi7oO1pFZMq/5rKZmepfksq89qEg58CmJrdEONi458I4NBKHQ5TKcB
	 eAnEnw5QYchuIATDNrtmkjZ9xmrF/KbW9FcrPLU52ypTYSEYQVZmNvhiRvQGn8vq0y
	 UgkaTNOSiRo4bvImFeP7Ua5tBso3SH4t5to15zfMCkF+gR0MS5duNblwhdnlBO0Jga
	 7grNdSHO8eFtySuvrf9Z8dPXTsJeYmd3rLh7B60Kms4zFXmffb298r2IydHK62Nft/
	 NRlCPFF3c6Ifi77pztIc8rXbH8aMsDQU71KNt5PPymPjMM9sh4SXGQxWrXwLUkoLqc
	 76zcc29339Fow==
From: Sasha Levin <sashal@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	lee@kernel.org,
	netdev@vger.kernel.org,
	Rodrigo Zaiden <rodrigo.zaiden@canonical.com>,
	Tamir Awad <tamir@auth.ink>
Subject: Re: [PATCH 5.15.y] af_unix: Clear oob_skb in scan_inflight()
Date: Sun,  8 Nov 2026 19:34:39 -0500
Message-ID: <2026-11-08-1-daily-reply-0011-af-unix-5-15-v2@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <08E5C4C3-189B-4B0D-94F5-5C049EAF6DA8@auth.ink>
References: <08E5C4C3-189B-4B0D-94F5-5C049EAF6DA8@auth.ink>
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

> Hi, is there an update on this?

Sorry for the delay. The patch as it reached the list had its whitespace
mangled and doesn't apply, so there is nothing to queue yet.

Could you send a clean v2 with git send-email?

-- 
Thanks,
Sasha
