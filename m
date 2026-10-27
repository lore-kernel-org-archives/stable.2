Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793107641;
	b=gl4NzDrpgDUKgFXVA2xd/niQSX3EioQ75zIiycodEF61Qv4cdNwGIFcSJld1rL2n6Dx0
	 WWUjUJ5R+9mmiEQNayJ0jrKYyhK7q28WOsNQqL0CScrsBnFKIkjYCuiCVHgUf+1HAOHUJ
	 EjnZNXs2llVt8LzaYS0MI5hV4/4ejTByWTENArnTIAYcqAJWIL7Au+FF4x2lfRKZEJfhB
	 ZDgXMPdyRS8uq325IyxqB4NO38vFa7JnMHigyyMDAJ+KG+9zd/iTVohSErqh3taoGMlEI
	 Qv20lGC3cq/m8K47n+d8TE4qGj4PBcWWRcgS7NkclXkpwwNZT8Dh0RtUou1i6u4roUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107641;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=XPhl5nAJZ01PZ8pIqOHEqDA0GiiMUbdOvpcbcEC79Tk=;
	b=bNZCSdAWZjHd1toNwJ5jIXBjutsoFMUSZ4IELiRKZKXZ572L1mOcQ8aP52FRDjR0049f
	 k5c2kxy6g4dazsZD4Vg2PEOAE9JYhYUlFsy3xsjFoNkjihzzHtweJX4efFqWTbGETwznm
	 54b9YBVCOPEXAL9rx7X5KJzdNndPHVwdKxf4DyaLZ1GfkWiVtfNH3jNopSB6xrAx2KF49
	 btVaOcuqQdsBKm4yaheLnzdquLIFzIZm2x7GdVO2UWDgf90UKyUplOCmO33bUn9Eh5V79
	 nWg+OcjGm/c0lCZOI380K/fDVjxkQLEzEt0kdV0l+GPgZrTDYadsfADO+shz+NfYWlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZW8ZvckB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A6E606A31B;
	Tue, 27 Oct 2026 13:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZW8ZvckB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C045A1F01825;
	Tue, 27 Oct 2026 13:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793107640;
	bh=XPhl5nAJZ01PZ8pIqOHEqDA0GiiMUbdOvpcbcEC79Tk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZW8ZvckBIuhZsnT4fpJsTn4/Hz3bk28vHTe+4HCuOWflZVbVN1jF3sc8N7lnHK881
	 +VVQP8MA1CaTP/Meht3G9X7Jevm3Qnz73/ugNpIP/Hif99zxrJiB4kw7D7RCJxuku2
	 ubGzeWyejakF9Xe/lrsPIObVgEmdDXFa4JtWfnEvtDnuknKllIdfisQmcgItLvHq+M
	 OJbZggxIlWF4mf0UtVqPFoej5o1/fYnagV2KAwyfN0lRL2UBXYRRQsOEKrGQ0qoqC6
	 SxwkshJp2HYEY7cB8zu7BauvnmpPm1k/rTVI9vLo3/wd5Zg2+c7ReshWr+iPyVnoDl
	 7aS8/smFkjbtQ==
Message-ID: <74d45c5a-1815-44f0-890d-c847f84c0a57@kernel.org>
Date: Tue, 27 Oct 2026 14:27:09 +0100
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
To: Baolin Wang <baolin.wang@linux.alibaba.com>,
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
 <de90d124-03f6-4657-a467-71ab3d441212@linux.alibaba.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <de90d124-03f6-4657-a467-71ab3d441212@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/27/26 14:20, Baolin Wang wrote:
> 
> 
> On 10/27/26 9:03 PM, David Hildenbrand (Arm) wrote:
>> Hi,
>>
>> see v1 for details. TL;DR various fixes.
>>
>> I now rebased on top of mm-stable (thanks Zi!) and retested with
>> Gregory's tests (thanks!). Thanks everyone for the fast review!
>>
>> When sending this upstream there will be one conflict with the following
>> upstream commit:
>>
>>     737362c7012a ("fs: port ->set_acl() to pass const mnt_idmap")
>>
>> Which should get resolved through something like
>>
>> diff --git a/mm/shmem.c b/mm/shmem.c
>> --- a/mm/shmem.c
>> +++ b/mm/shmem.c
>> @@
>> -static int shmem_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
>> +static int shmem_set_acl(const struct mnt_idmap *idmap, struct dentry *dentry,
>>           struct posix_acl *acl, int type)
>>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>> Changes in v2:
>> - Rebased on mm-stable
>>   - Fixup shmem_set_acl() compilation issue after rebase
>>   - Dropped: "mm/shmem: avoid moving the truncation start backwards"
>>   - Fixed up: "mm/shmem: stop retrying folios that cannot be split"
>> - In "hugetlbfs: enforce F_SEAL_EXEC in setattr", check for S_ISREG
>> - Smaller patch description fixups
>> - Picked up tags
>> - Link to v1: https://patch.msgid.link/20261026-fixes_shmem-
>> v1-0-703206d5fa0c@kernel.org
> 
> why drop this fix "mm/shmem: hold off eviction in shmem_writeout()" from v2?
> 
> https://lore.kernel.org/all/20261026-fixes_shmem-v1-6-703206d5fa0c@kernel.org/#t

Because I'm stupid and dropped two commit instead of one :(

-- 
Cheers,

David
