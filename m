Received: from mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7DD296BA9
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212353; cv=none; b=KtocntSfIihmUzFpimPF1rQIBiKs79aFjumqMVVuZvdYhB2jNMH2ihYJIYeqoAtOfx4jl9lQKD9Ox2ON0MZBGAhU1AacWLllZTMW/alh83AvRDCbnIakuEn3bqZvyRnxh+xGZn3ztakhOVKftguxHmUgFj4lRlVQIajMk1+h5KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212353; c=relaxed/simple;
	bh=sjluPKWYfXjAFZOlS3RybtthbiIfsFMylOb79mxumII=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qDD8La4XXIAD4MHB4vWp1Zhw9fvh3BhJokVnxzfE8PJ2Tujc7VYXvk8snwRDlFigLlPq60TMBY2VU4ckJRF+MAMHF6yQGgUEbcutS5o9xBg1n11d8XKuOnnYo+M5+V8W0/EvGMFMxsfP13W/ErG2QL/LEeEfVEKh1Cq6fNPqQnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=O8oxLrRe; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="O8oxLrRe"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=sjluPKWYfXjAFZOlS3RybtthbiIfsFMylOb79mxumII=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791212349; v=1; x=1791817149;
 b=O8oxLrReTSLDu+Z76neS4/JkLodm7FAW2gZRctdVrX/+lQoDA6ybypXYcOlheBTAuJbrvih1
 jHl6iZf8K4Ox5SuLQa/YE5QsRpYZgNVI6FJzgbqVpeBpWnLXD9AYP0/ln3bHyrzUD6gVC/c/ZgC
 m+o9OZZdrAOOdgRkncu5NQOg=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 93dd8002214013a1;
	Mon, 05 Oct 2026 14:59:08 +0000
X-Mizu-Trace-ID: 93dd8002214013a1
X-Migadu-Flow: FLOW_OUT
Message-ID: <0a0f7ae5-5fa0-430c-8074-9217f594a563@linux.dev>
Date: Mon, 5 Oct 2026 22:58:52 +0800
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
To: Borislav Petkov <bp@alien8.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>,
 Pedro Falcato <pfalcato@suse.de>, dave.hansen@linux.intel.com,
 luto@kernel.org, peterz@infradead.org, tglx@kernel.org, mingo@redhat.com,
 x86@kernel.org, hpa@zytor.com, riel@surriel.com,
 linux-kernel@vger.kernel.org, qi.zheng@linux.dev, nadav.amit@gmail.com,
 thomas.lendacky@amd.com, kernel-team@meta.com, linux-mm@kvack.org,
 akpm@linux-foundation.org, brendan.jackman@linux.dev, jannh@google.com,
 mhklinux@outlook.com, Manali.Shukla@amd.com, mingo@kernel.org,
 stable@vger.kernel.org, toshi.kani@hpe.com, david@kernel.org,
 mikhail.v.gavrilov@gmail.com
References: <20261005052302.43042-1-lance.yang@linux.dev>
 <asM7b8ECO34-jiwi@pedro-suse.tail5790ac.ts.net>
 <60d5db86-8002-4d87-b8d3-c161d674122b@linux.dev>
 <ab077b6a-160f-41a2-a167-813f0560e30d@citrix.com>
 <38541ec6-d796-4f35-a700-75ab097b6df5@linux.dev>
 <7ad90e94-d04d-453a-ba22-9640a5024d8c@citrix.com>
 <6801221a-6307-407a-85fc-46906f95d22e@linux.dev>
 <20261005142216.GAasOymJHYnmn6wD5m@fat_crate.local>
 <de41b083-6368-429e-9928-90aa5440f750@linux.dev>
 <20261005145315.GCasO523MWyIIx2ngl@fat_crate.local>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20261005145315.GCasO523MWyIIx2ngl@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/5 22:53, Borislav Petkov wrote:
> On Mon, Oct 05, 2026 at 10:36:26PM +0800, Lance Yang wrote:
>> I don't have an AMD machine to test this on. I spotted something
>> that looked wrong in the code and sent it out to see what others
>> think.
> 
> You send a normal mail - not a patch.
>   
>> Maybe I'm reading the manual wrong, but is raising a concern
>> based on the code and the manual really just "a wild hunch"?
> 
> If it is formulated like a patch which is supposed to be even urgent, then
> you're reading our process wrong.
> 
> https://docs.kernel.org/process/development-process.html
> 
> And since you have not tested it to actually fix anything, then this patch is
> nothing but a wild hunch.
> 
> And to answer your question, no, it is not needed. Definitely not the TCE
> angle.
> 
> Now, the speculative thing is another story but that whole story you're
> referring to needs a lot more debugging.
> 
> But we do not apply patches on a wild hunch, without any definitive data that
> they fix an issue and, if very much possible, with a clear explanation why
> they fix it.

OK, let's drop the patch.
