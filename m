Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.126
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793586229;
	b=SOTp1GVhqKAgk6Jki646WfXX5pESsM6NkoJ+WBQw8ZkGaAcL4ksDmCoRxD3YY6n1t93O
	 9alRjs8ly3y15igIpQ+h1S6FEJCoE/ILfa055uYQCpCECa0tBEzndUpUKUAu46jBFF5dO
	 SKi8Nwa5h9KKBLHfeJicm+eXzZwBfo+g6BDb29lN/7I3zCRTFowGVjO+as0H2cvDrRvnb
	 QU5l6utTl/7yiDopnuF05sb2zm5dp1BpMOP/x6qX8meMPliVRFYwgDaSQQ+UFxfzA6Lyb
	 NrTSN/Tc/P43ld50amxyMgF+ND3cl1tPyKNXyucP1up0QRFEmba2l3Ign6d/vl/yKDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793586229;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=o4fSDnmtmbZ30jH6553LXpXrsXHng0trnMhwaBC+PZs=;
	b=xPZ39rRnEbai161iqsJe0gPh25mvB00HYzdXvO5F9f9NEVVo6ADfx/F9icDBNgpJA2JL
	 OX1qryXCbaNWBSIA+CvXl55uyUZifgscb7YVQLWgCVe3VVBi6+EQGzTbj4i0nF4IQjIC4
	 JVWtgGDLPhvxWBsQNxxG/0X9JtvHMKQu9rHOJ9zWJvsmPA/bdLsJuVTXv0hqFHHkzOTWc
	 G4Fo4QQXqCUxP2NQhGFd+CmwQnmqxDVUdbhJ5M0nvqBO5hAF2PcydelS+K5MeQQOEhLFa
	 r90IFIF35sYIboUtxrg1m4CQZybcCJ1C0KvlJIQm8/wa+D6nRtfjQm6G4hI+7LYMb9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SRqinuuM;
	arc=none smtp.remote-ip=95.215.58.126
Received: from mta1.migadu.com (out-126.mta1.migadu.com [95.215.58.126])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D974C606A329
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 02:23:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D974C606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=SRqinuuM
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ALr5TsAEjuwt2pIJ/IP8K7713x8kUZX1icwbiFIInMI=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793586220; v=1; x=1794191020;
 b=SRqinuuMl6gdOXtp9TRbNPvcgF5WtOOqzaWiXWuBanFkmJV9xWmUIEICQ54IcO1dfYLdl/ue
 PBol2C63lhz91+GDFk7CfJhlOz3rzvVlyg07YN9TBKCWvNhCXfAw4f5el0RhCoZZBWuwu2sgdXc
 3mzifa34+JRcDNllCvqsNviU=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 74277f5059ada402;
	Mon, 02 Nov 2026 02:23:40 +0000
X-Mizu-Trace-ID: 74277f5059ada402
X-Migadu-Flow: FLOW_OUT
Message-ID: <2fd1dc53-ae46-4163-90a4-f916c9dce29b@linux.dev>
Date: Mon, 2 Nov 2026 10:23:30 +0800
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
Subject: Re: [PATCH net v3 5/5] net: restrict message_cost and message_burst
 to non-negative values
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 Joel Granados <joel.granados@kernel.org>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Thomas Gleixner <tglx@kernel.org>,
 Petr Pavlu <petr.pavlu@suse.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Maoyi Xie <maoyi.xie@ntu.edu.sg>, Zhan Xusheng <zhanxusheng1024@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, Neal Cardwell <ncardwell@google.com>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Yung Chih Su <yuuchihsu@gmail.com>, Wyatt Feng
 <bronzed_45_vested@icloud.com>,
 Hannes Frederic Sowa <hannes@stressinduktion.org>,
 Flavio Leitner <fbl@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261101061331.286404-1-jiayuan.chen@linux.dev>
 <20261101061331.286404-6-jiayuan.chen@linux.dev> <auftqzpuuNFiScrb@fedora>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <auftqzpuuNFiScrb@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 9:55 AM, Hangbin Liu wrote:
> Hi Jiayuan,
> On Sun, Nov 01, 2026 at 02:12:03PM +0800, Jiayuan Chen wrote:
>> net.core.message_cost and net.core.message_burst feed the interval and
>> burst of net_ratelimit_state, but neither rejects negative values:
>> message_burst uses plain proc_dointvec, and message_cost uses
>> proc_dointvec_jiffies, which happily stores -1 second as -HZ jiffies.
>>
>> Since commit a940d145cc38 ("ratelimit: Warn if ->interval or ->burst are
>> negative"), ___ratelimit() splats on such values, so the next
>> net_ratelimit() caller warns, e.g. a martian source log:
>>
>>   Negative interval (-250) or burst (10): Uninitialized ratelimit_state structure?
>>   WARNING: lib/ratelimit.c:43 at ___ratelimit+0x56e/0x960, CPU#1: ping/3218
>>   RIP: 0010:___ratelimit+0x578/0x960
>>   Call Trace:
>>    <IRQ>
>>    net_ratelimit+0x1c/0x30
>>    ip_handle_martian_source+0x1bb/0x340
>>    ip_route_input_slow+0x1057/0x3650
>>    ip_route_input_noref+0x104/0x260
>>    arp_process+0x109b/0x2510
>>    arp_rcv+0x381/0x460
>>    __netif_receive_skb_one_core+0x173/0x1c0
>>    __netif_receive_skb+0x21/0x150
>>    process_backlog+0x37e/0x1200
>>    __napi_poll.constprop.0+0xa5/0x5e0
>>    net_rx_action+0x4c0/0xf70
>>    handle_softirqs+0x204/0x9b0
>>    __do_softirq+0x10/0x18
>>    do_softirq.part.0+0x49/0xd0
>>    </IRQ>
>>
>> Negative values never meant anything here: 0 already expresses both
>> "no limit" (interval) and "suppress everything" (burst).
> Will this limit breaks the UAPI on old kernels that supports negative values?

All commits in this series restrict config values, and every one of them
changes the old behavior to some degree; the question is whether the

change is reasonable.


For this one, negative values never did anything that 0 doesn't, and
since a940d145cc38 setting one already triggers the WARN_ONCE().


> As the comment in ___ratelimit() says:
>
>         /*
>          * Zero interval says never limit, otherwise, non-positive burst
>          * says always limit.
>          */
>
> If all others agree to set the limit in this patch. I think the comment


The comment and the WARN_ONCE() are about ratelimit_state in general, not
net only. There are still other ways to set a negative value,
printk_ratelimit for example, so updating them is not this net patch's
job.

> and the WARN_ONCE() , and the admin-guide/sysctl/net.rst all need to be updated.



net.rst never documented a range or even the unit for these two, which is
why I didn't touch it. No strong preference though.

> Thanks
> Hangbin
