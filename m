Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35202184540
	for <stable@vger.kernel.org>; Sun, 21 Jun 2026 13:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782049681; cv=none; b=HtdiKFBjyPAmjnNLFqsLU9RrxDwy313TfEExEKSWli3yWPzlJXiL90/bY/rv49A8/YTBgaffH513nGCVkMVXO0lH+XkqTyC0n+bsao3Ma93ktjzXMgdPvTC16/iqMRC+KVFo+JPGeGS3iG2UmVc8Xs5MLy4eVG2FloAurXkwgZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782049681; c=relaxed/simple;
	bh=Zbm2Di0rsdxXFf2bTuiT+YPbai0Fib/fqqZI07eYrnc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9tY+CMd/nMKqPVA7rqJmQ7ulkYkO6jY0zcqSs/gar9G1A0RYrkQlxMKE+BBaqrnHYNpnySQgolh+Y7aAxSi/vhGA+AxPhEps5ohkztHdYp29zlgorR5i7XGDjMXx6ZLXrJVBl6bWyyCBWqEJabYXEfs85pQ0Yv8LVT490TG1bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aFNv91O2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aFNv91O2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999771F00A3A;
	Sun, 21 Jun 2026 13:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782049678;
	bh=txM1EMZdcsl4i9R1s1vwl8uZKZ7KBYlXqAc5zWVGZ2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aFNv91O2CC8MjV01G6t7PvV28TjV2JEcnaiO+30LCk7P/ttpxfB0ArIjvzgd4xuG1
	 QXkqiMpcGxKlHzsJ8ZctA7+X51iWSov6Zymy05AKiip/WpWzyitrHU0zUE2w69Pp9c
	 Rdo46gaVWyiJp/52UKcc0eSmQXTRHbE1po5MMxcXZgvBi/DgSy0S0zDEMdE8ngfaI2
	 9I7mBRkoJtq43DYov4aGk3VhvfPwxrP7eFz1zLP5ZIrBYi1wy/TxL1fobwoCYNP1E8
	 blTFdx3yYfL+tnjCKDa73pVxRxpK1YOe+zaPKXJWSehVN+NsV/ww2IHVJx/qCK35Nl
	 ladCAV1d/Hngg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	heiko@sntech.de,
	quentin.schulz@cherry.de,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiko Stuebner <heiko.stuebner@cherry.de>
Subject: Re: [PATCH 6.12.y] net: Drop the lock in skb_may_tx_timestamp()
Date: Sun, 21 Jun 2026 09:47:44 -0400
Message-ID: <20260621133722.0006.sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260619152012.2016837-1-heiko@sntech.de>
References: <20260619152012.2016837-1-heiko@sntech.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ Upstream commit 983512f3a87fd8dc4c94dfa6b596b6e57df5aad7 ]
>
> skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
> not be taken in IRQ context, only softirq is okay. [...]

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
