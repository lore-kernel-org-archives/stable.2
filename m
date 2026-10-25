Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792892800;
	b=KfiXWB77+I5djSQ/W4lXf93IByK5zaAEneQkyuRqvaDw6RE/H3nZ1C+Nh2MmD8nsIJm3
	 6a1bQmbdnn+bRgxmpyE23BqQzZM+0m2OaYdcHNnXAkIXKZ0SrFwJKmHZ5NtxD2N12Cs7x
	 MbEWIrle76E7e5CUOh+pVvG4ybaG8NDcBALoR5NwC6OAY43tFB/xTfBKMdsIa87LQYqp0
	 WzfjjyQSOeQ7POt36lGxCKYDcNZ3enAkHyXFkBd3kPU0b4Y0/MIKW4EQbiF1CHqu+TWFl
	 whzkX/9zSq6JnCTrp7KBipjrKtJZGe4zi9hy4UrY4/gtbbe2+bdh0ZdVcC5Q+9L/iUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792892800;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=pvDmB93L7p/VkAhfmd62Sy5Tcpn6HTAgeSbGeB9hiU2Es1/OiXPkW2DoVyzHmRLJIzN5
	 m10OLwEnQccSKy6lyuqUSpLJvnA+k+KqcrOOmKrVbnOTE7Iad+Q/gtzsfIprA0hYBYtcM
	 72c3BDgpHiby8zUwxCi8krjy278dn5suObymsyhQmzFrHEHl3QEYqG3uOCo6gMlpyofHR
	 FNe1rGarL6ypKMGU1fE85G7tSKOCCns3ZmBtdy/Umd/pxrQi5ztxwUF8t0cRJR++w/UBK
	 CpwKPXAfT43Q2OQWdxIDD+Jl/N4vWfCgY7McQT5yqE2uAYTa7Va8mrBcUYyOfE550rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OjjUoC6Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A94DC606A31B;
	Sun, 25 Oct 2026 01:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OjjUoC6Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D69031F01825;
	Sun, 25 Oct 2026 01:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792892799;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OjjUoC6YyTLXIppV0QRVrhEtRAoHhLqrYVw93S+2xkwv2iadXvf3bO41V7gZPpgbB
	 di9w/XUOiK35wAHkWPrHMGGyYwFSF/8HNk2PcrHFq8ekVme+YxoYmXpNSeHdKD6rcu
	 hdL68saBTDB51LGdblBvHAFNf+hu4Cws3nf4vCjEtx+BgnCv/o57On6feJbtFz8axm
	 wjCOjh2apuApYo0g5oPq9j6/X9YTHAWloa9nTEFKr36yT3ZZvLuoHcQNIbCX96XSab
	 sOjy5NIfO+A9VTOTfY5msTK8hgD6cKv/79OaffWex51DDWvwu2LJiNHo9ZKR8PoyPI
	 zLQMUYMzdMoEw==
From: netdev-bot+sinfo@kernel.org
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, dskr99@gmail.com,
 maheshb@google.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 yana06070@163.com
Subject: Re: [PATCH net] ipvlan: fix RX byte accounting for local traffic
Date: Sun, 25 Oct 2026 01:46:38 +0000
Message-ID: <179289279836.3327.9494173903555653580@kernel.org>
In-Reply-To: <20261025014251.542973-1-yanxia@cmss.chinamobile.com>
References: <20261025014251.542973-1-yanxia@cmss.chinamobile.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
