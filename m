Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE6B511E7B;
	Tue, 13 Oct 2026 13:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898812; cv=none; b=P9pnaqlSJ5W+YiKi9lP3wvMQxPKzmfVrs74Oo25Gd0WCM6UldN0IuKtSrocXST5g58w93yocqzAKusba+FzYulG4Sk997TmhC++9jK0XNdortgopTWXm+M+Bb+m8/GIeP3zfd2P70od1zuiVJXPNfTq6woDLk69xeATu2nEWkkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898812; c=relaxed/simple;
	bh=DxOA3K04TdGKgV9RBzwq7NMB042SfZvdvrNpiga7nYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pNwviLUVIeUCnTy9pSmQ+fo/IEuiN53pSpFlRQkP2b7RXhI5rWd3TJXCGQfIvVcT8FIgSfcN9Csxur0+tlbx5+p+Px94pqrrsx2I+SboFvoiG06jocIJJlhJXVpg6G5qFw6dgD27OKMHqNM4QXWY+25+U0PkUNLaQQHlnPGdQZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MCqGx9UD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MCqGx9UD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 719A51F00898;
	Tue, 13 Oct 2026 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791898811;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MCqGx9UD9NHZ8GC6Bbw7B71cpl1VU8UyokYAOriwEb90sr3M4PoMaRAz8tRax9vyN
	 bAwXjDmzXXpLUXk7ErgKXdfATQ3bHL2JnHpTqvECLEmk+AKNl0CpPF+unkDyikvHHu
	 dlwQc70kBpx4HCE+L2/jAK4vCWD8A9Xevrh2SLLxgvDa4WsOtwb2G+RZxpoo3zykSW
	 1Q4mrhjOUWrdJ2jYqJ8mj6AgHtIh/WqHWeThv3pOoxpArEKZwPCMUjBFc4MsxFhdI5
	 7wl60MdU5RHkSQRcDHgQC7gTkpjITtAT4J5swbCVOiXVcdpW4EDFSLB/i0OQhfLxxd
	 jGLTxVDD37dwA==
From: netdev-bot+sinfo@kernel.org
To: Thomas Fourier <fourier.thomas@gmail.com>
Cc: stable@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: 
 Re: [PATCH net] net: korina: fix dma_unmap_single() length in korina_rx()
Date: Tue, 13 Oct 2026 13:40:09 +0000
Message-ID: <179189880997.2527009.13708464565955754813@kernel.org>
In-Reply-To: <20261013132319.22253-2-fourier.thomas@gmail.com>
References: <20261013132319.22253-2-fourier.thomas@gmail.com>
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
