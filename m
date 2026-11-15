Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794786074;
	b=TFNn1Hpduc9IRMs9HzlTAMU8p/9PeOvsO/GPtpM1pZSEvKl3yCTi6vC8sa9XxZ6PrycW
	 1D3oAn6M8Q+Oq4IQvqGYq01fsxKGIc3UCp3VCdX0hx1ognhdlq9lqHqTapyl+OLtxHCKu
	 dj1OeR39FcypCkJ5NmuuPlUi/bB/Vmitf8YnM44b2dlE1EbQqYLLpBIZCtSFdu1fsp1kW
	 MY9t2XD+pGIHnFJcKkxyVynu2eEaWUzs41Gh6N6tNowCon2k6ry8g2GUOXXl/GVRVgVmB
	 XUdlILT83im0qox0YnHDUVhzxJksJIq+n3PJlX0EJ08ez2+Wa5t/bMJZCZ/jdMDuK1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794786074;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pA86C8XkV8AcJdfotHFXD3Zn2YfDfc6IZYlAgYWvmGk=;
	b=H4YUxVtnrd5RwcM79TASWI8pmTJ58kU28BZqA8RIr+k+KYVKsM9mBtxa0Dwtu/0qJMuP
	 +enZzLAsviPg3lhji3tyKMN0rygj+nJuvd1JCr2LzUetwkajNXlwNJyFHoxTw9zxofonY
	 Vyl7MV0nIunl682S/t2qNoUMRTHI1OJTVAl49o/p5VcuQQNcwHXec2YiaXgAb0Uf5trwp
	 6iaCXZsLP0lo6/PNXwpmn0sPAvNVOzUDAQNLHNtvQL7jYS+hLBso8dCk4qAx6xOxTjPXp
	 bcBNbWViIMESr57sR89ZmE9When1S4TiSxMfZBQMLfnkEL7j1D3s7Alw0e5oRQq7xgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqSslz0e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DAC606A323
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 23:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WqSslz0e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A49291F000C4;
	Sun, 15 Nov 2026 23:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794786074;
	bh=pA86C8XkV8AcJdfotHFXD3Zn2YfDfc6IZYlAgYWvmGk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WqSslz0e8KEeG0W5APKtVZAoOO8blfqpH+h0cODxG8lFbfzNfDsDL+q9IQwbFlNfX
	 tGBVxotgRvTxK4RqKhuNS6H6T+NIjTelG/+LOd7xa7xH2DEgyigu1nb0Rajm1PpR/3
	 HWvREgbckUBiNIMEkoys4CHOLKJP837XdJXKBgWtRP/XevG2VKYzJwtwIcHwr2FS+j
	 zP7tV6EWTQzn18JUI3zMBRQ36uc5Bd4bHwmWKHfuN488IgTCnP1NYUHFvzeUxSGN+I
	 vKKhPfI2QWDngW/9hY7pCyUcSc1wl/pZhVLEkDS13ET0UzZrLFSxSAgSTfsumrx+DB
	 rjyLJIKvex6Cg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	ljs@kernel.org
Subject: Re: [PATCH 6.12.y] mm/vma: avoid spurious write locks when mm->mm_lock_seq overflows
Date: Sun, 15 Nov 2026 18:41:06 -0500
Message-ID: <2026-11-15-1-daily-reply-0005-mm-vma-lock-seq-612@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261114182227.64779-1-ljs@kernel.org>
References: <20261114182227.64779-1-ljs@kernel.org>
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

> [PATCH 6.12.y] mm/vma: avoid spurious write locks when mm->mm_lock_seq overflows

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
