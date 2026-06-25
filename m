Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000333BED1E
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 06:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782367907; cv=none; b=EvqlRuJrmyamQnyS7WP6LqVjkcuk1i6QZ6e9EnyCVfZKLqPLUNJ7pSIO6fAwZ2+JKWTeqNDXtDGIAGmIt7wAwQjLfWORLs4rEyOcFGGFSQ9lO+3/n13x3r4Uqc8yvZN6uDC+spMKfF6roRvOBpI/0CR466I54Qg8VJGN37YZ3g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782367907; c=relaxed/simple;
	bh=WgQRdI0Kdq7aEnVKb9c7OASS4yeb0qoaPNVU8f06+4Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z2w+4hnqPBuunNkxzUMBoOSm6jrMd3EWAjlTd2SkO/wVBEpNxEMIVLM/pGMgU75qC/8r6hIG5xLg8ecf6LsD4XjuclCpJn3orkC0XHVDnFCRbvtB4UnOBaUZKp2kVZw8ukDdWyMAuLOUrDeoNhVFX+Gj4MbhuY2UCUscHmVkj8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=iPGBHwrr; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="iPGBHwrr"
Message-ID: <f18bf1b1-ccf7-4d77-9389-07311d2d1613@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782367902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xUSTBB1mth+fzw/4QWCYM0WAsrU6UvEDP/rElXqwnzw=;
	b=iPGBHwrrH9Djk0Ix8CjAt1/PVSBSALGaCFIEyhK2JpKUjjK5oqL4Kvv49azNzeQj1p7opV
	AvvGRxc4A7tCrGXQeM9eUrYiqoM4c3Oxf9OY2OwHdnLR5DDX1qI4+bWRL0tkPtH6eDuH9m
	urj5++hBAxg8aHMFtF4rsCCPvANwrXM=
Date: Thu, 25 Jun 2026 14:11:22 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Harry Yoo <harry@kernel.org>, akpm@linux-foundation.org,
 david@kernel.org, kasong@tencent.com, shakeel.butt@linux.dev,
 baohua@kernel.org, axelrasmussen@google.com, yuanchu@google.com,
 weixugc@google.com, hannes@cmpxchg.org, muchun.song@linux.dev,
 peiyang_he@smail.nju.edu.cn, mhocko@kernel.org, roman.gushchin@linux.dev,
 ljs@kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, stable@vger.kernel.org
References: <20260623024237.45990-1-qi.zheng@linux.dev>
 <e74b0808-3bcc-414d-a037-41e479210cc0@kernel.org>
 <d97128c0-7d89-4b5c-b891-84f9af702fee@linux.dev>
 <8a76aefd-629c-41f3-b365-aefd4cc1411e@kernel.org>
 <7946da94-dc1d-4cf2-986e-466c378665b6@linux.dev>
 <dfe5d773-2992-448b-a6cb-ef633714a08f@kernel.org>
 <1d638906-6d64-4e57-a181-4b77683652b5@linux.dev>
 <b5c85cea-5daa-4690-ac41-a6f5aebd1555@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <b5c85cea-5daa-4690-ac41-a6f5aebd1555@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 6/25/26 12:16 PM, Harry Yoo wrote:
> 

[...]

> 
>> So lock_batch_lruvec() can be implemented like this:
>>
>> #ifdef CONFIG_MEMCG
>> static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
>> {
>>      struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>>      struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>>
>>      rcu_read_lock();
>>
>>      /*
>>       * The memcg can be NULL when the memory controller is disabled.
>>       * Otherwise, the caller keeps the memcg owning @lruvec alive.
>>       */
>>      if (!memcg || !css_is_dying(&memcg->css))
>>          goto lock;
>>
>>      do {
>>          memcg = parent_mem_cgroup(memcg);
>>      } while (memcg && css_is_dying(&memcg->css));
>>      lruvec = mem_cgroup_lruvec(memcg, pgdat);
>>
>> lock:
>>      spin_lock_irq(&lruvec->lru_lock);
>>
>>      return lruvec;
>> }
>> #else
>> static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
>> {
>>      lruvec_lock_irq(lruvec);
>>
>>      return lruvec;
>> }
>> #endif
>>
>> Does this make sense?
> 
> Yes, looks good to me!

OK, this sync method makes more sense as it doesn't require adding a
new lrugen->reparente. I'll go with this method and update v3.

Hi Barry and Baolin, what do you think? Since the sync method has been
changed, I will temporarily drop your previous Reviewed-by tags in v3. ;)

Thanks,
Qi

> 

