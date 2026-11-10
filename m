Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344375;
	b=FtmssTRF5aHWNNJi2O+1zp1IouWlOw9DV1/bvoMJA52tEb639u9zlooxl45g0UqU8um+
	 b+XD4jVQsCOmk3uwogG9T+dMmkGanc8pefENJ5V9WSOeMhPCDiqs3yTluOr2VzfEbwUww
	 24CFOb/D4D5z4fzlIGF6pCrgHAJK/64ONrprngwoQL7qf/vJcKdzGqoDClPtZVy0YLLqM
	 G8nTAq+pvYCAKL8xoMPevygd0xk68t4lgUwRpZ93a8eNEEkGgu4JpyDSWZeb6BYWxjqEl
	 EKk6FK8X9p8RKL53+MUdQNXoaFqQydG3oDC+FuHm+wbMhcpVyekQscTE3E9nUdBSGUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344375;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dW1tCDyKiV0sPPNs/wl091QtUhWD6tfCj4ANQBc4Yj0=;
	b=a2eQeLqD71hRlROzWB2R4zzh25DdYGNYA8UIRgp/3iW5ILgb9kmbwU6aY4O26C2xrAGr
	 1NF7wzQY/EOLnKYYOGduhdATcHO3PewBVBn+7DcSrofmvQqjMl+o66+Y8nGZvwQe4MA6g
	 pkJIQGBJYd/TEoMCpqbbWJQnIlqzB7LyXMTphyaEOfgvbC0K2R5EO81i5YX5YqWMbo12C
	 QNycqkW4KU1tFnyhsFAqGLGS3mV54Yp2Z7DAhojPHwL+Ach1S219lc/xgl/bs5MoXBzyF
	 sdI1irou4lM4vKFSwIyNGXG7gq46u9dt07aabcnXdlKN17R/9516HT5jDIG9/imR5gQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGIKkNe5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FAD606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WGIKkNe5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34E571F0089F;
	Tue, 10 Nov 2026 20:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344375;
	bh=dW1tCDyKiV0sPPNs/wl091QtUhWD6tfCj4ANQBc4Yj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WGIKkNe5mUYfyy9gO1iY66qsKRqlKGtlfhMHIm+J2wT4xPuX432d5WcuzxUh4KxaC
	 /6f/MpiqrM5aI8FficU7yLk9vEzgYVrSf2w5CW2Jhp0GOOdN4vNfvNmsj4BJdAdgUh
	 iGVfoT14R/VXnIqtpluXTY2nonS3q+wm7SeUugBpIiR9idYLm0XkdayJ62SCdIizgs
	 MZKEgIzZv+DIm79WTCI6YpEz/XURXs7OZg5POIZ+cv9kvSaHqIUBJ9LgPh9wH5Ahvd
	 joITL0B9qa8Hqyq6ykMF2vU6jCUQPYMYPQCZApE+BpNKvxpdmM3NkMO9RA+xvr2ofO
	 W72I6nXF5/Cqg==
From: Sasha Levin <sashal@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	akpm@linux-foundation.org,
	david@kernel.org,
	muchun.song@linux.dev,
	osalvador@suse.de,
	peterz@infradead.org,
	fvdl@google.com,
	willy@infradead.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] mm/hugetlb_vmemmap: map the shared tail page writable" failed to apply to 6.18-stable tree
Date: Tue, 10 Nov 2026 15:58:57 -0500
Message-ID: <2026-11-10-1-daily-reply-0001-hugetlb-revert-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <avMJ1sVDviavKjQu@thinkstation>
References: <avMJ1sVDviavKjQu@thinkstation>
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

> But 6.18.y has its sibling, 01b1d0ffb6f7 ("hugetlb: remove
> VMEMMAP_SYNCHRONIZE_RCU"), picked up in 6.18.51 as a Stable-dep-of

Queued the revert for 6.18, thanks.

-- 
Thanks,
Sasha
