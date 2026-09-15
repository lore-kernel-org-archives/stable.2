Received: from mta0.migadu.com (out-43.mta0.migadu.com [91.218.175.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AE93C65FD
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789475076; cv=none; b=etWhJyl+0bGxXscjLsvkvZUDZI1gF0VS6RwFzZ4hHVq2um9O7hlOPEtwMPyU95X/Z2q/W8lYwfrdtCI6D3rjXBr9gAxR9+yZ3w11Y6zoJkBnW8hkHkjcnDVnd9/C1PIyzrDp1z4pFkjw/xV02kHb92HdqA9dpa863tDOIWBFIU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789475076; c=relaxed/simple;
	bh=xuQwE5igrAW6hukl2lXyxMqN9/4oMkU4kL5kbKNUvls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzYwrz+UfK4qEwLBpJntvJ0iDAdtOikU7NX9o/00W3/hz5P6nnhrOaE/binc7BjFsLHJXBUWlgx4uo1H00wtcCHSZL6McLIG/Fp3QYpx81hCJJDWwEl0k9weQTML2/zUY0iqqPggPY9URhynL3jXL1hd0AKmZPAxANTU5UZSa5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kdxEDSk2; arc=none smtp.client-ip=91.218.175.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kdxEDSk2"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xuQwE5igrAW6hukl2lXyxMqN9/4oMkU4kL5kbKNUvls=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789475072; v=1; x=1790079872;
 b=kdxEDSk2jOWadpLRN/n6ReQZfWugJFFwwzg19XMGJeoOmt+0HkvUMnn0dqrDqN38k//MDqtu
 krQN9AZxCxJLH4CZ+02rlKndkKUv3mUB1lxupI5otnwdCX6Wd2fIfQqbS0+2MCuw9+u0xqcjsoL
 3X90Hnf5S9VVnM8U75xazyg0=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 91ab6dea17195cd1;
	Tue, 15 Sep 2026 12:24:32 +0000
X-Mizu-Trace-ID: 91ab6dea17195cd1
X-Migadu-Flow: FLOW_OUT
Date: Tue, 15 Sep 2026 20:24:22 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	idosch@nvidia.com, alex.aring@gmail.com, justin.iurman@gmail.com,
	bestswngs@gmail.com, stefano.salsano@uniroma2.it, xmei5@asu.edu,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] ipv6: rpl: fix NULL dereference of idev in
 ipv6_rpl_srh_rcv()
Message-ID: <aqk49jT8tGsqn61d@fedora>
References: <20260817132644.2223-1-andrea.mayer@uniroma2.it>
 <aqjflqdySFG51YEa@fedora>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqjflqdySFG51YEa@fedora>

On Tue, Sep 15, 2026 at 02:03:12PM +0800, Hangbin Liu wrote:
> Hi Andrea,
> 
> While reviewing the SRv6 code, I noticed you added an `idev` check in
> `ipv6_rthdr_rcv()`. I’m wondering whether it makes sense to also halt
> processing for `IPV6_SRCRT_TYPE_2` when `!idev`, given that IPv6 is
> disabled on that device.
> 
> If so, could we drop the skb early at the entry point of `ipv6_rthdr_rcv()`?
> The downside is that subsequent processing and `__IP6_INC_STATS()` would be
> skipped.

Oh, another behavior change. At present, if !idev, we can still process the
IPV6_SRCRT_TYPE_2 message. And the process will be skipped if we return early.
I'm not sure if this kind of change is acceptable or not in kernel.

But on the other hand, is it correct to accept and forward SRCRT Type 2
packets on device that IPv6 is disabled?

Thanks
Hangbin
