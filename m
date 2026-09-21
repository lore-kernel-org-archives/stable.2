Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6654AC156;
	Mon, 21 Sep 2026 15:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003416; cv=none; b=sMIfavJoa/YGNFvtvaMDW9uxrgsvSpw5j4AYv/3FlZan9OUpidJHroLlfMtEyASLMEkm/EZSl8YOdx21cMTXiThd/13b+aELzz0p0cxCAP3Q4gUfOvHYOcRQYH/7mBtxie9d19TSLTF+Fr3n2RjUd1Snv5AQSei1a9mKoGUW5lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003416; c=relaxed/simple;
	bh=5P2r+m8kOxivxZ/Nim2W/Zh1JnqOL5mQoSfThrcpGzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOUVQVIg7VZ8aF2xu6cuLza7zn+aAR1M6MtAy/ufIS85hzZUhT/5b8Zrolf/xa4LP80xuih2fzkP1SAP6XVCQ8MFLpctXoH4QDxesYxsUzs+/EKEaB4VfncI6Yr3CyCKhgvxDVifvVguU0KEt8XYSHoIObAw+quRI/K7PnPkdFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5MMX7Jk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5MMX7Jk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9220E1F000FF;
	Mon, 21 Sep 2026 15:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003415;
	bh=lmzIA7sdnSc0PUXAahAHGXSbEM3vgCD2ilM41a4Tj98=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=N5MMX7JkLTXG2cJ7BLjw0I00zZ0YmChrV+NfFGebyzJj+A+OWN2V3KmqUbPj9FWpt
	 CLKpwPIlGDBxO2ZKVIxCTkcx61ZRPIWibIMy1CK4BGLv0zgjmbhvgO7F6756Z5Gm6S
	 PtkIze/Zz5HIb2E7l+hJ8LKQuURV8l6/5+caERhI2RBoaVhExAKgcyCk7OYokc9Cad
	 fo7hGc9lrnwsmiwihqx54cVBQj8wK5DZ3hUP2wFJCMVSzbVjMd1QJuF3B3OfNwUFfy
	 zX0x389yo2uD7q//HvdP6naAx/qsjfVdr4juXorqbYeBEr6fTM3OHoVDUTdkP6IEja
	 jzfUuXASH8NMg==
Date: Mon, 21 Sep 2026 17:10:11 +0200
From: krzk@kernel.org
To: Hui Peng <benquike@gmail.com>
Cc: Paolo Abeni <pabeni@redhat.com>, 
	Matt Johnston <matt@codeconstruct.com.au>, Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Simon Horman <horms@kernel.org>, Jeremy Kerr <jk@codeconstruct.com.au>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] mctp: route: iterate socket tag list in
 mctp_lookup_prealloc_tag()
Message-ID: <arFI0qPXFTdV52yI@quoll>
References: <159f68ef9444f8b44a6d5764de8696f094fa889d.camel@codeconstruct.com.au>
 <20260921051002.1656692-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260921051002.1656692-1-benquike@gmail.com>


On Mon, 21 Sep 2026 05:10:01 +0000, Hui Peng wrote:
> When a socket transmits a packet with MCTP_TAG_PREALLOC set,
> mctp_lookup_prealloc_tag() iterates over the per-netns &mns->keys list
> and matches netid, req_tag, peer_addr, and manual_alloc, without
> checking whether tmp->sk == &msk->sk. This allows any MCTP socket in the
> same network namespace to use and consume another socket's preallocated
> tag.
> 
> Iterate the socket's own tag list (&msk->keys via sklist) instead of the
> namespace-wide &mns->keys list in mctp_lookup_prealloc_tag(), ensuring
> that only tags allocated by msk are matched.
> 
> Tested in QEMU against Linux 7.3.0-rc3 by allocating a manual tag
> (0x18) on socket A via SIOCMCTPALLOCTAG for peer EID 9 and sending a
> 4-byte message with MCTP_TAG_PREALLOC from socket B in the same network
> namespace. On the unfixed kernel, sendto(sock_b) using socket A's
> preallocated tag succeeds (ret = 4); with this patch applied,
> sendto(sock_b) fails with -ENOENT (errno = 2) while sendto(sock_a)
> succeeds (ret = 4).
> 
> Fixes: 63ed1aab3d40 ("mctp: Add SIOCMCTP{ALLOC,DROP}TAG ioctls for tag control")
> Suggested-by: Jeremy Kerr <jk@codeconstruct.com.au>
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Hui Peng <benquike@gmail.com>
> ---
> Changes in v2:
> - Iterate &msk->keys via sklist instead of walking &mns->keys and checking
>   tmp->sk != &msk->sk, as suggested by Jeremy Kerr.
> 
>  net/mctp/route.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 


You sent multiple independent patches, to multiple independent
subsystems. The amount of these patches clearly suggest this was
AI generated and most likely not tested.

More importantly, you sent all this work without properly organizing
relevant patches into patchsets. This makes reviewing difficult
and might cause multiple reviewers to address the same issue.
Replying to the entire set is impossible and requires handling each
patch independently, instead of applying or discarding the set.
Maintainers also won't see the bigger picture of your work. Quite
worrying.

This is on the verge of hostile patch: bomb us with so many
contributions, we won't be able to handle them in efficient manner,
like responding ONCE to ask you to slow down.  Considering all this
is untested and LLM generated, I have even more doubts whether this
should be considered for review.

Please read kernel documentation BEFORE posting more work. It will
explain you how to identify subsystems, how to organize your work per
subsystem, how to document usage of LLM and how what you should not
do if this was posted in a good faith.

Best regards,
Krzysztof



