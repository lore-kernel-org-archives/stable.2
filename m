Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE233EDAC1
	for <stable@vger.kernel.org>; Tue, 25 Aug 2026 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787650938; cv=none; b=FH1jRcduxiUHbMnn+GqgLfkLTc0bV1QEiFAlzivD8CMurQQSI1GuwxMPlgxV/+LYDa3vHCSb55JPBPSHDxsdI+yWgIIxN3l9D5vua8JqHVwwaxni6EKsXKYREoOJzKj0fsXYnfJ1QLMCxd2Vbq6M5uCJZz7QXrSfJVV9uB3gIsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787650938; c=relaxed/simple;
	bh=TRCjrVT6a0nm5nOjYaRUYlFXYFxAVmK1oCXXhDKXrQU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FIk6tSwZJZFJ8WAXmhx80jaqpcLS0Qvuzz0ckxyzlA9l+Yfaw0+nHIwqdJifDIMExGjxqTt67QLx2SpBw50AV9N7GSI53mH3w0+RlF5JtSuRPcsTgJYrsVgJT6Q29pAYPS1cugwgfhIHdHVLQwmEqOSA6Ly/VB/ki5RYSR1e1nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJkQrKGH; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJkQrKGH"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4957952e0f8so2825355e9.2
        for <stable@vger.kernel.org>; Tue, 25 Aug 2026 02:42:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787650933; x=1788255733; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qmTx7tD1rUFhIsjzkYVNdRt+/Y88by0P9eG+nC4RYUI=;
        b=nJkQrKGHMg+QqYc9gXw8NbGWR+jTs3nnBYuDucUOfqom4ztT9+UOAFrhGuL5NzbEXo
         4xKAbV9XzDi2DUI1V/Ifzx+5u6nMDZ+7b1fjgF9yhtW8wj8d+dtKVJk73p6B26Ch9HCj
         fYSJ6WK8j03C2mhN/tlGx+QYP1T5ohuzx2xDjuXjEaI2uLt4mZDjHR0DD2LvKFiAkt0T
         rwAEIXveV0gvJf2YC/sVwFCfb+Py3swp7hmE94i9xnPPAmBvuucuT2PGrD4kmkA0X/9Z
         zpS16GY/F/j0q0W4Qck0hDvrfXO2pTOq9IQVklBjAlTMFJGzT2+SbH9vzddTcWuMZED2
         id5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787650933; x=1788255733;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qmTx7tD1rUFhIsjzkYVNdRt+/Y88by0P9eG+nC4RYUI=;
        b=U0ug4KsAgv6Wjag0K2o3es/rcsf0XH6lnn5DI8v+vUIiCBcRwNKyRvhyGaxohFEZuU
         QRrwOZhmz4+LCxfSNHCrYC7uEqxG+WWFcjmNX9hoXIDZYHBnFl14vM6Z5odUMHStRnu+
         8Wxr/vUzRm1yQmn4JB524lmJmNntaIKETZlef6vdgdjOIFHP9e2tspPuoTBFCOJdlB7K
         IjQoze8kQidg94jQ1Ut3fpDveaJLsb4PL4cRZF0hV4Yancg5ETm6h2LTSoZ6LzinLHen
         kCBZGP3gnZ/fJdDcAIVdj9bpGe39JtxpYcNHNa16A2GPWonDAU0DELopqR1ae2fo/roy
         4YKw==
X-Gm-Message-State: AFuF++kbO6IRLkkzefNpNzBNcQLziGhYJVvWMguxvOjIV7vuygrwWYXL
	xdpwLzCEMWC4KsG2+Uc8MvXsNj9pslBTflFRi1PuWVHMbk3KuXKVIHUy
X-Gm-Gg: AR+sD10o7ldaTJ0tdAp4KqWxwDHWm0rFFEJmL6bNNgFSg5pySjJGyfCI7mql4UCeQg4
	4GJdqDYuxRASTEVY1IKfeVin0FVJ/18DUkFA/IhUW2220or6WjjDMgwUyeTrY/Bqi+LaLhUzAt4
	OaIU6kZ1t49RcGWq4xh/dSnH5rms0j4uzrIqp1T7VPMcQHbrODnaTlbZk7uLzvR39VM3kJFLjV6
	jko9G9gzXgj/PqjVY4dMzCR0o6cd5ABdWcwgGGnn5sSYXACVja1So4ds15GfFezVwvRtldOJ4K5
	Fu6dFVPqQitH5UoZCb1WCHvNpO2fBOuDM9WfowC2yIoITBQGFPKa/wvNk2tSwiXyrK2kJqc2bz2
	kDPMlRb9cDKTYcX0JHhpcF41ip9RBT5pdzYZhCUdnTTNgNOkQ2c//WT3coTFZ4/RTYsS8Z2S1Cg
	EU3ob58Yh2ozUCTn5kPYElNVKKX5vh1tROF0T1rppkXZc8ToYIjswjB6dNSPFLySRZ7DetEeS8x
	BLIEbioyMLgTBncGsel/NW9/dcTIKI=
X-Received: by 2002:a05:600c:1392:b0:499:a660:f4ae with SMTP id 5b1f17b1804b1-499b8353024mr204215045e9.1.1787650933330;
        Tue, 25 Aug 2026 02:42:13 -0700 (PDT)
Received: from [128.93.83.149] (wifi-pro-83-149.paris.inria.fr. [128.93.83.149])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499d63553d6sm23460235e9.8.2026.08.25.02.42.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Aug 2026 02:42:13 -0700 (PDT)
Message-ID: <a62fc816-259a-4d28-a265-e425bc17ed50@gmail.com>
Date: Tue, 25 Aug 2026 11:42:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thomas Fourier <fourier.thomas@gmail.com>
Subject: Re: [PATCH] tpm: Fix barriers to prevent hwrng from activating during
 resume
To: Richard Lyu <richard.lyu@suse.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: stable@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jerry Snitselaar <jsnitsel@redhat.com>,
 "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260803092240.18348-2-fourier.thomas@gmail.com>
 <anpm2fdZEwOlnMwv@kernel.org> <aogdHNl9HLMR89cW@r1chard>
Content-Language: en-US
In-Reply-To: <aogdHNl9HLMR89cW@r1chard>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Thank you all for your time and comments. Revisiting my patch after my 
vacation, I now think none of the barriers are actually necessary.

On 21/08/2026 11:40, Richard Lyu wrote:
>>> memory reordering between the wake up and clearing the flag is allowed.
> 
> When exactly can this reordering happen?
> 
>>> diff --git a/drivers/char/tpm/tpm-chip.c b/drivers/char/tpm/tpm-chip.c
>>> index 12b7394b34bd..7f500797b7a7 100644 --- a/drivers/char/tpm/tpm- 
>>> chip.c
>>> +++ b/drivers/char/tpm/tpm-chip.c @@ -173,6 +173,9 @@ int
>>> tpm_try_get_ops(struct tpm_chip *chip) if (chip->flags &
>>> TPM_CHIP_FLAG_SUSPENDED) goto out_lock;
>>>
>>> +    /* Ensure that device is fully resumed */
>>> +    rmb();
>>> +
>>>      rc = tpm_chip_start(chip);
>>>      if (rc)
>>>          goto out_lock;
> 
> Where inside tpm_chip_start do we actually need to avoid loading a stale 
> state or flag?
tpm_chip_start() reads chip->locality for example.  I'm not sure it can 
be written to concurrently but some drivers write to it. It might not be 
a problem as it would just trigger a call to tpm_request_locality().

Since speculative writes are not possible, so rmb() is sufficient; in 
any case, no need for a read-to-write memory barrier.
> 
>>> diff --git a/drivers/char/tpm/tpm-interface.c
>>> b/drivers/char/tpm/tpm-interface.c index f745a098908b..2de12b02f62b 
>>> 100644
>>> --- a/drivers/char/tpm/tpm-interface.c +++
>>> b/drivers/char/tpm/tpm-interface.c @@ -474,13 +474,12 @@ int
>>> tpm_pm_resume(struct device *dev) if (chip == NULL) return -ENODEV;
>>>
>>> -    chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
>>> -
>>>      /*
>>>       * Guarantee that SUSPENDED is written last, so that hwrng does not
>>>       * activate before the chip has been fully resumed.
>>>       */
>>>      wmb();
>>> +    chip->flags &= ~TPM_CHIP_FLAG_SUSPENDED;
>>
>> Can you rationalize this change?
This change is mostly based on your comment: tpm_pm_resume() is called 
after the hardware-specific operations have been performed, and the flag 
must be set after these operations are complete.

I assumed hwrng corresponds to tpm_hwrng_read() which calls 
tpm_get_random() which itself calls tpm_try_get_ops(). After 
tpm_chip_start() is called, tpm_try_get_ops() can return a valid 
pointer, and tpm_hwrng_read() can work.

Individual drivers implement the .resume() method by doing 
hardware-specific operations then calling tpm_pm_resume(), so ordering 
needs to happen between those hardware-specific operations and 
tpm_pm_resume().  This ensures that the order of operations is:
   - hardware-specific resume operations,
   - tpm_pm_resume(), including clearing the TPM_CHIP_FLAG_SUSPENDED flag,
   - check that TPM_CHIP_FLAG_SUSPENDED is clear,
   - run of tpm_chip_start().

If tpm_try_get_ops() succeeds, then tpm_chip_start() is run so the 
hardware-specific resume operations are complete.

> 
> I agree the clearing of the flag should be moved after wmb() to 
> guarantee that SUSPENDED is written last, the flag has to be cleared 
> after the barrier.
> That part makes sense.
> 
> My remaining question is whether we actually need the wmb() barrier here?
Revisiting the patch, I agree that this point is not fully clear. 
Looking at the implementations of tpm drivers, most use the 
tpm_pm_resume() function directly as the .resume() method.

Three drivers implement specific .resume() methods:
   - tpm_infineon.c: which uses writeb/outb that adds the necessary 
barriers,
   - st33zp24/st33zp24.c: which calls tpm_pm_resume() without 
driver-specific operation depending on the config,
   - tpm_tis_core.c: which makes a self-test before calling tpm_pm_resume().

None of those cases seem to require a barrier at all.


