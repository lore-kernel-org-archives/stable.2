Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6499924E016
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828853; cv=none; b=tOaq7QgJPyTXaUNWBtxT5BOdaQn2mYYDNhGTCCaniOpzn+QzLyW1Y4JVk/JzIJaV1qfB/LgvokTAEwvBNWNkdh1LdsRkyqFBICsFNac+XOs1ppykGJZhLelErVxmqCNmdGJ/gW4ER2BcKSIxNDwOrl0UaidU8EASFPealKMK+u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828853; c=relaxed/simple;
	bh=WEM5ExpRATbN/M5cR8q5rIRCXTtsnuOypHzpWyeDAXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rOCjuTeXb4XSevH4zl7w/pYCaQ1Bvd11mORkuTqDQ8l5GjgW4CNxRkSwhfp3CoXJEwDWMqaAmccA+6GupwXU0XmvIr5Dak7jcELNK4GJ4TXl31pKQLAqcdaq6TI1hI02W2PHBRPjmBBRj5nupZqdBlxlB0ftlR5uPZPueJcQg4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=adsyiTRW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="adsyiTRW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A72081F00ACA;
	Tue,  8 Sep 2026 00:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828852;
	bh=yE9KV41xZGRWv9IaGV3abOYCBKMwbHq78Mb25Mv0d6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=adsyiTRWGL1gWFvu3/mEEeHc97bSiKN6OOx5GGhJlUPbBjVtAcRS7faJ7mz3aURgH
	 4EnMsxPd0QuojTpoLivD3i+xWBJzEOfAuxNJTUdsfKX3tP5KxNO1iNeT3wB0fERE0k
	 c6jSxKNaauHKfovazUVikwZTwW52tgAztJT+ATPSW0zjxOldRT9KWXDOEECobdUvas
	 tR6DsKOMlqr4OYhRY2fFjAMNQ27AuS+VJDJOocywr8k5RYv6HV5gwKsyQ1q6IMmN9/
	 BB8MLF6KC+IgWp+EGpoQ6f1Zr23DUDMw9xOOCXIVKGh4xqKlyvSDmkmS1Vjglygpby
	 lLSB+H0/TotVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Dave Jiang <dave.jiang@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y] net: ntb_netdev: Fix TX busy and drop handling
Date: Mon,  7 Sep 2026 20:53:48 -0400
Message-ID: <2026-09-07-daily-reply-0009-ntb-netdev-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907025929.469386-1-den@valinux.co.jp>
References: <20260907025929.469386-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 8aaa47351db0f93a5c5297fbafdfa8bc75e8ae49 upstream.
>
> Currently, ntb_netdev returns NETDEV_TX_BUSY for every enqueue error. It
> also increments the drop and error counters while leaving the skb owned
> by the qdisc, and may return BUSY with the subqueue still awake.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
