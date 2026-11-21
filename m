Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795274870;
	b=4a78FugPBOxT96ncDicim89s/JMzdKYG19ntXEsHDLVgbyNmV9wTFGij1Jt2UlAH/Wip
	 G4twB9Etj8uOPsIMVmMaPcs8jjk5wr1BQClG5G/5rwKwP1+1IkB5v1hFAASrbQRiueyQh
	 0DUNVwH8EUKjHXnDP9OzdDe/d5iayv9uhe7pGcOolvogMSf1Pfgj/2f0CDSlqQH6OVSBa
	 icOofjIXDdGsXEvtKtpI9eUFc14d5TT1P6mXQvHL11AkT8OPQDkWmQSPzjGWR1OvnqAre
	 Rs6NWF2VMEac7vlJ/BFOhcnixP4p/pewPYf+zXdcNcdDn93Pu7WlNxkTahDDp7P8T5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795274870;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=b1xFvpCBbc8W+ns8yM5r6koDGgvF3SIoxRLQsYmq9oU=;
	b=2WS7ruLUm/dBB8gsydLkmj5YFJvZvS2ziu2BuI5tO7ym+JWTwvztCe+b5C3f91+sNPJS
	 6TGfPsN2jsPZvwLYZLTw7oiy7woWRSQjiCgxEE9BOYucI44UguWJrWbQroGKMH1HuqQhZ
	 Mbc/DSLEdm6Lady4WskQPm6QT1cExtUPqWveYZSkVZK8gegAUd1HO4OXq5i5X9y2NVXsr
	 gM1lznDnKYaZ+TLUDjB0XEU/aDvIV1ZRiKRjZhSSNeN3v+bKhstKrvadS5ZD2ZnjBFiQq
	 fSUCAPkhfYy09We53v5C253F9gyZ5i/HX35J2G1UiGTWQdp+D6LVxCs7bVTOmXFxFbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixz17Hzh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C813A606A33F;
	Sat, 21 Nov 2026 15:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ixz17Hzh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B21931F000CA;
	Sat, 21 Nov 2026 15:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795274870;
	bh=b1xFvpCBbc8W+ns8yM5r6koDGgvF3SIoxRLQsYmq9oU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ixz17HzhdckNPK2SYiqBhHbBchsH79GIF9ncEXxe0hFi/hjf6kwNdiINSvV00/AWS
	 vWCyNhPeKZS5oOBqyIDasBFONDyUrEeiSeKFC8akfhb9eNhBcckS5AKtvMltYbWO5r
	 RUzMlSyqYAO/OdspFbSSqu/4z9sVI1HF4r1pdO5Ba9lQPZ6d3IFPmnIeoUHeg/qUz6
	 6+n9mhfHwpGHWi2c1xBQKGO1IBFoo6+gp9UGH40+GdXi2DRweSdM1hN9daJT5Bo/Yr
	 LxQz7veKeOe6sBZDnP1xoDU0ljLa2HH9xOd6o5AWCnv0+Sn9eP4NPKcXq6quRwr7VP
	 RECSgAT6PUuPA==
From: Sasha Levin <sashal@kernel.org>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	linux-rt-users@vger.kernel.org,
	Gabriele Monaco <gmonaco@redhat.com>,
	Florent Carli <fcarli@gmail.com>
Subject: Re: [REGRESSION] 6.12.y, 6.18.y: fair server runs SCHED_OTHER ahead of SCHED_FIFO on an idle CPU (fixed in 6.19)
Date: Sat, 21 Nov 2026 10:27:31 -0500
Message-ID: <2026-11-21-1-daily-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAJuRqcCc-p3OYAp1Sz=qFPRLPgig=Vnnmemz-NsdER35sQHdiQ@mail.gmail.com>
References: <CAJuRqcCc-p3OYAp1Sz=qFPRLPgig=Vnnmemz-NsdER35sQHdiQ@mail.gmail.com>
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

> Stable team: please pick the following for 6.18.y, in this order. They
> cherry-pick cleanly on v6.18.64:
>
>   e636ffb9e31b ("sched/deadline: Fix dl_server time accounting")
>   f5a538c07df2 ("sched/deadline: Fix dl_server stop condition")
>   1e0a2ba7afb1 ("sched: Provide idle_rq() helper")
>   ca1e8eede4fc ("sched/deadline: Fix server stopping with runnable tasks")

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
