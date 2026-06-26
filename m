Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBCB3FCB3A;
	Fri, 26 Jun 2026 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782491862; cv=none; b=EVLyAI+UmP2x14GhDxWwkXZZGy9hqAVhrkkFZw2eLljLDiAFiJwEeX6YGz0eTstbNEVfLh8mWhD61JcE43GmODkCbi7jJiPkbRN3MEws5HydfmkyVBpjf6n0/iQ2ry69ke11GK/JlBCLYiescWOt33Cb+1o6fMwt43H/0qWBP+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782491862; c=relaxed/simple;
	bh=lMuRHAfMuqNzny9sJY10zguaZtTrsML5NLnJR3unQpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTqyPtDVTFAdLLkfVU0hOO0bLaNWf+XjhvjVxQqtcrdBV6+dLb82rZuMxiOb9ccMK7cnkgmmQV/ml+/e/lh1H4EfQexS+KEqID1Wx5ix7HiVrsdaKubkdN4QcHHFD/iX3iBDQd0C08ECpPMDsjDwsgvILrmFvkQVAaEKAxHhQIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lCLfL4/0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lCLfL4/0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4781F000E9;
	Fri, 26 Jun 2026 16:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782491860;
	bh=25YMHu8BkwQq3mf5EDMj4sWLLgI4tXtIXIuJSB0ZS+c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lCLfL4/0rdTnXbCNVgvdlofIAhZnYNaJIroJwYdrng/hpzA8iQcwge5Es1y+yqq3s
	 x3uNKxSptkheRPAcb/EBs7lODYXf3JVCa7yi2jZUjs2sgnipB4vqKULy6TRgzqSnd+
	 wWU0iRcykU3nXB+HzDJMGJ6/xObGnmZLDoos8eKP2IfFKQql3xKphgFdF2XVvxeqcU
	 gfsv6y7PJoTbFlFOLrnL0yjW6WEWzNzmGvZDrzZf/2IPqIu1fqLaHRU6jbUy0WJeix
	 b1qzXFYUeIvyxbFcr3+96veMX78TxcqW6nFK19ru8D5iHJIZHJJbStFq/9m8Jq5IZi
	 ms6wzfAtlasDA==
Date: Fri, 26 Jun 2026 17:37:35 +0100
From: Simon Horman <horms@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: wwan: iosm: bound device offsets in the MUX
 downlink decoder
Message-ID: <20260626163735.GF1310988@horms.kernel.org>
References: <178236824878.3259367.5389624724479864947@maoyixie.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178236824878.3259367.5389624724479864947@maoyixie.com>

On Thu, Jun 25, 2026 at 02:17:28PM +0800, Maoyi Xie wrote:
> mux_dl_adb_decode() walks a chain of aggregated datagram tables using
> offsets and lengths taken from the modem. first_table_index,
> next_table_index, table_length, datagram_index and datagram_length are
> all device supplied le values. Only first_table_index was checked, and
> only for being non zero. The decoder then formed adth = block +
> adth_index and read the table header and the datagram entries with no
> bound against the received skb. A modem that reports an index or a
> length past the downlink buffer makes the decoder read out of bounds.
> 
> The buffer is IPC_MEM_MAX_DL_MUX_LITE_BUF_SIZE and skb->len is at most
> that, so skb->len is the real limit, but none of these in band offsets
> were checked against it.
> 
> The table chain is also followed with no forward progress check. The loop
> takes the next table from adth->next_table_index and stops only when that
> reaches zero. A modem can stage two tables that point at each other, so
> the loop never ends. It runs in softirq and clones the skb on every pass.
> 
> Validate every device offset and length against skb->len before use.
> The block header must fit. Each table header, on entry and after every
> next_table_index, must lie inside the skb. The datagram table must fit.
> Each datagram index and length must stay inside the skb. The header
> padding must not exceed the datagram length so the receive length does
> not wrap. Require each next_table_index to move forward so the chain
> cannot cycle.
> 
> This was reproduced under KASAN as a slab out of bounds read on a normal
> downlink receive once the iosm net device is up.
> 
> Fixes: 1f52d7b62285 ("net: wwan: iosm: Enable M.2 7360 WWAN card support")
> Suggested-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>

