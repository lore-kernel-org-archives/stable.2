Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794597010;
	b=j3eroohSuYI/dx3YpDUKNjtPM21wlL++Q3/d4PLsaFB4s8Gvz+SiXsTWvOEXndk8g3Mk
	 FiQWO7ZdPQxaERdfOBSu0pHtB01w+/H5Bv1/xww+haV1YF+gS1FTZo90b8eT3qbTyj9jE
	 xu6DFWDpogr4bNDnXAIvlBTQKWTYGlDizV5VDJDgfEm1D37CjpJfPEeMi0QNZmybK71tc
	 jvOsR00EQq5pR8G8L66FPqa9zHmuH32KGqMzoyK5hitrc3xXM9tryWQdbhusTRokMztgo
	 iusoUn/gg06DzBRZQq7jy8FgOUaj9yNkfDUvSgjE6H1Uj1YX5lzlgcw0DzaFkJCJvzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794597010;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=94WpNmZhFznISqsAYi6/Y/F9BN7M8TOq7MthItorM7w=;
	b=0VXlXxxkShVC8GdWaf2e0Jj3zRfiAk+RXU8rkpXPPNTm97PZGBr1uyT59qfzqIt/Dlqq
	 /XKyTyc/Erksk1ysVyqv/s0CVYn8ZV2KEkOerysL/Gpxu8IYpU6W0Eq2NEjR8pRdk/pKV
	 M1m+RtAIyXBBPRCorvNOkXogiJyXd9JH/Y6dkWQsq/hLTHkfHcQeI2gGrKs1KppguvVd/
	 GVY+yoWfdYLs6cFODhDb1D+rJx+b+kGFWHGSCBvH/qtQQHDlI75/JB7jAmc1tBv8UOWDR
	 VW6NxqkGu0j2x7m3Lq/YZkshSrdQsq7OODKLgPcGhBm47IeR+lLWhV7mWXFxMyr7WKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g98274r7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46881606A89C;
	Fri, 13 Nov 2026 19:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g98274r7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2901F000C5;
	Fri, 13 Nov 2026 19:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794597009;
	bh=94WpNmZhFznISqsAYi6/Y/F9BN7M8TOq7MthItorM7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g98274r7Yp9Adu7HPkfAWm8XwZwgCelBnV70HtjCEQN7ZiS0Jyd3WOsxyaP56CqAc
	 fBV6HKH9+xV7Us5TADES50VW6p6NgkyyZoOvuHof4HPhBTucNcQ9ClIyQ00qqaJUI2
	 m7NRM09GL+NdGYRT66ZlXoAuU0vXpTA1e90XSyoAVZ3BMzJdO2eL4n37x1zE5JJRpF
	 z68TNgma6mK4cSd6TCpLdIkccGXU+fuFFqPeu0PVO8lwGQNjHhggg9V8G/WbGZ9S4/
	 sp4Wgbin4f8qV01w+GH08h3VAETabSSIbTtmT8riWo5mTZnMSv0RHPIS9o0ZiwGxiQ
	 OfQuSORjcrZ1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Kyle Zeng <kylebot@openai.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH 6.1.y] net/packet: check TX_RING fragments before memory accounting
Date: Fri, 13 Nov 2026 14:09:54 -0500
Message-ID: <draft-0004-redoebelpacket61@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112202319.1603433-1-doebel@amazon.de>
References: <20261112202319.1603433-1-doebel@amazon.de>
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

On Thu, Nov 12, 2026, Bjoern Doebel wrote:
> Subject: [PATCH 6.1.y] net/packet: check TX_RING fragments before memory accounting

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
