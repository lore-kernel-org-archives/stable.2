Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795511041;
	b=cY4ISCltLALFdPWIGRXxAYzg3rAc0KT/boyjkQ4qpBc0+h9a7v7uYxeGs4KFxUP2drb/
	 wh4J5z0YB08VByfPH3af1kMknAG6uRQ/hU6Obk9qicEJV6EP+/GJLuYjlzFwKlVutS8+G
	 ySFUoNVBwmyOGjV6sGk1VlqZowP8rIUSou8udvA/xW5Z+Xhd7InM1c/cULgYCiBa7kYCo
	 DdnDf3Z+t1Zby02eqz8ek0eRkyeR8DTT9+T+MYtypnjiRgEWaEHDVPTVHvIarmsbZPKlA
	 qJscMntkKIrTzxAXk+RjPrHTO86iksK83JfKojjXzA8vkX+9NoYisUzXdE0PgkGf2Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795511041;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	b=t85r+VxMgyWqGazLVvZQOyiDbO3X+LOLZ3mrr/oTuP5nX2awGSxT2Jaq9yxRcgbWsNGb
	 moiNXWpZeiiW52XCs4jVaKE2Qs2FK1hGMwwCrkyLmke+s+ZNRXICF6PlvI0JN9Bi8pVxA
	 2beHnT537oSKYxAYJdVUltlfWXkdF9pFJmjRCODpICGHB4uD+7mJucu5M5RoqDiWMlUtt
	 /5biRKR9ZhfFc90orL50tPOPPLK9BLYiAH8L2R5pIk2CFy8bJiOtAnP8/3lOgziaYZKx0
	 dt0TiZqsHseeyMPDbBD3bLTvS62uJLM5rwdLjdy1VJiro/48ZCgWFpW3WAUGILX05+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4UTbb5s;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A901606A31E;
	Tue, 24 Nov 2026 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C4UTbb5s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18911F000C6;
	Tue, 24 Nov 2026 09:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795511041;
	bh=oj2zs7YpNjut+Fle9NDI2/nVbuq1xcuWOh/20pAlrQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C4UTbb5sRHQE2FH/jXmMrMiISajra15rq3x6a+lSahSmxctmDsh1mJFSIFIbPqo1k
	 9hyz1hHIN2eN3IzLb48Hdn0ExvmSj/p+NCbtKehI1umvpg7ZaVRsB+rlzUCsho/EQN
	 3fQl9y78ymOzWzwyVyyJYpqCc+UvBQd4W9P8JvgobhID8I7cb2hxOrUzdRMcIofcG9
	 xZfqc0iSmWqt1jS3L78eyGKqSnU/VZc2oB8HvMlfD3tmebwKyRm9lqkCvZoqtb/gN1
	 ye2AD17Zy1NmUsUyohdHsmghvhIPHxEQeJBFI5//BvMkapCvGwOmopPEhl84e1B5Kv
	 DGn8tCMvdiOWg==
From: netdev-bot+sinfo@kernel.org
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 linux-can@vger.kernel.org, kernel@pengutronix.de,
 Oliver Hartkopp <socketcan@hartkopp.net>, stable@vger.kernel.org
Subject: 
 Re: [PATCH net 01/12] can: bcm: copy the CAN frames outside of lock_sock()
Date: Tue, 24 Nov 2026 09:04:00 +0000
Message-ID: <179551104023.3294.3966794215800671203@kernel.org>
In-Reply-To: <20261124085757.1093632-2-mkl@pengutronix.de>
References: <20261124085757.1093632-1-mkl@pengutronix.de>
 <20261124085757.1093632-2-mkl@pengutronix.de>
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
   (e.g. found by LLM and not proven at runtime). If it was triggered
   please include the symptoms, like the stack trace or kernel messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account.

*IMPORTANT*: If you do repost (for other reasons) - please include
the relevant info in the cover letter or commit messages.
-- 
The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
