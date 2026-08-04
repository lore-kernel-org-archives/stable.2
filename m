Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 950B3486BA9
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785863116; cv=none; b=PzoGJl5kd/b0gWZi8Q04cOuvQgu6A5/e110515aQmbvGGdMEjiZTpynRBXiV5XqeJbZ1QRPLr/L0XGRcuE4tXJUP+213INxJqObjcdDFe6+eMqCDbALkPG2NR3b1C2etMDVI8OQybW1DyFoO3Oi4ee6gyLO0dP5RcYTlrHpVA6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785863116; c=relaxed/simple;
	bh=IIPV+uK9RzIxM4qreYDUAaEKrit9xi6m9STGo+r87Q0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OI9LlR+G6BBcWqrifo4ByW6P6uIWGeU6J8LUb7yGkHbjrUEoJH18jU5IUo+TZZSTbxtkk8H4TAxvFkIRhMc55EpalzaL0/4SYCgWfimUJkYazfcqlUG86UWc2Nryc8kR3o1YR9gswsqeX2AuRff7LxzTe6iHeE+OmVeu8ndjiuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhk5V3wk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhk5V3wk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8721F000E9;
	Tue,  4 Aug 2026 17:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785863107;
	bh=YDEfVs0Bi8dTQeWZgvTkiOBxm/ntA3Pj+qKWpGUZhAA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nhk5V3wkrUDVAWtxPRfrQm3EDSC20ZGWnFbzLCdVbKHLe/kjkLcRVxXiLC/fpqmuT
	 s6oz3TO5LyY54d2/8z3wG2yq1YsXkfUjM7RBP/waiT3/rOvVyIZtbC1EaHLzgih/JQ
	 gCk5ghpFp3q4QJF1UfpTsjMr2MPiKTxtMnVsaUSGQCThWNj03urvT1yTYKe/FFSYOq
	 y8yn1/WasyUfVRfZ65K/xeWPp2lS1Uhrk9AV4iczW2Zub9+WHrkObkv6unPBpqWPr/
	 HeAJHGLUqzCJroT6mK1il32ogZzOLpWkj5eSi/upLIwHqTyE8sJtp2+KRKyZDhia0k
	 NPoyi3CVzMuBA==
Message-ID: <556894de-2e06-424b-9414-36fb0ecd9657@kernel.org>
Date: Tue, 4 Aug 2026 19:05:02 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix incorrect flush address in direct page table reclaim
To: Andy Lutomirski <luto@amacapital.net>
Cc: Qi Zheng <qi.zheng@linux.dev>, luto@kernel.org, linux-mm@kvack.org,
 Liam Howlett <liam.howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
References: <3d3aa670-76bc-4df3-9c36-609c14354e9e@kernel.org>
 <0B39A63B-3697-4FEC-B6FF-2F4D5901F7E9@amacapital.net>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <0B39A63B-3697-4FEC-B6FF-2F4D5901F7E9@amacapital.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/4/26 15:43, Andy Lutomirski wrote:
> 
>> On Aug 4, 2026, at 2:34 AM, David Hildenbrand (Arm) <david@kernel.org> wrote:
>>
>> ﻿On 8/4/26 11:25, Qi Zheng wrote:
>>>
>>>
>>>
>>> We backported the PT_RECLAIM to our internal tree a while ago (excluding
>>> the rework patch being fixed here), and it has been running stably ever
>>> since.
>>
>> I'm wondering whether we should have a selftest that triggers this exact scenario:
>>
>> (a) Populate page table(s)
>> (b) MADV_DONTNEED to reclaim the page table(s)
>> (c) Allocate plenty of pages for another purpose (draining PCP where the page
>>    table likely ended up) and fill them with some data that looks like present page
>>    table entries.
>> (d) Re-access the reclaimed VA space, expecting re-population of anonymous
>>    pages.
>>
> 
> If you want a better chance of hitting this bug, you could try:
> 
> - First DONTNEED the range in multiple calls so none of them reclaim the table.

Not required. If MADV_DONTNEED spans the full page table we always reclaim if it
is empty after MADV_DONTNEED (there are some oddities around uffd-wp handling,
which wouldn't apply here).

> 
> - Then PREFETCH the range (or use your favorite speculative read gadget or even do a real read and ignore the signal).  Maybe also do this from multiple CPUs.
> 

Not sure if that's required, but if that's required to trigger it that certainly
makes it less elegant.

> - Trigger reclaim

Also not sure if that one would really help.

> 
> Then do c and d.
> 
> The result might be so specialized that it would be of dubious value.
> 

Right, if we cannot easily trigger it then it's way to special.

-- 
Cheers,

David
