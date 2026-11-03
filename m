Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702058;
	b=5NKJSEW2AeQaHpujYqMwI4/EeSQh9l3hhVBb2E1ntbUYs+8Cb9ZkHS9bE6lfbF2k6uRB
	 v5qjDyjCiLI5DttDGzwxPkxa+H7ff1Bj1JYC0CnVV3WtZz7HwgaMMwiD+CLsCv3zkmtCP
	 OZ+OYK9DOMWkXHrH2MgclhPyaVZW4oPWIosADSXfIjPBeHGwnYZP0pb2JKzC0hb+dI617
	 szcPhLGTBRIldz7DQOzsd4VUGIpV/YWfulOqBF4vezYv10o392MOKPnzciVFtAWzdm8CK
	 1xTix35GDRhPkGV8jDQZHh7Izb8DCVcbmipEJqKs6edJgYqI3JGU0SfFoiAtE5CyUmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702058;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=b7DGNOCzdoGGPGKxSnjekEMmcW6S4fI5lLNzQj77lal0fFmowHgVEoiMD1cLIJGIQbHr
	 0rDVPrBa0E0T6/2uES0Pw0aAFLqkdTEP06z/N4WZ2Ip779QVoGxOJ8+EsoQ95QgV8YE1Z
	 /fGjm3XsG+yITjOuhowKozkubJ0UeXEA2j8G6IUk4GSRcpU4ucTt50FTI8waap1X+MvX6
	 3wvndsPks2BJRQgdDfCGGLYxdkoF0eugkK2+Cge1F29aHdj0myhAeh7HylPcBxm8UocGe
	 tc217Rmr1Q3zS+L7lDls8WYYYJPdmGWlXLwOOE+Nfw7ZNDzSZ+Ti4uyPg5KpkrcCUQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fS9kzwX5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A76B6072BDD;
	Tue,  3 Nov 2026 10:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fS9kzwX5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE9B1F0093A;
	Tue,  3 Nov 2026 10:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702058;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fS9kzwX5oTjQe2eOwu1aNP+Tq0dkbISsvl364Kf7Rs4pqyuq1Bj2lgb3EdLvhqvoI
	 1POGbaB3RP5kyT2j3x7lLqBXebo1x1MvN7g01wXyk5H0fyRliIRiyE5LXrtOaq/6jE
	 rPxrIn+5yBCcHIsfGtVlY53rPucIvhxao3ZEMuDgb2tIPP1I83sG59wFVffvuxagK0
	 QXV9UJUa9Z75VqCNuF3HBvBKU3a8fOdQvby9KYwlk8Ssn1GSJHx8kCN+TPQPDaomql
	 /Vo8968vOwafgckx6CyvK+8ZG7XT9gz/giQNXPvockgDZGy7yAbVPgis71bMBWRKAS
	 UrtYgD6vD/IQw==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: free RX resources when TX allocation fails
Date: Tue, 03 Nov 2026 10:34:16 +0000
Message-ID: <179370205694.488859.8314003939394289435@kernel.org>
In-Reply-To: <20261103102857.1340748-1-vulab@iscas.ac.cn>
References: <20261103102857.1340748-1-vulab@iscas.ac.cn>
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
