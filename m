Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B29F429CEE;
	Tue,  6 Oct 2026 21:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791322592; cv=none; b=p72dpB7U4XaujZpF0j9pp/sDSZqCVaP+XJtWQR4ImYGcgDqbhkmzH8sAE6kRi6BjeSUAFV2WC7fcLd8r6YIwq5HiHx9OKNpvzlIOyMWPsu3aX7uyupE9WD9zkmAZUjYWk18LWghHt46VYRvv9Srlx053HUzCnSc3U8WRhwXvapo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791322592; c=relaxed/simple;
	bh=5mxINJmrCBCXVW2eWG0uxDmhymwst9X1mXtgC2tUQZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qY/CUbv3NBVLWH3ygXHCjCaBWL8EbZRlhg95sEmG8izwFI3dJhrhbFIm6OHGDigLUsY9OhQEuPISIDbB69t4XGoRhjV5LggFlOOuHWnv+I6XXSYvxCa1yRvb7C9H569qWOgzyYMy2wIkEa5/n5fYkXbRGNBtNBYfqMqKTU3jjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=arI3Gj2E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="arI3Gj2E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAF6F1F0089B;
	Tue,  6 Oct 2026 21:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791322591;
	bh=mdB53c/+D6/yTK1/16yZm0+J5jSaDZuMgTOPNLmZEEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=arI3Gj2E0J/rPJqDphuMvpCCwjyS+xLkD0SsM2QqZkMh7CTOEY/tr7TgNQKjAl+bR
	 L+/Yp3G/i1K7Iaheg/0hNNTOPqU3o/qii2N2du2R5xP7Z3C0DbISRE/oMxL5E1c3n8
	 NLugaMG5lXjsi6ot7avnn4+RaWPFcZv22mStOUIKRNdwBiyDoHXwRtV2ycpU/0kvf9
	 Yf+SoEATvKZr/ULs7GQi5EJ3wZSM63CvZTgqRZ2qi2UtA6mW3eNJmiXQx3zwI0pD5u
	 i6+IeZPUo/zE6VpZzpWZgVLpK01wxLTmELofmkPfTpe89jt+rhLUD7xn5sihi1xVGn
	 1tZa0gFONZjdA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	MPTCP Upstream <mptcp@lists.linux.dev>,
	Paolo Abeni <pabeni@redhat.com>,
	"Matthieu Baerts (NGI0)" <matttbe@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y] mptcp: prevent race between disconnect() and rtx
Date: Tue,  6 Oct 2026 17:35:45 -0400
Message-ID: <2026-10-06-1-daily-reply-0013-mptcp-disconnect-rtx-6.12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005175226.3607979-2-matttbe@kernel.org>
References: <20261005175226.3607979-2-matttbe@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [ No conflicts, but reset msk->timer_ival to TCP_RTO_MIN: in this kernel
>   version, icsk->icsk_rto_min is not initialised, because this version

Queued for 6.12, thanks.

-- 
Thanks,
Sasha
