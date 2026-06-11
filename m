Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867673AA4EF;
	Thu, 11 Jun 2026 15:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781192651; cv=none; b=gVdppmIn3sTOpGDJjw5lyIhCnTM1SeSu7FRy6SrClBZQSa7RR11GkH7kb4itkJIvssAnSXRB5r94UtdAoO4SfK7APXOO2B6YRkqH0DXNwFa7ZkmsQPPmJwQaiLNHecxYX6PGRwvK2xmGVx84tOEPSexTq+5N1x/e//C7p3NTqF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781192651; c=relaxed/simple;
	bh=h4jvRN4E19dkpQ5yFK5n2JakFhO2aBg/U/ArfFskC4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FDid4+Le9lJ3b6CFU3o/y1YSiG0/0beJTnF4FEXuYdJ7XOSyi8VT1Ax37H3eBYJI7mwYFzEZO92V04WAB2dd/ThTEwSniHFjoixhoApEddZW4fbTIOVAHCyCwAml/QWrMJcZCNYrAGVcWtQFL+mQTeeLVtDO2XxnYArGENsTDZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YaY7LoFa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YaY7LoFa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D871F1F00893;
	Thu, 11 Jun 2026 15:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781192650;
	bh=pmsBVymF0RW9AqgzB2dQja46aWO5BZy9eGdHvQpD6ek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YaY7LoFaeAUVz9gq9ORvzSAqAeLeuR/CxFTi6xjrHFXmJbXd3lydvX41hXg1wR22o
	 isLmPS/+YZA+NapMuA/f5wryeKj82fKhibKJJydc18pUa5xPRkJxENudaoQxX1lGWh
	 dWWf8wqsrvbtBakrfVvbphsuWEpLzxm8stkQ+IretBeNylcXMUvr+6Enbo8WLnm9ql
	 IMNPtiEcpMJ4moID7tLnWgMsgfeeH3nglCbIOBgXPzCllWOoc8XAwVD47e7c5FMVQy
	 lIFgOUwraZYeNutL3iQ9LGosIqvBVpNBm8U0TH9ejug6YIcf4aG/LnXMknoitgcWk/
	 BNWJbVjB4rgdg==
Date: Thu, 11 Jun 2026 11:44:08 -0400
From: Sasha Levin <sashal@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Simon Liebold <lieboldsimonpaul@gmail.com>
Cc: Qi Tang <tpluszz77@gmail.com>, Florian Westphal <fw@strlen.de>,
	Simon Liebold <simonlie@amazon.de>
Subject: Re: [PATCH 6.12.y v2] xfrm: hold dev ref until after
 transport_finish NF_HOOK
Message-ID: <airXyC2CaS0kO84h@laps>
References: <20260611121127.3908131-1-simonlie@amazon.de>
 <20260611-stable-reply-0102@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260611-stable-reply-0102@kernel.org>

On Thu, Jun 11, 2026 at 11:26:20AM -0400, Sasha Levin wrote:
>On Thu, Jun 11, 2026 at 12:11:27PM +0000, Simon Liebold wrote:
>> [ Upstream commit 1c428b03840094410c5fb6a5db30640486bbbfcb ]
>>
>> After async crypto completes, xfrm_input_resume() calls dev_put()
>> immediately on re-entry before the skb reaches transport_finish.
>
>Queued for 6.12, thanks.

Ugh... Looking at it again, I've dropped it.

The problem is the assumption that "the dev_put in the encap_type == -1
async-resumption block does not exist" in 6.12.y. It's true there is no dev_put
inside the 'if (encap_type == -1)' block, but that is only because the early
drop lives somewhere else here: it's the dev_put right at the 'resume:' label.

Look at where 'resume:' sits relative to the per-iteration dev_put:

   mainline (post-fix):              6.12.y:
         dev_hold(skb->dev);               dev_hold(skb->dev);
         nexthdr = ...input(x, skb);       nexthdr = ...input(x, skb);
         if (nexthdr == -EINPROGRESS) {    if (nexthdr == -EINPROGRESS)
                 if (async)                        return 0;
                         dev_put(...);     resume:
                 return 0;                         dev_put(skb->dev);   <-- early drop
         }
         dev_put(skb->dev);
   resume:                                 [async re-entry does goto resume,
         ...                                so this dev_put runs immediately]

In mainline the fix works because 'resume:' is *after* the per-iteration
dev_put, so when xfrm_input_resume() re-enters and does 'goto resume', the
async ref taken at the loop-top dev_hold is *not* dropped - it is held
continuously until after the NF_HOOK (plus the inline 'if (async) dev_put()' it
adds at the decaps/gro/drop/secondary-EINPROGRESS exits).

In 6.12.y 'resume:' is *before* that dev_put, so the async 'goto resume' hits
'dev_put(skb->dev)' straight away and drops the ref at the very start of resume
processing. The fresh 'dev_hold(skb->dev)' added before transport_finish does
not save it:

   - between the early dev_put and the re-hold, skb->dev is held by no
     xfrm reference at all - the exact window device teardown can race; and
   - 'dev_hold(skb->dev)' itself dereferences skb->dev to bump the
     refcount, so if the device was already freed in that window the
     re-hold is itself a use-after-free.

So this is a lifetime bug, not a refcount-balance bug: every hold still has a
matching put, but the reference no longer covers the critical window.

-- 
Thanks,
Sasha
