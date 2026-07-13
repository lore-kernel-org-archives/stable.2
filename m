Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657463DEAD6;
	Mon, 13 Jul 2026 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783956575; cv=none; b=VjYBWTRaMD9b8hKBfJsQKlD4Y3ijposIeGHv6dB1RH3hr+soq2sHOv5/2GcLUy8nWymrmybBacUeXG1Bn1Q6clA4tHsgmoOo+dEuRYOlctpy9TaBswUBmH4Z/7GoYLAo5KdKLYt+vmuxXxR5RLfeYs1SsCJg8UaRB2T+twor948=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783956575; c=relaxed/simple;
	bh=Bd4OsiFy6bzKGVEVj5v4aVQ6e6rkFrz9UPR2KdOK9NE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OSuclQQbVP8grGh0pRfAP53zO4oPRrEyLkMlusZ++HEr+0DKQ5fHZb1DrcNlgNkj/BkS0alj7o4I4R4XPjlxP0GqpPXrJrc5kcjGQeE0qokPoCEyXVW3Nb9AVNSkHJCHs/s9yXMUEQYweLFm3R+h9BicauitUAs7BqMobTkHgpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNqZ2P1p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNqZ2P1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C1C01F000E9;
	Mon, 13 Jul 2026 15:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783956572;
	bh=j1IpE1z1peYrAdiAg2ejI0h0lw+0MANfTVFBjpwiuwM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BNqZ2P1pUF9e+8V9nO41EGnr/KQaS+ZjVTGAnMFRYcjaj1m+XA67DnADU9p6MLLyz
	 M2YUvQ2d4vabmU/kPdacznHUkRjUCJwWILXJKpgyWNkhUpskW+8vxWPJpQUa9aAGxU
	 D5khQwGnMpegrtWrS5YWUF3I7SaqZP1xzTFe/4ITlDShSZz5tMT3qkQGjpNhD9/wLh
	 rC81kQIP0kTxLWqLkSSf245+ehXPkwlSq0WOnBkIYVdyy9WA7+hyH0zlR3lpduhfSS
	 BacOj+HqUOxcWnYRyP37FZ3wXTknbv7SDBjOqphr8E3lii7lGrW3NCoM7dgD0jFvB2
	 G6Ed0Y0KpHTDQ==
Date: Mon, 13 Jul 2026 16:29:27 +0100
From: Simon Horman <horms@kernel.org>
To: Abdun Nihaal <nihaal@cse.iitm.ac.in>
Cc: skalluru@marvell.com, manishc@marvell.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, maciej.fijalkowski@intel.com,
	stable@vger.kernel.org, Sashiko AI Review <sashiko-bot@kernel.org>
Subject: Re: [PATCH v2 net] bnx2x: fix null pointer dereference in
 bnx2x_free_mem_bp()
Message-ID: <20260713152927.GH1364329@horms.kernel.org>
References: <20260707054618.932108-1-nihaal@cse.iitm.ac.in>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707054618.932108-1-nihaal@cse.iitm.ac.in>

On Tue, Jul 07, 2026 at 11:16:16AM +0530, Abdun Nihaal wrote:
> In one of the error path in bnx2x_alloc_mem_bp(), bnx2x_free_mem_bp()
> may be called with bp->fp uninitialized. And so, there could be a null
> pointer dereference in bnx2x_free_mem_bp(). Fix that by initializing the
> fp_array_size after the bp->fp pointer is correctly initialized.
> 
> Fixes: c3146eb676e7 ("bnx2x: Correct memory preparation and release")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Abdun Nihaal <nihaal@cse.iitm.ac.in>
> ---
> Compile tested only.
> Thanks to Simon Horman for pointing out the Sashiko review.
> 
> v1->v2:
> - Add the correct Reported-by tag for Sashiko as suggested by Maciej
>   Fijalkowski. Also added Maciej's Reviewed-by tag.
> - Simplify the fix by initializing the fp_array_size later, as suggested
>   by Paolo Abeni.
> 
> Link to v1: https://patchwork.kernel.org/project/netdevbpf/patch/20260701065030.381836-1-nihaal@cse.iitm.ac.in/

Reviewed-by: Simon Horman <horms@kernel.org>

