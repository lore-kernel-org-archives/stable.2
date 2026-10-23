Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792765829;
	b=D5M6IwjRyLOR0t+KkUYiNUCl3QkdXdasT0tC/DmPEHY7siVdl3XUbpnQKmFmLpLi7nv+
	 vVPyTGs0LcJhF4fdwdAyMjU2RHO0kbb8T73tnALBQu8bVVEIK5yA3f/VzoBPqZkBonX+j
	 rnGJ496wVL7eIRwBF5pd6ebtFFcaC5IOI5v1yVk9QnXj5ZDgARH/Y01logogbIBifjb4g
	 zSbh8M7dc2cEVTHqctsFesIycLJnp17NbuqgQV0G5f9eLnBVujT/Wi4WosDV7HNzj/hpL
	 8xc7p0Y6fzCNm7UWEdttfl+LM9ihUt9z11KDmciiDEGiUT4xj4Jq4fyzkXFd9mOIhdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792765829;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=q19RkNdvdKZfvvzc83oRnTfA/45ChJc0dIPYMhstJII=;
	b=H7w9gHayXa6czxaCF6E04oUIzaXcx6E5/0euWcVaPjbyrgKfT4A0WzNPBmNDAspLgNeU
	 lH4LMRrupKu8j720/esh8hBBo4IA8cE0QuasEO1rR9peWddXrHag78KmJALX+vZaFu7Sg
	 1J5tRTvZ5yQ0ZXoiALuhGz4S6pTPnWWSJIqgVdB7etT2XLlcxKLhlO7ZBw05+xQ4uw5lO
	 V4WUu/BqFBz6wXmLOI9OpGJ0dn+zywuwqxFcWjVrQdjhjRIddIv9WZFTYXjgmWEBb1lih
	 tuEoFmV0bXQLQdNxGYz/yeK1ZCI/MKuzx5KE9oNHVBHw03VkMgyQStgCQzJwDyC7BNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k3pjAgHg;
	arc=none smtp.remote-ip=91.218.175.180
Received: from mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C4C606A31A
	for <stable@vger.kernel.org>; Fri, 23 Oct 2026 14:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27C4C606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=k3pjAgHg
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QkcatS4DUjgzNkAwRB16tzNFXXT1nPzIZUkqpGpZ14s=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792765821; v=1; x=1793370621;
 b=k3pjAgHgYsLIRxQBcdFSer+LE5OnuGJ3OE5BOl84/3/RIHVIYsitCwGCmxV6HltaC/xYc0v8
 WbajW2iIx8mHJvzF5hJB/k5no1yfZ3XY2a8pmfKtQOg9KYHFIaaSBSxyDGAJpxHegpx0Ly5B9tI
 fUmS/izzsyfyDh16XE3i5Ej4=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e015806712496f69;
	Fri, 23 Oct 2026 14:30:20 +0000
X-Mizu-Trace-ID: e015806712496f69
X-Migadu-Flow: FLOW_OUT
Message-ID: <50b46cec-9f95-42dd-8e97-5555897df4c3@linux.dev>
Date: Fri, 23 Oct 2026 22:30:03 +0800
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
Subject: Re: [PATCH net 5/5] net: restrict message_cost and message_burst to
 non-negative values
To: Fernando Fernandez Mancera <fmancera@suse.de>,
 Joel Granados <joel.granados@kernel.org>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Wyatt Feng <bronzed_45_vested@icloud.com>, Yung Chih Su
 <yuuchihsu@gmail.com>, Hannes Frederic Sowa <hannes@stressinduktion.org>,
 Flavio Leitner <fbl@redhat.com>, Petr Mladek <pmladek@suse.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, linux-kernel@vger.kernel.org
References: <20261023091419.167088-1-jiayuan.chen@linux.dev>
 <20261023091419.167088-6-jiayuan.chen@linux.dev> <attQGnJGhzTPFsMd@hobbes>
 <27876dee-435f-4ea7-afed-69f8366e1c62@suse.de>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <27876dee-435f-4ea7-afed-69f8366e1c62@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/23/26 8:55 PM, Fernando Fernandez Mancera wrote:
[...]
>>>   #ifdef CONFIG_BPF_JIT
>>>   static int proc_dointvec_minmax_bpf_enable(const struct ctl_table 
>>> *table, int write,
>>>                          void *buffer, size_t *lenp,
>>> @@ -544,14 +560,15 @@ static struct ctl_table net_core_table[] = {
>>>           .data        = &net_ratelimit_state.interval,
>>>           .maxlen        = sizeof(int),
>>>           .mode        = 0644,
>>> -        .proc_handler    = proc_dointvec_jiffies,
>>> +        .proc_handler    = proc_do_message_cost,
>>>       },
>>>       {
>>>           .procname    = "message_burst",
>>>           .data        = &net_ratelimit_state.burst,
>>>           .maxlen        = sizeof(int),
>>>           .mode        = 0644,
>>> -        .proc_handler    = proc_dointvec,
>>> +        .proc_handler    = proc_dointvec_minmax,
>>> +        .extra1        = SYSCTL_ZERO,
>>>       },
>>>   #ifdef CONFIG_RPS
>>>       {
>>> -- 
>>> 2.43.0
>>>
>>
>> I would prefer something like this [1] (not tested and not compiled).
>> This is more in line with the patterns inside the jiffies.c file. I put
>> SYSCTL_ZERO there, but I have a doubt if you actually need SYSCTL_ONE.
>>

Thanks Joel and Fernando, good to hear this.

I actually had almost the same proc_dointvec_jiffies_minmax() locally at 
first,

but then thought "this touches sysctl core, better not" and went with 
the local handler
instead.

Glad I was wrong about that :)


>> If the interval variable can be zero, then leave it as SYSCTL_ZERO, but
>> if it cant be zero and can be one the use SYSCTL_ONE
>>
>
> FWIW, I also like this solution and indeed we can convert other users 
> in the future.
>
> About SYSCTL_ZERO, I believe it is the right choice. AFAIU, it just 
> disables limiting.
>

Agreed on SYSCTL_ZERO. interval == 0 is the documented "never limit"
case in ___ratelimit(), so it has to stay allowed.


> Thanks,
> Fernando.
>
