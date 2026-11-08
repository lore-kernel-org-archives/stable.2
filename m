Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794179548;
	b=nyEZd7iu9Rs09TyyWEwtcLULLl/AbMQ3l1v4TkADIubEhwS4l8l91lazRYafrZgbPFeW
	 stODBlEi+2sPfAh4WVrBH1vNq5BzvpLojF/ALgA697q2LOsfhokR3t/uMjh1nNkGMj7FL
	 UieCXzYRKSzMatFRcZx6NBqoglWun9UzP/doKiLxzEIHeNGfRSFafqJb8yFf7Ml4U3lfP
	 CONyrBnwK3BGkdrgH/Vy1lR6FMtTFiOFTf5WXGXMXtUeojWqQmhM2rsGa8+yKhuCo7A9l
	 VxqwTNhksLxPeQVGgF+Y/7SBYuE3LZFwQ2xyF7/g0ObKziMHtwry+R5bjmz6OhexYWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794179548;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=CXQaE7qbV7eGxhp+28lFx0wX6wKu8htmvAmFNqL4VzI=;
	b=S8+Ay9cGzb3LGECkrYu9IkDKOtTOFsl5Lzuz+3jG8MGOxBNxOX3Esvf0VGytDHt6lQbi
	 9iWhLVflN1lSWxHvKGXn6CbWD0fT4mvS1F8CIW/OD3tqBuOO58mFGDaFxOHOOsC4+L2kP
	 E+SzLTu6PzyOIBFbRhfmMnXx/c3W/cNXzYlutQMrF5hTEL4msC2LwSg0vzkB1T6BNx5Ch
	 no8uWXhhyZuMHuqRNQ92E0dGG9YKhYLU5gKw8YHlXOykBQM8is7KEW+c38HdKcc6KfdtC
	 Gkru5YK2vtWRwdSbnegAHQZOtriin2WKXVC9aEOkI8knLjy9YBudgI15nBTHzH4VW5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kabVYj7f;
	arc=none smtp.remote-ip=91.218.175.180
Received: from mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001EA606A322
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 23:12:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 001EA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=kabVYj7f
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=uBz62HipOUpV8FMMhhDpcgo86aJTWb6jnbXPRjMq07s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794179545; v=1; x=1794784345;
 b=kabVYj7f+Qos9Sm9Vyp7fp9IVYV5yDyYpBFxKHYCPkTJNqwE3EcM8BJ4rruyYvK1ERqLg4gV
 hqX7uH2ezGT2urF5eOJZLHUwTi99/WmPdGerwcEMLps50wpwZbFp4IqYzDriOyDF00u019QtkvH
 RBgfu5h4XsSpwGzhf3nEhGEE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c8a84526f0e83049;
	Sun, 08 Nov 2026 23:12:24 +0000
X-Mizu-Trace-ID: c8a84526f0e83049
X-Migadu-Flow: FLOW_OUT
Message-ID: <490eace6-4ad4-418e-8ef5-5abf18bc8c17@linux.dev>
Date: Sun, 8 Nov 2026 15:12:18 -0800
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
Subject: Re: [PATCH v4 1/2] tracing: fgraph: allocate shadow stacks inline
 with GFP_NOWAIT
From: Vineet Gupta <vineet.gupta@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, andrii@kernel.org,
 peterz@infradead.org, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org
References: <20261021174406.2891598-1-vineet.gupta@linux.dev>
 <20261021174406.2891598-2-vineet.gupta@linux.dev>
 <CAEf4BzaTYgNwiBtvYoSw1wzuFZchs-2CCP93gh2OeDt-919-eQ@mail.gmail.com>
 <20261023143816.48163575@gandalf.local.home>
 <75b66acc-354e-4cd2-b9cb-4c22e8a02635@linux.dev>
 <20261023180902.2bf7cef4@gandalf.local.home>
 <88f41f2c-4226-4122-9627-4fc29a29b99b@linux.dev>
Content-Language: en-US
In-Reply-To: <88f41f2c-4226-4122-9627-4fc29a29b99b@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/26 3:25 PM, Vineet Gupta wrote:
> On 10/23/26 3:09 PM, Steven Rostedt wrote:
>> On Fri, 23 Oct 2026 13:13:41 -0700
>> Vineet Gupta <vineet.gupta@linux.dev> wrote:
>>
>>> On 10/23/26 11:38 AM, Steven Rostedt wrote:
>>>> On Fri, 23 Oct 2026 11:13:44 -0700
>>>> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>>>>    
>>>>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>>>>
>>>>> I presume this will go through Masami and Steven's tree, is that right?
>>>> Yes, but it came in during the merge window, and since it's just a speed up
>>>> and not fixing something that's broken, I was going to let this go in the
>>>> next merge window. I rather have a change like this sit through a full -rc
>>>> release.
>>> It is a speed up but not for optimization sake but to cure rcu stalls in
>>> production at Meta. IMHO it should go in sooner than wait a full release
>>> cycle.
>>>
>> Either way, I'd like to give it a bit more testing first. That is, the
>> earliest it will go is after -rc1.
> That's fair.

ping !
