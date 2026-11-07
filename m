Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794080952;
	b=Md3UppdNC83fWYLKWT0niMSMUn8Ajv5CV/jEsw45+XnJ+opwswn6BViLQEIFtkqPxzrU
	 nxvFIUKtQTewrrRjwdsOwD6cTtNJalO57+pfBw0Jq9adrGJZ33vYJ5w4BtQSCRpIbv9ry
	 ZHGgNHcapko67JGdNvRvXDP6TgqnEXY5tvBL52rxwCjZV45Y3oEifKTbAaVhpYYrs0sp7
	 LRFA06JQFvBAx2pp0UnV33p0paet3QfQwAuHdNAy9Y1d0+RK5gID/fhBqYHviYgErIvqI
	 hDppZMMmtwmTkXzAEKa0lo5s0y0bNhvzN/YjiqRf93SUz8msYdCNVt2nViDcQ44xm3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794080952;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UpqBfU7WaNB+XTlyGDto7UPQvAE0LO06YrZvq9JbcNg=;
	b=2fvXTs5+zF/vWHQDP5mtszfVnKPZ08dXMdzLDs+uTtmZ8imbB4nWmqcEdvJfqDK8gXRe
	 XF5QCjGEHhAbYmmQR9BnJmdHe4RTmqx8mKJ3SWxm4JOprTvWKIZo4pPLuAXKD6JGL8SBw
	 o+0pQhsjI+z/pSkF21LiIRrjJCZgi8a6dsSLzw2nZuQ5luyuVCfRjq0fFvkY2nArTX+fr
	 B3JOPBvOiGfSylLqkOIvDkWqcx4Vq19B3V58jb3GCCMauSxhABk0hqvDzSa25IN26RbI2
	 RdsBZ5Wv/5ytyBe0jrO+wSwOG1PMkdEtGMRG5LWUT6+07MhfWTHtuMPR7D71B21Y9eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWCzubg5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED92A606A32E;
	Sat,  7 Nov 2026 19:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WWCzubg5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 489611F0089F;
	Sat,  7 Nov 2026 19:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794080951;
	bh=UpqBfU7WaNB+XTlyGDto7UPQvAE0LO06YrZvq9JbcNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WWCzubg5LrlTsGxWW6thhwd/nCdi/y1LJrNsfteMhti10gr4Yc5gnZVEEy4rR4r3P
	 riGSnxpHSQRqQufNg00xPsEX4zKmwVUxFLjMUpxfrs5yxhlhlnODBQlILJ1ir6R52Z
	 2cfPq2MAWjQrl5Wrz3NKK05Qq6pwl5ys5CcsDWUjTYxjIQB98ALDwb47G2Ampy81aP
	 71rBtEnCRqu5zfSIVkvfz+FBcAG+95Pg0fUAEOMW8sLBqwzuSuAEqgXMTXeOTwqwdH
	 fpEudWOO3jzSiFTx64WrVaoxNLir4+6FzVbnZ6xzDwUGARF9VWwJM2v21s/nfAQySe
	 7F9xh9yrOyYog==
From: SJ Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	akpm@linux-foundation.org,
	kunwu.chan@gmail.com,
	brendan.higgins@linux.dev,
	davidgow@davidgow.net,
	usamaarif642@gmail.com,
	stable@vger.kernel.org,
	damon@lists.linux.dev
Subject: Re: FAILED: patch "[PATCH] mm/damon/core: return an error from damos_commit_filter_arg()" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 11:49:02 -0800
Message-ID: <20261107194903.198536-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261107051022-failed-6.18-6f276422aded@kernel.org>
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

On Sat,  7 Nov 2026 05:10:22 -0500 Sasha Levin <sashal@kernel.org> wrote:

> The patch below does not apply to the 6.18-stable tree.
> If someone wants it applied there, or to any other stable or longterm
> tree, then please email the backport, including the original git commit
> id to <stable@vger.kernel.org>.

This and five more patches [1,2,3,4,5] that cherry-pick-failed for 6.18 are
wrongly [6] have Cc: stable@ tags.  Please ignore those.

[1] https://lore.kernel.org/20261107051024-failed-6.18-1bfb9384ae0e@kernel.org
[2] https://lore.kernel.org/20261107051027-failed-6.18-1d2397b2c414@kernel.org
[3] https://lore.kernel.org/20261107051029-failed-6.18-cec08aad3def@kernel.org
[4] https://lore.kernel.org/20261107051032-failed-6.18-a1c7fdaf1657@kernel.org
[5] https://lore.kernel.org/20261107051034-failed-6.18-409d2ab6d982@kernel.org
[6] https://lore.kernel.org/20261107194352.198354-1-sj@kernel.org


Thanks,
SJ

[...]
