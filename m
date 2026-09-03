Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DACC2727F3;
	Thu,  3 Sep 2026 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788404396; cv=none; b=HcOSUPe2wvMB8/dW2eqb/DBn+76l4lFCWbnr6+ELA+dPbEDyYOYH0m6dNb9dd/6GLIc3lOKWVaIEBKZa/3BUMkw54Cn9j4A4S/+yIlRL4XXj1QELvFulo9YQpzuMLtjFKiWn3prULHWriLyxicysHgvrTWLlgiE5SfndcBo8dhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788404396; c=relaxed/simple;
	bh=zAYHzjAd9i26eGMaZjiwXe4yGSd27pS7YkeC2dycDc4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hZoQC42JlDV95U2NwKv/0tus+eZKzHc2NLGU9XnU1sp/zkfrdTQE3pLMalC2xR1oulbUMV6FZAwtWtF6w9fKCkD55pWNs+ve0r7byIwY/hFZupTpC3vpNDvmWJFZYxeUHQyrv3GiGdYvam18k9BjKLjLx+p02CF8u1L8+mv2/Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=HVR1wZs3; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="HVR1wZs3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=D5bRBdX0vZiJtojq5uoS3zzR7uDn/hiwLAr0SKIp9g4=;
	b=HVR1wZs3/utrXALDGQTSoGgQHDnkRtGqO+l8A5npxeeZ8RC1BbOveVjr/pAxnj
	GrTrll0nw0bpItreHH0VyBX5Db9tZ9QdK0EZuJOkbde/hZxWZ9yKkjoJx2Vvddwn
	H2r+/hadW6uytD2sJNVQGS7LlLD6hSQ12+VkJLt2ovpcY=
Received: from [IPV6:2409:8900:1a96:d5f:b0d5:8955:9102:74c7] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgCHrrGJ4phqBenFPg--.38749S2;
	Thu, 03 Sep 2026 10:59:23 +0800 (CST)
Message-ID: <7b88d7fa-b041-4289-aa5d-20f5dd4ec87e@163.com>
Date: Thu, 3 Sep 2026 10:59:21 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ntfs: fix volume flag update races
To: Hongling Zeng <zhongling0719@126.com>,
 Hongling Zeng <zenghongling@kylinos.cn>, linkinjeon@kernel.org,
 hyc.lee@gmail.com
Cc: ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260903021930.201169-1-zenghongling@kylinos.cn>
 <6A98D99B.5020504@126.com>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <6A98D99B.5020504@126.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PygvCgCHrrGJ4phqBenFPg--.38749S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3GFW5WFWUWF1fZr4DKF47XFb_yoWfZr4Upr
	s2yasrKa1DAr1xuws7t3yIga1S934rGr4UCry7Jw1av3s0kry8XFy8K3WrZ3Wvyr97Ar1I
	qFWUtrW5uw1UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UTKZAUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbCwQycZ2qY4oyIUgAA3w



在 2026/9/3 10:21, Hongling Zeng 写道:
> Hi,
> Sorry for the many versions of this patch.

Hi Hongling,
    A small suggestion for operation:
    if you want to send a later version patch like v2, when generating 
the patch, use "git format patch -- subject prefix='PATCH v2 '-- cover 
letter - v2-3" and add "-- subject prefix='PATCH v2'" and "- v2".
    This way, others can see at a glance what version of the email your 
patch is, making it easier to review.

Thanks，
Baolin

> 
> The ntfs_sync_fs() race you pointed out is fixed in patch 1/3: 
> NVolErrors() is checked and VOLUME_IS_DIRTY is cleared inside the same 
> mrec_lock critical section, so every interleaving with a concurrent 
> error path
> leaves the volume dirty on disk.
> 
> Patches 2/3 and 3/3 close the writer-side window: the runtime error 
> paths now record NVolErrors() before taking the mrec_lock to persist 
> VOLUME_IS_DIRTY, so a clear path running afterwards sees the flag under 
> the lock
> and leaves the dirty bit alone.
> 
> Looking forward to your review and feedback.
> 
> Thanks,
> Hongling
> 
> 在 2026年09月03日 10:19, Hongling Zeng 写道:
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
>>    VOLUME_IS_DIRTY under ni->mrec_lock.
>> - Keep ntfs_set_volume_flags() and ntfs_clear_volume_flags() semantics
>>    unchanged.
>> - Do not tie setting VOLUME_IS_DIRTY to NVolSetErrors() in the generic
>>    set helper.
>> ---
>>   fs/ntfs/super.c | 62 +++++++++++++++++++++++++++++++++++--------------
>>   1 file changed, 45 insertions(+), 17 deletions(-)
>>
>> diff --git a/fs/ntfs/super.c b/fs/ntfs/super.c
>> index a1813093222b..a7977b95b967 100644
>> --- a/fs/ntfs/super.c
>> +++ b/fs/ntfs/super.c
>> @@ -353,31 +353,45 @@ void ntfs_handle_error(struct super_block *sb)
>>   }
>>   /*
>> - * ntfs_write_volume_flags - write new flags to the volume 
>> information flags
>> + * ntfs_write_volume_flags - apply flag changes to the volume 
>> information flags
>>    * @vol:    ntfs volume on which to modify the flags
>> - * @flags:    new flags value for the volume information flags
>> + * @set_bits:    bits to set in the volume information flags
>> + * @clear_bits:    bits to clear in the volume information flags
>>    *
>>    * Internal function.  You probably want to use ntfs_{set,clear} 
>> _volume_flags()
>>    * instead (see below).
>>    *
>> - * Replace the volume information flags on the volume @vol with the 
>> value
>> - * supplied in @flags.  Note, this overwrites the volume information 
>> flags, so
>> - * make sure to combine the flags you want to modify with the old 
>> flags and use
>> - * the result when calling ntfs_write_volume_flags().
>> + * Combine @set_bits and @clear_bits with the current in-memory flag 
>> state and
>> + * write the result back.  The set/clear helpers pass only the bits 
>> to modify,
>> + * not the complete flag state.  The read-modify-write happens under
>> + * ni->mrec_lock so that concurrent set/clear operations cannot lose 
>> updates.
>> + * All bit manipulation is done on CPU-endian values, and the result is
>> + * converted back to little-endian before storing it.
>>    *
>>    * Return 0 on success and -errno on error.
>>    */
>> -static int ntfs_write_volume_flags(struct ntfs_volume *vol, const 
>> __le16 flags)
>> +static int ntfs_write_volume_flags(struct ntfs_volume *vol,
>> +        const __le16 set_bits, const __le16 clear_bits,
>> +        const bool skip_if_errors)
>>   {
>>       struct ntfs_inode *ni = NTFS_I(vol->vol_ino);
>>       struct volume_information *vi;
>>       struct ntfs_attr_search_ctx *ctx;
>> +    u16 flags;
>>       int err;
>> -    ntfs_debug("Entering, old flags = 0x%x, new flags = 0x%x.",
>> -            le16_to_cpu(vol->vol_flags), le16_to_cpu(flags));
>>       mutex_lock(&ni->mrec_lock);
>> -    if (vol->vol_flags == flags)
>> +
>> +    if (skip_if_errors && NVolErrors(vol))
>> +        goto done;
>> +
>> +    flags = le16_to_cpu(vol->vol_flags);
>> +    flags |= le16_to_cpu(set_bits) & le16_to_cpu(VOLUME_FLAGS_MASK);
>> +    flags &= ~(le16_to_cpu(clear_bits) & 
>> le16_to_cpu(VOLUME_FLAGS_MASK));
>> +    ntfs_debug("Entering, old flags = 0x%x, new flags = 0x%x.",
>> +            le16_to_cpu(vol->vol_flags), flags);
>> +
>> +    if (le16_to_cpu(vol->vol_flags) == flags)
>>           goto done;
>>       ctx = ntfs_attr_get_search_ctx(ni, NULL);
>> @@ -393,7 +407,7 @@ static int ntfs_write_volume_flags(struct 
>> ntfs_volume *vol, const __le16 flags)
>>       vi = (struct volume_information *)((u8 *)ctx->attr +
>>               le16_to_cpu(ctx->attr->data.resident.value_offset));
>> -    vol->vol_flags = vi->flags = flags;
>> +    vol->vol_flags = vi->flags = cpu_to_le16(flags);
>>       mark_mft_record_dirty(ctx->ntfs_ino);
>>       ntfs_attr_put_search_ctx(ctx);
>>   done:
>> @@ -414,13 +428,14 @@ static int ntfs_write_volume_flags(struct 
>> ntfs_volume *vol, const __le16 flags)
>>    * @flags:    flags to set on the volume
>>    *
>>    * Set the bits in @flags in the volume information flags on the 
>> volume @vol.
>> + * The bits are combined with the current flag state under the lock in
>> + * ntfs_write_volume_flags(), so concurrent updates are not lost.
>>    *
>>    * Return 0 on success and -errno on error.
>>    */
>>   int ntfs_set_volume_flags(struct ntfs_volume *vol, __le16 flags)
>>   {
>> -    flags &= VOLUME_FLAGS_MASK;
>> -    return ntfs_write_volume_flags(vol, vol->vol_flags | flags);
>> +    return ntfs_write_volume_flags(vol, flags, 0, false);
>>   }
>>   /*
>> @@ -429,14 +444,27 @@ int ntfs_set_volume_flags(struct ntfs_volume 
>> *vol, __le16 flags)
>>    * @flags:    flags to clear on the volume
>>    *
>>    * Clear the bits in @flags in the volume information flags on the 
>> volume @vol.
>> + * The bits are combined with the current flag state under the lock in
>> + * ntfs_write_volume_flags(), so concurrent updates are not lost.
>>    *
>>    * Return 0 on success and -errno on error.
>>    */
>>   int ntfs_clear_volume_flags(struct ntfs_volume *vol, __le16 flags)
>>   {
>> -    flags &= VOLUME_FLAGS_MASK;
>> -    flags = vol->vol_flags & cpu_to_le16(~le16_to_cpu(flags));
>> -    return ntfs_write_volume_flags(vol, flags);
>> +    return ntfs_write_volume_flags(vol, 0, flags, false);
>> +}
>> +
>> +/*
>> + * ntfs_clear_volume_dirty_if_no_errors - clear dirty bit if no 
>> errors exist
>> + * @vol:    ntfs volume whose dirty bit should be cleared
>> + *
>> + * Check NVolErrors() and clear VOLUME_IS_DIRTY under the same 
>> mrec_lock so
>> + * ntfs_sync_fs() cannot clear the dirty bit after a concurrent error 
>> has been
>> + * recorded.
>> + */
>> +static int ntfs_clear_volume_dirty_if_no_errors(struct ntfs_volume *vol)
>> +{
>> +    return ntfs_write_volume_flags(vol, 0, VOLUME_IS_DIRTY, true);
>>   }
>>   int ntfs_write_volume_label(struct ntfs_volume *vol, char *label)
>> @@ -1862,7 +1890,7 @@ static int ntfs_sync_fs(struct super_block *sb, 
>> int wait)
>>           return 0;
>>       /* If there are some dirty buffers in the bdev inode */
>> -    if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY)) {
>> +    if (ntfs_clear_volume_dirty_if_no_errors(vol)) {
>>           ntfs_warning(sb, "Failed to clear dirty bit in volume 
>> information flags.  Run chkdsk.");
>>           err = -EIO;
>>       }
> 
Hi Hongling,
   Patch 1 fixes the race in ntfs_sync_fs(), but there are two other 
sites with the same check-outside-lock-then-clear-inside-lock pattern:

   1. super.c:315 (ntfs_reconfigure, remount read-only path)
   2. super.c:1755 (ntfs_put_super, umount path)

   Both use:
       if (!NVolErrors(vol)) {                           // check 
outside lock
           if (ntfs_clear_volume_flags(vol, VOLUME_IS_DIRTY))  // clear 
inside lock

   The same race can occur: if an error thread sets NVolErrors() and the
   dirty bit after the check but before the lock acquisition, the clear
   operation will overwrite the freshly-set dirty bit.

   Although the race window is much narrower for remount/umount, should
   these two sites also be converted to use
   ntfs_clear_volume_dirty_if_no_errors() for consistency?

Reviewed-by: Baolin Liu <liubaolin@kylinos.cn>


Thanks,
Baolin.

