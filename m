Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795573705;
	b=OYwG8bZk/EjH/xU4V1mJE4ZkzvqL9maBUEVbnNiAmq4Dke8uyv88S0RmtQLUlWqmQaDE
	 Z3H6Jjc2zoVAzL5aL2obxb6OO7yB414LI6iIwJQwVlkk6wT+7goIzQraJ6S9RqNHwP6U0
	 P54IjfX/uy6U5l35Y8Qyy8GdM58EObZ5Hq9qdNNsRjsUlGQG+eklgscP1vHieyUE1u+xt
	 NtJ1V1uuuee99IbD8hwthc9+enZpqk54bAhgDpJnjbmRH6EfnwLkla+Rbd9sP7nMqHsTB
	 bMuq3P0PHR1nff+3mBPF0/mf0oJLVGkgomTuehSTmX4QFEk8Tsu0z4XdsV/a3O83EjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795573705;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=GZvNymZsIWDzZ+4ow3hX65QKKknBxmKLM784TXmwd/I=;
	b=WrDCocGXgmlDSESfRFPJczOF66/eL61ANe3unJ6L7MOc/6FisiZbZsyPdyi5RNQpU/J2
	 iONPpStMhWYfCOq6bNHBkBrIIL4kxefGUmutd0JTTUzBpI/BdSi+Wo4VN1Gouod/g1f+V
	 sBUTrKqwF2jDt7Lt4RRBGqPD57GpMKRwL4vCWf2sK9/QkOjhs3JmD8+u58987B71dtPAW
	 CGggPCHQfzYKzUSoZt65NIDs++VRjUb6Vq6CLL26uydQXQ1ol5DDdzbJf9bPkhzYH12Bi
	 sg6UChrcR35CLwFmZ9Q2dWPFnAXVHBOYcUNMageAAnuSYGnjQgVhV6e6UWvwrKzgBrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Mft61ybF;
	arc=none smtp.remote-ip=95.215.58.227
Received: from mta1.migadu.com (out-227.mta1.migadu.com [95.215.58.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13092606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 02:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13092606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Mft61ybF
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qN70FMkZdcX23pDbqX8QgEonbNQPBpr2pixHzy6GHiU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795573703; v=1; x=1796178503;
 b=Mft61ybFbXimS0hLWcc6z/SDUm562c5i9yOpsoDBtyX1GU7Z0ZWwXo9vhZi4IbuUUEi2OhFw
 bA29iEsf6p9FQEEDTuVXeXxImxhhHCvcgeSTy9iORyfJG80lG8bPKWlqhjqoglkSmt4+DvhWe7C
 LHsuHdNoSddQSye83XxVyOw8=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 9c984972921468ab;
	Wed, 25 Nov 2026 02:28:22 +0000
X-Mizu-Trace-ID: 9c984972921468ab
X-Migadu-Flow: FLOW_OUT
Date: Wed, 25 Nov 2026 10:28:19 +0800
From: Baoquan He <baoquan.he@linux.dev>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Kairui Song <kasong@tencent.com>, Qi Zheng <qi.zheng@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Barry Song <baohua@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
	Harry Yoo <harry@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: mglru: reset the mm iteration cursor in
 try_to_inc_max_seq_nowalk()
Message-ID: <awZHw6CK4_CaPUUf@fedora>
References: <20261117113700.453044-1-hui.zhu@linux.dev>
 <av6lVy5fW47XPxre@fedora>
 <0e42e0c4-c1f9-4778-a979-404fbb68130a@linux.dev>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e42e0c4-c1f9-4778-a979-404fbb68130a@linux.dev>

On 11/19/26 at 05:35pm, Hui Zhu wrote:
> 
> 2026/11/19 15:29, Baoquan He:
> > On 11/17/26 at 07:37pm, Hui Zhu wrote:
> > > From: Hui Zhu <zhuhui@kylinos.cn>
> > > 
...snip...
> > > @@ -3263,6 +3264,18 @@ static bool iterate_mm_list(struct lru_gen_mm_walk *walk, struct mm_struct **ite
> > >   	return last;
> > >   }
> > > +/*
> > > + * Advance mm_state->seq without walking the mm_list. The cursor must be
> > > + * dropped as well: iterate_mm_list() resumes from head, and resets the Bloom
> > > + * filter only when head == &mm_list->fifo.
> > > + */
> > This looks like a good catch, while the function name here is a little bit
> > confusing. From the code block inside, we can't see it's doing iteration,
> > just a pair of pointer resetting and a max_seq advancing. I would rather
> > not wrap up them if no good name is concluded. Personal opinion.
> How about inc_mm_state_seq(), after inc_max_seq(), leaving the "why"
> to the comment:
> 
>     /*
>      * The cursor must be dropped along with mm_state->seq:
>      * iterate_mm_list() resumes from head, and resets the Bloom filter
>      * only when head == &mm_list->fifo.
>      */
>     static void inc_mm_state_seq(struct lru_gen_mm_state *mm_state)
> 
> If that still does not read well to you, I will drop the helper in v2 and
> keep the two lines open-coded.

I feel like not wrapping them up is a little better than wrapping in
this case, while it's purely personal flavor. I would like to hear
other reviewers' opinion or it's up to you. Thanks.

> > 
> > Other than the nits,
> > 
> > Reviewed-by: Baoquan He <baoquan.he@linux.dev>
> 
> Thank you!
> 
> Best,
> Hui
> 
> > 
> > > +static void skip_mm_iteration(struct lru_gen_mm_state *mm_state)
> > > +{
> > > +	mm_state->head = NULL;
> > > +	mm_state->tail = NULL;
> > > +	WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
> > > +}
> > > +
> > >   static bool iterate_mm_list_nowalk(struct lruvec *lruvec, unsigned long seq)
> > >   {
> > >   	bool success = false;
> > > @@ -3275,9 +3288,7 @@ static bool iterate_mm_list_nowalk(struct lruvec *lruvec, unsigned long seq)
> > >   	VM_WARN_ON_ONCE(mm_state->seq + 1 < seq);
> > >   	if (seq > mm_state->seq) {
> > > -		mm_state->head = NULL;
> > > -		mm_state->tail = NULL;
> > > -		WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
> > > +		skip_mm_iteration(mm_state);
> > >   		success = true;
> > >   	}
> > > @@ -4686,15 +4697,11 @@ static void try_to_inc_max_seq_nowalk(struct mem_cgroup *memcg,
> > >   	DEFINE_MAX_SEQ(lruvec);
> > >   	bool success = false;
> > > -	/*
> > > -	 * We are not iterating the mm_list here, updating mm_state->seq is just
> > > -	 * to make mm walkers work properly.
> > > -	 */
> > >   	if (mm_state) {
> > >   		spin_lock(&mm_list->lock);
> > >   		VM_WARN_ON_ONCE(mm_state->seq + 1 < max_seq);
> > >   		if (max_seq > mm_state->seq) {
> > > -			WRITE_ONCE(mm_state->seq, mm_state->seq + 1);
> > > +			skip_mm_iteration(mm_state);
> > >   			success = true;
> > >   		}
> > >   		spin_unlock(&mm_list->lock);
> > > -- 
> > > 2.53.0
> > > 
