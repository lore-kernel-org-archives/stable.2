Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A17134DB74;
	Mon, 13 Jul 2026 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783974855; cv=none; b=Q3in7ldFVdYN3zd0hEez0QgINCnyneaMTqAiJi3cJi9m6E4zKzLd6hPxG3JBwM+O2Q3cUN7h3itgyBuK5Iw/n96Cr0IuZkvrstxlggupsDtBUwfCFwl8lC+pMOPF/QirxzXpKMz6tf8nmuiTvNXG88knTqODkbcRXm/BCmQVCY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783974855; c=relaxed/simple;
	bh=VjxSTB8DKbI97TuQ4NJC3Y98VFv42qxBh6HRSLMb/2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r3tjyh4FuAcpwYW69aG+UhEwW3fcQ01A1uxtPWHy7S6NSpOvYwTPqh34MOIG2okyPUIj5lKHiItZ5J0e2R6GXupJ6wY+ofO+BYVzRm1btSZiEW8GuxMw2XlTW7XM3noulQaqOQKm/nX0OVxftjfTQiZcGi1ni7yaqXAdTVsJmBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LiMaqzwO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LiMaqzwO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAC011F00A3E;
	Mon, 13 Jul 2026 20:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783974852;
	bh=tOu15TeE9DgWFxBFFS7HIMRjsc5RxNDgyFisjixUBK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LiMaqzwO0HzlduMnS0sgOqeUYryCRA4AvC9XAPuRBynoTLqqtJlmhdvUEMQRuQ//n
	 S0Pt+xaF3LFVvlMZlkRtH6at6Tc8q955n9LqGEa2UCkUpmU5g/UkT1swfooQBM/c8C
	 566rr49qGnnyBiTGrJ/LrtG2jFYbSaouFtIobWIYTxW85P3YRyP8qxuN+9txPE5fJE
	 mSyLZ5n/20v6c5uPjVH+aTUz2ZfaHGFP1onLQZYXoIb1WLRP29qHow7Ni4kx1GpNoN
	 nnKDkJ5tb6JfuAcRpmrscdiiQh9+lbTfJSukY0KginMlYtLR1lX3tk+gKpG3osdmN1
	 jcSOVLl8vbgCg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	bigeasy@linutronix.de,
	willemb@google.com,
	kerneljasonxing@gmail.com,
	edumazet@google.com,
	pabeni@redhat.com,
	lulie@linux.alibaba.com,
	davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dust.li@linux.alibaba.com,
	heiko.stuebner@cherry.de
Subject: Re: [PATCH 5.10.y] net: Drop the lock in skb_may_tx_timestamp()
Date: Mon, 13 Jul 2026 16:34:04 -0400
Message-ID: <20260713131907.agent5-0004@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713025017.38079-1-lulie@linux.alibaba.com>
References: <20260713025017.38079-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> commit 983512f3a87fd8dc4c94dfa6b596b6e57df5aad7 upstream.
>
> skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
> not be taken in IRQ context, only softirq is okay. A few drivers receive
> the timestamp via a dedicated interrupt and complete the TX timestamp
> from that handler. This will lead to a deadlock if the lock is already
> write-locked on the same CPU.

Queued for 5.10.y, thanks.

-- 
Thanks,
Sasha
