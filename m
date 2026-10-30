Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793350517;
	b=TTo5HooBRwb6Ys4ZoWmxPkqDx9hZ9/k/e1+dQawVOE2m6XfSxNx1IyGL5XrqtI0oCcid
	 WdmuPoYquUK+UfXXZNK8puqd8zhs69/GeraOjW6vLhILPdNs2sUOzN0bPdws9IaWy9BWf
	 AoC6NjQoyzYkYHivqncNooCiHNfG3cgodWjfmFtldzMgNIlw6vV7U64lZ16FPNlXPooPx
	 9R9xLEQAbsOpqmHu4uTmwvdDmSYvuz0r1CIe0SbN8mpU4+wMoGGnDUYdutz9itVaMb+G+
	 ENWkyz7UCFcP2jLQKvI3DU7r5fuYxO+7UwntnBGKAq6I3jxkoETSKNOLHePyRjYW4gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793350517;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=2ME/YKcQAmqEKXR0yxRYRyIXblEy16rwwZK5YWNyjhA=;
	b=x9nN7tQX/bjGG7wV3+utKyXwX5qF2mCV+bcajESCG0Oi87udBXqdtw5EoxUK1nbR8Q7p
	 GHLnpujMCPNxE5ZyK0am14YAHzJ0m+shr58U0Xo78u1bnN74CzBx9HzMyesypluZXSdIj
	 FaqzwocvmCUBsuBnjS9hsF8GqwLMjCr7vsnKvDAoj9Uu3XyWiL52eUeiqCRRyfONg8kT/
	 kwe+aeeXy+EsnD9DhkOeM2Z3FjICLnNURtNfqAK7n1zgTeSVSxoCOSC14YUmvW7rRyYfM
	 DzemFsHAWkJ+IE+ai4BA2mK2lpLD9FUppx1p6C/BDlzaaWCfyTFjBdew9IgGwck7jVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXll4QP4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5271A606A320;
	Fri, 30 Oct 2026 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CXll4QP4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D61461F000C1;
	Fri, 30 Oct 2026 08:55:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793350517;
	bh=2ME/YKcQAmqEKXR0yxRYRyIXblEy16rwwZK5YWNyjhA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=CXll4QP4+ROaktyPv7RAJz7f+WPuofJbzyw2m4AACejiGVIILiYZq+PxNbpYDu8vd
	 2Dm5iuJ/12bzLkrDS1RdE10rGH6i9HYqGkE0UXGfgzXOzXXE6naiSTFXFT7mi2yMsS
	 a5WNcQ+GTLBcmmRjtarEdx1R8caixrVhQKolICv40IegTz6IRR+SoElmpwOTHyW/q6
	 7Df3TV3klPlzpPUtvCGhWSAq9qOAqVDLWQWzyNS7wv5Qwyy8WwoASqZBNjn4XEEStK
	 CMKfPt8dwsnEchT7An+jO6D/nNxutbcvk8hJ6ADyAH3HF0ZZuRBHVTr7HFOcvGhjm2
	 gDwN1kw1sLmow==
Message-ID: <1e277f4a-87b7-4f5e-8c87-1b2bf280e859@kernel.org>
Date: Fri, 30 Oct 2026 09:54:59 +0100
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
Subject: Re: [PATCH 38/46] mm/ksm: reset the unstable trees of all nodes
To: xu.xin@linux.dev
Cc: akpm@linux-foundation.org, aneesh.kumar@kernel.org, apopple@nvidia.com,
 axelrasmussen@google.com, baohua@kernel.org, baolin.wang@linux.alibaba.com,
 baoquan.he@linux.dev, chengming.zhou@linux.dev, chrisl@kernel.org,
 dev.jain@arm.com, gourry@gourry.net, hannes@cmpxchg.org, harry@kernel.org,
 hughd@google.com, jack@suse.cz, jannh@google.com, jgg@ziepe.ca,
 jhubbard@nvidia.com, josef@toxicpanda.com, joshua.hahnjy@gmail.com,
 kas@kernel.org, kasong@tencent.com, kees@kernel.org,
 kexec@lists.infradead.org, lance.yang@linux.dev, liam@infradead.org,
 linux-arch@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, ljs@kernel.org, matthew.brost@intel.com,
 mhocko@kernel.org, mhocko@suse.com, minchan@kernel.org,
 muchun.song@linux.dev, nico.pache@linux.dev, nphamcs@gmail.com,
 npiggin@gmail.com, osalvador@suse.de, pasha.tatashin@soleen.com,
 peterx@redhat.com, peterz@infradead.org, pfalcato@suse.de,
 pratyush@kernel.org, qi.zheng@linux.dev, rakie.kim@sk.com, riel@surriel.com,
 rppt@kernel.org, ryan.roberts@arm.com, shakeel.butt@linux.dev,
 shikemeng@huaweicloud.com, stable@vger.kernel.org, surenb@google.com,
 usama.arif@linux.dev, vbabka@kernel.org, weixugc@google.com,
 will@kernel.org, willy@infradead.org, ying.huang@linux.alibaba.com,
 youngjun.park@lge.com, yuanchu@google.com, ziy@nvidia.com
References: <20261027-fixes_core-v1-38-6f74bec9a5bb@kernel.org>
 <20261030032409.127393-1-xu.xin@linux.dev>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20261030032409.127393-1-xu.xin@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/30/26 04:24, xu.xin@linux.dev wrote:
>>
>> Let's fix it by tracking in ksm_nr_node_ids the actual number of
>> allocated tree roots.
>>
>> remove_all_stable_nodes() and ksm_check_stable_tree() will now scan
>> more tree roots (skipping the empty ones), which is harmless.
>>
>> Fixes: ef53d16cded7 ("ksm: allocate roots when needed")
>> Cc: stable@vger.kernel.org
>> Reported-by: Josef Bacik <josef@toxicpanda.com>
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  mm/ksm.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/mm/ksm.c b/mm/ksm.c
>> index dbfb8f98b1892..9c51925825cbf 100644
>> --- a/mm/ksm.c
>> +++ b/mm/ksm.c
>> @@ -475,6 +475,7 @@ static void advisor_stop_scan(void)
>>  #ifdef CONFIG_NUMA
>>  /* Zeroed when merging across nodes is not allowed */
>>  static unsigned int ksm_merge_across_nodes = 1;
>> +/* Number of allocated stable and unstable tree roots. */
>>  static int ksm_nr_node_ids = 1;
>>  #else
>>  #define ksm_merge_across_nodes	1U
>> @@ -3636,14 +3637,13 @@ static ssize_t merge_across_nodes_store(struct kobject *kobj,
>>  			else {
>>  				root_stable_tree = buf;
>>  				root_unstable_tree = buf + nr_node_ids;
>> +				ksm_nr_node_ids = nr_node_ids;
>>  				/* Stable tree is empty but not the unstable */
>>  				root_unstable_tree[0] = one_unstable_tree[0];
>>  			}
>>  		}
>> -		if (!err) {
>> +		if (!err)
>>  			ksm_merge_across_nodes = knob;
>> -			ksm_nr_node_ids = knob ? 1 : nr_node_ids;
>> -		}
>>  	}
>>  	mutex_unlock(&ksm_thread_mutex);
>>  
>>
>> -- 
>> 2.43.0
> 

Thanks for the review!

> Looks correct as far as it goes, but I think it is not quite sufficient
> on its own.

I think this fixes the problem described. What you describe below is a mismatch
between documentation and the implementation, but I don't think it is
problematic as in "responsible for BUGS". See below.

> 
> The documentation requires that merge_across_nodes can only be changed
> when there are no KSM shared pages in the system, but
> merge_across_nodes_store() does not enforce this at the sysfs level.
> 
> Should we also reject writes while ksmd is merging? At minimum:
> 
> +	if (ksm_run & KSM_RUN_MERGE)
> +		return -EBUSY;
> 
> Ideally, we should also check that ksm_pages_shared is zero, since
> KSM_RUN_STOP (0) does not guarantee that all pages have been unmerged.

We do that already in merge_across_nodes_store() I think:

if (ksm_pages_shared || remove_all_stable_nodes())
	err = -EBUSY;

Which is really required when swapping trees.

> 
> That would make the interface match the documented sequence and close
> the remaining race window.

Right, either we should adjust documentation or adjust the implementation. Not
sure if restricting the interface is really required. Personally, I'd simply
fixup the documentation (separately) unless there is a real problem with the
implementation when allowing KSM_RUN_MERGE.

(I think there is no problem as we are synchronized on the mutex).

-- 
Cheers,

David
