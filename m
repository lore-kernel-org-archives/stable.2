Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0863148D3
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 09:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687953; cv=none; b=LY0UqZwrEw1/PhJbx6rgMnSiyGg3TcVtvmEUPPuBWf7aXamv006ze2R16K4T+1QcEf9+CD0j2tXwn9T8x448xJHOmNt02m2vI8rNrh0F2vWyjc7NUbADpD97NGSR3rXqqciZW8e64yXhjAjAaZBineRC6B1KOjAjPHL9L3m+V8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687953; c=relaxed/simple;
	bh=dfNyzEm0HtGsQGTvMwWDhpf24NmRwu+ZChOl+PfMOP8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=nMmxoIpnfYhqPNDOPodBzwQZIFZaXhsEDtX6K0ST34e+EMQ78QwQqULESXWD4MDF3DyRUvcYyr+AplU+CaKGC+ryGpfUYu0ez1972s/6grMsjdcsnUGqIuVKr4aTAflwMBZKLOzkSMgtSx8MWYUFYyiTZ1/CK5qWjVFZEbUus0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QPy5fbS0; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QPy5fbS0"
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781687950;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lMQGqpgSC5EMLyUBnCorVPFjA76iXNC33Ltwj1O5yMQ=;
	b=QPy5fbS0RybOo1ITfmRGYOxj37GMmK1I1T8rjl+fDmd6rf2JhYAMwF9D5oAvzGpAGOTjmP
	veiggTaNCIb8k2GPskVwl6CCKSfXJtrbVE2aLN4iYda++M3j6OffFni1+oWG7C0ojDvSGc
	dukv9z/KDBkRJpbWj8PcGFu2gt2rE/I=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.600.51.1.1\))
Subject: Re: [PATCH] mm: shrinker: fix shrinker_info teardown race with
 expansion
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260617085658.27096-1-qi.zheng@linux.dev>
Date: Wed, 17 Jun 2026 17:18:07 +0800
Cc: akpm@linux-foundation.org,
 david@fromorbit.com,
 roman.gushchin@linux.dev,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <D326325D-79A4-473F-9C63-B875176F378E@linux.dev>
References: <20260617085658.27096-1-qi.zheng@linux.dev>
To: Qi Zheng <qi.zheng@linux.dev>
X-Migadu-Flow: FLOW_OUT



> On Jun 17, 2026, at 16:56, Qi Zheng <qi.zheng@linux.dev> wrote:
>=20
> From: Qi Zheng <zhengqi.arch@bytedance.com>
>=20
> The expand_shrinker_info() iterates all visible memcgs under
> shrinker_mutex, including memcgs that have not finished ->css_online()
> yet.
>=20
> Once pn->shrinker_info has been published, teardown must stay =
serialized
> with expand_shrinker_info() until that memcg is either fully online or
> no longer visible to iteration. Today alloc_shrinker_info() breaks =
that
> rule by dropping shrinker_mutex before freeing a partially initialized
> shrinker_info array, which may cause the following race:
>=20
> CPU0                   CPU1
> =3D=3D=3D=3D                   =3D=3D=3D=3D
>=20
> css_create
> --> list_add_tail_rcu(&css->sibling, &parent_css->children);
>    online_css
>    --> mem_cgroup_css_online
>        --> alloc_shrinker_info
>            --> alloc node0 info
>                rcu_assign_pointer(C->node0->shrinker_info, old0)
>                alloc node1 info -> FAIL -> goto err
>                mutex_unlock(shrinker_mutex)
>=20
>                       shrinker_alloc()
>                       --> shrinker_memcg_alloc
>                           --> mutex_lock(shrinker_mutex)
>                               expand_shrinker_info
>                               --> mem_cgroup_iter see the memcg
>                                   expand_one_shrinker_info
>                                   --> old0 =3D C->node0->shrinker_info
>                                       memcpy(new->unit, old0->unit, =
...);
>=20
>                free_shrinker_info
>                --> kvfree(old0);
>=20
>                                       /* double free !! */
>                                       kvfree_rcu(old0, rcu);
>=20
> The same problem exists later in mem_cgroup_css_online(). If
> alloc_shrinker_info() succeeds but a subsequent objcg allocation =
fails,
> the free_objcg -> free_shrinker_info() unwind path tears down the =
already
> published pn->shrinker_info arrays without shrinker_mutex. The
> expand_one_shrinker_info() can race with that teardown in the same =
way,
> leading to use-after-free or double-free of the old shrinker_info.
>=20
> Fix this by serializing shrinker_info teardown with shrinker_mutex, =
and by
> keeping alloc_shrinker_info() error cleanup inside the locked section.
>=20
> Fixes: 307bececcd12 ("mm: shrinker: add a secondary array for =
shrinker_info::{map, nr_deferred}")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

