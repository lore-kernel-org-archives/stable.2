Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794033660;
	b=zeNz50nbHqBTRa4HY5W6f0IqYS5QvZnIIpR8ffbrVZBFxKNeG6ykkyHJpfyIjeUI7g39
	 Y2ukk419PjieyH1j9h23st1ksdH4O1G6z0031P0bDMsgIykIVycXssO29PnQQxLVgDibn
	 Sg9h33inHCfpRxOhYO5oVH/uk5wFhLNNyxqZLkxC8erXrdSqWbREl4wLwhkmU71iEzKOW
	 ohrmUWXQBCtDr2T4I3pU0iDe5aBtdP0kywiJWn8qKWfIpGh1yqHx5C0AUqoIz7HriuKJq
	 BsdQSV1SkmwwU1/rxbR2wEPTwTqJuQEgqiGmBIv04VYsbshgo1d17G0XKWxrjMJ9OEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794033660;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	b=D9vZ0joEhCheZnCxOHCWZOKR9/z8NO9iwdxYJ8H0rm8aN81Gw2LTR3PYycQ5PjCxA8j5
	 rqIShb+FwqR4TFTeBVT4DbRqgEdGb6PfMlz64Tu1WiSXLKaTVHxfNisancxHvTzoki+A+
	 a/eBZYhktko9BTeoVwgQPfJCNxuJnGau/H6qLwPzxZfTT6RKfDTw4tb+czYyZ6n+BusuH
	 6f6wtFco9u136IZNk3IZigvUJ5sQ7PGHuq0SiJk640HXT4IxCbOeVPsKkQMoouYDdJ+8x
	 DvNorjbnNL0EpDHcv31WK2Qen6+1sA4IQBG9eNGJB9PWnarqx8o4eiHfijgQRSiYX0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMAjPY00;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2111606A326;
	Sat,  7 Nov 2026 06:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iMAjPY00
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AEB1F0089F;
	Sat,  7 Nov 2026 06:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794033659;
	bh=LPA6Inh2wBCKqBtP/pIYKJnpKzD87TCTJsmoxrtXeEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iMAjPY00ocatbN7KrM421pXvOa3zCuXmd1SDzQ8m1xoKbqBSsbNw1BO7OMjl5kXXO
	 DO5bAmAdG+bK9qGTpVSC28DVVwZdG5/tPDUChrjljJvj6QxpsiBZAeP7vI99goGu75
	 NzKtssuKmOGGTAF10BI2aQXOFphNaYV5eTFjUVxgyOhtBwyk7JrqJXOX/Zk0RGp2we
	 2hFYEulFcwS0MT2/1eHpQ8IuYgbL2rKOD4aix3bXPGklfx0+xccdTN6/1Fp3GTX0io
	 jRTxbCEHeWnito8QmGIhR0v7Eez9j3nrrUraB3hL5AhnHw5mi8yFNEkfcGCB9zownl
	 P/rsHhh4NKZ0A==
From: netdev-bot+sinfo@kernel.org
To: hyunjungg <hj351016@gmail.com>
Cc: MD Danish Anwar <danishanwar@ti.com>, Roger Quadros <rogerq@kernel.org>,
 netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net] net: ti: icss-iep: fix deadlock when disabling PPS
Date: Sat, 07 Nov 2026 06:40:58 +0000
Message-ID: <179403365845.488859.14463866308744692967@kernel.org>
In-Reply-To: <20261107063726.3388730-1-hj351016@gmail.com>
References: <20261107063726.3388730-1-hj351016@gmail.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
