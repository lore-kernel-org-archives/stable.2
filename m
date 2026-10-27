Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.111
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088056;
	b=INVUUhFXhtec4pGcf2PsyIJZFzPx777NRL2qOHJmdBkxAIqDDSaLY1LkUgY8zoxpTV7h
	 dvQP8QJL6j7AWEC0Uod8RIRQY2LdG6vxzQBJCU6ZqJVBA8i0To5GTl8Xjfu7ZNEXOqsV+
	 uTAf5brz8rdV32vfFsCymJMSrf00O8G6tzq4AmDVf0fuIB/R/7eUa9iao5Y0JJyBbu/PT
	 cV8Vo/5qQjZlsrbRTcg+nD6+rCeklMNDSI9+o/kCScVZ+75NXRoQG/CCDaHZ19WXWSVwt
	 nKJ9FtPmE10GvEngZxe4es9hvnwWjaT70iI29s3egk7Ehme695fQRiBp/7qkCNLKGQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088056;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=OsqTgxlY/BA/8uomt0D4CyUz1chRyWUiTmuMkAfTR+I=;
	b=nXDKlF4mfQV2vuK2ZcuP6/mS4D0rUfLwgEUNj0JnXAl96Dic0Szkw9quHyWd/NBbHHhL
	 PndivAjQGALWOLwO38M2BW5cJeXB3fcJjL4qwBOBivqKzW34TkQWb1/qpr6fwMb1zioVd
	 LeqFT1p9P/mY/IV2GXhUfYqpo6Ffn0YcZ2BVknvjzTzn/hGLU0UtoeEK4QrXWPdV4HNuC
	 VIyY1/VRqXBvYU+6b/300UXaMXFo5dPLnOkfZC1/zEYDS5v3U3v0s1DuT0dCcEM1Schb1
	 c7QS8RseLwZ6TOes0N8uR+3vDwMR5X0ccXskLbkb06EFYKjamHS7peBREax5COATOCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dzTXcVP1;
	arc=none smtp.remote-ip=115.124.30.111
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17167606A31B;
	Tue, 27 Oct 2026 08:00:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 17167606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=dzTXcVP1
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793088045; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=OsqTgxlY/BA/8uomt0D4CyUz1chRyWUiTmuMkAfTR+I=;
	b=dzTXcVP1Fz/2P6CFq7suCZ+FrXlaHMrbMO6UA2DGOefDyEdZusH6MylvZDokWAGwaiGsovArpkqiaXhOh+yqdwOYwCqI0lhfX/b9/PZgQhO6xgCweaxMQoOqf7iEGeu2QpJUJ+Klpo5MCa31a/vhvuV4yXvoWhsdCH2+3NK5kvM=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=30;SR=0;TI=SMTPD_---0XDd63M7_1793088039;
Received: from 30.74.144.191(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0XDd63M7_1793088039 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 16:00:42 +0800
Message-ID: <68e7521d-6645-48cc-9e4b-f2c8f1159312@linux.alibaba.com>
Date: Tue, 27 Oct 2026 16:00:39 +0800
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
Subject: Re: [PATCH 11/16] mm/shmem: rescan after nonuniform folio splitting
To: Zi Yan <ziy@nvidia.com>, "David Hildenbrand (Arm)" <david@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>, Gregory Price
 <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
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
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-11-703206d5fa0c@kernel.org>
 <DMF9OO106FGX.3P7TZUBGHUFII@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <DMF9OO106FGX.3P7TZUBGHUFII@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/27/26 10:32 AM, Zi Yan wrote:
> On Mon Oct 26, 2026 at 5:40 AM EDT, David Hildenbrand (Arm) wrote:
>> The final scan in shmem_undo_range() restarts after a successful split
>> only if the original folio is no longer large. A nonuniform split can
>> leave that folio large, so the scan skips the newly created folios.
>> Hole punching then leaves pages within the hole allocated even though
>> they could be discarded.
>>
>> For example, a fault below the hole can allocate a 2 MiB folio after
>> boundary handling. Punching a 1 MiB hole at offset 64 KiB splits the
>> folio successfully but leaves the original folio at order 4. The scan
>> continues past all 512 pages, leaving 2 MiB allocated instead of 1 MiB.
>> The hole reads as zero, but the pages and their block charges remain.
>>
> 
> 
>> Restart when the original folio is still in the mapping after partial
>> truncation, identified by checking folio->mapping. If the helper
>> removed the whole folio, no rescan is needed.
> 
> This paragraph is no longer needed after Zhang Yi's truncate fix, since
> truncate_inode_partial_folio() returns true only if the folio is split.
> The function returns false when the whole folio is truncated[1].
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/tree/mm/truncate.c?h=mm-stable#n282
> 
>>
>> Fixes: 7460b470a131f ("mm/truncate: use folio_split() in truncate operation")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>   mm/shmem.c | 11 ++++-------
>>   1 file changed, 4 insertions(+), 7 deletions(-)
>>
> 
> folio->mapping check is dropped and the comment is adjusted after the
> patch is rebased on top of mm-stable because of the aforementioned
> reason:
> 
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 7cf5a4d9d1ace..ddea31f44fb32 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1477,18 +1477,12 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>   				} else if (truncate_inode_partial_folio(folio,
>   						lstart, lend, NULL, NULL)) {
>   					/*
> -					 * If we split a page, reset the loop so
> -					 * that we pick up the new sub pages.
> -					 * Otherwise the THP was entirely
> -					 * dropped or the target range was
> -					 * zeroed, so just continue the loop as
> -					 * is.
> +					 * The folio was split. Retry the scan
> +					 * to find the split folios.
>   					 */
> -					if (!folio_test_large(folio)) {
> -						folio_unlock(folio);
> -						index = start;
> -						break;
> -					}
> +					folio_unlock(folio);
> +					index = start;
> +					break;
>   				} else {
>   					/*
>   					 * Splitting failed, but the part in the

Thanks for explanation. LGTM.
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
