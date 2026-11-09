Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794186965;
	b=G8rX2av0rHUtAFuGcxI0gu/3KDjuGS47pfj6plG6BujZRlAeezr1DFNIgwPuOITYi5b1
	 31xCmuhz0hYS+ESD/PLJhTqZDHdZY1bohb8EYMbWrADaf1YRwTxra1jorUJZdzmZBeP2u
	 bEyEn+d1jzOFmPKyfwqlu4e4mSQAT6Tjwzs/VdxBvv2jeluy1CHDYRWTaxpYxvDI/ZMkj
	 GrKcBuOounDF6FX368Ig1tSDpfrkPo2nFNI6lUUBfibswjYQwrHiV60gboc5jVjHgNKoT
	 XG57soiEuczRUP4pppcQ9oC/cRT5XM6APGWCW4xOAUugBQYTC7xSU3mqHwvdLYDfCeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794186965;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xxDhrEIYZttgbFY7pnbXOVDKWaxrd78v0tNIwPh5P5U=;
	b=m8/w0fnZies6TcD8zQ5fF9qpFdhrD6/wvvY/NgdmimZzgMSisorJKPbTFYJOyJprzQAY
	 46849kPhc+15VUyQLx9QDRHXsVNWsHGspYear+GEk3Z/pD9I2bP9ew0hGM/88xDdgYJnT
	 xsDywQcoiGARLAupz4lc6AF+DMcaiFDkvFpyYV8V28bTWaYmwiiXWY11Dh0bWhDxbWy0Q
	 2o4kDsr8XAVaNvrlhY3dkaBNrkuIYd6wFChhnMoLcv1flA7IwqQSL2p0/5slat/3Lgg7d
	 gpvbINlfsJeToB7PlfxPb5TS2j/BxNEmjBQP0lH45hcpUciPHo8Wmc17q5FEjeikLSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yl5LJAvU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E21606A31C;
	Mon,  9 Nov 2026 01:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yl5LJAvU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBC51F0089F;
	Mon,  9 Nov 2026 01:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794186965;
	bh=xxDhrEIYZttgbFY7pnbXOVDKWaxrd78v0tNIwPh5P5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yl5LJAvUU+oWPByuTAm4vJ/x1vXc8vFn6kh7xTrrVz/NwSNIYbfncKf5zO1ZnsctW
	 rbyCz5/C9QBweG4a6jhnx2GJgNnLkr7i5927R0jWo8KkEMrhaLT0ovPigvB99ZEpkw
	 R2tMsYRywFEN+MFB3kCgrQ+dAbmdG8nGVYB/Zf1RNm5qWNoH6xTN6HJr0ZhbsZTEVS
	 vrdkA/wD+fswvNrrJ0ROc+CCHSEmbv8dTzBPwIUbbBRYJtCV9E+73Ud/f17ygjjfya
	 HPUl5/nlPEa/uLYV6yEpD2F7fkw2/IG66aF1qXmcxT2nM0/BM+V4zlMRGV/V6l39u9
	 CrFBfRBAC0vtg==
From: SJ Park <sj@kernel.org>
To: Sasha Levin <sashal@kernel.org>
Cc: SJ Park <sj@kernel.org>,
	stable@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@davidgow.net>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Lian Wang <lianux.mm@gmail.com>,
	Kunwu Chan <kunwu.chan@gmail.com>
Subject: Re: [RFC PATCH 6.12.y 3/5] mm/damon/core: handle uninitialized damos_quota_goal->last_psi_total
Date: Sun,  8 Nov 2026 17:15:56 -0800
Message-ID: <20261109011557.92525-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <2026-11-08-1-daily-reply-0009-damon-6-12-psi@kernel.org>
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

On Sun,  8 Nov 2026 19:34:37 -0500 Sasha Levin <sashal@kernel.org> wrote:

> > When DAMOS_QUOTA_SOME_MEM_PSI_US metric damos quota goal is set, the PSI
> > delta for the feedback loop is calculated using
> > damos_quota_goal->last_psi_total.
> 
> Patches 1, 2, 4 and 5 are queued for 6.12.
> 
> This one doesn't apply: 610c4438fb66 ("mm/damon/core: error
> damos_commit_quota_goal() for zero target_value") is queued for 6.12 and made
> damos_commit_quota_goal() return int, so the `return 0;` has to be kept. Please
> rebase it on the queue and resend.

Thank you, Sasha.  I just rebased and posted [1] this one as another thread.

[1] https://lore.kernel.org/20261109011347.92467-1-sj@kernel.org


Thanks,
SJ

[...]
