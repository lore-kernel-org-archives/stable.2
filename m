Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793241611;
	b=0E4fmXbjGhEHm6sjaAvQr3AHTpACMzbm/1yUDVAXEAaav/nURkHclV+I641JMIJhSifu
	 HLUkvcO2ztXmCVSqNJ+ua8wW0CfvIIndKPrUGENL9medW64vUFV1s+6sbn10+F8grXKd7
	 CjbT6Y/xIuX/FRGYpBy5SSpJ6VvMhKjkd0wwJEapyvrkHQQ36r1Xgy5vo1GmHv7g/WPJz
	 qwBBn2/KjOTBpE8Xqn9D5l5k0UazPCMc3UZn7J4LCKIHNvqLxTMiNh4Y6fGN+vrX8RcEt
	 pn8luKqWic6uha31xjEt6z14yposWH3HknB4He4BhPiwIWxDKndFm0uWncR/xUyP5MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793241611;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	b=dWAG0SeKZk9tUcBT3R/HRLsJWFkHCnuaJE4wCNXFzSY81DK8rRS9ZOdrok2Q7A5f4se0
	 uYvKSi8BnLPHNt0gwg0HOwYB+oSZmZ579H45HiEfx2zSPQ8bxohN50pq0/rml/YnDvu9u
	 rkYE9mDpT0cXtGCrWiG7wxDC5Nr0B6sHu2Xs+EtYzPWSnXhULAX1UCiyLqnb/skVqwLVy
	 /lQKypvlzFgHOC7E6sdvzdaUh8sIHKzhTTm9sj13FvxPLjsY7lSxDrTBFive2MjqGbgEm
	 nH9OUMgxSajhtb5p5KddQUZf/zN1ozpkEzM9apIRTeN8I9Z/12Sh6yodIoOkLO/GA9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKY71QlJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5F606A31D;
	Thu, 29 Oct 2026 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKY71QlJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3B501F01829;
	Thu, 29 Oct 2026 02:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793241610;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iKY71QlJCJKB1ksFMA/aIdM5aNO1o4yN4e48wOAq5ytGViSaFxISC1CAc7t0IHBfo
	 pVc2KXmyH8QBdJ3D7mTxIYkubcTLnd5Xa2PVlWpszCqudDPUnSQ3YvX06TQ73UERsa
	 rC2tv00c5L0DseyFifGCR5uafdoi+MBYRkNnHJOeBsU6cPKFQBZcQerKGyT8LBGw/b
	 3qkiqzbhi6KpYel2CdbDaiR2Jkotiz8eNI3VCI1/DAlg47+yqLSUV2zsj5w/pzKqwB
	 8kj+Boxs9yKFmuWsiGlxdsnsBIeEVoCrgyyIIpcNhaPCGrb6PRj3+V4M5HVaa9aqqp
	 UZPDfzpBNTfEg==
From: netdev-bot+sinfo@kernel.org
To: bo cao <treebacker@foxmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: fix dead half of the MTU guard in
 __ip6_append_data()
Date: Thu, 29 Oct 2026 02:40:09 +0000
Message-ID: <179324160941.3327.14128311361745862229@kernel.org>
In-Reply-To: <tencent_D1F9D5069513D7D12F0FC2E55A32A9ED4C08@qq.com>
References: <tencent_D1F9D5069513D7D12F0FC2E55A32A9ED4C08@qq.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
