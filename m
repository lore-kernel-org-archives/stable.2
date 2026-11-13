Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794537213;
	b=OW1G5nJ9WJdGJKwumjvUvs56jV/EXObiJZvN38z+fkgae+LTo+yzJ7x93tEqqgf/21o+
	 mq6ZJRAPUa5UYBapuZY25XpXB951NCGgSlXu4iAoIuXFUX2IeBJkXG9ap0X/ATf3wGcts
	 SIiXcBvrm1z2YRMO6XRvwt//N6PY8DWd3TkO/rc4NZV+avFgId5UOyoULnBeQBN6JQyv+
	 GX2WRX4vfS3O/YHgEbCxhVmsvl8hFO1AcJYNwfhZFjZXDeSpTHc+brO8jrvk4lZXYM3vn
	 Ltw4Pq59SloFcTdEUzQU0WIE0y7pOTUQr31gqzMgs4uPu4zNTbKVN27iEe+d8Wdcwwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794537213;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MWyQRKLbmV5VJavAZP3FXZA5bSs+oW6dX5jAyVPf8o4=;
	b=GufhlmO0trGGtGdSNuznEdQkThR5T+mPcy9Npn135bWB/jk0SnAIcF26dXUmUqWw39mZ
	 G8zGA7komEea4aZbSMmSHjtaY2zcZZJk/lJHfJRkkW0gFLjF6NAvK3PkHdy6MoffyX8Z1
	 Y7Zral99+4q5g1fYKMLhJo55+a50GGvag8e024/XTUODxaTzUMmfBsOzvQg3ZARzt3eif
	 vEuYBH+pTVL5tW0WoXO2Atz5+4CVhhwLDx2JPeXmJb/ToVPbXEHnsIPyM41H6o5JlavWY
	 DR6OG2YtIbymYebgaj4z6H4G0HejTyP7Hb1ihEglFcebS9hgXpKKkKYLkOhH1HKTbyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F0VKNgfC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC03606A32A;
	Fri, 13 Nov 2026 02:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F0VKNgfC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F6F1F000C6;
	Fri, 13 Nov 2026 02:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794537213;
	bh=MWyQRKLbmV5VJavAZP3FXZA5bSs+oW6dX5jAyVPf8o4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F0VKNgfCzsFRIru26esm9w27UYxIikQWNffBEWjw2kNIMAlRsNdHm4AdmltW8skxj
	 YAx92fwhkEgK8NXtnHaDbA9mNo2nreSmu/eNJeFGSEqfqjoBi1C493iI0OE9kdBevb
	 XmybjoDTXuv18wJFKVST3o/Z1hcL+z1RJmkhsKX7XDWMXkml2oCEpT6GXt7Lyk0Ucn
	 j3zcm4N1UR0i+nXD7PriAySShyiGXIBiFMOOg7TOAD+zTRsfHxReqJq867pD3hksIs
	 Q5TA3oS8gVYzw3FxVhmJ55JrdoxI2XKUxxKEWpWitaqsufwtdulm+XNO1qYcfmyKVL
	 9JQMHDgbZnQ/w==
From: Sasha Levin <sashal@kernel.org>
To: kuniyu@google.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	lee@kernel.org,
	netdev@vger.kernel.org,
	rodrigo.zaiden@canonical.com,
	Tamir Awad <tamir@auth.ink>
Subject: Re: [PATCH 5.15.y v3] af_unix: Clear oob_skb in scan_inflight()
Date: Thu, 12 Nov 2026 21:33:12 -0500
Message-ID: <daily-reply-2026-11-12-2647452388@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179441291360.3032.12248522121219232932@auth.ink>
References: <179441291360.3032.12248522121219232932@auth.ink>
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

On 2026-11-11, Tamir Awad wrote:
> [PATCH 5.15.y v3] af_unix: Clear oob_skb in scan_inflight()
> Embryo socket is not queued in gc_candidates, so we can't drop
> a reference held by its oob_skb.
> Let's say we create listener and embryo sockets, send the

Queued for 5.15, thanks.


-- 
Thanks,
Sasha
