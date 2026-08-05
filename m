Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB4B3E558A
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 08:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785919768; cv=none; b=n8vvqE9OT+qf6u/Gw3TOyvMS6hwPYFFyMj3Ga7nXS8hqK/KxvYE6WWcTV8ry41zklD2IsNOQSpadtNoNdrtpwmsJDePrve2z9ZLB8uvKE5/ZumLB46PsAMTFyWTLQ43g4WK7o1v0xiKO0ebXfm2Xz3CS9IJGnRO3UayDYUUH5Pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785919768; c=relaxed/simple;
	bh=T4YE/eGnsv3t/rKH3kRrdoat5725qTujmUDheDsuNX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m05VSPZMTUFszH5YGIFKy5YN+LLw3/ZFs7xcKl+54Q8h39g4MeNUWsmFbuXE0VTq61WmZtwu+LCL90f63iJ9s8/Jw6TKqRCltUTXyHZDvezG6NlJjQP2iM9wIjMHygp27cu6SQQ4Rzc8o2gfE0FKhPHY1KQlE7SkCjdoKpA1c4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GVt7pAXY; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GVt7pAXY"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-47c2ae992beso48214f8f.2
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 01:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785919766; x=1786524566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EfjKHFvdiIekXPyIJtfsuWIiX/n/M+UVlVb3uUnbRMI=;
        b=GVt7pAXYcVnALkngQCIxHoRtHMNxYpJ6w9+UsofZVNHZL4m3Drz1jTc+EyGUeV66w8
         KZLRAbhoXcDh5z27JkfdxJRiIHApw/XsqJR/YbJHyZ8OrdEyoLkfP/IH3FUv2RHt1wrd
         mER2qOyXoJMnhMgwo5QlynFtZm5LJn95dALW/bT1zDGjTbGyl9JpHiKNrLI4SszL6BVq
         lRWEHX/a49iWk9uOtQXGTPvatXF1SXLMmeiqAuZwiwB+ONOo5ILpVYPAs9bWnwLuEtJx
         8GffLULtKOo0SM4AI0pBh5R1UAZI419vAMj0Q5NJobw4Qx5pM1IWL7lpr25cJfOygxLo
         cB9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785919766; x=1786524566;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EfjKHFvdiIekXPyIJtfsuWIiX/n/M+UVlVb3uUnbRMI=;
        b=np4hzMlwEUrpmv1HLX4S0UVYkwak7yk9pTyRKa4h4heyudZXH3RPno8o4V4Il4oLpQ
         lI6ODBb8GQtiha84C2BeCEkHIgjW1ByrmVeK15Vo9h4u7QfxE8acXttdXT7fvEtPcKwQ
         W6JZK6FAKKPEsdzNIfJ2z+tOhGzxLcw/tFfOB6YEtSH1GfaZ/JhdrFzscL4fYFigTbO4
         oYYxtcgVZqGHdPD8R6fKWb6q2vU8lsKig7poYMQ6NQcp8jWc9Xdo4KHluLTW8WvZa5bB
         IMDd4A7pEjlkaE194eTJnqpsXsKpBLuuqPv1+LgGTAOZE8WoNWsqPKlasPiIDGyFA3FF
         WfaQ==
X-Forwarded-Encrypted: i=1; AHgh+RrN2Jxjy6oiQrxIiz7PpEILONUZU4SPyummYm748UL1UMUAkwN9DiwXK55pXMvbGnRieQz8sxs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx13WtQqGgq+e4g9uhO6Edq/V9D8OTRzDAhNvnUs68Zm64hYI/X
	FTjtpl0y6ld6pvbd0+9hfvSE1dKntPkJekVSOqnBWdoRLomQbRExIeq02tu933QmMEQ=
X-Gm-Gg: AR+sD13dt4F2xAq6vbV+HHexpvEAA03nBUQpdUQPF84dWtz1Il0Jc4F9B1axLbE/ug1
	XyoA8dHc+eYdz1EZH5UiQHLVI+nxuH1HsiPqmdfqdlQ0ErFmIRAzTfDpsoutvgauAacXn3dx5Ik
	6zMZwnIi8extMZwDJ6p3gX//6IYvkYtiGpcMGbfekDKhjaI/a3PQoXjIHKd+zAfpq+xWCIfVP6p
	l9wR5vbzi5x7rKgaFva0HrllBQohrHIORDkMMvltGsuNztL6lj7vp8zIZuWZEWQQFJCBTdFgHRu
	bnR7Gl2VtU8nA/1RmgggDVBi5srR3Oy+gd76QdxrG7aM6EhjPsznSPaYQh/MOC0M+MvVuSh/GzT
	+iA5BCrN1GnzMzObTsAFu4UWj92uwT0NwgWLL8V1EDloXqBKBQ+ODFCnJ2sh9qCAMVAldeoQZ5A
	giFKg1+TxNC+3F5uU0pETh6dbo9tBU4f02fKB4ay85jJKciwJZ7VGHaiI2ido=
X-Received: by 2002:a05:600c:1550:b0:493:ad11:6d5c with SMTP id 5b1f17b1804b1-4994e7cf0dcmr26391075e9.4.1785919765638;
        Wed, 05 Aug 2026 01:49:25 -0700 (PDT)
Received: from localhost ([202.127.77.110])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903f5fd0fesm1209890a91.2.2026.08.05.01.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 01:49:24 -0700 (PDT)
Date: Wed, 5 Aug 2026 16:49:19 +0800
From: Heming Zhao <heming.zhao@suse.com>
To: Matthias Goergens <matthias.goergens@gmail.com>
Cc: ocfs2-devel@lists.linux.dev, mark@fasheh.com, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, glass.su@suse.com, akpm@linux-foundation.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] ocfs2: fix cached cluster count after suballocator
 reclaim
Message-ID: <anL1pYKZK8UqYwsI@p15>
References: <20260805070837.3390148-1-matthias.goergens@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805070837.3390148-1-matthias.goergens@gmail.com>

The code looks good to me. However, the commit log needs some revision.

On Wed, Aug 05, 2026 at 03:08:37PM +0800, Matthias Goergens wrote:
> When reclaiming a suballocator block group, first reduce the on-disk
> cluster count by cl_cpg.  The current code then subtracts that new count
> from the old cached count.

The current code then sbtracts that new count (fe->i_clusters) from the old
cached count (OCFS2_I(alloc_inode)->ip_clusters).
> 
> For an allocator with N groups, that leaves the cache at

For an allocator with N block groups, that leaves the cache at
> 
>     N * cl_cpg - (N - 1) * cl_cpg = cl_cpg

     N * cl_cpg - (N * cl_cpg - cl_cpg) = cl_cpg

     i.e.:
      ->ip_clusters -= (fe->i_clusters - cl->cl_cgp)
      => ->ip_clusters equal to cl_cpg
> 
> regardless of N.  This happens to be correct when reclaiming from two
> groups, but undercounts the clusters from three groups onwards.  The

s/groups/block groups/

> incorrect cache value is also used immediately to update i_blocks.
> 
> Assign the updated on-disk count to the cache, matching the allocation and
> inode refresh paths.
> 
> In a QEMU test using a clean 256 MiB OCFS2 image and a 10,000-file
> create/delete workload, the first buggy reclaim left the on-disk and cached

create/delete workload, the first buggy reclaim left the on-disk (fe->i_cluster)
and cached (->ip_clusters)

Thanks,
Heming

> counts at 2048 and 512 clusters respectively; later reclaims underflowed
> the cache.  With this change, the cache matched the on-disk count across
> all four reclaims: 2048, 1536, 1024, and 512 clusters.
> 
> Fixes: 4a54331616b3 ("ocfs2: give ocfs2 the ability to reclaim suballocator free bg")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
> ---
>  fs/ocfs2/suballoc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ocfs2/suballoc.c b/fs/ocfs2/suballoc.c
> index a4a2b87a45fe3..20c3aec6b9873 100644
> --- a/fs/ocfs2/suballoc.c
> +++ b/fs/ocfs2/suballoc.c
> @@ -2759,7 +2759,7 @@ static int _ocfs2_reclaim_suballoc_to_main(handle_t *handle,
>  	fe->i_clusters = cpu_to_le32(tmp_used - le16_to_cpu(cl->cl_cpg));
>  
>  	spin_lock(&OCFS2_I(alloc_inode)->ip_lock);
> -	OCFS2_I(alloc_inode)->ip_clusters -= le32_to_cpu(fe->i_clusters);
> +	OCFS2_I(alloc_inode)->ip_clusters = le32_to_cpu(fe->i_clusters);
>  	fe->i_size = cpu_to_le64(ocfs2_clusters_to_bytes(alloc_inode->i_sb,
>  					     le32_to_cpu(fe->i_clusters)));
>  	spin_unlock(&OCFS2_I(alloc_inode)->ip_lock);
> -- 
> 2.55.0
> 
