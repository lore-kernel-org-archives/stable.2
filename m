Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.6
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793667945;
	b=OJ9KvSAb8lj3kbFnfjnuQxp1cwFhroUs83zkxYxhM9RqK3ivr32yTjqfWf0tfzl+G/A0
	 W8pWSCXS+8r9pL+/ZWB4koKbeeEEvC9mUd3GI8QedqqLkri/kzOC33Rtgm0ee18E832kd
	 kai0iFwoyNwbaeYQCN7YA2jGJATYIrdETfTblRZmqQ6OXrxnDrcKYNla+820ggF4Er3xe
	 OnKIuMXO5+zcqUmh5Kn2UFi5NZHVhIS1nwgCG91SUJJ69EfLcyzWZhJYIAFcF9geON5bh
	 KWEH4EP0qX95uCYLKygMst9ZioaDgCVzRNrgmMXK1CJit60OK0LSO/d4gxkDsZntK3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793667945;
	h=DMARC-Filter:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-Coremail-Antispam:X-CM-SenderInfo;
	bh=NnkY2DC4h5FBOyoy0W5E18s80gLOkDFUVQgHeLoHd8E=;
	b=rgHMnkP797XMRDu7mejZ7dhov09Ofja9J5kY9snCNuqKb9IveDG8MEykgUBVqC/Ix7We
	 3Qgq+7Dl4KYKMIjP/9RjjiYt+Q7ejHy5j0Q+mRvVbHKFBeFSTcrnxUp1RoSBoVuiRY/zq
	 XADDc3TvxSui23Q9HlmRjw72rw/Ix8mr5uKl93UiVOONxN1MYEH4LUxnVlxk/Hwxl0HQg
	 hl+tbQA91UHqcQWFmfLb0T+82wDbIAXCOGPc3CUbsQObvt0Q7dCJdJ6YaOoYdHTFgELgo
	 ln4NZeDq4rL/hvsNsFAgxbNEz9uwtiQk4tXMqBkZCEh1qj4sBLYEMACGcfIY5HZKB9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=126.com;
	spf=pass smtp.mailfrom=126.com;
	dkim=pass header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b="e/9ukaL9";
	arc=none smtp.remote-ip=117.135.210.6
Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9926606A337;
	Tue,  3 Nov 2026 01:05:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9926606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=126.com header.i=@126.com header.a=rsa-sha256 header.s=s110527 header.b=e/9ukaL9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=NnkY2DC4h5FBOyoy0W5E18s80gLOkDFUVQgHeLoHd8E=;
	b=e/9ukaL97NDmYYjkYbJ2lppAzZJJpoIN8WYST4O2xCvwRvYr/jKxzr1EHd3e7q
	L+SgsdeQvSPpcsI1vXxbBPT9DnL1geaVB8XwSxvSaWJKgSZLvxdyBo8AL2iOflTV
	0GjrkICSxCSXGB5sfCQL/Q0E5SUUmQFmDXqVpp4OWl60A=
Message-ID: <7f3b08fb-8eec-4ff1-a696-f8a1b3df7b45@126.com>
Date: Tue, 3 Nov 2026 09:04:55 +0800
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
Subject: Re: [PATCH net 2/5] e1000e: do not cache the hwtstamp config before
 it is applied
To: Jacob Keller <jacob.e.keller@intel.com>, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>,
 stable@vger.kernel.org
References: <20261028090455.2291659-1-xiaolinkui@126.com>
 <c4c4833b-b0e9-4d79-9e7b-7db9eee67535@intel.com>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <c4c4833b-b0e9-4d79-9e7b-7db9eee67535@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3d3k3M+lqJRVrCg--.32589S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWw4UCryDZFyfJw1DAr1kZrb_yoW5ZF1xpa
	y5CFyYkrs8tr13Ka97X3W8Ar98Kan7tay5WFyYyw15A3s8uFyxCrykKrW8uay0q3ykGw1j
	qrn8Zw1xGan8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UZZ2-UUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBlBvvxmrpMzuB5gAA3K

Hi Jake,

Thank you for applying the patch and for the review.

On 2026/11/3 06:15, Jacob Keller wrote:
> On 10/28/2026 2:04 AM, Linkui Xiao wrote:
>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>
>> e1000e_config_hwtstamp() stores the requested configuration in
>> adapter->hwtstamp_config right after the rx filter has been
>> translated, but the two register writes that follow are verified by
>> reading the registers back and each of them can fail with -EAGAIN.
>>
>> When one of them does, the driver is left holding a configuration the
>> hardware never accepted:
>>
>>   - e1000e_hwtstamp_get() hands it back to user space, so an
>>     application that reads the configuration back is told that
>>     hardware time stamping is in effect while it is not;
>>
>>   - e1000e_systim_reset() re-applies it after every reset, including
>>     the ones the watchdog triggers, and keeps failing;
>>
>>   - e1000_watchdog() starts polling TSYNCRXCTL_VALID for the cached rx
>>     filter, and e1000_xmit_frame() still parks skbs that ask for a Tx
>>     time stamp because it only looks at FLAG_HAS_HW_TIMESTAMP, so they
>>     are eventually dropped by e1000e_tx_hwtstamp_work() with a
>>     "clearing Tx timestamp hang" warning.
>>
>> Cache the configuration only once both registers have been verified,
>> so that adapter->hwtstamp_config always describes what the hardware
>> is programmed with.
>>
> 
> Any idea why this got marked as patch 2 out of 5? This doesn't appear on
> either netdev or iwl with any other patches.
Regarding your question about the "2/5" marking: it was an oversight on 
my end. I generated this fix from a local branch that contained other 
commits, and `git format-patch` automatically added the series 
numbering. The patch is indeed a standalone fix and was not intended to 
be part of a series posted elsewhere.

I'll make sure to use a proper invocation for single patches going forward.

Thanks again for your time and for taking this fix into the Intel Wired 
LAN tree.

Best regards,
Linkui
> 
> I'm going ahead and applying it to Intel Wired LAN regardless, since the
> fix looks good.
> 
> Thanks,
> Jake
> 
>> Fixes: 62d7e3a2d006 ("e1000e: Validate hwtstamp_config completely before applying it")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
>> ---
>>   drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
>> index 35f5590228eb..7ae33273734f 100644
>> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
>> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
>> @@ -3715,8 +3715,6 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
>>   		return -ERANGE;
>>   	}
>>   
>> -	adapter->hwtstamp_config = *config;
>> -
>>   	/* enable/disable Tx h/w time stamping */
>>   	regval = er32(TSYNCTXCTL);
>>   	regval &= ~E1000_TSYNCTXCTL_ENABLED;
>> @@ -3763,6 +3761,8 @@ static int e1000e_config_hwtstamp(struct e1000_adapter *adapter,
>>   	er32(RXSTMPH);
>>   	er32(TXSTMPH);
>>   
>> +	adapter->hwtstamp_config = *config;
>> +
>>   	return 0;
>>   }
>>   

