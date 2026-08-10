Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF76A4418F2
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786406289; cv=none; b=kOXFflFzI0xKo5tExehCFbAqBm56/8b7fr06XKQ4LhK0j+c98zDsq4cbl55BTU0Mau0q3jhqruka85PFor+/yYRmZRNwKkGYuroierYQcJKWRKzf7q4qQ+kL+YZYwPvecegq/PMmQV0fIQwxuuFwZtgZnwOlCa+R0WclrLK1Wh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786406289; c=relaxed/simple;
	bh=Ku7003Cc6tIHZLPYh9fuIYwYnti0Xinbi/UCz3qoDtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jV7dlQ6FrrxD8U3bZbU/t5/XF9WxVIfcC8ie6FP2rcs/CFZuT0EW6H+7cmZEAbNkARmiNmMj8HLPL8bQ/4HZdaK6Y1Nv8bEim7FRLr1zbbslcV1kXLE6UdiXR6yAqK1h8GA7m96tLnHSlJF0WHl2Yqu7ZRHjO4GV8b4bkm+fBGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LraRrTlw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LraRrTlw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB9101F00A3A;
	Mon, 10 Aug 2026 23:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786406287;
	bh=JCmxO5IjV9+G5UjSwOg7uvLGXJK8rFidrf9I6IRRMzw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LraRrTlwHMyj4lAtArybBEdMWuJdOh3ZBm2YIiyI6DP/Hn+bUh2mrT2E3AUDT4XkU
	 iWl9+XUgPXbEr4Jo+ijJ3qB3Y9HJ3+P3RFYaMu5CRVBP/frGY8w2W6kXKkPZX+b9JP
	 iVBkbBU3pWkw4wUXKViE17WAkfBUVb+Y13zvPQeA869p0Div90Nqk7YGWlk6nxM16I
	 FDkjHwUFd4iltyhAhDkLM+RX7gKZKV57KNFGvxs4jYPj2galsgKpe+HN9Y5ENwkmW7
	 mVJaeJ92d2408Y5jHDB5UCpNZ7N985XuFzNnY63+zMZAK4jnczWhTNdLdvx1i2oSKG
	 2A/Ye2QSQhLzQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH 6.12.y] gpio: pca953x: fix pca953x_irq_bus_sync_unlock regmap lock
Date: Mon, 10 Aug 2026 19:57:47 -0400
Message-ID: <20260810234738.0009-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809235632.1856553-1-mark.tomlinson@alliedtelesis.co.nz>
References: <20260809235632.1856553-1-mark.tomlinson@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Locking is disabled in the regmap config as this driver uses its own
> lock. This means that all calls to regmap functions (read or write) must
> hold the i2c_lock.

I've taken your 7.1.y patch, but I'm holding this one: we need a 6.18 backport
before all the older ones go in.

-- 
Thanks,
Sasha
