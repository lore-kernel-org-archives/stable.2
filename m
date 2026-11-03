Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702128;
	b=Cu8zs+6OvDMfl/Y2s4IeqIm+liE3GqsVM4L41wmyO5+dFdnCDVos9n88R3PnoJtTcFGZ
	 lDR+a5PgETix0CEeZfxHIKQa2oibrLzL0j2fYLwMmopTS3jdv9MWlvN691K1GFjFwWwGB
	 Be3+hYbajkgZgXy5vwczWi/zgMSuVKCCB65dctp9cRlN6mQzu2/YchBjtaIXfkSDVto/e
	 jiQXBqOd/CgxOV+ULaRnp/mInuY7YeTFek+URpApaX5NFff2gPKKdRm8Nf9FDABpdT65M
	 caDTYbYSTSsbf4c+/FvzVnOJr1fbtV+/vdiTGvJGqJ4eIYYLxvJ54syzsCYnIcvTLCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702128;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	b=TxNvuJwuW/SXSvoZoJNgkzU9iYSiR+YteO1sgYkY5Vgi0wFjheJ3pSd/6jrx4HTU08jE
	 YRwRGtFv3RxTI/y8XHY4BFWfglmubfz+ACg3+dxOIFTR7hcv9givpZ2pVAUvNzCN0EuO4
	 H73+fBBbjHIxDy5UM6K3RF5vKsBGrbIHE3hGSNpO5ACq3sfUJvEkQWa0Gz8beM5s0jFfK
	 GnVhapWeABlhG91p7VkYjhgz2izphVH8KdBwc7V6oh6EQ7Gzx6TGlA8hIbXKhdWgjYJ9W
	 rPT0OTOaVddBimQipgiN6+fS4KsfcY/SMqGpyFwaSczOe3HvG7BPZE7+F4ZPiEILkRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBftJEG8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE85606C57C;
	Tue,  3 Nov 2026 10:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBftJEG8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565831F000C1;
	Tue,  3 Nov 2026 10:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702127;
	bh=URC7r36kokGjXCV5G6Ei8oKV54JoMbconYpCKkPt2AY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gBftJEG8LZPcJYCNNArZIZpnLVB2E36eekFVNKTyzLxf7ESZYSHjytOIr7a9KRnuB
	 0LwKhKwzkEvsctdua9jatnHXNwFgQVxs5F5SEn9Za8ssO2UgEYw0tQKjlbsaYnUC8U
	 uGGfTTXPYzoF3E1T93nTLA0q6YhDUXU59Fn5qjIJgyWc0+78fYVYOR9iMqZxjxb31g
	 C618bIkSziDxHHVseneLb6axDi9B0jiYeb8AgTkM7Z98rs82vkofsdOBuZjwNBlXoD
	 vui1yTgGBSigKwqpbI1q923+wYb9hFgULBmDPUPpIEHLdEvCjGPVsnVvLsxWVK7IBM
	 nbRUpXkkjtDew==
From: netdev-bot+sinfo@kernel.org
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH] net: ethernet: ti: cpts: drop the refclk mux node reference
Date: Tue, 03 Nov 2026 10:35:26 +0000
Message-ID: <179370212692.488859.15181526059142533874@kernel.org>
In-Reply-To: <20261103102858.1340800-1-vulab@iscas.ac.cn>
References: <20261103102858.1340800-1-vulab@iscas.ac.cn>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

 - What hardware the change was tested on. For driver fixes please
   mention the device (and if relevant firmware version) used for
   testing, or say that the change was not tested on real hardware.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
