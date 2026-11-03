Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702121;
	b=jXsOzG6LMxcRmYZKjdRDropZgv8/BMPJH47rGoKWWWEMexfkDBRSny43+YjkG+i88N60
	 lVqoRK8rnGprmhyhNgHIi+OQMoVGKbGUeQCVaz4aqxNT0G18kKbHRJO4OdHcNT7QP8wVw
	 p0sdCs44XBtgl3EttxOSLyH1W8+fUrBzYON295xvlehC1Pf4Vqpxl9Rq0yEBvVIso4zCu
	 wAYEfoad4lm9CUzcYm6hXGNjG5IR5nQUoRGOl+z8TckKX6SzYW2pSrqyz2JVgs/NpddnB
	 AVjmadH/1cNUbJneTe2vwrJ0OGlFde6T3tdimu0SCp2+sZJUEz+rAhOLCor5kNTPQhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702121;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=g8CXpm9jfE2f7+zLnB5alzNip53AFfXKgOGLuYU8GixIvg+26runSjV3ZUiHRouBjjVr
	 H01wQ7Nlc/Xvct3S7Dvz82cj9vzoxsa7VU+6tL99nev7ptYI0jY7Xl49fq5lJJ9IQvL84
	 qdZGK/VY6AO5d43XZyDE6IxRFdvf2ye8MDcEPALzG+k5WDoSjtheCQxlcPWEnFhK2q/mK
	 r0k91fGjXHhdD1cOaJxPfAkmPcXV5aB/du1TjZMqOPHahCFk1yp7kBcaLy/OaM4uxAbn3
	 9YuvyBvO4Yo8a1HjlbL+o6PoGIpJPTsZhi+IuKCnG06GvrSf+rqKF0tT50o6imLhVMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amasMzCr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6003A6070AA3;
	Tue,  3 Nov 2026 10:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=amasMzCr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F5D21F000C1;
	Tue,  3 Nov 2026 10:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702120;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=amasMzCrNeNDN/3vk+4l64FRtVd0KZykcnKoiwcNC1Fm15kyBrVy2PH29l1DV81WM
	 3czvT95T+4jQXNzzdO7h8gptwQAzkgE155J/QKar9R/thfy989XJeBvHoZx4bmBh9W
	 lIDv0c7W8X3NtnYIbOdi2xgBY3ANdQmjh5ubIPVUVfTDRISwXy5+XlbmqUbPsrv1xf
	 fyEEJaCtjd63XJajtfX2gZnbNp2qG/htklQMeeEvtNE29amaB2N+0MvpFOcIBBH5IM
	 MkV2jwZqTw1IRV1dF92v7sihAIRm7bknrjBV7iNiQEKFeJOSXotp/SayMuAK7b1eFe
	 VSk3OqwWaECHQ==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] net: ethernet: ti: cpts: drop the refclk mux node
 reference
Date: Tue, 03 Nov 2026 10:35:20 +0000
Message-ID: <179370212002.488859.1362537216158287231@kernel.org>
In-Reply-To: <20261103102913.1341095-1-vulab@iscas.ac.cn>
References: <20261103102913.1341095-1-vulab@iscas.ac.cn>
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

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

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
