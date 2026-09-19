Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D68B23ABBE;
	Sat, 19 Sep 2026 22:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789858154; cv=none; b=F5TMbNgOpWulqSjbXul9h08SXNSm0Kg21qjtokFuDKRZ3Xo5uhyvNzyUIWnJKhYJieO3s3xw/CH/limXtL3jiiPQ6zNVHdi5nRbKzoVIgjsBN4VKHJn0c5Ldn5M+nC3Z0FJtgbnlBPwgMuozLDJ5lCRlVX4nuTVvYQNQ5QFB3jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789858154; c=relaxed/simple;
	bh=M9lfdycnj26B0wf5T64eB/rV1ODXhAAyswP9GbZp4t8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j1amJgrrz74Gs+wXd9JrAMsK5Xx2TJ/J/bLHyU2IrLTT0doGFrebqiekkvNBnWjMYPJzUMu4aHJNtsxcmX5x42gT7fukOJpv3jJK3qaKAY8dumI0jQxIRtqM88sPi/CL5c/CC13M5ttpIkureBa1VJfAMCXEMWVlgOQZHYAwd5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKEBFSsv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKEBFSsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 870221F000FF;
	Sat, 19 Sep 2026 22:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789858152;
	bh=Kzr59Jx2V7LYxFe38Uaf68tYAwz1FjpadJT/liTBMSY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SKEBFSsvn3C+/J4BM76pDWNB3ByiPTR96WGBAhwcvmHj426Cy7AkFj9ANz35WG+iy
	 zbj6J0PhYyOiyw+c6CzdYfulLekAoiZSAmChwQNnRyiYc7K75CjtLmHEmdeJ20Zh2l
	 Kt3nFCNcO6/bwlh6MWMTOdeD5EYqW/6ykEYgx/JA6srLpKA8Ql2PxzE3QM15E04WzV
	 HaOUPwmw+5muGevyfWf3KMtGNfO9zL6TN+xhH52s9HthJDbkliDLROhXtAMTiq1GoC
	 5i8ba7nBCqNZCOARSNDo6TTBiohCBOVpda5zfC1rNXSxXWWyFExWzvchQIDz9I6PaP
	 hFpwB3Wr4X20Q==
Date: Sat, 19 Sep 2026 15:49:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: Xiang Mei <xmei5@asu.edu>, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, jakub@cloudflare.com,
 stable@vger.kernel.org, co+0ea1ac045375cf05@bugs.sh
Subject: Re: [PATCH net] vlan: require the MAC header to be present in
 __vlan_insert_inner_tag()
Message-ID: <20260919154911.642616cf@kernel.org>
In-Reply-To: <20260919074535.GW51261@horms.kernel.org>
References: <20260915083152.705309-1-xmei5@asu.edu>
	<20260919074535.GW51261@horms.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 08:45:35 +0100 Simon Horman wrote:
> > +	if (unlikely(!pskb_may_pull(skb, mac_len)))
> > +		return -EINVAL;
> > +
> >  	if (skb_cow_head(skb, meta_len + VLAN_HLEN) < 0)
> >  		return -ENOMEM;  
> 
> TBH I am surprised that we have a bug like this in this function.
> But your analysis matches my understanding of the code.

FWIW I suspect it's because non-ethernet packets shouldn't normally
reach ethernet helpers. But I'm not sure how practical it would be
to push mac_len checks to the callers or anything of the sort,
so we can as well check here..
