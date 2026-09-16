Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DDCE4908B0
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789549664; cv=none; b=HyCwfuTY0raCL5VM2zCyx4PjEKqVrBABuJXJw3Z+NU38nzyeaeAsJfQoYBplfQLGVacLqROnCK8BzvdddsL32kQ66yWZi7bonQKRohPFeo90y9WgmZO7rBUVSL5ynVW0RBN75+fpIFA40Xl8kYBzmafbEPaAOi7RAQ2dVUEFi1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789549664; c=relaxed/simple;
	bh=/oSHeo+dHrTJ4BeaXgDyE3G967AhC/96LwQQ8JcP8WA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BYWNizQ4Xwfxo2PekQlyrHP8l5KimIWcug2KkfLxIiJpA5LK7FaQ3F1Ec+5LtkFEFyktPStu7DEkjj7DAXpfZZHk+0T8mb2KYC3OUxORN25X/RFow8iwZh/BCwJSzzsQbwfSyewjZWIgCT69E8StSnjQzEFcVer/sRneFQQ1y2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GLV8fORQ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GLV8fORQ"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747f05ffcso4626255ad.0
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 02:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789549642; x=1790154442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/oSHeo+dHrTJ4BeaXgDyE3G967AhC/96LwQQ8JcP8WA=;
        b=GLV8fORQ821+tCJ1eEdWqiITJkiQGR6zLDx6NGw3kw1lrhpz5iQTZscXxR+Ny7Rlsz
         xC6EzehnUaEGVyyLDhKEzpgcd06Qug5aDN41IsGTf40yigTKI8xpG5rsnG0C4gK7d6yV
         NZ20uMCGsIU0vQL0Q+CSnBe1hOYTPBNe3i32L7mShmVrurvQKlTXWdsFLZ4eYkEQgan4
         6rRZpjSgxOjXvg+PpNaKYL98ArpwKSAqpl3zbAAImS76bnGMc0JqqqkTN1IJKHJgvQfl
         VNPOzRH0dnKB+KN2fjvu70KLxHx2TYJfnGRIx4LIN+drHEM+rtotEFF69sFclW+OQZRi
         OOeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789549642; x=1790154442;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/oSHeo+dHrTJ4BeaXgDyE3G967AhC/96LwQQ8JcP8WA=;
        b=UswHv0vhjsYgYnDO1u8vs6zJahzfKYV1P+3uxJDE2yMTNSAdVcJfkPrXKoVgj+iciv
         8rzEvcNmnpLJeWXoKD2IjTN5nAAa5qvwmNirDdGBrOtX3ZnQsGJT4VFi7MqGtcCdg8iT
         Uz5jIVNgLT+ARddYhIVBW910hiYzupvERUAOpzOvUC0D590QC4tCElcJADirTlveaq70
         GY4YI7/vp2gJYd478l1kuRvuWZjNUpDJ9rD4okwPAbQK3fr04DMW1Lj+ZSiQgUQGhwNG
         nRy4r16eit7RaO8H2tlyXNwpzXtWh6tr+eZpY8Q1FR7fCta1mWiz6zH+XuT9nDVGwvYF
         xGmQ==
X-Forwarded-Encrypted: i=1; AKwUvByTjpQ0SnrnBZTn4BYsv83jvl63Tdd5hMqzzwmQkxm6SE9/uNJXZAXF0MJrOyqYk/SvyKXXOzA=@vger.kernel.org
X-Gm-Message-State: AFuF++lhuB+OYunGsz65gs41t/PvmG2oAry2Kz9Jut9IRQT+zfxTMz+z
	6oOKz09mxyFCphxoOEOqiQn40Uolk+G6Vb3HBLwn9ceESOt2evFOzf/6
X-Gm-Gg: AYBFou13BaytvgosNPNdktX+StzvKs6HTUsGywEW+mpFjPeIBJCrGY6zaSrbMLTAD4e
	Rp2yNP4y6NUxnhYcFYMHCblsyvz5iIhQld4Nac9HlXZcIlPflxl2UqU3VJMuKkEGtixe9SXZ49l
	mWv0baNUbnVamZN/gxrSOOlLsKhkEATlrG/GS0TXYcExf1uEsr0OreocoQpxmbvrP/79VIgrn+D
	aY66JoIBf9XzXrZXkNFFP4YvycgG1/NujRZz2EQ0BcfhQxrzC+1dzQzMSxWWb0qaM+N2Fllo3m8
	3aLZBhuGfMKaOD1cjavHSyhZY7/CViJMzwQL5zIacKhbea0czpLg1GdCxhIBU78SVFZRn+ZCOSA
	5W9AndMyBJ5kt3nZBNLZpQQBIEVP696EWKJVkCOBzSH5lN2N/8J9NqodM9DUADMja3+ht92Jb9q
	+TwRKbN94RhfL4Cmxxyc9ULp8odZZixIPsdMuHBh3AJPdydF/Rwbko73ctbY/wcNf8RjjxKw3XS
	aFLr0GKHbm/wkeDO9MM2l3mW6Mn5JDdAlW2KA==
X-Received: by 2002:a17:902:d547:b0:2d0:cc92:f7a9 with SMTP id d9443c01a7336-2dd8dd0b15amr37176235ad.4.1789549641965;
        Wed, 16 Sep 2026 02:07:21 -0700 (PDT)
Received: from [10.89.160.219] (wf124-219.ust.hk. [175.159.124.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89eb7d15sm8234195ad.39.2026.09.16.02.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Sep 2026 02:07:21 -0700 (PDT)
Message-ID: <dc927d3e-e7f1-461c-9a75-259f71899224@gmail.com>
Date: Wed, 16 Sep 2026 17:07:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.12 1061/1376] nvme-apple: Drop the PRP null check
 chicken bit
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Joshua Peisach <jpeisach@ubuntu.com>,
 Janne Grunau <j@jannau.net>, Sven Peter <sven@kernel.org>,
 Sasha Levin <sashal@kernel.org>
References: <20260912065607.535295758@linuxfoundation.org>
 <20260912065631.206877541@linuxfoundation.org>
 <9be379ae-7589-40fb-a0b0-4d4659f46e71@oracle.com>
Content-Language: en-US
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <9be379ae-7589-40fb-a0b0-4d4659f46e71@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


Harshit Mogalapalli 於 2026/9/16 下午4:32 寫道:
>
>
> On 12/09/26 12:28 pm, Greg Kroah-Hartman wrote:
>> 6.12-stable review patch.  If anyone has any objections, please let me know.
>>
>> ------------------
>>
>> From: Sven Peter <sven@kernel.org>
>>
>> [ Upstream commit 8ce883fd068b7ba9ab493cd3ecca3a7ea868c375 ]
>>
>> Now that we program the DMA direction correctly the NULL check that used
>> to make commands fail passes. Another side effect of this bit was that
>> non-align buffers on the admin queue were silently allowed and that's
>> been fixed now as well and we this don't need this chicken bit anymore.
>> More importantly, starting with the firmware installed with macOS 15,
>> which is required for M4 but can also be installed on the previous SoCs,
>> the controller no longer exposes this control register and any access
>> SErrors instead. Just drop the write entirely.
>>
>> Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
>> Tested-by: Joshua Peisach <jpeisach@ubuntu.com>
>> Tested-by: Janne Grunau <j@jannau.net>
>> Tested-by: Nick Chan <towinchenmi@gmail.com>
>> Signed-off-by: Sven Peter <sven@kernel.org>
>> Signed-off-by: Sasha Levin <sashal@kernel.org>
>> ---
>>   drivers/nvme/host/apple.c | 14 --------------
>>   1 file changed, 14 deletions(-)
>>
>> diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
>> index 8fc466588c4f2..5f745bf615fe7 100644
>> --- a/drivers/nvme/host/apple.c
>> +++ b/drivers/nvme/host/apple.c
>> @@ -47,9 +47,6 @@
>>   #define APPLE_ANS_BOOT_STATUS     0x1300
>>   #define APPLE_ANS_BOOT_STATUS_OK 0xde71ce55
>>   -#define APPLE_ANS_UNKNOWN_CTRL     0x24008
>> -#define APPLE_ANS_PRP_NULL_CHECK BIT(11)
>> -
>>   #define APPLE_ANS_LINEAR_SQ_CTRL 0x24908
>>   #define APPLE_ANS_LINEAR_SQ_EN     BIT(0)
>>   @@ -1130,17 +1127,6 @@ static void apple_nvme_reset_work(struct work_struct *work)
>>           /* Setup the NVMMU for the maximum admin and IO queue depth */
>>           writel(anv->hw->max_queue_depth - 1,
>>               anv->mmio_nvme + APPLE_NVMMU_NUM_TCBS);
>> -
>> -        /*
>> -         * This is probably a chicken bit: without it all commands
>> -         * where any PRP is set to zero (including those that don't use
>> -         * that field) fail and the co-processor complains about
>> -         * "completed with err BAD_CMD-" or a "NULL_PRP_PTR_ERR" in the
>> -         * syslog
>> -         */
>> -        writel(readl(anv->mmio_nvme + APPLE_ANS_UNKNOWN_CTRL) &
>> -            ~APPLE_ANS_PRP_NULL_CHECK,
>> -            anv->mmio_nvme + APPLE_ANS_UNKNOWN_CTRL);
>>       }
>
> Hi Greg/Sasha,
>
> I ran an AI-assisted backport review, and I have verified the report. It
> looks valid to me.
>
> Upstream removes the Apple PRP workaround only after
> 69d22a6b2f698 adds a page-alignment quirk and ea2160c7b7818 enables it for nvme-apple.
>
> Upstream code with both alignment prerequisites:
>
>     if (is_admin &&
>         (ctrl->quirks & NVME_QUIRK_ADMIN_PAGE_ALIGN))
>             lim->dma_alignment = NVME_CTRL_PAGE_SIZE - 1;
>
> Downstream 6.12.y code:
>
>     lim->dma_alignment = 3;
>     NVME_QUIRK_SKIP_CID_GEN | NVME_QUIRK_IDENTIFY_CNS
>
>
> Neither is present in 6.12, whose admin queue still permits four-byte
> buffer alignment.
>
> I suggest porting those two prerequisites to the older queue-limit API
> and applying them before this deletion. Thoughts?

This appears to be correct. In addition, the way this deletion is currently
structured depends on commit 

04d8ecf37b5e06d1 ("nvme: apple: Add Apple A11 support")

solely because adding A11 support wrapped the existing
code in an if statement. The correct patch would be to
remove the corresponding code directly in 6.1, 6.6 and
6.12.

I suggest this patch and all of its dependencies to be
dropped from 6.1, 6.6 and 6.12 so this patch can be
backported properly alongside the page size quirk later.

Patches that should be dropped:

04d8ecf37b5e06d1 ("nvme: apple: Add Apple A11 support")
6fe0687245e8406b ("nvme-apple: Prevent shared tags across queues on Apple A11")
a6ab75639e23169a ("nvme-apple: Reset q->sq_tail during queue init")
8ce883fd068b7ba9 ("nvme-apple: Drop the PRP null check chicken bit")

Best Regards,
Nick Chan


>
> thanks,
> Harshit
>>         /* Setup the admin queue */
>
