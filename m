Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795487852;
	b=AgS0h4qhNsKl6sCndPCTOC/amdFZVmsBWAODFrOlu55AoC4PKqkex4j2p1XnDI/QjBha
	 wW8bixOY1mrRvsLyKGxL/EBt8LLWApHKYeWJqI6liE9vXhZvAo3liS591U+M664iOPgJC
	 7a2enRnr9bCs1vrgcWYNhW1Ycmp3sHWBBimOEfRAZCA411AwtyTYrcxco1EsCUETCr570
	 E9uHmkIjDtnP7foJITlv2dcZMGgES6NMzOf6eXQUwblFA3fbAYVIBrHek6m5rfG2wLPLb
	 rjpeBaoHix4RXJr6ITKVnXjgDbZC3EmXeofoZGcWlHfkuHWA3+bL/6nJlN6CcnoSGug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795487852;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=9aaMJwAetaq46EUyI+XQENYtiynOb1k9BZrDSha3iyo=;
	b=0xdvFvcSI6Ol2492J5m3Bjcc9Do5UdehBXNbnSop2Eon7VrBRxtdlxsIsocNSmT+LIvW
	 f+5swCnFGSrH/lyYWqgjtOc8vQuxqpdJ+C7Ux1R2JIDXCzL3s4aluU7ovuXMhqku55glJ
	 s2ue/vGrboZ+u3LZNDlIdGlqZqtNoS0glwUiz+tSVqYVhyE9oW7V4Qy4bLVTS3UI8MHZN
	 eXbIkBPTK1vvsaNRnrNwWbPYMIqo4LqKENbZtbQOIfYxysEGATr1xi7wueUUJbeX/2QBr
	 iItWzIvgVIgBJBQ1XkqhXYvZu7R0HutU8VL8leVdf+uGj6wd0i+yzhE0qBwdj3xyTmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PuCm+535;
	arc=none smtp.remote-ip=198.175.65.14
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 120A5606A32E;
	Tue, 24 Nov 2026 02:37:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 120A5606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PuCm+535
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795487853; x=1827023853;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TSZzxm9AhzGQXVzzdZ8sPb2fgY5Sb9l8OdPTSCZyscU=;
  b=PuCm+535LXpgsOLhfUsPLufVqAKnUS9melj7joL+GRJbT9bJbs5bj1EA
   BJrLeDKP0QjgFj17weip3B1JTuO6/BCJp8G/mvOAgMXwlhV+dbHmpXwC9
   P4FfHrgvTQpJAkFiaAgsuzCVjVxU9dsynWD5fgbw/hAhdPhtzjtvBFHOh
   464FPr/w4p4gRYOlzfEBe9iidUpfdzDmte8aqGYHm5+k6XE88dH1eGfLk
   5k/whw7TsuLx/AgGhU2e2lNNuzDZacpLWhTYNAs86Dykokh619eQakBGZ
   yRYAkH2rwA7d/O0rB6Ze+h3fFeQXKFfIXmFYtxet2ORe7d9dPrHmaOgNK
   Q==;
X-CSE-ConnectionGUID: HxDXShFuSkid/WF6yhUsMA==
X-CSE-MsgGUID: +APJomvpR4Ob3EqpYkewsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4205146"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4205146"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 18:37:32 -0800
X-CSE-ConnectionGUID: 1S6kDrGQQZeK7IapvQ1q1w==
X-CSE-MsgGUID: +FisAPidR9u832zlRFgwhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="11764117"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2026 18:37:32 -0800
Received: from [10.107.17.224] (unknown [10.107.17.224])
	by linux.intel.com (Postfix) with ESMTP id CD81720B8CD1;
	Mon, 23 Nov 2026 18:37:28 -0800 (PST)
Message-ID: <bb5c5880-5a8f-4991-8dcd-91ffa3fa2271@linux.intel.com>
Date: Tue, 24 Nov 2026 10:37:27 +0800
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
Subject: Re: [PATCH net 1/1] af_packet: Fix wrong timestamps in tcpdump
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Song Yoong Siang <yoong.siang.song@intel.com>,
 Looi Hong Aun <hong.aun.looi@intel.com>, KhaiWenTan <khai.wen.tan@intel.com>
References: <20261111053728.2611070-1-khai.wen.tan@linux.intel.com>
 <willemdebruijn.kernel.2721e06a6436@gmail.com>
Content-Language: en-US
From: KhaiWenTan <khai.wen.tan@linux.intel.com>
In-Reply-To: <willemdebruijn.kernel.2721e06a6436@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/13/2026 6:01 AM, Willem de Bruijn wrote:
> KhaiWenTan wrote:
>> From: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>>
>> Since commit 97dc7cd92ac6 ("ptp: Support late timestamp determination"),
>> timestamps may need to be retrieved with input from the driver
>> .ndo_get_tstamp(). Support was missing from mmap'ed AF_PACKET sockets.
>>
>> The problem was noticed using the igc driver, that since commit
>> 069b142f5819 ("igc: Add support for PTP .getcyclesx64()") has migrated to
>> use .ndo_get_tstamp() that timestamps were wrong on the receiving side,
>> when using tcpdump.
>>
>> Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")a
> 
> Fixes: 97dc7cd92ac6 ("ptp: Support late timestamp determination")
> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
>> Signed-off-by: KhaiWenTan <khai.wen.tan@linux.intel.com>
>> ---
>>   net/packet/af_packet.c | 29 ++++++++++++++++++++---------
>>   1 file changed, 20 insertions(+), 9 deletions(-)
>>
>> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
>> index cf6429f09477..7197236c8a3b 100644
>> --- a/net/packet/af_packet.c
>> +++ b/net/packet/af_packet.c
>> @@ -456,15 +456,20 @@ static int __packet_get_status(const struct packet_sock *po, void *frame)
>>   	}
>>   }
>>   
>> -static __u32 tpacket_get_timestamp(struct sk_buff *skb, struct timespec64 *ts,
>> -				   unsigned int flags)
>> +static __u32 tpacket_get_timestamp(struct net_device *dev, struct sk_buff *skb,
>> +				   struct timespec64 *ts, unsigned int flags,
>> +				   unsigned int sk_tsflags)
>>   {
>>   	struct skb_shared_hwtstamps *shhwtstamps = skb_hwtstamps(skb);
>>   
>> -	if (shhwtstamps &&
>> -	    (flags & SOF_TIMESTAMPING_RAW_HARDWARE) &&
>> -	    ktime_to_timespec64_cond(shhwtstamps->hwtstamp, ts))
>> -		return TP_STATUS_TS_RAW_HARDWARE;
>> +	bool cycles = sk_tsflags & SOF_TIMESTAMPING_BIND_PHC;
> 
> nit: whitespace line between variable declarations
> 
>> +
>> +	if (shhwtstamps && shhwtstamps->hwtstamp &&
>> +	    (flags & SOF_TIMESTAMPING_RAW_HARDWARE)) {
>> +		ktime_t tstamp = netdev_get_tstamp(dev, shhwtstamps, cycles);
> 
> Does this call need to be conditional on SKBTX_HW_TSTAMP_NETDEV, to
> interpret the union as netdev_data?
> 
> like get_timestamp, resolve the orig_dev.
> 
>> +
>> +		return ktime_to_timespec64_cond(tstamp, ts) ? TP_STATUS_TS_RAW_HARDWARE : 0;
>> +	}
>>   
>>   	if ((flags & SOF_TIMESTAMPING_SOFTWARE) &&
>>   	    ktime_to_timespec64_cond(skb_tstamp(skb), ts))
>> @@ -476,11 +481,16 @@ static __u32 tpacket_get_timestamp(struct sk_buff *skb, struct timespec64 *ts,
>>   static __u32 __packet_set_timestamp(struct packet_sock *po, void *frame,
>>   				    struct sk_buff *skb)
>>   {
>> +	struct net_device *dev = skb->dev;
> 
> validate skb->dev != NULL
> 
>> +	unsigned int sk_tsflags;
>>   	union tpacket_uhdr h;
>>   	struct timespec64 ts;
>>   	__u32 ts_status;
>>   
>> -	if (!(ts_status = tpacket_get_timestamp(skb, &ts, READ_ONCE(po->tp_tstamp))))
>> +	sk_tsflags = READ_ONCE(po->sk.sk_tsflags);
>> +	ts_status = tpacket_get_timestamp(dev, skb, &ts, READ_ONCE(po->tp_tstamp), sk_tsflags);
>> +
>> +	if (!(ts_status))
>>   		return 0;
>>   
>>   	h.raw = frame;
>> @@ -2424,9 +2434,10 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
>>   	/* Always timestamp; prefer an existing software timestamp taken
>>   	 * closer to the time of capture.
>>   	 */
>> -	ts_status = tpacket_get_timestamp(skb, &ts,
>> +	ts_status = tpacket_get_timestamp(dev, skb, &ts,
>>   					  READ_ONCE(po->tp_tstamp) |
>> -					  SOF_TIMESTAMPING_SOFTWARE);
>> +					  SOF_TIMESTAMPING_SOFTWARE,
>> +					  READ_ONCE(sk->sk_tsflags));
>>   	if (!ts_status)
>>   		ktime_get_real_ts64(&ts);
>>   
>> -- 
>> 2.34.1
>>
> 
Hi Willem,

We have gotten approval from Kohei to include his patch into our current 
patch. Will be updating a v2 for both patches based on your comments.

Thank you.

Best Regards,
KhaiWen
