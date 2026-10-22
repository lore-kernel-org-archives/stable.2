Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678048;
	b=qdtk9PFKrohbfTzh5njRlOw4WS7WEJQ5dVrqcd1JttJakMgvWSdAMEYn3gnXxKigbOw8
	 eOPaUmo8r1gp8FGrAQd8It/xJEq8GpCBLj6BvgCLS/VqYM8z5AwUV4XjEAvkz0zbH3f0Z
	 k6MEJbxPD8/y+fTe83wmC1qZXvpRGTWj6vNnQkTlHO7gityRlswl6pUy2gu1HEhzIHSWn
	 byf45mZlYKUiBC/0tbKNOq/jyzpM8iEdMxor0mVYKwLy8B0ddv+zEolxh0xKUS27LHimU
	 n1krT2wDDVfJFDBfFIEdPphPmD2nfuDyT64UCmBhcffyWCR8UpHZlj82AscmiithdKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678048;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=quxMtEE6GxlVCMkn5xRD+KqU3s0nR0lifLmxsFTqAp87z8FrYpzM1eNnQ4GR8WlC3joX
	 V/c+HG83xr8qsGrFqyE84fGVNjdY4P2puMhFD7KnkFFO5qEHhBv9dF9w30h2d3E8CdTdQ
	 bF1EV7bbW/YP9iRoeHGj5OpfL9onBWlhkjkryK7wcTbG9SirdGJeBK483a+0HdKSo5XXQ
	 Mdf2hAOBiXbYFZ4gPJ2a8UfHS/FGL/IFlnu//9BtaF6TfswNXDW1v4hbVArJe7BzprQV7
	 GrNldVwkVi+66DXOymsWZ744XKW75R0eTEMj7eoXz5dFxxZauUIyshvhrM5SAG465Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpQFeUY0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B391606A31D;
	Thu, 22 Oct 2026 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IpQFeUY0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528971F000C1;
	Thu, 22 Oct 2026 14:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792678047;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IpQFeUY0cXAt528pGVzP/wn6tBvLtTeYpzWaYGGk1VqcSu9usViffUDabmBW0yT/T
	 29oq7k8xIorBVKJ115Avpoef3o/x+uR2LinT9Y6eg0BdHG0WFlLpVntmDwP0fOtpKh
	 IGWyLdr/FA0qG2rXnPrLkTVOQlcJmYHz2gE84Kbfskdvtu8j7TeixO4qxNjdy4wwX2
	 txqcKp6elbXXc8BFt6D25psiNluhomybENSi9SPalUXg/WgIYBZKVEVD5gw2YZ6Ygh
	 RUbSigHzTSgOG4snodjyx3/O/YZRGOZpW0iW/nFTMg1JPZqvHWgDCobl1qNBeIw377
	 Oma48dhzAIxZA==
From: netdev-bot+sinfo@kernel.org
To: Yingjie Wang <1075151112@qq.com>
Cc: kuniyu@google.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] af_unix: order MSG_PEEK references against garbage collection
Date: Thu, 22 Oct 2026 14:07:26 +0000
Message-ID: <179267804679.3290.7400946684850477681@kernel.org>
In-Reply-To: <tencent_287A56749EA8448A970F2715FFF29F334108@qq.com>
References: <tencent_287A56749EA8448A970F2715FFF29F334108@qq.com>
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
