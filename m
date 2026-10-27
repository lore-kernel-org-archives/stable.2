Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107269;
	b=n4lRHV5eH4wcMfjVG4ejQ0aOSJvmBEX1mCWiw8azeHS58JKUzMYsXzx6Po9HI6tc11Ja
	 0NP0o6Aknvhw5wEm+/KV0rbweZnmD8+cGQgEM0zsfnO/jEEY9IlVf+csD6QTlesuQZGwm
	 HPZ0QK9PaiT5Dgh5oLyGtv38IwKLvNF/xIq4MHbsdr+vsLXyqoFvk9egXropztW5O6FP8
	 xQ3XWx8M4UOold7ivrKasPUfto1FNxnOFTcTk+kDFbijBWpZ4VBzGAyoFtVmvK0ntTS2C
	 Vukzifvk+Cy2Q9AZAaQ0hrekhsVluN/E7PsPoQ3wNaIdOy3HRb3ZaDrDGFF+2QOW0Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107269;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=CuQkM5AxwZ9bvY/L5nF/RTWycJ4QV92AF8p0xtQA/Aw=;
	b=OorJ4fJfphCN3PrDT/Cu4IG7L2r8RomUMeGPNYzXQHtGjLqdbFFBBlekBtkYGhWbQ5XA
	 Zqw4D7udXnCYhpIi1/95I91er5UNKFzYJjZZTWqvAJMm0jj3ul/C7MvsqRnT6ZbnlZCPS
	 uHvdwZxMD6Dg9OmWn3Ms1tMGs8KR8M+uUPRLXlLz/voW7DGtAPw2WizvieH4+0Soc+F7H
	 k4KB7yWB6aTRu6Ba79STu3dp4Fusk197LDXFEdlnFV8hhl49cxZ/KEGXWMtafuMNzx21e
	 ArMluHQWTiSHe4G8tDrrqGBNKjsClqNE1XrDfC46xlIE6qtFZhkgAAWzt6gxZZrzh4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=h5psblzd;
	arc=none smtp.remote-ip=115.124.30.118
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF38606A326;
	Tue, 27 Oct 2026 13:21:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BDF38606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=h5psblzd
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793107259; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=CuQkM5AxwZ9bvY/L5nF/RTWycJ4QV92AF8p0xtQA/Aw=;
	b=h5psblzdWKDEY+uP9ryvZBr6xfptZI33+XJ8wGMoIAWOzzN38dkEUXysLNcn0+vFdEL6kF9FO0B0YJi/O0asbc4eMogN2GcRCZZoWz605xJa/wnpGe10iPSHARfwEgZV1HqQZraMZkdkCdF/qVfQCoOBDd9o63PV2y/KX4X0XLE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R241e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0XDe0LQe_1793107255;
Received: from 30.74.144.191(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDe0LQe_1793107255 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 21:20:56 +0800
Message-ID: <de90d124-03f6-4657-a467-71ab3d441212@linux.alibaba.com>
Date: Tue, 27 Oct 2026 21:20:54 +0800
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/14] mm/shmem: various (urgent?) fixes
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Gregory Price
 <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Lukas Czerner <lczerner@redhat.com>,
 Carlos Maiolino <cmaiolino@redhat.com>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>,
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 David Stevens <stevensd@chromium.org>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 William Kucharski <william.kucharski@oracle.com>,
 Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>,
 Nhat Pham <nphamcs@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org,
 Pedro Falcato <pfalcato@suse.de>, "Kiryl Shutsemau (Meta)" <kas@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>,
 Eva Kurchatova <eva.kurchatova@virtuozzo.com>
References: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261027-fixes_shmem-v2-0-86a00952acb9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/27/26 9:03 PM, David Hildenbrand (Arm) wrote:
> Hi,
> 
> see v1 for details. TL;DR various fixes.
> 
> I now rebased on top of mm-stable (thanks Zi!) and retested with
> Gregory's tests (thanks!). Thanks everyone for the fast review!
> 
> When sending this upstream there will be one conflict with the following
> upstream commit:
> 
> 	737362c7012a ("fs: port ->set_acl() to pass const mnt_idmap")
> 
> Which should get resolved through something like
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@
> -static int shmem_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
> +static int shmem_set_acl(const struct mnt_idmap *idmap, struct dentry *dentry,
>   		struct posix_acl *acl, int type)
> 
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
> Changes in v2:
> - Rebased on mm-stable
>   - Fixup shmem_set_acl() compilation issue after rebase
>   - Dropped: "mm/shmem: avoid moving the truncation start backwards"
>   - Fixed up: "mm/shmem: stop retrying folios that cannot be split"
> - In "hugetlbfs: enforce F_SEAL_EXEC in setattr", check for S_ISREG
> - Smaller patch description fixups
> - Picked up tags
> - Link to v1: https://patch.msgid.link/20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org

why drop this fix "mm/shmem: hold off eviction in shmem_writeout()" from v2?

https://lore.kernel.org/all/20261026-fixes_shmem-v1-6-703206d5fa0c@kernel.org/#t
