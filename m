Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB78235AC07;
	Tue, 11 Aug 2026 01:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786410049; cv=none; b=M0NRFIf1LwY0O590lZD7jS7GDes7GxAnUEtbN1LTZ7Uako0ZUnMZPwzLPCFnU1uxpW8OQRTjV4aWbbwcR2kPYWniF5GEuLqX6DPTFBXyNV72T0AXOVM8x1s8Ujy8ES7bPXIp7SvhZJWpX6Qw23DZLscI4yVeESPIdi6cdTcMb/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786410049; c=relaxed/simple;
	bh=WJ26OSaxHu81+Ut+YwEQ+ihjohMQJxEnhLIQ9lQ13Sw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YuqJ+3T3qNBC5b6rP0HMmQ5iSY+tKRUV98MmKFDz3HG1RoKOVfuKvNSGpWmGEO9xz1bf6paM8HFRluWtSZSQuloNqEcXXFEp6BsSQ2OklU1CsUjYo/thN1sd3S6WiOYbuPNg6Sg4mG5bsgL75rRzVuKqDi/H9VuoZTIRStUPoSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=OTZN3vS6; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="OTZN3vS6"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786410039; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dwtQcvm1kh6sD91quCycZFtphcFKjDvEK+jso18AATc=;
	b=OTZN3vS68+M36SAYM5GkB8zaLZDQrZqA8TE66k8NZ4ZA5tLZ0abO81bJfRsChw+OtTwG/9FjJUINGjCOtj4XHdRI2rVIR/xPulHJ06SqGEn1RZhDmjhfDadFBiM54eIn/4klJ9wyYi3S5e2GmICtrkNZqYC/cFYbUVQnykSQYfs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=joseph.qi@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X8mP3mb_1786410038;
Received: from 30.221.129.51(mailfrom:joseph.qi@linux.alibaba.com fp:SMTPD_---0X8mP3mb_1786410038 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 11 Aug 2026 09:00:38 +0800
Message-ID: <7dba713d-fb15-4f9d-a369-690e77afb18d@linux.alibaba.com>
Date: Tue, 11 Aug 2026 09:00:37 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ocfs2: bound-check dir entries in the readdir
 re-validation scan
To: Zhan Xusheng <zhanxusheng1024@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
 ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, zhanxusheng@xiaomi.com
References: <20260806122133.956847-1-zhanxusheng@xiaomi.com>
From: Joseph Qi <joseph.qi@linux.alibaba.com>
In-Reply-To: <20260806122133.956847-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/6/26 8:21 PM, Zhan Xusheng wrote:
> When the inode version changed since the last readdir(),
> ocfs2_dir_foreach_blk_el() re-scans the directory block from its start to
> relocate the current position:
> 
> 	for (i = 0; i < sb->s_blocksize && i < offset; ) {
> 		de = (struct ocfs2_dir_entry *)(bh->b_data + i);
> 		if (le16_to_cpu(de->rec_len) < OCFS2_DIR_REC_LEN(1))
> 			break;
> 		i += le16_to_cpu(de->rec_len);
> 	}
> 
> The loop dereferences de->rec_len (at byte offset 8 within the entry)
> guarded only by i < sb->s_blocksize.  `offset` is derived from ctx->pos,
> which userspace controls via lseek() on the directory fd, so i can reach
> the last bytes of the block; reading de->rec_len then reads a few bytes
> past the s_blocksize-sized block buffer (an out-of-bounds read).
> 
> The main emit loop below already guards this via ocfs2_check_dir_entry(),
> which rejects entries too close to the buffer end before touching de.
> Apply the same lower bound to the re-validation scan so that a full
> minimal directory entry is known to fit before de is dereferenced.  For a
> consistent directory this changes nothing: entries are at least
> OCFS2_DIR_REC_LEN(1) bytes, so no valid entry starts in the excluded tail.
> 
> Found by the sashiko review tool; fix approach suggested by Joseph Qi.
> 
> Suggested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
> Fixes: ccd979bdbce9 ("[PATCH] OCFS2: The Second Oracle Cluster Filesystem")
> Cc: stable@vger.kernel.org
> Link: https://sashiko.dev/#/patchset/20260806022044.167962-1-zhanxusheng@xiaomi.com
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>  fs/ocfs2/dir.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/dir.c b/fs/ocfs2/dir.c
> index d7fc3cccf2f4..3b606b4c04dd 100644
> --- a/fs/ocfs2/dir.c
> +++ b/fs/ocfs2/dir.c
> @@ -1903,7 +1903,8 @@ static int ocfs2_dir_foreach_blk_el(struct inode *inode,
>  		 * dirent right now.  Scan from the start of the block
>  		 * to make sure. */
>  		if (!inode_eq_iversion(inode, *f_version)) {
> -			for (i = 0; i < sb->s_blocksize && i < offset; ) {
> +			for (i = 0; i + OCFS2_DIR_REC_LEN(1) <= sb->s_blocksize &&
> +			     i < offset;) {
>  				de = (struct ocfs2_dir_entry *) (bh->b_data + i);
>  				/* It's too expensive to do a full
>  				 * dirent test each time round this

It seems we have to guard two things according to sashiko review comments.
1st is to safely read this record's length, and 2nd is make sure the record's
length stay inside the block.

The above targets the 1st, so the 2nd is still missing. e.g.

if (le16_to_cpu(de->rec_len) < OCFS2_DIR_REC_LEN(1)) ||
    i + le16_to_cpu(de->rec_len) > sb->s_blocksize)
	break;

Thanks,
Joseph
