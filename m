Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480EF450F2;
	Thu, 27 Aug 2026 03:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787801455; cv=none; b=B1k/45gxfJOV9zACvd6zA6Aso3SuDqh8fiT26JVIU6ing0gayFdkOhV+gyL73S2/Vcxp0eJ9QZQdD7kC93cWKr0JrdDa+1Nzbg+Hgep1du6vIU4d+S2XJXfayJsdymp//i2u0ZcJ6tS4paXjaG2lQCfgk3i2S1IQ6tqKgMqnUXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787801455; c=relaxed/simple;
	bh=T/8sJkm0Ed9vU2a+hi/Hu/cxK8L5klQwq+/IdqNFimo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lqSqLVNQcq1/YgWHYM+f4ZGAzLKiErSX8TdNY+s0S0RMidxlBtArmZHdyZHBZGCkTQ+9Ef/2ATRt3onjeaB7Zi2hW+JGOv/wxH6zDMiQNOodEF2gnCGZedyghU43KJQ+Rj8N4H1DT2Tvmow/RD32PUA2pqQh3MaDQrxDTg0L3Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=M52t9mEN; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="M52t9mEN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=GnOdnf4HgZ45scT5RjaQMDi0s1XWYCbY2fvOOZ38dmY=;
	b=M52t9mENxWQmNuag85VZn4jxV0+YmAxkDgwOrcHfMD21T81wMjUFlLhLseCJxD
	GGfpknwp5JYynUE9Gx7+ZjP7K/43PFxh5pyT9TKjvc+3p9k+RmeTyeydU6u9DAQQ
	QkwGUJuhJbb4L6vvnK4nxMYRKklZ5s4/tOm8NnEdx517s=
Received: from [IPV6:2409:8900:1ef4:8f82:6a1b:f1a6:cbdd:11fe] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wBX1YlNr49q+5VnSQ--.28959S2;
	Thu, 27 Aug 2026 11:30:23 +0800 (CST)
Message-ID: <4a626656-332d-4e2a-9db2-2949cf9caccf@163.com>
Date: Thu, 27 Aug 2026 11:30:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntfs: fix race between fallocate and mmap reads
To: Hyunchul Lee <hyc.lee@gmail.com>, Hongling Zeng <zenghongling@kylinos.cn>
Cc: linkinjeon@kernel.org, ntfs@lists.linux.dev,
 linux-kernel@vger.kernel.org, zhongling0719@126.com, stable@vger.kernel.org
References: <20260826054204.1364589-1-zenghongling@kylinos.cn>
 <CANFS6bbVZ3jZa+a8FTjz1w3RuPvFTgjfBh134J4a-9fK549UxQ@mail.gmail.com>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <CANFS6bbVZ3jZa+a8FTjz1w3RuPvFTgjfBh134J4a-9fK549UxQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBX1YlNr49q+5VnSQ--.28959S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxurWrXw43Ar1ktF18ZF4ruFg_yoW5Ar4Dpr
	Wqg3WUKws5XrWj9F1vqw48uF15W392grW5urWfX3WxZFn5KFn2gF1UKrn3uFyftF93Jr43
	Xw1jqF9ruFyavaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6a0dUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6Q99SGqPr08twAAA37



在 2026/8/27 10:43, Hyunchul Lee 写道:
> Hi Hongling,
> 
> 2026년 8월 26일 (수) 오후 2:42, Hongling Zeng <zenghongling@kylinos.cn>님이 작성:
>>
>> The fallocate implementation only takes invalidate_lock for punch hole,
>> collapse range, and insert range operations. For standard allocation modes
>> (mode == 0, FALLOC_FL_KEEP_SIZE), the lock is not held.
>>
>> During ntfs_attr_fallocate(), new clusters are mapped to the runlist via
>> ntfs_attr_map_cluster() before being zeroed by ntfs_dio_zero_range(). This
>> creates a window where concurrent mmap page faults can read uninitialized
>> disk data.
>>
>> Since mmap uses filemap_fault() which takes invalidate_lock in shared mode,
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
>> ---
>>   fs/ntfs/file.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/fs/ntfs/file.c b/fs/ntfs/file.c
>> index 88747217ba61..6958a1469fb0 100644
>> --- a/fs/ntfs/file.c
>> +++ b/fs/ntfs/file.c
>> @@ -1153,11 +1153,9 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t offset, loff_t le
>>          }
>>
>>          inode_dio_wait(vi);
>> -       if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
>> -                   FALLOC_FL_INSERT_RANGE)) {
>> -               filemap_invalidate_lock(vi->i_mapping);
>> -               map_locked = true;
>> -       }
>> +       /* Take invalidate_lock for all fallocate operations to prevent races */
>> +       filemap_invalidate_lock(vi->i_mapping);
>> +       map_locked = true;
> 
> map_locked can be removed.
> Otherwise it looks good to me.
> 
> Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>
> 
> 
>>
>>          switch (mode & FALLOC_FL_MODE_MASK) {
>>          case FALLOC_FL_ALLOCATE_RANGE:
>> --
>> 2.25.1
>>
> 
> 
> --
> Thanks,
> Hyunchul

Hi Hyunchul and Hongling,

Thanks for reviewing. I think map_locked might still be needed though.

Before filemap_invalidate_lock() is taken, there's this check:

         inode_lock(vi);
         if (NInoCompressed(ni) || NInoEncrypted(ni) || 
NInoWofCompressed(ni)) {
                 err = -EOPNOTSUPP;
                 goto out;
         }

         inode_dio_wait(vi);
         filemap_invalidate_lock(vi->i_mapping);

If that goto is taken, we reach the exit path without having locked.
Without map_locked, we'd call filemap_invalidate_unlock() on a lock
we never took.

Would it make sense to either:
1. Keep map_locked as a guard for the unlock, or
2. Change that goto to inode_unlock() + direct return, so the shared
      exit path always holds the lock?

I'd appreciate your thoughts on this.

Thanks,
Baolin.

