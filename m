Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798911;
	b=2NRFAIfJTPqkUQiHf4ANYcFhLNAGCg6qrnGQnfp/asPfVxBdLE998xVDMq2e7yNNuirU
	 ovV/EYm6hnN1eOMK9/hcXo10r74STCgn3wqe88JbHYoxcF7FCCbpjshAeWCLD2PMQSfTK
	 dQuJrjGErhP96EDKEVnXdHUyTuSonq4nj4w45BoXPN/nUDCHPmu1MoeatvUsU2wouYcE8
	 cOOU/CGH6Uh4uriumeT8SxYzkLRQky4BRYto4M+hm2vk5LRKlwn++jdE4eCyoaUWjomeo
	 X3NmJzggd2Ga49xXT4TlU3g8hL09o90J7LI9C9BNhldcyGFuAZBix4XSSeCVy5Xi0PQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798911;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RaqfmynnzRNGBkAoS9G9liwZ+JXnLKg6qpzs52o9Vvs=;
	b=y7aOqmUlQ7zDLbEOoO9UKUvp7nexwZqg5rGr4/fL2KwF2izBupUwl7xSVKekLsnleVjE
	 maA+O45puUBeXrrvSQfG8pazAuZM1Br8cpz4KGb81P/fMGCq8wrRk2X642lIfDABABhJQ
	 0kfgndE1k2hks94khpsYsQCayUUSjcQu5GQ8IJJNVRkzq061w/kZ06UAcpgoxY6X80eWg
	 D+KNc31mRkpBzd2VqCHMk8quouH+01LrOwoYf4RH+Cxx/GFUeo6fIHh5BCGwv2nVeE2SO
	 psqV5Cn0RIDu4M2YdAcCY+dVsRma2c0H3DK+EjPBhQoEmXpNcIddQwI9Wffln8c9XEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="TX/yrNhz";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6AD606A321;
	Fri, 27 Nov 2026 17:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TX/yrNhz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3E01F0089F;
	Fri, 27 Nov 2026 17:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798911;
	bh=RaqfmynnzRNGBkAoS9G9liwZ+JXnLKg6qpzs52o9Vvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=TX/yrNhzEDFKe6mixfiEdpV47FAKutlhara5QRfPfcrd6FFDveUNup1UaGB3c2tO9
	 cf7mrffIgoIPYIJlJ6ALDHFnaaV5+RGkcem4BMtN8paVS83q/ITd2tZ1HnpkKgmXZJ
	 oh3VTDvEciSV+0vIc+RwB6tMFudyjY3udljsJsYyUQpJ3ZjlUmfQi6fkD/YQO3STnv
	 FfNK9snLZS5bnYhwAlO0EAkD/QVDfjsko1EkDHI0KVEcqGJ01JzkIVShUXE523CIAN
	 5aTNfZClEzajEWdvD4adjNGSgrKMpr+hAeUor8gmyUKPFtAlbmo5REEX4QFIY+s6UL
	 vmfnz1huQBWCQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@kernel.org,
	horms@kernel.org,
	jhs@mojatatu.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	toke@toke.dk,
	victor@mojatatu.com,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.18.y] net/sched: codel: bound the dropping loop per dequeue call
Date: Fri, 27 Nov 2026 12:00:58 -0500
Message-ID: <2026-11-26-1-daily-reply-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125204850.72393-1-artem@trailofbits.com>
References: <20261125204850.72393-1-artem@trailofbits.com>
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

> The CoDel control law schedules the next drop one interval/sqrt(count)
> after the previous drop, using the configured interval
> (codel_params.interval). For very small intervals the scheduled step
> rounds down to zero, so the dropping loop in codel_dequeue() never
> advances and drains the entire backlog under the qdisc lock in one
> call - an unprivileged user can trigger a soft lockup this way.

Queued for 6.18, thanks.

6.12, 6.6, 6.1, 5.15 and 5.10 lack this fix as well. Could you send
backports for those trees too?

-- 
Thanks,
Sasha
