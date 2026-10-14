Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 104A02EC0A2
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941251; cv=none; b=AzcgXwHu1Gn5ftRO11LoO1GpaK7tkEvMDKW684/PaCysdv+hvk9QL+EVFOBFbSIdAqCnlq6IJXyIbyWUBPAWUM/dfcJjfnEcEf40MNwrGMbTGjmItmDA20yHbWrkqbO9fee2AoSKrLS1b+WpaXR8RnB9a71XblzINmUZRL6DwRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941251; c=relaxed/simple;
	bh=rqyVgETzkmgFPBWVCOuQ2KGf7jOl5gkg6sRWxqEK9BI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4kjWLT680sBTxs6enkyMCnveSHzQf9wcJd7xc+lcZcjc4cCNULFr1j5hPi42Zkl+b/NiLlpmweJt0HgeLQCdzTw/BU8WbejTvqib2MavDMPqUaFD+sLZyHFAwD7DiuGVPW/jdAP0q2JVZrcPilQyuIDwfGMqKISqWdw4bVIaN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOF8Kl0R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOF8Kl0R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E2251F000FF;
	Wed, 14 Oct 2026 01:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941251;
	bh=9DeAZP1wmn9STeJnW1qg+ivCSUq46Mh/aNmiBTmiszA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hOF8Kl0RPcKESPFUfdEQDaJRC4mThDv2imjOPiFwH0YqqBR1CVfkVIYyLAOJ0mab7
	 2UIienEbFVQ6PhT+/pVbNu4p7xaLYTE07o51QM/bJ/RHnDu0hVxyje/0j6uE7BTw0G
	 b88tfEa9Gmf2ZTe/zr8McCKx8oYkzoIog2fQ4LsdnHtOLyofHcB+rfXnOrfLVtnBkF
	 6dC9TyfFPpEIyRNm1l48gGDyB8hKV/Ml99pspwxcFJcNosKoPfsT06l3Ej9S1IDOKl
	 u2CBRmA855rqj90n1iWZp0XmC434ITF8EFflJ7pY6P/mnzX0mCrYDfS34DKO9M1ubx
	 zNDGeeOAQveQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Joerg Willmann <joe@clnt.de>
Subject: Re: [PATCH 6.1.y] can: fix unique skb identifier regression under RPS
Date: Tue, 13 Oct 2026 21:27:01 -0400
Message-ID: <2026-10-13-1-daily-reply-0010-can-skb-uid-rps-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013074222.288326-1-socketcan@hartkopp.net>
References: <20261013074222.288326-1-socketcan@hartkopp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Commit d4fb6514ff8e ("can: use skb hash instead of private variable in
> headroom") moved the per-skb unique identifier used for raw_rcv()
> duplicate detection into skb->hash.

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
