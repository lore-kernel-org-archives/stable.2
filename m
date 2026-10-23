Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794345;
	b=hBoYgB+u8JU7lb0+gxRXRTjoiAReFsuGMy9w2ObRFCisu1NrtWO8l2hlq2qqadljGUKp
	 ZSXw5ABW6rj/3HtsXtrYBG2YYDMWWXKllww7tg7IQABsGhGbUdkbuIZKlGQ12Cnt+20VO
	 3eo+JllPXJV5pY3W8aLligrMQIsvFuLjFaQ9xV6es4Toitvom7CRh/eUY/SVwrYbo6ESR
	 2GfkM9cGYuNHOOJRciYOOxp29L/4erWxf3rNJGIcQW68fZF3+ief4TeEhfcYzyZI3HDAs
	 M4DCfI4KTStFL1kQFiPBgBqeGoJCHVZuJ1kC+rUKzj99TjUWzbQdUau0Pk9/hBdzoPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794345;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=ZW4f/bR0z9X+iXbSmnF3Tp6NyBRkbBWJTCRV7Fj2AnU=;
	b=MoQR+rlESY+yWsqwFcx5/DRBSnTMd6vdThoq5IpdVb6SYwRJaoZbvBF2kJHTNbRQLDyH
	 JBBJL6aOm+PHkkbI4/u07tOxAsYudxdrCaL8qznMeWJ1xQf2tKB3pA84YBYTTojyK9lfx
	 UIDK6TwS3QThmCTOwgsFWJlJ4W4lAIiGSD4ebq8rLcdLOpF1+F5K00zULyx/mDqUJdDZE
	 L0Avpe+EriNfhVHmC61D4X8auaIH4cQAWNhJGxiUMbPzmRoAbzS4/eYFGAvyDgxAzGqsf
	 wCD9wi6YPJkDYknat1CMwg/dTlOF3ZeK2VnN09AZYq8DFDgaMc7tMw7hOQKgb9rh2cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b="P/lDtrff";
	arc=none smtp.remote-ip=95.215.58.98
Received: from mta1.migadu.com (out-98.mta1.migadu.com [95.215.58.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF730606A31D
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 22:25:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF730606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=P/lDtrff
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=u2RfliYPbv+3w6elZKzr8CHYPnDNw3MYZtq8+QF/6MI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792794341; v=1; x=1793399141;
 b=P/lDtrffUrzzLvqruj7aLeNYurvmbTFl4CckgrCjD5s7Jf+X63XXt8oSvG6cHXFuNqIA6Fwd
 UgFZifqJmUUTcmYMvd+1XCOJZJLOhon/26JixWxWPVay1KRdunENsZ8okZo9KgK4v7b24kOU1vU
 qxBuc00zEy8ZkI2PbAmv3H3o=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id aee3234f182cf0bb;
	Fri, 23 Oct 2026 22:25:41 +0000
X-Mizu-Trace-ID: aee3234f182cf0bb
X-Migadu-Flow: FLOW_OUT
Message-ID: <88f41f2c-4226-4122-9627-4fc29a29b99b@linux.dev>
Date: Fri, 23 Oct 2026 15:25:33 -0700
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
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20261023180902.2bf7cef4@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/26 3:09 PM, Steven Rostedt wrote:
> On Fri, 23 Oct 2026 13:13:41 -0700
> Vineet Gupta <vineet.gupta@linux.dev> wrote:
>
>> On 10/23/26 11:38 AM, Steven Rostedt wrote:
>>> On Fri, 23 Oct 2026 11:13:44 -0700
>>> Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
>>>   
>>>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
>>>>
>>>> I presume this will go through Masami and Steven's tree, is that right?
>>> Yes, but it came in during the merge window, and since it's just a speed up
>>> and not fixing something that's broken, I was going to let this go in the
>>> next merge window. I rather have a change like this sit through a full -rc
>>> release.
>> It is a speed up but not for optimization sake but to cure rcu stalls in
>> production at Meta. IMHO it should go in sooner than wait a full release
>> cycle.
>>
> Either way, I'd like to give it a bit more testing first. That is, the
> earliest it will go is after -rc1.

That's fair.

Thx,
-Vineet
