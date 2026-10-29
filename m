Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299432;
	b=2hZLwrUgfQ2DKW9aKrHmAsORWDZAi5gnflDGzuM2MumL6po8J3O4pcunMbxdtxUu5iOJ
	 UPmy9UGW6b9HTYqc09iGsXoXTS0DHImqQdhA4iz+Mlw4o+aUKwtCxoCKr5ARcgsD7zw1g
	 qs5UXKpkaV8cpyBzl192RxhVaRLCBHl/Y44nf98AQAUj0AgORpPYhttKOwMXMPDtl2sOh
	 GYTG0x01GT43yEgcSqFbJsGCQudpGOBP0iPl2futcAaa/V4maiSc1fC25o4jusdU+LD6n
	 pwN6V0lmtHLdpcFSvkL5sYqedRhkBTIUbUKx6kBVqH8KmYzVYI8WA0YBVQpf3xyRogw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299432;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZsmWCtfkjSUIpjrO1t+mOBHz9egmsCMYiQyBvXpggqE=;
	b=y2LTl0JJd9UHDBXROFV04MbiCJdjcYjyUq0z6/xWCnEuasbBlb+Q1MBYojgGw4XaofuB
	 aafn/o65xb8UFIXgq7meFbe9DNvh7Cz6O3V7ZKBGqEGsK98F4gMqD8rXGjP9exw7to8dB
	 USrWZjv+TFq5eCz4+sQuG4NXMfMfxOEtIHreygUGsZ5P4mrNo4oxXhTJ24U6aLTapXuX+
	 QGPtaKy4V2PlV6/woi3KHBNpof4s53HOohTE9f5+rFi8i3+zq9vq96fb1xUg6C6kkt5z6
	 g2RDWAHzVtMCPiIpwfoQYp+rTzjR1FeQ8oMVXRzQL0d3BUQhG9sU43+RfLa6jYCqliw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjarjlCU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FD260A2604;
	Thu, 29 Oct 2026 18:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjarjlCU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6A91F031F2;
	Thu, 29 Oct 2026 18:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299432;
	bh=ZsmWCtfkjSUIpjrO1t+mOBHz9egmsCMYiQyBvXpggqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cjarjlCUJ4uQLQXdiYDh7cqeH/4JdoxApwHcNdOL8aSwUsm/h60OhTyUcHrf6oTA1
	 XxfxzNNH8wY5GHzAuCxiWVYGztMLLTIX/qcQA+ZEsmyai6ie0pBMtpF0NOVWRP3Syk
	 bPHJMTn6wQ1YmVoP6GbMd8sKx7CuDHrn+bLZ+BoXR6yKHEvCuPSniML9R/hqfx2qZl
	 ZWUzzaZIOs7MizUOvEhw37ff1tRnZ2PWiwzSoYQc6JP0j73INjyEeTI4bg0oSX1pml
	 jBRqzk+v5gxKx816lsUvdDbVUlJyFy/+eq6hGJnv2KDgbUVHeMgxaI6rfrbppj3W4f
	 WMIBiAEfgEu9w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 6.12.y 0/2] mm/damon/sysfs: fix pid leaks from wrong error handlings
Date: Thu, 29 Oct 2026 14:43:22 -0400
Message-ID: <2026-10-29-1-daily-reply-0015-damon-pid-leaks-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028141150.160711-1-sj@kernel.org>
References: <20261028141150.160711-1-sj@kernel.org>
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

> DAMON sysfs interface can leak pids due to wrong error handlings.  The
> issue in the mainline has been fixed with code refactoring.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
