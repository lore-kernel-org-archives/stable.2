Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBF6D1E515;
	Tue, 28 Jul 2026 00:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785196990; cv=none; b=g4We0Z02jIK12aAn9GHgdpectS84nBYgpzUvk7CNt3tg/KPUqTmg1/Z/UOUTbFboe5QKexrHENy8FEgDzv8o9nCYIFZjFevoGQ53LyMt8cKpnN74Z/IJUh4Bp9PW9uAo6rm2ZiPxkm5zRYAlLPX3nCeVgM9ttId8WcLR/LL0hs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785196990; c=relaxed/simple;
	bh=e5FPB6lO9CXcoBZyNCq5bhDA7+ZhbwIocnnxZxqFAK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tGGvYGZTgrUk3X6g1oUcHA+ZhUvu5YcVGcNaeOHOTDDqJeGwD+o471sXFLNMYsVSfWrTd9ds1bXm7G409jTJ0BGVQoX5/+cpOsNjNeWFBT6SM2Nfa3sjiJREqzfEMivHHsTueGhTUIzD35NC0yBYHQ+an1hRIfKgh/yJbX1bw8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G08Rw17e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G08Rw17e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CCFE1F000E9;
	Tue, 28 Jul 2026 00:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785196989;
	bh=DR3dsXcr6Hegsm3zHTAPVtcPp1GsgiAyCtmDZf0/fJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G08Rw17eq0QhpT+lYlQUH+G+Ee0wkqCQYrYuhgZ1PKYTOtKpqofQbpyzcLXpN/2F5
	 krdSFem5gDzV+kak3D8fRtZzBxvrKugBcD2xFEebtvzyEDW7vzKdOe3vvnoj1Ho3Z+
	 c9Qqd/cwl0uqP/B6HmRZjjutqXttST35WiGb3ZKcD7yv2EJN6Rmnb0oY1l4+bT3B+S
	 uzmNW/kaWOZuEjq6ZaRJnijSPO7AXohjliP1ZX5+RdeuVaMYt9pPPqezCErIfBz9xz
	 osJW7GS18N+sWQbI2DUMBtJdvajvyOQwOPvU6GDx+ef8QYzuXWcNvj8tFf1jNH6TkU
	 Whz+sf3ioADqA==
Date: Mon, 27 Jul 2026 17:03:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Vaibhav Nagare <nagarevaibhav@gmail.com>
Cc: horms@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, matvey.kovalev@ispras.ru,
 Pavel.Zhigulin@kaspersky.com, aelior@marvell.com, manishc@marvell.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Vaibhav Nagare <vnagare@redhat.com>
Subject: Re: [PATCH net v2] qede: Fix NULL pointer dereference in TPA
 fragment processing
Message-ID: <20260727170308.5199f377@kernel.org>
In-Reply-To: <20260724140044.1055918-1-vnagare@redhat.com>
References: <20260716084746.212045-1-horms@kernel.org>
	<20260724140044.1055918-1-vnagare@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Please don't post in reply to previous posting, and...

On Fri, 24 Jul 2026 19:30:44 +0530 Vaibhav Nagare wrote:
> Fix by:
> 1. Adding NULL page validation in qede_fill_frag_skb() before dereferencing
> 2. Checking error state EARLY in qede_tpa_end() before processing fragments
> 3. Checking error state in qede_tpa_cont() to skip fragment processing
> 
> This allows the system to survive memory pressure by dropping packets
> instead of crashing.
> 
> Fixes: 55482edc25f0 ("qede: Add slowpath/fastpath support and enable hardware GRO")
> Cc: stable@vger.kernel.org
> 

.. remove this empty line ..

> Signed-off-by: Vaibhav Nagare <vnagare@redhat.com>
> 

.. and the --- separator should be added here, before the change long.

>   v2: Addressed AI review feedback from Simon Horman:
>     - Added net_ratelimit() to prevent printk storm in NAPI fast path
>     - Fixed NULL buffer recycling: check if page is valid before recycling,
>       otherwise just consume the BD to prevent NULL from re-entering the ring
>     - Added proper cleanup in qede_tpa_end() before early exit to prevent
>       memory leaks and ring desynchronization (DMA unmap + BD recycling)
> 
>   v1: https://lore.kernel.org/netdev/20260709044704.141507-1-vnagare@redhat.com/

I sent out the latest AI complaints. 
