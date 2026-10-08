Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFE4448B96;
	Thu,  8 Oct 2026 08:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791447332; cv=none; b=OsM7pLEyb/0RZyklWW4D7RPiNUDGkd/ctZ8rO7Qp3zzO1DF4ukEqkbgkPJt+KN9RR35ttRmM6IUm+IT+bThx7BumjgW07sI4A+ypSBLMojOmqAHI/J8s9fIkzh3XH6JELmZ8W6cLFPPFuQai1O6rpU8LLsLYn4h9cwIXsDuzr/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791447332; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lowqajzvcum2LAmBqEvEcYKRrhAJh1ZsfPoHriutQSp+5TkhKnD8qmsJa6o/GbfmO1r9dgE5T/acqCHPNN0YAmEYxIvMcRJ9woOxDofv3ESTosaPxJCDrgQ9qRHh/R35hL/vVokX2+5wWoEyENohlSw8gAUsfQ0hj3svLAadwVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQES6Boo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQES6Boo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2D51F000FF;
	Thu,  8 Oct 2026 08:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791447329;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZQES6BoosN5HcQNjgNSh7421R1F2f0WtvD/WQ0VI61riJgcx0jopZAgBCS+vgrYVt
	 4U67d6xVKomzo3kWwJ8GkRmEfCG8ItLeZ5NeUmk3FdQnuJ8DtijBiLIFkcNjTJva5X
	 hA/3bchgvYrp2HMnv8d5Gl++DXCJZNLha+KCwlBH1G1MTw78Xfd628yCgDh3h8Qw1k
	 b3EQ38at/lABZQKqRF2gNCk4q6mjlMGhOkBMadDmFuxXlquuZamBFS+XMifgNH1lte
	 qMee/TR4kQo59WNcMwfaSK6w+TqPowcqhkPG6hbjaMwcNpfvW5hjwTLRGWhmLEXjZ0
	 +SAfHVaY6sGeg==
From: netdev-bot+sinfo@kernel.org
To: =?utf-8?q?J=C3=A9r=C3=A9my?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: Sabrina Dubroca <sd@queasysnail.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v2] macsec: prevent AES-GCM nonce reuse after packet
 number wrap
Date: Thu, 08 Oct 2026 08:15:28 +0000
Message-ID: <179144732865.2527009.4589205158706524011@kernel.org>
In-Reply-To: <20261008080625.360063-2-Jeremy.Jean@oss.cyber.gouv.fr>
References: <20261008080625.360063-2-Jeremy.Jean@oss.cyber.gouv.fr>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
