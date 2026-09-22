Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71EFF4EB872
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 10:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071323; cv=none; b=eWXqsAIQIOxdE7Lf5DThRXJC17+B3L1J8agfb5E9TlAySEihjTvcStvkPfW0/kE/BOru7ho+QYjQTEewBudTw1Oo5WovSqgiPgXQyuhunHyq/fBvtAT0GJe4Ek2wwy1hQekqTQOkOjST1uY6c/kBdBDg6X1EXiFpcAZQZgUEp9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071323; c=relaxed/simple;
	bh=207cRhtOF6NzUqdPBujl5zqVEED8VL4pXa16JxsEym4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LuNx/cH0wQcoF9NXUvY34/jIlbYxv8VFpcsTxQ2tkNED8+CpaHxbU3ec/axWaKYszDl3F6W1DSjlI4ihFTRwLVZZmeftZO7vtXYVxjbHr0XResgC/DKS2OcEWcUrwYesQscLZwiwQxRvryMi3622ilSgW2FeMX5zI+Y0ufpn5xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RZVn7zS0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=izfsOyU0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZVn7zS0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="izfsOyU0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790071321;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XPYZNeIyiYj7gOq6QRXPEwzFCOAwM8Zc2zjq+jeGRJc=;
	b=RZVn7zS0I9XQtr+Xc+Ca01c/z2lF+HxgqikV2XA+24ZccRFBMGXw4Cx2l6nvXS0Jpe1pBS
	w+BQUxRB5SrR4R6z+gJ5XURushvvWpnOnxbl4pHdimlPgp5/g7i7wGEFR9VIByaCNMjxQy
	snJCDpNBeWDTJYOIglFAnHmLp5KqC9g=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-vc3jwhHbMl-ByMtZuSGuCQ-1; Tue, 22 Sep 2026 06:02:00 -0400
X-MC-Unique: vc3jwhHbMl-ByMtZuSGuCQ-1
X-Mimecast-MFC-AGG-ID: vc3jwhHbMl-ByMtZuSGuCQ_1790071319
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-487041c4c82so1209392f8f.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 03:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1790071319; x=1790676119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XPYZNeIyiYj7gOq6QRXPEwzFCOAwM8Zc2zjq+jeGRJc=;
        b=izfsOyU0WFguVFQcG+kXD6kF4mRthWdF8+qSKJ0u563lMWVRRBVaBcZN+VOVdsnAB3
         VWiiWrJBnF8Lq7BPr6RuilBlTq+Lwv8mCzgEU9T2095KpBXbTzL4Dz1yszUBpZfXv70W
         lim2kjl/J4jQS0+HMmlrfDOzhaVRAFj7zkkFhEKULm30vEvgj7NfV27MdwF0EzXDQA2E
         oIHW+2PhuPtuIDJXxVAFL5fHK23vOT0qhm5C84N5KyCixi0tADb21THNZtE/QOafsoHO
         pmwWdrN5t7GeLWyMCYaY4YRR8SLAmPjvM4p/X3UbORfLDellbQwO+Sm647YUETs73Zud
         iXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790071319; x=1790676119;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XPYZNeIyiYj7gOq6QRXPEwzFCOAwM8Zc2zjq+jeGRJc=;
        b=UbGcW2GIoDqM73T2h1kgjN2JrZB828QVW217YMNH7tDi4mpXaa/cACY9liB2bFC9rX
         qrYQHwhWxNr49qIup5HqimAYjiB6iRcCIlAljVhKIpR1mz3PzSn/uWqHsMkMl0FcIlVO
         tUxHrTcvPsaX4nnfIe1B1W+UrsOkyiI55qRJvyrAt2Iosf8jAIMIlCotM87NbGRn9vAU
         r9UOtNXs/pci2qGAvV8xAJp1u09/vAH2sIRqjISl53j0ME2Y3zJMbUjdKE7OBDI+WifC
         BZYvNXMI4dGQuIG2Uwe8cCLaFa9C19/XgwT6WAHVShcvSO+V+pqfCtsF/SweM4iV7ZuJ
         DOfg==
X-Forwarded-Encrypted: i=1; AKwUvBwGxNB4biZmxIB3/fs19Fh+Ij4UHxC3v3yLCANo2kU/M/MgCTfkIU+mkvHnB7b8jZJzaBfKwls=@vger.kernel.org
X-Gm-Message-State: AFuF++kdPAp2aBJlFNKRyOfxAtq3eMZIIYkmEpH2sgdasSsyC1Hyb5s4
	UdFGQYV5TAKBzmdWa3elMaUi/KOPSgIYd1EbvaYO2ya5BnIQuMWVqZZ/32tBE73mcpHe0M7GXp6
	NGNxwf+uxORKlMJvLQmh8t3u+cIdrscwD9674RNEjL1dcqfpkdcAro5EqlQ==
X-Gm-Gg: AYBFou3aS42iC/xAbTwtJHrTcvE1lNu33taCvEhJ/fv02DB3tpLdglQHf8iPmtRu+AY
	cPyOY8S7/x10slXMBq239UliHPVuhHTW0LUk68K9kvvhhCFa65BEdjhmIBgRsYWQMqs2skeWYIL
	sSEEZjuG41tB3HcKrlNn44Ux59eRJP2OnIw17KogSijW5ZSuI2GyXT6S6YneWLxoU1FAMQTf3e2
	unHZCRffU4XZgvz2jhjBvkRdTRpb+LKJjDP9w5rDVBCjVlWeNjkWQGxHB2NIEmeH2Qpsff32OK3
	zH8vB5qJd4wMPI6tXOUJa1WhC+7wbRkPEbMBf7FVyRj01y5Ph40D+UsIdDnXg37hJ2ZQfhSG/sl
	O6PBdfGiQgT0DMU7orQGF/Pd6+jPwQrWWCeU48Pcpu1ragiPNF6eAHDO/6lvPGS1h/36o7ZlG+w
	==
X-Received: by 2002:a05:6000:38a:b0:487:36b:1816 with SMTP id ffacd0b85a97d-4871e244bd2mr18225744f8f.7.1790071318695;
        Tue, 22 Sep 2026 03:01:58 -0700 (PDT)
X-Received: by 2002:a05:6000:38a:b0:487:36b:1816 with SMTP id ffacd0b85a97d-4871e244bd2mr18225706f8f.7.1790071318182;
        Tue, 22 Sep 2026 03:01:58 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48862795232sm3867019f8f.32.2026.09.22.03.01.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 03:01:57 -0700 (PDT)
Message-ID: <99bcc883-1cbb-46f9-9283-cd03e5efafe7@redhat.com>
Date: Tue, 22 Sep 2026 12:01:56 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: dsa: microchip: save the periodic output
 request
To: Bastien Curutchet <bastien.curutchet@bootlin.com>,
 netdev-bot+sashiko@kernel.org
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, richardcochran@gmail.com, ceggers@arri.de,
 arun.ramadoss@microchip.com, pascal.eberhard@se.com,
 miquel.raynal@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260917-fix-perout-v2-1-d8acf3eea6f7@bootlin.com>
 <178998077822.2160803.3867886756893254872@kernel.org>
 <635cfefd-c588-4b3f-bbc4-1cf11ef0a2c5@bootlin.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <635cfefd-c588-4b3f-bbc4-1cf11ef0a2c5@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 9/22/26 08:32, Bastien Curutchet wrote:
> On 9/21/26 10:52 AM, netdev-bot+sashiko@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 2 potential
>> issue(s) to consider.
>>
>> Critical: 0 · High: 1 (2) · Medium: 1 (2) · Low: 0 (1)
>>
>> If you believe none of the issues are legitimate, please reply to each
>> issue of Medium severity or higher and explain why the AI is wrong.
>> If any of them are legitimate and you plan to respin, please let patchwork
>> know by including "pw-bot: cr" as a separate line at the end of your reply
>> (one such reply per series is enough).
>>
>> - [High] ksz_ptp_enable_perout()
>>    (drivers/net/dsa/microchip/ksz_ptp.c:226) commits the caller-supplied…
>> - [Medium] The commit message states that 'if a flag was set in the
>>    request that triggered the periodic output, it is lost when the output…
>>
>> Pre-existing issues:
>> - [High] A non-canonical but ABI-accepted period whose timespec64
>>    conversion is zero (e.g. period.sec = -1, period.nsec = 1000000000;…
>> - [High] In ksz_ptp_restart_perout()
>>    (drivers/net/dsa/microchip/ksz_ptp.c) the elapsed-period quotient is…
>> - [Medium] The device exposes three trigger output units (caps.n_per_out
>>    = 3 at drivers/net/dsa/microchip/ksz_ptp.c:1056, PTP_TOU_INDEX =…
>> - [Medium] ksz_ptp_enable_perout() resolves the output pin with
>>    ptp_find_pin() (drivers/net/dsa/microchip/ksz_ptp.c:206).
>> - [Low] ksz_ptp_tou_reset() (drivers/net/dsa/microchip/ksz_ptp.c:66-86)
>>    assigns the result of the TRIG_RESET read-modify-write to 'ret' at…
>>
>> -- 
>>
>> net: dsa: microchip: save the periodic output request
>>
>> The patch replaces the two stored timespec64 values (perout_target_time_first
>> and perout_period) in struct ksz_ptp_data with a copy of the full
>> ptp_perout_request, so that the index and flags survive a perout restart.
>> ksz_ptp_restart_perout() now replays the saved request with only the start
>> time recomputed.
>>
>> A few questions below.
>>
>>>      When a periodic output is initialized, only the start and the period are
>>>      stored, not the flags nor the pin index. So when the periodic output is
>>>      restarted, the request flags and index are always set to 0. So if a pin
>>>      other than the first one was used, or if a flag was set in the request
>>>      that triggered the periodic output, it is lost when the output is
>>>      restarted.
>>
>> [Severity: Medium]
>> Can request->flags ever be non-zero in this driver?
>>
>> ksz_ptp_clock_register() sets caps.n_pins, caps.n_per_out and the callbacks,
>> but never sets caps.supported_perout_flags, and caps lives in the zeroed
>> struct ksz_device, so the mask stays 0. The core rejects any flag that is not
>> advertised before it calls the driver:
>>
>> drivers/ptp/ptp_chardev.c:ptp_perout_request() {
>>     ...
>>     if (perout->flags & ~ops->supported_perout_flags)
>>         return -EOPNOTSUPP;
>>     ...
>>     return ops->enable(ops, &req, perout->period.sec || perout->period.nsec);
>> }
>>
> 
> This check is 'fairly' recent, it was added by d9f3e9ecc456 ("net: ptp: introduce .supported_perout_flags to ptp_clock_info") (v6.15). I experienced the reset issue on a v6.12 kernel.
> 
> Even if it can't happen right now, as soon as this driver registers any new flag, the bug will come back.
> 
> 
> 
> All others comments are already existing issues that can be fixed independently from this patch so I don't plan to address them right now.
This one:

"""
Should the request be committed to ptp_data->perout_request only after it has
been validated and the hardware has actually been programmed?
[...]

There is also a period that this check rejects but the memcpy has already
stored: period.sec = 4, period.nsec = 294967296 gives 0x100000000 ns, and
TRIG_CYCLE_WIDTH_M is GENMASK(31, 0), so the request returns -EINVAL. On the
next clock step, ksz_ptp_restart_perout() feeds that value to
div_u64(now_ns - first_ns, period_ns), whose divisor parameter is u32, so the
divisor truncates to 0. Is that a divide error in process context with
ptp_data->lock held?
"""

Looks new to me, and bad.

Also if the issue you are observing on an older kernel is already fixed in
the vanilla tree, I suggest instead sending to stable the relevant change.

Thanks,

Paolo

