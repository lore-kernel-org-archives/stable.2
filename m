Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D063C6A56;
	Thu, 30 Jul 2026 20:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785443230; cv=none; b=jssDZ+93ya9RjeZLYjmTlNuyjoZ59nxWnuZ77Y9dq6VvZahXhJru6n36QpRUYbPIrKQFQJ3Ow+UZKcwgS8On4FxHBnw8oO8Ugo6BKCvduhyPcqsIoJs7SNRh+utJtmR3t6AoMp0UbaWifJ0ecLtpPPqE19oXdnYzla6MVGuNYIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785443230; c=relaxed/simple;
	bh=0M6OiyujQcSFWGAQZkpgjJ09w3VYQzS7bHqsglTXnKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oP2ssxVATouWr7MYlmQqmt9txnfG9u8onf3HcrWmxqYBXL5amM1Kqb4iYDQ0TgAZhiviwfWI9PzzYjeMRUF7DPDM0ndwEdsMZpef6td1BSQM32aA/juLZdvWFqrnx34e7v6qCOphaegFNF7DmD7E9Q3nInrCdoAwR0we0X0Mn1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgCYe1w6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgCYe1w6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D636C1F000E9;
	Thu, 30 Jul 2026 20:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785443226;
	bh=oaFgb7FcLIccJmyowpWmlw7aD0mw7q9LLhJkgC2z4gE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hgCYe1w6B1pD4kXOWvkfco2VdGK4jONQ7eG2f9OBgg+I5t6RjhyhkOOV3DmkaMOhg
	 TYw3yzslJqVjwJx0M2G0ly4oGzgfayT2JXzxvVBcI3e5zkUIzdNxjxzyP8P+b8/Rzr
	 e+3PfdX0dlBemQHAoxHE5ip3zbheXqlaIUZDiqGA3+4MEoBrKdIWa7n4TUH1YcToK9
	 /mSQTytf+ip73TZRiRkJ5yrdNayYi0mWG936vxg6klDtuHKMQPIOXHbHfhMuruRhmX
	 tU2Oc1J92sg1NSJhHRu/5Z4X8bIyro9D/114mqdbM6lOSkLE8/TQKEdyRlaCctN+vz
	 SqeFXAAkrpK1g==
Date: Thu, 30 Jul 2026 13:27:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Florian Westphal
 <fw@strlen.de>, Davide Caratti <dcaratti@redhat.com>, Christoph Paasch
 <cpaasch@openai.com>
Subject: Re: [PATCH net 1/5] mptcp: avoid combining some incoming suboptions
Message-ID: <20260730132705.58e65d98@kernel.org>
In-Reply-To: <c77bd843-725f-4d65-8750-87da6105a8d3@kernel.org>
References: <20260728-net-mptcp-misc-fixes-7-2-rc6-v1-0-f7e2d229159d@kernel.org>
	<20260728-net-mptcp-misc-fixes-7-2-rc6-v1-1-f7e2d229159d@kernel.org>
	<20260729172306.31deb67d@kernel.org>
	<c77bd843-725f-4d65-8750-87da6105a8d3@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 10:14:53 +0200 Matthieu Baerts wrote:
> On 30/07/2026 02:23, Jakub Kicinski wrote:
> > On Tue, 28 Jul 2026 19:11:57 +0200 Matthieu Baerts (NGI0) wrote:  
> >> Some MPTCP suboptions are mutually exclusive according to the RFC8684,
> >> but also because in different places, the code doesn't expect some
> >> combinations to be present. That's specially true for suboptions that
> >> would be present twice, but with different attributes.  
> > 
> > Looks like Clashiko has much to say about this patch.
> > Could you check?  
> 
> Sure, I will check that.
> 
> Do you think Clashiko could look at patches from the MPTCP ML as well?
> Because the (deprecated?) AI review tool we use didn't find anything:
> 
> https://netdev-ai.bots.linux.dev/ai-review.html?id=d1d1ff69-0f15-4812-ad16-e4f6f2df9f6b
> 
> Or maybe that's because the model is different, and this can be easily
> fixed? Or maybe the prompts are different too?
> 
> I'm asking, mainly because once patches have been accepted in our tree,
> it can be hard to have the original author fixing them. Not to block
> other patches too long, I often have to fix them, so I would prefer to
> get the same review tools (if possible) to prevent that :)

Sorry about that, I know it's annoying. Not the best time TBH.
I'm modifying our instances very actively, I don't want to have
to worry about the extra surface of integrations. Hopefully things
converge soon and we can switch you over and kill that old service
we had completely.
