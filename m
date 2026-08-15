Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6661E7660;
	Sat, 15 Aug 2026 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786761214; cv=none; b=GpSED1cHhhFiAV/wL83RY+/UpV7vQE3Ze0kRM4NQ7ZZrDIiZ/5OaVXMFOUunM4aiwOBX84ESF0ga9B+ZLGhRj8rmOz9iuWLFgTYaEGVjzmtgvNJYrUVeWzstsbBmYtTPO1xtK7nLcHa1wqIc1Iu7fIocyNm3UeHxuPEfDsNI8LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786761214; c=relaxed/simple;
	bh=6IKgrmnFFox5ChhTfX+15w7dbSodb7sTg5ZsZ2R4z/w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VsfyfHU5QWf3vxtL0kRBkzKldUnnxSKPRxdbvDQ9eTTvlY/Bf/zz75QkQvraYV+ZPi1RlPhTzZNjtKQm2DcQzF31PAOicATgsRhvuZy3qGpl+1Qql8ibQWjQ4qKGDAkUhBPRztZkpuv4jn4C+DZPReASkgYaprTzp9mDRE44wag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H3rBBgdT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H3rBBgdT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D0D1F00A3E;
	Sat, 15 Aug 2026 02:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786761212;
	bh=MnsYRclaPBu8kknIxjQKDR16XXhF2YUS7T43EkqkGIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H3rBBgdTX3s1Ru7gZzAhocqa6H2gzgfg1+hhl0g3PFjrJzLtq1e06qqfUXfdS75EY
	 909Q47iuS2hQqXeuhTzctQwsSGo+LuY5eiWgoj0mbpkOITWgyl6xi8aihVwk6HGW9C
	 nd/qHM5WLcpt6fdYlaTCPoSJw3oR4pnKy9SENoprLFX7gz8kBjGbVCyPNagKk0rxiS
	 0gWx7cW4hXhCadtHN4O9RFICTPCoKk2xyHuNZ8BswygTiCkzC6OBBMAtXW5+Lue2c6
	 RN63dPezqn5IMCXAxH3pzIN6XLZVNeGxqge7qF67N4ngiiLcXS6j7KSy8gNf0U+qTB
	 NeWZ5w0o2tkKg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Simon Liebold <simonlie@amazon.de>
Subject: Re: [PATCH 6.12.y 1/3] block: Reorder the request allocation code in blk_mq_submit_bio()
Date: Fri, 14 Aug 2026 22:33:07 -0400
Message-ID: <20260814193000.7@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812135412.2715611-1-simonlie@amazon.de>
References: <20260812135412.2715611-1-simonlie@amazon.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> From: Bart Van Assche <bvanassche@acm.org>
>
> [ Upstream commit 44e41381591dc5b4ea67a9f170b4ec85c817586e ]
>
> Help the CPU branch predictor in case of a cache hit by handling the cache
> hit scenario first.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
