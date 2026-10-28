Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793170946;
	b=LMb9uKIxlWcn+pwEwpDYbF1v74OAv3RPd/ql1hJAcOSvPb3s54nKCCJ5MSt2wcmhqNYv
	 kSaLSjqEHctb9ri3+0SAEoksa8o4YxcK7mK8hG7IDbvqI43O7kalWgmScwhWZcgrqU19f
	 oBwq/JiqfLkyqRhPRb8Aln19368hBOjVzx++K1Jv5nUppDC/KzmLsXH9itQ45XTh/lbq+
	 0AiNh01ul4Zli0ptP88pZIPPrBUElAK6c9wwccWS3j1xVJgi6D16C693aXScovmLUxbtS
	 tpRCc9KxeGTMQsV6z7al4ZiUWvoebOj1UCb5SHPl5cLt+oaxrNk7VJlqtJ1kQyY7hsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793170946;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=YqMDWZaaRapM5JJzBgdWWKkQQCkL8Mdt/SJ2Z6FiaTw=;
	b=fA7n787cnIyTrUatSsUWvbmLYACuzPozAkG391PeTVGV7KN23I4UWzYjvhrZYzQclacC
	 UH5wcEqdopI12ncVObV7+5udqdU7pGsbpvqtXkDBZm3lsEkGxHIPaVdtUqt0BH/2Zd5Rk
	 LIWBK1TrCg3ZPNrEnowri43jIqRwsQuugxN6giJBruY53DP9yKilEfhiJC2XNJTBZu5xe
	 OATKGjJTdzgyImeoz+lbQdVYab8x1++RV/VxHecHzPqLcTSJR2YR3yH0wYvyEDcLbxpVE
	 zEEvMeqp2Q86ZxCMhIUCAcRlc9LT6dpKGfu/iw0kZCUf0Rua4SyN+wA1s/zpx0uSo2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MbaoWJUv;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A7E9606A31A;
	Wed, 28 Oct 2026 07:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A7E9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=MbaoWJUv
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29D7B1756;
	Wed, 28 Oct 2026 00:02:20 -0700 (PDT)
Received: from [10.163.164.200] (unknown [10.163.164.200])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 496EB3F673;
	Wed, 28 Oct 2026 00:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793170943; bh=pHcA5AF4V+BVk2kWzI92VbLUecJ8ewRtrlSehqaLj/s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MbaoWJUvhJDQbHFVrjpOxDE3CyORMGTd3NpdK/61gpkc0W6MuOUM+EZjeoqpLLM74
	 wiHQ91S+/66UxUQoh8QNkfwPgxgFta+DxLovi1npFjhDzue2RFhZH16rMP77tXmAd9
	 WLBbYQsnwaWmIv5l3Tz5js3XaGuXuNUGXp6hND18=
Message-ID: <adc41db6-16b7-449c-b883-8b093309db8c@arm.com>
Date: Wed, 28 Oct 2026 12:32:14 +0530
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
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the
 promoted order
To: Kiryl Shutsemau <kas@kernel.org>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Harry Yoo <harry@kernel.org>,
 Usama Arif <usama.arif@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>,
 Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel-team@meta.com
References: <20261014202936.GC371161@cmpxchg.org>
 <78238103-3a7f-432c-b1df-bd14d7cf4bb1@kernel.org>
 <atDMN5MoGrwJNpAj@thinkstation>
 <4aa14b41-9b89-494c-8825-55fffd5a541c@arm.com>
 <atiCG2iPrHwDznSZ@thinkstation>
 <d2b8edf0-39ab-4a44-bd0d-58230dee2fad@arm.com>
 <ats7oFM-fsYdUS8y@thinkstation> <attOFXch_TchIfEv@thinkstation>
 <atty0n4UzTfI46eN@thinkstation>
 <0757f1b0-9af6-417c-a4cb-eff0b05ba277@arm.com>
 <auCDnqJc7fsBpUW2@thinkstation>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <auCDnqJc7fsBpUW2@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/10/26 4:30 pm, Kiryl Shutsemau wrote:
> On Tue, Oct 27, 2026 at 12:42:12PM +0530, Dev Jain wrote:
>>
>>
>> On 23/10/26 8:16 pm, Kiryl Shutsemau wrote:
>>> On Fri, Oct 23, 2026 at 01:12:02PM +0100, Kiryl Shutsemau wrote:
>>>> The diff below replaces the previous one. It needs cleanup and splitting
>>>> before it goes upstream.
>>>
>>> Proper patchset:
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/kas/linux.git page_alloc/nofrag-watermark-v1
>>>
>>
>> Thanks! I applied the 3 commits on top and the results improved a lot. Your patches
>> make sense to me.
> 
> Thanks for testing.
> 
> Can I use your Tested-by?

Sure! Do Cc me whenever you send. I'll try reviewing if I am not on vacation : )


> 
>> But still, I see more compact_stalls and a worse compaction success:fail ratio. The
>> limitation must be by definition I believe: we still won't be able to use 64K blocks
>> from non-movable pageblocks.
> 
> Right, that is by design.
> 
> defrag_mode keeps the free space in unmovable and reclaimable blocks for
> those allocations, so they don't spill into movable blocks. Your 64K
> faults never take it.
> 
> The price is that defrag_mode needs more free memory for the same
> workload. In return, the system does not fragment over time: huge page
> availability stays steady instead of decaying under load.

Right.


> 
> The benchmark runs right at the edge: it fills 99% of MemAvailable and
> then faults another 20% in 64K. defrag_mode=0 takes the 64K chunks it
> finds in non-movable blocks without compacting. defrag_mode=1 has to
> build them inside movable blocks, and with memory full there is little
> free space there. So more compaction, and more of it fails.
> 
> The 64K fault count ends up close anyway: 20.1k vs 20.7k in my runs.

Yep, the issue is that Android folks may complain - they observe increased power
consumption due to reclaim stalls and compaction stalls and would like to
minimize them.

I would really want to see defrag_mode become the default since it attacks
the major cause of fragmentation nicely, but the assumption is that compaction
is a free resource, unfortunately on smaller devices that's not the case.



