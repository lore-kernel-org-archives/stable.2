Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363042;
	b=I+jCJbq417ba/2EjPth3uCR9DqG7B5A2MWxjnzQbJ0B/dDC4gBP0x0GXlJvpg0Ifrs/0
	 ruvqPfNtfFW2+cfwF5NsPEq09uSK0OCJG3A4vfmunfLrDiyP4gjh29QrUqOHPEnMR4QMA
	 SlrjokXwIYBFKYp78ARorL6qFzBATXhaVBDiGQC9onjavYGVqhId75xY945wUS4/eM+Lo
	 uHHpmhn3yZa8oVfPA3V9Fg1NiVX0JKNbdop+eyYp7bq7bxI1AA2aBjTckMyesxKRCBTLW
	 J0CmdcnZyTTb12khUVq/rIC2Z6jMhPrqXBJhFJXw2IQTCG4TMy42VYA+eo1CGQvnseg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363042;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=hOTL3ynqrdAagNxrpnS2EPcvLUhi8fo9egZpNWmibrc=;
	b=ji8YE0wDPMQuYVw6u+0wWX7VJ3b/dJJnkmnFs41VQujgm5dJs9mxRwsnSULh2R8xgsJB
	 qlJPuSpa379/stUXWvhUnuNJRhQ9cKevGoLNt+xOX/DoB67l+wwz3Msoo9Z7zs/Zhl3aX
	 f4kK9/JCJE3tcyK1YApZ5jtBg/Nn+MIka3KXdKoKl1kzNEm6zr1qPtNc56OSsdCblCtAr
	 pzd7Ti0SmE2SNr3w8T3oz2X/+7Fb/CNOStKIfs4w8h2n8y4nOoeSD9wQnD1UTqC6yTPdE
	 z21q3SBhHlHKt8NvQMGqCBJxJf10CENKQ8bYGbmy9YjVVMhwTF/mGCWqfzOBNTiVKVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=o3znHdw+;
	arc=none smtp.remote-ip=113.46.200.226
Received: from canpmsgout11.his.huawei.com (canpmsgout11.his.huawei.com [113.46.200.226])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C6F606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6C6F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=o3znHdw+
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=hOTL3ynqrdAagNxrpnS2EPcvLUhi8fo9egZpNWmibrc=;
	b=o3znHdw+y19luWgswyg/VMfSfXPGyPgITZ9tIhERRdvv9zMnBwh2kvLfKrk/+o554MJ67A4bj
	4ZnAVKdkuPi8Z/mvMV8eMuy0JofjW/WMQ6UjRB0aoANRJGdPyv7O2J+GY+/0oy55Togvxz1yQus
	GvhdFu4zsCJ3uqXG2fnzLjI=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4jPRnC6KfwzKm8S;
	Wed, 11 Nov 2026 10:10:23 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id B07DD4048B;
	Wed, 11 Nov 2026 10:10:33 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 kwepemf200016.china.huawei.com (7.202.181.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 11 Nov 2026 10:10:33 +0800
Message-ID: <95941b27-84b0-4895-a473-a584533ff0cd@huawei.com>
Date: Wed, 11 Nov 2026 10:10:32 +0800
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
Subject: Re: [PATCH 6.1.y] nilfs2: ignore non-fatal signals during synchronous
 log write wait
To: Ryusuke Konishi <konishi.ryusuke@gmail.com>
CC: <stable@vger.kernel.org>,
	<syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com>, Viacheslav Dubeyko
	<slava@dubeyko.com>
References: <20261107054332-failed-6.1-7131aaa74bcc@kernel.org>
 <20261111013114.470246-1-wangjianjian3@huawei.com>
 <CAKFNMoneZ4jzi025V4w4Ep2N_VpHediHwwoe7TY6OowVjmq9_g@mail.gmail.com>
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <CAKFNMoneZ4jzi025V4w4Ep2N_VpHediHwwoe7TY6OowVjmq9_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemf200016.china.huawei.com (7.202.181.9)


在 2026/11/11 9:59, Ryusuke Konishi 写道:
> On Wed, Nov 11, 2026 at 10:33 AM Wang Jianjian wrote:
>>
>> From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
>>
>> Based on a syzbot report, Wang Jianjian pointed out that following a
>> successful directory operation in nilfs_rename(), a synchronous write
>> requested within nilfs_transaction_commit(), triggered by a sync flag
>> set by nilfs_commit_chunk(), could be interrupted by a user signal.
>> This interruption leaves in-memory metadata updates intact while
>> returning an error, causing inconsistency with the VFS dentry cache and
>> ultimately triggering a kernel warning.
>>
>> According to "signal(7)", local disks are not classified as "slow
>> devices" (such as terminals, FIFOs, or pipes) and their I/O operations
>> on disk devices are not interrupted by signals.  In kernel space,
>> waiting for such disk I/O should therefore not be aborted by ordinary
>> (non-fatal) signals.
>>
>> Suppress this issue by modifying nilfs_segctor_sync(), which waits for
>> the log writer thread to complete synchronous writes, to catch only
>> fatal signals via fatal_signal_pending() and return -EINTR rather than
>> -ERESTARTSYS.  To complement this change and prevent the wait loop from
>> busy-looping when schedule() returns immediately due to a pending
>> non-fatal signal, switch the wait state from TASK_INTERRUPTIBLE to
>> TASK_KILLABLE.
>>
>> This serves as an effective interim stabilization measure without
>> structural changes until a comprehensive fix for metadata consistency
>> is implemented.
>>
>> Reported-by: syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=f6c7e1f1809f235eeb90
>> Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
>> Tested-by: syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com
>> Cc: Wang Jianjian <wangjianjian3@huawei.com>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
>> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
>> (cherry picked from commit 7131aaa74bcc7c9da1f1d1c8724da75c775557a0)
>> ---
> 
> Hi Wang Jianjian,
> 
> The patches that the fix patch depends on have also been submitted to
> the stable tree, so the conflicts should be resolved.
> 
> Considering future backports, I think Sasha Levin's approach of
> simultaneously sending acceptable dependency patches to resolve the
> issue is preferable.
> 
> Could you please check the link below?
> 
> [6.12.y] https://lore.kernel.org/all/20261110131241.1664282-1-sashal@kernel.org/
> [6.6.y] https://lore.kernel.org/all/20261110131728.1706995-1-sashal@kernel.org/
> [6.1.y] https://lore.kernel.org/all/20261110132237.1722151-1-sashal@kernel.org/
> [5.15.y] https://lore.kernel.org/all/20261110132713.1736389-1-sashal@kernel.org
> 
> Please let me know if your intention was different.

Hi,
ok, I misunderstood this. sorry about this confuse.>
> Thanks,
> Ryusuke Konishi
> 
> 
> 
>>   fs/nilfs2/ioctl.c    |  2 +-
>>   fs/nilfs2/recovery.c |  2 ++
>>   fs/nilfs2/segment.c  | 10 +++++++---
>>   3 files changed, 10 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
>> index 4e964549bc4c..cbbe49bb4926 100644
>> --- a/fs/nilfs2/ioctl.c
>> +++ b/fs/nilfs2/ioctl.c
>> @@ -960,10 +960,10 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
>>    * Return: 0 on success, or one of the following negative error codes on
>>    * failure:
>>    * * %-EFAULT          - Failure during execution of requested operation.
>> + * * %-EINTR           - Interrupted.
>>    * * %-EIO             - I/O error.
>>    * * %-ENOMEM          - Insufficient memory available.
>>    * * %-ENOSPC          - No space left on device (only in a panic state).
>> - * * %-ERESTARTSYS     - Interrupted.
>>    * * %-EROFS           - Read only filesystem.
>>    */
>>   static int nilfs_ioctl_sync(struct inode *inode, struct file *filp,
>> diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
>> index ce30b51ac593..34462039ae7d 100644
>> --- a/fs/nilfs2/recovery.c
>> +++ b/fs/nilfs2/recovery.c
>> @@ -744,6 +744,8 @@ static void nilfs_abort_roll_forward(struct the_nilfs *nilfs)
>>    * Return Value: On success, 0 is returned.  On error, one of the following
>>    * negative error code is returned.
>>    *
>> + * %-EINTR - Interrupted.
>> + *
>>    * %-EINVAL - Inconsistent filesystem state.
>>    *
>>    * %-EIO - I/O error
>> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
>> index a412abdfbbf3..3a256f786db2 100644
>> --- a/fs/nilfs2/segment.c
>> +++ b/fs/nilfs2/segment.c
>> @@ -2236,7 +2236,7 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
>>          wake_up(&sci->sc_wait_daemon);
>>
>>          for (;;) {
>> -               set_current_state(TASK_INTERRUPTIBLE);
>> +               set_current_state(TASK_KILLABLE);
>>
>>                  /*
>>                   * Synchronize only while the log writer thread is alive.
>> @@ -2250,11 +2250,11 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
>>                          err = wait_req.err;
>>                          break;
>>                  }
>> -               if (!signal_pending(current)) {
>> +               if (!fatal_signal_pending(current)) {
>>                          schedule();
>>                          continue;
>>                  }
>> -               err = -ERESTARTSYS;
>> +               err = -EINTR;
>>                  break;
>>          }
>>          finish_wait(&sci->sc_wait_request, &wait_req.wq);
>> @@ -2289,6 +2289,8 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err, bool force)
>>    * Return Value: On success, 0 is returned. On errors, one of the following
>>    * negative error code is returned.
>>    *
>> + * %-EINTR - Interrupted.
>> + *
>>    * %-EROFS - Read only filesystem.
>>    *
>>    * %-EIO - I/O error
>> @@ -2324,6 +2326,8 @@ int nilfs_construct_segment(struct super_block *sb)
>>    * Return Value: On success, 0 is returned. On errors, one of the following
>>    * negative error code is returned.
>>    *
>> + * %-EINTR - Interrupted.
>> + *
>>    * %-EROFS - Read only filesystem.
>>    *
>>    * %-EIO - I/O error
>> --
>> 2.34.1
>>

-- 
Regards
