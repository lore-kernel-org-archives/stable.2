Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794929825;
	b=qHPeASdElzQMFXGWZwlf1tykrKLxe9k7yb0bFycMDq2AKdxIfbPi+wwvEQPYVrtn5m8B
	 x5j7RPmzIkdMh8LtLAa1/7+F9r4CD/+WYJsXRnWNBFqP4A7IScDz+DfR7EdZU5aHejE5R
	 pJF/ud1Wrr+/RvyxkXT9HAKFoOsYfq4VUU465TEVbdX8Nnh1PPu3FfHFsZKvisQx2XDTT
	 T2VSuudYJxw1am0BEn4DAcB3yUYgVILGmsAQf66cPnLZPg435NeQtNSgSFvVE1gdLABZ8
	 NKoRVElaEVQibDaW2Mm3cXJNDZWz8T4kD5K09jqLbOQDpvrn2rgmTDWSCi5D52ZaKdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794929825;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=+bALTgYPfIad1XZTuc45/MCR0LAeKGdtBKZv+egR7pQ=;
	b=vPMku3QgPXGlPvxP7Z9i+F2NUNodE/eFFgr+22l3vJhem7prnoFeLlMidUCO38sd0BRU
	 h0e+VlN4R2Iyf68wgNeqpvKqOhYdNO+mxCItY2xhz0k2HuvfajsWZZ5yQ702jTx5GyjLh
	 nTENujcIlI4spDs4uTzreY8cpkpvRaFlWITnEMo64cZfw9sEUschNfP9P95T2LnuiMNgm
	 RLv2habQJTxevcga1qbq0jSdA1hak43cwFlguiPD3joNUKZPYDu95e9OrK6LX9/VDaQTt
	 tygU/2z9Db2NHaVsI772kPYZj/qb+Xor2kBIx/d1bfkMNWUl1+ZUzcLKKQBSlX4dSqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZjlZo9Ub;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D774606A33A;
	Tue, 17 Nov 2026 15:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZjlZo9Ub
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1871F000C4;
	Tue, 17 Nov 2026 15:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794929825;
	bh=+bALTgYPfIad1XZTuc45/MCR0LAeKGdtBKZv+egR7pQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZjlZo9Ubqff4c93mEcadpNICZynvRDGma8iq4qQhH5ZtClssDYYxMEJmhnIIMv7rH
	 +tSvWJ3smeCCE6UvBQLXxwRZQhdu5Hi1cbrQHTnRwEGZtSvFb4/U9QIK2AAAmFw82+
	 JzTufoKKAbf4PMRbnzKJYo2BOe1BAXvMQtY9UOEdhiAcyGqZbnlvaeFZDDhAFOa4Am
	 h/LD58VRtaGPno2Tqat5p36Yv13S3DyHGucnqaXHJx6Ieq/v4CP4kWzwjawT+bC2zf
	 q0jaQIEz/puFZBofPlJIaO2/YvofxD+7ItBTJaxs48Dd0C8LueDY8pBllWg8vjZZyD
	 GB0kcW4vuRuvw==
Date: Tue, 17 Nov 2026 15:36:58 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@kernel.org>, 
	"David Hildenbrand (Red Hat)" <david@kernel.org>, Gregory Price <gourry@gourry.net>, 
	Andrew Morton <akpm@linux-foundation.org>, larips <larips950@gmail.com>, stable@vger.kernel.org, 
	Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Brendan Jackman <brendan.jackman@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Jackie Liu <liuyun01@kylinos.cn>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mempolicy: fix copy_nodes_to_user() for odd inputs
Message-ID: <avx0Ci5uPW_hF0Jk@pazuzu>
References: <20261117142628.3931151-1-arnd@kernel.org>
 <avxnIQTcFni9G4IN@gremlin>
 <541a67af-3b45-4d5d-ac4b-c741850f92e1@app.fastmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <541a67af-3b45-4d5d-ac4b-c741850f92e1@app.fastmail.com>

On Tue, Nov 17, 2026 at 04:26:48PM +0100, Arnd Bergmann wrote:
> On Tue, Nov 17, 2026, at 15:59, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Nov 17, 2026 at 03:25:53PM +0100, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> For compat syscalls, the effect is worse, as the actual calculation for
> >> the size does include the extra word, but the check for the input size
> >> does not take it into account and can leak a word of stack data.
> >>
> >> In addition, the size calculation rounds up to multiples of 64 bits
> >> instead of multiples of word size as documented in the man page and
> >> expected by numactl.
> >>
> >> Fortunately numactl always passes multiples of 64 here, so none of
> >
> > (Claude) went looking at numactl source (e.g. via libnuma) and it seems it
> > passes size + 1 matching the convention?
>
> Ok, I see it now as well. The man page again says "maxnode specifies
> the number of node IDs that can be stored into  nodemask——that is,
> the maximum node ID plus one.", which I'd naïvely interpret as meaning
> that a system with 64 nodes would have a "maximum node ID" of 63 and
> require passing one more (64), but clearly the implementation on
> both sides expects a 65 here.

Yeah which is... special isn't it? :))

>
> >> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> >> index 6d662a9a8c74..f318e1155770 100644
> >> --- a/mm/mempolicy.c
> >> +++ b/mm/mempolicy.c
> >> @@ -1749,12 +1749,12 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
> >>  static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
> >>  			      nodemask_t *nodes)
> >>  {
> >> -	unsigned long copy = ALIGN(maxnode-1, 64) / 8;
> >> +	unsigned long copy = ALIGN(maxnode, BITS_PER_LONG) / 8;
> >
> > This looks like it'll be broken given the convention of passing bits + 1,
> > e.g. ALIGN(1025, 64) / 8 != ALIGN(1024, 64) / 8.
> >
> > Then later that could case a buffer overflow potentially?
>
> Right, this would then overflow the user buffer.
>
> > Overall it seems the issue is that e130242dc351 (understandably!) passes maxnode
> > rather than maxnode-1.
> >
> > So a really small fixup would be something like:
> >
> > diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> > index fb627b37afcb..051d411c04ee 100644
> > --- a/mm/mempolicy.c
> > +++ b/mm/mempolicy.c
> > @@ -1733,12 +1733,12 @@ static int copy_nodes_to_user(unsigned long
> > __user *mask, unsigned long maxnode,
> >  		if (clear_user((char __user *)mask + nbytes, copy - nbytes))
> >  			return -EFAULT;
> >  		copy = nbytes;
> > -		maxnode = nr_node_ids;
> > +		maxnode = nr_node_ids + 1;
> >  	}
> >
> >  	if (compat)
> >  		return compat_put_bitmap((compat_ulong_t __user *)mask,
> > -					 nodes_addr(*nodes), maxnode);
> > +					 nodes_addr(*nodes), maxnode - 1);
> >
> >  	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
> >  }
> >
> > Maybe doing that's the easiest route for this?
>
> I would still try to fix the other mistakes (aligning to 64 instead
> of BITS_PER_LONG/BITS_PER_COMPAT_LONG and the incorrect nbytes).
> Maybe it's clearer to just pass the adjusted maxnode into the
> function directly and keep that extra '-1' in one place?

Yeah it'd be nice to get away from that convention which is... very
confusing :) Especially as 'max' implies to me an inclusive bound.

You could have a wrapper get_nodes() that calls __get_nodes() that has a
'lastnode' parameter for instance?

--
Cheers, Lorenzo
