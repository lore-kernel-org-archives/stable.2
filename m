Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794359854;
	b=Sn8MGLkidwDCjZgxJKgQfN5G/pp3dIdYy/VLtXbpLxob4YDQksZXItO/I0rZ9gkJ661s
	 NeMxmRENDLY0Q9PUHBoS0jCTgcSi4UfxSb9hY2Fr/mgO1nXG14quo0PxynM9ocUIQATg4
	 OQRR5yBEMx+7ghVkyl3LA8Yoy71Kl/kutMLYE8b6o3URsitNOSrwMPM6Vml8EbMq6VFf5
	 xtrGx3Zr7SsbKtMUyKdqysJiy1lrIeeSajhZ0FaY0EvRNGGB4tzCjlj6uffir3wdVPI+S
	 GgwH6sOZw2v6lYnRSR9OGcJW6n7LX5CXpWEe1VvU2YXFAN5vCg0LrmryvJGX+qUsa5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794359854;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=bgX2frutdKa3nUwn53N50PB8rl432cPTQFa+RanFp4I=;
	b=n/zRqTgg+EIZXetWfb3ud40AcnyCHzlGyJCQrUSqCEqsyxPKJIVTMYWtESoFg8gEKgVN
	 x/M+m8P3HCTpiG9QHh3NodhlzJfqIzkAXz9mANojsCpo/5w90zeXUdXGxtq0daJa83D1e
	 cRvR6O5xBlKzqEEKDEG27iGp3aHxasP19xIirbbnbMdhGibevgfv0gEM2wteIQLFN2CUu
	 2GMwvpl/eqmxCv4ox5+/EVu8FOO+p4fhETYM6ICNR+ySN3ITibKkZAD5Be57CAPyAHyCF
	 k/+2d7yHea4RcrFp3Kze8XqYjUgHEXRZmqozEgT6n91JbvsLbOje50GvB+/w1cSfxaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b="0D/KYGTO";
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8ED606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED8ED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=0D/KYGTO
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bgX2frutdKa3nUwn53N50PB8rl432cPTQFa+RanFp4I=;
	b=0D/KYGTO5ZoLI5N4HAh/H927BZRf6tkv8x/TIxlUZ6WMnndOaXQ1KpzxWDpKzaFqnG6YwQFEf
	mXNNYnr2ZncYVeMdU9gbDHbxSGemluh+RJjuH80w7MMIjLnmxZR773iQ6ZGMsujpnsZQNArcNv7
	1VX4tV9A1iahOlX7IVEiF8E=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jPQcH6qrxznTVm;
	Wed, 11 Nov 2026 09:17:35 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id EEC274055B;
	Wed, 11 Nov 2026 09:17:30 +0800 (CST)
Received: from [10.108.234.194] (10.108.234.194) by
 kwepemf200016.china.huawei.com (7.202.181.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 11 Nov 2026 09:17:30 +0800
Message-ID: <3d9854df-f152-46e6-926a-acbb4e634eb6@huawei.com>
Date: Wed, 11 Nov 2026 09:17:29 +0800
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
Subject: Re: [PATCH 6.12.y] nilfs2: ignore non-fatal signals during
 synchronous log write wait
To: <stable@vger.kernel.org>
CC: Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	<syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com>, Viacheslav Dubeyko
	<slava@dubeyko.com>
References: <20261107051820-failed-6.12-7131aaa74bcc@kernel.org>
 <20261111011339.4103615-1-wangjianjian3@huawei.com>
From: "wangjianjian (C)" <wangjianjian3@huawei.com>
In-Reply-To: <20261111011339.4103615-1-wangjianjian3@huawei.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf200016.china.huawei.com (7.202.181.9)

I resolve it, but please let wait Ryusuke's Ack.

在 2026/11/11 9:13, Wang Jianjian 写道:
> From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> 
> Based on a syzbot report, Wang Jianjian pointed out that following a
> successful directory operation in nilfs_rename(), a synchronous write
> requested within nilfs_transaction_commit(), triggered by a sync flag
> set by nilfs_commit_chunk(), could be interrupted by a user signal.
> This interruption leaves in-memory metadata updates intact while
> returning an error, causing inconsistency with the VFS dentry cache and
> ultimately triggering a kernel warning.
> 
> According to "signal(7)", local disks are not classified as "slow
> devices" (such as terminals, FIFOs, or pipes) and their I/O operations
> on disk devices are not interrupted by signals.  In kernel space,
> waiting for such disk I/O should therefore not be aborted by ordinary
> (non-fatal) signals.
> 
> Suppress this issue by modifying nilfs_segctor_sync(), which waits for
> the log writer thread to complete synchronous writes, to catch only
> fatal signals via fatal_signal_pending() and return -EINTR rather than
> -ERESTARTSYS.  To complement this change and prevent the wait loop from
> busy-looping when schedule() returns immediately due to a pending
> non-fatal signal, switch the wait state from TASK_INTERRUPTIBLE to
> TASK_KILLABLE.
> 
> This serves as an effective interim stabilization measure without
> structural changes until a comprehensive fix for metadata consistency
> is implemented.
> 
> Reported-by: syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=f6c7e1f1809f235eeb90
> Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
> Tested-by: syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com
> Cc: Wang Jianjian <wangjianjian3@huawei.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
> (cherry picked from commit 7131aaa74bcc7c9da1f1d1c8724da75c775557a0)
> ---
>   fs/nilfs2/ioctl.c    |  2 +-
>   fs/nilfs2/recovery.c |  2 ++
>   fs/nilfs2/segment.c  | 10 +++++++---
>   3 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
> index 03062b6bc323..11ccf18c3999 100644
> --- a/fs/nilfs2/ioctl.c
> +++ b/fs/nilfs2/ioctl.c
> @@ -972,10 +972,10 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
>    * Return: 0 on success, or one of the following negative error codes on
>    * failure:
>    * * %-EFAULT		- Failure during execution of requested operation.
> + * * %-EINTR		- Interrupted.
>    * * %-EIO		- I/O error.
>    * * %-ENOMEM		- Insufficient memory available.
>    * * %-ENOSPC		- No space left on device (only in a panic state).
> - * * %-ERESTARTSYS	- Interrupted.
>    * * %-EROFS		- Read only filesystem.
>    */
>   static int nilfs_ioctl_sync(struct inode *inode, struct file *filp,
> diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
> index 21d81097a89f..f1d346aefc76 100644
> --- a/fs/nilfs2/recovery.c
> +++ b/fs/nilfs2/recovery.c
> @@ -760,6 +760,8 @@ static void nilfs_abort_roll_forward(struct the_nilfs *nilfs)
>    * Return Value: On success, 0 is returned.  On error, one of the following
>    * negative error code is returned.
>    *
> + * %-EINTR - Interrupted.
> + *
>    * %-EINVAL - Inconsistent filesystem state.
>    *
>    * %-EIO - I/O error
> diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
> index 063400f8a73c..530ae5889bc6 100644
> --- a/fs/nilfs2/segment.c
> +++ b/fs/nilfs2/segment.c
> @@ -2266,7 +2266,7 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
>   	wake_up(&sci->sc_wait_daemon);
>   
>   	for (;;) {
> -		set_current_state(TASK_INTERRUPTIBLE);
> +		set_current_state(TASK_KILLABLE);
>   
>   		/*
>   		 * Synchronize only while the log writer thread is alive.
> @@ -2280,11 +2280,11 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
>   			err = wait_req.err;
>   			break;
>   		}
> -		if (!signal_pending(current)) {
> +		if (!fatal_signal_pending(current)) {
>   			schedule();
>   			continue;
>   		}
> -		err = -ERESTARTSYS;
> +		err = -EINTR;
>   		break;
>   	}
>   	finish_wait(&sci->sc_wait_request, &wait_req.wq);
> @@ -2319,6 +2319,8 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err, bool force)
>    * Return Value: On success, 0 is returned. On errors, one of the following
>    * negative error code is returned.
>    *
> + * %-EINTR - Interrupted.
> + *
>    * %-EROFS - Read only filesystem.
>    *
>    * %-EIO - I/O error
> @@ -2354,6 +2356,8 @@ int nilfs_construct_segment(struct super_block *sb)
>    * Return Value: On success, 0 is returned. On errors, one of the following
>    * negative error code is returned.
>    *
> + * %-EINTR - Interrupted.
> + *
>    * %-EROFS - Read only filesystem.
>    *
>    * %-EIO - I/O error

-- 
Regards
