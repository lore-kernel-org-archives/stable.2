Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 665551D7E5C;
	Tue, 22 Sep 2026 00:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790036252; cv=none; b=jrSvu3QyQAQMBWtjF8YPCtNwxgTg2Eit19AwB/7LuYwMsbTwtAbN8yT/zn5uFwdKqn1PE8NpABye8v5w6U2Nn3GstE02aJ+PIdEIX39/JTqaC/swrBNeMTgjlBqztiYkKkzRD8HKuLWr4flwV+8/hNQak0ByUKlcU3rj/HAc3Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790036252; c=relaxed/simple;
	bh=Dtd+vuEXW2FRSX4+Ub6P0X2FggLyeP43+es8EivwjKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RoZaBjCNNProwm3ZWGeC2xp62VH4kVGtcxES+FQbB04ut3bIJPH9mNUfp06XHnem+UD7UiF2dqh3qwmxuCGhkIEmXwWJkCoTyTeCD01Pp6gqwyUbm2Ne5edJC/GRunAOyrMd8NdJAMr/p1eGvSzgdwcPGyoQ2ibByQeu+McCvU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Oz702gl2; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Oz702gl2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=VLPsiOrqn3JUU0Kgbrh6KiQx/oROijL617qgfbaZZ5s=;
	b=Oz702gl2M2JgE6gVYAUzg5wZquwBbWF016dzPRl/G+N5AYPoMwRFD6EpHjYRsa
	IF8YiIwQ4bbPrVYhpcFQlX4rVXY4FNCG3nvYBLL5Oma6Hw3lF74np5OhIZbggG11
	wfPyAoA/OHKMKqxSZ4eYec55MwwXIOUrjnr9jyQw9jJmI=
Received: from [IPV6:2409:8900:1ee3:222c:420f:a5a2:eb51:8645] (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wCHtwX5yLFqsv6SCA--.53149S2;
	Tue, 22 Sep 2026 08:16:59 +0800 (CST)
Message-ID: <3b2dc68a-08fb-45c7-aaa9-bfa8de52affd@163.com>
Date: Tue, 22 Sep 2026 08:16:57 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] ntfs: mount hibernated volumes read-only regardless of
 errors=
To: dd <zhongling0719@126.com>, Hyunchul Lee <hyc.lee@gmail.com>
Cc: Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260920025955.31209-1-zenghongling@kylinos.cn>
 <04255390-4133-4e8e-81ad-4d2402498431@163.com>
 <CANFS6bYLBPr+FmE_MVWxBBMw+Qz55EFfy1u6UmBgkTak2CMyvA@mail.gmail.com>
 <4e70c6d0.7644.1a0c34d327f.Coremail.zhongling0719@126.com>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <4e70c6d0.7644.1a0c34d327f.Coremail.zhongling0719@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHtwX5yLFqsv6SCA--.53149S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZrWkXr1kZw4fCF1xtw4kCrg_yoWrur13pF
	Wqga1DtF1kKr10krn2yay8JasavryvkFWjqr1kJw47Wrn8tFnxt3yrKr1j9FyFkr95Jw4x
	XF40kFy3uFy5CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTKZAUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwRt3QmqxyPsZYgAA38



在 2026/9/21 17:30, dd 写道:
> Hi baolin,
>   Thanks for catching this. I agree that temporarily setting
>      SB_RDONLY
>      makes it impossible to distinguish an error suppressed by
>      ntfs_handle_error()
>      from a successful check. In particular, errors from optional WSL EA loading may neither propagate through the hibernation check nor set
>      NVolErrors()
>      , allowing the flag to be cleared incorrectly.
> 
> Hi all:
>     One question: with errors=panic, a corrupt $LogFile can still panic
> during load_system_files(), before the hibernation fallback is reached.
> For example, ntfs_check_logfile() panics on "LogFile is too small".
> 
>     Should mount-time metadata errors generally avoid errors=panic before
> the superblock is published? If so, that seems like a separate follow-up
> to extend the temporary policy substitution over load_system_files().
> 
> Thanks!

Hi Hongling,

   Yes, the earlier $LogFile check can still panic. I would keep that 
behavior and limit the temporary substitution to the hibernation check.

   The intention of this exception is to preserve read-only access where 
possible when we cannot establish whether Windows is hibernated.Refusing 
write access provides a conservative outcome in that case, without 
bringing down the whole system. Temporarily substituting remount-ro lets 
us reach that outcome even when nested lookup or inode-loading helpers 
call ntfs_error().

   This deliberately also covers genuine metadata errors encountered 
during the probe. It is a limited policy exception for the hibernation 
check,rather than a requirement to suppress panic throughout mount.

   A corrupt $LogFile detected earlier is an independent filesystem 
error.Honoring the user's explicit errors=panic choice there is 
reasonable,and that path will not proceed to the subsequent $LogFile 
emptying.I do not think the hibernation exception requires changing that 
behavior.

   Also, extending the substitution over load_system_files() would not 
cover the whole mount process: boot-sector processing and the initial 
$MFT loading happen before it. Extending it further to cover all mount 
stages would effectively make errors=panic apply only after a successful 
mount, while using remount-ro during mount. I think that would override 
the user's selected policy too broadly.

   So my preference is to keep the temporary substitution around 
check_windows_hibernation_status() and preserve the existing policy 
elsewhere.

Thanks,
Baolin.


> 
> At 2026-09-21 15:57:29, "Hyunchul Lee" <hyc.lee@gmail.com> wrote:
>> Hi Baolin, Hongling
>>
>>>     If you agree with this approach, could you please incorporate it and
>>> send another revision? I'd appreciate feedback from you, Namjae, and
>>> Hyunchul.
>>
>> I agree with this approach. It looks sound to me.
>>
>>>
>>> feel free to add:
>>> Suggested-by: Baolin Liu <liubaolin@kylinos.cn>
>>>
>>> Thanks,
>>> Baolin.
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>>        if (unlikely(err)) {
>>>>                static const char *es1a = "Failed to determine if Windows is hibernated";
>>>>                static const char *es1b = "Windows is hibernated";
>>>> @@ -1581,12 +1594,25 @@ static bool load_system_files(struct ntfs_volume *vol)
>>>>                const char *es1;
>>>>
>>>>                es1 = err < 0 ? es1a : es1b;
>>>> -             /* If a read-write mount, convert it to a read-only mount. */
>>>> -             if (!sb_rdonly(sb) && vol->on_errors == ON_ERRORS_REMOUNT_RO) {
>>>> -                     sb->s_flags |= SB_RDONLY;
>>>> -                     ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
>>>> -             }
>>>> +             /*
>>>> +              * A Windows hibernation image is not a filesystem error, so
>>>> +              * this is a safety interlock rather than something the
>>>> +              * errors= policy may downgrade.  The super block is already
>>>> +              * read-only here: the temporary flag taken for the check
>>>> +              * above is not restored when the check failed.
>>>> +              */
>>>> +             ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
>>>>                NVolSetErrors(vol);
>>>> +     } else if (unlikely(temporary_ro && sb_rdonly(sb))) {
>>>> +             static const char *es1 = "Errors were recorded during mount";
>>>> +             static const char *es2 = ".  Run chkdsk.";
>>>> +
>>>> +             /*
>>>> +              * Errors were recorded during the check or earlier, e.g. when
>>>> +              * loading the LogFile.  Stay read-only, like ntfs_reconfigure()
>>>> +              * does for volumes with recorded errors.
>>>> +              */
>>>> +             ntfs_error(sb, "%s.  Mounting read-only%s", es1, es2);
>>>>        }
>>>>
>>>>        /* If (still) a read-write mount, empty the logfile. */
>>>
>>
>>
>> -- 
>> Thanks,
>> Hyunchul

