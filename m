Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A433A37DE84;
	Mon, 29 Jun 2026 03:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782703680; cv=none; b=es220QO2N00EchfviwVY2xbOM+vQrrWXhdBD3uoyDuSyFJZq2n/T+Kmvirk7tmX1SthJHGLZ2GJ88xY8Yq5OJX3zyDpRUV9hx5CCkOgQvxOEXD5uXakNHPna7QL5+Od9kO9/z6/Zej4UDyuWCEPnfROeEgH0xGUBhEutsWIHW+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782703680; c=relaxed/simple;
	bh=Mh0HCfG+EqC71QqziUOSeBTvb7e5Dd2WJzMcOo/E+Mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jOg+Wbhbwi0EV8I6MaCByonE4RH7PS8MyFlIFzpdlxQqaVXJ1MrOQVwKXwBiyb8/22yx1ao5VlqixfLpH39sDlBfs/OTP/JfmgUJmYDrVvCZiueXXFqZcU8rnL3QTVSVyDEZgVb8n8kf/DAm1Hqdy6AH86f79lDj3hmCKgbBb0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=mjRpffcB; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="mjRpffcB"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782703668; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=GnuCCBI3ALRCI/rId03CW8nskbsRqSLSxoX75VBaEXk=;
	b=mjRpffcBLVZJT32bHFGBQkykRhoZ2HpkcTs9dxecugboXuSFNuzAAhSQQ5T5au1grTXfNOd8Ant1/+Vp68xxX9VpbBLmrD7phndRrU/6xJCA2R27JmAgDCcW5eClO4z60qyoUHQ1z+A4x85958ZCY1xcs8WagLm/G/oAM1+2ucs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R651e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X5luln4_1782703667;
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0X5luln4_1782703667 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 29 Jun 2026 11:27:48 +0800
Message-ID: <dde92cd4-c6fe-4339-a892-004ca78ebc30@linux.alibaba.com>
Date: Mon, 29 Jun 2026 11:27:47 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tmpfs: zero unused folio tail for long symlinks
To: Yousef Alhouseen <alhouseenyousef@gmail.com>,
 Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 syzbot+bf5586280a66e9ccdfa9@syzkaller.appspotmail.com,
 Barry Song <baohua@kernel.org>
References: <20260628004314.27370-1-alhouseenyousef@gmail.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20260628004314.27370-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

CC Barry.

On 6/28/26 8:43 AM, Yousef Alhouseen wrote:
> shmem_symlink() marks the entire folio uptodate after copying only the
> NUL-terminated link target. The remainder of the freshly allocated folio
> is left uninitialized.
> 
> Reclaim may pass the whole folio to a swap compressor. KMSAN observed
> sw842_compress() computing a checksum over the uninitialized tail. If
> the folio is written to a swap device, those bytes can also leave the
> kernel.
> 
> Zero the remainder of the folio before marking it uptodate and dirty.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: syzbot+bf5586280a66e9ccdfa9@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=bf5586280a66e9ccdfa9
> Cc: stable@vger.kernel.org

Do we need CC stable? Have you observed any actual impact?

> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
>   mm/shmem.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/mm/shmem.c b/mm/shmem.c
> index b51f83c970bb..b06c1ae2f50c 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -4057,6 +4057,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
>   			goto out_remove_offset;
>   		inode->i_op = &shmem_symlink_inode_operations;
>   		memcpy(folio_address(folio), symname, len);
> +		folio_zero_range(folio, len, folio_size(folio) - len);
>   		folio_mark_uptodate(folio);
>   		folio_mark_dirty(folio);
>   		folio_unlock(folio);

Thanks. Barry sent the same fix before[1] (though I forgot why it didn't 
get merged). I think this is a reasonable fix. So:

Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

[1] https://lore.kernel.org/lkml/20251224020424.52976-1-21cnbao@gmail.com/
