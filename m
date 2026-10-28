Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793164016;
	b=l7Z8DHzm3rDG3yOElGsyjmR22abjISaA07R7XV+NxA4MjuMnESKh4F9wK9niJzOouiuY
	 pNoq6dOZePvtfuBDBaNUNQFR44Kd59uUlFcdOrhsQHTq41xi2r1Ji4MjrNC9NvZ6FrrXU
	 KBa1+FImm4sHTygDe3KL10DCIxO2cJpNHbTQ5bzzbc4h6xZUEjiC5vshyckntRyLimvJG
	 tBGUTf1JJP2SJBzgsLsLWqTBfnNpWw6/XbSGrx7pyYiKfq9yQA5xYde5H1sF943s4XDNP
	 ir5NLMBXuOiCVwc5wc3fpkMr8Xkkp25sDT674Tl/q4JOU81MSdLMqvZg6AC1yqeCo1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793164016;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=LiRW6iv3MuIhsNXzrZMEbUs0Az8htm2AbgWP6IOUqWqYaL/HlTZCOXuaTArq7LFUUWLd
	 wwK4bFy2WZSQ7hb118QNIYNcinTL/p1aiirqijq6MdFJCchCeKFFjBrvCduoqduOhRQho
	 stD8SIKcVQj/wqINux3YLdX0HZLC1LqouUbIPPv00B+CVwkr/jp/wVmh217qnokIfe1Te
	 YzFL64D3TQ//mmlfDZmw1AtPEPlVSOZ370C68+ajpYxVcvsH4Z61Bhv+cDBN6tNOfy8Q9
	 +K805DG28A/TR9JZT8hVx2JKWUf1goY/pGrEm9ogTitd9QFj1r3hLk+Vzk5NWPAr43g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCk9zlCq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE9D606A31A;
	Wed, 28 Oct 2026 05:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gCk9zlCq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7A121F01825;
	Wed, 28 Oct 2026 05:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793164016;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gCk9zlCqKFQoDnvknNh8Tt6vir7RWgbV37t2cnL2jsrQUYkBvM8d5bGBfrChWIjSK
	 60GrI0ZSICji6yKrK472dVdDZYyuz+Qcxj7bQAo8c0pgCa4jbe+5fCPyg0F8uN8HN7
	 JSOkNerSzIostPvLAjc7g8jnDqgqb/hJWHYrQn+kDtLVzp9WsILAOd870e6nouG7lI
	 85qyw6uOAEN6mSUa40vSKLcZMrQylSt7QpVoCyeHHi3BlyWLO3C4FmIZsis5MbHgPJ
	 e4tSA10jXnkPnrch9o//a6mPaGiXPeNyAH/prNPnYOVy13UJTD0CM5XsRz4oErAP+p
	 +Zo0cCXS98lvQ==
From: netdev-bot+sinfo@kernel.org
To: Jiale Yao <yaojiale02@163.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Christophe Leroy <chleroy@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: phy: only remove owned topology entries
Date: Wed, 28 Oct 2026 05:06:55 +0000
Message-ID: <179316401520.3327.16652152694923638855@kernel.org>
In-Reply-To: <20261028050312.126508-1-yaojiale02@163.com>
References: <20261028050312.126508-1-yaojiale02@163.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
