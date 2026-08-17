Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020D71096F;
	Mon, 17 Aug 2026 03:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786936367; cv=none; b=piLV3AEY/6In+BthlmbzeCST0Pv6O1e8VQNMkTTzCdX05KpnDp3qbbBN8AshSdBpIZXZ8zZ35c+LLrSycrQuYNBkN54G8g/w017i0E6qMrbvOJp/j6bRAR1kWa6u1xSej/tFVZVx/md/V5NkPAYphYu88gyAEx6sY3iYzntRvoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786936367; c=relaxed/simple;
	bh=Q8JiJccHlNzc3kl5wzqlkkvQhs58awE5AovvFLYsIRE=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kjahWF5utRMYp0pXDVveZn2YEZzPbGQ2jbexD+mk29LeW8p80r+/P9sx+YePe0XbXDtNfgd8+sMch1h1+FdfBMlG4uUXtEF5G5c+bJaE3aw7mdLbbzrg6+ZHIVXarw6tDlFmB2KARQBswaMPHnGAw7DJxLKomuTSi8JH6cWUJFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bAjkpPIm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bAjkpPIm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C2F71F000E9;
	Mon, 17 Aug 2026 03:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786936365;
	bh=BRFbMgM0fP8bN6SVHVyTTETj/PNKQbV2eBDfSpHMY3k=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=bAjkpPImAXeRH3XQpe5pSLpBRxy5Zyy029ebaTKXlCEkA4by8khQMPLjPa741g4ra
	 n+bAbiLKy8CDO0fHT4UVO1HquwC3pKrj4h+PwzOBn4KNdV9vhTh2cN3ww2/6ufDjfi
	 FV+K+GWZZ1KPpHmaK5XCcbuTDh46nLyhAkrlnd2rrPewRV1SPuAxsfGEcUA43pSoBr
	 C9l1eX5+r1fmDmbOWOIXyPlQ1LgXLYhKq4fn+5DLeLFda2kzSUTGw6ag4nrh1szhB7
	 AlSw/VDRPyzgnHfCHWvmaCAsZIS3kMVDUvxdb5zYl7uBlurkWf1GtTg/rJbQ6iEm79
	 C0knKfK+60C/w==
Message-ID: <c3a4a131-4a97-4227-8968-03fcd491c0a4@kernel.org>
Date: Mon, 17 Aug 2026 11:12:41 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Sungjong Seo <sj1557.seo@samsung.com>,
 Yeongjin Gil <youngjin.gil@samsung.com>, Yunji Kang
 <yunji0.kang@samsung.com>, zhanxusheng@xiaomi.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] f2fs: fix i_size when pinned fallocate partially fails
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Jaegeuk Kim
 <jaegeuk@kernel.org>, Sunmin Jeong <s_min.jeong@samsung.com>
References: <20260817022723.3324123-1-zhanxusheng@xiaomi.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260817022723.3324123-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/17/26 10:27, Zhan Xusheng wrote:
> From: Zhan Xusheng <zhanxusheng1024@gmail.com>
> 
> From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> 
> Commit 4275b59673eb ("f2fs: fix to round down start offset of fallocate
> for pin file") moved the allocation loop's start down to a section
> boundary, but the error path still converts @expanded against @pg_start,
> which holds the unrounded start.
> 
> @pg_start exists for that conversion: commit 88f2cfc5fa90 ("f2fs: fix to
> update last i_size if fallocate partially succeeds") added it as an
> immutable base because map.m_lblk moves every round.  Each round now maps
> exactly sec_blks blocks starting from rounddown(pg_start, sec_blks), so
> pg_start + expanded overshoots the last allocated block by
> pg_start % sec_blks, and a partial failure leaves i_size covering a tail
> that was never allocated.  Nothing corrects that afterwards either, since
> file_dont_truncate() has already cleared FADVISE_TRUNC_BIT.
> 
> Keep @pg_start pointing at where allocation actually begins.

Hi Xuesheng,

Can you please provide a reproducer?

Thanks,

> 
> Fixes: 4275b59673eb ("f2fs: fix to round down start offset of fallocate for pin file")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> ---
>   fs/f2fs/file.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4b52c56d71f0..cc0d2b8c4684 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1919,8 +1919,9 @@ static int f2fs_expand_inode_data(struct inode *inode, loff_t offset,
>   		block_t sec_len;
>   
>   		if (map.m_lblk % sec_blks) {
> -			map.m_lblk = rounddown(map.m_lblk, sec_blks);
> -			map.m_len = pg_end - map.m_lblk;
> +			pg_start = rounddown(map.m_lblk, sec_blks);
> +			map.m_lblk = pg_start;
> +			map.m_len = pg_end - pg_start;
>   			if (off_end)
>   				map.m_len++;
>   		}

