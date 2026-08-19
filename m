Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2D73C1D43
	for <stable@vger.kernel.org>; Wed, 19 Aug 2026 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787110356; cv=none; b=KXR5eD5az8Xt7nM/XkBddxJgx2E3+Ej0H519c5J6s/EzP60ZKc4DEC89cyL/66a4RzKzk5in/wgayfm4EVOnGjNUH7ODFGYTM3l2S2LVhG4/mwOS+bf/J1v6vOc9mObpYv2fMggu7yLLhUuUCwIEvRjjW3OA2NcfO28L0z1IBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787110356; c=relaxed/simple;
	bh=6v1lXS1RC5qX9igi/umx8sB9EI0dGbxgSOX6xB+Q0c4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AR8lKDMR2dSWheaNZiry1iRcJimJTxSbFyNx/fsthFpMmS9gd0mq+EBr+waEU3E4jDMgrre3b0imaMoBtH3Bo2oHrO1LJYbd2Pg/dW9pq5mCSkhZdnaDeyz1BUdLvtTlCr8+PAb3WtrfcLNVlCtUtswfmJNS0BbOR16oKSMm96E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UdG2V5gF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UdG2V5gF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C4C1F00A3A;
	Wed, 19 Aug 2026 03:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787110354;
	bh=g4eeoRNHUKBkuv2AofupOHTPLHATKXotSQvoqmSNtSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UdG2V5gFynfuAnrOOXzz2Uoj5BtPgvrQJ7h7X+HvM7UoW2hzKtEYnK0H8LljQfC7j
	 9Jd79opM8GrJtYHpcb/n69TIP7zRxhRNlXziiRTlpD5JKADPitgTWvJK66XBCQswfi
	 ZF2lXolcp/1gy63HmUrwVNHbTnOFmg26/AXAe1LGrpRSEHZrRiQby8AyLm7SsDcn2l
	 csswazjbm4R704cT6PnowMDbev4WSCbOw0U/JdipsmTR4/keER7g4IxOprqpBdzYRJ
	 GGm0j6eVJQFksLiRAUy8cYdcKXYvVkregdSxVe8IzFtwW1oeGhgLnlydNnKWL5AR3k
	 w20Ak6Nbg3WDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Shung-Hsi Yu <shung-hsi.yu@suse.com>,
	STAR Labs SG <info@starlabs.sg>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH stable 6.12 1/4] bpf: Fix linked reg delta tracking when src_reg == dst_reg
Date: Tue, 18 Aug 2026 23:32:17 -0400
Message-ID: <20260818220420.3@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818081428.57938-1-shung-hsi.yu@suse.com>
References: <20260818081428.57938-1-shung-hsi.yu@suse.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Aug 18, 2026 at 04:14:19PM +0800, Shung-Hsi Yu wrote:
> [PATCH stable 6.12 1/4] bpf: Fix linked reg delta tracking when src_reg == dst_reg

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
