Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606745;
	b=O1vHAU8eUzyla+H463ubN7QLYHCuU+rWXSxr+sPkpmJhvvRxeJlMrQpWYXnn7WSHFChn
	 C4T7+SYVPuPSQHg4aMWj4T+9i/xF6Cn6s0URf4ycl7GB8/rWfmwxuRuimG+bgqBr0j0WS
	 wBXg8jHosfGiTdisDrVtrgXROn5dw/UPWMc5TQ4CGAt3OIkPAlCYErroeBPOAtx1uhgok
	 +OWQl/CWBRjTFciNEt7ICoz76vpLaMgs4TssffCfnKQML/VinPTK8Yliqffvcwfi8TngO
	 B0joL98XoZnn2jWqGBTdcP0Pf8mD6qaGQX8X6TqBP0KMfr2DI0Fv8CPr+Dlz8aEASzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606745;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=MVWBICeTjf8qK83d1J+ekt2+KhQ2TiQiLz4B4oi35/4=;
	b=mtvAGte138r9qIkTaOqHNijq/Ujd1ZkNUq5zyqFh1aBSkhh2Jt65BJnlt6S+0eDSn4sD
	 iPo+x3iX3Z/EVGAo6MCL93ZI190rYrMF0QGTSv0f8cWX8ZByKDCDIRFGyc/lZVImbZBqc
	 PQcWZWMmxBFkaCxltKgd6TTFT6M7wLKrPBQR4CwGy+MqTyvsHucV+jDhhdHb+2VhQGDFX
	 gnjM+6MyHksrha7m8OcfohQZVshzfh+6W5VK2kR2Tub7Handngpas3kEMn4qom7sGEskX
	 5SMOzQwm/KB4Pj/awBWIsTAEk1dYktmdRoUakylyM6lpy4uJsbEtay52A/tFfBSvLDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fOV73sjb;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rDEe25b9;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821E7606A327
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:39:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 821E7606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fOV73sjb;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=rDEe25b9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1795606743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVWBICeTjf8qK83d1J+ekt2+KhQ2TiQiLz4B4oi35/4=;
	b=fOV73sjbuarzCZOdYz0xuUx+25nR0y8eU5WwFxze2ZPH8THiy1cjhPabl1XZsNxEoRvyvB
	H10MrnDt7yQjqto6fq/4JhuEdVrzbLBFl6X18JaFbUK3KthsS6jXejJ0E6if5kZbYYcm2E
	cdNIUWyvDs+tHTRo5nZVnRdpdZFxlbo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-bhQlY1sVNp6wkAAi-cjTcw-1; Wed, 25 Nov 2026 11:39:01 +0000
X-MC-Unique: bhQlY1sVNp6wkAAi-cjTcw-1
X-Mimecast-MFC-AGG-ID: bhQlY1sVNp6wkAAi-cjTcw_1795606740
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48c6a1d4034so3254590f8f.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 03:39:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1795606740; x=1796211540; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MVWBICeTjf8qK83d1J+ekt2+KhQ2TiQiLz4B4oi35/4=;
        b=rDEe25b9Tb6MiYVtOtS70qf9qM222Mm7/NgjCdRbtEuo+gLxFFNKWc8vOFfcwCe0Qe
         eEodUbK2T/gyueczGpyvuup/3kHGUHey16w02055R+wspZIJ5AV8IgT1W9nkvdT5s/aa
         i4f7SZUmXBLeaDsrhXqkEWC9gIpIc/RJUGbKcZlhrDjAsR7H6vfv+XiOo4mjJ8ZvqdxG
         bmcfP1rsm90rvAkjyCyuYkk8P64TTTG6gv271Bxb8Rby6X3zseASncUAcWyVkp7ZSkuQ
         t/ufDZxf0LpYzKF/sb7XfgIaLRm6Utx2OBj0oaMNAeZ65stXVJD0aZEXfSR2Q4/FMzbr
         MSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795606740; x=1796211540;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MVWBICeTjf8qK83d1J+ekt2+KhQ2TiQiLz4B4oi35/4=;
        b=GFJQp+4Fi2Qd1cUx89k8xzQL1nmEzwTtGLosSO7O+nDrprP65erC0xD9bK8ZV+BKma
         +8EQrKeynxyix9CxLV+Okh8CJ5ColGZF2CIudHd+jwjEuFI95equlUVgdpmPOvb/pyqs
         WyXluQxVyxqpMY7mekdjHjkFLkdD0+iJie0oKtB1Gm/sigIFJkIba4YJwBGY2CZWG7Jr
         Zji55ZFrG8d6XIWdm6ydnCgvI0FjXHveMVT8LpGjnrKqT6Q8FeSlBRmJLZEhJnodnqGW
         602E3XAlM2Kr6eigoI+YVAS+iVYcCorf/PdzujeKqGlTm7OIXcFK+v4vLtamDwkdiKMT
         0jAQ==
X-Forwarded-Encrypted: i=1; AL+hErGULoovpwy0jm8ut7dYcSPvhXmUjZAfGj/fBcbpqbBYmsDp1pRrLCyt5WnI973BycIteF0XBCA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FsmTPalD8j9rkKiZcK1K5qbzpZhR/T4QTjnUteEMIjMZQU+aH
	DxHs23GcCCUuJkI92e25LnEyxfLyveyqLmudU+3WUtrTbJXTSVwr/yM6On2o4vP0cYaeM0nwpd1
	n6R99iG4PGXRACJ9dtYKRvEuTQwjbOjEisbL0N+NLYCJbe9JDk4BKCyBeZZ9Zrjd+Og==
X-Gm-Gg: AZFdTZeSPIEVWXI9Mz3Savt0Jhp6EbXqCCSSeJfOcWbLrdezR0c//qGcxx3mgkGtrXn
	+fFxkYbExOnY6fyeccIOAnDmpiYouj0ksFHwXFHHG/KKN82cYfRjfRIF11QM0rQU2i95DFvVQa7
	qp7rNFMrvmYNief2/HC5NlrZJklrJ/5OUi+keFfeicoN9F1EdbAst+WJBHwK479Z2pIf0/mWc+k
	ljmmrqLhWBAwidAwPRfSqml0ao/kXl97Xq2aV9iOmqks2ADsCEBfBi/WM9Ud+OU6L/C51hqT2q6
	FbEtH5sx7cD8WsRZMJaELkpZnSYLOvmQ9Km0oHvaeUcJUHEIliQGG3O3zzZy/kBcqWyTLSqcfdQ
	nGPUfzaykiChpsq9Nn0jpnCNupp1B82yqxlj3JlXFfoQZrIEStBaCVjzec6ezzNDeKi8dtwic7a
	70Ck2LkrN2NvOfI2KpMw733peyQ4Lk8Gz+iiOls8HXSovZ
X-Received: by 2002:a05:6000:4025:b0:4aa:bcd2:c3ff with SMTP id ffacd0b85a97d-4abb71cbb6cmr29938997f8f.31.1795606739852;
        Wed, 25 Nov 2026 03:38:59 -0800 (PST)
X-Received: by 2002:a05:6000:4025:b0:4aa:bcd2:c3ff with SMTP id ffacd0b85a97d-4abb71cbb6cmr29938951f8f.31.1795606739409;
        Wed, 25 Nov 2026 03:38:59 -0800 (PST)
Received: from [192.168.88.30] (ip231-128-192-82.pool-bba.aruba.it. [82.192.128.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab69bf680fsm38650991f8f.14.2026.11.25.03.38.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 03:38:58 -0800 (PST)
Message-ID: <fdc005b9-e48a-4550-b66b-0f58db82babe@redhat.com>
Date: Wed, 25 Nov 2026 12:38:57 +0100
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
Subject: Re: [PATCH net v3] ptp: vmclock: keep the device state until the last
 file is closed
To: David Woodhouse <dwmw2@infradead.org>, Chad Aldreda <ca@modelmiser.com>,
 Richard Cochran <richardcochran@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>,
 Shuangpeng Bai <shuangpeng.kernel@gmail.com>, netdev@vger.kernel.org,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261119061517.1142436-2-ca@modelmiser.com>
 <1f77fa9014f8dfafb2be9cf15a66c5541880656a.camel@infradead.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <1f77fa9014f8dfafb2be9cf15a66c5541880656a.camel@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/24/26 20:44, David Woodhouse wrote:
> On Thu, 2026-11-19 at 06:15 +0000, Chad Aldreda wrote:
>> vmclock_probe() allocates struct vmclock_state with devm_kzalloc_obj()
>> and maps the shared page with devm_memremap(), so both are released
>> when the driver is unbound, but an open /dev/vmclockN keeps using them
>> through its file state. After an unbind, read() runs on the freed
>> struct and reads through the released mapping, and a poll() in
>> progress sleeps on a wait queue in the freed struct. KASAN reports a
>> slab-use-after-free in vmclock_miscdev_read(). In testing, the same
>> read() faulted on the unmapped page once the device had been bound
>> again.
>>
>> Allocate the state with kzalloc_obj() and map the page with memremap(),
>> and release both on the last reference: open() takes a reference and
>> release() drops it, and a devm action drops the device's own reference
>> after vmclock_remove() has called misc_deregister(). misc_open() calls
>> open() with misc_mtx held, and misc_deregister() takes misc_mtx, so
>> open() always runs while the device's reference is held.
>>
>> vmclock_remove() now marks the device as removed and wakes every waiter
>> on the wait queue. A read() or mmap() on a file that is still open fails
>> with -ENODEV once it sees the mark. On a device that supports
>> notifications, poll() returns EPOLLHUP | EPOLLERR, including a poll()
>> that was already waiting; it tests the mark after poll_wait(), so it
>> cannot miss the wake-up. The wake-up uses wake_up_interruptible_all(),
>> because no later notification will reach a waiter that the remove-time
>> wake-up skips, such as a second epoll instance that registered the file
>> with EPOLLEXCLUSIVE. Without notifications poll() already returns
>> POLLHUP.
>>
>> Separately from the report below, the bug was also found by a
>> Coccinelle script that reports device nodes in devm-allocated memory,
>> posted at
>> https://lore.kernel.org/r/20261106193517.3267013-2-ca@modelmiser.com,
>> and reproduced in QEMU 10.2.4 with -device vmclock. There is no access
>> to EC2 hardware with this device, so the fix has only been tested in
>> QEMU. QEMU's device has no notifications, so the poll() path was tested
>> with a local change that lets poll() wait without them.
>>
>> Fixes: 205032724226 ("ptp: Add support for the AMZNC10C 'vmclock' device")
>> Reported-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
>> Closes: https://lore.kernel.org/all/178144969601.60470.14493569608271069160@gmail.com/
>> Cc: stable@vger.kernel.org # 7.0+
>> Signed-off-by: Chad Aldreda <ca@modelmiser.com>
> 
> Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
> 
> We did have a plan to pull the PHC-only drivers out into drivers/phc
> and leave only the *real* PTP in drivers/ptp. I kind of stalled on that
> because I wasn't sure I had consensus especially from Richard and the
> net maintainers. Shall I revive that and repost it?

I'm sorry but that conversation is way of my context window. Do you have a
pointer to the prior discussion? why such separation would be useful?

/P

