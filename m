Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793982959;
	b=csCLgW2km77ELz7KLyH6WpvayVCo76rGCPRI+Y3bATOztAmlR7QsMuP3apgWQAvtxYl6
	 9KRnhxc2pgwSJZSeD0JkbI7eKKMzKqIOXiFZtiQIk8Um6hiaQKKeI+UC2o0Wt3ZEiIrw8
	 tgiCNkenZIqNJVbqVc/tsRnvItfaueHmPmSfe4EeNfg0IVLUFgpyXIqJRstYiNlxMeIsN
	 IMWDGxILwH8rMSLNhZm2Hm9g/1E8UjYwu8rEHe6RV8BuDOIlxzPUwdF6/UqjYZLs6R7eu
	 Oltb/a+M/hmmdR3dvkK6nz/ieJ+6WNAu9apg4woEmRaZsNjTY6UKYTx3Z1ad7msgZBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793982959;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YKNn2f/IrTNM/cedHO9yNS4LYxAAWrNIDv2+KHPJirw=;
	b=0KYdrP414ooF1hQI8nTPb3ka+PvN4aR6IB+F6+gINsRWkorI6sgd4dpU4Z38bKzyNs2B
	 OT/TR/pjYEbnNPKgZQiCSCYJ7PPFm4amgHkHdIrA26OE7DrN1VXXq5h1WeTepKdBVsrRd
	 efEca81zAkqRcagLTjJP4IKs7ogzzpuudetSqqgim2+UAzrqxTxR07WUuamlMh3jVC+rT
	 hBI6fQZpGGcKoXgYaeK6SCYSK1BleXLCHcclLpYljp6drNCGtLcXvKVP2YRW7kMNIrqkX
	 mJkU/DQCALRQBwrkYhwfiWhomiNvEUBMt4EsDMIMSXTqilrPEnJjKXa3tijAoz9QGQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgFeYpxF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487FF606A339
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 16:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgFeYpxF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF5D1F008A2;
	Fri,  6 Nov 2026 16:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793982959;
	bh=YKNn2f/IrTNM/cedHO9yNS4LYxAAWrNIDv2+KHPJirw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SgFeYpxFib/07a+8F01J16pgeRySrqBaJjEV52Xs8027M9DpYr29DQ4dsZOQvvKYN
	 unSXpxCH/UzywxxPMkjLPrOiLGlBBSiBBLNbEk71FS2ZFpU91pp6xrXT4aYPHDm+4b
	 Ev8RNbiHm2uWa7GNzGFAS50bmQ1Ll1EvltflXHMOrLUNSDO2LmeHzaLy3CuO9nAP5c
	 pp/6t0ljghfmrNW7p5Lb1/MbXUM8muHufGawJSaGbdv1uBl0YQ70czuPeO8u75rIVE
	 V2oKCS+u3H4SrpnqvFh0ksNZjjJiOSkjK6JINdDCZoJjlwWUTiK+LCf8FaWpxC9ypc
	 2+DRueJOYFRWA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	imv4bel@gmail.com
Subject: Re: [PATCH 5.10.y] inet: reject unhashed sockets during established lookups
Date: Fri,  6 Nov 2026 11:35:37 -0500
Message-ID: <2026-11-06-1-daily-reply-0002-inet-unhashed-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <au2VwORvjv7XG64y@v4bel>
References: <au2VwORvjv7XG64y@v4bel>
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

> [ Upstream commit 4e2b3ef19e0e04adca38442f07dd6bc93c712bf1 ]

Queued for 5.10, thanks. 7.3, 6.18, 6.12, 6.6 and 6.1 did not have it either,
so I queued it for those too.

-- 
Thanks,
Sasha
