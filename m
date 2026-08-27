Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5160718A6D4;
	Thu, 27 Aug 2026 04:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787803504; cv=none; b=JauJNXNCNkvrd6lYVRIe39wDeN9UQWCWn/l8onrKd26SwGAdMPSE42Tb9BsOkhQPNrX80Sx0eQYC0SzBmzKR9A21WZyg3t0ayteM1CIOARn8sDKe5gdpLzr4JqwoMX62hPuqJ9/Kvu3Oq/Nxl1w6sjdyGuBl9/VfbLGj78o4u/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787803504; c=relaxed/simple;
	bh=dMuq1DxVmQiU7b+us0xp/kJ/V1CQFxeMax37t2ZK0BQ=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=auHUURFnLAOODhH3UN9Pvs9RL3M1E17hGs2r4AdN1lAcf2SfaNiBuYl6z+y7qsBTxass10mVwP6tvbCiBxf2W6jFRRNVx5WA6fhxPGKPfrx/v06HUGKGBVJlW1wQVuNazdHkmmkJO/4OmR+3csTHOTuasnEP2Jrvf0S2B+VqmR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Ei7WZ4Xj; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Ei7WZ4Xj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=drS/ZvD0XeA/LQvCSDdwA6CuJiJoYkF8nFoRrZL6PZo=;
	b=Ei7WZ4XjM4ZTgCpT1uleP/5hnp+x9m86fzjJJxgynLDmk+PzgXL2ITvRntHyGJ
	gpj7yvPapMP1ZMNavaTBaTzCKs4Jyo9UgJLvZygphLgvxR9cs3OCO+uBXImS/yQr
	0a3DaAhpCHqy3T6eQeDWz4NdtkcInMIR0fEKqJcZHklpA=
Received: from localhost.localdomain (unknown [])
	by gzsmtp2 (Coremail) with SMTP id PSkvCgDnD+tWt49qYbuMFQ--.57571S2;
	Thu, 27 Aug 2026 12:04:39 +0800 (CST)
Message-ID: <6A8FB73D.30104@126.com>
Date: Thu, 27 Aug 2026 12:04:13 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: liubaolin <liubaolin12138@163.com>, 
 Hongling Zeng <zenghongling@kylinos.cn>,
 linkinjeon@kernel.org, hyc.lee@gmail.com
CC: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
Subject: Re: [PATCH v2] ntfs: fix race between fallocate and mmap reads
References: <20260827031647.1605970-1-zenghongling@kylinos.cn> <bd197da8-a8ec-40ad-a50d-dc579840d680@163.com>
In-Reply-To: <bd197da8-a8ec-40ad-a50d-dc579840d680@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PSkvCgDnD+tWt49qYbuMFQ--.57571S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWxXw4ftw1kKr1UXF18Krg_yoW5KFyrpr
	WqgF4jkrs5XrWUuF1kWw4UuF18Ww10grW5CrWfX3W0vrn8KFn2gF1UKr4fWFySyFZ3Jrsx
	Xa1UXrZruFyav3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-rc-UUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrxeBUmqPt1fN3AAA3-


在 2026年08月27日 11:37, liubaolin 写道:
>
>
> 在 2026/8/27 11:16, Hongling Zeng 写道:
>> The fallocate implementation only takes invalidate_lock for punch hole,
>> collapse range, and insert range operations. For standard allocation 
>> modes
>> (mode == 0, FALLOC_FL_KEEP_SIZE), the lock is not held.
>>
>> During ntfs_attr_fallocate(), new clusters are mapped to the runlist via
>> ntfs_attr_map_cluster() before being zeroed by ntfs_dio_zero_range(). 
>> This
>> creates a window where concurrent mmap page faults can read 
>> uninitialized
>> disk data.
>>
>> Since mmap uses filemap_fault() which takes invalidate_lock in shared 
>> mode,
>> it can fault in pages during this window and expose old disk contents to
>> userspace. This is an information leak and data integrity issue.
>>
>> Fix by taking invalidate_lock for all fallocate operations, not just for
>> punch/collapse/insert modes. This prevents concurrent page faults from
>> accessing unzeroed clusters during the allocation window.
>>
>> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>> Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
>> Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
>> ---
>> Change in v2:
>>   -Remove now-unnecessary map_locked variable.
>> ---
>>   fs/ntfs/file.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
>> index 88747217ba61..779baafa0319 100644
>> --- a/fs/ntfs/file.c
>> +++ b/fs/ntfs/file.c
>> @@ -1153,11 +1153,8 @@ static long ntfs_fallocate(struct file *file, 
>> int mode, loff_t offset, loff_t le
>>       }
>>         inode_dio_wait(vi);
>> -    if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
>> -            FALLOC_FL_INSERT_RANGE)) {
>> -        filemap_invalidate_lock(vi->i_mapping);
>> -        map_locked = true;
>> -    }
>> +    /* Take invalidate_lock for all fallocate operations to prevent 
>> races */
>> +    filemap_invalidate_lock(vi->i_mapping);
>>         switch (mode & FALLOC_FL_MODE_MASK) {
>>       case FALLOC_FL_ALLOCATE_RANGE:
>
> Hi Hyunchul and Hongling,
>
> I think map_locked might still be needed though.
>
> Before filemap_invalidate_lock() is taken, there's this check:
>
>         inode_lock(vi);
>         if (NInoCompressed(ni) || NInoEncrypted(ni) || 
> NInoWofCompressed(ni)) {
>                 err = -EOPNOTSUPP;
>                 goto out;
>         }
>
>         inode_dio_wait(vi);
>         filemap_invalidate_lock(vi->i_mapping);
>
> If that goto is taken, we reach the exit path without having locked.
> Without map_locked, we'd call filemap_invalidate_unlock() on a lock
> we never took.
>
> Would it make sense to either:
> 1. Keep map_locked as a guard for the unlock, or
> 2. Change that goto to inode_unlock() + direct return, so the shared
>      exit path always holds the lock?
>
> I'd appreciate your thoughts on this.
>
> Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
>
> Thanks,
> Baolin.
Hi  Baolin and Hyunchul
  You're right — that's exactly the unbalanced-unlock path we spotted while
   preparing v3, and option 2 is what v3 implements. The early exit now does
   inode_unlock() + direct return, so every path reaching out: holds
   invalidate_lock, which let us drop map_locked entirely:

    inode_lock(vi);
    if (NInoCompressed(...) ) {
            inode_unlock(vi);
            return -EOPNOTSUPP;
    }
    inode_dio_wait(vi);
    filemap_invalidate_lock(vi->i_mapping);
    ...
    out:
            filemap_invalidate_unlock(vi->i_mapping);
    v3 with this cleanup is on its way / attached.

  Would this v3 approach be OK with you?

    Thanks,
    Hongling

