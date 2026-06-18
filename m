Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12B7B2E7F0A;
	Thu, 18 Jun 2026 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781773847; cv=none; b=nYhhcoFx1RrGQWM46D7axxUczPwPW+Gh+RKi94cVlg3NIDNc5YroHP6veGQxtZL1ZxHMQv7PdVCTE3d+IO9ACC+oz/7u1kivpMLJ6dGkNnTuLtKyUIt4/niocV6qse2DqPyIRh7vri0/+nDWUbqZdxqwUjfM1mvd/dUQ7B1N1wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781773847; c=relaxed/simple;
	bh=0KmksIlsFebc+Hwiubh5WMHG/AlNHNdUDIvsEYBpHBE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KtG6LyG8puFbp5J4ZelSlbQe7VaF9X6YpBSLFcrr/02D8cSR6bbyCZZ1dpelnuHOf3PWgJt6HfituDcJ5LHrMffsXTaUj0MIgyl+2O0+gWOCdT6AmwdbaLAbvGC2MNCmxQrtxGbmCemhFHkFPH0zBARfB2C33sQzHeP7oP1yLWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8TmQdOY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8TmQdOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756C61F000E9;
	Thu, 18 Jun 2026 09:10:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781773845;
	bh=Mu/5JeWg9wGgtcFG3wqOUM31ha/q1C3fppjlkFjuvrM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=a8TmQdOYEc4RG5qU7fTNKbdi7+JVCHqvfQi28aKRCmj9NjgicMpKs16bt4EFCkbvJ
	 r/oC+canvKL7VyqAsYOsJS+loTIdQJZZ5AgPG6GjxUhHBzZ2vRi0SvjhLpzHkzp3wg
	 Exs+xvy76ecw/Y82iuGTHV5u7nHmU67s5NOAZ4Gv3dPXYDUL4azztSgzZZyqgDiYj4
	 5Nhxkzx8Pw1nZT3Zan9LXm7XUPPKP0skBrSFCGND+0oSV5FMHHRsh62cj2f/xmIt38
	 uZDJEquEkf+UTEZfU9WuL0v4gJtoHViL+GquJ5IwOmlSFhbuH8KlqngmBLCaoiEA5E
	 JmYGzOdBA7g4Q==
Message-ID: <0d161878-6602-4bbb-b1db-754f4a37a011@kernel.org>
Date: Thu, 18 Jun 2026 17:10:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, geoo115@gmail.com, yangyongpeng@xiaomi.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: use post-decrement count for cp_wait
 wakeup
To: Wenjie Qi <qwjhust@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260616135637.1439319-1-qiwenjie@xiaomi.com>
 <ajLi3nLqyS31Y6J4@google.com>
 <CAGFpFsRfSsBjuhGmXC8_NohcPFEAZncWKFnmbazo5EhrNqCM-A@mail.gmail.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <CAGFpFsRfSsBjuhGmXC8_NohcPFEAZncWKFnmbazo5EhrNqCM-A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/18/26 11:38, Wenjie Qi wrote:
>    The race is between dec_page_count() and the later get_pages() check:
>    another CP-data writeback can be submitted after the counter reaches zero
>    but before get_pages() observes it, so the zero transition may miss the
>    cp_wait wakeup.

Can you describe race condition like below calltrace? which will be easier to
understand?

     loop device                             umount
     - worker_thread
      - loop_process_work
       - do_req_filebacked
        - lo_rw_aio
         - lo_rw_aio_complete
          - blk_mq_end_request
           - blk_update_request
            - f2fs_write_end_io
             - dec_page_count
             - folio_end_writeback
                                             - kill_f2fs_super
                                              - kill_block_super
                                               - f2fs_put_super
                                              : free(sbi)
            : get_pages(, F2FS_WB_CP_DATA)
              accessed sbi which is freed

Thanks,

> 
>    v6 also adds dec_page_count_return() and uses it instead of accessing
>    nr_pages directly.  The wakeup logic is unchanged from v5.
> 
> https://lore.kernel.org/linux-f2fs-devel/20260618031008.2447279-1-qiwenjie@xiaomi.com/T/#u
> 
> On Thu, Jun 18, 2026 at 2:09 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>>
>> On 06/16, Wenjie Qi wrote:
>>> f2fs_write_end_io() decrements the writeback page counter and then
>>> reads it again with get_pages() to decide whether the last
>>> F2FS_WB_CP_DATA completion should wake cp_wait.
>>>
>>> Use atomic_dec_return() for F2FS_WB_CP_DATA completions so the wakeup
>>> decision is made from the value produced by the decrement itself. Keep
>>> the existing dec_page_count() path for other writeback counters.
>>
>> Is there a race condition to do this? If so, can you describe? And, I think
>> we need a wrapper function instead of calling nr_pages directly.
>>
>>>
>>> Fixes: e234088758fc ("f2fs: avoid wait if IO end up when do_checkpoint for better performance")
>>> Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
>>> ---
>>>   fs/f2fs/data.c | 12 +++++++-----
>>>   1 file changed, 7 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
>>> index d83a21998ec2..58d23eb74ec2 100644
>>> --- a/fs/f2fs/data.c
>>> +++ b/fs/f2fs/data.c
>>> @@ -392,15 +392,17 @@ static void f2fs_write_end_io(struct bio *bio)
>>>                if (f2fs_in_warm_node_list(folio))
>>>                        f2fs_del_fsync_node_entry(sbi, folio);
>>>
>>> -             dec_page_count(sbi, type);
>>> -
>>>                /*
>>>                 * we should access sbi before folio_end_writeback() to
>>>                 * avoid racing w/ kill_f2fs_super()
>>>                 */
>>> -             if (type == F2FS_WB_CP_DATA && !get_pages(sbi, type) &&
>>> -                             wq_has_sleeper(&sbi->cp_wait))
>>> -                     wake_up(&sbi->cp_wait);
>>> +             if (type == F2FS_WB_CP_DATA) {
>>> +                     if (!atomic_dec_return(&sbi->nr_pages[type]) &&
>>> +                         wq_has_sleeper(&sbi->cp_wait))
>>> +                             wake_up(&sbi->cp_wait);
>>> +             } else {
>>> +                     dec_page_count(sbi, type);
>>> +             }
>>>
>>>                folio_clear_f2fs_gcing(folio);
>>>                folio_end_writeback(folio);
>>>
>>> base-commit: c0b65f6129c7fbb526e921dd60261650f1b2bef9
>>> --
>>> 2.43.0
>>>
>>>
>>>
>>> _______________________________________________
>>> Linux-f2fs-devel mailing list
>>> Linux-f2fs-devel@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

