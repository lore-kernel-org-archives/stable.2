Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42002931FB;
	Thu, 24 Sep 2026 01:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790213700; cv=none; b=oCxbR5Do5qmVSQBqLWMkbUyAc4Ef0JJ5LirlcnZ8OBLOHRXktT2l65fXBWYzwbcsOWUCNjqdxnbBm+9QWZchfbAjWAf+oSAlNilXTgiz8MO0YHjozs9KSXg7Kos1fhL0eQbKw/XDoGEbT3+T6ZIE7KYkKozHS1MGG0Bkzhl5lYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790213700; c=relaxed/simple;
	bh=dvI0aEy8BBevho3a70jrtwAvMdULSLP/KVrcnWlSX0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Tj5AdaftOyweHOKkKxKRe912Gtn7c/kaS5+YyZxuViBErfUqiFybs/GhkVczC1Jk5gENO++anP85HLkdY4Ily1SCTlGHlJkf+b/Mcea6otYPftMKEMkrUQZ7Tx3qTjdiie5oib+wJs13LpeLEpAjvdTQT2wMTIQ2r40PGPGkuJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B+7cYCsd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B+7cYCsd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F23C81F000FF;
	Thu, 24 Sep 2026 01:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790213699;
	bh=dvI0aEy8BBevho3a70jrtwAvMdULSLP/KVrcnWlSX0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B+7cYCsdhQtrFmAp1vRwiKaRg/V4HwZUI6YmUUxYiPddMjrkamL1/6gawx4WzOlGA
	 jxLwwTngkjRiU/RERIRpcuuH+bwDXT4/G3qT9RzYZTxw2g/zdiuxaXO4op9w52odAH
	 uu9nD40GR6OE0lDKdlp/n5KilT4XLfdGl5nUYtGmwEH0gYO6YbGCFO+qcINP+zeRIL
	 /XiGX1FTcALpj91ev+QApR1xfOThf0qlI4y9fBPaTvBskbnveG4HXp9EjjSQnY3ULG
	 aDPogneOGcdCBkMaYzJT0lM2+olGlt6Pi/b0Q8GjLv/wt1Ap5T00dCoC3VSsV6EUpA
	 Ubqj3QVilTLoQ==
Date: Wed, 23 Sep 2026 18:34:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Hui Peng <benquike@gmail.com>
Cc: Andrea Mayer <andrea.mayer@uniroma2.it>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Hangbin Liu <hangbin.liu@linux.dev>, Simon Horman
 <horms@kernel.org>, David Lebrun <david.lebrun@uclouvain.be>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH net v2] ipv6: sr: enforce exact attribute length for
 SEG6_ATTR_DST
Message-ID: <20260923183458.67595d91@kernel.org>
In-Reply-To: <20260921044025.1535982-1-benquike@gmail.com>
References: <aq-E5MPYZS5s9_bk@fedora>
	<20260921044025.1535982-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 21 Sep 2026 04:40:25 +0000 Hui Peng wrote:
> Subject: [PATCH net v2] ipv6: sr: enforce exact attribute length for SEG6_ATTR_DST

Do not send patches in replies to existing threads.
