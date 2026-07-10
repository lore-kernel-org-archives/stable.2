Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1D832F765;
	Fri, 10 Jul 2026 21:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717417; cv=none; b=Tb0MGJbX0DzrisCFXBQoBJ83H0mOTExUREHzyyFHpHyFOCPjoC8hVyl2vou9Ut8LS4ZWXGy2+sqfLY9XmeEffsNac+ofKujidzRm3uHLOsrCbqCCWNIvsylArouywUPtu2KrxsaE4zTgD2m5pCkOovFzr2sxuWX45W5urJKxqB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717417; c=relaxed/simple;
	bh=LoueaCPR3KuWjsRpBMw3ws+M+YThOyYVDTcq141cJVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CsX6MlwigBOnGq9xbvRaqDX29aZt0dE1/B9WScieD35yB2NIPyYNc9QQ8Z3Qqw5EXdmvCQW5iODIBkB+pYzhypqiPYxD6adumnwWOZHxVKYgX26CYK1E2Q0jeKNz+Zn/3aAcIToP7FnmWeVVNX1feKc9kxLBkto0ZeiuPxmwvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3pzzN5t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3pzzN5t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320C41F00A3A;
	Fri, 10 Jul 2026 21:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717416;
	bh=091RSm351wueY8NvWEvHqUD75rk3Y9BZ/AS/hw7BcwQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g3pzzN5tdiqGR/YfzWpILhi4DxVcvUDtoxKp1O4p0pEdifA6ontp8IB0WBumsK+LB
	 2t1gBw3OBr5oKj2XiPCz9kiTwmV4CRQvkt7Jwb1pDVyrNtUt7JS2DDpRFI7zs/gUjh
	 PPs3+AK8DJGmAcb8GG3qdJWcsxjQKgl79WbNNvMlXGyWsICpkSc/SMQwM8YBoUmLt+
	 v9u2r7y7BIYMTFMpzDTBltgJK1TMRPIeLOpzamKw9p9+2pMxmtkBe1A9Pa3hhVJI0z
	 Ssw+BPfOXHmqHRsjwSBIaM3c3S77LyHq8EWXCmmpf8LE4HDyIOTY+I1IlmSNffAJQ7
	 /NOp/vIESDUAQ==
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
Subject: Re: [PATCH 6.6.y] net: Drop the lock in skb_may_tx_timestamp()
Date: Fri, 10 Jul 2026 17:03:08 -0400
Message-ID: <20260710163023.agent5-0012@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709125816.86769-1-lulie@linux.alibaba.com>
References: <20260709125816.86769-1-lulie@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, Jul 09, 2026 at 08:58:16PM +0800, Philo Lu wrote:
> skb_may_tx_timestamp() may acquire sock::sk_callback_lock. The lock must
> not be taken in IRQ context, only softirq is okay. A few drivers receive
> the timestamp via a dedicated interrupt and complete the TX timestamp
> from that handler. This will lead to a deadlock if the lock is already
> write-locked on the same CPU.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
