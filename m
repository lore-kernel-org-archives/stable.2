Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793903964;
	b=RCfxcExWh05tDPioTifGOsyhFxQCwFEqwWoZQueXEKHi7cVc4nIKmN0uUvHliJ1IqsTo
	 i+Xx1BNOygTPwjIjbPpEP1A1a0kbYqykccM/l9X0qjEg41zBnGe5ZLZGNDb1wzixGZsOz
	 NFEQLiT3d4J7K/Xz2YgPs1t1qprNUPseUM1hBSStTBi8kthMOQOlgjf+ciRdecZGhYxqs
	 L+nw2/LQ3K1bYMklmW+UKBUNWDnNUNvErxlFQGulSjiXgiZ0YwMkhVlJAwAwJ5cbQdqLu
	 It0eGov3OMXLgwSRdsAob97F+LL0fh/S2sC1JNa0c1nxH1GcjWjWp9MKKWXF9I4IxOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793903964;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=m73ETkCoJLf19UqxWgdfSmlDpfUJZ86mu2KoMFYhahQ=;
	b=mRfsAXvrcAcym8OCATwCS2pV8g67n6pQav2TyleIMJXsO0JwAEBA2Yki6+iyN4HhItyU
	 Q824kjtiQMADNDmGuRYp1oJLdTklAtyHowZrbPdavNVdB19twweydFPSMr748N27QI97H
	 ejCdLNGzny0ch6Cj9kgTT00SUMrk0vCBpAvRwpmHPbdID0oLWq7UnUO71m6t0FTDd1ckt
	 VxcxxPci/DzkNE/RY5aFffaNS1JvPVXpfeMhiCmevZ8gGNMlWUf/JlAHbri2VAGZdvAeI
	 F8VX5yCbV/aaXl83uWjWeAddu+BqztNouhZIY6PqTIwcY+qthlr9Rzr++S6SIKg2Vpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ev0fQPol;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E260A606A32C
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 18:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ev0fQPol
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3247E1F000C1;
	Thu,  5 Nov 2026 18:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793903963;
	bh=m73ETkCoJLf19UqxWgdfSmlDpfUJZ86mu2KoMFYhahQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ev0fQPolXzii6zkCO9wUwDeX21NcNb6N7uDZbgT6FuD/XgvHiuQsKSa6R5MGvDcF/
	 sFj3OKY7in2VRXoMV/JP2G9NefRt5hFkoUmDuMtf1FqdC0Bu/QCEmHxsKYDhzVeLdc
	 EliZ4eJFI9lUEY+CWQvNSYBYxxqh4LMOuNHzbB+o02qc3pxz7AQFLdqTOEsOu2k8XT
	 w+BalFa7zRlUIrqwQFnl/dgvk5t+G7X0WDDA/pjeCsWXYk7qELer7kOGPOG2nCkHtV
	 8YyAv9m/lS7OjQVdeZq2JmmhfCNO3c+F1ctEfm80eo9PYbc4jswZSR3F/J4B6jNddD
	 hfROCYBpKrUOw==
From: Sasha Levin <sashal@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Chris Mason <mason@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 6.1.y] ovl: take a snapshot of the name for copy up
Date: Thu,  5 Nov 2026 13:39:08 -0500
Message-ID: <2026-11-05-1-daily-reply-0003-ovl-name-snapshot@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAOQ4uxhK6nfoPiqmxeXLZ_bPi_e04k35JwCjzMUvWH-PkfMmCQ@mail.gmail.com>
References: <2026110415-dragster-unsubtly-6084@gregkh> <20261105034403.1239777-1-sashal@kernel.org> <CAOQ4uxhK6nfoPiqmxeXLZ_bPi_e04k35JwCjzMUvWH-PkfMmCQ@mail.gmail.com>
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

> This is the same change as the one I asked Greg to apply to 6.6 and 6.1
>
> Can take whichever to 6.1

Thanks, both of your patches are queued for 6.1.

-- 
Thanks,
Sasha
