Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D153EA959
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788985606; cv=none; b=mg3vFQZ4rOiMc64ZwiM9wcaMjVk/3ZUlzFKscd+IDa0QxzR3Bjkh+dGgFnm0PcS1W31fj4zP8jDELCnPR+ArbKzU+6iegbWuV/kUjbafzuUvyWLQ2YCXkekGyFLO19SOKOO/RgaXmXp9TSaJYAXmf2JJB4GPFE4Wqe0eaTir0VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788985606; c=relaxed/simple;
	bh=8UZ/7HoYtMvv+3PoXes6ZAF+MALsc02w+H/abmlqk2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d9MD1P5wBNBmapH3sS0wVst1R+ol0EdHWrVScJR7b3oq2Pi8+mP7i6hgcE73EkEQrvQGRja+QXeNx9PQkCdcn3jYD2y9M/7ZdfKfAAnbed93OF/Rf0AnSvFtnW0vTEVw1T2Vz+yN28KBA9n6/t2dmOzGUs/341tSjsyafgFsNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hclkvXb0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hclkvXb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 920D71F000FF;
	Wed,  9 Sep 2026 20:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788985601;
	bh=oZvt146HY5/cYP95yCuAv5EVB+E1dVG2k3fsP5i5FE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hclkvXb0QOGac1ZkTUjUB/WyJExmI8dQXuj9DL516E0XYWplvjzpFKHn/LmGsGXgl
	 MX2mWF+4ppdD3UmQ7KV5Y12pAR5j9Zaataemo9FbnyBN9adYEbyh2S+kb7w1QsPMWY
	 LO6ImevfLf8FX2tTvU5wxYelL2sdXqmzmJ9dSbWq/6YuBtWKI/LtIF/KLalmc2TLVr
	 5dKuqdHvjIdSgxqhmTRXJc5Py0qFiZpSbxJoGOhJhwsCxaVMS/MXgQnd1Hv5gCavvy
	 6PG726EIMx7B5rJqShG1CKNJa4JJB7GMpHOukyj0hj+1RuSQXn99set2CuyI37B7xK
	 KqnNjzDDkFGHQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kazuki Hanai <hnkz.64@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH 6.6.y] nvmet-auth: Synchronize timeout work during SQ teardown
Date: Wed,  9 Sep 2026 16:26:04 -0400
Message-ID: <2026-09-09-daily-reply-0006-nvmet-auth-sq-teardown-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909125209.1798946-1-hnkz.64@gmail.com>
References: <20260909125209.1798946-1-hnkz.64@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> nvmet_auth_sq_free() cancels auth_expired_work with
> cancel_delayed_work(). If the work has already started, cancellation does
> not wait for the callback. Transport teardown can consequently free or
> reuse the queue containing struct nvmet_sq while
> nvmet_auth_expired_work() still accesses that SQ.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
