Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C844A2E2C;
	Tue,  8 Sep 2026 09:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860277; cv=none; b=q2me7Dph9rGPCBC5w7wqc/2tb1YCOSZSwDGCU1WMRivHUZEZkVtp15hDCv7B7ki0Ze5F6M2RWUzKiXM5j/Izckaw8eIkP22Q/P+0389acWGK1Ro4PfPzPgD8DCyZUc5ZN3IbWNLp3ZXSURjsER1Cen2grEbEeAGkRjxMQCcXnxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860277; c=relaxed/simple;
	bh=Q2rW5BR/LLACzasBuLbDQr8uj8m4CWXW+k2UZZkiKu4=;
	h=Message-ID:Date:From:MIME-Version:To:CC:Subject:References:
	 In-Reply-To:Content-Type; b=LsaixDEKO9WKK5lPvEL04T0NmwrOUldMxmo3J9W5RRhWUOrq4NaltdmkpTfNhO9ILZfDNLgqB+NgxcvFMb91Z7O+11i+kS8RcJBPs+15TQGgYqm7VwcENdvrc+4KgZc5ZwUS2rtyVyhD1+K3b1SwXb7TBG1mnntWlp4rMN2Dgwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=cR8YVtrJ; arc=none smtp.client-ip=117.135.210.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="cR8YVtrJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:From:MIME-Version:To:Subject:
	Content-Type; bh=xVLCcQ8vJkUaz62i/t1qATMz6ZGDkw/cfKjiPehCZpw=;
	b=cR8YVtrJdkW5++hGCASw2cNe0ujKTOITH9Rp2YDYQwq79JSnqxpJqvPdcIL/PM
	JD/os7k4J8XZDoHeHTU45Xy4leCuXNi3dPptATztovyrby5f/43+4awO3oIUGXOP
	OMBvrmevlP0Ah2b4u/XJEaozPKirUNC4gtxvWLHz7n0Os=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id _____wDXT8dT159qur7kAg--.40856S2;
	Tue, 08 Sep 2026 17:37:23 +0800 (CST)
Message-ID: <6A9FD734.9080600@126.com>
Date: Tue, 08 Sep 2026 17:36:52 +0800
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
Subject: Re: [PATCH v3 1/3] ntfs: fix volume flag update races
References: <20260907070852.291323-1-zenghongling@kylinos.cn> <20260907070852.291323-2-zenghongling@kylinos.cn> <9b5a4c9a-447c-4510-8d95-40c552dcbb73@163.com>
In-Reply-To: <9b5a4c9a-447c-4510-8d95-40c552dcbb73@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXT8dT159qur7kAg--.40856S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3WF4UWrWUCF18ZFWkGw1xKrg_yoW3ZF4Upr
	sayFy7Ka1qyr1xuws7t3yIqF4S934kGr48Cry7Jw1av3sIkr18XF18K3WrZF1vyr9rAr1I
	qFWUtrW5u3WUZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jaZXOUUUUU=
X-CM-SenderInfo: x2kr0wpolqwiqxrzqiyswou0bp/xtbBrhOMXWqf11MyXwAA3w


在 2026年09月08日 13:29, liubaolin 写道:
>
>
> 在 2026/9/7 15:08, Hongling Zeng 写道:
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
>>   fs/ntfs/super.c | 63 +++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 45 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
>> index 60d43339c590..ce159ae8169a 100644
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
> Hi Hongling,
>    Doesn't the caller-side check still leave a race here? Several 
> paths in file.c and namei.c do:
>
>       if (!(vol->vol_flags & VOLUME_IS_DIRTY))
>           ntfs_set_volume_flags(vol, VOLUME_IS_DIRTY);
>
>   If the check sees the dirty bit set and sync_fs clears it before the 
> metadata update, the caller skips setting it and the volume may be 
> left clean. Since ntfs_write_volume_flags() already checks for an 
> unchanged value under mrec_lock, should these callers invoke 
> ntfs_set_volume_flags() unconditionally?
>
> Thanks,
> Baolin.
>
   Yes ，you are right - the check reads vol->vol_flags without the 
lock, so it can race
   with the sync_fs() clear exactly as you describe. I'll drop the 
caller-side checks in file.c and namei.c and call
   ntfs_set_volume_flags() unconditionally; when the bit is already 
set,  the mrec_lock-protected unchanged check keeps that a no-op. I'll post
   an incremental for 1/3 once there is agreement on this.

   Thanks,
   Hongling

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
>> @@ -1862,8 +1890,7 @@ static int ntfs_sync_fs(struct super_block *sb, 
>> int wait)
>>           return 0;
>>         /* If there are some dirty buffers in the bdev inode */
>> -    if (!NVolErrors(vol) &&
>> -        ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY)) {
>> +    if (ntfs_clear_volume_dirty_if_no_errors(vol)) {
>>           ntfs_warning(sb, "Failed to clear dirty bit in volume 
>> information flags.  Run chkdsk.");
>>           err = -EIO;
>>       }

