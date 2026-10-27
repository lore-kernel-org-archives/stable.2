Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793096034;
	b=FthpSAszuLK14MzjTqK5jEnCkX41pGMmlrQFTRK52lkuIawVhSaAoMAR9wVt5P8kmnYU
	 ZIh3V31fQE6EA5hK1aguFbPDXSIjSJRSM/bmijc1MbCMpZLc5DOMyfSVD01qJMvjgqVQz
	 jNoZ/yh51tmN0zA66vXVoRmc/dHE1SSPoAubw59uAF6eh+TDa7kr+T+iDX1whjzDz7Vzk
	 KXyLFdVfy6JHXObVSG1eDcwo2r0PlkDP3HgYZX+3GWKILXmnPesW5SdQF5iNPpQidAX5a
	 sYs0qjQKvOlia2Z4oPjPjytWhQyS++lL3KYlV25o9WG2iIgTMIWY3EwESoqVDetH1+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793096034;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=VcjnV7QS2G+aidrtUKihb76qyh+JC3b0hokomy9CWtI=;
	b=DKoJbd0yAiZBHFcaGXKPKG1HIikgmsU1htZE3DqXlE4qE+1+2h+NKOEMT5XAOeMGfQSp
	 qx0aYbwVVShcn4KEmFh/3IoX+JWi2pAOMKNAYOnKnCPCH8yLD8Q7dGvzyGBAr//6jGdnb
	 RjzNYdpudfGCakZnfVDr2jHHzUCi4wX+HLmcVF+qsJ6ivfTTSPCDq+XOo9rLaaRWUxFIP
	 tyXmQ+567lQ+HvNQIPsGRPTDdoJME6Se4iUS8vsga1MV+t5OpQPYLykD8C+2ZqqKlM8d/
	 UWBuJF2VTiGlU4GeYBdzMOCsA22jNn+DqdIAp2MesPpbkOVeiv6dRQVIUG5ODstzxyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwnkNvoo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283C3606A31A;
	Tue, 27 Oct 2026 10:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UwnkNvoo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B261F01825;
	Tue, 27 Oct 2026 10:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793096033;
	bh=VcjnV7QS2G+aidrtUKihb76qyh+JC3b0hokomy9CWtI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=UwnkNvoos1ek2AkU4HMF6xMMIsDgOXZGtVXxowwR/TRjQw2QGKWFVBS9ZULzArNQM
	 vKjbhEVbAE3XPTSOdy8+zQwqfOB/4dPDOtAjgwfFuR+DqJwgHcwlxraumzkxaHA2ib
	 Va2JKy62cNXxS5F+0zUgxeVYwzpiDA2KcmRzwRB7TU2ZGdFjSlpkYuldKxpsncjev3
	 VX99o6PmXSBPUsXfoGoG2H1a1zhRt2weS+QJK9agGdCjnbHxq7Z4JjPoHfP4VxU7MW
	 OUTqfd8SpKL3+WjGAgmochCxIqilm+wXLSmTgUwZQGbAORhAlqKbDbjxETH1txy4HI
	 +owiB3GFSMiyg==
Message-ID: <b45a3b54-2b96-4325-a0a3-508ba0227c16@kernel.org>
Date: Tue, 27 Oct 2026 11:03:24 +0100
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
Subject: Re: [PATCH 08/16] mm/shmem: stop retrying folios that cannot be split
To: Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
 Gregory Price <gourry@gourry.net>, Joshua Hahn <joshua.hahnjy@gmail.com>,
 Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Vladimir Davydov <vdavydov.dev@gmail.com>, Michal Hocko <mhocko@suse.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Lukas Czerner <lczerner@redhat.com>,
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
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-8-703206d5fa0c@kernel.org>
 <DMF8FVCUYJ5X.215YGBLZ7H56Y@nvidia.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <DMF8FVCUYJ5X.215YGBLZ7H56Y@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/26 02:34, Zi Yan wrote:
> On Mon Oct 26, 2026 at 5:40 AM EDT, David Hildenbrand (Arm) wrote:
>> From: Chris Mason <mason@kernel.org>
>>
>> A fault or collapse can insert a large folio crossing EOF after
>> shmem_undo_range() has handled the boundary folios. If splitting that
>> folio fails, truncate_inode_partial_folio() retains it when it is dirty.
>> The final scan then repeatedly finds it because it restarts from an
>> unchanged start.
>>
>> Truncation keeps the inode lock and ignores fatal signals while looping.
>> A concurrent unlink() can then block other directory operations while
>> holding the directory lock and waiting for the file's lock.
>>
>> Advance start past the retained folio, whose truncated part has already
>> been zeroed. Do not move start backwards if the failed split has shrunk
>> the folio.
>>
>> Fix generated by an LLM and sent by Chris Mason in private.
>>
>> Fixes: 55ac8bbe358b ("mm/shmem: fix race in shmem_undo_range w/THP")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chris Mason <mason@kernel.org>
>> [ david: split fixes, simplify descriptions, adjust comments ]
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  mm/shmem.c | 8 ++++++++
>>  1 file changed, 8 insertions(+)
>>
> 
> I rebased your patch on mm-stable, which has Zhang Yi's fix, and
> 1. tweaked the comment,
> 2. skipped the dropped folio (this is to avoid a narrow case below).
> 
> Since after Zhang Yi's patchset, truncate_inode_partial_folio() is
> changed to return false when it drops the entire folio. Restetting
> start for a dropped folio in the scenario below would leave zeroed
> folios still in the memory, causing a waste, although it is very narrow:
> 
> folio A=[0, 512), B=[512, 1024), C=[1024, 1536],
> 
> 1. A, B and, C are inserted after the same_folio block check, so only the
>    code at whole_folios label sees all of them,
> 2. A is split partially and the split failed, A becomes [0, 32) and
>    [32, 512) zeroed,
>    truncate_inode_partial_folio() returns false, start is set to 32,
> 3. B is dropped entirely, false is returned, start is set to 1024,
> 4. C is split successfully
> 
> After 4, index is start=1024. The [32, 512) folio is not dropped. That
> is why I added the folio->mapping check to avoid changing start in 3.
> 
> 
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index fadf23f9e21ed..efd54a624974c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1480,6 +1480,16 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
>  						index = start;
>  						break;
>  					}
> +				} else {
> +					/*
> +					 * Splitting failed, but the part in the
> +					 * range is already zeroed. If the folio
> +					 * was not dropped, skip it when
> +					 * restarting the scan to avoid retrying
> +					 * it forever.
> +					 */
> +					if (folio->mapping)
> +						start = max(start, folio_next_index(folio));
>  				}
>  			}
>  			folio_unlock(folio);
> 
> 

Thanks, makes my life a lot easier!

I'll change that to an effective:

diff --git a/mm/shmem.c b/mm/shmem.c
index 1a81f6dca7510..c263f02fe07cf 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1481,6 +1481,15 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, uoff_t lend,
                                                index = start;
                                                break;
                                        }
+                               } else if (folio->mapping) {
+                                       /*
+                                        * Splitting failed, but the part in the
+                                        * range is already zeroed. The folio
+                                        * was not dropped, so skip it when
+                                        * restarting the scan to avoid retrying
+                                        * it forever.
+                                        */
+                                       start = max(start, folio_next_index(folio));
                                }
                        }

-- 
Cheers,

David
