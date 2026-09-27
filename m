Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62174379EF5
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 15:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521619; cv=none; b=XtYhT8y7uqpSrvZWKanN1U36ZGbRqaTg5yW84EsFyMSUl0EfXYQyZLxoeHczqqVLyAsOZQCHtIS7G8z/w13CADdH/ZZzp5SbE643WKjVTLwb+gt/S+81Ei2RS90XeGpCXxato/81k0K1/qzwb5v+QzGKVeTDg4zz5BWSW3xGu8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521619; c=relaxed/simple;
	bh=ROvVLsAWWZxTQsLfqClfhbwIw0ODqKrmuaWsIVnaKbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iDy2NC1Gj/xrrjUGd62KP9fxtHPIcHtvM3JG7zsWhHe+kgBpbpzz0oojDAqQyJRvNppIp7+rPSsLTUng889MPADJK9q+VEoWMgnSTywFywgkIQoth1NGQBmrIYpAqoYLtjj7P+ycA4r7qL/CJKfL1yj8bv5JKbcikoOQK2itNpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INjnGC/q; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INjnGC/q"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso1775164f8f.0
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 08:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790521616; x=1791126416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CrMFIXOrRMNN8CamXouNMnZGLVuoBTeO83yFUevJuik=;
        b=INjnGC/qXsOUC1/3/1t0+elj0LKt1D/0oqs4/KHJDXkgWvCbSlS9yYurNIfiumZygK
         EL6orVHaOwP6Aymbnu+AsDk+0b62l3zgggUfrTENVQxNTEprhOdfEYvCGDyNgPqmBPzw
         OP2EcR1MzjmDut27XlMAeawIt2z+vR4+r59SywQfuCDyMd+GZIYFt8NBlMrKcaSeYA7e
         EIM9tpp8lXp9NHAdfn63LTkoTrUlTw87rCd/Q59Pcj4+tS3OaUkqqt0HPG7kgkdYkBim
         D44h1c0n4VlgrNfblFwxg8tRVuDEU4ZCzYwuHuUvu85BVqYJDhiGIfxFFWshKz8J0TJ0
         AxNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790521616; x=1791126416;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CrMFIXOrRMNN8CamXouNMnZGLVuoBTeO83yFUevJuik=;
        b=bHJq8P2Y3S2mc4Hic0BBCDjgeUDgYjKtLrmi3xoYPkK1+wxgMs58Stf+jhxWzM89rF
         3rRCffI6+BurfIUtDGiAeCemUwu7Rwqh/Qti98ixZf0kNRNLY00QD6/2mBxxbXBQ9UIj
         QHTQ38PDUBUA8iRsKao5vYS2jgqB/q/siOkq9zKxmx3ftaJ/cYj7Qfish08PY3SRkrOo
         9IrHyvMFn2L3iKfK1mv2IRfu907v4LJadZlzhuNI4r+QGgRodXrUb+WesiCDW1c32XWN
         35hm5kfFitUmWU2qhvbMFoqc3eicQ2M7h59uumHaYl8p8GyZhrgXyUfhSbNfNpb7wPPm
         lHSg==
X-Forwarded-Encrypted: i=1; AKwUvBxkj8v9DgiD8JiHij/yrb+xVpHsCo/IF6DlMB8BNZ1lJKaSiiVxYqP1EWemPM7fzdW0QfRM+Vk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIcZ3UUlahx8FWEvCfBexhUkXcgYE+ANvd7IDPo2A/3tXoMelg/
	VggQvk62ikrq5wDm2JXGj9K8PEnHb6iNNcLcvoKf1oQdBQkQZqpXzWielIH1YH3kCIU=
X-Gm-Gg: AYBFou2GM9aiNifGIBDgEnzn8fCJldkOs2vDXzglAppijiQBcsCyCX9V9KNbFd0Eaj/
	iOFvrGkuS3puAoEpDGEaugmlL9sq3UKLDKhT4nJWBlfZwUzg+97TcaJRdvOYnzAg7TY4d1d/y0/
	/JasyKTsz5yjtRBwOx5oFtdoKdKACd9Hwk0NvF9oFnNwBB27NUfoYoyrXbQ9jRz6F+o9s80XxzA
	/wiFRkwRwLSMyJ3RjiWU+niPysTkJYPmngPElPo2ejS3i3lYwPeWfTQHcbDArzPYGP68TuGnaW1
	2yjjzDojHGrIckoQV9bg8HkR/zEip3ZESyGXewYe2w6L2bQ8JtaKYG6Ng/TCV7fjcLEzV+zVleC
	+BCu5UBwYo/vF9DvqKzKsh36sZxH38vHO5u7hhgZv3WX32KgwfbX+h+Gpc73Bnv8gJ0dx4dZDOZ
	1uskTi6u1odK1Q4IwVJtPJ6LFKHe/JYRGpQ+7Td4Bn/7AefnnweC/GHX3oHdSjMTjMhAsOMA==
X-Received: by 2002:a5d:5f45:0:b0:487:2347:817 with SMTP id ffacd0b85a97d-48872abc804mr19369239f8f.33.1790521616280;
        Sun, 27 Sep 2026 08:06:56 -0700 (PDT)
Received: from gmail.com ([83.231.69.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm20467465f8f.9.2026.09.27.08.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 08:06:54 -0700 (PDT)
Date: Sun, 27 Sep 2026 17:06:52 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/mremap: fix locked_vm leak by splitting VMA for
 MREMAP_DONTUNMAP
Message-ID: <arkuBw_l6iL-VLuC@gmail.com>
References: <20260920-fix-dontunmap-partial-self-merge-v1-0-6ffb556f8f8b@kernel.org>
 <20260920-fix-dontunmap-partial-self-merge-v1-2-6ffb556f8f8b@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260920-fix-dontunmap-partial-self-merge-v1-2-6ffb556f8f8b@kernel.org>

On Sun, Sep 20, 2026 at 03:13:11PM +0100, Lorenzo Stoakes (ARM) wrote:
> The MREMAP_DONTUNMAP feature is highly unusual in that it permits mremap()
> operations that keep the original VMA in place.
>
> Historically this has led to a lot of bugs where non-obvious interactions
> occur between existing mremap() operations and the original VMA.
>
> Fix another of these - partial copies.
>
> The long-standing mremap() partial VMA logic has the baked-in assumption
> that the originating VMA is unmapped and thus moved.
>
> However MREMAP_DONTUNMAP defeats this by performing a partial copy
> instead since it keeps the source VMA around.
>
> An mremap(..., MREMAP_DONTUNMAP) operation disallows resizing of the VMA,
> but the operation can be performed partially:
>
>                            |-----------------|
>                            |                 |
>                            |                 v
>                         <------>          <------>
>                         .new_sz.           new_sz
>                      |--.------.--|       |------|
>                      |  .source.  |       | dest |
>                      |--.------.--|       |------|
>                      <------------>
>                          old_sz
>
> The page tables in the specified range are moved, but the original VMA is
> kept intact.
>
> This interacts poorly with mlock()'d VMAs, as the VMA_LOCKED_BIT flag is
> cleared for the entire source VMA and set for the entire destination VMA.
>
> This results in an mm->locked_vm leak as the change is therefore not
> accounted correctly.
>
> The clear solution here is to make the portion of the source VMA which is
> mremap()'d distinct from the rest of it, a.k.a. split it.
>
> Therefore resolve this issue by splitting it ahead of the rest of the
> mremap() operation.
>
> In order to make this change re-expose split_vma() in vma.h for
> CONFIG_MMU (nommu doesn't compile mremap.c and uses a static helper
> instead).
>
> A quick search of how MREMAP_DONTUNMAP is used in the wild suggests that
> the partial case is either unused or rarely used, so this should not result
> in unreasonable VMA proliferation.
>
> Since this makes every mremap() MREMAP_DONTUNMAP operation operate across
> an entire, distinct, VMA, also eliminate now-redundant code checking for
> this in dontunmap_complete().
>
> Finally, update the sys_map_count check to account for this case.
>

this also LGTM.


Reviewed-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>

--
cheers,
jose a. p-a
