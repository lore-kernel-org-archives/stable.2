Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2700F317163;
	Thu,  3 Sep 2026 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788478690; cv=none; b=j9EJazXg2jyj0kFOoCnQlJosy29NdQFvS09ci/vZJLS2dlyuPktVy58GsvxtcGTZWjyo8QgUQmByHOBDWTU67dKx31wKnhQ9s1Gqa4x/+PYTvYuQcAr+Z6b0AoTIvEh8O2V7XXH0Z4GVqz7viYt3KMUsivqNITDuxGelTdUa03c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788478690; c=relaxed/simple;
	bh=R22rTRS8i9oV4XQC8K1yvIUDAkDqyALkPaWr3zupxq4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M90M5penJDoPAbD3UJAjhIfRByk7tHl3JOVyRt/yEaJfXPFEgQReZCFRS5WDLoS6OTF/Cv9ngQjdl0JgXrGz6nysV2aBR9HWVfBtEQuz05+oupMZ5rCoOgz3zXTQhOnT14TF6kApCwdSHVdVq2j54w9QV5dXdLYJGmDBBgQSPUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pWFcCily; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pWFcCily"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=uRpUrzAIFjYym95kQ3qVHTU3gGRgeQr9wo+Qelo0Hjc=;
	b=pWFcCilySSzrWE5DcN5ZIZXHpOigjdlHbNYqTIiaIB72O3hB7rEf8i/iYnBFLX
	9Aklbalm3VEUoGdI6bLw/iXde1Ziqr5kD7T8wi8u/t4a7ufU8fVHxO2JdDF5dYUl
	q45qENWwO6rUNgj8jTX8fN3bDQDZKFHvM7+I7in+G/xxE=
Received: from [IPV6:2409:8900:1a96:d5f:519a:bd19:ff78:1325] (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wBX1h7ABJpqwN2yAQ--.239S2;
	Fri, 04 Sep 2026 07:37:39 +0800 (CST)
Message-ID: <c43b2ea8-e80f-4f63-8b07-4c3f5b845edb@163.com>
Date: Fri, 4 Sep 2026 07:37:35 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ntfs: fix volume flag update races
To: Hongling Zeng <zhongling0719@126.com>,
 Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260903012104.185926-1-zenghongling@kylinos.cn>
 <d576d6d6-e378-4124-817a-f019c09c391e@163.com> <6A99158E.2040006@126.com>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <6A99158E.2040006@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wBX1h7ABJpqwN2yAQ--.239S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXrWfZr1DtFyUCrWfCr45KFg_yoW5Cr47pF
	Wa9rnrWw4kKF4Ikr1vya1fWryFgFWxAF43KryrGw4xXwn8AF17XFW3Ka1FqrykCryfKwnI
	qr40y398u3W7AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTKZAUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6QNyPWqaBMP1hAAA3j



在 2026/9/3 14:37, Hongling Zeng 写道:
> Thanks for the careful reading
> 
> These two sites cannot actually race ntfs_sync_fs(): ntfs_reconfigure() 
> (via do_remount()) and ntfs_put_super() (via generic_shutdown_super()) 
> both run with sb->s_umount
> held for write, while the sync(2)/syncfs(2) paths only take it for read 
> through iterate_supers(). So the check and the clear inside 
> ntfs_clear_volume_flags() are
> effectively a single non-interleavable pair with respect to sync — the 
> window is not merely narrow but structurally closed.
> 
> We deliberately keep ntfs_clear_volume_dirty_if_no_errors() for the 
> paths that can genuinely race sync (currently only ntfs_sync_fs() 
> itself), so converting these two would
> blur that line rather than improve consistency.

Hi Hongling,

    Thank you for the explanation.
    However, I believe we may be discussing different races.
    Your explanation addresses why ntfs_reconfigure()/ntfs_put_super() 
cannot run concurrently with ntfs_sync_fs().
    My concern is whether these paths can race with an NTFS writer/error 
path while checking NVolErrors(vol) and clearing VOLUME_IS_DIRTY.

   For ntfs_put_super(), I agree that no change is needed.
   It runs only during the final filesystem shutdown, when ordinary 
userspace writers and related I/O can no longer run concurrently with it.

   For a normal read-only remount, reconfigure_super() calls 
sb_prepare_remount_readonly(). This blocks new mount writers and checks 
for existing writers; if writers are present, the remount does not 
proceed. Therefore, the normal remount-ro path does not have the 
concurrency issue I was concerned about.

   However, an emergency/forced remount uses SB_FORCE and skips 
sb_prepare_remount_readonly(), calling only sb_start_ro_state_change(). 
This does not wait for writers that have already entered the filesystem. 
Such writers use sb->s_writers and do not need to acquire s_umount.
The following sequence is therefore possible:
NTFS writer                         forced remount
   -----------                         -------------
   file_start_write()
   Enter the NTFS write path
   Set or prepare to set VOLUME_IS_DIRTY
   Pause
                                       Acquire s_umount for writing
                                       SB_FORCE
                                       sb_start_ro_state_change()
                                       ntfs_reconfigure()
                                         sync_filesystem()
                                         NVolErrors() == false
                                         Clear VOLUME_IS_DIRTY
                                       Set SB_RDONLY
   Resume the writer
   Continue modifying metadata
   An error occurs
   NVolSetErrors(vol)

The final state may be:
   NVolErrors(vol) == true
   VOLUME_IS_DIRTY == false

   Therefore, the s_umount locking relationship only rules out 
concurrency with ntfs_sync_fs(); it does not rule out concurrency 
between a forced/emergency remount and an NTFS writer that is already in 
progress.

   Please consider whether this case also needs to be handled. If you 
agree with my analysis, I suggest adding a follow-up patch to address 
this race.
   This is my current understanding of the issue. I welcome further 
discussion, and please feel free to correct me if any part of my 
analysis is inaccurate.

Thanks,
Baolin.

