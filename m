Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E93FC5DD
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782493731; cv=none; b=NE21N+l9O6HE8qQByjs6EwxKj7AMemS8iHdA9LP0PabzdmgsYkHS2YrLH3YCBVuO/D4Ooqo/J3yV9e3TrHXwxwaroMg37x9nN15clAtPFdFJe4vAaLoydZNpmEUtwbSwwxh4x5VN6H6tpQKwKHZ9aiceDIAAicekaVAhT/tltfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782493731; c=relaxed/simple;
	bh=8Frm7ffQcAOhqsvdj7dYQtimPztj6oIAOxA5EJVnHoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCCD+kCZ/5YuoO/Lq7lav/tVwrvdTfa8zXjhlf7BwOnIOJdna4ceDp90pm70bv6GQSFVf/thw//0Ffg8WhHnpAvzSJy1phj/XswHE4ThT2vNPrnHb8OzbH0QXBIDF3dxNJqtIhmJ8TXU8wkPd+7mjAu4ryfp5BQOfFjCNsQEGAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HYljj6Ox; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HYljj6Ox"
Date: Fri, 26 Jun 2026 10:08:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782493716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tLPhQOvYbJ9MvCaXmifdh1jUBsM27DjBWEoAqn3LyyM=;
	b=HYljj6Oxv5JQqBwnaQNq8arYkl4AVGChM7A/N+JwsXNKPFlqfwPfDmcembYDjq+qFPbBaW
	WYIjUXv88Ktn302oXsGMU6PTCtdkLbBVI+qbEeazTj23fzTPOhPIGpqtsfF24Y3aRckwAw
	BW4tjB68OxrX9c5nu8VHDntI287ZpHw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Harry Yoo <harry@kernel.org>, 
	akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com, baohua@kernel.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, muchun.song@linux.dev, 
	peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev, ljs@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
Subject: Re: [PATCH v3] mm: mglru: fix stale batch updates after memcg
 reparenting
Message-ID: <aj6xzyqtwd4it0kZ@linux.dev>
References: <aj12aVq3he6q7b2C@cmpxchg.org>
 <4c7b0c46-14f0-4a62-893e-e50714e09b74@linux.dev>
 <46ac28bf-5be1-4600-b522-0a1aa76c28e6@kernel.org>
 <08cf8972-6cfc-4452-9a3c-88e0368dbbf9@linux.dev>
 <afdaff7c-fe6b-40da-8f54-aeeab8fe8867@kernel.org>
 <90fd5300-1016-42e7-abad-08ad85fb62b4@linux.dev>
 <5a0c6597-6b96-4781-a71b-fd1298b2b7bb@kernel.org>
 <c0e366ec-ee5d-42d9-ba33-7c630660e8af@linux.dev>
 <aj5I7JAXWlTHRyEW@cmpxchg.org>
 <57c18afd-e2a3-4b37-90b6-f2a4c758e8aa@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57c18afd-e2a3-4b37-90b6-f2a4c758e8aa@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Fri, Jun 26, 2026 at 07:21:28PM +0800, Qi Zheng wrote:
> 
> 
> On 6/26/26 5:39 PM, Johannes Weiner wrote:
> > On Fri, Jun 26, 2026 at 03:04:17PM +0800, Qi Zheng wrote:
> > > On 6/26/26 2:48 PM, Harry Yoo wrote:
> > > > On 6/26/26 3:24 PM, Qi Zheng wrote:
> > > > > On 6/26/26 12:59 PM, Harry Yoo wrote:
> > > > > > Observing a dying cgroup should be rare anyway, it's worth focusing
> > > > > > more on readability?
> > > > > 
> > > > > While it's rare to encounter consecutive dying memcgs, it can still
> > > > > happen, right?
> > > > 
> > > > But is worth saving a few instruction in a basic block that is
> > > > unlikely() to be executed?
> > > 
> > > I don't have a strong opinion here. Hi Johannes, I'll leave the decision
> > > up to you. If necessary, I can send out the v4.
> > 
> > Yes, I was thinking what Harry actually bothered to spell out ;)
> > 
> > The race is rare, multiple levels even rarer, and even *then*
> > mem_cgroup_lruvec() is a quick inline.
> > 
> > This way you have one block to handle that one rare race
> > condition. One place to put the comment. No labels, no goto.
> > 
> > Simplicity wins :)
> 
> Okay, I will update it as you suggested and send out the v4.
> 
> Hi Shakeel, do we really need to move lock_batch_lruvec() to
> memcontrol.h? It's currently only used by reset_batch_size().

This function is very specific to memcg therefore I asked it move to
memcontrol.h and not to keep in vmscan.c but we can always do the cleanup later,
so proceed however you want.

