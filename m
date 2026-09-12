Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E43369990
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 08:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203127; cv=none; b=aa5hyOrOO3UA+eJi2jqv8YtpAefUEHSlfH+J6pEpOAmtEQfLz4+8S8OvIIBVZRxCjFShnXlqGZl8bobgi41n5dPP4WhC/AietVqsJ7RngcjZV471BOzD8gy/NQiHoU12UzUe1PQWa0nPBqv/fbIoWZgN0wrieJPUol8a0rtsiGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203127; c=relaxed/simple;
	bh=FvDyIeajTzPoqqyVVH8idp/ukPMukR8P8DfR0tOhbrs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fV274/hUtOjE7HJSozteQfDKoJFpla/joQYlyU2WCi+6Un9KmShW5eOEAJEtJ3lfqpvf3H0/M6NXKwutLEc/m6enze0VlHfPzm1NHLSVZ6zzlUlZKAEDxvh60txDIAsp1LofRLGS5Lv+vcDDrYTqNdZtIQSSUDYy8HrNxBX6H0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YcpcxXIz; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YcpcxXIz"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f6c7a4aso35045566b.0
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1789203123; x=1789807923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X2mVxp3XlX3rnCXS7z9wGOr6nw5exllwoCYlzrLQ+oo=;
        b=YcpcxXIzSRUs9wJAD+hxsy/C+pqc4xgCEq16PdPcPUMURUPoE+H+5wcrej4IZzyNN2
         i1cjvhCW+Qg+BBE8wAxVyS3aA8EZed/vt48okZiKmsRc9PepZziW/osPXf9OXPzxrDSb
         nG7NCVOQ4lLaXlATCABP4tuh/HyuHptxXLXawc3PXfRF/c/pLwUGseXYDIjbQX+st9ye
         KCoZC6UMlWJmKFj/WeXSILGhJD5ijHPVp2kim5J7Xa/8jRe8+dky18mj3NhBXetvcBl3
         Gc+JmdkgvWY5v0EmMnNes0oaXVF+/7Z1B/v7q0Eceu/ZN3fQ7s/nBnKrPAhl5AIwlXzF
         YsFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789203123; x=1789807923;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X2mVxp3XlX3rnCXS7z9wGOr6nw5exllwoCYlzrLQ+oo=;
        b=iNthXDbkwtniSB+MC1srSHlWGtnQAjbTsabkhNeESt50RakOzOwPS5R5L9ktOmSc5S
         0MEmhxl23kO/vS3n1YITj25QllZmY9nuG2b0URDKCZqTOggo3PIhIEcgZqRRc+CfXwws
         dRMb9NQ7w9yfhZoE8MnaVThlrKc3iKjHQYS4jH/WaeQwcGrvqP/QaTnd2RE/aGW2K7GX
         CLYbzbpbmZWsJ9SEHg/xNS3hw4ZgfHNps7bm95FsVWI+cA9xXk3QsQpd2W0X9wXNY3mk
         UkxJP8NAeObbdK+LW/FV2PQx8hPQ3lAgd0V6kwhr9tZxGIaXJ80zylfNf1/u9BnVdtPc
         Nh7A==
X-Forwarded-Encrypted: i=1; AKwUvBz8R7HaCzTMw8xhYNKo51fKNS4QJ9fUw7EfVYh0tmFQT3b4yYrqssREf2ScXIdKum/DcoJ2uQs=@vger.kernel.org
X-Gm-Message-State: AFuF++mDZWBQb4FH8TTa4BLZhAa0kJIUSoc4KZ+97IYaw7BjRMZexiu+
	qBGQtp/G4x3jk9VtJDqAjtlzXB/YiH/57hZ6ahzP6150eGNv9QuIB/U3NmM/XBLTNSw=
X-Gm-Gg: AYBFou32fi2xwuiTuiHrgGqSeEl4EMzdKWMZpOGYBERcQugtKAoa18/lZBHLAdUV7AM
	/R66ntpR5ryT4nFy8Psag0bdKlmQa0daVs1O6vY5oCWn5v9p0lMFgNiXJx6C+Tf5iytOXNmaUlr
	W2ZdJqc2E1FzcbWHSnK3jGkgg19DtQlUKPHpNLY8CTDTxCgxXGw9lsrGK2sKzbvlj6Pv2eeAutb
	u1vd0jU/piGWZEXQv9MEJfLZLwpJYul6LhTcaOQqSW9+/y2Rl3CEyC/311MYvVHX8LCZpoG+Q1m
	DmTr+GjhTEultQaatDpdiJbeSekpMPVAOczHQs9aMlEUQRlAxBbKJbRnWhei1oUfMrhshnfAoq5
	0Dcqlil1dPeqyd/zcBq7WCljstesILNMjWMqEVKLF5KeyKd9XJ0FNA3UDUJbI3Bc9gSLPiYV3dA
	ajzG1cVtqnAu0cZu3x7njw8VkvcNikd84T4puYVPlCkZoZHLtgkGTk7ld5Pmy3zVo=
X-Received: by 2002:a17:907:a317:b0:c29:4b08:79d with SMTP id a640c23a62f3a-c29858b1bfcmr92871966b.26.1789203123498;
        Sat, 12 Sep 2026 01:52:03 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29ebc712sm2088303b3a.49.2026.09.12.01.51.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 01:52:01 -0700 (PDT)
Message-ID: <d460ffbb-5db6-4029-b177-9273a8261453@suse.com>
Date: Sat, 12 Sep 2026 18:21:53 +0930
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7.2 1226/1815] btrfs: fix a lockdep caused by path
 resolution during device scan
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org
Cc: patches@lists.linux.dev, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Filipe Manana <fdmanana@suse.com>,
 David Sterba <dsterba@suse.com>, Sasha Levin <sashal@kernel.org>
References: <20260912065648.999753832@linuxfoundation.org>
 <20260912065717.791396667@linuxfoundation.org>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXVgBQkQ/lqxAAoJEMI9kfOh
 Jf6o+jIH/2KhFmyOw4XWAYbnnijuYqb/obGae8HhcJO2KIGcxbsinK+KQFTSZnkFxnbsQ+VY
 fvtWBHGt8WfHcNmfjdejmy9si2jyy8smQV2jiB60a8iqQXGmsrkuR+AM2V360oEbMF3gVvim
 2VSX2IiW9KERuhifjseNV1HLk0SHw5NnXiWh1THTqtvFFY+CwnLN2GqiMaSLF6gATW05/sEd
 V17MdI1z4+WSk7D57FlLjp50F3ow2WJtXwG8yG8d6S40dytZpH9iFuk12Sbg7lrtQxPPOIEU
 rpmZLfCNJJoZj603613w/M8EiZw6MohzikTWcFc55RLYJPBWQ+9puZtx1DopW2jOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJnEXWBBQkQ/lrSAAoJEMI9kfOhJf6o
 cakH+QHwDszsoYvmrNq36MFGgvAHRjdlrHRBa4A1V1kzd4kOUokongcrOOgHY9yfglcvZqlJ
 qfa4l+1oxs1BvCi29psteQTtw+memmcGruKi+YHD7793zNCMtAtYidDmQ2pWaLfqSaryjlzR
 /3tBWMyvIeWZKURnZbBzWRREB7iWxEbZ014B3gICqZPDRwwitHpH8Om3eZr7ygZck6bBa4MU
 o1XgbZcspyCGqu1xF/bMAY2iCDcq6ULKQceuKkbeQ8qxvt9hVxJC2W3lHq8dlK1pkHPDg9wO
 JoAXek8MF37R8gpLoGWl41FIUb3hFiu3zhDDvslYM4BmzI18QgQTQnotJH8=
In-Reply-To: <20260912065717.791396667@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/9/12 16:19, Greg Kroah-Hartman 写道:
> 7.2-stable review patch.  If anyone has any objections, please let me know.

Please drop this one.

There are already users (although the minority of users) who do not use 
an initramfs to boot, and the device path of rootfs stays as "/dev/root".

With this patch, there will be no way to update the "/dev/root" name of 
the rootfs.

Normally it is just a cosmetic problem, but tools like grub2 will be 
unable to probe the driver for the rootfs.

I'd argue we should discourage root btrfs without an initramfs, and 
grub2 should use device number/libblkid to properly detect rootfs 
devices, but still there are users complaining.

There will be a special hot fix for it, but I'd prefer to at least delay 
this one.

The deadlock itself is not easy to trigger, it requires block device 
files created on btrfs, and doing block device scan on that file over btrfs.

Thanks,
Qu


> 
> ------------------
> 
> From: Qu Wenruo <wqu@suse.com>
> 
> [ Upstream commit 108cc873398932af589c295f78c348513b8d70d9 ]
> 
> [BUG]
> There is a lockdep report related to device scan:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 7.2.0-20260712.rc2.git0.e3321fa3034d.300.fc44.s390x+debug #1 Not tainted
> ------------------------------------------------------
> (udev-worker)/1653 is trying to acquire lock:
> 0000006919232220 (&type->i_mutex_dir_key#2){++++}-{3:3}, at: lookup_slow+0x3e/0x70
> but task is already holding lock:
> 00000069238564d8 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: device_list_add.constprop.0+0x148/0xc60
> which lock already depends on the new lock.
> the existing dependency chain (in reverse order) is:
> -> #5 (&fs_devs->device_list_mutex){+.+.}-{3:3}:
>         lock_acquire+0x150/0x3f0
>         __mutex_lock+0xba/0xdc0
>         mutex_lock_nested+0x32/0x40
>         write_all_supers+0x7a/0x670
>         btrfs_sync_log+0xae6/0xdd0
>         btrfs_sync_file+0x4fa/0x7a0
>         __s390x_sys_fsync+0x52/0xa0
>         __do_syscall+0x172/0x750
>         system_call+0x72/0x90
> -> #4 (&fs_info->tree_log_mutex){+.+.}-{3:3}:
>         lock_acquire+0x150/0x3f0
>         __mutex_lock+0xba/0xdc0
>         mutex_lock_nested+0x32/0x40
>         btrfs_sync_log+0xaba/0xdd0
>         btrfs_sync_file+0x4fa/0x7a0
>         __s390x_sys_fsync+0x52/0xa0
>         __do_syscall+0x172/0x750
>         system_call+0x72/0x90
> -> #3 (btrfs_trans_num_extwriters){.+.+}-{0:0}:
>         lock_acquire+0x150/0x3f0
>         join_transaction+0x108/0x680
>         start_transaction+0x21a/0x660
>         btrfs_join_transaction+0x32/0x40
>         btrfs_dirty_inode+0x52/0xf0
>         touch_atime+0x90/0xc0
>         filemap_read+0x446/0x450
>         vfs_read+0x208/0x370
>         ksys_read+0x88/0x120
>         __do_syscall+0x172/0x750
>         system_call+0x72/0x90
> -> #2 (btrfs_trans_num_writers){.+.+}-{0:0}:
>         reacquire_held_locks+0x14c/0x240
>         __lock_release.isra.0+0xd8/0x380
>         lock_release+0xf6/0x270
>         percpu_up_read+0x28/0xf0
>         __btrfs_end_transaction+0x178/0x1f0
>         btrfs_dirty_inode+0x82/0xf0
>         touch_atime+0x90/0xc0
>         btrfs_file_mmap_prepare+0x8c/0xa0
>         __mmap_region+0x214/0x780
>         mmap_region+0x108/0x160
>         do_mmap+0x402/0x5a0
>         vm_mmap_pgoff+0x156/0x230
>         ksys_mmap_pgoff+0x17e/0x220
>         __s390x_sys_old_mmap+0xa8/0x140
>         __do_syscall+0x172/0x750
>         system_call+0x72/0x90
> -> #1 (&mm->mmap_lock){++++}-{3:3}:
>         lock_acquire+0x150/0x3f0
>         __might_fault+0x7a/0xa0
>         filldir64+0x11c/0x210
>         offset_readdir+0x92/0x200
>         iterate_dir+0xcc/0x2d0
>         __do_sys_getdents64+0x7a/0x130
>         __do_syscall+0x172/0x750
>         system_call+0x72/0x90
> -> #0 (&type->i_mutex_dir_key#2){++++}-{3:3}:
>         check_prev_add+0x160/0xf40
>         __lock_acquire+0x12aa/0x15a0
>         lock_acquire+0x150/0x3f0
>         down_read+0x5a/0x280
>         lookup_slow+0x3e/0x70
>         path_lookupat+0x1f0/0x370
>         filename_lookup+0xce/0x1f0
>         kern_path+0x48/0x70
>         is_same_device+0x146/0x300
>         device_list_add.constprop.0+0x1be/0xc60
>         btrfs_scan_one_device+0x13a/0x2f0
>         btrfs_control_ioctl+0x110/0x1e0
>         __s390x_sys_ioctl+0xfa/0x130
>         __do_syscall+0x172/0x750
>         system_call+0x72/0x90
> other info that might help us debug this:
> Chain exists of:
>    &type->i_mutex_dir_key#2 --> &fs_info->tree_log_mutex --> &fs_devs->device_list_mutex
>   Possible unsafe locking scenario:
>         CPU0                    CPU1
>         ----                    ----
>    lock(&fs_devs->device_list_mutex);
>                                 lock(&fs_info->tree_log_mutex);
>                                 lock(&fs_devs->device_list_mutex);
>    rlock(&type->i_mutex_dir_key#2);
>   *** DEADLOCK ***
> 2 locks held by (udev-worker)/1653:
>   #0: 0000016c727051c8 (uuid_mutex){+.+.}-{3:3}, at: btrfs_control_ioctl+0x102/0x1e0
>   #1: 00000069238564d8 (&fs_devs->device_list_mutex){+.+.}-{3:3}, at: device_list_add.constprop.0+0x148/0xc60
> stack backtrace:
> CPU: 2 UID: 0 PID: 1653 Comm: (udev-worker) Not tainted 7.2.0-20260712.rc2.git0.e3321fa3034d.300.fc44.s390x+debug #1 PREEMPT
> Hardware name: IBM 3931 A01 701 (LPAR)
> Call Trace:
>   [<0000016c70680e3e>] dump_stack_lvl+0xae/0x108
>   [<0000016c7078aa44>] print_circular_bug+0x1a4/0x230
>   [<0000016c7078ac5c>] check_noncircular+0x18c/0x1b0
>   [<0000016c7078c030>] check_prev_add+0x160/0xf40
>   [<0000016c7078fbaa>] __lock_acquire+0x12aa/0x15a0
>   [<0000016c7078fff0>] lock_acquire+0x150/0x3f0
>   [<0000016c7180e2fa>] down_read+0x5a/0x280
>   [<0000016c70b88dde>] lookup_slow+0x3e/0x70
>   [<0000016c70b8f5d0>] path_lookupat+0x1f0/0x370
>   [<0000016c70b900ae>] filename_lookup+0xce/0x1f0
>   [<0000016c70b90218>] kern_path+0x48/0x70
>   [<0000016c70f5b4a6>] is_same_device+0x146/0x300
>   [<0000016c70f67cfe>] device_list_add.constprop.0+0x1be/0xc60
>   [<0000016c70f688da>] btrfs_scan_one_device+0x13a/0x2f0
>   [<0000016c70ed9cb0>] btrfs_control_ioctl+0x110/0x1e0
>   [<0000016c70b97d0a>] __s390x_sys_ioctl+0xfa/0x130
>   [<0000016c718004d2>] __do_syscall+0x172/0x750
>   [<0000016c718155d2>] system_call+0x72/0x90
> 
> [CAUSE]
> Btrfs device scan will call is_same_device() with device_list_mutex
> held. But is_same_device() will call kern_path() which will do path
> resolution and lock the inode.
> 
> So device scan has the following lock sequence:
> 
>   mutex_lock(device_list_mutex) from device_list_add()
>     |
>     v
>   inode_lock_shared() from lookup_slow() during kern_path().
> 
> Meanwhile another thread is fsyncing, which has the following
> lock sequence:
> 
>   inode_lock() from btrfs_inode_lock() inside btrfs_direct_write()
>     |
>     v
>   mutex_lock(tree_log_mutex() from btrfs_sync_log(), which is further
>   triggered from
>   iomap_dio_complete()->generic_write_sync()->btrfs_sync_file().
>     |
>     v
>   mutex_lock(device_list_mutex) from write_all_supers() inside
>   btrfs_sync_log().
> 
> So the device scan has a reversed lock sequence, compared to the fsync
> one, this means we can have the following deadlock:
> 
>            Device scan                   |           Fsync
> ----------------------------------------+--------------------------------
>   device_list_mutex locked               |
>                                          |   inode locked
> 					|   try to lock device_list_mutex
>   try to lock inode                      |
> 
> [FIX]
> Instead of a full path lookup, use dev_t to determine if two device
> paths are pointing to the same block device.
> 
> Inside kernel dev_t is going to uniquely determine a block device, and
> the device path lookup is already done by lookup_bdev(), which is done
> without device_list_mutex held, thus no reversed locking sequence.
> 
> Reported-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Link: https://lore.kernel.org/linux-btrfs/5a9d9847-4ae6-43c4-afdc-6e5fa51d6117@linux.ibm.com/
> Fixes: 2e8b6bc0ab41 ("btrfs: avoid unnecessary device path update for the same device")
> Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Reviewed-by: Filipe Manana <fdmanana@suse.com>
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> Signed-off-by: David Sterba <dsterba@suse.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   fs/btrfs/volumes.c | 37 +------------------------------------
>   1 file changed, 1 insertion(+), 36 deletions(-)
> 
> diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
> index 6eab4cc73ce44..8bcc6cb837695 100644
> --- a/fs/btrfs/volumes.c
> +++ b/fs/btrfs/volumes.c
> @@ -740,41 +740,6 @@ const u8 *btrfs_sb_fsid_ptr(const struct btrfs_super_block *sb)
>   	return has_metadata_uuid ? sb->metadata_uuid : sb->fsid;
>   }
>   
> -static bool is_same_device(struct btrfs_device *device, const char *new_path)
> -{
> -	struct path old = { .mnt = NULL, .dentry = NULL };
> -	struct path new = { .mnt = NULL, .dentry = NULL };
> -	char AUTO_KFREE(old_path);
> -	bool is_same = false;
> -	int ret;
> -
> -	if (!device->name)
> -		goto out;
> -
> -	old_path = kzalloc(PATH_MAX, GFP_NOFS);
> -	if (!old_path)
> -		goto out;
> -
> -	rcu_read_lock();
> -	ret = strscpy(old_path, rcu_dereference(device->name), PATH_MAX);
> -	rcu_read_unlock();
> -	if (ret < 0)
> -		goto out;
> -
> -	ret = kern_path(old_path, LOOKUP_FOLLOW, &old);
> -	if (ret)
> -		goto out;
> -	ret = kern_path(new_path, LOOKUP_FOLLOW, &new);
> -	if (ret)
> -		goto out;
> -	if (path_equal(&old, &new))
> -		is_same = true;
> -out:
> -	path_put(&old);
> -	path_put(&new);
> -	return is_same;
> -}
> -
>   /*
>    * Add new device to list of registered devices
>    *
> @@ -895,7 +860,7 @@ static noinline struct btrfs_device *device_list_add(const char *path,
>   				MAJOR(path_devt), MINOR(path_devt),
>   				current->comm, task_pid_nr(current));
>   
> -	} else if (!device->name || !is_same_device(device, path)) {
> +	} else if (!device->name || device->devt != path_devt) {
>   		const char *old_name;
>   
>   		/*

