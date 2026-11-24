Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.31
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795482581;
	b=odP2mfG0TVGGyW1Co4GgB2cAUD1Y5gIOX7SzGHs4k5CewpKvyuvDkgiS4Zb3ODfZWvbs
	 D1mqjAvsPohV3NecqxSxrSEejSGqysEUEgt+28ir0V0nW7zLSCZ8hsCO/NWhalNIumzN+
	 3lzTw0jiYH8EWSAmFKRY7/EG0Nd6aFfB1gYsVS0GEIE1Lgh0N3sbcC1ZdL5BGq2Oro+N0
	 8KToAou4MOJ01Tob82IvY81mWK3bLhfRvc4CU5Gx7zM36XLCbbCU6iA05Jw57G9401Bcv
	 jtUgdTNFaxdwzSs1v6ZEuHQNlV0OJDy1zOCxejjvXGzISM9wTFUmlF6ZkUgSrwVK9aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795482581;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=owYjzpuYFLjOeIilxJig3Hw1JAaAisOBDLN+NbRQADQ=;
	b=Yu2c1Zc86OUPrkDKzDSo6yOYDiWY0iqg6LgIgT3s1HQPLh6n+qvyiE3gqg82kui/JNqV
	 C/qb6lgonZRVprwkL1JWtgUrokp+6yDLzeM2fz/D6Kx58qkbSM10u3QNJ187BriXcIfDO
	 qmkeso6XHaOj9m0198G/hujlvBvnUfVZ8t7CzUDC2cEtF/QBorP1Pd23Dlm01ToDtqU3S
	 h9kSi+wQGDAzW+EvKcrEGLzzZdZ8jMA+3LHPjyhC2OSrXypTB1o5dC+RvcgJb9ZTsZXX9
	 Nzxbrc2RR/+wL5PXHrrvi2cPzZ68y+4wRnmbdOuP5nfYmp0QJmWPvsJ+L1qHGB8Zh2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="uJoyh2/F";
	arc=none smtp.remote-ip=95.215.58.31
Received: from mta1.migadu.com (out-31.mta1.migadu.com [95.215.58.31])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628E0606A322
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 01:09:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 628E0606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=uJoyh2/F
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=CJ0tRkMlINyNJPnyBo44a+7BaS66at2HH38E/JU9IL4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795482578; v=1; x=1796087378;
 b=uJoyh2/FWyqZ6OMki2DTylrPNf5wJSpXgAFcImcgbo1wmpemxa4BczOit50u2uyHV9jFrkag
 lrHruw3b3XQRT9tNPhBUj3F2wMeVRM+HHykqslbHfOJ64HdDcHDvGgB2KcQG7hseMc7S8PSdUy5
 s+WbMX+srwG71oIjDRekSHTU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id dc929d9c275ff9e4;
	Tue, 24 Nov 2026 01:09:37 +0000
X-Mizu-Trace-ID: dc929d9c275ff9e4
X-Migadu-Flow: FLOW_OUT
Date: Mon, 23 Nov 2026 17:09:35 -0800
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Koutny <mkoutny@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Meta kernel team <kernel-team@meta.com>, cgroups@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] memcg: free the private ID of a memcg that never comes
 online
Message-ID: <awTh5c6t7SczKRDG@linux.dev>
References: <20261124000439.967403-1-shakeel.butt@linux.dev>
 <20261123165451.8c30df036f95995316e15047@linux-foundation.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123165451.8c30df036f95995316e15047@linux-foundation.org>

On Mon, Nov 23, 2026 at 04:54:51PM -0800, Andrew Morton wrote:
> On Mon, 23 Nov 2026 16:04:39 -0800 Shakeel Butt <shakeel.butt@linux.dev> wrote:
> 
> > mem_cgroup_alloc() reserves the private ID of a memcg when its css is
> > allocated. The ID is erased when the last reference to it is put, and
> > that reference is first taken in mem_cgroup_css_online(). The failure
> > paths of mem_cgroup_alloc() and mem_cgroup_css_online() erase the ID
> > themselves.
> > 
> > But css_create() can also fail after css_alloc() and before
> > online_css(): in percpu_ref_init(), cgroup_idr_alloc() or
> > css_rstat_init(). The memcg is then freed through mem_cgroup_css_free()
> > without ever coming online, and nothing erases its ID. The reserved
> > entry stays in mem_cgroup_private_ids for good, and each such failure
> > takes one of the 65,535 IDs away. With failslab failing radix tree node
> > allocations during mkdir, 1,500 mkdirs leaked 6 IDs this way.
> > 
> > Erase the ID in mem_cgroup_css_free() if the memcg never came online,
> > which is when (memcg->css.flags & CSS_RELEASED) will be false: it is
> > only set when an fully onlined memcg is released.
> >
> > Fixes: 73f576c04b94 ("mm: memcontrol: fix cgroup creation failure after many small jobs")
> > Cc: stable@vger.kernel.org
> 
> hm.  These allocations are all small and they're GFP_KERNEL so
> cc:stable seems a stretch?   But whatever - stable people have bigger problems
> than this ;)
> 

Sorry, I should have explain better the user visible impact. The memory leak
is not really a big issues, the memcg ID leak is greater issue. We have upper
limit of 65535 IDs for memcgs and if we keep leaking the IDs, we can start
seeing memcg creation failures.

> > --- a/include/linux/cgroup.h
> > +++ b/include/linux/cgroup.h
> > @@ -449,6 +449,11 @@ static inline bool css_is_online(struct cgroup_subsys_state *css)
> >  	return css->flags & CSS_ONLINE;
> >  }
> >  
> > +static inline bool css_is_released(struct cgroup_subsys_state *css)
> > +{
> > +	return css->flags & CSS_RELEASED;
> > +}
> 
> todo: switch css_next_child() to use this new helper.

Ack.
