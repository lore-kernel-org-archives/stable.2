Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795104517;
	b=Wdmbi5CPCELNDAXKkOZnh2UY44XBGNQeKrHcEVJoXTlhOll1zX2laWFQ/muombFzgVQy
	 /K6N+NNQFyKIiRs/GzPGEM4GDC0cTpmT/JDUhLz6hwNl4fBbOGp0VdxMD/rf5uMSlASTi
	 q2ua2BpIHeUHrNYzMO+b8rAEHkKfJAseY9Xab4JA4I3WbzyI7Zh21mtw9/fVrU43LBj/l
	 qKsUEE5X63AUMHnzW2AyKYh/lNYCuX5vlbrdZ8hqABhvVug1Nj7rPCSZP/+lFnOXB5RFk
	 x/V/ctN5RHavckLGWdHsq24NvIpIxcJj7Q4AN1Zbra1VW2d/RTEMOeJ4JrWtQgz3qfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795104517;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=YGpkrtG0U4OoqMAB2Rys3huSMrs5r5rFJ8rRWTRRKE0=;
	b=FAF6CxgYE4YrkszIcopo0Q3PY4tn1WKYEdmNkxYmJ0UnFAK277fFfgcBrkdRI4IYKbF5
	 eYsYzGU61EFQ4T3Y505PB+J+FCvGQRK3gG9vRkz/RaxJpitVT8XxfuUn5IZ5b8RPFgI0k
	 rFSsILQX57z6TzUVBuptZELSeYyOg//qEk6Z38oy4e3KqWWB8W8OHAvT4R1sCsQ6u0z1Z
	 aaZKVzQf56akjla56tcq0y5GtCxBEuTRMKNRU4Xnb+B4O5nqurODqNbzLMJFBwUAd61ET
	 vHAvzp7HClMLwMnHC3sOkkm7gS5K4CaE5Fb0+dOQhAEu4AubW6w7Xy/j0vFCFwxPUtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeQ9szDe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E9E860A2601
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 16:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeQ9szDe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FB2E1F000C5;
	Thu, 19 Nov 2026 16:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795104517;
	bh=YGpkrtG0U4OoqMAB2Rys3huSMrs5r5rFJ8rRWTRRKE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EeQ9szDegkPyKaWh30MoQMOnYB6cTrBFew6jsNd/T9KtibfgTnIuqnbj8ZrxR3hyF
	 CDkW9yX3dD4bF7Y/6S75RFWenNj0y6mx2XBH68CPM8VQJ0DEycwwlfwJpmN4Se89gs
	 8tung6K+d0BP3iA2UUntuPXLv5DylH0WzTciGIA9DIDMcXZsQtEcBVEXTgwb/pgjqE
	 FVibtETHxyuKbydxi1IpSQk9SiNjtx92TT2Ku8RKpO+q9aLk+ityiwveOti2enRNCk
	 xdbPle/WEoA+xTZQS54pEB74jTA1Kn9T5gmsdsGMBOjpCyJ9G3vaacpLy6avyWqmbs
	 uO1/Wxl08Mq4w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Mark Bundschuh <mkbund@amazon.com>
Subject: Re: [PATCH 6.18.y 0/2] netfilter: nft_ct: move custom expectation support to helper
Date: Thu, 19 Nov 2026 11:08:05 -0500
Message-ID: <2026-11-19-1-daily-reply-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117232211.stolba-3679da4ad8be-linux-6.18.y-v1-0@amazon.com>
References: <20261117232211.stolba-3679da4ad8be-linux-6.18.y-v1-0@amazon.com>
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

> Also in this series:
>   - 6fb421bd07f1 ("netfilter: nft_ct: expectation timeouts are passed in
>     milliseconds") from v7.2-rc1 is included because it fixes the
>     timeout unit bug this branch has

Queued the series for 6.18, 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
