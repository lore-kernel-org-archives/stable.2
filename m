Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.210.214.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795146933;
	b=ELwDFFKH/b6wPgUWezqEXc3wxzlkfe3GRiNmL4T+TkI7cAXHTPzyvPW7xN6e5mTDtdQA
	 /s2hTmefA8T2gDjGOgj4ZfpjTQjNujvPM29Zrxip/U0mvFlPJP5mPh9W/Gc6RPuSWLf9B
	 2+5cdo0zJGcZbM25fY5xVPGpfY/XnwKhGAgokKr9SnfGbW3flr0UA3zHIlVBKBpfCLADf
	 vYPUirfB2yD2P5eOrOWIf9G7xqXQO6I6QjCWcb8ibM7bAB+YaTA+h6alKahgV7jdmuT76
	 LGi1KHwxYYSFoSc/hnLCk/d0XTksfumOOHPryuCfs+AbFqLh4FKbpazLrRWSNJqqThA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795146933;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Wmcb4dTMJFIsR3cB+IE3EGHuT+3Q3Ct6EhJsH00YYO4=;
	b=K2qkrM8crab8bLG21BFyMXI/5SkeO6FPLSGfCdpMOdn6bZyy5V9cObB5/jFNqQJ5Cv06
	 C6h/951JqF9qztlOeF0ZCRhccEGPIvgx3715nYe0h/wQY1fgjXgpave0c0HhRJyf5saS2
	 ZG9P7LHQRaQXXZQE4inTSOxkFUqIn+WLtfNSvP/9xb1xe9oxCiqO7m77zaIPEiRsUaDBr
	 badi34Y5KouijF1xOzGM1nurJrl71kUgkq4ql+WaAOHoDUDbN25in1bJzXk3NCHq59z9d
	 ER5k8uXw7jwhC7mGOVf4VHPrMCEZrcarz5ELtHFGN8fuLsAW19PpAZV6nSrzy99II+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=codewreck.org;
	spf=pass smtp.mailfrom=codewreck.org;
	dkim=pass header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=zR7qOTyT;
	arc=none smtp.remote-ip=62.210.214.84
Received: from submarine.notk.org (submarine.notk.org [62.210.214.84])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A851E606A320
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 03:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A851E606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.a=rsa-sha256 header.s=2 header.b=zR7qOTyT
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id ACC4114C2D6;
	Fri, 20 Nov 2026 04:55:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1795146922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Wmcb4dTMJFIsR3cB+IE3EGHuT+3Q3Ct6EhJsH00YYO4=;
	b=zR7qOTyT9luajpwgtLj2ZUzHQtw0UHTUOIs2yCvXGcUhCYB93vXne4Vu2lZuxACxdS4BZN
	K5nxVDH9V39RxbHIp4QoIGMbOl0g//izPSZgLYcC6QCQO2ZL0JQKdF9NYzTFs9Y4hpR9Pi
	aBg9dx+0hvnC8IRKdMcfcJBx58ZjkQmecOJ//ae0chUoRFO37TdJSTTE52NfUYQZddMvto
	lLPXPJ06UFR565k2o8AK2BvdVJzn2S4L/blun8SAwurOaApDD2WsA4g91sz7fvwv6gbcg0
	2NVZmygUHNvLmPejotYdbzd+wdVYGG76IxqxkRoXHEarty1uUqAac7FOykhNKw==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 2193485e;
	Fri, 20 Nov 2026 03:55:18 +0000 (UTC)
Date: Fri, 20 Nov 2026 12:55:03 +0900
From: Dominique Martinet <asmadeus@codewreck.org>
To: Sasha Levin <sashal@kernel.org>
Cc: Francesco Dolcini <francesco@dolcini.it>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org, patches@lists.linux.dev,
	Aristo Chen <aristo.chen@canonical.com>,
	Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 7.3 1238/2651] phy: freescale: fsl-samsung-hdmi:
 initialize default rate
Message-ID: <av_El2-tHN0DJRC5@codewreck.org>
References: <20261118150247.972732815@linuxfoundation.org>
 <20261118150332.571312313@linuxfoundation.org>
 <20261118223142.GA597634@francesco-nb>
 <20261120020908.2320910-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261120020908.2320910-1-sashal@kernel.org>

Sasha Levin wrote on Thu, Nov 19, 2026 at 09:08:58PM -0500:
> Dominique, the 6.12 NULL dereference you bisected is this same patch:
> 6.12 does not set cur_cfg before the clock is registered.

Yes!

Adding commit 41db46233467 ("phy: freescale: fsl-samsung-hdmi: Refactor
finding PHY settings") on top sets cur_cfg correctly and also fixes the
NULL deref, but I definitely agree with dropping patches at this point
(this cycle has been big enough!!), thank you for all the work!

-- 
Dominique Martinet | Asmadeus
