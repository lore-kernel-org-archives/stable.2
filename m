Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443361;
	b=euoru701Zq6wqw4Juup8djRhVwwhVgktn5xgA1TRU9nJnAbo0O8Q/6uwc1Cfd5ZuQqbv
	 RpDP9PSztOUVxBladCJCkk3QNPnuoqrboGQIsugAX6UyRgmkCD5l6cRc51tqqgOXz0aDh
	 mgIXdPQ40F1pit35hUsw2NtVVqIBKYU7rvXuvvbDZhv8m0CJZ9oyAPUciR+5TudI8Expp
	 BCYSmRmGTTjQq6xqwovTJE/7deWZPiAtEIT8N+joj+7yXvxL1QrXM/lAO5IlDze0HIWkC
	 pOQUFG6g8V+icWBpFFQSZxUxRCNYK7wY80lnpWO7F7m5jB5l5ooTcBBlRMhmt1+V+xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443361;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wX2gOZNV1APNndXXZSYyzBJHWGMDwSmGFFhAiUL4QSM=;
	b=t+vhbnUDvgFWCKFIiUzGVbgid5AFqligTej8QQKIAyp3aVHlFvqo/Nya6tUFy7YKk3wM
	 mWtNz9XXVN5n91OBXe2bp9KYQZf+Wh1OzvMmWlU/guJzB3Q/s+sJUORAaZs2qoKk6tcsZ
	 7srwpWX3F/JoqdjP9X0LHbKIAH9gst7PP8SzZ/onD0Rw7cqxuYmKf7HaKK+0R40MVyX5U
	 B2ylC/joAcJY4W+C8BKRnqSPK1qt4xHAcCR+bGnK++n+uociZcRzPgKcP9EHhvmZ/Uel9
	 23CEoERhdrIatTZj6i1QQL0VfGQhAg3TthXH9hHYSu1E4D3HmRQN4bvy7wc0vumfbOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EGTiIfU4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C24E606A31F;
	Mon, 19 Oct 2026 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EGTiIfU4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95E661F000C5;
	Mon, 19 Oct 2026 20:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443361;
	bh=wX2gOZNV1APNndXXZSYyzBJHWGMDwSmGFFhAiUL4QSM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EGTiIfU4HydM+kzHFGkFO5+pKfAQA+Oyibb7mnwA327weHGZFIMeL43InqVER3mFS
	 +v2wyEqYYQwVfsG1lM8ElEWRYm1WCiWo14xChH1M2o2N61mgeRL96knuqWBjyQl1PF
	 OzQO4eiykODtz/AeoQ5XqT8hqWDqCr5/hHGBpEvRPnTg0qrbWaEL0rfjrMHTG0NQlG
	 X+lnTMF1J3y3wPfgn/sKBC3AhMLQu2qyPZj+Q+8P68uIITVf5EaR7RHFpIfy9W7U/Q
	 zy5+GZVh77YC0U5Notq59he5ISVPUkW6lP3MVr1/w+8o7aKXypaAgVxU2mp6mPPjaI
	 090fnv9Zjd/bA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	mptcp@lists.linux.dev,
	Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Abdul Wasey <w453y.me@gmail.com>
Subject: Re: [PATCH 6.1.y] mptcp: move the OoO check back into __mptcp_try_fallback()
Date: Mon, 19 Oct 2026 16:55:37 -0400
Message-ID: <2026-10-19-1-daily-reply-0012-mptcp-ooo-fallback-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019111559.2063342-1-w453y.me@gmail.com>
References: <20261019111559.2063342-1-w453y.me@gmail.com>
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

> The 6.1.y backport of upstream commit 1bba3f219c5e ("mptcp: do not
> fallback when OoO is present") put the out-of-order queue check
> in __mptcp_finish_join() instead of __mptcp_try_fallback().

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
