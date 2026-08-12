Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C6137475C
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 19:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563121; cv=none; b=RPBYxbMjOHkDOvGP3+KOh9wuMqlStxulaAerkPi1tJoUGuREXAHgaMOcVTK8gvmJljnU2HjT+2qqabS1pBdN9R0Kyt+SGMeo7wRRihSn9TNTwzB8t0KsZmbHXzNIXomp+qYQX6oZvq6yFqip2nUBHzMyll3vgZsG++7NYVDxxDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563121; c=relaxed/simple;
	bh=+qQRiiUCwQCD20Re9tDOWLm8g4UGUDN1XvkW0NPnfeA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OyQ6bVWd5j4Zr2luwbEyAjrxCrq5IgsdDaV38kdslT191tZvnh1SQV7Ih1MTkW0tiwWMVRGZBD4taRCcu2LRwo6uW3eNIgukGESS6JsbCgev4K8Q/a/1l9qqpqSx/1LUBWZiwpz3lTM8+m2EzvjBqrA1I14OrIg1P1+asdGbReM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LymSNHcT; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LymSNHcT"
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4a451915d8aso802311b6e.2
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1786563118; x=1787167918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JO8wtDZ5KajjBoQwQfJOX0LnbQbHRiyuBi4hT4PtKNA=;
        b=LymSNHcTwB/ZhqtTvjbj+KhWts8iEjrtKOUKgmkd0ouU9JabYt1mGhQ6IJ3A5yG+ml
         VHBrXy+CN4or1Tehywp9euygxhFWb/nfyKxCmVqywgVPnq3kUgtqKKk+voHk7xEFAKRn
         iN+kesYagL3hGTeV3vDCDxwGiFTmWFIPZElgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786563118; x=1787167918;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JO8wtDZ5KajjBoQwQfJOX0LnbQbHRiyuBi4hT4PtKNA=;
        b=jvsy2Pq4l0c0ezIlrQNg9HY90lmcFo0EukXa0kO+3WFgEfDwZWeMn77ND9ga7Ff4Pv
         zyFbb2ZBOnQnjL+o1IlIf90g6YuWwmHcroFSAPJbz/wsi+DKzXjccB29A8goia80DH0S
         24L9KfhGIKANl5o0rFOSU1ujoV58JO80eSqm/emic1Ads6MzGwO3slh6FAY61VScsMEw
         ELXcVxxk1DccDwW1xnc27IPOWeVlbE/VKhvy2ylXQzX9sWXaZlt1i2e75YVEMy5Nd4W2
         enReAovx5qd7eUnPCdUlLT1FCmudBpSRrcfhSSqvht06BY7x7PqD7Ez9wLdViJ+FtYll
         7vBQ==
X-Forwarded-Encrypted: i=1; AHgh+RrJ3/dsiM07Kbs//mxZ2yQaClItCcgzz2VyEwLjshwGBOrYi70iLXJE+Y8M8+zSKCjY6HWS/9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJxYAxpIGw6rEy7NywNT8QJBiPFAV2oIZLqr5iYwo+YIaUMQbK
	CalQFcczc+SU4vyLmGLa/Tz2KWneszRFCD3KKuqn+RzZbTzkqqe6t5raYHXQ2mN29tI=
X-Gm-Gg: AR+sD12yqL+6+g5K8rOfTkS/TqtAR2c64djoK7L+m3JXEmiU6py7K4eMWFYpz8PbAmi
	kMMSeLk5gl/mYaa2HeWAaM3QcZ+LpJzfJRy6Ipwmql/CRthCt2+qMlAHw3C1UaxDRwnK6QDsr4h
	dZZLQP+lubLQZ5Hts+XHCYGPGFg8ZELKgOrcXOp9FWroNKqc0s3LbRRie+MVx9QiI4+b1BPNaD7
	htguylRzDkd/vEkBNXf79J4DVYm0PAmuOTZaqQoYLANnr/GtetgFyD2uWfmomFRqxJtvAMRUp9F
	dR0LfccR4wcafRNsLlW/a8PTs6v8c0k7rDndEfKxcvCLtnOXVUbOvYiadQcxjceTq62mF4S4ML7
	ojh9wAvcCobuN+F9PgyRoSYTnoUnbgO/aAr9UxYHgTcyssfYRJJv3pXS06K7w/fGX4h7Nd4csU2
	03jhOJNg4hY2FbytI9hx0ZoenU7Dav6TYb6+mnPaM1z4SCTM8o6jLpt34QgQBMd976Wnm+8w==
X-Received: by 2002:a05:6808:640f:b0:4af:5b7e:e5ce with SMTP id 5614622812f47-4b227790286mr185589b6e.3.1786563113727;
        Wed, 12 Aug 2026 12:31:53 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.57.99])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b22347c0basm631294b6e.6.2026.08.12.12.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 12:31:52 -0700 (PDT)
Message-ID: <647d51b8-bc02-40a7-8cf0-3a76f950c7ad@linuxfoundation.org>
Date: Wed, 12 Aug 2026 13:31:50 -0600
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] usbip: usbip_host: remove legacy rebind_store in
 favor of drivers_probe
To: Jeffin Philip <jeffinphilip14@gmail.com>
Cc: gregkh@linuxfoundation.org, i@zenithal.me, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, shuah@kernel.org, stable@vger.kernel.org,
 syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com,
 valentina.manea.m@gmail.com, Shuah Khan <skhan@linuxfoundation.org>
References: <e3473010-e995-40b6-9040-e38f51d1a6c9@linuxfoundation.org>
 <20260812024050.11267-1-jeffinphilip14@gmail.com>
Content-Language: en-US
From: Shuah Khan <skhan@linuxfoundation.org>
In-Reply-To: <20260812024050.11267-1-jeffinphilip14@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/11/26 20:40, Jeffin Philip wrote:
> On Tue, Aug 11 2026, at 16:53:23 -0600, Shuah Khan wrote:
> 
>> On 8/11/26 10:05, Jeffin Philip wrote:
>>> do_rebind, which sleeps normally gets a mutex lock. However, it does not
>>> or should I say, cannot check for null udev between spin lock dropped in
>>> rebind_store and entering do_rebind. This is a potential race window
>>> already. So, even if we check for null udev under spinlock, we cannot do
>>> it outside. Regarding do_rebind, it is called during stub_device_rebind,
>>> but that function is called during module exit when all files are removed.
>>> So, do_rebind is not designed to work in a concurrent environment in the
>>> first place.
>>>
>>> We have a safer function that can already do what do_rebind does,
>>> drivers_probe. So, we use drivers_probe to rebind the device rather than
>>> use rebind_store.
>>>
>>> usbip tool references this function immediately after the device is unbound,
>>> which is safe for the tool itself but since we opted for drivers_probe, fix
>>> it by using drivers_probe rather than rebind_store after unbinding device
>>> which is more safer.
>>>
>>> Tested and working in both userspace via the tool and manually echoing
>>> the busid in the related nodes. rebind node is still left active with a
>>> warning to use drivers_probe upon encountering rebind_store.
>>>
>>> Thanks,
>>> Jeffin.
>>>
>>> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
>>> ---
>>> Changes in v3:
>>>    - Removed rebind_store in favor of drivers_probe to eliminate race
>>>      condition
>>
>> How did you find this problem?
> 
> I found the problem on syzbot and had to reproduce it using the following
> commands:
> link to issue: https://syzkaller.appspot.com/bug?extid=af76b01c9a0f0ab60fb0
> echo 'add 1-1' > /sys/bus/usb/drivers/ubsip-host/match_busid
> echo '1-1' > /sys/bus/usb/drivers/usbip-host/rebind
> 
>> Is this generated code or did you write it?
> 
> No, I wrote the code myself.
> 
>> Also, the first patch removes code in rebind_store(), replacing it
>> with a pr_warn()? The second patch points it driver_probe() - what
>> happens with just the first patch?
> 
> It just prints out a warning. I did get a -Wunused function warning
> while building the kernel for testing and considered removing it. I
> ultimately didn't as scripts running on newer kernels(if this
> was merged) would break as there is no rebind node. Should I remove it?
> and is pr_warn not the right way to deal with this? If so, please advise.

Okay. But why is this change split into two patches? Does just the first patch
work correctly?

> 
>> Did you run tests to see if you can bind and unbind devices - does the
>> driver work correctly?
> 
> Yes the tool works correctly after switching to drivers_probe. Devices are
> bound and unbound correctly.
> 
> The function also caused an invalid opcode while testing in an unpatched
> kernel with a different sequence: write to match_busid, then write to bind
> and rebind, followed by writing to unbind.


thanks,
-- Shuah
