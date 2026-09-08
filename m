Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3CC318EC4;
	Tue,  8 Sep 2026 03:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788838124; cv=none; b=ihje/PgO5whFmqBXp0pmJE7R9YjrX2Nb31fvlfm/inkuxb4SwNhrppC4C1NZqvx4iPFDf3N/faRh/r9as7DaoCeBKB8Tqp30spoysuzkTrFVrUFlAjt+9Ha3g9ASypQYEoSyLzVlstGQ2T/4TeoWjjQ86/5TkOBBikKJAm1VcZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788838124; c=relaxed/simple;
	bh=DW1SKC1RHCKiNnSlS5ckc1dSmlacAbY7Ge3SiyatA1o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vi5B4rI0VEJfB2wKcPQijJZpONEab9ejIacjwoMVlU/G8vukK4YCkjTn9RsB0M0y5o4qsrcI0lJZ12pftL5bV28XN/CQZ+NbFC1nfH0rxScYSp235DfOQR9Qg4/k3RBXYyXqMnYXDIfDo34ChxQkpu+nZnnra0BiK2oQSB6JXYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=AyE6qOnI; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="AyE6qOnI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=9Jmh13UuI18JqUXcZu4rjIJtMowjjdODVjEiYNhzfec=;
	b=AyE6qOnIv6i/lJwmS3pVYExpv8fKzXYzZy61hnk+NPqEfAn3EHTGWAxNZEoYrg
	GOa8jE/Th/7fIP5NHJVYzm/rzwvYyi2EpUu/EiG1En8SFsGRqD8m+eQre51qUMrS
	UuV1lAlFDD+HXEQg7L/xKWi/lq8X8mHDFFKy1D7Lr/9bY=
Received: from [IPV6:2409:8900:1e93:d74:46a:b98a:2b32:6a19] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3_4vSgJ9qjoihBQ--.26682S2;
	Tue, 08 Sep 2026 11:28:20 +0800 (CST)
Message-ID: <99339432-684c-4ef5-b7df-8ab27f42d614@163.com>
Date: Tue, 8 Sep 2026 11:28:17 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] isofs: fix Rock Ridge CE extent validation on
 multisession media
To: Jan Kara <jack@suse.cz>
Cc: michael.bommarito@gmail.com, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Baolin Liu <liubaolin@kylinos.cn>,
 stable@vger.kernel.org
References: <20260907082602.3777551-1-liubaolin12138@163.com>
 <rkarpx2frv53ygu4hye6vpxi6kztw2uiygysx2x4cwrx3jjrtc@guubqalgvowf>
Content-Language: en-US
From: liubaolin <liubaolin12138@163.com>
In-Reply-To: <rkarpx2frv53ygu4hye6vpxi6kztw2uiygysx2x4cwrx3jjrtc@guubqalgvowf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_4vSgJ9qjoihBQ--.26682S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFW8WrWDtw13CFyrWw1kAFb_yoW5Ar4Upr
	ZrG3W7KF4UJ3Wxuryvva4xXry5K39aya17GrnxJ3WUJa4v9FyIyF13tr15JayqqrZ3Ja1Y
	9FWYqr97Ga1jyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UwvttUUUUU=
X-CM-SenderInfo: xolxutxrol0iasrtmqqrwthudrp/xtbC6RTXomqfgNT7-QAA3v



在 2026/9/7 18:58, Jan Kara 写道:
> On Mon 07-09-26 16:26:02, Baolin Liu wrote:
>> From: Baolin Liu <liubaolin@kylinos.cn>
>>
>> Commit a36d990f5913 ("isofs: validate Rock Ridge CE continuation extent
>> against volume size") compares the CE extent directly with s_nzones.  The
>> extent is an absolute block number, while s_nzones is the number of blocks
>> relative to the selected ISO session.  The comparison is therefore wrong
>> when a multisession disc starts at a non-zero block.
>>
>> isofs_get_last_session() selects the last session on multisession
>> media, and its volume descriptors describe a volume beginning at that
>> session's LBA.
>> For example, a session beginning at LBA 45447 with 64 blocks can contain a
>> valid CE at absolute LBA 45467.  The existing check rejects that CE, so the
>> ER continuation record is not read, Rock Ridge is disabled, and the mount
>> falls back to Joliet names.
>>
>> Save the selected session start in filesystem-block units and validate the
>> CE extent against the half-open interval [session_start, session_end).
>> Scale the session length to the same block units and retain a separate
>> block-device limit.  The lower bound is intentional: accepting arbitrary
>> blocks before the selected session could make a CE read data from a
>> previous session or another filesystem on the device.
>>
>> Only apply the bounds check when cont_extent is non-zero.  A zero extent is
>> the in-memory sentinel indicating that no CE continuation was found, rather
>> than a request to read block zero.
>>
>> For a single-session image, session_start is zero and the effective volume
>> boundary remains unchanged.
>>
>> Build-tested with:
>>
>>      make CONFIG_RUST= CONFIG_RUST_DRIVERS= fs/isofs/
>>
>> Fixes: a36d990f5913 ("isofs: validate Rock Ridge CE continuation extent against volume size")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Baolin Liu <liubaolin@kylinos.cn>
> 
> Thanks for the fix! I've taken the patch to my tree. I've slighly cleaned
> up the types (use sector_t instead of u64). I've also remove the check
> against sb_bdev_nr_blocks() - if anything, we should have check s_nzones
> fits within the block device earlier, not in Rockridge parsing code.
> 
> 								Honza
> 
Hi Honza,
    Thank you for improving and organizing the patch fixes.
Thanks,
Baolin.


>> @@ -101,11 +107,14 @@ static int rock_continue(struct rock_state *rs)
>>   		goto out;
>>   	}
>>   
>> -	if ((unsigned)rs->cont_extent >= ISOFS_SB(rs->inode->i_sb)->s_nzones) {
>> +	if (rs->cont_extent &&
>> +	    (extent < sbi->s_session_start ||
>> +	     extent >= session_end ||
>> +	     extent >= sb_bdev_nr_blocks(sb))) {
>>   		printk(KERN_NOTICE "rock: corrupted directory entry. "
>>   			"extent=%u out of volume (nzones=%lu)\n",
>>   			(unsigned)rs->cont_extent,
>> -			ISOFS_SB(rs->inode->i_sb)->s_nzones);
>> +			sbi->s_nzones);
>>   		ret = -EIO;
>>   		goto out;
>>   	}
>> -- 
>> 2.51.0
>>

