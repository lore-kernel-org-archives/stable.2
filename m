Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE190846A;
	Mon, 15 Jun 2026 07:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781509661; cv=none; b=D6j2DWwhwv+PKoSZh6Ay/Z63Jr/DFz4ACforzaJCFqziH25svGAH55m15oX6szXdmaL3CuRN6/P9r9QY6gbzbDQuhQ/U+5zU7DXaqyedaoOwE5DCjM6xF44eLjdTaj36j4yIvgb5FleBUkjT2NBin+l50NO2OOq+AvSQIhOp2qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781509661; c=relaxed/simple;
	bh=S1YrOgmYp5hDadcAc358C9cRUcdQFt9KBguIsc9syyQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jrWA8Rnn1mEgIt7IdN060wszzFtubPd0M44vuvMxLHvkh4wU863wAeT8qV+VcXzio2BLMmtpv+ZYSO0iR+G7X3R9jiQdHXtbduOVuIxL0eZD3BepCcpEpEz9VFi/Hrla9Tjndq4S17+xvX2QQImqHkchU72HslbK8blQxO5wtZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwdvPNsP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwdvPNsP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EECFE1F000E9;
	Mon, 15 Jun 2026 07:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781509659;
	bh=A4PEFDiKVjBjc437nkKrTm0Y46RlKHnQkTSU9vUCLOU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=NwdvPNsPfviCl6xUVdTG0Enldakh9vlHNj1EYRFYZujA9X1yI78ZKlxVv78tM7sxd
	 LDMyUenyWLmSW19VffyN+LErdlxt760c0GOvsJRvd86z5xgthpZcwU97zISdBJZAww
	 x+p3rTgU80jjsxMsxX4+7F69+tWlwGamlZ3oovxio239dcvpBENy/FgC2sCrYZ8bry
	 Ix7s/d0U6jdTVBhYFxXbSjtiJpEeFPcIJjS/Ymt13vypn3uLZS24J8emfHmYVKpq1G
	 lUHGmZgX5EZk1P/eBTd1AM5KRiR6QIKAvl8GCUl4xPkkyaRm8vBfrx5AIQly0Z3Kkv
	 nRnNBioYLIWyA==
Message-ID: <899acd73-4247-4a8a-9b3a-58f03d550bca@kernel.org>
Date: Mon, 15 Jun 2026 15:47:36 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, daehojeong@google.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] f2fs: read COW data with the original inode during atomic
 write
To: Mikhail Lobanov <m.lobanov@rosa.ru>, jaegeuk@kernel.org
References: <20260605103834.14894-1-m.lobanov@rosa.ru>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260605103834.14894-1-m.lobanov@rosa.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/5/26 18:38, Mikhail Lobanov wrote:
> When updating an atomic-write file, f2fs_write_begin() may read the
> previously written data back from the COW inode:
> prepare_atomic_write_begin() locates the block in the COW inode and sets
> use_cow, and the read bio is then built with the COW inode:
> 
> 	f2fs_submit_page_read(use_cow ? F2FS_I(inode)->cow_inode : inode,
> 			      ...);
> 
> and f2fs_grab_read_bio() decides whether to schedule fs-layer decryption
> (STEP_DECRYPT) for the bio based on that inode via
> fscrypt_inode_uses_fs_layer_crypto().
> 
> However, the folio being filled belongs to the original inode
> (folio->mapping->host == inode), and the data stored in the COW block was
> encrypted (or left as plaintext) using the original inode's context, not
> the COW inode's -- see f2fs_encrypt_one_page(), which keys off
> fio->page->mapping->host.  fscrypt_decrypt_pagecache_blocks() likewise
> operates on folio->mapping->host.
> 
> The COW inode is created as a tmpfile in the parent directory and inherits
> its encryption policy from there.  With test_dummy_encryption the newly
> created COW inode gets the dummy policy and becomes encrypted, while a
> pre-existing regular file -- created before the policy applied, e.g.
> already present in the on-disk image -- stays unencrypted.  The read
> path then sets STEP_DECRYPT based on the encrypted COW inode and calls
> fscrypt_decrypt_pagecache_blocks() on a folio whose host (the unencrypted
> original inode) has a NULL ->i_crypt_info, dereferencing it:
> 
>   Oops: general protection fault, probably for non-canonical address ...
>   KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
>   RIP: 0010:fscrypt_decrypt_pagecache_blocks+0xa0/0x310
>   Workqueue: f2fs_post_read_wq f2fs_post_read_work
>   Call Trace:
>    fscrypt_decrypt_bio+0x1eb/0x340
>    f2fs_post_read_work+0xba/0x140
>    process_one_work+0x91c/0x1a40
>    worker_thread+0x677/0xe90
>    kthread+0x2bc/0x3a0
> 
> The COW inode is only needed to locate the on-disk block, and that block
> address is already resolved into @blkaddr; the data's crypto state belongs
> to the original inode.  Read with the original inode so the post-read
> decryption decision matches the folio's owner.  This also makes the inline
> crypto path use the correct (original inode's) key.
> 
> Fixes: 591fc34e1f98 ("f2fs: use cow inode data when updating atomic write")
> Cc: stable@vger.kernel.org
> Signed-off-by: Mikhail Lobanov <m.lobanov@rosa.ru>

It leaves use_cow as no useful variable in f2fs_write_begin(), can we drop it in
f2fs_write_begin() and prepare_atomic_write_begin()?

Anyway, it's about cleanup, the fix itself looks good to me.

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
