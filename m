Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F382FBE1F;
	Thu, 27 Aug 2026 04:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805250; cv=none; b=MkMaU4qcmUjkWdY8qPhSiHb90bbSYWbzXsr4OfG3zZEc34NxDBGvXak55nNNgz+E/GGFnncBAh2RvBR5lcXsZdzBc/cgWg8JgjseJAMOWLj+JlRsY7b16vSz0//m5qHn1jLoksTvQUK5RhPTZGmytFiClIw/YXDOFL5HeU6ngOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805250; c=relaxed/simple;
	bh=1BH16QiWc0Qjb48YHhn9W5XUR+q9xRxcLUk2RYcQIi0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hiBOI49VnchY6xmEEM29t0AGKU6Lk3WiPyNE7ne6zGhWWLNXmSjtPARHFk0U9UAy/TlI4uHfCkWrfkiqF0SNJlbVrIpZXgyes61NR1l9N2eLOjlXiaG9M3xZy9lgJM6vnv5shdxOiLrfaydD1eyS4t3u6B+aomZhcGndxdbKtzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CxbT6Z72; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CxbT6Z72"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=PRoXD4sZgycHw3w5/hnLgpayzzS06vs5edBN/I94MWc=;
	b=CxbT6Z72WSbtkVnrJTNytTTxgQQdQXdSv+j1NOkIYbnVqwReA5n0r7zb507ScU
	uZgqQg49YPRIQgd8bGPnfxGYR008ITLwLE8H6e7k6wLW0BvWxjILF5HyDkPZTS3Q
	Yp3DJtakRQ85VpRXHsKhbfwrwC0zfqoJn++Oygjh5UrLA=
Received: from [IPV6:2409:8900:1ef4:8f82:6a1b:f1a6:cbdd:11fe] (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCnoe0dvo9q_WUwDw--.46122S2;
	Thu, 27 Aug 2026 12:33:35 +0800 (CST)
Message-ID: <6bf63800-e169-4ff7-baa2-52c4d42bb35e@163.com>
Date: Thu, 27 Aug 2026 12:33:33 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ntfs: fix race between fallocate and mmap reads
To: Hongling Zeng <zhongling0719@126.com>,
 Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>
References: <20260827031647.1605970-1-zenghongling@kylinos.cn>
 <bd197da8-a8ec-40ad-a50d-dc579840d680@163.com> <6A8FB73D.30104@126.com>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <6A8FB73D.30104@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnoe0dvo9q_WUwDw--.46122S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw45tFyrtry7ArWkZFW5Wrg_yoWrGw1fpr
	WqgF4jkr48XrWUuF1vgw4j9F1Fg340grW5urW3J3WIvrn8KFn2gF1UKr4xuryFyFZ3Jrs3
	X3WUJrZruFyYv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UaJPiUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwh81AGqPvh-OlwAA31



在 2026/8/27 12:04, Hongling Zeng 写道:
> 
> 在 2026年08月27日 11:37, liubaolin 写道:
>>
>>
>> 在 2026/8/27 11:16, Hongling Zeng 写道:
>>> The fallocate implementation only takes invalidate_lock for punch hole,
>>> collapse range, and insert range operations. For standard allocation 
>>> modes
>>> (mode == 0, FALLOC_FL_KEEP_SIZE), the lock is not held.
>>>
>>> During ntfs_attr_fallocate(), new clusters are mapped to the runlist via
>>> ntfs_attr_map_cluster() before being zeroed by ntfs_dio_zero_range(). 
>>> This
>>> creates a window where concurrent mmap page faults can read 
>>> uninitialized
>>> disk data.
>>>
>>> Since mmap uses filemap_fault() which takes invalidate_lock in shared 
>>> mode,
>>> it can fault in pages during this window and expose old disk contents to
>>> userspace. This is an information leak and data integrity issue.
>>>
>>> Fix by taking invalidate_lock for all fallocate operations, not just for
>>> punch/collapse/insert modes. This prevents concurrent page faults from
>>> accessing unzeroed clusters during the allocation window.
>>>
>>> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>>> Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
>>> Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
>>> ---
>>> Change in v2:
>>>   -Remove now-unnecessary map_locked variable.
>>> ---
>>>   fs/ntfs/file.c | 7 ++-----
>>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
>>> index 88747217ba61..779baafa0319 100644
>>> --- a/fs/ntfs/file.c
>>> +++ b/fs/ntfs/file.c
>>> @@ -1153,11 +1153,8 @@ static long ntfs_fallocate(struct file *file, 
>>> int mode, loff_t offset, loff_t le
>>>       }
>>>         inode_dio_wait(vi);
>>> -    if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
>>> -            FALLOC_FL_INSERT_RANGE)) {
>>> -        filemap_invalidate_lock(vi->i_mapping);
>>> -        map_locked = true;
>>> -    }
>>> +    /* Take invalidate_lock for all fallocate operations to prevent 
>>> races */
>>> +    filemap_invalidate_lock(vi->i_mapping);
>>>         switch (mode & FALLOC_FL_MODE_MASK) {
>>>       case FALLOC_FL_ALLOCATE_RANGE:
>>
>> Hi Hyunchul and Hongling,
>>
>> I think map_locked might still be needed though.
>>
>> Before filemap_invalidate_lock() is taken, there's this check:
>>
>>         inode_lock(vi);
>>         if (NInoCompressed(ni) || NInoEncrypted(ni) || 
>> NInoWofCompressed(ni)) {
>>                 err = -EOPNOTSUPP;
>>                 goto out;
>>         }
>>
>>         inode_dio_wait(vi);
>>         filemap_invalidate_lock(vi->i_mapping);
>>
>> If that goto is taken, we reach the exit path without having locked.
>> Without map_locked, we'd call filemap_invalidate_unlock() on a lock
>> we never took.
>>
>> Would it make sense to either:
>> 1. Keep map_locked as a guard for the unlock, or
>> 2. Change that goto to inode_unlock() + direct return, so the shared
>>      exit path always holds the lock?
>>
>> I'd appreciate your thoughts on this.
>>
>> Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
>>
>> Thanks,
>> Baolin.
> Hi  Baolin and Hyunchul
>   You're right — that's exactly the unbalanced-unlock path we spotted while
>    preparing v3, and option 2 is what v3 implements. The early exit now 
> does
>    inode_unlock() + direct return, so every path reaching out: holds
>    invalidate_lock, which let us drop map_locked entirely:
> 
>     inode_lock(vi);
>     if (NInoCompressed(...) ) {
>             inode_unlock(vi);
>             return -EOPNOTSUPP;
>     }
>     inode_dio_wait(vi);
>     filemap_invalidate_lock(vi->i_mapping);
>     ...
>     out:
>             filemap_invalidate_unlock(vi->i_mapping);
>     v3 with this cleanup is on its way / attached.
> 
>   Would this v3 approach be OK with you?
> 
>     Thanks,
>     Hongling

Hi Hyunchul,
    I think this approach is good.Looking forward to your feedback.

Thanks,
Baolin.

