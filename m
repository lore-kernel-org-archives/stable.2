Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A8C2E2EEE;
	Thu, 24 Sep 2026 00:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790209270; cv=none; b=JsKKXsYfp3DCHePRCIbJLqOqm018XXnrfC/9tOfLKQBa7/HTNSqTitIT4Qrts+kBkmlkB2J0N3rnTtGbpXZ54nLL1isCkzfCU7AG8+AI50vkPsEzakTPFsv0/eFbhy0kgZ+DCHhk7M5SowX7IIigMuOMu4fucA3mkal/MVISURE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790209270; c=relaxed/simple;
	bh=j33SFjUs9bLkwK707rc6w6rTDdvZWFTeFKPrLmWy4aI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fyCiqimZysBV4lqO1pZhD3KI02PPlI9Npq2GMxgcJ+HKvXgasrpUmVDtPdddvRqOA75sMgy4TLph+iThH1+QXWXsr3KdxW4kpGEYKnbq4DSQasR2GlJlJ1CIzMnVEAUBWIbb2idXMWtHzMYO2WapUlp69OlaPocCibRNBn01INU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+mslzAC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+mslzAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D20D1F000FF;
	Thu, 24 Sep 2026 00:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790209269;
	bh=f44/3BudnhXlJCUexHQgGy7lXIQWNaW3tCRELozZTgw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b+mslzAClwTHszWQXJtRSucaSVT6wKVZHYQTk6eqr0HbC6Cupzi3QThpY6goCaPbD
	 Kxux09/L5r8qFd19C1Nwu6C4gpRRxAZn+RTu5YLYg5QUFIeFfxI+gdHofrqv6x4snb
	 x+ehiNjcPz0c3Gm4UCLM+z5c0aY8FQJMf1eRyzBun/KBM9uDrIgYY3stO5CjkhvWOl
	 dHrcgh2iW2k0UEmy65tIaJYAGL9Dj2ykh2tEkEbPevytb4aWTjGwH+ZSJ6l8F2Jdfa
	 4gGMj6qs+yk6g61JwGnjfV+FWgCIbN9uk8A/tYUfUha7dahadof0pb4zVMaJs736gL
	 V853KfHvoGKpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	axboe@kernel.dk,
	asml.silence@gmail.com,
	felix.moessbauer@siemens.com,
	gregkh@linuxfoundation.org,
	io-uring@vger.kernel.org,
	Chen Xiaokun <shinnkka1@gmail.com>
Subject: Re: [PATCH 6.1.y v2] io_uring/io-wq: Fix memory leak in io_wq_create() on success path
Date: Wed, 23 Sep 2026 20:20:52 -0400
Message-ID: <2026-09-23-daily-reply-0003-re-io-wq-allowed-mask-leak-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923064315.195997-1-shinnkka1@gmail.com>
References: <20260923064315.195997-1-shinnkka1@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> In linux-6.1.y, this backport introduced a temporary allowed_mask
> variable in io_wq_create().  It is correctly freed on the error path,
> but is not freed on the success path.  As a result, every successful
> call to io_wq_create() leaks cpumask_size() bytes of memory.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
