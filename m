Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901378;
	b=W5VrykZlKEAcL9t7h/HD0KjJRK6tRxXwR+MW7+WJGohSBUydNVQfVLJdvKZKCDpCGvIu
	 teu4cp+fMrqEzXNCDwImZ0xif4TMcyCtC0Hy7tlg9VMeB3V16EFS8hJGHv5WqjEHzxGG1
	 mKekUZLkJKRRjTkQyxh+vczfMEcMZhV5VpOuhT0Os7uLn/SmsfmDb3Uzt1ZU9EKsuFpNg
	 Zt3MFWi4+TJdkAhL6ingzE8s4iD1HKQToI4mgNwqehZ9inQGDn786kaSGGHMEEk6+QSgf
	 I6hoAung/dBAV8ZYLBeGuP/r9t85YECSMxyJo8erzQN40qBt/b7qQnpp9eJZbGFeyKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901378;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=c9l3GCx27vWCzWprqBUpZF8ewdrrLXW/RA/zgGEtIsE=;
	b=yt1Za/0GsSisYlvhOTDNFyWxdXFcfdpb2by2gKM1JbQnd4ruC+TyHCPGKTuaeEtAqSbB
	 WZYiK5suDJCxdsUqPYTpYBmZ3NvsvErPaWEQQnp52rT4HH9y2r+i6nyWw3LdTfcpTvcol
	 Y+8dej2RCybqVZ2otqqbeEjW0pURZiHqud+y2aqyLLhSlb+0N4JFBY/cYN4HEEmSzikQP
	 eEr2Oo7YZi5lsNGd3CI5Zbk28kmyIhpBYorGg82TjsFDtWpprX2mEdW3OiKhup3lo2dOP
	 35lqMHyBYJpByMjt07xrllNbkm07IA3D/OEAe8CTq/+5pl1xEhoQcWTHIpscHB7syVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vhGOx06M;
	arc=none smtp.remote-ip=95.215.58.123
Received: from mta1.migadu.com (out-123.mta1.migadu.com [95.215.58.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD8B606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:56:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BD8B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=vhGOx06M
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FaUkFUcHuP3BiesPQYnJEtWy77nW5jWOpPkoZ46/VDg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793901375; v=1; x=1794506175;
 b=vhGOx06MUin+6IT6RcCDaNLs8FswwfRHcwxD5UprIwZuWACBn7FcbOWvYCWI2TIF8g6AonrQ
 NMbTaSfvKz5Iindtkfj8xEC/yfkjvLYXKrkB9ctLXnPvdSPA8t1EmnaiRLrUiVP8DQ6gPebHuPX
 kBVV1UCzbhXmbH2kHiP+952Q=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id bb547c92f083d415;
	Thu, 05 Nov 2026 17:56:15 +0000
X-Mizu-Trace-ID: bb547c92f083d415
X-Migadu-Flow: FLOW_OUT
Message-ID: <53ee72a4-a5f7-4a7d-8a0a-fc3fc8804d75@linux.dev>
Date: Thu, 5 Nov 2026 09:56:07 -0800
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
Subject: Re: [PATCH 1/2] tracing: fgraph: Raise FTRACE_RETSTACK_ALLOC_SIZE to
 1024
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, mhiramat@kernel.org,
 mark.rutland@arm.com, mathieu.desnoyers@efficios.com, andrii@kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org
References: <20260922225526.1554758-1-vineet.gupta@linux.dev>
 <20260922225526.1554758-2-vineet.gupta@linux.dev>
 <20260924100040.GD4121339@noisy.programming.kicks-ass.net>
 <1e223334-b371-487b-a60a-7f1f5c007f7e@linux.dev>
 <20261105122648.67abbe1d@gandalf.local.home>
From: Vineet Gupta <vineet.gupta@linux.dev>
Content-Language: en-US
In-Reply-To: <20261105122648.67abbe1d@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/5/26 9:26 AM, Steven Rostedt wrote:
> On Fri, 25 Sep 2026 12:32:49 -0700
> Vineet Gupta <vineet.gupta@linux.dev> wrote:
>
>> For submission, would you take this up as reported-by me or do you
>> prefer I send a v2 (your authorship and SoB etc) ? No big deal either
>> ways just not sure what the std operating procedure is and nuances of
>> all the tags etc.
> Please implement Peter's suggestion and send a v2 with the tags:
>
> Link: https://lore.kernel.org/all/20260924100040.GD4121339@noisy.programming.kicks-ass.net/
> Suggested-by: Peter Zijlstra <peterz@infradead.org>

I think you have some catching up to do still :-)
This is v1, we are currently at v4 [1] with Peter's suggestion and 
further split up for ease of backport and use of new rcu_scope 
constructs as suggested by Masami san. It has been Acked by Andrii [2] 
and Alexei [3]

Thx,
-Vineet

[1] 
https://lore.kernel.org/bpf/20261021174406.2891598-1-vineet.gupta@linux.dev/
[2] 
https://lore.kernel.org/bpf/CAEf4BzaTYgNwiBtvYoSw1wzuFZchs-2CCP93gh2OeDt-919-eQ@mail.gmail.com/
[3] https://lore.kernel.org/bpf/DMAUS3F32198.M27YWDF2F3UV@gmail.com/
