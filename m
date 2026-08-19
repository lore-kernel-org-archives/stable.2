Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA0E35DA47;
	Wed, 19 Aug 2026 01:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787103850; cv=none; b=GT2rNgeGeHOLei/iqkVPEhazAdhb6n9iB00EqLox+1XKISq7dSBifSPMHXRai8izfgvgg5KSao87o9R1vrXPOk+GLxboKudJNsAptDR0RtOl7Ft0TDdhGYQXboBLyVvJ7SqVjZPJpJhS7UykKuNsYY6yZGrjM8dbsIqbbzVrzOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787103850; c=relaxed/simple;
	bh=qmaJO1U7G6fzU5JnOS8umC6O3o431iLqMaPw0Ia0zV8=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=GQlu+7wqkswRM+U4B+ukKotCDatQvPB46boONzUQsPXeqE6V75ufefMDADUYiMIAIplC4c5Bg2T/xUD4akRbbb9ThBLyAj9RkeNUwpluU90ViB7jjMGV2q8orqQQ1dWupwbkJSOgeZNLrkwkBy7efjrqvm1Qvx0r1isXBINF3kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FYZdizJ6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FYZdizJ6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E5961F000E9;
	Wed, 19 Aug 2026 01:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787103849;
	bh=y1r7r1ef+XaZdtVHqxWc3yLM/RtI5eF6GflDDDAKlSs=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To;
	b=FYZdizJ6iBbR7KHKgktjZMXk40APAX0sPCEi3LxnKXveCgYS7ZvyQEjEMOPiVg7ng
	 xx1d7iSkI6fDqK12bvn9xZrv7wubNCVZ4NZ6EipmmyfDoVCPF3a3TNE7yLXxvv3NS2
	 Y0EO/yHlZJPwQiIjpswpikTzktRBu9IZc0da6srmxRXmztgf0he4slW4zXeAfgFhdH
	 AYQ2lrIOLxHeYvW5rL+dHZsatTAAAAhPsmVH/06lC7OxrU6GSBJAfxqchlhNf93wsb
	 q11gBfIoHZbjyBvUaDB7UilRcIBwQXRt9W5z5twKCyod8WpAyM6EZ1iXq0HzpfC/CL
	 vj3r61H5Pr+OQ==
Message-ID: <8f85cf1e-fcc2-431e-b005-59a8ca6f5b8e@kernel.org>
Date: Wed, 19 Aug 2026 09:44:05 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: chao@kernel.org, Sunmin Jeong <s_min.jeong@samsung.com>,
 Sungjong Seo <sj1557.seo@samsung.com>,
 Yeongjin Gil <youngjin.gil@samsung.com>, Yunji Kang
 <yunji0.kang@samsung.com>, zhanxusheng@xiaomi.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] f2fs: fix i_size when pinned fallocate partially fails
To: Zhan Xusheng <zhanxusheng1024@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20260818145535.449055-1-zhanxusheng@xiaomi.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20260818145535.449055-1-zhanxusheng@xiaomi.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/18/26 22:55, Zhan Xusheng wrote:
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
> It needs a start offset that is not section aligned plus a fallocate that
> hits ENOSPC partway, so the error path runs with expanded > 0.  On an
> 80 MiB image with 2 MiB sections:
> 
>   truncate -s 80M img
>   mkfs.f2fs -s 1 -f img
>   mount -o loop img /mnt
>   touch /mnt/pinned
>   f2fs_io pinfile set /mnt/pinned
>   # 2093056 = block 511, so pg_start % sec_blks = 511
>   f2fs_io fallocate 0 2093056 536870912 /mnt/pinned
>   stat -c %s /mnt/pinned
>   filefrag -v /mnt/pinned
> 
> The last extent ends at block 10737 either way.  Before, i_size is
> 46075904, block 11249, so 511 blocks of it were never allocated, and
> filefrag does not mark the last extent eof.  After, i_size is 43982848,
> block 10738, and eof is back.  A kernel from before that commit also
> shows no overshoot.
> 
> Keep @pg_start pointing at where allocation actually begins.
> 
> Fixes: 4275b59673eb ("f2fs: fix to round down start offset of fallocate for pin file")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
