Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299439;
	b=ZhTNXWzBnBZ9Tf1lynhvbpXcU7h/9ytkKy6oGo7HwmcvQ7yQ9qiBxbcA75Qe1jgcmR50
	 kQ+j32e7OqzOQUwlRnZwqWvEUguUVn4ruWObdr3KRLDTGjzUUxWKTRbqh8NSufPpEgfEt
	 gxhjZwKOFKt+da6Lp9s/ZYdAzZ5FpWUVhqsWzY5ZBgdR5Z8UKUohNTNr9KRX7ITc689kJ
	 QSdj6CUDOuDudyALzx9A7p5+sJKygG5yVM6n53psMNbsRUC3n7vxhpsD0Bg0Sejnm72FB
	 vtsSF7s3V4XB0FNM91OHR01E6jYyqcRvMMbpzd+3SDpSgnOsS4SUqB6DpmtbJt2GqCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299439;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Qx9Vxq+q1VH53YvroEAQ47lDP6bGDc9uPHBxf7J0T7o=;
	b=wY3LUgq+j9RxUy3TopMKR1RJO5zbU2a/YMlG6BdnEFWIXcvs9ioN/3Kbt7/UouvozFbH
	 BEP9/nTz/sqf6AQ+dWtchPpnFy9Xpw2zcmwfPVLA/baf40riTMZxz3EqHnITwQqWeY6wV
	 KoExv4W0P2IFKwQK0natNjt0XioN9pNuLS++MTdPLUqlXTvMPXPo8Fw7wKdM1h+x2wPqQ
	 6gy/qNYOBVNGJCTckFA9sBzK75y3NAyhAyth6/zJ9Iu0m7/IAG9DNrLe6o7vjo91AhSn1
	 Rxu+hibgBH8UAfq/1dZ49b9UJUgcxlKbJvIklPNd/MbguCACqQ+JCn9UMcPo8dQMqAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+h5gi3j;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C4160A2610
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g+h5gi3j
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2A9F1F01283;
	Thu, 29 Oct 2026 18:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299439;
	bh=Qx9Vxq+q1VH53YvroEAQ47lDP6bGDc9uPHBxf7J0T7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g+h5gi3jEK8BB5uAdKTMg8CQvNl6gCP/yYOLuc7kCqhiYS606tBFVtV4NHYt9RkEF
	 Pmus3xfxFpQDHtIcj5Fj752O1CDElhr0Sr2bb0sqr0MQqeueKKFq7E+mpOSnkHQMPT
	 LlbW3KPjfynlptaczW+rNeJ/Y8JFFC7y8mC0ePLjS70++cwT/kbZljgFu+B/nkcK0H
	 c5j/TLLwhH9U+/MD9itZaqOZ7SyB9IkuWgOYVGQdyhpglt074BwN+xpSyttxu52Cqv
	 m1sRIpFx0Hr5nW6oRprb0RB6PJC6Pb/ru+bPS9qAQ15w+MrnitG3cpmNg4ybCnl2AH
	 A9GFs4hZnrhLQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Karl Mehltretter <kmehltretter@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Dan Carpenter <error27@gmail.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: Re: [PATCH 5.10.y] nvme-tcp: fix error codes in nvme_tcp_setup_ctrl()
Date: Thu, 29 Oct 2026 14:43:28 -0400
Message-ID: <2026-10-29-1-daily-reply-0021-nvme-tcp-setup-ctrl-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029031352.56096-1-kmehltretter@gmail.com>
References: <20261029031352.56096-1-kmehltretter@gmail.com>
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

> These error paths currently return success but they should return
> -EOPNOTSUPP.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
