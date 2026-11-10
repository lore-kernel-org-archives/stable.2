Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344402;
	b=bOsEIr+23OIxi2A97S6Y4fbJ8KHui1i14AmGo08VdXGagwAbcwWa7G0qJXXS52RL+PXb
	 WGvudzc21O66PsxpeqnF5Afb6ccGhebTJcCD+yOysnYWd6tDb8tk1TUSp8XgDHCd0O3Fn
	 J+WyuOgTPpTOi9BLFcqVtbpewsn/C+0rJHwiliGK3B060a5SaoTcALUU8rvl0H4xnfojI
	 jTJ6Uc3UWzgiyANb/Ls/d5ZSm5t/vGE677Z+G4uO+xSxj2SX2/8ePjYna1W1bv7bquqL9
	 kY2nnLkQjoIK/gq/0SOMpGcBxQp6ouwyL9TUHw42LqcqCbN8ylspuBNkZ7y9OaLpFUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344402;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=lFcW3tBywnjHNYcpFJYQqkTqNU863ZEvHshKQCio2zQ=;
	b=nAO2ohVLxhs20qjJsP330D2XpqBplvo0HNyfE+XD6SgIkfq9xVITt9xyUUT00Tha+qiI
	 wIWez+ybzCuvqu8Y73TEA3xSIrjtGaeBR1F/FPBLjPE5nyeTlXCAgCD9TKWqRg0ZKyHwJ
	 vyjNNJTUNCmpjzgDjoJQOVVln2HjXrR30q58JInbhXG82SqGwCTd6+sythDzTuNlFnGRv
	 hNq+PWZ2sHO4C66WPT/arX+0jGO3knqB+xeW0U6tfCP92cbGBO3OdgCpzXsFJOvmUbIch
	 exH/503afFqqDattVnmEkDYiPuEOMhXWLFw/tfP9DdD+VCtm7tW3Y4iq1QxnqSMDaAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GmrgpOMl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8610606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GmrgpOMl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FD61F008A4;
	Tue, 10 Nov 2026 21:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794344401;
	bh=lFcW3tBywnjHNYcpFJYQqkTqNU863ZEvHshKQCio2zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GmrgpOMlB09r9y2xsin1kcyxPvFIy2W0TCYNC0fApFg6eQ3VjCJENBh9ACQBcvMEf
	 CxFuBMI/ztVJNbXrkRHEXeU46i4n5iN14iaRYTjq6jDDRuhc7ZXNfr/YYTcnZo1Hef
	 UBPEO4/P5rr26EKbQfB66WpPVEHG1D7GGtTUZvstXzLCfGMwWNTa2N7hFCVxvenDbh
	 3emb8WeqecCo3TJTCdZkwUgCC7gDQXbPOWQHu7PoNwYB/TQ7CMvlxpErsZ9ZlM2JJ0
	 yMdPMCmZ/S5YfzJi8MuPXbvs5MosHXJozcr+03pru9CJXxKoDeR9WkBb53OnRPtaKC
	 n5EtysESUe5/A==
From: Sasha Levin <sashal@kernel.org>
To: lee@kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [STABLE v5.15-v5.10] tracing/histograms: Verify event_call identity when updating synth_event refcount
Date: Tue, 10 Nov 2026 15:59:25 -0500
Message-ID: <2026-11-10-1-daily-reply-0029-synth-event-5.15-5.10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109165648.3451454-1-lee@kernel.org>
References: <20261109165648.3451454-1-lee@kernel.org>
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

> tracing/histograms: Verify event_call identity when updating synth_event refcount

Queued for 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
