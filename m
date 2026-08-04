Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E89F3F0AAC;
	Tue,  4 Aug 2026 02:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785810152; cv=none; b=KxCz8qHokjukdMB2r9ycp3GBoUbB04GwBV1zw6QqglzPaO+czaXAg/kSE2rMw5JIjtSG4bfZo5LmBQpK7mOKw4ShI54lkaunRGXmluJ9D/bsLpoB6dZ9UXmK/reABvnAUwwqzmjhmYUxm01EMGIaqMvZ/gBOewwRgh2vQ2l+xQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785810152; c=relaxed/simple;
	bh=fl9oXxfzPPmnFE31vFzRCofCL/zfY8JEsm5Unn7oDto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=crOxXWb41iNGJGGrZ1MtwMq06X4fDgLOgbsGyzg63nEWk0tdP21Fuj5s/NifLz29hn8/TeS7AeoQj+J9fk6aVqnivPCv/mB1MAbvFJuJsJjipyCTwDBiQxCJyKmx71GiGsN+w3RIiFHmrJ4myWFAIT3aWiW28wEeq27gi4/q7pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LLRtJ+3c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LLRtJ+3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 168E31F000E9;
	Tue,  4 Aug 2026 02:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785810150;
	bh=S9bPbX6RE0wDEHbA1Fij5VmW8M/Cn+8q3po/K2p3JBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LLRtJ+3cQNq9giqTf4o0R8Wkazzn+Y68wQLDS/Csgzir8atYUlW7RmBen7XPozlHm
	 U0wF3gERcPxtJ3kKGxBU/UF7kaUR2NOa2a79aQ2/IZ2Vwo+B6L1VPg1pM/lkMWkHcm
	 MHkCW8hQJ73DkqnFq+Zy9eIXdN5lYMoVWUbfowWtv+G/w+18VvX+mKwlApw8GcG9ZX
	 5c/C4QoqYoX6UpV/IwLTWfzgIvLP8Df6iOG+7kUFCPIk827pP8WOOgYig2NDTMb+UW
	 02PmvRq7pWp86yx2tdKip2pOoyd4UgwnGVCwFz6FkSjWGB2xnWUQYEe0b6BqFfcd2A
	 khfMe2vsZCLhQ==
Date: Mon, 3 Aug 2026 19:22:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Qihang <q.h.hack.winter@gmail.com>, netdev@vger.kernel.org,
 daniel.zahka@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v5 2/2] packet: use consistent hard_header_len in
 TX_RING send path
Message-ID: <20260803192228.49a49867@kernel.org>
In-Reply-To: <willemdebruijn.kernel.f39af6152c60@gmail.com>
References: <20260730082925.93759-1-q.h.hack.winter@gmail.com>
	<20260730082925.93759-3-q.h.hack.winter@gmail.com>
	<willemdebruijn.kernel.f39af6152c60@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 05:22:21 -0400 Willem de Bruijn wrote:
> Qihang wrote:
> > tpacket_snd() reads dev->hard_header_len independently for skb
> > allocation and header construction in tpacket_fill_skb(). Concurrent
> > netdevice reconfiguration can therefore make the reserved headroom
> > smaller than the amount later pushed, or make copylen - hard_header_len
> > negative.
> > 
> > Snapshot hard_header_len once before processing ring frames and use it
> > for the frame limit, headroom allocation, copy length, and skb
> > construction. Pass the snapshot to tpacket_fill_skb().
> > 
> > The separate SOCK_DGRAM consistency problem between hard_header_len and
> > header_ops->create is not addressed here.
> > 
> > Fixes: 69e3c75f4d54 ("net: TX_RING and packet mmap")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Qihang <q.h.hack.winter@gmail.com>  
> 
> Reviewed-by: Willem de Bruijn <willemb@google.com>

Willem, does the *shiko feedback look like false positives?
Both instances seem to provide different feedback, if I'm reading my own
tea leaves right Claude discarded the Gemini feedback about a panic
as a hallucination..

https://sashiko.dev/#/patchset/20260730082925.93759-2-q.h.hack.winter@gmail.com

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260730082925.93759-2-q.h.hack.winter@gmail.com
