Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52173D9DCC;
	Thu, 15 Oct 2026 17:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792084037; cv=none; b=Mz2tf1Xla8P76zzu6YykkGp7Sx82rTG3y1r08tEhyFKxCxEo8OH8nau6gwefVRxNqdU4uyS4ec3JameJgUdJQOqeYU3zixKWZyCwo76SK3sj9jhyvwvv0fKQJgkHztMXM64PeL/vDw8y1bMBZONcFBPq1Jl+Qb8aD0+i1McOCho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792084037; c=relaxed/simple;
	bh=knm5sTGCsL01TnJ4ZhNaEWkpxU4c/0Sr70AV9htyH1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dViOQS4E40563W9Pgei7nU1Muhxc3boAIIyICtEV5VePcfb5o/ipfMC+I526Ir4lFq7oCe1mKzjEjIb9BxmnWKwERP7N8sVzvB9R89RfV+dFfcYBqET9R/BiK2nbROqxQHSmZIc7z+ZsCqq0SLqg4f29q4kYHj6yuKapcxFmGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGdB/70J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGdB/70J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08EE51F000C4;
	Thu, 15 Oct 2026 17:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792084027;
	bh=VWkfSRkT/w+lVOCbl0O97VWBKRGnrtBmH8DzMAgCTEg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fGdB/70JJ8gmWqUnw6NDgZZ0goLzwn+lUJEbTuIRQbKApZ3NQMoGeOiGaqEMwookG
	 sEV3RBeT7uhuIPufi6BCW074FrQKPCFa/KBM/uWgpW3eAXy2ZYNROEqxOR8cIdxqB2
	 95yjEP57Ppofbe+skjxT0bYMkBjt5W1FvDOWeE9wpMA9KaTug0T0cGvfFino6k4hS5
	 hBr/4KzMyTH3JpbZf63/6IwRXxzyP2hMXrVdQo2gdjUqpwxJY8c9E5OHut6/5qD2dS
	 ZhbXr6WDezUHCz3Y0MTxYRG4i4ALxkVof/YGLk3M4eZgQP+Upx3MhmYOLxBfpTgvy6
	 801XU3qsxQZWA==
Date: Thu, 15 Oct 2026 10:07:06 -0700
From: Kees Cook <kees@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Jiri Pirko <jiri@resnulli.us>,
	Brad Spengler <spender@grsecurity.net>,
	PaX Team <pageexec@gmail.com>, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-hardening@vger.kernel.org,
	Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>,
	stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next net] netdev: Hide the netdev_priv() origin from
 GCC in netdev_from_priv()
Message-ID: <202610151006.E2F587A60@keescook>
References: <20261015165959.i.798-kees@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015165959.i.798-kees@kernel.org>

geh, for the subject "net" and "net-next" glitch: I've poked my 
subject-building tooling again, this should be for "net", not
"net-next"... 

-- 
Kees Cook
