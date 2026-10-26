Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793031211;
	b=pWXajyT7wgKGcy9XcWzTxa1AOET5RRw0dsnK4fbdRYj8uEt2zco+9mZil3IBaH+PEc/9
	 vNy7D5/pYWncXVPHZng1CwAywcT7sbbWDKMlbjgvn170935an5zOQf+CE4XdsblnGv4ST
	 oSDttOnK0PFb3oWM1eu+C2JDZXsSXJKnqTTEZJJ31g41wAy3ksySoYNrfZcEyKZnWpvX3
	 5PI/XUl6GWx9zy4LQCL+sZEfkTqgEw5gjLGq7Wwg/01Q6LjekJOjHB/lnQjVV5CMGGufe
	 zndgpUOLfBT2cg0SZwQi0A46fSrHFqoLKydL/KD/xumk4f9K9Sl3gYqMj5mkva3Y6Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793031211;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=SuEMA61PD8ypCGtu9RwAMCLG5YHaMT/lSDKBxP64Lpw=;
	b=g97gK1EHraqXo+om3t15TmLEDGvToIGi0KMYTAO/PYayDGkggVvScm4ChlZG+wYgMiUe
	 ME5M+YBb6tNkzmGxqHGOXWTWoVd4V4sqCGqiNfnbMYZ9e5UfzcfjIxDeS8Bar1u83zvbs
	 MqlwJZyFtbBD9dnUKfB2PkGKYYUWjfUt5/EX4xADhllLrb9Ak/YGf+VKEcVAMYyBQk+dm
	 qsk38O0v+KPSLZxi1w/kb/JTjEJNxAQljsT+Z6HwEO9z1nVI2rrOQd404kCdKk3sHUE88
	 +ZopjXjMoU3jmHhitVSQWN5AyhDUYzWednHfQRWrV/4dKfbwqUolTRD/m6eHPAGZtOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=shutemov.name;
	spf=pass smtp.mailfrom=shutemov.name;
	dkim=pass header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=oJmC6Xsf;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Cb1maXTk;
	arc=none smtp.remote-ip=103.168.172.142
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE405606A31E
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 16:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE405606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shutemov.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shutemov.name header.i=@shutemov.name header.a=rsa-sha256 header.s=fm1 header.b=oJmC6Xsf;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=Cb1maXTk
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailflow.phl.internal (Postfix) with ESMTP id 280901380089
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 12:13:30 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 26 Oct 2026 12:13:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1793031209; x=
	1793038409; bh=SuEMA61PD8ypCGtu9RwAMCLG5YHaMT/lSDKBxP64Lpw=; b=o
	JmC6Xsfow1yjAZvNP33bJMXf5QY+i5XLHravTrgfuUCsaWbIpBFuTAyiBGRWfzjV
	1dlqnm623/dOTK6ZeM9oXZ012Glr2ZzTSWB5cbMUYaQNOhfvSb+br37HHzad7Mew
	YSoqZ1bQIt+/HrK86GlC0l8ihnxPo++AyQVR/CL6z4c4B7H/j6hEts7HjWqmCYi6
	Dij5oR+kOfo7I4m9b0H0RIgf1Y8DVcG4zMb0gtKvFxUiCssnLsTAUw7wBN8CSXun
	Rv27Eex5wPm0gULIAO7uqy45Bl7M2JvPMmURWBRR4YgwcAZFygUuOmXf3GL5fwVp
	HGLRFuIjafJGovqd/yD5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793031209; x=1793038409; bh=SuEMA61PD8ypCGtu9RwAMCLG5YHaMT/lSDK
	BxP64Lpw=; b=Cb1maXTkRxdSrJDSeCUZhRNJVEOAhC0nIyYPlubphV/2InsX1vj
	CKga3SeUmjNJb6ZRxYxf7o75fVEESWgnYk2DFP2D0JHiEZA07AN2P0/b9PYWyKoW
	5ZS83JtRizqFf7/rbcjXl2BmOFBs7RweB/9A4QBfclyL+Y6NQQWXVl+k58gwZPj6
	oyg8vo+1lkXqSiEFI1opSznaGLXkVzNf3HVhXZzqF5WLE+2w4WTptzclGxpCACJC
	fUhhD1p2/DXENyImJ9kxipMuSKZFpOPZZBl6O7q6sLLHyid/Xyr9Vk8r0K6xBsrV
	fripqVEVRosLWlqDqD1IQIDUzY5kxMZm0SA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=shutemov.name a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793031209; d=shutemov.name;
	mf=PGtpcmlsbEBzaHV0ZW1vdi5uYW1lPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:MWQJnXqHvBGKEqlF9+YcTm0xStSTzytjTmhyRib3imB36AN
	dBUoYsTvv0ICTogyd6dMX1IF+KzDHm4Ixm9WopSlQ/a+HJwtyRsq2Ki9yzLP4M2q
	n26DgL2UqWdmItq+Yi+g24RKkpo8FUqcCnCdBZZrNZa9GMT1pQpUbFq4Zvovic+d
	6ONO3wjMLAWNbK7jOH4aNiqx/rnQ7aAKNLQ/wEulHmuA6OAN2e9kRUfPsWNUSq4s
	y22yTgxIC86PeONqgd7bxjmRFzulGHQ/k+lRGofRmnHJPsDbKPH0X0pFqs4Ms3Ci
	8znOK01I0wC3SpDzxDia+xqkuYwSPyxH19h0HlA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:P9tqkjtr7xJ0LZI83z6SZ6DETyMxibEyw+1uHfVj6Zg=:JLuqQrk98leSnt6vv9Cw5t0oqfF/5BKxz1YFDI+HSBc=;
X-ME-Sender: <xms:J3zfalgYzmFLkjivWEpvSfZqG2OoqNdinomxBIXdw0khYzSPk8Ia0w>
    <xme:J3zfagu-Pz_FO68c6gFQ9AsJDcOloRLceN5gDhUDkwHZKXCfw5XH0j887loyEWRuM
    9xqnPBm-XR6YUT2AMrrN_APFTdTp27asP8TrpCG2-u7PUZSB0eEkD-w>
X-ME-Received: <xmr:J3zfavSa0XBfO4-iC9Ee1B3PxoCm5kctj88IxDRhA7pPrpGJrK-uOmVtTd4>
X-ME-Proxy-Cause: dmFkZTGBB2cNjuELTs67fGgvkDQEDSU8qux6+8nxtLoE35+WVs+aWAZCsMVW4zWZvl//3o
    d+Nts1yMBYhfz0A2pBdaxzFlZZaoafSDu63LVpeb+vxy9Vwm87V8WMyFLNk7rWQLoUa5/G
    k0yzKLjsyVStCe8yZI9HHv7vy5dspIr4hypntb/PIB9H4GNYku4+EG1lzv/wuo8fa87di9
    +CF8ONEHEzQPPZF0ighPmGYTs5ZHVZOXemZ2aI7j2mAiAgvuUBkiiwxC2GgD8XiB+Phzk7
    kD0l7xy/HxT+YKPa/yncQBqQq8O7UuH9+4cIXrnIxtjuWoj2OdbkHw4f/dvsCiGqt0GPJ6
    5XToz1kkUWDtBnx/w21CqNEaW1qZCvZGci3D50ojvkPRVd8HZEg01/INknz4HMFlhsZqAX
    BgPwRhczFxR3vNXil2moy+KyOZlL14BR/CppwtBzFCXgKpreiHrIjMKpLWLmW0aV/9ND7x
    o2+CZ0TyrN34nBMGfM1olHAEhI2/mxv3mkAWJHEz8epr0WELvKEStcO2gFrRIN1FQC7sPV
    RVysmrQ+pAibpu010ENwev3dXzBi0OYRiVIY3IoRKhCaAuO2k5glaEdwhGn+EUxT/nggPe
    OKKPMnGTGlBnPIt3aeIzpw/5QeNySULr6bW8Ff0Rm+pBvg06Se3/TBr3MdOw
X-ME-Proxy: <xmx:J3zfaq5Pa-KToeTPK8EsXreG0-ZZRQpQfP5oche3lz2EtpVZb99A5g>
    <xmx:J3zfamjKiP0dGK1Zh6_Z6YQcsHArXWREOXYSfXPzaUYkwyJfx7b1CA>
    <xmx:J3zfattvMyNG8zSYSZXeVAfaFOviFi2vceffpzvUOZP_SnZ6KiqLFA>
    <xmx:J3zfaii39xyfykCc74-fjNwcC1MJZwle20cXhV-3PTdJ2RtNOAXukg>
    <xmx:KXzfahsomsDyKod-euTcJeG0g_T_Ta9KwojHvoPH_natJJqeuGKu88An>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 12:13:26 -0400 (EDT)
Date: Mon, 26 Oct 2026 16:13:25 +0000
From: Kiryl Shutsemau <kirill@shutemov.name>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Gregory Price <gourry@gourry.net>, Zi Yan <ziy@nvidia.com>, Joshua Hahn <joshua.hahnjy@gmail.com>, 
	Rakie Kim <rakie.kim@sk.com>, Ying Huang <ying.huang@linux.alibaba.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Vladimir Davydov <vdavydov.dev@gmail.com>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Lukas Czerner <lczerner@redhat.com>, 
	Carlos Maiolino <cmaiolino@redhat.com>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Daniel Verkamp <dverkamp@chromium.org>, Jeff Xu <jeffxu@google.com>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, David Stevens <stevensd@chromium.org>, 
	"Matthew Wilcox (Oracle)" <willy@infradead.org>, William Kucharski <william.kucharski@oracle.com>, 
	Chris Li <chrisl@kernel.org>, Kairui Song <kasong@tencent.com>, Nhat Pham <nphamcs@gmail.com>, 
	Miaohe Lin <linmiaohe@huawei.com>, Naoya Horiguchi <nao.horiguchi@gmail.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Subject: Re: [PATCH 06/16] mm/shmem: hold off eviction in shmem_writeout()
Message-ID: <at97dZY434e1maVl@thinkstation>
References: <20261026-fixes_shmem-v1-0-703206d5fa0c@kernel.org>
 <20261026-fixes_shmem-v1-6-703206d5fa0c@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261026-fixes_shmem-v1-6-703206d5fa0c@kernel.org>

On Mon, Oct 26, 2026 at 10:40:39AM +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Once shmem_writeout() has moved the folio from the page cache to the
> swap cache, the folio lock no longer keeps the inode alive: truncation
> and eviction find a swap entry, free it and do not wait for anybody.
> That did not matter as long as swap_writeout() was the last thing the
> function did.  But since it puts the folio back when swap_writeout()
> returns AOP_WRITEPAGE_ACTIVATE, it uses the mapping and the inode
> afterwards:
> 
>   reclaim                               last close of an unlinked file
>   shmem_writeout()
>     shmem_delete_from_page_cache()
>     swap_writeout()
>       zswap_store() fails               shmem_evict_inode()
>       writeback is disabled               shmem_truncate_range()
>       return AOP_WRITEPAGE_ACTIVATE         shmem_free_swap()
>                                         destroy_inode()
>                                         ... RCU grace period, freed
>     shmem_add_to_page_cache(mapping)
>       xas_lock_irq()            <- use after free
> 
> swap_writeout() behaves that way if zswap is enabled, cannot take the
> folio and the memcg or one of its ancestors has memory.zswap.writeback
> set to 0.
> 
> shmem_unuse() already added infrastructure to deal with that.
> Reuse info->stop_eviction to protect the inode during writeout. Increment
> it before removing the folio from the page cache, and decrement it after
> swap_writeout() and any attempted reinsertion and inode accounting.
> In shmem_evict_inode(), wait for the counter to reach zero even if
> swapoff has already removed the inode from the swap list. Add some helpers
> to make the code easier to digest.
> 
> Fix generated by an LLM and sent by Josef Bacik in private.
> 
> Fixes: 6344a6d9ce13 ("mm/shmem: writeout free swap if swap_writeout() reactivates")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: code cleanups; improve description ]
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

->stop_eviction is ugly, but, oh, well...

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
