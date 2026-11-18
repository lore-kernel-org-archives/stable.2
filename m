Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794961392;
	b=mXUbBSPe6Vd3rVMi57NouCoUe12ySjPpGEetCPmN6UyRySn15bPqQqrE3+Hi28ws93a/
	 5k648OHxFX8xJO4Mwx2psHJ5xKX+1bt8h1LjubfJp+SW3omNxNyVuv6u4t43mo9XG1/FI
	 RDOZQ9qeQAhthzM1y2jwkypIbKn0ubA4bJSx1sdgulXilCafmBcXARxLYB1YdiF0xNldL
	 +xZpfveMpzJSZ269B2yP++pDOBfDP5pOWvqwY669ppcQsn/fBG1y9O94VqaqvtrODEnck
	 l1PLtygAal8UMcBEpPB2VyCabwaNAJcHGD0ZdIPm36wgCtWXld0KCvuhiPapNHoazKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794961392;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=T/KeOQAMogHIx7JTaFazjZHCznLnaZpss/DsrDscrDA=;
	b=Mv/m5cJWQYA7XUze7kq9Hct8R9k+OJ3qxCVDpV2KOeMRL0iiWBAOQQEK2CIKBk4Ws8HG
	 Suf3nyg0R5dxntIDh8Ik5ytQwGpmK41hD3QBtkYrEzfDz7+Gmau9E1m51ShgpjcODUfc5
	 8MeQGTToo0Kkn293URpGyLpCfjj27pZZmh+g2/y/TQ939LDMFI4G+yhR4iG4gnnUd6vdJ
	 RaPEJvtZe/Uzaet633yAQx2+wjapBnC3YYjr0TUBp771+o9uimModoMPJMtNFokPCeBwF
	 /sza0crXL8CjGg3Upb6xSs25Ph3D7ifJeKY76yEkfPXeugB9vbJncxQ3j7Lns7XHwYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAWpIjVy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C472606A32A;
	Wed, 18 Nov 2026 00:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OAWpIjVy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69CC21F000C4;
	Wed, 18 Nov 2026 00:23:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794961391;
	bh=T/KeOQAMogHIx7JTaFazjZHCznLnaZpss/DsrDscrDA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OAWpIjVywsUgw6B8R0ZcFcwunD5b9R2ClA0JIthfo9ilo7KIBhNreHH59k0zkGS5F
	 3gK1ydVywaWd85PB3X0AH82DqK1MkVJb/A2Uk6hLccME2OYPJ9lNfYn5xxOT6vHF9Q
	 8GPMresQiz83C986B6fSkszlfoBp0B7Tu3mGZ2qdiP47ib3AX11x9Vz4WwgS3QUmPN
	 UfqQEjm3pxpXzrJ8wiu7XikE+LtmKqhe/CkAxGnP2iyH+OuTrN9gDAmJTM4hdpmOcS
	 fzvntZtSYkhv/xTHm+J4EIoPl8tp/fZojWZFJm4nMQwknfx+kdaSy/gO5i8M5nPHtq
	 hTSnCubtzZ6Zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	stable-commits@vger.kernel.org
Cc: John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Stephen Boyd <sboyd@kernel.org>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Anna-Maria Gleixner <anna-maria@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>
Subject: Re: Patch "timekeeping: add CONFIG_LEGACY_TIMER_TICK" has been added to the 5.10-stable tree
Date: Tue, 17 Nov 2026 19:23:09 -0500
Message-ID: <2026-11-17-1-daily-reply-0010@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <101777e2-a6fe-4d1a-9a9e-7179ce89bd65@app.fastmail.com>
References: <101777e2-a6fe-4d1a-9a9e-7179ce89bd65@app.fastmail.com>
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
Message-ID: <20261118002309.3IfESL_PYCJvWWGLWcYeP8Mt1TzE2Qgxdiynp-nfDwI@z>

> I don't see how this is a dependency of 2927f7ca7844, it looks
> unrelated to me, and the patch only adds an unused function.

You are right, it is not a functional dependency of 2927f7ca7844 ("time:
Prevent time64_to_tm() day truncation on 32-bit"). The next patch queued for
5.10, de995239ab01 ("time: Improve performance of time64_to_tm()"), has the
LEGACY_TIMER_TICK Kconfig entry as context in its kernel/time/Kconfig hunk, so
I took it to keep the later patches unmodified. It only adds an unused function
on 5.10.

-- 
Thanks,
Sasha
