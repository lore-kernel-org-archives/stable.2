Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF7457268A;
	Thu, 15 Oct 2026 19:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792092993; cv=none; b=ltIpQ0P0oCzppzN2QZiVnFJnJBi9M5vkPOedeG1UXP6FfGxQgnKDFPEtaDTPQ5aeL7uipc+Fyk8HeR7ppgO+COpUN4dKairV2JNX2nZ3h4/jJ/xXB9/+FT0a7q6E+0dMQUtrSZLT6Thfq+TXwkevFd8wrbD3/kzQXSuYmQIyDtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792092993; c=relaxed/simple;
	bh=xQkZ6wL5DX7K36xURIvtokpviq0OfwPjz4UDjX8Y+e8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TH2LP98sbN3Z3XtqVYKakIRvffWm8aEyBIPhhAbthXLoElmc8jxz3wZ/rPLZwwrGrEjUYT13wLq8gegdNpaYeiGBnrULLtxXcCZPWAAgP6cf/DxNKnKbx59/HLGW3lWRg0T5u1xhwLfndmzpU6iTKOHqzkCfzGUT2kUEIGXAYlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RX4B8ZRf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RX4B8ZRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F42061F000C6;
	Thu, 15 Oct 2026 19:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792092992;
	bh=by0e8225MtbYPCIfUN2aK7pgEEw3Huf7EZzUdrjurvI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RX4B8ZRfwypPtbyz49a9EvZErLzpTu5qz6sPTO5BBUgooAZqRmnHwFqwJh+empOg2
	 cSfMJtaV/F/qnBXo3p5D1ehiPPNbz61V1KUE4NBiJuLKkJvCf1Waa8dLqDnCwtriPd
	 kNJw/f0h+SV2PkRNFB1St+JGACOcjEUZCzG5BM6y0/HTZ+dF21W6HXFn02e2VGpC4J
	 2FuykPc6dm1BEE6RgE0IfP/t1nMRdu3Nq4tfLdE0g4fe1oPrGT4Zh3P19XYpGBXzgV
	 3IAvp9nKy2rROm3vWd+NEGB4ubI2m0lXcIP4NzFmVJwNW4igjsMpAGBqPJElk7Pa5J
	 uTfd1I9C8P1ew==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	raminwo0202@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	apais@linux.microsoft.com,
	Tahera Fahimi <taherafahimi@linux.microsoft.com>
Subject: Re: [PATCH 6.1.y] xfrm: prevent policy_hthresh.work from racing with netns teardown
Date: Thu, 15 Oct 2026 15:35:52 -0400
Message-ID: <2026-10-15-1-daily-reply-0009-xfrm-policy-hthresh-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014212540.1437936-1-taherafahimi@linux.microsoft.com>
References: <20261014212540.1437936-1-taherafahimi@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> An XFRM_MSG_NEWSPDINFO request can queue the per-net work item
> policy_hthresh.work onto the system workqueue. xfrm_hash_rebuild()
> retrieves the enclosing struct net from the work item, so the callback

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
