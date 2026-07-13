Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4218A437451
	for <stable@vger.kernel.org>; Mon, 13 Jul 2026 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783953107; cv=none; b=FlhsMrrx9Csb3qSMvniwp4doUb1RZufP/e/okilaCUMoE/gO6Dj+sVRn+/+Yd15TcKsZV+9G8qrY4bVslEnuPHmyld3GHvgdL+PQxIsPFE2bCPO8uFaQ6RUfBn0vFfVuLcA47sTinWyMTm0H730oafZdipYoaoy4YeFJsehIo6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783953107; c=relaxed/simple;
	bh=bHTg67WLZNZPGJySzByFGb5I52o4TwIzu25xmj4aii0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=qoB/KfOqIlKIOfxa/WtIizPCNcooGJ/VY0YRFIKBh7XqG/MnfU1DGv6Ry8A6FsA4DGazKKyFHqnB66ZObJJJk1q1ns9Zg5drRuOeBq7k1uhAaSMr+7Eq5ZWvQWCFHgN1VH/8151kzu4ZDJk+6OBHbqt87lG9GN+bNs81LIdwFTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YhPqNrZl; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YhPqNrZl"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783953092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RP3LyPOyZnOu+5+FjIIqGVMA/Bpeem6vrUwBKnHaTKI=;
	b=YhPqNrZlHQ8ejQJEsKy22q7L2GwC8ZsKq8sODTlaMyBeXGHMdDNE3YCyn027NpCm9FGZKb
	GH4lpKEvmboLM/8AbLfjpjKd/DdrCA8T9cOaPAVIXi/jfL1ehkYFeaV3dNVJG67SVAs8NC
	uHVXw1fkorik/3Y+InQR45DobcQBcmo=
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 14:31:29 +0000
Message-Id: <DJXILB94G82L.37YBL62YO9XBK@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Brendan Jackman" <brendan.jackman@linux.dev>
To: "Andrew Morton" <akpm@linux-foundation.org>, "Brendan Jackman"
 <jackmanb@google.com>
Cc: "Vlastimil Babka" <vbabka@kernel.org>, "Suren Baghdasaryan"
 <surenb@google.com>, "Michal Hocko" <mhocko@suse.com>, "Johannes Weiner"
 <hannes@cmpxchg.org>, "Zi Yan" <ziy@nvidia.com>, "Sebastian Andrzej
 Siewior" <bigeasy@linutronix.de>, "Clark Williams" <clrkwllms@kernel.org>,
 "Steven Rostedt" <rostedt@goodmis.org>, "Shakeel Butt"
 <shakeel.butt@linux.dev>, "Harry Yoo" <harry@kernel.org>, "Alexei
 Starovoitov" <ast@kernel.org>, <linux-mm@kvack.org>,
 <linux-kernel@vger.kernel.org>, <linux-rt-devel@lists.linux.dev>,
 <sashiko-bot@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm/page_alloc: don't spin_trylock() in NMI on UP
References: <20260710-spin-trylock-followup-v1-0-affb5fe5ed00@google.com>
 <20260710-spin-trylock-followup-v1-1-affb5fe5ed00@google.com>
 <20260710170311.e22bfd21c658e8357ceddeec@linux-foundation.org>
In-Reply-To: <20260710170311.e22bfd21c658e8357ceddeec@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT

On Sat Jul 11, 2026 at 12:03 AM UTC, Andrew Morton wrote:
> On Fri, 10 Jul 2026 10:42:20 +0000 Brendan Jackman <jackmanb@google.com> =
wrote:
>
>> As noted in can_spin_trylock(), using this is unsafe in this context.
>> commit 620b46ed6ae17 ("mm/page_alloc: return NULL early from
>> alloc_frozen_pages_nolock() in NMI on UP") fixed this on the alloc side
>> but missed the free side.
>>=20
>> Reported-by: sashiko-bot@kernel.org
>> Link: https://sashiko.dev/#/patchset/20260703-alloc-trylock-v5-0-c87b714=
e19d3@google.com
>> Cc: stable@vger.kernel.org
>> Fixes: d7242af86434 ("mm: Introduce alloc_frozen_pages_nolock()")
>
> Is this correct?  I'm not seeing anything in that commit which could
> have caused this?

Oh yeah I guess it should be:

Fixes: 8c57b687e8331 ("mm, bpf: Introduce free_pages_nolock()")

This is confusing coz we have:

A: commit d7242af86434 ("mm: Introduce alloc_frozen_pages_nolock()")
B: commit 8c57b687e8331 ("mm, bpf: Introduce free_pages_nolock()")
...
X: commit 620b46ed6ae17 ("mm/page_alloc: return NULL early from alloc_froze=
n_pages_nolock() in NMI on UP")=20

X is marked as Fixing A, but it was an incomplete fix. I just copy
pasted the Fixes tag. But actually I'm now changing the free path that
was only introduced in B.=20

>> --- a/mm/page_alloc.c
>> +++ b/mm/page_alloc.c
>> @@ -2979,8 +2979,7 @@ static void __free_frozen_pages(struct page *page,=
 unsigned int order,
>>  		migratetype =3D MIGRATE_MOVABLE;
>>  	}
>> =20
>> -	if (unlikely((fpi_flags & FPI_TRYLOCK) && IS_ENABLED(CONFIG_PREEMPT_RT=
)
>> -		     && (in_nmi() || in_hardirq()))) {
>> +	if (unlikely((fpi_flags & FPI_TRYLOCK) && !can_spin_trylock())) {
>>  		add_page_to_zone_llist(zone, page, order);
>>  		return;
>>  	}
>
> It would be nice to include a description of the userspace impact.  I'm
> suspecting that's "none known", but some speculation on what might
> happen to someone is appropriate.

Ack. I think if you trigger this bug by accident it will probably crash
your machine in extremely confusing ways. If you can trigger it
deliberately from unpriv (depends on the rest of the host setup, e.g.
what tracing is being used) you can probably use it to get root/ring0.
Can mention this in the commit message.

> Also, please let's not combine a cc:stable bugfix with a minor macro
> renaming.  They're very different things and will take quite different
> paths into mainline and -stable kernels.

Ack. I assume by "combine" you mean put them in the same series - let
me know if I misunderstood that. Will separate them for v2.

> Also, Sashiko might have found yet more pre-existing issues:
> 	https://sashiko.dev/#/patchset/20260710-spin-trylock-followup-v1-0-affb5=
fe5ed00@google.com

There are 2 cases here:

1: !pcp_allowed_order() -> This is forbidden by alloc_order_allowed(),
   quite a bad miss from Sashiko IMO. Usually I expect AI to do better
   at spotting this kind of thing, makes me wonder if I'm the dumb one
   here.

2. pageblock is isolated -> Yeah this looks broken to me.=20
