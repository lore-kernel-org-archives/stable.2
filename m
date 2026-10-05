Received: from mta1.migadu.com (out-49.mta1.migadu.com [95.215.58.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB2E3F927A
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791211017; cv=none; b=NEmMqVy/GxgGNG9HqirAiz4R6LhBkczz0Az4D7uNQ3gYW91OD8BhDjnOWZ2ZShBglLYMEx+YNNR1x0hAYRcc/ZnvUEC2rlPrXnTmKKMH563Bb59hJ+jC+TCYWJwK4zyUQcEGVewKBNLyuKQy5nO3aJl4Skk46ihDKh7sD/1WldQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791211017; c=relaxed/simple;
	bh=F9by0ha0YQK0T/c0DHTwYvhzhlGXnVnEdgz0tUOz0JM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j+8DH3el+CkCDiSts4YV0dE7PYasgh2/tQE4XPtrdFHLN+DeGvK85nY5eZi9KjmMsaF0sAuw5HyFCjbLtxuqq9+a4ALLTsm5fBD/HhgqFP7A+kASxSQEgaK5Qu45cIeVw+TtLAxgNYCOlcLjJxWUXNOOgROOx5UxwJuwLuNfMdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=r8Y3d/2t; arc=none smtp.client-ip=95.215.58.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="r8Y3d/2t"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=F9by0ha0YQK0T/c0DHTwYvhzhlGXnVnEdgz0tUOz0JM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791211006; v=1; x=1791815806;
 b=r8Y3d/2tMptWxAOP35SYvkYzFgJtbLlxH9J+ZqwvEuWk8cRnrzsQ8zrqILyhOjE/qZn7VyAp
 b2y4Q/MgYEU2N/t1TMxgei6oaYMZWXcIFAhtUT0qMB8xQx4GkPYfljqAuYJN+mhuRJA18QUAf0k
 MiGcocgfBrYxJtFe1jit0fzk=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 16f5694261043640;
	Mon, 05 Oct 2026 14:36:45 +0000
X-Mizu-Trace-ID: 16f5694261043640
X-Migadu-Flow: FLOW_OUT
Message-ID: <de41b083-6368-429e-9928-90aa5440f750@linux.dev>
Date: Mon, 5 Oct 2026 22:36:26 +0800
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
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20261005142216.GAasOymJHYnmn6wD5m@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/5 22:22, Borislav Petkov wrote:
> On Mon, Oct 05, 2026 at 06:12:45PM +0800, Lance Yang wrote:
>> Which CPU? None so far. As I said, I don't have a reproducer. I'm trying
>> to make sense of what the manual says and what the code does ...
> 
> So you're sending a patch for which you have absolutely no justification? And
> CCing it to stable too?
> 
> And that patch hasn't been tested to actually address anything?
> 
> Just a wild hunch?
> 
> I wouldn't do that in the future if I were you.
> 
> HTH.

I don't have an AMD machine to test this on. I spotted something
that looked wrong in the code and sent it out to see what others
think.

Maybe I'm reading the manual wrong, but is raising a concern
based on the code and the manual really just "a wild hunch"?
