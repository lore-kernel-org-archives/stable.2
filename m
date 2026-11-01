Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793517510;
	b=gxjGmgttjD4U7GsqEy/M7keRu2do7b2oNilJkrFw13+VN5g33NTYU1wU2hXtA9hrtPH5
	 S0QpExd7t7r6nPN5QVB/raN3DQkac2BKu/csAgpnHknc2YUQHrtrFpo+IWW5VgLLF9kuM
	 3foYfC2UBUIggJRiZR8JKHjKI3ypsiLXsI2pdl7xu5Zk24QBDCcxdS4IDvW+wJRUVcZEp
	 Ap13ULEpRMu1TXjUieMdb2SS+ETFo9VVF36iqtBYvMixt91JNgvofqVXgCoB019Z95uP5
	 8pvSM3Ex1RUqtT+KmUVs97YTMFU48U3uBnOonSI2wxa25yK+/ilidGjcF1Lwx53Q0Gg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793517510;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=X+BwoNYH8Zzqv3w5tIVg3636uhE4Ev+ncQBA55QTM0Y=;
	b=h1a/gwE6EDW9JQGbQ15DHNLjIXo7ZDMrDOqoFECJ7sr5VoFflLdSOXFDRp8HgjrBlRQA
	 kTcC8YJ73bJIPW7LvB+vOPfH9uMYHQOesVmgSdtytjWD/dMWRkE5mHYECGyETaoiK4Hq2
	 pZMvPeNx8ta5uRc3LtC8MllLpbcIGkz9B1G+/rpNXiuZb8Xt5ehZshWzklKjuyM9ci5az
	 hfRCB4pIisd738pEEYA/aNjwItcXuxSVMSCkUvntz/pBEJy0FeSumaLi+ZUiZ08TwOX0e
	 Lf8FkP2Ax1Tm6YjU2itwUFMgm5nvk3Et39wPqy+7+lgIlXVFXqLjzrnU6OJFhZQ60IQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ffK5pmQk;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C583606A326
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 07:18:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C583606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=ffK5pmQk
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a210470b49so15613875e9.2
        for <stable@vger.kernel.org>; Sun, 01 Nov 2026 00:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1793517508; x=1794122308; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X+BwoNYH8Zzqv3w5tIVg3636uhE4Ev+ncQBA55QTM0Y=;
        b=ffK5pmQkqD7xyXFYTYf2tSVw1KfU9AScHuDeQEj0RaUM5ODUuEB3elvi7BIDxa0Wpf
         oGoDo5g4HwMt0T0SqlJn2SlTSGOUfIbvQ79nfoNdsEYpGRg4aOu5PZ6sZIvFZxrN9PGt
         IZXKXWAtg/E2YplhIvxZTkBTCo0KKbU8Zno6PK0NZi7qSW3/LlRzO222l8TB6cDdNi4j
         OEi/YbwnjtvR45G4Sgk7/cjGIf9t7q74+/zbVQQi6LXakNbrazZ1QFvPEPUNpT0KHdko
         WHqQpnNr5YUt8TpnuzIrTrr1A4+5w/w/6r4r9kPO0444XyUmba+PkTL3vfgUv1A98/cc
         hi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793517508; x=1794122308;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X+BwoNYH8Zzqv3w5tIVg3636uhE4Ev+ncQBA55QTM0Y=;
        b=11itApXzROtoO+ZiyDk2TEUTCTj9/N9rcnkaIezP5vRMRAM9nHufp6o0RXHDC0JZjC
         8p0tmFyP6s08yY3G2RiWtu5ciRM+41ANIq/wEcALtmkUnhXGPcOHt/34/cdJhxJksEbn
         fOCdjzNTQ5sd5OXpoofKatfatSEq4y5XAoc02LPWOFdlMblOreQYLa83F8uFAoRzA3tc
         eUuRrw42OMEczfAIz0UuJ3U2audeKtG7GYAMLJEXDXz3smDcx82zPb36rtEIuQqpm0Bh
         UkG/p+PfCjAAUTctbIPOagLQawPSXLDPmGlAfsitj9vQSynYTWCIQfncEzjeo9fntsLr
         pffg==
X-Forwarded-Encrypted: i=1; AKwUvByjz0ZYoLjtwyZQMave+Yfnei+46g3IiJXv3ioqZm6//9VycoI39nYAIzFr4qMo8rBr9UsTA0w=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhabYdfsm7NyO7mDzk01NvWedouveNVXRAmjXumRbgG4MVrMJ0
	qaZEIj2AeWSWBXkxBuPzKsO7gBUmxbSfMXWdZToHdvEwKyCzwv4QcxR3G3KQYoAeVQc=
X-Gm-Gg: AYBFou3h+z1hEAqrsA9Bwtt/kR3VOFgYkrGFENcmP7cr5+OR6ecyRL6yPX6bGx1hrGx
	qDt1bLAec0F34Cj6hB0yH9rNPtKuBIaZs7XTLQ5hiPkbZJy47irmk9dOhqLrwFU0YjdrAXas/zB
	epny2KIT4Dl78oy5sSswd2YhxI0bDIIonMUoJv2jVaBFEfNM76NL5Rqqx7xjfO+a1GcsxdQyi8l
	72F9McXxRv+EwQcG0rw7pG+rJ/M5BJGQHYONndBmIqkCUSnlBb86HOyB/22Wf3GmxFagydNAy5R
	yNeBZIwbzB35L+cgekvTJEDf6fYLSeCeOrEcS2vwbZpKb4eRa3qj8WaKMRe/w2oL+fzojBXAHMt
	UmqACRI+HvFwe1jJ+c2WQ/Z9E59aoIRACiLpWxHK3/mgyxgHYihlOY297cRjtA9j9mLDlcXJj56
	8It0UvNaxNHZZF3j6uKK6QYAnYJSGOTutXf0rVhUATAXb3HrK8I4MqKYSz1yhu17A0FTEIk1S1f
	aq/9IzqBrNNI+BtGo+hdRP6x1Kkd4TEi1LqthEaSBfBUgzm/tGdiQQFgHHC9VvWa0TGoA5013/k
	x2SIYVquZU73f8XpNVheMlDUjbv8Wg9dnc0vXhuaAg==
X-Received: by 2002:a05:600c:1f93:b0:4a1:7e76:d02f with SMTP id 5b1f17b1804b1-4ac180f299emr143671995e9.14.1793517507631;
        Sun, 01 Nov 2026 00:18:27 -0700 (PDT)
Received: from [172.16.0.229] ([159.196.52.54])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac19f4a04esm22697298c88.15.2026.11.01.00.18.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Nov 2026 00:18:26 -0700 (PDT)
Message-ID: <b4962b1b-bc5e-4302-8456-73b9b8a6474b@suse.com>
Date: Sun, 1 Nov 2026 17:48:21 +1030
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
Subject: Re: [PATCH v2] btrfs: reject refs=0 subvolume without DEAD in
 SUBVOL_SYNC_WAIT
To: Qu Wenruo <wqu@suse.com>, Cheng Yongkang <teel4res@gmail.com>,
 David Sterba <dsterba@suse.com>
Cc: Chris Mason <mason@kernel.org>, linux-btrfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20261101062539.1744605-1-teel4res@gmail.com>
 <a92d223b-55fa-493e-821a-e5acc8afee08@suse.com>
Content-Language: en-US
From: Qu Wenruo <wqu@suse.com>
Autocrypt: addr=wqu@suse.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNGFF1IFdlbnJ1byA8d3F1QHN1c2UuY29tPsLAlAQTAQgAPgIbAwULCQgHAgYVCAkKCwIE
 FgIDAQIeAQIXgBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ujyBQkUpLw5AAoJEMI9kfOh
 Jf6o8OIH/0mqW+TQM4m2x3hCsnK+oB4yJH1qnGvIhFF/Lhs48wI02sGh6/4aA0hkCDfd9LHQ
 +ci4FUepZ9y4VS01+oIExbg/8ytzGYTzLtb44jK2GBOBVSJkMiha6jp22XFt7WUkT/tvbreu
 WWdGsaJIRQaZChy7xsMI8lqQ2WdmluZJ4LT0wD3l/l6QU1ZseMGySebdY9sVOQEOJNV7Qj92
 /KOAFNmeZshV/qDI8Iw1RTs6TvLqCcqmlZLCmJkYSVhT1RonWRren8xIRcFEgMe004IDnt7V
 qdQhk/nhTS9x9MBAhMRl0TTE1VKDLvVALsud3iZLrmmtYvwPApzGJk052f0m28vOwE0EWdWB
 rwEIAKpT62HgSzL9zwGe+WIUCMB+nOEjXAfvoUPUwk+YCEDcOdfkkM5FyBoJs8TCEuPXGXBO
 Cl5P5B8OYYnkHkGWutAVlUTV8KESOIm/KJIA7jJA+Ss9VhMjtePfgWexw+P8itFRSRrrwyUf
 E+0WcAevblUi45LjWWZgpg3A80tHP0iToOZ5MbdYk7YFBE29cDSleskfV80ZKxFv6koQocq0
 vXzTfHvXNDELAuH7Ms/WJcdUzmPyBf3Oq6mKBBH8J6XZc9LjjNZwNbyvsHSrV5bgmu/THX2n
 g/3be+iqf6OggCiy3I1NSMJ5KtR0q2H2Nx2Vqb1fYPOID8McMV9Ll6rh8S8AEQEAAcLAfAQY
 AQgAJgIbDBYhBC3fcuWlpVuonapC4cI9kfOhJf6oBQJq3ukKBQkUzDspAAoJEMI9kfOhJf6o
 SNsH/1ysUWOKmzY0rGS3ZdS61QgqMGhSWD/EJ4UiPw+xO4l4+GtX0fOAqxqsmBKqje3vyhBa
 Z5o/1Y+gNiN+E6RBcSz4b1TAd78sQ2bvT5DWOvBjeeVxHdiuQMIn4S8xk5ZpySBw5ifjoiuL
 0M33UVtJOzM8yfAeL+d/Rp4leJw72SutjkLyZTG/gJIp4pJGD/kFHn24OLL0IxEcO0gOekNZ
 os5e1R6jAJ2ILk7+MDnvU8wXHcCiVzuDhJLI1tih1uUIE50muHQJWbYuVBbdJeu8WlIDDssx
 UOCxLylNG3gDXV5MhLubPTOpp9OiFc/XC37nvkgEcrlmlOFBv4/NJCbECpo=
In-Reply-To: <a92d223b-55fa-493e-821a-e5acc8afee08@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/11/1 17:21, Qu Wenruo 写道:
> 
> 
> 在 2026/11/1 16:55, Cheng Yongkang 写道:
>> btrfs_ioctl_subvol_sync() assumes that a cached root with zero
>> references has BTRFS_ROOT_SUBVOL_DEAD set, and asserts that before
>> waiting for the cleaner. Two states break the assumption:
>>
>> - A corrupt ROOT_ITEM with zero references and a matching orphan item,
>>    on a writable filesystem.
>> - A failed subvolume deletion. btrfs_delete_subvolume() zeroes the
>>    root references, aborts the transaction, which forces the filesystem
>>    read-only, and then clears DEAD again. No on-disk metadata is
>>    corrupted in this case.
>>
>> With CONFIG_BTRFS_ASSERT=y, both reach a BUG().
>>
>> Before waiting for a deleted subvolume, return -EROFS if the
>> filesystem is read-only, since the cleaner does not drop dead roots
>> then. The check runs on every iteration, so it also stops a waiter
>> when the filesystem becomes read-only during the wait. Subvolume
>> deletion holds subvol_sem for writing across the abort and the DEAD
>> rollback, and each iteration takes it for reading before inspecting
>> the root, so the read-only state and the cleared flag are seen
>> together. On a writable filesystem, report a zero-reference root
>> without DEAD and return -EUCLEAN instead of asserting.
>>
>> Subvolumes that were not deleted or do not exist still return -EEXIST
>> and -ENOENT, also on a read-only filesystem.
>>
>> Tested on btrfs for-next with CONFIG_BTRFS_ASSERT=y. A deletion made
>> to fail by fault injection after the references are cleared hits the
>> assertion in SUBVOL_SYNC_WAIT without this change and gets -EROFS with
>> it. A waiter on a deleted subvolume now returns -EROFS when the
>> filesystem is remounted read-only, instead of waiting until it is
>> signalled.
>>
>> Fixes: 6c83d153ed86 ("btrfs: add new ioctl to wait for cleaned 
>> subvolumes")
>> Cc: stable@vger.kernel.org
>> Suggested-by: Qu Wenruo <quwenruo.btrfs@gmx.com>
>> Link: https://lore.kernel.org/linux-btrfs/dd97efe9-91ec-495b-b698- 
>> acff1447421c@gmx.com/
>> Signed-off-by: Cheng Yongkang <teel4res@gmail.com>
>> ---
>> Changes in v2:
>> - Return -EROFS on a read-only filesystem before waiting for a deleted
>>    subvolume (Qu).
>> - Use unlikely() for the inconsistent-root check (Qu).
>> - Describe the failed-delete case separately from corrupt metadata.
>> - Add the Fixes tag and Cc stable.
>>
>> v1: https://lore.kernel.org/linux-btrfs/20261025180258.349175-1- 
>> teel4res@gmail.com/
>>
>> Testing notes (btrfs for-next d1dca33127ef, KASAN):
>> - The fault-injection case reached the cleared-references state in 2
>>    of 4 attempts on each kernel. The other attempts aborted earlier, and
>>    both kernels returned -EEXIST.
>> - FOR_ONE, FOR_QUEUED, COUNT and PEEK return the same results with and
>>    without this change for live, missing and deleted subvolumes, on
>>    writable and read-only mounts.
>> - The -EUCLEAN branch was not exercised. A crafted image with a
>>    zero-reference root and no DEAD flag hits the assertion without this
>>    change, but remounting that image read-write stalls in a transaction
>>    commit with or without this change, before the filesystem becomes
>>    writable.
>>
>>   fs/btrfs/ioctl.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/btrfs/ioctl.c b/fs/btrfs/ioctl.c
>> index 9857d6a9d456..5a1f2edfd831 100644
>> --- a/fs/btrfs/ioctl.c
>> +++ b/fs/btrfs/ioctl.c
>> @@ -5166,8 +5166,14 @@ static int btrfs_ioctl_subvol_sync(struct 
>> btrfs_fs_info *fs_info, void __user *a
>>               return -ENOENT;
>>           wait_for_deletion = true;
>> -        ASSERT(root_flags & BTRFS_ROOT_SUBVOL_DEAD, "root_flags=0x%llx",
>> -               root_flags);
>> +        if (unlikely(test_bit(BTRFS_FS_STATE_RO, &fs_info->fs_state)))
>> +            return -EROFS;
> 
> I'm not suggesting such an ad-hoc check, but some more comprehensive 
> checks, like mnt_want_write_file().
> As this one won't handle aborted transaction.
> 
> But it's not a good idea using that mnt_want_write_file() either, as 
> that will block pm suspension/hibernation, especially considering the 
> wait will only be handled by cleaner thread.
> 
> The default timeout for waking up cleaner is 30s, which is definitely 
> not suitable for such calls.
> 
> 
> If you are not sure what to do with the RW check and cleaner behavior, 
> just don't put an adhoc solution into the update.
> At least it won't be any worse.

With that said, there are more problems with the ioctl.

- No real user
   No one is utilizing BTRFS_SUBVOL_SYNC* flags. Btrfs-progs itself
   doesn't even bother it.

   So all these fixes are very low priority, unless there are some wild
   programs utilizing this.

   But even btrfs-progs doesn't utilize them, the possibility are very
   low.

- Incorrect return value
   For that wait loop, if we waited for several rounds, then the
   subvolume is properly removed. Then we just return -ENOENT, which is
   definitely not the correct return code.

- Inconsistent radix tree index checks
   There is a U32 radix tree check, but there is no such check for any
   other operations like btrfs_insert_fs_root(), which can lead to
   subvolid conflicts.

With that said, I'd say it's more meaningful to address those problems, 
and add a proper btrfs-progs support for it, along with test cases.

Sure, if you only want to fix the ASSERT(), that's fine.

But I would prefer to take a little more time to find out the real 
problems deeper behind the scene, other than dumping tokens to just grab 
some low hanging fruit.

> 
> 
>> +        if (unlikely(!(root_flags & BTRFS_ROOT_SUBVOL_DEAD))) {
>> +            btrfs_err(fs_info,
>> +                  "subvol %llu has refs 0 without DEAD flag",
>> +                  args.subvolid);
>> +            return -EUCLEAN;
>> +        }
>>           sched_ret = schedule_timeout_interruptible(HZ);
>>           /* Early wake up or error. */
>>           if (sched_ret != 0)
>>
>> base-commit: d1dca33127efacd86ac550aa86352f8ea9f29a5a
> 

