Received: from mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3098D15AADA
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791214619; cv=none; b=CnMf3mPKJAh8N6A0XCBt5BhIMZEsv2xQp6OY7KPKtPqdUDF7B/RcC6fb8vm3niCe3xjwS1qH9vBuadxqr9bxB5xyPX1Ka+b2OEl7IW061Ldhqs+hy0MGQp5KB1wQ8NWvMT7At4hjXzQRG/Ooa85l1A8ohJYZIXKJQox32JUKyRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791214619; c=relaxed/simple;
	bh=5zX+01E1uYtcKNTedIU5E0EoruaCd2DT0fqXgC7ia5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g53awaYdlieY7ngJEkLyvrKwKoNz5C/LNtnbtkD7xOC584RuGaX4GsFKaAQzpEbWk5GulcHWGmwyyFGcQFcy/YkVp+arFkyij847L8PdRiljKUK3GSd76WJ9ew/yIdN2n+A+W5irfVjsX0ThJ5+J2bodKB7Vi4gwEWL8zcfSVZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QoEIM2Ha; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QoEIM2Ha"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=5zX+01E1uYtcKNTedIU5E0EoruaCd2DT0fqXgC7ia5I=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791214615; v=1; x=1791819415;
 b=QoEIM2HaXyPtk7CN494dWenrpWjsWWgEMg+swUH9vkjcn2co6GeBCNw8Ph6nj8SvPT9DDQzg
 KOULzsPzjm5jNf5CQjkZv2FLUVjTpabtBq3Cl3Yl78+V6HkS+GE7HCDuEHsooEYsxrHW/KwSo8w
 325ie3y0MOYH9BNQaciGz8lE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8941f7e82ec68c72;
	Mon, 05 Oct 2026 15:36:55 +0000
X-Mizu-Trace-ID: 8941f7e82ec68c72
X-Migadu-Flow: FLOW_OUT
Message-ID: <6ad07601-eeef-4fe6-9758-f6936a3bff41@linux.dev>
Date: Mon, 5 Oct 2026 23:36:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/mm: fix incomplete page-table invalidation with
 TCE
Content-Language: en-US
To: Andrew Cooper <andrew.cooper3@citrix.com>,
 Pedro Falcato <pfalcato@suse.de>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
 tglx@kernel.org, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
 hpa@zytor.com, riel@surriel.com, linux-kernel@vger.kernel.org,
 qi.zheng@linux.dev, nadav.amit@gmail.com, thomas.lendacky@amd.com,
 kernel-team@meta.com, linux-mm@kvack.org, akpm@linux-foundation.org,
 brendan.jackman@linux.dev, jannh@google.com, mhklinux@outlook.com,
 Manali.Shukla@amd.com, mingo@kernel.org, stable@vger.kernel.org,
 toshi.kani@hpe.com, david@kernel.org, mikhail.v.gavrilov@gmail.com
References: <20261005052302.43042-1-lance.yang@linux.dev>
 <asM7b8ECO34-jiwi@pedro-suse.tail5790ac.ts.net>
 <60d5db86-8002-4d87-b8d3-c161d674122b@linux.dev>
 <ab077b6a-160f-41a2-a167-813f0560e30d@citrix.com>
 <38541ec6-d796-4f35-a700-75ab097b6df5@linux.dev>
 <7ad90e94-d04d-453a-ba22-9640a5024d8c@citrix.com>
 <6801221a-6307-407a-85fc-46906f95d22e@linux.dev>
 <9459bab2-b373-4008-8f3d-f84b62db5b67@citrix.com>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <9459bab2-b373-4008-8f3d-f84b62db5b67@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2026/10/5 23:22, Andrew Cooper wrote:
> On 05/10/2026 11:12 am, Lance Yang wrote:
>> On 2026/10/5 17:57, Andrew Cooper wrote:
>>> On 05/10/2026 9:32 am, Lance Yang wrote:
>>>> On 2026/10/5 16:19, Andrew Cooper wrote:
>>>>> On 05/10/2026 8:29 am, Lance Yang wrote:
>>>>>>>
>>>>>>> Did you repro any bug related to this? The functionality is perhaps
>>>>>>> underspecified in the AMD manual.
>>>>>>
>>>>>> TBH, I don't have a reproducer yet. Just LLM stumbled upon this while
>>>>>> I was investigating another memory corruption issue [1].
>>>>>>
>>>>>> [1]
>>>>>> https://lore.kernel.org/linux-mm/arY1Wq6R9OY20ans@pcnci.linuxbox.cz/#t
>>>>>>
>>>>>
>>>>> What hardware are you running on?
>>>>>
>>>>> That looks like the Zen5 issue, for which you want either the latest
>>>>> microcode out of linux-firmware and/or
>>>>> https://lore.kernel.org/r/20261002211617.1001617-1-bp@kernel.org
>>>>>
>>>>> TCE is a no-op in Zen1 and later, so unless you're on older
>>>>> hardware, it
>>>>> won't be that.
>>>>
>>>> Just to clarify ... these are two separate issues.
>>>>
>>>> I mentioned [1] only to explain how this came up while investigating
>>>> something else. I'm not claiming that TCE caused the corruption
>>>> reported
>>>> there :)
>>>
>>> Please can you answer the question.  Which CPU are you seeing this on?
>>>
>>
>> Which CPU? None so far. As I said, I don't have a reproducer. I'm trying
>> to make sense of what the manual says and what the code does ...
> 
> I'm afraid that if you're trying to be helpful, you've had entirely the
> opposite effect.
> 
> TLB handling is a complicated topic.  What you've done is present what
> is effectively a query about the AMD manual as if it were a bugfix for
> an critical-sounding issue.  You even sited a real bug-report for an
> actually-critical issue, despite it turning out to have nothing to do
> with your submission.
> 
> The patch is buggy.  For starters, you should be checking is whether TCE
> is enabled, not whether it's available on the system.  This causes the
> more expensive option to use used even when TCE is turned off.
> 
> But, AIUI INVLPG only flushes the whole structure cache because of a
> windows bug which caused it to crash on a 486.  AMD deliberately
> introduced TCE to remove this overhead for every OS which didn't want
> lumbering with a workaround for buggy windows.
> 
> Linux currently believes that it's TLB invalidation algorithm is
> compatible with TCE, so at a bare minimum, you need to have some kind of
> discussion on why you believe this not to be true before claiming that
> it "might be unsafe because the manual says so".
> 
> 
> It's fine to ask a question, and even ask "so shouldn't the code look
> like this?" but such a patch needs a very clear RFC or QUESTION tag.

Thanks for explaining! Lesson learned. I should have made it clear
that this was a question about the manual ...

Let's drop the patch. I'll take another look.

