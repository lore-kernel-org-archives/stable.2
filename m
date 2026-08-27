Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE0C222599;
	Thu, 27 Aug 2026 03:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787800324; cv=none; b=l8+RU7Pbop7gDGIFhKc21HQGgHmTY/fl72gI+aq1d578vo6XzmDqkVqXVMpv9T9oqdxrm6+mFkzbAUNrQ7nCIOq2NgZG89vH/PMtfx42LfzFpwH6kmZwkwncQhnFSL/gZUk9gI3Wv+9/qimJfWmK8bK0KmhSrIo/SXonOj6r5ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787800324; c=relaxed/simple;
	bh=KcwK/YhyJWaNmeTkEl/2KPAst9MSM1GXtF6RyPr0GtE=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=etDnFKORsjLm/cN4vMysYvAizPGSxB3VRZk5WL4q1bcQg2zkrmaPPyNt4KWEtT5bJ5NrGaF+0Y2nxRu7T1REUGDduQuvBORm9lyYSRVObW3IjQ7CK9a5ZDiXhY2zpH1quPLo8eHRJqXUGk14ECyJ4+yB08tCryDaht5v8orynfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=HP29rBTK; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="HP29rBTK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=tRUgptt3/iOeaoL0OChJJ/UHDKz4DcTXArKL3r2EcPA=;
	b=HP29rBTK16P1/n7OL0zPg7KzmODPZgRMOVNPxZo+SQdP1fwzy9rs1l1/RSr0gg
	U/GjFuNKD1UjvxOEoO6/rOOB6dULSkPeI3rv/pj4di8OK68Lxh6rAAuRkH01nQK7
	WoeqiLGa8Gj3lI+7II0BgSqvOuPqkV/hrtwnfPFKGwzQc=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDnL8zoqo9q1iCbGg--.30864S2;
	Thu, 27 Aug 2026 11:11:37 +0800 (CST)
Message-ID: <6A8FAACE.1040601@126.com>
Date: Thu, 27 Aug 2026 11:11:10 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: Hyunchul Lee <hyc.lee@gmail.com>, 
 Hongling Zeng <zenghongling@kylinos.cn>
CC: linkinjeon@kernel.org, ntfs@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ntfs: fix race between fallocate and mmap reads
References: <20260826054204.1364589-1-zenghongling@kylinos.cn> <CANFS6bbVZ3jZa+a8FTjz1w3RuPvFTgjfBh134J4a-9fK549UxQ@mail.gmail.com>
In-Reply-To: <CANFS6bbVZ3jZa+a8FTjz1w3RuPvFTgjfBh134J4a-9fK549UxQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnL8zoqo9q1iCbGg--.30864S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KFWDCw4xZr18KF1kWF45KFg_yoW8KF1rpr
	Z3KF15Kws3X34jvF1vg3y8uF1rW3ykWrW5WrWSq3WxuFnxtFn2gF4jkr1furyxKF9xJr4f
	Xr1jqr9ruFy7ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jI0PfUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrgljNGqPqukN7gAA31


在 2026年08月27日 10:43, Hyunchul Lee 写道:
> Hi Hongling,
>
> 2026년 8월 26일 (수) 오후 2:42, Hongling Zeng <zenghongling@kylinos.cn>님이 작성:
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
> map_locked can be removed.
> Otherwise it looks good to me.
>
> Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> |Hi Hyunchul,||||Thanks for reviewing.
>
> You're right, since invalidate_lock is now taken unconditionally,
> map_locked is no longer needed. I'll remove it in v2.
>
> Thanks|
>
>>          switch (mode & FALLOC_FL_MODE_MASK) {
>>          case FALLOC_FL_ALLOCATE_RANGE:
>> --
>> 2.25.1
>>
>
> --
> Thanks,
> Hyunchul

