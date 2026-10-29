Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793239675;
	b=hiq81nLDgOcrwCSpPcLiEA5oto1HwZjtk0dlvWdcM3X90kBc9dZUyJITWkZi7QuZuhIg
	 XSjdmcjy5/cIe4/UJyZKNQjI/FCvi/3acYozS5ZOFA4F4EKWyrmtj5qyTCQzI0qn16J+F
	 L6KM9/zb/10ou5E+cbY2uOJuasb8GeZ+mqnj2/SBvff+Bh0WjnXFhvNY7g98m2lESebsB
	 1CQoT1Dlg3OyHa8jy50NJB/ppxZ9b8d5L5xUvXTERdsUc/6saOE9nB9Uid+1d5AKwFPP4
	 CAQOpqoFLLjPphQzV0sX/OUQB3BHDtlWi7pmbO/+ULvhk+M788DYDHzONqtnn1nE05Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793239675;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xo31mvG/7p/5y5qelRls1EDLgAbdS/ONalz/GcY/xAc=;
	b=l9evn0NUN4aCed/NazCkHdY4Ht/XWzu8o3Lcsk2y4Co4d/yyHniMuPEKYkURIUdu/HQA
	 5fhj9jckqJLTJFFSAasNtzz3vHItY3cFZu+53pIPEEaKgFF72Z1imitmb2Ta7+vX2AXXA
	 lPjsQ0fYXznSk1mcjFm0zWg4gQoUz0kcogPngGHhsvGaTvcxfua4docJ06M1gQUSyemwy
	 sl/YX0Kn9oGOCABszyva/ucfol9yQfgujD6NWrBv21rnfkqyCgLuAPzHXuQQU+m8+Oqa1
	 kGHKpopfFd40pZVFOj+VJ8VdPzEdwpu7PM8RRByfvHLyqPGkBEmnEy6AP4YSUm/ybLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JcDCMiHm;
	arc=none smtp.remote-ip=91.218.175.197
Received: from mta0.migadu.com (out-197.mta0.migadu.com [91.218.175.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A35606A322
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 02:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 72A35606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JcDCMiHm
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xyLPSKnOyBeEPlunYayjcEhwkUZvZny8jBvv5fVbWJ4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793239672; v=1; x=1793844472;
 b=JcDCMiHm338GyuYaxcnnbI/OssltPjIrrI+cL9sAo3SZySFe+JSAjicS/shmE7cUXSlM44MW
 GQsDGSE/x456lV+l7JnY7fdtVdhTEWasSzlKHuuIXliRxz01/DnijQW0LrzPOlJqkNdrn92UdpP
 E+z3JsQOrWzHqnoZzRgbCU1c=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 5da86a6bb385be24;
	Thu, 29 Oct 2026 02:07:52 +0000
X-Mizu-Trace-ID: 5da86a6bb385be24
X-Migadu-Flow: FLOW_OUT
Message-ID: <cf2f4721-892d-4283-9354-84e7609e7034@linux.dev>
Date: Thu, 29 Oct 2026 10:07:40 +0800
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
Subject: Re: [PATCH net v2 1/5] ipv6: restrict gc_elasticity to 31
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Joel Granados <joel.granados@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Willem de Bruijn <willemb@google.com>, Maoyi Xie <maoyi.xie@ntu.edu.sg>,
 Jiri Wiesner <jwiesner@suse.de>, Gerd Rausch <gerd.rausch@oracle.com>,
 Zhan Xusheng <zhanxusheng1024@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Yung Chih Su <yuuchihsu@gmail.com>, Wyatt Feng
 <bronzed_45_vested@icloud.com>,
 Hannes Frederic Sowa <hannes@stressinduktion.org>,
 Flavio Leitner <fbl@redhat.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261027104701.296240-1-jiayuan.chen@linux.dev>
 <20261027104701.296240-2-jiayuan.chen@linux.dev>
 <CAAVpQUCBBaVmaZUv+D+a4anSbGSR_pKukYVXvRJRzSGVnjb2kw@mail.gmail.com>
 <eb85d54b-778e-403e-a5a5-56805b23b560@linux.dev>
 <CAAVpQUCHeydud7_NkMuUyK3tdNYLD9GrCGJiGQO6gV+r0-GuHA@mail.gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <CAAVpQUCHeydud7_NkMuUyK3tdNYLD9GrCGJiGQO6gV+r0-GuHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/29/26 9:53 AM, Kuniyuki Iwashima wrote:
> On Wed, Oct 28, 2026 at 6:47 PM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>
>> On 10/29/26 7:58 AM, Kuniyuki Iwashima wrote:
>>> On Tue, Oct 27, 2026 at 3:48 AM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
>>>> Every counted IPv6 dst allocation runs ip6_dst_gc() once the number of
>>>> live dst goes over gc_thresh (1024 by default). ip6_dst_gc() decays
>>>> ip6_rt_gc_expire by gc_elasticity: the smaller gc_elasticity is, the
>>>> smaller ip6_rt_gc_expire gets, i.e. the more aggressive the gc.
>>>>
>>>> ip6_dst_gc() reads ip6_rt_gc_expire into a u32, but gc_elasticity has no
>>>> bounds at all, so writing >= 32 shifts a 32-bit value by >= 32 bits, and
>>>> a negative value gives a negative shift count. Both are UB:
>>>>
>>>>           val = atomic_read(&net->ipv6.ip6_rt_gc_expire);
>>>>           atomic_set(&net->ipv6.ip6_rt_gc_expire, val - (val >> rt_elasticity));
>>>>
>>>>     UBSAN: shift-out-of-bounds in net/ipv6/route.c:3369:53
>>>>     shift exponent 32 is too large for 32-bit type 'unsigned int'
>>>>     CPU: 2 UID: 0 PID: 615 Comm: ping6 Not tainted 7.3.0-rc7+ #364 PREEMPT
>>>>     Call Trace:
>>>>      <IRQ>
>>>>      dump_stack_lvl+0xc1/0xf0
>>>>      dump_stack+0x10/0x20
>>>>      __ubsan_handle_shift_out_of_bounds+0x1d1/0x390
>>>>      ip6_dst_gc.cold+0x15/0x1a
>>>>      dst_alloc+0x4e0/0x620
>>>>      ip6_rt_cache_alloc+0x189/0x7e0
>>>>      __ip6_rt_update_pmtu+0x68e/0x1160
>>>>      ip6_update_pmtu+0x30c/0x3a0
>>>>      icmpv6_err+0x1fa/0x330
>>>>      icmpv6_notify+0x303/0x770
>>>>      icmpv6_rcv+0xc12/0x1670
>>>>      ip6_protocol_deliver_rcu+0xb4a/0x1520
>>>>      ip6_input_finish+0x19c/0x400
>>>>      ip6_input+0xd4/0x240
>>>>      ipv6_rcv+0x1fd/0x330
>>>>      __netif_receive_skb_one_core+0x118/0x1c0
>>>>      __netif_receive_skb+0x21/0x150
>>>>      process_backlog+0x37e/0x1200
>>>>      __napi_poll.constprop.0+0xa5/0x5e0
>>>>      net_rx_action+0x4c0/0xf70
>>>>      handle_softirqs+0x204/0x9b0
>>>>      __do_softirq+0x10/0x18
>>>>
>>>> Make it a u8 and reject writes outside 0..31 with proc_dou8vec_minmax().
>>>>
>>>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>>>> Cc: stable@vger.kernel.org
>>>> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
>>>> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>>>> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>>>> ---
>>>> v2: switched to u8 and proc_dou8vec_minmax(), as suggested by Kuniyuki
>>>> Iwashima.
>>>> ---
>>>>    include/net/netns/ipv6.h | 2 +-
>>>>    net/ipv6/route.c         | 7 +++++--
>>>>    2 files changed, 6 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/include/net/netns/ipv6.h b/include/net/netns/ipv6.h
>>>> index ffda15318be59..aefce37c04a4f 100644
>>>> --- a/include/net/netns/ipv6.h
>>>> +++ b/include/net/netns/ipv6.h
>>>> @@ -25,11 +25,11 @@ struct netns_sysctl_ipv6 {
>>>>           int ip6_rt_gc_min_interval;
>>>>           int ip6_rt_gc_timeout;
>>>>           int ip6_rt_gc_interval;
>>>> -       int ip6_rt_gc_elasticity;
>>>>           int ip6_rt_mtu_expires;
>>>>           int ip6_rt_min_advmss;
>>>>           u32 multipath_hash_fields;
>>>>           u8 multipath_hash_policy;
>>>> +       u8 ip6_rt_gc_elasticity;
>>>>
>>>>           __cacheline_group_begin(sysctl_ipv6_flowlabel);
>>>>           u8 flowlabel_consistency;
>>>> diff --git a/net/ipv6/route.c b/net/ipv6/route.c
>>>> index 94e5ef1c4f83e..abc8b811cd423 100644
>>>> --- a/net/ipv6/route.c
>>>> +++ b/net/ipv6/route.c
>>>> @@ -6579,6 +6579,8 @@ static int ipv6_sysctl_rtcache_flush(const struct ctl_table *ctl, int write,
>>>>           return 0;
>>>>    }
>>>>
>>>> +static int ip6_rt_gc_elasticity_max = 31;
>>> as you need v3, s/int/u8/
>>>
>> Hi Kuniyuki,
>>
>> proc_dou8vec_minmax() put extra1/extra2 into proc_uint_conv(), which
>> reads them as unsigned int, so the max has to stay an int like
>> tcp_syn_retries_max and friends; a u8 there would read
>> three bytes past the variable.
> Ah exactly, then please use unsigned int.
>
> Thanks


Makes sense, unsigned int in v3.

