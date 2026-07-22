Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5830C25B0B3
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 00:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784681647; cv=none; b=SECQGa8WXCy2dH/iWLv0o30p8Dr4Ry1qMYAmeOBCFCtG3wOHmf5MO65s9tH8geczzB4rhjHzxiVC94P5hCG/MP9jZmI222WP2Wfh+FCqHNaWdnJpnhyCPURFpBb0RwmAurOKafocqcM/D7caylNkcwVwBg6XhmHGl6exg9yqHO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784681647; c=relaxed/simple;
	bh=ZNFT9zQQcEth1FDAzSEPEc0sK04oFBe8+8VbVH6gGN4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HS+D/8hcof1n06k3E+ta5vY/DpVC2BLWsroBT8YeTnCakMiejGT7sH3EPofc5kiHuhjNlAkEnmCflgakB5ZP2OdunroLzkGfGHwb/Uckwza1qvlt6w+inpfMqEHe8TRQ3HtfaDDKlgdkMznLFgW3vRRWHhbLL3KV22qdYsX8Zak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqIjg1OI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqIjg1OI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25B251F00A3E;
	Wed, 22 Jul 2026 00:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784681643;
	bh=wPnx9Cpj1H3isxkE04eewuN13eiI8GgYrWnMgg5A7Uw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JqIjg1OIZqRPBqfXVSYvngUCvnzunz66XRX+a1ioPwbRUUv+bdz8Zjo+zjArkQZB+
	 x/gaZRoXge8ZtqiYlceu488MmqEdwDomkwxPR1Af4sniPPuVRzx/ap5qLVAVP5HIHV
	 ckjZKZ0t3A1NDV6ylwe/LqYfcdypdlf+AplKaU93luXCaYtFJQcrK8LOky7cckHtyI
	 hxZ77qYGL3T5jv3y8NkMeQgQ/1N5D48B0yhSWNdspYgkRpnHv/0ZFPwRRMBGd4rbRd
	 sZAisgf9BloNgh1tBX7+tX8M+SYA1gSnZfgjcoGbuC4tXp8V8DzdXd+VdF2f0Bgp6o
	 edKUvgbjU3xHg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shivam Kumar <kumar.shivam43666@gmail.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v2 5.10.y] nvmet-tcp: Fix potential UAF when ddgst mismatch
Date: Tue, 21 Jul 2026 20:53:49 -0400
Message-ID: <20260721201114.0002-stable-reply@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260721135845.16642-1-kumar.shivam43666@gmail.com>
References: <20260721135845.16642-1-kumar.shivam43666@gmail.com>
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

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
