Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.113
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793013070;
	b=XU/lt/S31dpmdDaJsY9sRaTYb4GzpsjyDh27U2wpi00I8vwxGQ1Mcnj1X/8aPpYzdeGp
	 GLx/L+73Sw8/7D48s3NRc/pKW40t7KGvnhJIpT7NhY1LeQOunOWNXxAz5ldd9b5Xf4Uoz
	 /qlY5b+iU7U9sAia3MNmXXvtdFDjUj2GvJjg8C767YF82cCVKBAVgOOWPPu1/K2kKPQ34
	 aqIri7IjMwP8SYFhsIKPYYZsZWflyzauwJ720zoXQqCeO0PsMinI0Nzz9HWl/ODMQpGHD
	 nkV1Zrv95CHRMGhoSG9Q+9p7Q5wLHEBfZOqA6QI4wLb37duYC6xTtBZ6NJ/Uhe9w2cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013070;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=kv79Ibi9i0yW18VfNZUR7O/kIwfQnu5qszXLeT8x3ok=;
	b=WteivkShQ75q0K+FgbEnNtqqwLWwRlzEVfUkln/+gQjZaB5HXoxbgE+XlWsAePDZ3wlV
	 fGZApXBuvnkJVcBY6rXKzjd9N6aCRzB4DapVeWq47rFEX2WTTVnIB5MY9LABJdzXlxtB0
	 q2gqKSFfEbxQQicjucCb6WX2gzeIvTlWU4DOglOMmqC78MD16U1CZXpdeIbrtsASmc/dl
	 0F0mxKj44g/iMufEErqYJ8UPe1mW+UIE+S5ud5r9BM8Q6sDtIdA0XLaX9tyqOCShgbsuY
	 rFXhsq0mdGVWGm7U/sFRC/eQ2GL1Wb80gwir0Mnhd24YfF74gPhv0Z82szv+Xo+jTmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vbEuDUa0;
	arc=none smtp.remote-ip=115.124.30.113
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216B960A382E;
	Mon, 26 Oct 2026 11:11:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 216B960A382E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vbEuDUa0
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793013066; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=kv79Ibi9i0yW18VfNZUR7O/kIwfQnu5qszXLeT8x3ok=;
	b=vbEuDUa0lR/TYNeWtHyreCqcI+7qY+DwXmSvujuDgrG80ppvtqwGsF30X3qsakyvdRy9byh7rL9oeGo0/SJZMLXz05fZ+KcQN+WV0lqPm2OrahAJnBqk0nbGGOuU356K8Ah2+gcoSagkiOYjp8pwHs/q2fy0fWoZMzHJchVLa8Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=33;SR=0;TI=SMTPD_---0XDWn7u2_1793013062;
Received: from 30.74.144.181(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDWn7u2_1793013062 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 19:11:03 +0800
Message-ID: <a8f01101-7d7d-4982-9cf8-04b754ba132a@linux.alibaba.com>
Date: Mon, 26 Oct 2026 19:11:02 +0800
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
Subject: Re: [PATCH 00/16] mm/shmem: various (urgent?) fixes
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
 Josef Bacik <josef@toxicpanda.com>,
 Eva Kurchatova <eva.kurchatova@virtuozzo.com>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/26/26 5:40 PM, David Hildenbrand (Arm) wrote:
> Hi,
> 
> the fixing fun continues.
> 
> This is a handful of fixes for shmem/tmpfs. I sneaked in a related
> hugetlb fix that stalled upstream.

Wow, thanks David!

> Some of the stuff is more urgent (patch #1, F_SEAL_EXEC, truncation
> hangs), others are less urgent but still rather unpleasant.
> 
> The majority are fixes from Anthropic that I cleaned up or reworked.
> While doing that, I found a bunch of other issues and tried to fix them
> somewhat cleanly.
> 
> In general, shmem + swap handling is a nightmare. shmem_undo_range() is
> such utter garbage it makes me want to cry. I mean, really, WTF did we
> end up creating there. Does any expert here have time to clean that up and
> make it *actually* maintainable.

Agree. :) I'll re-read shmem_undo_range() and take a close look at the 
issues you raised, and see if I can make shmem_undo_range() more readable.

> The following things are still broken in shmem_undo_range():
> 
> (1) Truncate/punch of a single page of a large swap-error marker
> 
> We don't split. Consequently, read access afterwards will still fail
> instead of returning 0s.
> 
> I have a fix to try to split (which can fail), but I don't consider it
> that urgent, really. So I'm not including it. Might send it later
> separately.
> 
> Truncate/punch of a partial page can obviously never do the right thing,
> as we cannot poison parts of pages ...
> 
> (2) Truncate/punch whole pages within part of a large swap entry
> 
> We try to read the entry, but if we are out of memory that might fail.
> Consequently, we will not free up swap space and a re-read will not give
> us 0s but the previous content.
> 
> AI proposed a nasty NOFAIL patch which has too many nasty side effects
> IMHO (allowing users to force-read pages and retain them afterwards even
> though memory.max would disallow it). This needs a proper thought. Likely,
> support for splitting large swap entries (and large folios in the
> swapcache, which I recall is under development  by Kairui). But splitting
> can fail ...
> 
> (3) Truncate/punch of a part of a base-page swap entry
> 
> We obviously have to read the page in, in order to 0-out the parts to
> discard. That might obviously fail.
> 
> Maybe we should install swapin-error markers if swapping during
> truncate/punchhole fails, to at least tell user space on later access
> that something went wrong? We might affect unrelated data, outside the
> requested range, though. Anyhow, these are long standing issues and
> I don't consider them urgent.
> 
> They need a proper solution.
> 
> I did my best trying to test these fixes. I was able to reproduce some
> of the things (including unkillable truncation hangs), and the fixes seemed
> to help.
> 
> But again, shmem_undo_range() is just an absolute mess.
> 
> Please prioritize review of these fixes, I want to get fixes for the
> issues in a timely manner upstream.

OK. Will review and test this serires this week.

> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> ---
> Chris Mason (5):
>        mm/mempolicy: charge shared policy nodes
>        mm/shmem: honour F_SEAL_EXEC when an ACL is set
>        mm/shmem: avoid moving the truncation start backwards
>        mm/shmem: stop retrying folios that cannot be split
>        mm/shmem: preserve data in clean folios when splitting fails
> 
> David Hildenbrand (Arm) (7):
>        mm/shmem: discard whole new large folios on fallocate rollback
>        mm/shmem: rescan after nonuniform folio splitting
>        mm/shmem: fix truncate hang in large swap entry
>        mm/shmem: preserve allocation errors when swapping in large entries
>        mm/shmem: fix truncate loop after boundary swapin failure
>        mm/shmem: fix accounting of swapin-error markers
>        mm/shmem: fix truncation of files containing only swapin-error markers
> 
> Eva Kurchatova (1):
>        hugetlbfs: enforce F_SEAL_EXEC in setattr
> 
> Josef Bacik (3):
>        tmpfs: keep the quota soft limits of an unused id
>        tmpfs: preserve explicitly disabled quota limits
>        mm/shmem: hold off eviction in shmem_writeout()
> 
>   fs/hugetlbfs/inode.c  |   8 +++
>   include/linux/memfd.h |   9 +++
>   mm/mempolicy.c        |   4 +-
>   mm/shmem.c            | 170 +++++++++++++++++++++++++++++++++++---------------
>   mm/shmem_quota.c      |  28 +++++----
>   5 files changed, 154 insertions(+), 65 deletions(-)
> 
> ---
> 
> base-commit: 21a7f44fd0765fcc5194130b28767786eba1d1e7
> 
> change-id: 20261025-fixes_shmem-2782719b130e
> 
> --
> 
> Cheers,
> 
> David

