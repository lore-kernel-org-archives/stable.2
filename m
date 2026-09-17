Received: from mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E58641D4C0
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 05:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789624718; cv=none; b=OAUgEaXPj/lXiy5COvD+80DcjtzYVyUeycklTO+UzVSy9ACZqOZLLdYSAmH49OWpjPQdcg9Bn8TcJykhVa6ORw/cQt/YAHxxrkDIFMYcje4Jxdgs2Q4lIsWPf59xZx6IUIOeyqcJdnIdd6Uy8SH/HqK19vhGIxmizgXQvVJkJfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789624718; c=relaxed/simple;
	bh=J8DscqG4a4GeiQzq3/0ZMuMoJ5VdAvhrxumKrU8mFcI=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=YuhuE7ZZi28a4NgMZVXk3C4/6VBykm0VcYVFJWwwrZ47kUeQpnEbzgTR6XnbEdDAlkZ8qEYRYoV2y7WR3JSZ7uBppVbcz4sX4y9YwsQiMigM3H3MMHiLMojLP8iVxj07h1pWGloz9OavGtHX45OaO0vdxF4BcbW1dJT6ZfN2RMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YjTmazg9; arc=none smtp.client-ip=91.218.175.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YjTmazg9"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=J8DscqG4a4GeiQzq3/0ZMuMoJ5VdAvhrxumKrU8mFcI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789624714; v=1; x=1790229514;
 b=YjTmazg9aIQBpzd39HD+qdjdHyMQ6IWhBBlRR3dFFJuYswwbtw9NutY2Wvkq8zHBRWlR/wXv
 QSoUrX9UyeYdZ7JPEhyY3cxYOz71ydRYsLA3ZZN2QTexx8OQi605WPUH2GaUBqauuIIDhwCMS5I
 Od/QQGNhp1SqgHUx99quepG0=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 67928f8b5859cc35;
	Thu, 17 Sep 2026 05:58:33 +0000
X-Mizu-Trace-ID: 67928f8b5859cc35
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [PATCH 1/2] mm/hugetlb_cgroup: move per-node usage on cross node
 migration
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260916-for-hugetlb-charge-v1-1-70fb708b2e4a@kylinos.cn>
Date: Thu, 17 Sep 2026 13:58:11 +0800
Cc: Oscar Salvador <osalvador@suse.de>,
 David Hildenbrand <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Kees Cook <kees@kernel.org>,
 Colin Ian King <colin.i.king@gmail.com>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Mina Almasry <almasrymina@google.com>,
 Mike Kravetz <mike.kravetz@oracle.com>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Hongfu Li <lihongfu@kylinos.cn>,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <E35A1286-33DF-4B54-8338-888EE28BFD06@linux.dev>
References: <20260916-for-hugetlb-charge-v1-0-70fb708b2e4a@kylinos.cn>
 <20260916-for-hugetlb-charge-v1-1-70fb708b2e4a@kylinos.cn>
To: Hongfu Li <hongfu.li@linux.dev>
X-Mailer: Apple Mail (2.3864.700.51.1.1)



> On Sep 16, 2026, at 16:30, Hongfu Li <hongfu.li@linux.dev> wrote:
>=20
> From: Hongfu Li <lihongfu@kylinos.cn>
>=20
> hugetlb.<size>.numa_stat uses folio_nid() to account usage in
> __hugetlb_cgroup_commit_charge() and =
__hugetlb_cgroup_uncharge_folio().
> hugetlb_cgroup_migrate() only moves hugetlb_cgroup pointers, leaving
> per-node usage behind on the source node during cross-node migration.
>=20
> When the migrated folio gets uncharged, we subtract usage from the
> destination node counter. This creates stale usage on the source node
> and unsigned long counter underflow on the destination node.
> The hugetlb.<size>.numa_stat interface exposes these incorrect =
per-node
> usage values to userspace.
>=20
> Add a hugetlb_cgroup_move_usage() helper which moves the usage from =
the
> old node to the new node, and call it from hugetlb_cgroup_migrate().
>=20
> Fixes: f47761999052 ("hugetlb: add hugetlb.*.numa_stat file")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongfu Li <lihongfu@kylinos.cn>
> ---
> mm/hugetlb_cgroup.c | 31 +++++++++++++++++++++++++++++++
> 1 file changed, 31 insertions(+)
>=20
> diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
> index ecb6e0b7819a..1040406e7e1d 100644
> --- a/mm/hugetlb_cgroup.c
> +++ b/mm/hugetlb_cgroup.c
> @@ -179,6 +179,34 @@ static void hugetlb_cgroup_css_free(struct =
cgroup_subsys_state *css)
> hugetlb_cgroup_free(hugetlb_cgroup_from_css(css));
> }
>=20
> +static void hugetlb_cgroup_move_usage(struct hugetlb_cgroup *from,
> + 				     struct hugetlb_cgroup *to,
> + 				     struct folio *from_folio,
> +  			             struct folio *to_folio)
> +{
> + 	int idx =3D hstate_index(folio_hstate(from_folio));
> + 	unsigned long nr_pages =3D folio_nr_pages(from_folio);
> + 	int from_nid =3D folio_nid(from_folio);
> + 	int to_nid =3D folio_nid(to_folio);
> + 	unsigned long usage;
> +
> + 	lockdep_assert_held(&hugetlb_lock);
> +
> + 	if (!from || !to)
> + 		return;
> +
> + 	if (from =3D=3D to && from_nid =3D=3D to_nid)
> + 		return;
> +
> + 	usage =3D READ_ONCE(from->nodeinfo[from_nid]->usage[idx]);

READ_ONCE is unnecessary because there is no concurrent writer.

> + 	if (WARN_ON_ONCE(usage < nr_pages))
> + 		return;
> + 	WRITE_ONCE(from->nodeinfo[from_nid]->usage[idx], usage - =
nr_pages);
> +
> + 	usage =3D READ_ONCE(to->nodeinfo[to_nid]->usage[idx]);

Same here.

> + 	WRITE_ONCE(to->nodeinfo[to_nid]->usage[idx], usage + nr_pages);
> +}
> +
> /*
>  * Should be called with hugetlb_lock held.
>  * Since we are holding hugetlb_lock, pages cannot get moved from
> @@ -906,6 +934,9 @@ void hugetlb_cgroup_migrate(struct folio =
*old_folio, struct folio *new_folio)
> 	/* move the h_cg details to new cgroup */
> 	set_hugetlb_cgroup(new_folio, h_cg);
> 	set_hugetlb_cgroup_rsvd(new_folio, h_cg_rsvd);
> +
> + 	hugetlb_cgroup_move_usage(h_cg, h_cg, old_folio, new_folio);
> +
> 	list_move(&new_folio->lru, &h->hugepage_activelist);
> 	spin_unlock_irq(&hugetlb_lock);
> }
>=20
> --=20
> 2.54.0
>=20

