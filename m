Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795798896;
	b=pKyRRkiyh/nYOWivoj3+0IPUQjboSsT1I0s1zUUKCts8AwrE9w1soWvDEXfiWBnV1M+t
	 dTfvdmo2LKtqE93mm9tJ6fJ3RDVeITChtdaDf6bFvXgoSnRWA25pG/M3C2BFmQsQOkVV4
	 eRVSL1ksBqfhn5gIFeZl8+09igKi+KDCblZ8c4DgCgZk1yxuSDe6F0dlR80MZ++COYYXE
	 rpajwY8vUD92FU6ExtDb5H0Rn0AHwuiXe9R2xHfws8WCOykXBEMkF3q5v10hOMLQt7pU0
	 NltFg48w6U9zrkR+w3heQQyrpJFdB8udeMYO7yDYZvkKIzjvoZBy5WloYvhFU1f0Y6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795798896;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=3EH6D9Ak8+Ti5XDHlSsRjKAE21BJ42aXHGgAK+PsQ2s=;
	b=OgoFUm8vrsJXs2ltsctUGbdkE5qbGeqUzuCuERE6Kf/CESDQSm9aoH6INAi1GwfyoBs2
	 8KbDhm4yOqiAsP1QyaVbGxR+TWm1UtMJLb8Mle4wdmCNt62jqwaZQ2Exu5AFvYlvtXov6
	 +D+AZACMQEPrAs+P+bEi017zVYFKx4KTIYti9NNge5BGG+/Y+8dOceUTVv71axoPsN4NW
	 paTqta6cBrj2+Rs3mAJ/ASHsreSqo75nEDpNWoVnwNXanmMTmOxd1wM/aYs1m7AZZsILA
	 wXWcTIpROE+bzJO9j5j9P+tNQMBJIzt6qYLm5IEyRr0rvEHofKyLiIkw4SxdzbN52hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcpmqqnX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC7B606A31E
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GcpmqqnX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B811F000C1;
	Fri, 27 Nov 2026 17:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795798895;
	bh=3EH6D9Ak8+Ti5XDHlSsRjKAE21BJ42aXHGgAK+PsQ2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GcpmqqnX4czvCqO9O+S/AkvGNaaCJ/LWREMN/b05JzFod0MkzZex4+DMOotFjlv5g
	 iiP4U0SRf0rjym+beF2v12D9cYjCSr4JrvQG+Co9X9p1fd5YMwnZ7qmBbJKzHKRihY
	 aDfOzG4aDBACS6CAyyNa8862KpftyfqobLx8wldn/Ivcx/P3BXC3D1t228+V/30A3Q
	 GBnV8coOEZZpG4r+5dNIr48uVXXJE3hHtMQmA9QQkPUhCJHNbejcjpqk1dVCKGk1cj
	 uSR6r+Jeqgs/Zc8SI1ZCCx1NkUku42yrNJsTPZIKD+T09zLAWOyLVMeXVoiwpJa4SC
	 qNJwnhIUUIJxw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Josh Don <joshdon@google.com>,
	=?UTF-8?q?Jakub=20Oko=C5=84ski?= <jakub@okonski.org>
Subject: Re: [7.3.y] sched/fair: cgroup::idle preemption fix
Date: Fri, 27 Nov 2026 12:00:49 -0500
Message-ID: <2026-11-26-1-daily-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <DN4MT9L8BQH8.VY2522F55XYK@okonski.org>
References: <DN4MT9L8BQH8.VY2522F55XYK@okonski.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I'd like to see these two mainline commits backported to 7.3.y:
>
>   9a92f776dfa6 ("sched/fair: Use guard in sched_group_set_idle()")
>   75545668ae0f ("sched/fair: Make cfs_rq::idle the sum of ancestor tg::idle")

Queued both for 7.3, thanks.

-- 
Thanks,
Sasha
