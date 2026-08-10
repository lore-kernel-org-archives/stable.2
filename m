Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAF9381AFB
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 16:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786378544; cv=none; b=Ad3pB1zCjxxU3Q+Ps2wFmISix33n/xoQDOHPFxeD90nXFSdQKYSozZb/nZGK0TgZumtSs8Z1Qu+uwZ2TXFtHYH88JP+Lhsii46cOxaN4lMe3v9Yxk+4CtgTuyAXcppKizNu9W1QNvmv8ZuyZMXG0GhIpDJ8LExkx0AXDVvaifdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786378544; c=relaxed/simple;
	bh=ls8jXR7z4yRoxt7WuuegDOenuGMvt9OxwYTIfOfjYnc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VuEgkxexroxtEV0YpPfnhvmHF5QF8pjg5/UmD8+HPLzO07UieUkllFcpEN1JQ9RzFkj+Lhj5XpoKkKopxP4BVpXRPavzP9UtoIVc2l4M1JPCO7jTzciGcEoE+wCoRKe9su6WflRfZam2Iau+vZ2Hknzh/3cD8p9+MWtH+euqdFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TurWUar5; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TurWUar5"
Message-ID: <ae8068c8-ece8-4c6b-9c0b-65d9cbedf84f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786378529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ucEznkl+fQA3uTG/r3zs1YKQpu/sFtIRxu3JT0SliEM=;
	b=TurWUar5fGcoAcOUIE6TAn/45H/Wjjjm8yECIEtdpFenB3dO7cF7tz1ndKAlXUSG9JEMkF
	aCHoenfZwXolFUJfgvpmsc7fiwP0VHXmZOMZO8/RhZ1Dca3PEbZCg5xJX+Ts4S22DZcsar
	WXvZUtaJ712VMYhoy//SyoLoJdILz1A=
Date: Mon, 10 Aug 2026 17:15:25 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net 2/2] gve: fix NULL dereference due to missing ptp
 adjfine
To: Jordan Rhee <jordanrhee@google.com>
Cc: Harshitha Ramamurthy <hramamurthy@google.com>, netdev@vger.kernel.org,
 joshwash@google.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, thostet@google.com, ziweixiao@google.com,
 willemb@google.com, nktgrg@google.com, pkaligineedi@google.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260807224315.234152-1-hramamurthy@google.com>
 <20260807224315.234152-3-hramamurthy@google.com>
 <724b2c8d-1481-4418-a10a-4331a620cd91@linux.dev>
 <CA+mzVttPSW=NKqqBwY9kxdL_r0hKzQfu38eZtmfUB6iaeHcNRw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CA+mzVttPSW=NKqqBwY9kxdL_r0hKzQfu38eZtmfUB6iaeHcNRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/08/2026 16:55, Jordan Rhee wrote:
> On Sat, Aug 8, 2026 at 8:27 AM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 07/08/2026 23:43, Harshitha Ramamurthy wrote:
>>> From: Jordan Rhee <jordanrhee@google.com>
>>>
>>> Fix NULL dereference due to missing implementation of adjfine, which can
>>> be triggered from usermode as follows:
>>>
>>> sudo ./testptp -d /dev/ptp0 -f 0
>>> [  551.943697] BUG: kernel NULL pointer dereference, address: 0000000000000000
>>> [...]
>>> [  552.061946] Call Trace:
>>> [  552.064487]  <TASK>
>>> [  552.066681]  ptp_clock_adjtime+0x1c0/0x2c0
>>> [  552.070874]  ? get_clock_desc+0x6b/0xb0
>>> [  552.074825]  pc_clock_adjtime+0x78/0xc0
>>> [  552.078755]  __do_sys_clock_adjtime+0x85/0x110
>>> [  552.083293]  do_syscall_64+0xea/0x610
>>>
>>> Cc: stable@vger.kernel.org
>>> Fixes: acd16380523b ("gve: Add initial PTP device support")
>>> Signed-off-by: Jordan Rhee <jordanrhee@google.com>
>>> Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
>>> ---
>>>    drivers/net/ethernet/google/gve/gve_ptp.c | 6 ++++++
>>>    1 file changed, 6 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/google/gve/gve_ptp.c b/drivers/net/ethernet/google/gve/gve_ptp.c
>>> index 06b1cf4a5efc..1d6c59f4ead3 100644
>>> --- a/drivers/net/ethernet/google/gve/gve_ptp.c
>>> +++ b/drivers/net/ethernet/google/gve/gve_ptp.c
>>> @@ -26,6 +26,11 @@ int gve_clock_nic_ts_read(struct gve_priv *priv)
>>>        return 0;
>>>    }
>>>
>>> +static int gve_ptp_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
>>> +{
>>> +     return -EOPNOTSUPP;
>>> +}
>>> +
>>>    static int gve_ptp_gettimex64(struct ptp_clock_info *info,
>>>                              struct timespec64 *ts,
>>>                              struct ptp_system_timestamp *sts)
>>> @@ -60,6 +65,7 @@ static long gve_ptp_do_aux_work(struct ptp_clock_info *info)
>>>    static const struct ptp_clock_info gve_ptp_caps = {
>>>        .owner          = THIS_MODULE,
>>>        .name           = "gve clock",
>>> +     .adjfine        = gve_ptp_adjfine,
>>>        .gettimex64     = gve_ptp_gettimex64,
>>>        .settime64      = gve_ptp_settime64,
>>>        .do_aux_work    = gve_ptp_do_aux_work,
>>
>> .adjtime has to be implemented as well - neither adjfine nor adjtime are
>> checked within ptp_clock_adjtime()
> 
> adjtime() can only be reached if gettimex64() succeeds. Since GVE
> currently returns -EOPNOTSUPP in gettimex64(), ptp_clock_adjtime()
> will short circuit before calling the driver's adjtime callback. We
> will need to provide a stub for adjtime() when we implement
> gettimex64().
> 
> My understanding is that fixes should only address real, reproducible
> issues which is why we only sent adjfine in this patch. If the
> maintainers would prefer we send adjtime() as well, just let us know.
> That said, our preference would be not to delay the other patch in
> this series ("gve: fix zero-length skb frag with header-split").

ah, yeah, I see that gve_ptp_gettimex64 is -EOPNOTSUPP.

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
