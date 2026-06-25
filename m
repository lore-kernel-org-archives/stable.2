Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D67D36EAAC;
	Thu, 25 Jun 2026 08:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782374980; cv=none; b=hdO9Lwq1u8RpMOrpKzhIEe3Ns82+oTD3PqLBK3PqThRcTHsE6lYZ2FVtcbypJoW3gA4gcQ8F0AUriEVxsPEsLcHL7Wyg8mpioT75CfA2UPSTfSba4CowlrzL/3lgvpIm2ys8dZDyDmYsQ8/W6qUvGT6tIAhH9ZPSfQ0mxrnS0T4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782374980; c=relaxed/simple;
	bh=TtyfEpLlqD92FVCQKlxN0X7ES36Ti+2+2Vp4DlDpeG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R/J7W7Ompokgg6rovN84pNTUl71GoQPQWnT1sMQM+6qpaqvURWTZtrKz4ckuh7ATGY1ouUjsB36YpLQe5JCDpzEttwWZcZpXtgn8GZs5WtZuca+9pXGMNdsZDLQC3wy9rZUSKtUOM7egpRFaaq5jxrRBy3L5AWYglEjc1u83Lho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=EyBO9TfR; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="EyBO9TfR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1782374958;
	bh=zyJK8B23oxGHn172N926QO3i+pQ6Sz0c3dJ9gVTZyOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=EyBO9TfRmX/s/GKviJb7EXvGh9whAN3Lv8p9krFRQxHkYaEV/V5NwiQKht4/5j06m
	 e+TCFpgztUjnI9jLTeyd6oW1ny/SsY5ft63Y+YLY0OThbufR2Eq20b4m+uk69A739x
	 6N2Lwa609ivdfBH7FW7aZt0GXzMTYxbqi36OlaYY=
X-QQ-mid: esmtpgz16t1782374951t0fff7946
X-QQ-Originating-IP: wulmzFysRr/NFb0J+WJZNEgu27wUdpLE0vGLc97S6cQ=
Received: from [172.27.139.54] ( [218.94.142.77])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 25 Jun 2026 16:09:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16784617416225829723
Message-ID: <3B3C2386FB8D946D+d8adcbe7-ccca-44ea-8298-3dffaec3826a@smail.nju.edu.cn>
Date: Thu, 25 Jun 2026 16:09:08 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] mm: mglru: fix stale batch updates after memcg
 reparenting
To: Qi Zheng <qi.zheng@linux.dev>, Harry Yoo <harry@kernel.org>,
 akpm@linux-foundation.org, david@kernel.org, kasong@tencent.com,
 shakeel.butt@linux.dev, baohua@kernel.org, axelrasmussen@google.com,
 yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org,
 muchun.song@linux.dev, mhocko@kernel.org, roman.gushchin@linux.dev,
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
 <f18bf1b1-ccf7-4d77-9389-07311d2d1613@linux.dev>
 <1d78e1c1-0cdb-435e-b278-670bce9148b3@kernel.org>
 <1db11ccc-ae05-4b26-b360-c34ac9f97299@linux.dev>
Content-Language: en-US
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
In-Reply-To: <1db11ccc-ae05-4b26-b360-c34ac9f97299@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MNDKt/jCy+CfXU/aCSj6peOTCWVzMlVUabqmtXJWGFdsPP0RXigG1Tne
	HQdojlJP2UuovMYIuhBn5Fo1mpQb7FxWVeslVBQ7Ax2/fNfqfE7YnOaPprnRfhxc09kEB3K
	RA9ua1Ezkc6NFJJmL/VX4d2PlcWYJ8Q6qYCwpVbonXJOUZtyx/3dhbuvrQnSkkzByc8dMdo
	cDhBt83wVl2FdTlVkQAGyRMuXiOOKoZwgmDVyou7rCNq0+WH6vXPVpmqyk3GmTes25eZEsa
	EwMdZDIDp1k7Tc7oWSWXe8RCjNAI3w0DKnjueleGCjxbW72yMm8/JrvVt0oopSpMXMwUfX6
	JvYt5VTl49xUIXfDFpt7UWYtBXW66jFekw4nRTjw6lf3vnP5uUV2/Ns7YBXWkmpwoY1i1EM
	Ec1Hy43DRMoHS/oBGPc2VB3LeMxzkDW+70ZV6wH9t5a4fOqEka7bbdokYzHxwogIeIa+I+6
	zKLFiDeScuVwJSvzwUQ/B/iTQ6Cq6yT9MQw4Co2IfW00hup5kmZ8oyinMQW42LZaAPrSBxb
	DfhvC3sSnEqHcC5LV5x0tS1JBnREMtRvVZAxkmgYNNLo0nKGLNS8EBm8dF3j3lPebSnjYQ1
	2dpfpEiYK49cEGPXam2a9nuLT4xEPJgnKtigZKNL2fmwfKr+NwTd6tWiHNlBc1KWvX1ljuJ
	We7rICxz0nXKJ5Lnzld529GvbHyRj0AvSHS6MBB/2uvv9/y2P+rKFjp/a1eKn+Fz50FMkoE
	Ngh7cjOdnF6WUi+T7KXWbtbB/GU6wLJ7StxH8+sWtM6iN12UW1zGNZePTQOD4cKgzAxE3Ok
	mJGsy2PrZbIjSfl7PG6ICXOumJ3XzwZQq+9c3IaRIKkSOffre4zt52jNlPfT7maQM5gI54i
	sta6Zdw4aUFjn4yuowmQ8BSxGkQeBBf2LYIPXxgMJKnWgOtXzeQbKCIQKxQ/8VV67WF7qUm
	9+yfSQ9Z/hXYKx9NoQHY3iInVrIQuRRtfY5yxxjCW8qCLUacLpMT0Ae4BJV8jhH6re7IfC2
	ugjfIhmE3dmtlcEGmhZKPX+BODbFqXHtC7Hp+fSGvpfu/xuaJHIXG/Q4AAZFrot088kALwq
	qmOixE+aSJ9HQuKxEMxRktHEtV0AGKmNskl69v4u2Sw
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0



On 2026/6/25 15:37, Qi Zheng wrote:
> 
> 
> On 6/25/26 2:32 PM, Harry Yoo wrote:
>>
>>
>> On 6/25/26 3:11 PM, Qi Zheng wrote:
>>> On 6/25/26 12:16 PM, Harry Yoo wrote:
>>>>
>>> [...]
>>>
>>>>
>>>>> So lock_batch_lruvec() can be implemented like this:
>>>>>
>>>>> #ifdef CONFIG_MEMCG
>>>>> static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
>>>>> {
>>>>>       struct pglist_data *pgdat = lruvec_pgdat(lruvec);
>>>>>       struct mem_cgroup *memcg = lruvec_memcg(lruvec);
>>>>>
>>>>>       rcu_read_lock();
>>>>>
>>>>>       /*
>>>>>        * The memcg can be NULL when the memory controller is disabled.
>>>>>        * Otherwise, the caller keeps the memcg owning @lruvec alive.
>>>>>        */
>>>>>       if (!memcg || !css_is_dying(&memcg->css))
>>>>>           goto lock;
>>>>>
>>>>>       do {
>>>>>           memcg = parent_mem_cgroup(memcg);
>>>>>       } while (memcg && css_is_dying(&memcg->css));
>>>>>       lruvec = mem_cgroup_lruvec(memcg, pgdat);
>>>>>
>>>>> lock:
>>>>>       spin_lock_irq(&lruvec->lru_lock);
>>>>>
>>>>>       return lruvec;
>>>>> }
>>>>> #else
>>>>> static struct lruvec *lock_batch_lruvec(struct lruvec *lruvec)
>>>>> {
>>>>>       lruvec_lock_irq(lruvec);
>>>>>
>>>>>       return lruvec;
>>>>> }
>>>>> #endif
>>>>>
>>>>> Does this make sense?
>>>>
>>>> Yes, looks good to me!
>>>
>>> OK, this sync method makes more sense as it doesn't require adding a
>>> new lrugen->reparente. I'll go with this method and update v3.
>>
>> Thanks!
>>
>> Just one thing to clarify...
>>
>> So, when we check something that's updated _before_ grace period
>> (CSS_DYING), RCU is sufficient.
>>
>> But in folio_lruvec_lock*(), that is not the case because reparenting
>> is performed in the RCU work, under the lruvec lock. So the check needs
>> to be done under RCU and the lruvec lock.
>>
>> This is quite subtle :D
> 
> Indeed.
> 
> And in theory, the l->nr_items check in lock_list_lru_of_memcg() could
> also be replaced by the CSS_DYING check.
> 
>>
>>> Hi Barry and Baolin, what do you think? Since the sync method has been
>>> changed, I will temporarily drop your previous Reviewed-by tags in v3. ;)
>>
>> And hopefully Peiyang would kindly double check v3 still not reproduced
>> on the machine :)
> 
> Yeah!
No problem! I can help test v3.> 
>>
> 
> 


