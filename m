Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434104;
	b=x08SOGKA0bpJ/BhdSzJH6zdMJoKotaKHm7FngYFOXrVMKeDkuoVI4zoEwFo9J7U5QZdj
	 JisCFs+arwGIu2PyJFMzoKAaRw9HmOaEONYZvzj5dAYh0nphY5UJdx5SvmFFeIM/o6ljO
	 K4bAiub9b92T0xvHzJyVggN/E3FPv+dIPTB6IR14tHr2azPmd+agl2o3zgc2JlHXrGC3n
	 SyfIFzi5TojsPGrLwt3SkWYk7TctTJS63VT6I6APzrYWBkn2g71luTHG7JFu2CH506Bw3
	 sZQ1lAJpfk+iXMY3TS+4+0PyIoDN45W+MNzyDHir1mcC7frRbx/Tjlu2s1jbMwQqXTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434104;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dhx7k2Y4W4t46tBmhcaJRNkmWAfB/mIJ1WqdXChCpKA=;
	b=crAExKmZSOD78JYNlf2vF5bEAgutYx2MqXas3lSpBqmIGBtClHHGxepq9cZykqghoRlz
	 L5tBTKsjqS44oMFpuRQivJAgzjCiDA+QeWm2PNnta8nAwHhvAdNaaWtbZNdcvXg7+esLS
	 EPsuwzSbYQo/gnEZO6zDHi9nSMhr3qmWqItrCbl323UJgCWEN+yyydpK8P31JnJg1iXHR
	 WoSVGQEwXA1MQfccVyspJpQ1slvVGs7h9ODcQcjWVTlA78EExyBh1vaZ2uqNiJlCF23bJ
	 LGyauF3o6+9aVzt5ORxDkxcIXRNEihl2Ph3qfCoyr7F+NxiNvehE+0Hoq0p3slOLh3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQJvSj5N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD798606A8A5
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQJvSj5N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93EC61F00A06;
	Wed, 11 Nov 2026 21:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434104;
	bh=dhx7k2Y4W4t46tBmhcaJRNkmWAfB/mIJ1WqdXChCpKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hQJvSj5N4eQ5wh4gvpXfGcFJNFv+srGH75RnAzN0VyKWtVFy77lMXvMxK3iys4zwX
	 yGRQyPFLvkegtvuAXl7pKFGTTAuuRf0ppnpI5h+exxXmWz6/FhFyf4QsSocaD4hyuy
	 uE4f5EWRe8jn9lXBMKj6aD16xZnVTmYylZcK6ssxJO3bQKa5JSclzPyS+lq96HnIsB
	 VnGimqtyxqmsUSwiQgG6OQTvbgBm87hTl4gH7f4ogwoXAku4+BFb9U7vRjydp3orQc
	 EQlz2PfYXvxj6O7XWDm55HVxTzXYNd3pMn/C+yO0Pw2Fk/n7cfUn8qORiTLem/Kxv/
	 HYPcpwUkiqG0Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Jiucheng Xu <jiucheng.xu@amlogic.com>,
	stable@kernel.org,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 6.6.y 1/2] f2fs: force out-place update for all writes on compressed file
Date: Wed, 11 Nov 2026 16:54:36 -0500
Message-ID: <2026-11-11-1-daily-reply-0003-ae93c1ee1e7eeebf2307@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111075403.1299-1-jiucheng.xu@amlogic.com>
References: <20261111075403.1299-1-jiucheng.xu@amlogic.com>
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

> [PATCH 6.6.y 1/2] f2fs: force out-place update for all writes on compressed file
Queued the series for 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
