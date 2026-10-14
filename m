Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B7B2D949F
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 01:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791941251; cv=none; b=q5QZsuagvLb+s8COG5kRVKjRqZcIKypaSBZAaIpoXRol+7x9WFkQOGupxxU76CSOLHPHbIf2k4GkpLthT0zIeK4nL86ky2zONZQaG2nkKAQpwL6KoORsKcuorRCthPqXc+/ek8a3LENp/jyPtM8O3iaQ5PZ8HJzJbRVvkgFFANU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791941251; c=relaxed/simple;
	bh=+eSTQMUD/e5hUW1cuijMMx03FReZ5glcFxgAcJ7xdoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2zpOzEipMpOJjuOQZ5AP/jZKkXGv0JqW5YzxFbb9ergY3kAoUWnlX+cMr1HQ3TIPXupzoqx9ZvVkOFfQHhz48s1Px6ZUm5MpaY4mDZKBOJ+9X44RPjgIUsrWYKYLcuR2TAfhpIUrtBl4/I2eGndocB7K86z5fvS7OtOeekvsNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRnzPLX0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRnzPLX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E9621F00893;
	Wed, 14 Oct 2026 01:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791941250;
	bh=G/DwHzJYElGI7U8fDxhsQtxWyxKOsQMegixRWQtBVig=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iRnzPLX0yedH14GEncqEOpHUjuemPgFm21raXBYgsQzMjzrtRgqjbq3XI7Zdnmxpu
	 Ly2bnXk2mN+pt5ZCXwekusYnD9g/iq2TSzy5bXUturlW0loyI5e9L9o9aBBsrbCEXX
	 3FHL+Imx6vn/YLxw9agMT+WLWi5z/qJZqNbyKaCKMmV7TAt1YJwnXMaJu4vGZNfPea
	 oRwGeOrdgsCfJGlrpVpo/nvzV8TtblmS8NXHkSH1Necflpu/kSFgT1sf+46TrHcMSE
	 yrA2wrCwGQxUXxSJuvsBi1kdlYRzs215u+aKnVT2PrGZg4zpusIjxPTdYLouoAEofz
	 FMSL3S2s0XSGg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Joerg Willmann <joe@clnt.de>
Subject: Re: [PATCH 6.6.y] can: fix unique skb identifier regression under RPS
Date: Tue, 13 Oct 2026 21:27:00 -0400
Message-ID: <2026-10-13-1-daily-reply-0009-can-skb-uid-rps-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013074243.288346-1-socketcan@hartkopp.net>
References: <20261013074243.288346-1-socketcan@hartkopp.net>
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

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
