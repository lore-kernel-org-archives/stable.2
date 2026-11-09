Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239609;
	b=Syv+BV/DJ/hIOIHyH4BP3h10s/ZYDfcj+uVpVl9rNjoo9+MZGlLiSmJVX6I2gWqS+qw5
	 ORanMvrC8JaBk9MWr/zRqTpC6Wt21w1PY5l7LXKv4eiaTgzFP0Gh8G1B8Jb66628R0YZj
	 9fuE7sG/8co9k4BypTgRXJi+JdKmxvyTqIGObEow96o/AafCTEwXfHuy2i/9uNLrm5uoj
	 O2XXsMUb5jGh005p4enaxGAQeA2FOoT/Zh0Euasf5D/oixraIkdID40e6kAvfiDuLMcMm
	 cpW00KEPwv/Z9d5ciGpCBCc4M+3o6rfy5to6D/NgrZVXiL/BiujPYb/OvG8OzLBAjKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239609;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ceSlBEzuNxuO4/T1ERd3OzK8OidhBSWdJANGxKEOQOE=;
	b=Cm4uThAejkKPHuEpoDSmGCPBbhIE9ewhVqFGAIo6eklLDPhW9ORORvo20YmVR3ep+lNC
	 iCrQJtRiRGZUg/fO+BwT9Z+4ROVMCKYFVhF8VOorrhu7FW9/2QWVybsdNRx8X4N753MAC
	 0JNqmPebsrIpUmh83AgCg+1szQ5wlnW82VTiBnMqT5OiAvnSEMW3Z6xJ96rYswzHVPNdE
	 4eTIUn52X42eIX804Y7RHw4JyS4pmBEu9fcyaXs26+M80G2XJWkX/lNph/MI5mOxkQQdR
	 cR6LbR/CmQIMOkc7NoXNcoe0jEdmuKPnXczs0QRLfn6UZpnSh9A9l89bwBnPm8ab6hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DpKl0o9Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52104606A32A
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DpKl0o9Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64A351F008A3;
	Mon,  9 Nov 2026 15:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239609;
	bh=ceSlBEzuNxuO4/T1ERd3OzK8OidhBSWdJANGxKEOQOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DpKl0o9ZNvDzBss766opeFLf+yhAo4PY+YvjbCsgIO2RyH9qZ5N2wf/zPbv9StJ0Y
	 TMJ1AG/WRnOEgyp6OkggdoqhHJAuV6X4XQNe/LJaz+CIKZh1hmF3y2HyI0kvL6l3Hx
	 xoIb+cDi0Se1A5+1Oc5Dvj+ltJYWesCOYsv0ArQIIyV0tUS5e4sxAQbsUNrANfP2Hf
	 rzE6162mbu/ZlHadPu867MdLP/PHU3T4ag7QcIVKyiLaJfBAIqeS310MiYcEj+YMgL
	 AfybeJqu+IIlHn6KlwCuf6KXGusVQ5HdIdbdXoAHfpjxqa4Ml0CW3riYkN/JE6AnT6
	 h7LghNmLYpQtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Mark Brown <broonie@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Pufan Jin <cyan2254650260@gmail.com>
Subject: Re: [PATCH 5.10.y] spi: zynq-qspi: fix address buffer corruption and support 4-byte address
Date: Mon,  9 Nov 2026 10:52:44 -0500
Message-ID: <2026-11-09-1-daily-reply-0002-zynq-qspi-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261108171356.66438-1-cyan2254650260@gmail.com>
References: <20261108171356.66438-1-cyan2254650260@gmail.com>
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

> spi: zynq-qspi: fix address buffer corruption and support 4-byte address

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
