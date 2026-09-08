Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE211FCFEF
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828851; cv=none; b=nwVVEcAdiN4y6ixDcC1jADgZ2FftZE8Hu32OeoNEZ1xXQH7H9RpwJYaZMs0ZnlcHIoNFNBmaRp0CeqAfc3jj/rIFVS433XgikIm5KEXe7x3sVOsNoOY4DHAoMI9sqd75uxjAC5inWUikL1Ob5ZtkCKOYcqf6GF/SoV/dMbKga2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828851; c=relaxed/simple;
	bh=RX7fk0kGEA5PB2CeAajW7nEAjOT990ZVEVyzro8epeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkHvftJ0tZfJjjpMzOZYsWohWWW7cGL2Zg9ciz8vaJPop7mvHNHQaCmsweyme7itgR3DKycEj6rlf5PZKBJWmUjD0ZImYrHe0YaLD3wj1koczbK+QjpopQi6biVSqxtc2aPgwigYLq59T9XmkDd0AuSuA1o+a2rB49iURL3UmBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EWPM41XJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EWPM41XJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C511F00A3D;
	Tue,  8 Sep 2026 00:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828850;
	bh=oLvkFbxrx/brW/5CWeaci3ywJK4m/qDSrplR4DtlUfs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EWPM41XJnhYdh1EvbYBbygIUnQsc68DCHr5RPKAZqBPDIdXfdzJznzsxBJRF6X87I
	 4L4v5RdB//ZJXq7zCz1zWCRMwQmj7riCHnpuNY1mzpWZumtywzlzbNFP+Rp2J28Tk4
	 CcYTbV0mHbk0aM3c9FdtKd9aCu459kIOHZxGvmGhfU8shBnGKtsutNa4XoyoWXgXX2
	 49gDg1aCn8dzs7v4OgqeMUMpfP4+16okd8bxG6U0rjvpB8Nt3OmXBw/sH3tyrd0fVM
	 iVYvazRCd0ae7RemlEvk5qQsvXnRxlSiIoTvTGzUryKICNbjSxMQp7reg8EwT+Rw+S
	 ruI7RBnJgX3UQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Koichiro Den <den@valinux.co.jp>,
	Dave Jiang <dave.jiang@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.1.y] net: ntb_netdev: Fix TX busy and drop handling
Date: Mon,  7 Sep 2026 20:53:46 -0400
Message-ID: <2026-09-07-daily-reply-0007-ntb-netdev-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907025840.469024-1-den@valinux.co.jp>
References: <20260907025840.469024-1-den@valinux.co.jp>
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

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
