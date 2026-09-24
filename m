Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014C73A8758
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 09:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790242639; cv=none; b=PUJrhCXzpftDyZj2gHVPi02ohKj1KteAoYff42cu73LaxXiw3zbtmZ/ZUkJTQnae57/cmEpCmnkH2aUJqWNBl9B15/iVC6Fl4K9Tuy8HJPS29PQJuN+ib/efNdJDJIiUhlsFtdQRPt0yNpEUNBkpA/7g+S/Pt6OzqUZGvCTHDxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790242639; c=relaxed/simple;
	bh=70TFsAFRbI1TuzaqNIADo3Zfc7ofFfEiP7yn9cQoyzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CiOavgTkqhEAIbgOeKayO1Hv/DN4fUGrnVsQt79FCW6xwqZZLYTgPdW9BkvST/NeQ0gPaqIUILItsd0braLZ8nSBdmeCfhcuM7/lR5R4jXa6JEeTXXa1drcSnefbrzZQQbhw5cvk0DOj861WiLU9vz/cvPNTBecire83kznCUf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AmN19kJ8; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AmN19kJ8"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d91ede8035so16779845ad.3
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 02:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790242637; x=1790847437; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FHoeQiU6kNP6O34S62q6U8XbBumTsi34UKnTIzqpmJA=;
        b=AmN19kJ8BsJ0X1DljsyziIWCsc6ZQRbMF7/wBuPlYkavSBK3IPgRFebvJhf80wLL+F
         OyGPRgX6AozROkkIveCZtmOp/j9Iq1FflgyO/mGv/tpSAm5AbhYmiQUQv20SKjBESdXn
         iySZrvkw4PjISx+SRvyblr4H+JyHQ0Yxtf9NosmK5PjHS91fL0g/sNQAEesf7n5AQ7DZ
         s8HMYRPg5mLE1OdBLwiqURYRAFsN8k/fGsYXQGGcXUzp6ea0qRNsNJLKKZaeNqsf/TgB
         SGlrbDb0I/0qjATkqgdBpaDAZupNm+fkTJ9W029gJB704vLlFWSqR5lpOxo5iqpSocbd
         lv9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790242637; x=1790847437;
        h=content-transfer-encoding:content-type:in-reply-to:from:references
         :cc:to:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FHoeQiU6kNP6O34S62q6U8XbBumTsi34UKnTIzqpmJA=;
        b=GpXfS8p34rEsvN/fYvm6eWPehm9DW/PitfjyJt/dyxk+XMn89CPBWK5bOKN8E17I0N
         bsdlmO/sStbJtY7sz+3o39Un19xCLCUmwYB7n2Cw1A8Pesk24MURNTT+ou+9IPAZ7vjX
         VkWzyiU0NbqZCM3JwyknUvpCgAZx/W8TIJgxDe7pwnX87Ve39Ui/iiTNIX2jSS+gaD0y
         k3dGLdSgBTvWSsoMEffNJPVdqsqjAxlEzwYJCjDI7dtkQnbfzBQXmiaIFnxnyBFtvu3c
         Gjw9Z/uodwKNf4yxX09UlI2L3gLES3mR2HcUqmFazHzXbMKqmFjbREwdPh31CvO1pW6I
         G21g==
X-Forwarded-Encrypted: i=1; AKwUvBzcBEH8tyG2mbDJDI00PHSk1k+PIkjSrykfdq2D2Iq7Q4G4efdF9ruezaGckIF+vQrR19rnfTw=@vger.kernel.org
X-Gm-Message-State: AFuF++nK4nY4T/RJGuKvDd1i69nGcy+2vo/WlywDDbxlBjAiVOJv6ES6
	9NXlrPxJKGFC12iYYBb/QrDCN7kvX0JDLu6Dd6fbAitf+3/oUfk3LqW6
X-Gm-Gg: AYBFou2Zw6ugSFHqPpzIDFJ48/efjyccjyP7Z97B4lVscYnP3+5R+/NDg5PWOxHdUz5
	3hBE+v2uj6IHo0coR2RpM8xUmWo5TgS6p1JScd2v2tUnEjiBI0VSzlpwH9nmZOy8Up1hZDNWMxy
	L6hJxd92rkIDnBahUvTGjLrtvPZJzOk1uxt/gWILrrnSIwOhJ6V6mFdjxo1ZmJ/JjRPM+iYRlxb
	bNesoYhjSK1U+WOiX64eJbX62oMOfHdWeLSj9LFBgC6CB3P9mew+IwpfQGEleUNVvQnIODGUsca
	xfann+KEyQTk3fQJVTi4bvS2P8+5izjCt7vPG0NHLD5zKeJl2pA5fxNsAUnZgU9LC97uNQhuG+3
	iK8Bw5zjP7HLpMUxDs2zgSGHB461+IdcV4bOzw2tYlKTR/ccN78tpgDpT8Ef2UuIpV7tyYCO3JX
	Yx/U+Pxo0GDS7O7pNs+meAbM1DQSwQZArXq2TxUkg77qFWrClCJfNVtlUmujbCLs4oA6v3xYAkM
	bm0zGUy+atE9PWUPxkuLQ==
X-Received: by 2002:a17:903:3c67:b0:2ca:e19c:97b with SMTP id d9443c01a7336-2df7e24f3a5mr16150895ad.5.1790242637239;
        Thu, 24 Sep 2026 02:37:17 -0700 (PDT)
Received: from [10.192.33.43] ([43.224.245.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5169absm24501695ad.8.2026.09.24.02.37.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 02:37:16 -0700 (PDT)
Message-ID: <9a542b7e-bbb0-4c14-8760-f3aceaab39e2@gmail.com>
Date: Thu, 24 Sep 2026 17:37:08 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix race between inline dir conversion and folio
 read
To: Sandeep Dhavale <dhavale@google.com>, Theodore Ts'o <tytso@mit.edu>
Cc: kernel-team@android.com, stable@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Baokun Li <libaokun@linux.alibaba.com>, Jan Kara <jack@suse.cz>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, liuderong@xiaomi.com
References: <20260918025416.604297-1-dhavale@google.com>
From: liuderong <liuderong2022@gmail.com>
In-Reply-To: <20260918025416.604297-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 9/18/2026 10:54 AM, Sandeep Dhavale wrote:
> Commit 90f097b1403f ("ext4: refactor the inline directory conversion and
> new directory codepaths") moved directory block initialization in
> ext4_convert_inline_data_nolock() into ext4_init_dirblock(), unlocking
> data_bh before setting BH_Uptodate.
>
> When block size is smaller than PAGE_SIZE, multiple buffer heads share a
> single block device folio. If a concurrent read on that folio runs via
> block_read_full_folio() while data_bh is unlocked and not uptodate, it
> locks data_bh and submits a disk read for the uninitialized block.
>
> Because ext4_init_dirblock() initializes bh->b_data without holding the
> buffer lock, the disk read races with and overwrites the initialized
> directory entries and checksum tail, corrupting the directory block:
>
>    EXT4-fs warning: ext4_dirblock_csum_verify:375: inode #...:
>      No space for directory leaf checksum. Please run e2fsck -D.
>    EXT4-fs error: __ext4_find_entry:1626: inode #...:
>      checksumming directory block 0
>
> To fix this, mark data_bh uptodate before unlocking it in
> ext4_convert_inline_data_nolock(), just like the regular file path
> does. Additionally, hold lock_buffer(bh) in ext4_init_dirblock() while
> populating the directory entries and checksum tail so any buffer
> modifications are properly serialized.
>
> Fixes: 90f097b1403f ("ext4: refactor the inline directory conversion and new directory codepaths")
> Cc: stable@vger.kernel.org
> Assisted-by: Antigravity:gemini-3.8-flash
> Signed-off-by: Sandeep Dhavale <dhavale@google.com>
> ---
> Note:
> This issue was reported by an Android partner encountering kernel panics
> in ext4_dirblock_csum_verify() ("No space for directory leaf checksum")
> on 16KB page size kernels mounting a 4KB block size ext4 filesystem.
>
> We verified with a standalone reproducer that the race reproduces
> deterministically on Iteration 0 (< 1s) on both ARM64 (16KB page size,
> 4KB ext4 blocks) and upstream ext4-tree/dev on x86_64 (4KB page size,
> 1KB ext4 blocks), and confirmed that this patch resolves the issue.
I verified this patch on an MTK platform running Android 17 (kernel 
6.18) with 16KB page size and 4KB ext4 block size: the script can 
reliably reproduce the issue. After applying the patch, the issue no 
longer reproduces.
Reproduction log snippet:
EXT4-fs warning (device loop54): ext4_dirblock_csum_verify:375: inode 
#15: comm repro_issue2: No space for directory leaf checksum. Please run 
e2fsck -D.
EXT4-fs error (device loop54): __ext4_find_entry:1626: inode #15: comm 
repro_issue2: checksumming directory block 0

Tested-by: liuderong <liuderong@xiaomi.com>
>   fs/ext4/inline.c | 1 +
>   fs/ext4/namei.c  | 2 ++
>   2 files changed, 3 insertions(+)
>
> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
> index ceee69a66482..0aa14cee3310 100644
> --- a/fs/ext4/inline.c
> +++ b/fs/ext4/inline.c
> @@ -1167,6 +1167,7 @@ static int ext4_convert_inline_data_nolock(handle_t *handle,
>   		error = ext4_handle_dirty_metadata(handle,
>   						   inode, data_bh);
>   	} else {
> +		set_buffer_uptodate(data_bh);
>   		unlock_buffer(data_bh);
>   		inode->i_size = inode->i_sb->s_blocksize;
>   		i_size_write(inode, inode->i_sb->s_blocksize);
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 3b9740c1c16d..6550102fb56b 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2933,6 +2933,7 @@ int ext4_init_dirblock(handle_t *handle, struct inode *inode,
>   	if (ext4_has_feature_metadata_csum(inode->i_sb))
>   		csum_size = sizeof(struct ext4_dir_entry_tail);
>   
> +	lock_buffer(bh);
>   	de->inode = cpu_to_le32(inode->i_ino);
>   	de->name_len = 1;
>   	de->rec_len = ext4_rec_len_to_disk(ext4_dir_rec_len(de->name_len, NULL),
> @@ -2965,6 +2966,7 @@ int ext4_init_dirblock(handle_t *handle, struct inode *inode,
>   	BUFFER_TRACE(dir_block, "call ext4_handle_dirty_metadata");
>   	set_buffer_uptodate(bh);
>   	set_buffer_verified(bh);
> +	unlock_buffer(bh);
>   	return ext4_handle_dirty_dirblock(handle, inode, bh);
>   }
>   
