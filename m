Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146F46EC69
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 11:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790593319; cv=none; b=t9riSf9/FffR4CT7wTdFVH5BuO5TWQLTCZ/dqC8YPY1THQPA7TgNiukNhtFlsg5mk/xem5X3Rq7kEtK/7Dr0p3I6pbE5gmLfVlfW7usVOpxwe1ud9Tj6vY+eAdmfO9TnPcdT6B5CVI3TMtlfu56PkWeJKYwnOr/oC6IlyvRSmxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790593319; c=relaxed/simple;
	bh=jkyTYu2joa+N7LW/jLjMCrd80RlV2NlHH6zguWtPxew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srzkBQ0mTaU9MaZj7+1cEEpr9N8gl5glPUQlSbM7qWGxsDj034mezSq9T4FyNiU5/5Y66ZeqIj/robIwSJrGJ1+SrdGi7inZwyOS+CojhIMZhKy3sCXumAtxomnVi/WyaehmL8/sqeKDfATMGrtcsrsIVokcH3dr377cDHm5hjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndx/x6nw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndx/x6nw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDCF1F00893;
	Mon, 28 Sep 2026 11:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790593318;
	bh=ZkSQyWzu7T/0A3a31XNu8vpxdHKsJ4rnNLYcnd0bezA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ndx/x6nwMj46Es9rYHZ9z5o5JqF6jxdKphwEJZh+flA2ah0VkSrN1HPEkvBpTZ55l
	 Ec140TtlDd00Tm8VtLGdh+OYVKZXZ0cixKbTgzq/h0Jrs+rr0ZvEOC8OG3Xkgg9QsN
	 sPsYC2pc+Yqt/UI424ddW2XK70/rrvc1WMUH306WX7q6ii+DiFZaGC8+1oeExOv1le
	 IyMP4ppESpTjASvi8x0OInxnclTaAPXeNrazQgAAnd2ENyXioV7QTp6iRQKOApdZwH
	 WNYK0ElfQrsxviktM5lH9ifaxdewsw+Ij7RF58oCxfzkZWcVw9CfQgdsm+NISW6BNW
	 XNEDMAFhYc2gw==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.ams.internal (Postfix) with ESMTP id 51887198003A;
	Mon, 28 Sep 2026 07:01:53 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 28 Sep 2026 07:01:56 -0400
X-ME-Sender: <xms:IUm6amGRh7ivfHDvq4z-E4J238NnRqeDSKn55_llFW07u2nvIC12gw>
    <xme:IUm6anzTLp0eOfCljLLN7gd438Ibx6XI9YP_osT2WClEWug6PWQZEYIJVekIUzG5l
    Tr-0rptENVwcMoqN7WMkBrhNoGTT2U18ORsCPfW-OmiEc3ZRh8KTZ_i>
X-ME-Received: <xmr:IUm6alm3_1G1yWMrJZAP6YyyEhFHpAW59SEB6sArwbs_1HFnH1XDQTTvpZs>
X-ME-Proxy-Cause: dmFkZTF0aXYM8k99TJSKePzPlV0De8TMZ2NIzeehRzclNPyyK+ntmJJe9xCW5IfIQqBvZb
    4B//Q8aA+dg+pkoM/Hu4RNB1DMHP9RcAheVWJjNEUWscLZxr0DKXN45dL8/VHoXCApqgdv
    9kyt5mrKg/Qv0CHkIWHqHnTGVENgrqiQhzXgV4SFDHQCtMPP0dbQrKV7Ld27CUqdi/llIg
    RPOyyKS2epukrnxpRUIDWnbAA6KMEqtKVW7p8XcJ5GCOI0cRyClu1cuGLZi8XLbNZuRw22
    4LFnKw9fd81HwwydQsLTyoqMNRUkKJLfz8JqZMNAwQBJE82qW8VZnUdBtFke/U1qNBefWu
    WHCWENgAaAF7ORaIKprhr7jnkKBAHlQytYXZ4nF9v7PeatMRQz3kA9MLoHMo1ubFNX0htR
    ZZnUVdeBxwHVo2Q9B2+N3Eh6miyohAYEhBv+2AdOVJT3RUAG90m8Ht+cdygxtl1HsmeT1u
    dMRCTmtfi2+cS/qJp0ga1/cmugkZ3GHpjh0iUJnBpTvAIMXsHbLE0TciO9UV6aYwEnsIC7
    A51LzFfDGTFIHQMkDkOfmf1YIk0tochZfIOTFQ97CEiVXCYXjRhwr3QG4FQYMxJPb2BhM2
    tLlFSoqklbLoC9YaXpInfuYnQIKOYnUc28/ozsBsi8pb+OVTDGPgFXtN/eWw
X-ME-Proxy: <xmx:IUm6auBd3_IhSHMMW3j4FKZja0Mq6HFnH8XR7kq3VggHYchzikfyFg>
    <xmx:IUm6agKxqdn9FF9woV3mgkBZEhkETPfU_LNFx8CsGvUEeAGGUsoXpQ>
    <xmx:IUm6ahwx6SH2NL2nvBSCuoCYvtrA-MntLblDciCkdhYYgjLUBxGdoA>
    <xmx:IUm6akz2-uaDiSQsTbDgrPDCV3AZqJhHwdzK44hNCNp5pwAqq_41GA>
    <xmx:IUm6aj3NRI4ihvxFUzsqZuJuC6btbpULou_EwtGCUY2EM-zl6oWB9zOE>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Sep 2026 07:01:52 -0400 (EDT)
Date: Mon, 28 Sep 2026 12:01:51 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Brian Geffon <bgeffon@google.com>, Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] mm/mremap: fix locked_vm leak by splitting VMA for
 MREMAP_DONTUNMAP
Message-ID: <arpI-wmzRXU5aSOG@thinkstation>
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
> Fixes: e346b3813067 ("mm/mremap: add MREMAP_DONTUNMAP to mremap()")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Makes sense:

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
