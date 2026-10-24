Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792872683;
	b=cWra4+Lr2ZeW5jlwkfKwBqBpPt1RJ1LDwGxAb6PiKtOXGBLVnHiaFzGgBPPkwRDgGnUd
	 1UARsnQxpTY94Q9CiwzD49cFojD1QozaxwtF+Xa/DxhxyAyw6P8egeqR4LAGyaZaD755L
	 CpZJHOubRjv/nuVF+Uhv4v9APtjPLVZV6Mo4GOuR5ArX8BJkKtxrDKX5Hz2axqmih8d/D
	 rlPmU+k8cDCgzscPszqGDAqu1xqCog9HpFStdMG8ybCOp5b6Zk3e+BQ+ohuKl6Hugfg10
	 MWv7xJHal9Kcv0isxG05LdUASyhtkO85MSN9eg5DRmqw244ctXFaVXURa593LBWjwaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792872683;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=1QAkdRsJVKTlKiztU9TqAk4OE9mbK+2pCFzT+fsIDG0=;
	b=QLc7FsJNDqwcDNqSWQTjgFZbP1hd/QjEiO+NubRyZjsTv79XTZtR+NXP991ZaZWjiSZL
	 dyQFY8LLvGaoTdcVMhEbDAkXEYX0LdV8UETuaVgO7DWbyn+RCG7iEht7bGZ6DxI1D66N0
	 2E3tWnZo4mQoK1tq7vplfz/7waYE+qEz4rx9wAsB3eTN63V12k20/ZYsXI12rROhZNZkX
	 Ng23+adew9cNj4Da/kgC91Gvf5KKxeg4PrCjF0sCluzg3fQsO5rQCn8S8tdEpywNC4qXj
	 8XMOcD/q99v8Nowlf2b10/WJ+jNLhr/pUt/tFdf4W6buZ3vFpDWeFx2AS1X+hlvA0+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KRdJUrEG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996AB606A31F;
	Sat, 24 Oct 2026 20:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KRdJUrEG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CAF1F01829;
	Sat, 24 Oct 2026 20:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792872683;
	bh=1QAkdRsJVKTlKiztU9TqAk4OE9mbK+2pCFzT+fsIDG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KRdJUrEGh8VDXSkrQT3EkvmRHG1bULOYrQnqvSX3ix9PnGGa1PSC+OBmgFS38ueRz
	 mywtFnUgHzb8ZFpF5AfkqzeqjCYsZ614eN5S+8Qk99z/bNZPqIl3vlHTTs2azoo5+X
	 lZ7xWrxPYb//Aki3iaNAGDn6F4GdnaAAcMgRaieGLxyGBXNvNstdunCpPOOmDmm9o4
	 pg4amm5tq2+qCvjYI9BdCrAgoyOR9S95tPXDDAyqn/XGz9WsZZEP9wdp5425t+wY9I
	 wE6uW/CxeOjA7NJjvTISkRn/bzuQTHrmvj4OyUYsm33V2wGj0EakTFjEiHayNokU6I
	 IKstvZbUE9xnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	kuniyu@amazon.com,
	lee@kernel.org,
	netdev@vger.kernel.org,
	Rodrigo Zaiden <rodrigo.zaiden@canonical.com>,
	Tamir Awad <security@auth.ink>
Subject: Re: [PATCH 5.15.y] af_unix: Clear oob_skb in scan_inflight()
Date: Sat, 24 Oct 2026 16:11:00 -0400
Message-ID: <2026-10-24-1-daily-reply-0002-af-unix-oob-skb-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <7fa31470-872a-4fb8-9c8f-51dce38e9190@auth.ink>
References: <7fa31470-872a-4fb8-9c8f-51dce38e9190@auth.ink>
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

> This resends Kuniyuki Iwashima's March 2025 fix for the old GC. The
> code diff is unchanged.
>
> @@ -102,13 +102,14 @@ static void scan_inflight(struct sock *x, void
> (*func)(struct unix_sock *),

The patch is whitespace-mangled and does not apply: the indentation is
non-breaking spaces instead of tabs, blank context lines lost their leading
space, and the @@ line above is hard-wrapped, so git am fails with a corrupt
patch.

-- 
Thanks,
Sasha
