Received: from mail-qv2-f42.google.com (mail-qv2-f42.google.com [74.125.230.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02EA52123F
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577422; cv=none; b=bK5zxohlq4o4kB9wn5hQ//rewTwpSAYAsjlol9tbNaq1b0sVdtZMYid8+/X15yJPQ68Q/XiT1sVsGLNWRmvJgWaDsuOPkJPxFAFqwUVRansA8Gk2JuS8z3pvrzPnQxr9KwBWY3Cv9KV8yLyM5XLAgEAIPAs/83Alde1grh8JYCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577422; c=relaxed/simple;
	bh=q9ndVdNv8I6fF/lRjh4YCE5HmLMnihcAbtaTuS3i75M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W72qTaQDOXF+odp3mM9fS1djz2ZqiTEp+CekUtWEK+Ga8pUVn5zOdzYuOM37zA4p737uUft8iIqbOY/it19KgQcqZ88Qvj6uArYL5U9tvtWKufqA/zMiSLwpu2VKqjip+NmFRWzXihba9DTbeWsNOR/oYsHdSftJ0DT4wvSU5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=YD+42Tvc; arc=none smtp.client-ip=74.125.230.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="YD+42Tvc"
Received: by mail-qv2-f42.google.com with SMTP id 6a1803df08f44-90cdfc6db0aso11071336d6.1
        for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1789577406; x=1790182206; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RsW3GrpW0HCe9cpgsGq1CDgI5c4v//i9fXbu19rssIo=;
        b=YD+42Tvc3qcF4oey03iYs3vsIJ6RM0LIOQlv9/rHXjxR1DlptlXoyeXZVlGTppBPYy
         LSo0p70uhqkccTPKiWlEmmGKoHObcjXCQh6RdyVNkQ7f+SVwET9gemHrDJjM/OYDNJO4
         YEsaXakOy6qI/VLH/6h6gMW1LgzqVlFnMZjdmW5kslMAvpqsgIHRX3FA8xekFCBZsRCc
         geC1RXIqUa/AgEXr+0jzZrm8lH/uTaqDE3q1juBrrwZmYivLnOU9K74+SdnviHD25hQW
         dwly66yUiG49EdpBtvTBjEUzZs/t/328SsJ/op5I3ZR/Erh3syKr0t3HlFRTuel3nxQf
         GfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577406; x=1790182206;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RsW3GrpW0HCe9cpgsGq1CDgI5c4v//i9fXbu19rssIo=;
        b=txrllekoPyJg8oo+FUUcVzRZJfhMM0Nj0HGIRA7xvOM5Qcfto9gHGCXTcfh10yaibt
         rtb2BoKvJZzP3+QwDpqknfyBazZglUY4B2xh1S7lK/C4gYZX6B3Yn+VMEcLbM+sQN74i
         eqE8BYpL789BhmJ57uVShx71WbDr+5H/wSRIKk/zn0KVkELun8WGhnvg6XQbpnDmWCgq
         4/zZeeltI71n1SNUEB0iA6i6Sskm/AcwN/ZJhnLYqv7f6PSoM0JB0U+w1/xQHpE/A9SR
         zu1p18YseE7cofoHACfWYF3Dk/2gU63CBnLlVMiaK0iLPdTz01hxPoQ2WEUR3goy743V
         fysg==
X-Forwarded-Encrypted: i=1; AKwUvBy4ED02svBi/ohDRDK+43j4CQtswQBQgwezonP9j0xi2S/FxK5Fe5u6K1IrhO+fuEZKX/EQUSw=@vger.kernel.org
X-Gm-Message-State: AFuF++nJCfVIjEjpxtgmQlXUgCFPXVicPl5ZCMzVSZFIzIbV2O1oPb0C
	id5AOu6r5ejlKOM0/UDTUisMGOsWc5NADFzpP1TXUdckgL7bJm+Kt8EuoNDibR03v5s=
X-Gm-Gg: AYBFou0utvbAvJEnoyeThJVSgb8LZoyVJcRzuTF0YlucDimivp5SRCmlZaVGCk3fc9M
	1XRZ8GtPCC1k86rCAbEkEkAj8bCVAilsfNGjoZBn72HcJDvg8mBZhmGRAFDzZDO7Xyd6Cvc12v9
	/l5yKlPNng0qTNmnoIgyjccbOcOf13Vulm1oVQfwNATpfbW3M4SSCqBiUE9Rudhiq8SRZlY4NYM
	80P2gV4ek4ELNbp19cV10E7B+CLcliPy5CxMdy0dI6at7VfOsmW0Z27oF0bPE0ouF6NtdLUatmt
	Up/llT45SojM1/gC9cbF9glHOr4SeTzgQ8wuUJSDkeiMPaFh6HNPjg885zgriN0r7HE+UEOQ4Lw
	JVb3GU7Kz1XNp+I/dHVf6V3tWan+rsxfLsZLzAKuTRvlsaTt69Sb+BhnWDj3dcQa+8sPfIDvQu5
	IVVT2tWxIqSao3EPhhEQELJuosY7eLSA9OOwKsq7B+t+OmczgIquC0mgxrFURhO71x8FV1qw==
X-Received: by 2002:a05:6214:3c9b:b0:90e:995c:42d2 with SMTP id 6a1803df08f44-9123d72c6c3mr68034436d6.12.1789577405749;
        Wed, 16 Sep 2026 09:50:05 -0700 (PDT)
Received: from localhost ([2603:7001:f100:500:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9123be5fcfasm29739106d6.12.2026.09.16.09.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:50:05 -0700 (PDT)
Date: Wed, 16 Sep 2026 12:50:04 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yuanhe Shu <xiangzao@linux.alibaba.com>
Cc: akpm@linux-foundation.org, vbabka@kernel.org,
	mgorman@techsingularity.net, linux-mm@kvack.org, surenb@google.com,
	mhocko@suse.com, brendan.jackman@linux.dev, ziy@nvidia.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	henry.willard@oracle.com, david@kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: do not boost watermarks in kdump
 capture kernels
Message-ID: <aqrIvPY6iJOJ0mVf@cmpxchg.org>
References: <20260916112545.3707893-1-xiangzao@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260916112545.3707893-1-xiangzao@linux.alibaba.com>

On Wed, Sep 16, 2026 at 07:25:45PM +0800, Yuanhe Shu wrote:
> A watermark boost is not confined to one watermark: wmark_pages() adds
> it to min, low and high alike, so every watermark check sees it,
> including should_reclaim_retry() and the last ditch ALLOC_WMARK_HIGH
> attempt in __alloc_pages_may_oom().  Once the boost exceeds the memory
> still free the allocator gives up and invokes the OOM killer, and a
> capture kernel that is still booting has nothing to kill: the boot
> panics and the vmcore is lost.
> 
> Seen on an arm64 machine with 64K pages, CONFIG_PAGE_BLOCK_MAX_ORDER=10
> (pageblock = 64M) and crashkernel=512M, running a distribution kernel
> based on 7.0.14.  A high order UNMOVABLE allocation fell back to a
> MOVABLE pageblock while the capture kernel was still in do_initcalls():
> 
>   Node 0 DMA free:68096kB boost:65536kB min:68160kB
>   low:68800kB high:69440kB managed:479168kB
>   Out of memory and no killable processes...
>   Kernel panic - not syncing: System is deadlocked on memory
> 
> The zone was not short of memory.  Subtracting the boost gives
> min:2624kB low:3264kB high:3904kB, so the 68096kB still free sat 17
> times above the high watermark and the allocator would not even have
> entered its slow path.  The boost supplied 65536kB of the 68160kB min
> and by itself put the zone 64kB under water.  It is that large because
> boost_watermark() clamps it with max(pageblock_nr_pages, max_boost);
> watermark_boost_factor alone would have allowed 5824kB.
> 
> Commit 14f69140ff9c ("mm: limit boost_watermark on small zones") already
> tried to protect capture kernels, but it infers them from the zone size
> and skips the boost only below four pageblocks.  arm64 64K pageblocks
> were 512M then, so the guard reached zones up to 2G;
> CONFIG_PAGE_BLOCK_MAX_ORDER can cap them at 64M, which shrinks the guard
> to zones under 256M and lets this 468M zone through.
> 
> kdump is a property of the kernel, not of the zone, so test for it
> directly.  A capture kernel exits within seconds and never uses the
> fragmentation avoidance the boost buys.  Normal kernels are unaffected:
> the size based check still covers their genuinely tiny zones.
> 
> Passing sysctl.vm.watermark_boost_factor=0 to the capture kernel does
> not cover this window: sysctl.* parameters are written through procfs
> by do_sysctl_args(), which runs after do_initcalls() where the panic
> above happened, and watermark_boost_factor has no early_param of its
> own.
> 
> Fixes: 1c30844d2dfe ("mm: reclaim small amounts of memory when an external fragmentation event occurs")
> Cc: stable@vger.kernel.org # v5.0
> Cc: Henry Willard <henry.willard@oracle.com>
> Cc: David Hildenbrand <david@kernel.org>
> Signed-off-by: Yuanhe Shu <xiangzao@linux.alibaba.com>

Reviewed-by: Johannes Weiner <hannes@cmpxchg.org>
