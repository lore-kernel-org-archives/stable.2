Received: from mta1.migadu.com (out-70.mta1.migadu.com [95.215.58.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBA03CF026
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189150; cv=none; b=hYx/azaAAvcNfOI2Zma1ox9Kf/UxW0I50kZnqy8tIqyJd8KYfp4u5w4e9bWQUyOs47fN5NGHOwLS7DO+1qMjJL8fB8RpsuwYmJhSUa7WQnqttbsuKC2X7hVVznYGHdayyeJZ5FoM1iVtqJMdK0IbeW1h6KvRtbCNYG9FmsEP9SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189150; c=relaxed/simple;
	bh=ZVqDd9QcXqvYOGttGtquLNTksUQ0N7zdBVZm8WxBuns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=he4x7ps4jrbg/EiDKEpPL4R9NqKvnLQmRvHgwTx2l8TZfDXA0cHK/tCFJEaXPVpH2Wd+0YmJ3V8mKGX4NLxG4aVFcZWlboXIlBP3xOks78C7f3PHpk0Oc3C3FLs8nly3eevZ7J4k56SdBz1h8qXAe5fH7drd655/47N1t++/qIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oQ6rdbUH; arc=none smtp.client-ip=95.215.58.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oQ6rdbUH"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZVqDd9QcXqvYOGttGtquLNTksUQ0N7zdBVZm8WxBuns=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791189146; v=1; x=1791793946;
 b=oQ6rdbUHuhSP+4h5cRRL3sBX8z5na8Ci6CGhJuK/EKEZdb1QKW3sGH/PB8MTZ7D2UEHrTDDK
 TO9JikHQpuTKrwBCnHoRNHBOWr17uXf2NpvhoNbfEGNCUTjla+OoNZrcCFSno+RcHVUMADzdV9a
 XTrqpUOEHNGnmAunn60ROhqI=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 73cb7fec8dce91d4;
	Mon, 05 Oct 2026 08:32:25 +0000
X-Mizu-Trace-ID: 73cb7fec8dce91d4
X-Migadu-Flow: FLOW_OUT
Message-ID: <38541ec6-d796-4f35-a700-75ab097b6df5@linux.dev>
Date: Mon, 5 Oct 2026 16:32:10 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] x86/mm: fix incomplete page-table invalidation with
 TCE
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
Content-Language: en-US
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <ab077b6a-160f-41a2-a167-813f0560e30d@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2026/10/5 16:19, Andrew Cooper wrote:
> On 05/10/2026 8:29 am, Lance Yang wrote:
>>>
>>> Did you repro any bug related to this? The functionality is perhaps
>>> underspecified in the AMD manual.
>>
>> TBH, I don't have a reproducer yet. Just LLM stumbled upon this while
>> I was investigating another memory corruption issue [1].
>>
>> [1]
>> https://lore.kernel.org/linux-mm/arY1Wq6R9OY20ans@pcnci.linuxbox.cz/#t
> 
> What hardware are you running on?
> 
> That looks like the Zen5 issue, for which you want either the latest
> microcode out of linux-firmware and/or
> https://lore.kernel.org/r/20261002211617.1001617-1-bp@kernel.org
> 
> TCE is a no-op in Zen1 and later, so unless you're on older hardware, it
> won't be that.

Just to clarify ... these are two separate issues.

I mentioned [1] only to explain how this came up while investigating
something else. I'm not claiming that TCE caused the corruption reported
there :)

