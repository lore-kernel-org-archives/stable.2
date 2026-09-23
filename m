Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9FF83D75AD;
	Wed, 23 Sep 2026 06:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790146295; cv=none; b=Khtzxv+/9rBk40f4pxevh5oVxGuA6lmGhVBkIDi/5K5nB7UMiIcnMyKvr0CVOPF9WbXovARAN5VrXzN2qXfsDmJkn0SFq298gODObfoRyAwAHcACAVhuiB3yvS+Jx//rtIdtKizUavOUn1YnDm4n/wP74DVNIjyYWWWCoHLOHvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790146295; c=relaxed/simple;
	bh=sY4kqUXjV43Z3lxOaoU7+ZK8mTamB5s+/oHuwIJGLg0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RDl6c4rtPGeAnq/wEtmBU5IkgJLAcXO2ZbCcKe4iykpSQGLCSeXb88csVw2GaVLcDzKREHqCKPZKsYKoS2BsFRMGdGElvMteh9dZoYZPDomlm5aet2YUI3Ebii6En43OXQaD/JEa8JBRWSzk4+STOVJUKNEtUYnuoYN7dM9UY+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qXMkOKo7; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qXMkOKo7"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CBE864E41043;
	Wed, 23 Sep 2026 06:51:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9502260580;
	Wed, 23 Sep 2026 06:51:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C05F510329298;
	Wed, 23 Sep 2026 08:51:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790146285; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=pUaLIn+oOf0tZ8toMwBTWM8tTKttxaPOWSyDwEVvWuQ=;
	b=qXMkOKo7SEpYgYtiAU6qu2AmvSM8wBSZsGKhG4UVi9nkUai6K5QQK7ndEU93BPtPIPMrML
	2h0rJpQQPj2aIb3goOnTanHedJ9AorqcB0bcq9a52xVcHa2YDwveIaNXlV4la7zf5LzcqC
	q+kjqDEt4sUNAQlRW0EXunL+m/Q+eOVjGp2VhsGPhkhxL0LY3XCbGd9lHnlxhUM28DY6Jj
	2bmuX6T5tKlmVyhT8Fj4ffGt7+A8905rsuaFTw/vw0Tgrv1nKoTYA7ur1bJDHaYlfYX2ms
	HJqXYm/Kc1WLy7F2gkld5xwYeVLi83l5rkSRdJOMoO/Oll3VeIW3vpaKOgbCdQ==
Message-ID: <c1cde6b7-5883-4dbc-87e9-d7b86f727ba7@bootlin.com>
Date: Wed, 23 Sep 2026 08:51:19 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dsa: microchip: save the periodic output
 request
To: Paolo Abeni <pabeni@redhat.com>, netdev-bot+sashiko@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, richardcochran@gmail.com, ceggers@arri.de,
 arun.ramadoss@microchip.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260917-fix-perout-v2-1-d8acf3eea6f7@bootlin.com>
 <178998077822.2160803.3867886756893254872@kernel.org>
 <635cfefd-c588-4b3f-bbc4-1cf11ef0a2c5@bootlin.com>
 <99bcc883-1cbb-46f9-9283-cd03e5efafe7@redhat.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <99bcc883-1cbb-46f9-9283-cd03e5efafe7@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Paolo,

On 9/22/26 12:01 PM, Paolo Abeni wrote:
> On 9/22/26 08:32, Bastien Curutchet wrote:
>> On 9/21/26 10:52 AM, netdev-bot+sashiko@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 2 potential
>>> issue(s) to consider.
>>>
>>> Critical: 0 · High: 1 (2) · Medium: 1 (2) · Low: 0 (1)
>>>
>>> If you believe none of the issues are legitimate, please reply to each
>>> issue of Medium severity or higher and explain why the AI is wrong.
>>> If any of them are legitimate and you plan to respin, please let 
>>> patchwork
>>> know by including "pw-bot: cr" as a separate line at the end of your 
>>> reply
>>> (one such reply per series is enough).
>>>
>>> - [High] ksz_ptp_enable_perout()
>>>    (drivers/net/dsa/microchip/ksz_ptp.c:226) commits the caller- 
>>> supplied…
>>> - [Medium] The commit message states that 'if a flag was set in the
>>>    request that triggered the periodic output, it is lost when the 
>>> output…
>>>
>>> Pre-existing issues:
>>> - [High] A non-canonical but ABI-accepted period whose timespec64
>>>    conversion is zero (e.g. period.sec = -1, period.nsec = 1000000000;…
>>> - [High] In ksz_ptp_restart_perout()
>>>    (drivers/net/dsa/microchip/ksz_ptp.c) the elapsed-period quotient is…
>>> - [Medium] The device exposes three trigger output units (caps.n_per_out
>>>    = 3 at drivers/net/dsa/microchip/ksz_ptp.c:1056, PTP_TOU_INDEX =…
>>> - [Medium] ksz_ptp_enable_perout() resolves the output pin with
>>>    ptp_find_pin() (drivers/net/dsa/microchip/ksz_ptp.c:206).
>>> - [Low] ksz_ptp_tou_reset() (drivers/net/dsa/microchip/ksz_ptp.c:66-86)
>>>    assigns the result of the TRIG_RESET read-modify-write to 'ret' at…
>>>
>>> -- 
>>>
>>> net: dsa: microchip: save the periodic output request
>>>
>>> The patch replaces the two stored timespec64 values 
>>> (perout_target_time_first
>>> and perout_period) in struct ksz_ptp_data with a copy of the full
>>> ptp_perout_request, so that the index and flags survive a perout 
>>> restart.
>>> ksz_ptp_restart_perout() now replays the saved request with only the 
>>> start
>>> time recomputed.
>>>
>>> A few questions below.
>>>
>>>>      When a periodic output is initialized, only the start and the 
>>>> period are
>>>>      stored, not the flags nor the pin index. So when the periodic 
>>>> output is
>>>>      restarted, the request flags and index are always set to 0. So 
>>>> if a pin
>>>>      other than the first one was used, or if a flag was set in the 
>>>> request
>>>>      that triggered the periodic output, it is lost when the output is
>>>>      restarted.
>>>
>>> [Severity: Medium]
>>> Can request->flags ever be non-zero in this driver?
>>>
>>> ksz_ptp_clock_register() sets caps.n_pins, caps.n_per_out and the 
>>> callbacks,
>>> but never sets caps.supported_perout_flags, and caps lives in the zeroed
>>> struct ksz_device, so the mask stays 0. The core rejects any flag 
>>> that is not
>>> advertised before it calls the driver:
>>>
>>> drivers/ptp/ptp_chardev.c:ptp_perout_request() {
>>>     ...
>>>     if (perout->flags & ~ops->supported_perout_flags)
>>>         return -EOPNOTSUPP;
>>>     ...
>>>     return ops->enable(ops, &req, perout->period.sec || perout- 
>>> >period.nsec);
>>> }
>>>
>>
>> This check is 'fairly' recent, it was added by d9f3e9ecc456 ("net: 
>> ptp: introduce .supported_perout_flags to ptp_clock_info") (v6.15). I 
>> experienced the reset issue on a v6.12 kernel.
>>
>> Even if it can't happen right now, as soon as this driver registers 
>> any new flag, the bug will come back.
>>
>>
>>
>> All others comments are already existing issues that can be fixed 
>> independently from this patch so I don't plan to address them right now.
> This one:
> 
> """
> Should the request be committed to ptp_data->perout_request only after 
> it has
> been validated and the hardware has actually been programmed?
> [...]
> 
> There is also a period that this check rejects but the memcpy has already
> stored: period.sec = 4, period.nsec = 294967296 gives 0x100000000 ns, and
> TRIG_CYCLE_WIDTH_M is GENMASK(31, 0), so the request returns -EINVAL. On 
> the
> next clock step, ksz_ptp_restart_perout() feeds that value to
> div_u64(now_ns - first_ns, period_ns), whose divisor parameter is u32, 
> so the
> divisor truncates to 0. Is that a divide error in process context with
> ptp_data->lock held?
> """
> 
> Looks new to me, and bad.
> 

I agree it is bad but it's not new IMO. In the current behavior, the 
period and target time are already stored before the request being 
validated. This patch only stores the rest of the request with them.

I'll still send a v3 storing the request at the end of the 
perout_enable() so both issues get fixed at once.

> Also if the issue you are observing on an older kernel is already fixed in
> the vanilla tree, I suggest instead sending to stable the relevant change.
> 
The issue isn't fixed in the vanilla tree, it's only hidden by the fact 
that the driver doesn't register the flags it supports in 
.supported_perout_flags.
And only the flag issue is hidden, the index still gets wrongly set to 0 
on restart.


Best regards,
Bastien
