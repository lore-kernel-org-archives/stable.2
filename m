Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798900;
	b=1hIk6MzoPYky/m0kyDM5X8Knx7WqbYvouTSQI6HgHq/mEB24DflBVJ47AmFVgGwXFq9c
	 lObb3cGpBMHexEozz/4ra/a+dvAOpV5JvG2CPt/JIDR19lLNSnBeHnuN3Av14U5c2cdHX
	 cNodtPJtZ5a1wjnMUgljPVtUbwi5v0V6eboV14mYn+nOwvy3gRRWRH8NFYNkWHANSRfbR
	 tef7igG43C+oBsJTB2be2PQ3/0a4NUwbqtFhLaNybwfXNx4RO7RJr6rkDITyNyaAhFMxE
	 nHWmXgZYhjl4Vxtgoga2u59+d/kYntHUFuSayIOJo/m4rWJ7AawqB/slROVS9BqALkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798900;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TDRqOUoxsvmHPtC+JB3JhOJfKwwJqZXIPJpVBodyNOU=;
	b=vsTEMCR2GWgOjrKv4+OJwQJh90JuMGmIgWAa9nOuTSKYXEFvigz1qnUSIjNPVZS4TG/o
	 nc1CjWPY/5TJGBmn19xakOjrV0+tcniGcXzD5pIkTMQrYuZoe/JE/qY6n1XyzBu+Zcsrw
	 eUF9ed/bYtokd0RGuaEdDayDc50D6wIaT1Q/jNPE/zldEPHLbPoPTwIJjMz4KjU3nCf3t
	 5tz+M4UOtMAyV6O+CmMdMYq3sujjFT+gn/+ioZJTnPHng9Osg6QNnmDQ+YODfIVz6cmIl
	 WAxbTjLn4QwV42s1r2hvGvUQBXItid4tLeWhDSc3x8EfJzseF5S0po70+eE40yVqYAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTwjq80+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB188606A31C
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eTwjq80+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CF4D1F00893;
	Fri, 27 Nov 2026 17:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798899;
	bh=TDRqOUoxsvmHPtC+JB3JhOJfKwwJqZXIPJpVBodyNOU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eTwjq80+25isSuTNiM2xdGld49lh+dVT7/RtmqqngiDbtvc615YT34o9pU1GZcjfw
	 MayI/BIcpKMAZO0wpOsJnGhHMnx2SpBSuXn7sKstyFKFlMgfN6urElEW5/P6J1Gz4w
	 FJRoZZD3RqXz70r0MhwLJdJiUGwZEWXhPWLH1y0SiAjulymeZKJuc96sOiGjyXkvjN
	 tPkRQlqRoX1Yi/B+nnAFZRc1O1cEU+FW0mHyl0g0/Lb0qjRdtqDU0EQKVX3LnRqdY7
	 aTwXIkzR43YyCeLEjaGeNl2cuMQfJEJNQBKAAy+7+tnuJDSwP8Ym0a+9FU7046gxOV
	 synQzRMBdDOBw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@kernel.org,
	Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH 7.3.y] rust_binder: push BR_TRANSACTION_COMPLETE before BR_FAILED_REPLY
Date: Fri, 27 Nov 2026 12:00:52 -0500
Message-ID: <2026-11-26-1-daily-reply-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125180623.2012238-1-aliceryhl@google.com>
References: <20261125180623.2012238-1-aliceryhl@google.com>
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

> When building a reply fails in Thread::reply_inner(), BR_FAILED_REPLY is
> delivered to the caller before BR_TRANSACTION_COMPLETE is pushed to the
> replying thread's work list.

Queued for 7.3 and 6.18, thanks. I restored Greg's Signed-off-by from
the upstream commit, which both backports had dropped.

-- 
Thanks,
Sasha
