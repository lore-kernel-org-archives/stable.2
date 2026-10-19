Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CC345D5F3;
	Mon, 19 Oct 2026 06:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393132; cv=none; b=VWPhLvC6TvPP2FHFYaYz1STTIkNuQ8lq0f49BTDQ3rxIOyqk3f8FcTZ9e+kBtehhwWh9kpwJUMbzGlLAtJYoNLjRJww1UZSBOmm94EFILY9Kp/Rv2+82zRG0bOtjOqErWr+vx9kJ5ZiYFRR4q/w7kwj1ih9NSwtG9erIOfYevEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393132; c=relaxed/simple;
	bh=jKcRI0F9aHnlKD651grREaBBW4xvRcUMzBlgAiHKlsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jNoSbcnDSqx9p0XaDDnR0Ma+kki1ccqM6vWlqmvE6RChURg462fokF9RBzzuSq1B3YHOgpb2HUIkMBcmasEMCxQEAFw1Bw/hC3zKOghNnnM68I5PcaOjkFqaMnpn6PWCHkHnUTgSoqdJu933oolU8Qb5urwb6/6xL8/X+3TkBYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=StlLDKq4; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="StlLDKq4"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F4841477;
	Sun, 18 Oct 2026 23:58:46 -0700 (PDT)
Received: from [10.164.148.56] (MacBook-Pro-3.blr.arm.com [10.164.148.56])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 514DC3F673;
	Sun, 18 Oct 2026 23:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792393129; bh=jKcRI0F9aHnlKD651grREaBBW4xvRcUMzBlgAiHKlsU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=StlLDKq4P1yblYmcNUL/S2ln1AqLeYYRPcJPR+/GUUMAOs1w3CfSJYbdyEfSHULs+
	 yNXPO49brP9+UjPFeg1bY6f39wNxEV9GIf+ejuiDxy5qXrhRH/cH9ROgchLpwdaLtX
	 AYklqgynUtNpXJDDuA7feuEpCmp7LhrGsihDk9Ms=
Message-ID: <4aa14b41-9b89-494c-8825-55fffd5a541c@arm.com>
Date: Mon, 19 Oct 2026 12:28:40 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] mm: page_alloc: make defrag_mode retries follow the
 promoted order
To: Kiryl Shutsemau <kas@kernel.org>,
 "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc: Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Harry Yoo <harry@kernel.org>,
 Usama Arif <usama.arif@linux.dev>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Brendan Jackman <brendan.jackman@linux.dev>,
 Zi Yan <ziy@nvidia.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 kernel-team@meta.com
References: <20261009125503.126202-1-kas@kernel.org>
 <15a9e03e-c748-4e51-b8cc-583a3610c897@kernel.org>
 <20261012192834.6934ef85444dee4a60d6d876@linux-foundation.org>
 <as5q14OsbK2CmOrh@thinkstation> <20261014202936.GC371161@cmpxchg.org>
 <78238103-3a7f-432c-b1df-bd14d7cf4bb1@kernel.org>
 <atDMN5MoGrwJNpAj@thinkstation>
Content-Language: en-US
From: Dev Jain <dev.jain@arm.com>
In-Reply-To: <atDMN5MoGrwJNpAj@thinkstation>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15/10/26 6:25 pm, Kiryl Shutsemau wrote:
> On Thu, Oct 15, 2026 at 09:16:36AM +0200, Vlastimil Babka (SUSE) wrote:
>>> And agree 7.4-rc1 with CC stable is fine. Sadly, not sure if anyone
>>> but Meta is using the feature right now.
>>
>> I thought it was there for a long time but it was only added in 2025 :) At
>> least the enterprise world is slow to adopt things, AFAICS.
> 
> I was thinking to propose a patch after merge window to make defrag_mode
> default. Do you think it is too early? I don't think it is ever going
> to be truly stabilized without wider exposure.

AFAIU defrag mode is not going to improve mTHP allocation success.

I ran a synthetic benchmark faulting in lots of 64k mTHP with swap enabled,
defrag mode caused me to enter a warn_alloc (and 8 times more compact_stalls),
which didn't happen without defrag.

So perhaps bundle the default with pageblock_order eagerness etc.


> 
> We also discussed with Johannes to make a stricter (defrag_mode=2?) mode
> that will not give up on fragmentation ever, but OOM instead.



> 

