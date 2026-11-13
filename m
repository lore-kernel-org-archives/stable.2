Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537225;
	b=XMuZ8F3dqBOnYA1Nz/SuosOu2JB9GFkuWy8yXmg7cVQfBYLDLRnOGdTdmJ6SdMowSHfb
	 e3rWj+OwdjGRaH6ZWzmiGhu8/vPy3DDk6iL6Z4wzkco/OXjN22Izx5N+ILGhp1vTbA4Wh
	 nGd6Z/ww4iVmayMgrnAAT6cZ3VpwY3KWj5wImt1xfCmSZ32weJDuQvpSW+wNuXfOUdlKo
	 m1VNqyE2b8PH+vdVxMj0KjOWLDQ77j+UpuIFVVo9cWo6lxteyfKwnF4upxO5pYe/Smesz
	 kBOB6qdcwHRcODVS6lCm8ej7bbpJL38B7p4i7NBdJIZkPDiEiRP4gnYAYlvq8gge6OQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537225;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8DY0UdgeLd+dTsyn6yUub6xlGeK/sMPHeEmOBI6IJ2Y=;
	b=IDIs2xXCKZEHGJgOzrqpvfZPTIZw1x79aZI40PgZbH4vIgQkqQRDDpcHhljilS2IzuAK
	 296qICkYr5VDSzpXwTPKxKaJ1K2jXkOHNZsQPJlYMXplW4K/hyrSrvr+dZMTDxajBUOv+
	 oT0TA9OCbNfQKtL4MauzgRIA99fgqeZ08RRsfbybgf23EN5oKkHKfpRO+rabNL4jUDd32
	 HuZhfLwGl0P2KEfLHtr9ouw4uczclDWT6VJbmKFc9bUtGqgfSZiiu8rgiXzE1+qhj24ar
	 cF1v6g+tC9Bk/QxE6tEyeflmV8PQapWoCq5BV4F4KDiwasCZWbgCkCAIi+8Df5ARgtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbNFL8Gn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D5606A323
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbNFL8Gn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21D51F000C5;
	Fri, 13 Nov 2026 02:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537225;
	bh=8DY0UdgeLd+dTsyn6yUub6xlGeK/sMPHeEmOBI6IJ2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BbNFL8GnLaf/JDJ7UtKGP9YN9yvqwMo/XPEP7kyy9cvTxuVja0VGFQmBhhhocnJ8c
	 VJj4VeZwc2AxAuIwMfAx3Ka1ncfc1KvvtjA/GiMzDdr/g/IPmpuyxHzEVTk4lETGIv
	 OSC5TJVJSEPArPe46AdKEsinPXlvhcvaBrPUWiWmbXGpXKm74eGP+185mLFYtooq74
	 TGoQx6H43/A9UK1fo4kby+mfZbBuNlOU+w4lRnjAwiKIVTHnBFlL6PtwRmcnW3o9bT
	 4tsTUZM0UBk9FJK9oUxS+8X9K8YSCeUo5WBgFSfZNhU82LdxfvadQWZT0aJ1cWRZJr
	 SRxLQPWMwLmbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	namjain@linux.microsoft.com,
	bp@alien8.de,
	tglx@kernel.org,
	vdso@mailbox.org,
	hargar@linux.microsoft.com,
	decui@microsoft.com
Subject: Re: [PATCH 6.1.y] x86/init: Initialize wall clock in get_rtc_noop()
Date: Thu, 12 Nov 2026 21:33:24 -0500
Message-ID: <daily-reply-2026-11-12-1192264727@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112081708.524011-1-namjain@linux.microsoft.com>
References: <20261112081708.524011-1-namjain@linux.microsoft.com>
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

On 2026-11-12, Naman Jain wrote:
> [PATCH 6.1.y] x86/init: Initialize wall clock in get_rtc_noop()
> get_rtc_noop() is used when an RTC is unavailable, but leaves its output
> argument untouched. When CONFIG_INIT_STACK_ALL_ZERO is not enabled,
> timekeeping_init() may therefore receive a nonzero invalid persistent

Queued for 6.1, 5.15 and 5.10, thanks.


-- 
Thanks,
Sasha
