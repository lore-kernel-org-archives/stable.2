Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793177869;
	b=DtgX2fOOGbef7Pp3Zvoa2BpayJ84uZFtoQ7iZOB9tpIASnyf+eLtHycXAnRuAUvsVNhY
	 Re5N4bIYmo2tcVuvufKEDbjz2Y3mZaccnHcOPHUFP2mHfzi/OsfukwYHS+Udw4vr23o8I
	 X/qfx9jQQnKwNtGmklpvsfvnfQJ6R7JTcDq87v8etkzKUqvk7xI1srjomcpkTBF9aOYHr
	 MpEcHRx1Pzu1omAXjD49LtFhQS2ghdcA6sYWAQKxh8nu/28gLwoGMlWKn5BRX68yFgLCU
	 Adbp+64jfZqdTi00LvcE+C9M0SKYScGVFnOrlMNo4Ps/W0s91T40Zu50VmaErdOA7QQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793177869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=/WqBXbdrr81VFuR+G6HpIUqhONN25pqT1vt0MHbETgY=;
	b=v4IaOnP6RW1M4rKUpS08pARrAGWl3lbgA5O86EuKnY1f3v3edBsaGdgV2KA7rRsBqpVb
	 7h71aw/MHd54Zq1XRw/2J+lhWFhJ5CgYy+Gs50IZYCT/W2gimR+1VUx4Md46gJCKzReoN
	 4HXacsvaxUvMNGWtacBW7gwWKSOT32kHnPg9QAKiz4NoRSU0y+TWA/kS6Z5dIgTZrQXid
	 nrwhG+ejaQca7MVoMTMI+2feNtQ7VowYpqsfVjTCc/iX/hxE8d18aEFJUZRq1Lbv8EWSE
	 hsGMv5Nma0m2IRX7WlKg7duclDOH7D5MFRlLB0MgmBGlkdDl+PS7bcxcfrnGid8b1Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CFv5AfZu;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05FA606A31A
	for <stable@vger.kernel.org>; Wed, 28 Oct 2026 08:57:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E05FA606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CFv5AfZu
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a20bdaf39cso7061255e9.1
        for <stable@vger.kernel.org>; Wed, 28 Oct 2026 01:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793177866; x=1793782666; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/WqBXbdrr81VFuR+G6HpIUqhONN25pqT1vt0MHbETgY=;
        b=CFv5AfZu5I2b9KXFq0rOQPwx5UV0ZFc+xHcUWQMTcUuoaaCCbTqUKE2sjAMCyCKKuS
         rdafitpNcg5oiyS0CZjoKlJY3o0peJuKFzL4a68vw2whwjYNLbygWPA6iyXxMkbCHuaw
         lUi2hjyacO81EYVMX03X18jKuZU+N3fY4n3qLOWvkNEcFnZc/QJyPIafW9EJMx6h+bbV
         MynPWKZhKIjQEaGEPpKkDOueqoolfl/FAZVoFCjoG9TEoWiWSgaswZqeDErFDuDIo23A
         qg50u0QBJv2HO7OuqmLq+2lWtgZZGerhOBvXBAA68k/meQvgU+UgtZCkxSju6ioa7mD1
         Y7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793177866; x=1793782666;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/WqBXbdrr81VFuR+G6HpIUqhONN25pqT1vt0MHbETgY=;
        b=Z3iqkyvwqLiOaGRLKemGudzOsXJDjx7E14CPBE9FcP68rBR059gu5M9UGoCyniNH4h
         Bg5ZQoa//zzrFIPzpI9BuXYx9AMwkILL2pPIXxEqHH4j0jFUoylWBNFdNMcYncPhlUnG
         Z+Sl9q0T5+f/RSEHpc5laWIMxky3oPJYb8+YQ43n6uylhAdfaIeWNmV3G4//CUMlpx3B
         9ynRMsWXRjxY35oy4j7TDW5fmnG2cUsjbvpsBdvuO/A6TCNI81eCqmNtExqVp/jjTFbP
         b5Bj9I/ek3XdaFNJgnH/QVQoI49IZV6xcnNLOWSWbyGnz+Yuv37LOHhDBeob4GU2meM9
         m2nA==
X-Forwarded-Encrypted: i=1; AKwUvBz6ImKiuGASJXRN8rBdgDEFzgg/zlcG+MENzS/UqUyXABtj5UqeNXeg5okmAGpggQ3pFXKGvTE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK1nuMR1JgXsIR/b5aKmXRAAUKBT7jq3AHT8b/MdmDOpsv4my5n
	MExX4fliDx2UxUjoEoG3VjmUTV3uVL8t2a7s/WXNsww2JTjgCgYIxKppPm+h0vp350k=
X-Gm-Gg: AYBFou0Crs2+K1oScFVWHKhERvhmCydqTG9Z6TUzXXVIiUyKokZ5JOkLs2X82lUlOi7
	y+z1tjw5ofL7lexw88enKTscLYNJKiQkOgsv6zBppBz7BkzY7Ww9F2mn2aIFjQ344EvKQgZaVk8
	hITLJ4JulfqpIl0OVEcJBkrhOxZ8lWLUC9riw2It+9eiVMG7jlmQypvQoy9SxaXBuvz9n/6Swrd
	bdCS6NsF5IpVmYfY58/wyUC4dA01KQtk0ZDiM2gm3gMReiOcFPVYHZukxmgZc2Ci5F3IEFdYQjA
	170lfzXLI2w1TMBKFHSazM7UAoCbXnkUWw3PMr2kgsLRyo7UGBdOvQ1tBSDreY/sOGOcUDCmQ9i
	/eVgG6rz73WQKcym5DSHa3Kg85mgmciiw3JD+N9b62sSxWa83kb3Mpi+fGvQqKbQYBV48VFBMpl
	h6oKGSDElc9gxiN9lmcKG12xO30CZyQVPLhIVmC63rRbyNKM7rvjNy4zq+R5ffROFDz24EafgHD
	qKie4gyY5FCOHwx+slfdSLeV6GjvlKsS/g/AEpYUMOzDkBnER4vYJpiVewuI+c8oVLdIi9S4GCK
	A0kkoThpwufGxqKG2A27tw==
X-Received: by 2002:a05:600c:8715:b0:4a1:7ec7:a479 with SMTP id 5b1f17b1804b1-4a967ab1ce3mr32942435e9.33.1793177866215;
        Wed, 28 Oct 2026 01:57:46 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae5a9035casm2084162a91.2.2026.10.28.01.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Oct 2026 01:57:45 -0700 (PDT)
Message-ID: <65fd2260-78e1-4521-9df1-b042788ae7bc@suse.com>
Date: Wed, 28 Oct 2026 19:27:39 +1030
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
Subject: Re: [PATCH] btrfs: do not leak -ERESTARTSYS from FITRIM to userspace
To: Luca Stefani <luca.stefani.ge1@gmail.com>, zhiwei.liang@zliang.me
Cc: David Sterba <dsterba@suse.com>, Chris Mason <mason@kernel.org>,
 Filipe Manana <fdmanana@suse.com>, Robbie Ko <robbieko@synology.com>,
 linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20261028-btrfs-fitrim-freezer-v1-1-0ad1d58aa94d@zliang.me>
 <CAO0HQ0UE5BtevPHHfV9mQo5HoqzxzDDjAkj9e=pD_0AaXmSYFQ@mail.gmail.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ujyBQkUpLw5AAoJEMI9kfOh
 Jf6o8OIH/0mqW+TQM4m2x3hCsnK+oB4yJH1qnGvIhFF/Lhs48wI02sGh6/4aA0hkCDfd9LHQ
 +ci4FUepZ9y4VS01+oIExbg/8ytzGYTzLtb44jK2GBOBVSJkMiha6jp22XFt7WUkT/tvbreu
 WWdGsaJIRQaZChy7xsMI8lqQ2WdmluZJ4LT0wD3l/l6QU1ZseMGySebdY9sVOQEOJNV7Qj92
 /KOAFNmeZshV/qDI8Iw1RTs6TvLqCcqmlZLCmJkYSVhT1RonWRren8xIRcFEgMe004IDnt7V
 qdQhk/nhTS9x9MBAhMRl0TTE1VKDLvVALsud3iZLrmmtYvwPApzGJk052f0m28vOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ukKBQkUzDspAAoJEMI9kfOhJf6o
 SNsH/1ysUWOKmzY0rGS3ZdS61QgqMGhSWD/EJ4UiPw+xO4l4+GtX0fOAqxqsmBKqje3vyhBa
 Z5o/1Y+gNiN+E6RBcSz4b1TAd78sQ2bvT5DWOvBjeeVxHdiuQMIn4S8xk5ZpySBw5ifjoiuL
 0M33UVtJOzM8yfAeL+d/Rp4leJw72SutjkLyZTG/gJIp4pJGD/kFHn24OLL0IxEcO0gOekNZ
 os5e1R6jAJ2ILk7+MDnvU8wXHcCiVzuDhJLI1tih1uUIE50muHQJWbYuVBbdJeu8WlIDDssx
 UOCxLylNG3gDXV5MhLubPTOpp9OiFc/XC37nvkgEcrlmlOFBv4/NJCbECpo=
In-Reply-To: <CAO0HQ0UE5BtevPHHfV9mQo5HoqzxzDDjAkj9e=pD_0AaXmSYFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/10/28 19:21, Luca Stefani 写道:
> On Wed, 28 Oct 2026 at 07:57, Zhiwei Liang via B4 Relay
> <devnull+zhiwei.liang.zliang.me@kernel.org> wrote:
>>
>> From: Zhiwei Liang <zhiwei.liang@zliang.me>
>>
>> When a suspend starts during FITRIM, fstrim can fail with:
>>
>>    fstrim: /: FITRIM ioctl failed: Unknown error 512
>>
>> On a Fedora 44 laptop with kernel 7.2.7, 3 of the last 21 weekly
>> fstrim.service runs were in progress when an automatic suspend started.
>> All three failed this way and left the filesystem untrimmed.
>>
>> Since commit 69313850dce3 ("btrfs: add cancellation points to trim
>> loops"), the trim loops return -ERESTARTSYS when
>> btrfs_trim_interrupted() sees freezing(current), and FITRIM returns it
>> to userspace. Since commit bfb670b9183b ("btrfs: handle user interrupt
>> properly in btrfs_trim_fs()"), btrfs_trim_fs() returns it right away.
>>
>> -ERESTARTSYS is only valid while a signal is pending, because only the
>> signal handling on syscall exit turns it into a restart. But
>> freeze_processes() first sets pm_freezing, which makes freezing() true
>> for every user task. Then it walks the task list and sends each task a
>> fake signal. The trim loops check btrfs_trim_interrupted() after every
>> extent. If a check falls in this window, the loop returns -ERESTARTSYS
>> with no signal pending. Nothing restarts the syscall. On that laptop,
>> with a few thousand threads, freezing user space took 2 to 5 ms in each
>> of the three suspends above, and all three runs hit this window.
>>
>> Make btrfs_trim_interrupted() treat a freeze as an interruption only
>> once the fake signal has arrived, i.e. when
>> freezing(current) && signal_pending(current). freeze_processes() sends
>> that signal in the same call. The trim loop stops at the next check
>> after it, so suspend is not delayed.
> Looking at how ext4 handles this scenario it seems to me they don't set
> the error code to -ERESTARTSYS and (from a quick glance) return the
> bytes discarded to the caller.
> And like before they continue the discard (which will skip/fail again) until
> there's nothing to be done.
> 
> I don't know what the intention of btrfs: handle user interrupt
> properly in btrfs_trim_fs()
> was, maybe we should just swallow the ERESTARTSYS case in those scenarios.

I agree on that btrfs is the exception, we should follow ext4/xfs, not 
rely on some tricky signal handling behavior for suspension.

I think the tokens of the author should be spent on unifying the btrfs 
fstrim suspension behavior instead.


>>
>> The restarted syscall re-reads struct fstrim_range from user memory.
>> When the device phase is interrupted, btrfs_trim_fs() has already stored
>> the trimmed byte count in range->len, and btrfs_ioctl_fitrim() copies
>> the struct back unconditionally. The restart is then asked to trim
>> [start, start + trimmed) instead of the requested range, or fails with
>> -EINVAL when nothing was counted yet. Skip the copy_to_user() for
>> -ERESTARTSYS. In all other cases the partial count is still copied back.
>>
>> Tested in a VM with pm_test=freezer. Without the patch, 18 of 20 freezes
>> during a trim leaked errno 512, and 10 of 10 restarts after a
>> device-phase interruption failed with -EINVAL. With the patch, all 30
>> runs restarted and trimmed the full amount.
>>
>> Fixes: 69313850dce3 ("btrfs: add cancellation points to trim loops")
>> CC: stable@vger.kernel.org # 5.15+
>> Signed-off-by: Zhiwei Liang <zhiwei.liang@zliang.me>
>> ---
>>   fs/btrfs/free-space-cache.h | 3 ++-
>>   fs/btrfs/ioctl.c            | 7 +++++++
>>   2 files changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/btrfs/free-space-cache.h b/fs/btrfs/free-space-cache.h
>> index e22443598b..cba2f5fd6b 100644
>> --- a/fs/btrfs/free-space-cache.h
>> +++ b/fs/btrfs/free-space-cache.h
>> @@ -58,7 +58,8 @@ static inline bool btrfs_free_space_trimming_bitmap(
>>
>>   static inline bool btrfs_trim_interrupted(void)
>>   {
>> -       return fatal_signal_pending(current) || freezing(current);
>> +       return fatal_signal_pending(current) ||
>> +              (freezing(current) && signal_pending(current));
>>   }
>>
>>   /*
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index ac070c745b..b02c59cbb0 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -529,6 +529,13 @@ static noinline int btrfs_ioctl_fitrim(struct btrfs_fs_info *fs_info,
>>          range.minlen = max(range.minlen, minlen);
>>          ret = btrfs_trim_fs(fs_info, &range);
>>
>> +       /*
>> +        * A restart re-reads the range from user space, so do not clobber it
>> +        * with the partial len the rerun would otherwise take as its input.
>> +        */
>> +       if (ret == -ERESTARTSYS)
>> +               return ret;
>> +
>>          if (copy_to_user(arg, &range, sizeof(range)))
>>                  return -EFAULT;
>>
>>
>> ---
>> base-commit: e17e64baf63f7c85bec209ed73f14c1b2a7e39fb
>> change-id: 20261028-btrfs-fitrim-freezer-d4cba16e7e13
>>
>> Best regards,
>> --
>> Zhiwei Liang <zhiwei.liang@zliang.me>
>>
>>

