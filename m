Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F2F29A309
	for <stable@vger.kernel.org>; Sun, 11 Oct 2026 07:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791702752; cv=none; b=UiyemjBKI/Q1jPrgfTMKoB0TSKL7uxpe+i+TOTEhV91Tb/sChkNJJftTTUVtg2zaeSVHzLBfAwE21Re/U/CFw9OxHOCs8St4T8f8UisZOXs02W9camxSoXx59e/J4Vf+qVvf2ejT51RWfYzeXnOCp01AcOMBlPb3kWRVKPBdWcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791702752; c=relaxed/simple;
	bh=gJshVderULOvxmhRbszTCmVTTARq3BJyWuKfPN56n6g=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=maZep3/q3MNzxJLRST2dBrj63sky//6fUHvlF2Ag2Fc7QX8diNsM93Yu+oSpmtp64W4nsz4/bVDb5DZMVTLfbF50jmG2BFWny330HZBfgQvjvNoK5krjLsi8fw9sMImCryWI3M+uW076ViWkPYXCxAeEhMLlrx/qAWzgAc4vRGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gB8VNHt0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gB8VNHt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38C421F0089B;
	Sun, 11 Oct 2026 07:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791702750;
	bh=9Q3x3Mf48yf/z+Pl8/DxTpFVbkK9gz1N9GTRxAQWZYA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=gB8VNHt0hqOqDf+KphZB1k6+N95+y36bXPyGxJJmaGOZfb5jF2ah6NPEoV5Qfccnu
	 8xi3+Lp3vsgF5icpHxTDnSMJNtYYBZEddPHkffBvRxDxmleZkWVepzsGWWzfJT4Fcr
	 dagmOlpcqKwFlUDPK1c3QG+83rjSZTNquJlTWr03E+XlzyS8Iyerv5038+tmgpHxaP
	 dJY6hzses81q53lkyjZMnBBqLs9/M6fi4fp7GcAatl4uve0L80tgvZrm86vJad6Hw0
	 1TaxcwsMfDgv3Hw15hl8Z/RATO7nPQkzjB1OW2+/T45W1cgmNjJAyO3OT90Vm/m11E
	 CQ41Ot2t3OgIg==
Message-ID: <97c38f99-76ca-4e2d-8f2a-a47047d78ab2@kernel.org>
Date: Sun, 11 Oct 2026 15:12:27 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Barry Song <baohua@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: remove mappedtodisk flag usage in mmap write
 path
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261011040232.2940423-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20261011040232.2940423-1-zhaonanzhe@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/26 12:02, Nanzhe Zhao wrote:
> PG_mappedtodisk was inherited from the nobh/buffer-head era.  However,
> f2fs has no buffer heads and the flag is no longer meaningful.  The only
> user of the flag is the "no holes" shortcut in f2fs_vm_page_mkwrite(),
> which makes mmap write faults skip marking the folio dirty.  Chao Yu
> pointed out that this is not only a cleanup: it causes the following
> race condition with filesystem freezing:
> 
>   CPU0 (write fault)     CPU1 (freeze_super)
>   ----                   ----
>   f2fs_vm_page_mkwrite()
>   sb_start_pagefault()
>   /* shortcut: no dirty */
>   sb_end_pagefault()
> 
>                          sb_wait_write(SB_FREEZE_PAGEFAULT)
>                          /* no waiter, passes */
>                          sync_filesystem()
>                          /* folio not dirty, skipped */
> 
>   finish_fault()
>   /* PTE writable */
>   fault_dirty_shared_page()
>   folio_mark_dirty()
>   /* dirty folio on a frozen fs */
> 
> It will also skip APP_MAPPED_IO iostat/REQ_TIME updates and post-EOF
> folio zeroing.
> 
> Remove this shortcut in f2fs_vm_page_mkwrite() and stop setting it in
> f2fs_read_single_page().
> 
> Reported-by: Chao Yu <chao@kernel.org>
> Link: https://lore.kernel.org/linux-f2fs-devel/496b913c-eb81-4fa8-be72-c6a06a10aba2@kernel.org/
> Fixes: fbfa2cc58d53 ("f2fs: add file operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
