Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793055368;
	b=BZ7Tcau5pUrZMhqCmo861pOdn41BE+RmWO0MI0vBi2E8yyWhU45rqm8vnJ3vDZtK+wde
	 I69RJ2dggeUd2UOFTxusm9UIyLnwlMN5dOQejGhAJ9w8qt63jPkrtO5VOnsN8D7m1Nsgk
	 gVGFr6l7goeYM6ePCSJCig/NY8qP6E84+D8OsgZtgirczbc/EpZtqQYKmybZHTjdy0/q+
	 R96ABW9kxGztGqvKalZCVxluyco6bCcTLuoe0q+DoJPxix3dn/eCIiiFHYDeL1Lbm6JK1
	 1EtNGLhDustk4EcOSIF2ci9Eorqif/0obABIFhmLAEsJ8S/OQQSnJEUfiqyG74ThfsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055368;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kDRiWJeMZqvF6vqXY+N9yfNAfM6lhJN4gULkYvRyiak=;
	b=SbJgeI8cjOucxdvKtzDuM5ZZu4XQEQRsjW+GH/LMSSD8SIDPzAdVZD6d1tdnV04SUg+o
	 Ow0ChkCYwVDHeD65Y+45lVUkTAEJQujCwCUp5fUZjNdYV+e4JFUxdN/QwYqQuu9RIuxFY
	 t70RHXIVwRyUL7M+EzJCxm4Q/qCRv2CgmOBVyz7juwYa+kTPFXiYdbmopoXd1dOD7ZrNA
	 rLisWV7bUoBGld4L/xE7X80wj0dA9vHWjoF4EcTgNOKmnYNtm3MJqgscZiQWDIaWv5iX3
	 3lhl3xrQGr/0mbG8Om+ocCAXEVLtxqSBDIbu4giS4iLOAoEK3BkcT1n+SF9vNeCE0yw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JA6O2W7j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171B1606A326;
	Mon, 26 Oct 2026 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JA6O2W7j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E29761F01828;
	Mon, 26 Oct 2026 22:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793055367;
	bh=kDRiWJeMZqvF6vqXY+N9yfNAfM6lhJN4gULkYvRyiak=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JA6O2W7j6unWHhshHnkD/s//HD6Gtrrxz19ZJJp88yY8baS14aOi/vhUL9vmbQFoS
	 YlCnw7TvFUMhJk64ZYoPjt3OMOnK8zJ2oQjFkyu9W+VNz93QO51yxzDj1RmljmeT49
	 jCw0KgpYmfxg3j7ZZM4qmjjs6fx0/qNxyAs0s9SWeOnQzFA8SHMclQsgU83RHmaTsD
	 hkNT63KrvO/8yXP1sZU3TQ3kuzUPk4y+K6dMrAzpF7eWXz37BThopS4aUsG5FNh6sr
	 /VEgJeNMtrTnrhtLZ+0zdQAAvDBEURk95nPKgwo+ut9jeN7y8uxuG8lo4HwSab71fV
	 Q1MzPx4yhnwAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 7.3.y] mm/damon/core: error damos_commit_quota_goal() for zero target_value
Date: Mon, 26 Oct 2026 18:55:55 -0400
Message-ID: <2026-10-26-1-daily-reply-0004-damon-zero-target-value-7-3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026133320.68445-1-sj@kernel.org>
References: <20261026133320.68445-1-sj@kernel.org>
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

> Notes for stable kernel porting.  The upstream commit doesn't have
> Fixes: and therefore not ported to stable kernels.  It turned out it
> fixes commit 8b549a4fd3c5 ("mm/damon/sysfs-schemes: commit damos quota
> goals user input to DAMOS") which was merged into v6.8.  The user impact
> is a race condition that can result in divide-by-zero.  Hence backport.

Queued for 7.3, thanks.

-- 
Thanks,
Sasha
