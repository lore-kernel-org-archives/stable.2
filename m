Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C663DD525;
	Sun, 20 Sep 2026 09:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789896423; cv=none; b=V5a5aVWN+OsY0O7EEcxwWpUTvLylHM72RB31V1n5sIxEIusa3cPR7uB4YmsdFPJESPP02aOrT5ode1IshIa+aO//4i8/+8CK2pTv1FQNGp3kHoOKJE/Lbz/ikkoiWncn7m8pFyBgqeps2/w8CcHUwT5z/qXnq7xkFqGc+8bTc4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789896423; c=relaxed/simple;
	bh=Fd4NH91IHpBfE5nh8j7n8QVkABIowpo1/jSDVGNjAQ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbvU43OlbGuEE+nn4yLSRd9TQoB35sTYgwOXOzsjGN0Iqr8wFzBgG01Dla3gSNK2OvgqgMomrlY3qjHCVpAV6CjcsDV2DCx9aCKtNXK3ZivwvKyLy5ITfPfxa/hj4TE6ChZyuBASX7tbXkkIypWjlfLuXo5n88TO3YNDl8qgdok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lQcf4LUF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lQcf4LUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBEAB1F000FF;
	Sun, 20 Sep 2026 09:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789896421;
	bh=3NMeU7tF9nrFiPFgCGKge/XFjjtDJmpo93ZYBHwOb7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lQcf4LUF+JvPt2NshpVB49GBqGlU+x1gzcFNmvNHRV8TCW51sziWv30Ois0CoHa9v
	 dqsKkj6qbTGQcphiyZQEu8AH8NTxf2Qu462ZRvr+DnYFpm5fxBjCjUztxNqACOzALa
	 vVmx4d4mEwLlO1BVqv7ha99BBjXG5u51hO58NZnTl4zmHbSowyngcnY4ekn5nUBi6V
	 s5IDg6BCYHs4a7TcJnqd1zFmtl8qBzzfeLpTg5BQsmDqQ0zggtvYGe/QDYm4YVDf/3
	 V59AZo5U8msxQ+zLhTrirmRIkM3LqBorZZjVkJR8D37tQzSBX2GmlHXD2a920zKLB2
	 FEXkFW+jkl0eA==
Date: Sun, 20 Sep 2026 10:26:57 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Xiang Mei <xmei5@asu.edu>, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
	jakub@cloudflare.com, stable@vger.kernel.org,
	co+0ea1ac045375cf05@bugs.sh
Subject: Re: [PATCH net] vlan: require the MAC header to be present in
 __vlan_insert_inner_tag()
Message-ID: <20260920092657.GB13925@horms.kernel.org>
References: <20260915083152.705309-1-xmei5@asu.edu>
 <20260919074535.GW51261@horms.kernel.org>
 <20260919154911.642616cf@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260919154911.642616cf@kernel.org>

On Sat, Sep 19, 2026 at 03:49:11PM -0700, Jakub Kicinski wrote:
> On Sat, 19 Sep 2026 08:45:35 +0100 Simon Horman wrote:
> > > +	if (unlikely(!pskb_may_pull(skb, mac_len)))
> > > +		return -EINVAL;
> > > +
> > >  	if (skb_cow_head(skb, meta_len + VLAN_HLEN) < 0)
> > >  		return -ENOMEM;  
> > 
> > TBH I am surprised that we have a bug like this in this function.
> > But your analysis matches my understanding of the code.
> 
> FWIW I suspect it's because non-ethernet packets shouldn't normally
> reach ethernet helpers.

Yes, I agree that seems likely.

> But I'm not sure how practical it would be
> to push mac_len checks to the callers or anything of the sort,
> so we can as well check here..
