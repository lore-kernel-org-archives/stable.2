Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB514367B84
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 19:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786563763; cv=none; b=HFCm7cdI/2W3CqJ7gjTjfbKQPfDRSpbrCdy59i1fY88TlO9HzMHM+GZlAj+sXLrqq9czq+M6nHZgYzn9tZoWVvLsJnDT/EPXvN0TrsQDjfBXuNP+NDfn9Ho/BrdGshRn+oCptPQqVlePjJX5GcwYqhNd2ncoMCFdq3F4c0GIAEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786563763; c=relaxed/simple;
	bh=eISd+hEgb4c3qR0e1EfQedosc8fxgnYoQNMskvbjX3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ltYLzRwc15mdI8DM318BzI+1+MP/wSkhYVyO2XZxWB2KHPC7g7xQVdLhEzOtzwaekVYa0cy1pmjqJaDwBhVarLMScQtfEdGrXLRkWdOydlDJH7KIzXVgKHsgTsH69FZhc7nAglvg7DEzXbrhf/DmZPInaoBvWiQfyJbmoZwmB3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCv4fT8A; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCv4fT8A"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38e041ea211so1635480a91.0
        for <stable@vger.kernel.org>; Wed, 12 Aug 2026 12:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786563761; x=1787168561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x28R8Syz/ACbEC+wTOFdBotlQUTS8Z7aqlLsrbeAKSM=;
        b=MCv4fT8AswGMxZmC2WMv+bbO81p6jgmYYp8Qv6uf4ZzSp/s1mHwZTK6eiWucY33R00
         Tk9zIKLYxC5yj3EZ9lPTLVv2tGWYZ9DmHeYa83EBQiEcuQr58WTzJBvWiTwX7Gd9+gLl
         ouN23uz6uLiIBqT5JZunJwGZ19t4Q++TEYndKZ7S7mf/WuLxRkT66lsgZr7AgPyY4lFI
         +FSJ5eO04v18gc6nWJOjls2DvhhWjtqtu7YtJkz99YbalqxCjWjIYaS8WGMZhkbO4SC+
         7iCOAk6x/+BYQJDxmeGND+8i5vDy8O8swQ6+aSKMPDJyRLdpvfy6wDzKjI8auG/UQ1a3
         JjTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786563761; x=1787168561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x28R8Syz/ACbEC+wTOFdBotlQUTS8Z7aqlLsrbeAKSM=;
        b=aTWLeiSJ5Z7+UUaYUZ9LpXFjaIqgvlRaBA1S6eLkDA258iUbyw0RqsniwiGkB9B31H
         5D0xZIOkFkA7jiPFlSNRcFm+Rdzmcqy7XvmXRnNiLU4BXmLg/97MDgZ3MBumXb7zHb4H
         ip6tnHARX96wmbWGhoZsZPCOK/qaJrqvV36gdPzS83zo8pwPegdsU9FSFKdEtiGebAXR
         aYfrscH6zSrufpo9rlSTo7HcrviaZxIToXAlnud89ghcuvtoAUxSFEulKrXyHIuG89I2
         NRmFsRIo1Qz2oGZJnvI0juCarQ36Mvv4FlU0JAPRO/xVtM2mZiodK7G+pc/XpsVErpi0
         6phA==
X-Forwarded-Encrypted: i=1; AHgh+Ro+w+yk1bXbkrVpfSmcdJvvB6aHuTR9F8U8Hmj/+wqUTroBIHU2Cd/pH7nJ2kPRQWRctsMlxXI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhFtnTnCKr32W0NRmbsBkr1TQ6/tF+O8Grfr4GNrQ+fUvknkkr
	ZEpP1Abw1Ea9ZqeiDPo5dmRZOFs4wcE60UFhuFkWcHTNjFfUdUHt4NBO
X-Gm-Gg: AR+sD110b8UoG3B/rM4sVpwxgVVw+V17pjabxAOkwKUSCJ4VY2qbBVg9tfLrCkCEs7J
	iNLReIP4dHn+/t9MktCDk7ODmwRpiaaPUxMm0U5RxAb4SmmwOF54AnOudNzjhlLOGI7xe1X7CQQ
	KXjC1zEo8vNytTpHUhDD7/P/jDYIwSegsK3EQIrjlnj3ntm514hrTbTXmPbx0hSDtAixPKFzJ0q
	qp191t26HoX6gIQVm47meC57jJvTXecld/WnZPq9Xv+i6SIWvZSluEFBALQzs+6kNxrz4oVySqB
	R7xN+CFQAVDdo95/A4jymdmEh0tK2MdOLuy6Qpiz7UY3fSILPjfWSLcYb1Up3srGSZYhQSCCvEb
	OE0DqW/f4cJz8uUPwHiIcXbIKMtcYZ9LyDUN/y9zCik8e07RVxioe0kqEs3UvLMBPlsFRNvwUDU
	PXeie1cZtr6Q8p/s3E7idVDD6g+a3X8P2dOEeLCnasCuvtS0CCopLcXqn+SYjcdKiJxQ==
X-Received: by 2002:a17:90b:3b81:b0:38d:f5bb:e0f4 with SMTP id 98e67ed59e1d1-3931dfe6479mr716266a91.1.1786563760947;
        Wed, 12 Aug 2026 12:42:40 -0700 (PDT)
Received: from Default ([2409:40f4:1019:468c:4dfb:a166:9b41:1fa8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31cf3621252sm16726993eec.1.2026.08.12.12.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 12:42:40 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: skhan@linuxfoundation.org
Cc: gregkh@linuxfoundation.org,
	i@zenithal.me,
	jeffinphilip14@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	shuah@kernel.org,
	stable@vger.kernel.org,
	syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com,
	valentina.manea.m@gmail.com
Subject: Re: [PATCH v3 0/2] usbip: usbip_host: remove legacy rebind_store in favor of drivers_probe
Date: Thu, 13 Aug 2026 01:12:24 +0530
Message-ID: <20260812194224.9293-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <647d51b8-bc02-40a7-8cf0-3a76f950c7ad@linuxfoundation.org>
References: <647d51b8-bc02-40a7-8cf0-3a76f950c7ad@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 12 Aug 2026, at 13:31:50 -0600, Shuah Khan wrote:
>On 8/11/26 20:40, Jeffin Philip wrote:
>> On Tue, Aug 11 2026, at 16:53:23 -0600, Shuah Khan wrote:
>> 
>>> On 8/11/26 10:05, Jeffin Philip wrote:
>>>> do_rebind, which sleeps normally gets a mutex lock. However, it does not
>>>> or should I say, cannot check for null udev between spin lock dropped in
>>>> rebind_store and entering do_rebind. This is a potential race window
>>>> already. So, even if we check for null udev under spinlock, we cannot do
>>>> it outside. Regarding do_rebind, it is called during stub_device_rebind,
>>>> but that function is called during module exit when all files are removed.
>>>> So, do_rebind is not designed to work in a concurrent environment in the
>>>> first place.
>>>>
>>>> We have a safer function that can already do what do_rebind does,
>>>> drivers_probe. So, we use drivers_probe to rebind the device rather than
>>>> use rebind_store.
>>>>
>>>> usbip tool references this function immediately after the device is unbound,
>>>> which is safe for the tool itself but since we opted for drivers_probe, fix
>>>> it by using drivers_probe rather than rebind_store after unbinding device
>>>> which is more safer.
>>>>
>>>> Tested and working in both userspace via the tool and manually echoing
>>>> the busid in the related nodes. rebind node is still left active with a
>>>> warning to use drivers_probe upon encountering rebind_store.
>>>>
>>>> Thanks,
>>>> Jeffin.
>>>>
>>>> Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
>>>> ---
>>>> Changes in v3:
>>>>    - Removed rebind_store in favor of drivers_probe to eliminate race
>>>>      condition
>>>
>>> How did you find this problem?
>> 
>> I found the problem on syzbot and had to reproduce it using the following
>> commands:
>> link to issue: https://syzkaller.appspot.com/bug?extid=af76b01c9a0f0ab60fb0
>> echo 'add 1-1' > /sys/bus/usb/drivers/ubsip-host/match_busid
>> echo '1-1' > /sys/bus/usb/drivers/usbip-host/rebind
>> 
>>> Is this generated code or did you write it?
>> 
>> No, I wrote the code myself.
>> 
>>> Also, the first patch removes code in rebind_store(), replacing it
>>> with a pr_warn()? The second patch points it driver_probe() - what
>>> happens with just the first patch?
>> 
>> It just prints out a warning. I did get a -Wunused function warning
>> while building the kernel for testing and considered removing it. I
>> ultimately didn't as scripts running on newer kernels(if this
>> was merged) would break as there is no rebind node. Should I remove it?
>> and is pr_warn not the right way to deal with this? If so, please advise.
>
>Okay. But why is this change split into two patches? Does just the first patch
>work correctly?

The first patch is for people echoing the busid directly to rebind node, so it
just prints out a warning asking them to use drivers_probe. The second patch is 
for the usbip tool, as the old tool used rebind store for rebinding, we replaced
it already in the first patch and since 'usbip unbind' rebinds the device back to
the usb driver after unbinding it, we cannot use rebind_store like the old tool.
That is why I replaced rebind with drivers_probe in the second patch.

>> 
>>> Did you run tests to see if you can bind and unbind devices - does the
>>> driver work correctly?
>> 
>> Yes the tool works correctly after switching to drivers_probe. Devices are
>> bound and unbound correctly.
>> 
>> The function also caused an invalid opcode while testing in an unpatched
>> kernel with a different sequence: write to match_busid, then write to bind
>> and rebind, followed by writing to unbind. 

Thanks,
Jeffin.
