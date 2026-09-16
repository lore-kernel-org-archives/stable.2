Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CEF4DD3C3;
	Wed, 16 Sep 2026 23:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602566; cv=none; b=sXfHeO6ZPb5J/4qUj8S9qiG5w5aoijUPVVsZH1V5saBz9YbQ8iYAr30XY0p+s0grqoe399FlzJFY3emseS6Vuc1aKqD+R5ZhjgCeighkWZIJ7pNo7nYCWD3X/3tewUhXtrn1YImNim0nAqJ1KXTC+3YxD/nqnvn2hS5mpCpi4Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602566; c=relaxed/simple;
	bh=3VICl/PljwfMNqlFD4r491TYryV5qL4xLUt/1jbDk4U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IzO8CYESTlrwdzEEUnvkf+R77EYy5YgsIm6xFiqGQSvxKaMGM+g6nneKOvFzvOM/2ir4A2OQYaWirszMAJ0mxbyleAXkPtPvMAMzQDkch8XCZIrXMArGApvVZZH0xCx28s8d5rScPjCB2EIHP2yktvsk4b+g2eYdufjEDc3ezbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Z7WHNe1r; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Z7WHNe1r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=AkC4/63UwswKlo+NGzzlx9i4qj+7xSP0MGqUjBcBcKI=;
	b=Z7WHNe1rSzhkp+MnDOMQkuJs1Hd6r6FUPltsUOVYnwxgdUzafeo1Ys+E6Px8fa
	YTljf77xn1JgpTuWP49DejPXgYnRlOvjjmB/HrWf64axGoE+cr2Uod1qrs7DwXHC
	lfUf6xEKPJ1WOVJTzzoCmrqFiWTWmhuJZSRpbtlWCTEMw=
Received: from [IPV6:2409:8900:21a7:a33a:b45d:31d1:c098:7d46] (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wD3F_rmKqtqlwSDBA--.51140S2;
	Thu, 17 Sep 2026 07:48:56 +0800 (CST)
Message-ID: <a2280318-0604-4318-a3b6-01cd4a72d781@163.com>
Date: Thu, 17 Sep 2026 07:48:54 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] ntfs: mount hibernated volumes read-only regardless of
 errors=
To: Namjae Jeon <linkinjeon@kernel.org>,
 Hongling Zeng <zenghongling@kylinos.cn>
Cc: hyc.lee@gmail.com, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org,
 zhongling0719@126.com, stable@vger.kernel.org
References: <20260915023820.621797-1-zenghongling@kylinos.cn>
 <CAKYAXd-Pz0WCKNyOdoxKyfgE_rx7GVDRmtidfjsx-x0C-AA1RA@mail.gmail.com>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <CAKYAXd-Pz0WCKNyOdoxKyfgE_rx7GVDRmtidfjsx-x0C-AA1RA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3F_rmKqtqlwSDBA--.51140S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXw1DAF1Dur1fAr4DXF45trb_yoW5Kw47pF
	9rKw4Dtr4kKr1akrn2vay0q3WFkr93Aa1UGrn5CF47A3s5KF13trWfKw1a9F4SkrW5ta1x
	XF409343Wa1DZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UaYLPUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6ghKFWqrKujH-wAA3G



在 2026/9/16 19:57, Namjae Jeon 写道:
> On Tue, Sep 15, 2026 at 11:38 AM Hongling Zeng <zenghongling@kylinos.cn> wrote:
>>
>> The hibernation check in load_system_files() only converts the
>> superblock to read-only under errors=remount-ro.  With the default
>> errors=continue (and with errors=panic), a hibernated volume is
>> mounted read-write and the mount-time $LogFile emptying writes to it,
>> although a hibernated volume must not be written to at all.
>>
>> Drop the on_errors term so that a hibernated volume, or a volume whose
>> hibernation state cannot be determined, always mounts read-only.
>> NVolErrors() is still recorded, so ntfs_reconfigure() keeps refusing
>> remounts to read-write, and the $LogFile emptying is skipped by its
>> !sb_rdonly() check.
>>
>> Also change the ntfs_error() calls inside
>> check_windows_hibernation_status() to ntfs_warning(): they run before
>> SB_RDONLY is set, so errors=panic could panic there, while the warnings
>> preserve diagnostics for already read-only mounts.  The read-only
>> fallback message is logged unconditionally: with SB_RDONLY set, or on
>> an already read-only mount, ntfs_error() cannot panic, and the reason
>> for NVolErrors() stays visible.
> errors=panic can still panic before the read-only fallback.
> ntfs_lookup_inode_by_name() and ntfs_iget() in
> check_windows_hibernation_status() can call ntfs_error() internally.

Hi Namjae and Hongling,

   Namjae,thank you for catching this, and sorry I missed those internal 
ntfs_error() calls in my earlier review.

   Changing the ntfs_error() calls in the shared lookup and 
inode-loading helpers to ntfs_warning() would affect other callers as 
well, so I would prefer to avoid that.

   Would it make sense to temporarily set SB_RDONLY before calling 
check_windows_hibernation_status()?
Since ntfs_handle_error() returns immediately for a read-only 
superblock, this would prevent the nested calls from triggering 
errors=panic, while preserving the existing error diagnostics. With this 
approach, the direct ntfs_error() calls in the hibernation check could 
also remain unchanged.load_system_files() is only called during the 
initial mount, before the filesystem is exposed to userspace.

The basic idea would be:

   bool temporary_ro = false;

   if (!sb_rdonly(sb)) {
   	sb->s_flags |= SB_RDONLY;
   	temporary_ro = true;
   }

   err = check_windows_hibernation_status(vol);

   if (temporary_ro && !err && !NVolErrors(vol))
   	sb->s_flags &= ~SB_RDONLY;

   If Windows is hibernated or the check fails, we would leave the 
volume read-only, call NVolSetErrors(vol), and log the fallback message 
unconditionally. A volume that was already read-only before the check 
would remain read-only.

   The reason for adding !NVolErrors(vol) is that 
ntfs_read_locked_inode() can continue after an error looking up 
AT_EA_INFORMATION. The underlying code may have already reported a 
metadata error and set NVolErrors(), while the hibernation check can 
still return zero. Checking !err alone could therefore restore 
read-write access despite the detected error. This additional condition 
is conservative: it would also keep volumes with previously recorded 
errors read-only, and that case would need a corresponding diagnostic.

   Namjae and Hongling,I would appreciate your thoughts on this 
approach, particularly on the condition for restoring read-write access.
   If you both agree that this approach is reasonable, Hongling, could 
you please update your patch based on this approach and send a new version?

Thanks,
Baolin.

