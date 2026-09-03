Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC63F58E9;
	Thu,  3 Sep 2026 06:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788417505; cv=none; b=tvVbooxBdef/0ziOvk2MvBq6/qJZ6ck5ohO2EsUjw54TvQ9s+P4ZqjHZs/oayXY52axq5PPSFRJ+0ju3A9xHscEAsbkg777jPU3psprKDgWX7HGLmdUGnWqG+lcq3gjC+cxTZqCvTj3okKHGbwQtsPjK0WSMWy9QvM96JNx9T3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788417505; c=relaxed/simple;
	bh=WHzN8whD/sPVFMbaTppMqhjZBhAguwvoXnPwSSu9ehY=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=hx9dhEU76ypWA2UQVJt2QFXO+uME6Y8SvFnsRlstvel6c96K1qfNU6L1ilM+P1C4nOy3CPmsaCxEoqluV0I+n6ga4WpCeL9BocyE5mLjUy0iA5skJqqNexOjBzyolHyYAAJ3e0YsQRqThpCF1CykD/52QCdX4B6iWD3Do5lQid0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=dh/fCS7G; arc=none smtp.client-ip=220.197.31.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="dh/fCS7G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=QhhhQWqk/C4nR9X6FXtttU/PKvCAIlbq/hLOZ5YeK4Y=;
	b=dh/fCS7G0OJqoZRU1MMXilaZclxQLnSGH9pxl1+hGwO2xyhIhXmRNiDba0i10v
	/Ov6SbbD5ffZT01ipwBqjVz0pfNGwxyp6af9gINSOkapB+ih2a/dz2gu5PMR3OEr
	BjWkQLnVic2s2jKbOY55AwXOknOlYrSV37dEE7YhVLv88=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wDnt5mpFZlq41LHAA--.43306S2;
	Thu, 03 Sep 2026 14:37:30 +0800 (CST)
Message-ID: <6A99158E.2040006@126.com>
Date: Thu, 03 Sep 2026 14:37:02 +0800
From: Hongling Zeng <zhongling0719@126.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: liubaolin <liubaolin12138@163.com>, 
 Hongling Zeng <zenghongling@kylinos.cn>,
 linkinjeon@kernel.org, hyc.lee@gmail.com
CC: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
Subject: Re: [PATCH 1/2] ntfs: fix volume flag update races
References: <20260903012104.185926-1-zenghongling@kylinos.cn> <d576d6d6-e378-4124-817a-f019c09c391e@163.com>
In-Reply-To: <d576d6d6-e378-4124-817a-f019c09c391e@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnt5mpFZlq41LHAA--.43306S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF4UWrWUCF18ZFWkGw1xKrg_yoWfAr4fpr
	s2yF9rKa1qyr1xuws7t3yIga1S934kGr48Cry7Jw1av3s0kr18XFy8K3WrZa4vyr9rAw1I
	qFWUtrW3uw1UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j-sqJUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrgpwQWqZFarT4QAA3r


在 2026年09月03日 11:01, liubaolin 写道:
>
>
> 在 2026/9/3 09:21, Hongling Zeng 写道:
>> ntfs_set_volume_flags() and ntfs_clear_volume_flags() both read
>> vol->vol_flags outside any lock to compute the new value before handing
>> it to ntfs_write_volume_flags(), which only takes ni->mrec_lock around
>> the actual write. The read-modify-write is therefore not atomic, and two
>> concurrent callers can lose an update: ntfs_sync_fs() may derive a
>> "clean" value from vol->vol_flags while a writer concurrently records an
>> error and sets VOLUME_IS_DIRTY; the locked write then silently
>> overwrites the freshly-set dirty bit. The on-disk volume looks clean
>> despite the recorded errors, so chkdsk will not run on the next mount
>> and corrupted metadata can persist.
>>
>> Fix by moving the read-modify-write inside the mrec_lock: pass the bits
>> to set and to clear separately, and combine them with the current flag
>> state under the lock inside ntfs_write_volume_flags(). The set/clear
>> helpers pass only the bits to modify, not the complete flag state. The
>> bit manipulation is done on CPU-endian values, and the result is
>> converted back to little-endian before storing it. The wrappers keep
>> their signatures so callers are unchanged.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>
>> ---
>> - Also fix the ntfs_sync_fs() race by checking NVolErrors() and clearing
>>    VOLUME_IS_DIRTY under ni->mrec_lock.
>> - Keep ntfs_set_volume_flags() and ntfs_clear_volume_flags() semantics
>>    unchanged.
>> - Do not tie setting VOLUME_IS_DIRTY to NVolSetErrors() in the generic
>>    set helper.
>> ---
>>   fs/ntfs/super.c | 62 +++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 45 insertions(+), 17 deletions(-)
>>
>> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
>> index a1813093222b..a7977b95b967 100644
>> --- a/fs/ntfs/super.c
>> +++ b/fs/ntfs/super.c
>> @@ -353,31 +353,45 @@ void ntfs_handle_error(struct super_block *sb)
>>   }
>>     /*
>> - * ntfs_write_volume_flags - write new flags to the volume 
>> information flags
>> + * ntfs_write_volume_flags - apply flag changes to the volume 
>> information flags
>>    * @vol:    ntfs volume on which to modify the flags
>> - * @flags:    new flags value for the volume information flags
>> + * @set_bits:    bits to set in the volume information flags
>> + * @clear_bits:    bits to clear in the volume information flags
>>    *
>>    * Internal function.  You probably want to use 
>> ntfs_{set,clear}_volume_flags()
>>    * instead (see below).
>>    *
>> - * Replace the volume information flags on the volume @vol with the 
>> value
>> - * supplied in @flags.  Note, this overwrites the volume information 
>> flags, so
>> - * make sure to combine the flags you want to modify with the old 
>> flags and use
>> - * the result when calling ntfs_write_volume_flags().
>> + * Combine @set_bits and @clear_bits with the current in-memory flag 
>> state and
>> + * write the result back.  The set/clear helpers pass only the bits 
>> to modify,
>> + * not the complete flag state.  The read-modify-write happens under
>> + * ni->mrec_lock so that concurrent set/clear operations cannot lose 
>> updates.
>> + * All bit manipulation is done on CPU-endian values, and the result is
>> + * converted back to little-endian before storing it.
>>    *
>>    * Return 0 on success and -errno on error.
>>    */
>> -static int ntfs_write_volume_flags(struct ntfs_volume *vol, const 
>> __le16 flags)
>> +static int ntfs_write_volume_flags(struct ntfs_volume *vol,
>> +        const __le16 set_bits, const __le16 clear_bits,
>> +        const bool skip_if_errors)
>>   {
>>       struct ntfs_inode *ni = NTFS_I(vol->vol_ino);
>>       struct volume_information *vi;
>>       struct ntfs_attr_search_ctx *ctx;
>> +    u16 flags;
>>       int err;
>>   -    ntfs_debug("Entering, old flags = 0x%x, new flags = 0x%x.",
>> -            le16_to_cpu(vol->vol_flags), le16_to_cpu(flags));
>>       mutex_lock(&ni->mrec_lock);
>> -    if (vol->vol_flags == flags)
>> +
>> +    if (skip_if_errors && NVolErrors(vol))
>> +        goto done;
>> +
>> +    flags = le16_to_cpu(vol->vol_flags);
>> +    flags |= le16_to_cpu(set_bits) & le16_to_cpu(VOLUME_FLAGS_MASK);
>> +    flags &= ~(le16_to_cpu(clear_bits) & 
>> le16_to_cpu(VOLUME_FLAGS_MASK));
>> +    ntfs_debug("Entering, old flags = 0x%x, new flags = 0x%x.",
>> +            le16_to_cpu(vol->vol_flags), flags);
>> +
>> +    if (le16_to_cpu(vol->vol_flags) == flags)
>>           goto done;
>>         ctx = ntfs_attr_get_search_ctx(ni, NULL);
>> @@ -393,7 +407,7 @@ static int ntfs_write_volume_flags(struct 
>> ntfs_volume *vol, const __le16 flags)
>>         vi = (struct volume_information *)((u8 *)ctx->attr +
>> le16_to_cpu(ctx->attr->data.resident.value_offset));
>> -    vol->vol_flags = vi->flags = flags;
>> +    vol->vol_flags = vi->flags = cpu_to_le16(flags);
>>       mark_mft_record_dirty(ctx->ntfs_ino);
>>       ntfs_attr_put_search_ctx(ctx);
>>   done:
>> @@ -414,13 +428,14 @@ static int ntfs_write_volume_flags(struct 
>> ntfs_volume *vol, const __le16 flags)
>>    * @flags:    flags to set on the volume
>>    *
>>    * Set the bits in @flags in the volume information flags on the 
>> volume @vol.
>> + * The bits are combined with the current flag state under the lock in
>> + * ntfs_write_volume_flags(), so concurrent updates are not lost.
>>    *
>>    * Return 0 on success and -errno on error.
>>    */
>>   int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
>>   {
>> -    flags &= VOLUME_FLAGS_MASK;
>> -    return ntfs_write_volume_flags(vol, vol->vol_flags | flags);
>> +    return ntfs_write_volume_flags(vol, flags, 0, false);
>>   }
>>     /*
>> @@ -429,14 +444,27 @@ int ntfs_set_volume_flags(struct ntfs_volume 
>> *vol, __le16 flags)
>>    * @flags:    flags to clear on the volume
>>    *
>>    * Clear the bits in @flags in the volume information flags on the 
>> volume @vol.
>> + * The bits are combined with the current flag state under the lock in
>> + * ntfs_write_volume_flags(), so concurrent updates are not lost.
>>    *
>>    * Return 0 on success and -errno on error.
>>    */
>>   int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags)
>>   {
>> -    flags &= VOLUME_FLAGS_MASK;
>> -    flags = vol->vol_flags & cpu_to_le16(~le16_to_cpu(flags));
>> -    return ntfs_write_volume_flags(vol, flags);
>> +    return ntfs_write_volume_flags(vol, 0, flags, false);
>> +}
>> +
>> +/*
>> + * ntfs_clear_volume_dirty_if_no_errors - clear dirty bit if no 
>> errors exist
>> + * @vol:    ntfs volume whose dirty bit should be cleared
>> + *
>> + * Check NVolErrors() and clear VOLUME_IS_DIRTY under the same 
>> mrec_lock so
>> + * ntfs_sync_fs() cannot clear the dirty bit after a concurrent 
>> error has been
>> + * recorded.
>> + */
>> +static int ntfs_clear_volume_dirty_if_no_errors(struct ntfs_volume 
>> *vol)
>> +{
>> +    return ntfs_write_volume_flags(vol, 0, VOLUME_IS_DIRTY, true);
>>   }
>>     int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)
>> @@ -1862,7 +1890,7 @@ static int ntfs_sync_fs(struct super_block *sb, 
>> int wait)
>>           return 0;
>>         /* If there are some dirty buffers in the bdev inode */
>> -    if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY)) {
>> +    if (ntfs_clear_volume_dirty_if_no_errors(vol)) {
>>           ntfs_warning(sb, "Failed to clear dirty bit in volume 
>> information flags.  Run chkdsk.");
>>           err = -EIO;
>>       }
>
> Hi Hongling,
>   Patch 1 fixes the race in ntfs_sync_fs(), but there are two other 
> sites with the same check-outside-lock-then-clear-inside-lock pattern:
>
>   1. super.c:315 (ntfs_reconfigure, remount read-only path)
>   2. super.c:1755 (ntfs_put_super, umount path)
>
>   Both use:
>       if (!NVolErrors(vol)) {   // check outside lock
>           if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY))  // clear 
> inside lock
>
>   The same race can occur: if an error thread sets NVolErrors() and the
>   dirty bit after the check but before the lock acquisition, the clear
>   operation will overwrite the freshly-set dirty bit.
>
>   Although the race window is much narrower for remount/umount, should
>   these two sites also be converted to use
>   ntfs_clear_volume_dirty_if_no_errors() for consistency?
>
> Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>
>
>
> Thanks,
> Baolin.
Thanks for the careful reading

These two sites cannot actually race ntfs_sync_fs(): ntfs_reconfigure() 
(via do_remount()) and ntfs_put_super() (via generic_shutdown_super()) 
both run with sb->s_umount
held for write, while the sync(2)/syncfs(2) paths only take it for read 
through iterate_supers(). So the check and the clear inside 
ntfs_clear_volume_flags() are
effectively a single non-interleavable pair with respect to sync — the 
window is not merely narrow but structurally closed.

We deliberately keep ntfs_clear_volume_dirty_if_no_errors() for the 
paths that can genuinely race sync (currently only ntfs_sync_fs() 
itself), so converting these two would
blur that line rather than improve consistency.

