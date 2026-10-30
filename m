Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793353198;
	b=uDBZL1i+eMNMF5Lc6CT80MScVFA5W+XrChvRQpulHF0wlDNtdVKbPebOav7QEnuVKuvy
	 4bZf55fivzHLPxmkFUX+oOS7UEN+SO8FeHmyAnLMnCaY58sLYuq83+0HJ8io0QRmsjR/m
	 nGt6vND4ML9jo9gASxh4AGbWJ/9IyPubvL8FoOEjtG9KKAdYwW+IaLCJcTA149r0UZRGC
	 btYwT6GlurMrZQgYg7x8LLGLp+S1aQcqTtf1SDl/3jqHr3sUUfx+WJ5xm/9LvfPbOwblK
	 F3dFZY9iH9Y2QdJrvmZRjlZ11caUZldAst5b8T0XyKx6QHlQUtfBZ27UCCRutm0ficw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793353198;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 In-Reply-To:References:Auto-Submitted:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	b=D4xYHx8jWAY+dnuTyIkHSDvC0aHQHtBZqZg89EZfnzSeYqrHnGdeok8/7aomg6EgTfla
	 Ozj/RpwDaznxrC52nhI7n8I/CPsXHzwiiHwsOmZRMrzJkv0dNWKE3b+l7IJI8g9qx6TJV
	 MWaRpnOmSUSJGRPZ+IAedg0bFN4eg2vh5R0MBli1avd9i/gmdkqT2kIy73SB9gfsltE5w
	 Hk+aSXACmCKZee5M2Du5AYR90vwAvP4KBpnZZHpy0CH3YuaTeVdDbLlZLNLnze2pDNsqW
	 bzCROBCdEKPD8xhQZwuFy3S2BpdRv3/PNqTITKQbYuSptux80LjIR7SxbA2G+QWVDVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvUVTiyE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD26E606A320;
	Fri, 30 Oct 2026 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IvUVTiyE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 951331F000C1;
	Fri, 30 Oct 2026 09:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793353197;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IvUVTiyEbFwIpZg2rvZGoJZJ2Os2PoUxfCfLH9wdmVgGnmQPjXhT4L15PMNweU6dy
	 lYbT9gZFcFlikLv+zmqiVezJJQ2GTdqwf2aspaY8Alks4PLQBWxVN5EzRq+/vpXrxh
	 RxDEc/egL11QCh23UPacGyIBgKMbywmpZJbTCXltY0IDLVf8TyA9fgEiZexmA9amiE
	 DWMSFbID3WrUK80cpd9CnmDnzhmhT7Q9a/FV4CJSmg15x8MOpD8eCW+HnmFufKDLfB
	 pK+5/6ve1FZJrgyLcB26IgMSTnNKs0M3RIIqCHd9DXjxK9BIfzmi/0Id26gkzA7DXs
	 GzZznvqShADnA==
From: netdev-bot+sinfo@kernel.org
To: Yifan Zhang <yfzhang23@stu.pku.edu.cn>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, alex.aring@gmail.com,
 stefan@datenfreihafen.org, miquel.raynal@bootlin.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 zihanx@nebusec.ai, stable@vger.kernel.org
Subject: 
 Re: [PATCH net] mac802154: use pinned interface for beacon transmission
Date: Fri, 30 Oct 2026 09:39:56 +0000
Message-ID: <179335319608.3327.811462129554867448@kernel.org>
In-Reply-To: <179335297474.14852.9229658182764909973@stu.pku.edu.cn>
References: <179335297474.14852.9229658182764909973@stu.pku.edu.cn>
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
