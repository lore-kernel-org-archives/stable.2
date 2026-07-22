Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5235A35F192
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681645; cv=none; b=b3+Mq2KvHHAiszLn1yufZA+DoENTbze0oKPcBN+CQRRQ4+R7d00JLimNLEekO9/sNZUrAxwBTSwZ05tVHjXIiSPZyzKfwOFwfRwyhWoREEe8Z2A2JcR2K+2zx8uLvxgSIOOFh2c6u5AKoBC2bnSegW45GamNBfQiUTf9XJHv6Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681645; c=relaxed/simple;
	bh=2Tj0RY/gKQs5yrMV0gEqDHBf2NUabCZlWNRYeIPEZrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jnO1FGIe/KMAPuViPG/Bl//P3wf8ZDQv0vWIDlmI7TJ4wG91qjApud/bkc05Var2mKlaAqodL4hyTK7AeB3+w5hUFNGs2hwzm9rtGSnBAfnyqMfTrrwx4wNqByLb7kTajwdVMwpbDbcQiaDXVadYLjYds3GurXdEgoV8axklznM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yv6oA/X2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yv6oA/X2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 354E81F000E9;
	Wed, 22 Jul 2026 00:54:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681642;
	bh=RY9t3Nxt+kocw7miEoSnl0bzrcTmAaknlsRRqOwvjJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Yv6oA/X2gC1edbK+vyWuVMwtoWRHaMBdgRC/xYDUu1+sAt6NIqYAhog6kyTkdpTXK
	 TgBflngHw8G0xC8XHCLaQOxewpBhGcIpYmqVqVZuKpsmPQRIcITeIJf/aR17MY7iyX
	 LP95Rt8dlKC9uvEujrMFFMSwWRwEnESa6yQxxaZweGJc8lJNjnLe93hlPKHAuTAu9A
	 RHxewmwPBBlhWrkL5XNcMZ+kiv9F+i5unxDTrAlJHAoqCkk2JzBWK+jGoZFb8N1H2t
	 zJ1GBeRiz282V3ThN9cGDH0QfXfC1AWzURPxAF8/XunqGaH9WxruysE/0gTqTV+Fj1
	 jbmiZdeec0UnQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shivam Kumar <kumar.shivam43666@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2 5.15.y] nvmet-tcp: Fix potential UAF when ddgst mismatch
Date: Tue, 21 Jul 2026 20:53:48 -0400
Message-ID: <20260721201114.0001-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721135438.14435-1-kumar.shivam43666@gmail.com>
References: <20260721135438.14435-1-kumar.shivam43666@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit dbbd07d0a7020b80f6a7028e561908f7b83b3d5a upstream.
>
> When data digest is enabled on an NVMe/TCP connection and a digest
> mismatch occurs on a non-final H2C_DATA PDU during an R2T-based
> data transfer, the digest error handler in nvmet_tcp_try_recv_ddgst()
> calls nvmet_req_uninit() - which performs percpu_ref_put() on the
> submission queue - but does NOT mark the command as completed.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
