Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239629;
	b=Y836pTUuiRuFQ3xtBgMC61ICIyEhBdqoEdb9jS+Dh1dQGDB6NLkN+qGtzK7BmqSZ6LEs
	 ogZSvOGHoJ8Q+r9mBBr1KWM27IZMzz+WXS48hDhJlhyHPaX9q4AfskDp7KzQAVibAq+lt
	 FY3VxZjW/DDmmxwxi/dKvrt7J2LqWO6zuXGnOZTBdq2okgk42SDn2k8oUtWB+gs62D9XB
	 CdCcW6nosWHZEtAmcP8AFocQOei9uRM8srOxQlvbwUpPnHOT+eqNOncz/MCsjuySZtC7T
	 aC1LXKxitrpzDh25RpEpEH0vsvYycDdJHoq5k6ZPb6xp2ehHZyhRbZ8ZNbepx940tbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239629;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=BcIhTrG4F30lAaZL1/3Yfx0NOa+ZKSg75+aLXsISvo8=;
	b=wJezVI5+exapztK/bvBQUSEYGVg3ZD36QwLzBAbeOM8EH9Iwi76ZolOTUX1DdI57AfEe
	 sGwya/H96z1EoSOt+pjZMaBNyQsf0x6uN4xDgxrf0pwLeu11sEDaeNnsUmxeILhYJZ30x
	 FEF7KL+a8G9T9GXRmK0fHqF+nDzNsji+QhId/3OAJLC5H3XBeH1JgSP3XV5qCKuoO2UXb
	 5Tdej7+cBtKo2okdTWIhqrFhcy2wJ+8SpZReSLF1YWeSvWZhiR75dAg/D1pZte6qlUsng
	 +2Akg+lSBHgs7HzNxx6aKbGVRdb8GGaOD4KZyXLIdECj/jSwAKz8+QH1Vo/+/04ruTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCKmIJFv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B1A606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RCKmIJFv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FBCB1F008A2;
	Mon,  9 Nov 2026 15:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239628;
	bh=BcIhTrG4F30lAaZL1/3Yfx0NOa+ZKSg75+aLXsISvo8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RCKmIJFvW8VX6JNTR6OZ+s5P5V3Fr+K2g4Fqdg1i+63t/0gTpQO4pSg8xUjwp/nRB
	 TfpNFRJqz86Xl59IRG9h8ZzmhSAmsPdswd4mC8n9gZhme1HWru1U7JVq5PQN0B1n2m
	 pBaOUjYGWP6VA+5aqjBSmPMo4aA6iTVAo24cLvK2bX8VzuQ0XSU//F+uuFQzS36SLU
	 1ibVoahUQjEu12SEBIt+wRJ88OfmgFqyXIn1ol9tC3WTQUtvvM4vjPwMCHPLtz+ASc
	 WzBth4e5K+pCRhG1xSs5DsaBrCV+uFvfUdGTkPyDwN+qf15uZ83KrLIQFVj82O4Mj2
	 z2y140O29V7cQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>
Subject: Re: [PATCH 6.6.y] pwm: tiehrpwm: Clear period on disable to allow reconfiguration
Date: Mon,  9 Nov 2026 10:53:04 -0500
Message-ID: <2026-11-09-1-daily-reply-0022-pwm-tiehrpwm@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109081728.798045-2-ukleinek@kernel.org>
References: <20261109081728.798045-2-ukleinek@kernel.org>
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

> pwm: tiehrpwm: Clear period on disable to allow reconfiguration

Queued for 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
