Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253011;
	b=HLBmZ1t3JjobUWUxNQf7UHjp+/D86QvpfxNeTu234l8JPc7yAA195wS8KOIqiJajxFFk
	 EkNi/XzN8dKOSvi9H3UpzNEbLBB421jEZZjvS7MBdULIMSooEwVf53rQMXsCL/KwDeHjY
	 VevKUXEcGERr7w7PCaS3lg2F5gcCMmEvi6JKsjzipcbUJTXokTVDStLyeScFtrC1hsyXj
	 Uq+DwAE0gCZXL9la81suj8hx6y0qF4v1w2ga9Np2CdDjrDydIzhB1KE4U293yteT3gOHd
	 jn9lfT2WEaiAb16qdQ8Tqav1VNjJc3044neEBQwo+MtWtQtlFco2jfDwAad2y7ZI71g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253011;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:MIME-Version:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Report:X-Spam-Score:
	 X-Spam-Bar:X-Rspamd-Score:X-Rspamd-Action:X-Rspamd-Bar;
	bh=lHNvfOdzDYvflZZwQyDfJT5woa7wvoLZDtOmJUj4Za0=;
	b=yr+GM/ZNXYL1OPhocR+SbFUaqlg0yq0aQMlIAL8mQq4GZJ2GTa6/G3FT9e1VQ/zcwbHJ
	 66tsXoBWBKOScBPnCmL1e2O8LPneIrpzH0/YSWtDHukx3GakZQU6E9KiryrIU6JQkxepg
	 XoKtC0+EDjIYNhUPWTe7eEtWgq8bkb0lnnUNivMo6EAzpy911dn5WrFkxQCyWumWBrp5X
	 NGxexuSqcSCobeNuGlnypldmdhy8tWQBxMYXYCSgiXJG0mLsjjcWPBRMF6kdpWUANwanC
	 pq0ZISc1hPHNprUNOcNIAhLHvxYlwBQoCle9stDzcKhIVO+1GKJQIrDC5PtF2P5/vZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=cCEHTs7S;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B237606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:36:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B237606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=cCEHTs7S
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=lHNvfOdzDYvflZZwQyDfJT5woa7wvoLZDtOmJUj4Za0=; t=1794253010; x=2109613010; 
	b=cCEHTs7SOKNwAL1hcCF/0FaPqivWWBp3YBIozueYkEe1Un82ppxIJbmcsR5iZ+MM9uyXeeykFWj
	JTN9jJd4brXAGC2n8T7QjJWQ+22wz/auFJdO0jMZSoeQbtvTB0C3Kej3ODWxoVe/sdsTZWSnlk5yr
	jDfWqEmivALGBKABNQIv/8WN4Ze+sXtfbzFIxUcamu7I5z3Yf/LtqBA5lclIBI8FNjXY8b7jqHkun
	I9IAACXt/SZb4VSbvgPeLOitOHKGltcqzZA7M14TmYlCLt7h4vFYUUpDHejaUbS0zH+3Gwqw0btiW
	lQXLxkXDdLsy1OTgTq6UMUYTNOW2ANpfYJsw==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xQVAe-007cRa-45; Mon, 09 Nov 2026 20:36:48 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1xQVAd-00000005Gc5-111S;
	Mon, 09 Nov 2026 20:36:48 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <mfo@igalia.com>)
	id 1xQVAd-0000000GRqv-0Nyv;
	Mon, 09 Nov 2026 20:36:47 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 09 Nov 2026 16:36:47 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: Hamid Nassiby <hamid.nassiby@nokia.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Ran Xiaokai <ran.xiaokai@zte.com.cn>,
 ranxiaokai627@163.com, Andrew Morton <akpm@linux-foundation.org>, Vlastimil
 Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Oscar Salvador
 <osalvador@suse.de>, linux-mm@kvack.org
Subject: Re: [PATCH 6.12.y] Revert "mm/page_owner: fix memory leak in
 page_owner_stack_fops->release()"
In-Reply-To: <20261109141509.2880440-1-hamid.nassiby@nokia.com>
References: <20261109141509.2880440-1-hamid.nassiby@nokia.com>
Message-ID: <3443f5711f170336778377c744ae84a1@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-4.9, Tests=ALL_TRUSTED=-3,BAYES_00=-1.9,KAM_DMARC_STATUS=0.007
X-Spam-Score: -48
X-Spam-Bar: ----
X-Rspamd-Score: -0.8
X-Rspamd-Action: no action
X-Rspamd-Bar: /

On 2026-11-09 11:15, Hamid Nassiby wrote:
> This reverts commit 7fbea59f737eb3a47368ee5253e708cb342faf8b, which is
> commit a76a5ae2c6c6 upstream.

Thanks for handling this and submitting a fix.

Reviewed-by: Mauricio Faria de Oliveira <mfo@igalia.com>
Tested-by: Mauricio Faria de Oliveira <mfo@igalia.com>

cheers,

> 
> The upstream change is only correct on top of commit 156c0c5d1463
> ("mm/page_owner: introduce struct stack_print_ctx"), which first appeared
> in v6.19. That commit makes page_owner_stack_open() allocate a struct
> stack_print_ctx through seq_open_private() and moves the stack_list
> cursor into it, so ->release() must free it with seq_release_private().
> 6.12 does not have that commit: page_owner_stack_open() passes a size of 0
> to seq_open_private(), so there is nothing to leak, and
> stack_start()/stack_next() store the current struct stack node directly
> in m->private.
> 
> The upstream commit was backported because it is tagged for stable and
> carries a Fixes tag for 765973a09803 ("mm,page_owner: display all stacks
> and their count"), but the leak it fixes only exists since 156c0c5d1463.
> 
> seq_release_private() kfree()s m->private. Closing show_stacks before
> EOF therefore frees a struct stack node that is still linked in
> stack_list, and the next reader of show_stacks walks into freed memory.
> On v6.12.115 (x86_64 QEMU, KASAN, page_owner=on), a single 4 KiB read()
> and close() followed by a full read gives:
> 
>   BUG: KASAN: slab-use-after-free in stack_print+0x165/0x170
>   Read of size 8 at addr ff11000005259d40 by task init/1
>   ...
>   Allocated by task 1:
>    __kasan_kmalloc+0x7f/0x90
>    __set_page_owner+0x45c/0x6c0
>   ...
>   Freed by task 1:
>    kfree+0x1a0/0x390
>    seq_release_private+0x58/0x110
>    full_proxy_release+0xe3/0x290
>    __fput+0x35c/0xac0
>    __x64_sys_close+0x79/0xc0
>   ...
>   The buggy address belongs to the object at ff11000005259d40
>    which belongs to the cache kmalloc-16 of size 16
> 
> Without KASAN, a partial read followed by a full read
> ("head -12 show_stacks; cat show_stacks") panics arm64 hardware running
> a 6.12.108-based kernel:
> 
>   Unable to handle kernel paging request at virtual address 0030206235376d88
>   pc : stack_print+0x20/0xd0
>   lr : seq_read_iter+0x340/0x470
>   Call trace:
>    stack_print+0x20/0xd0
>    seq_read_iter+0x340/0x470
>    seq_read+0xf0/0x140
>    full_proxy_read+0x54/0xa0
>    vfs_read+0xc8/0x348
>    ksys_read+0x6c/0x118
>   Kernel panic - not syncing: Oops: Fatal exception
> 
> With this revert applied, the QEMU reproducer completes 20
> partial-read/full-read cycles without a KASAN report. mm/page_owner.c is
> unchanged between v6.12.115 and v6.12.116.
> 
> Backporting 156c0c5d1463 instead is not proposed: it prepares for the
> new show_handles and show_stacks_handles debugfs files rather than
> fixing anything, so reverting the backport is the minimal change for
> stable.
> 
> Link: https://lore.kernel.org/stable/20260106170507.666343896@linuxfoundation.org/
> Signed-off-by: Hamid Nassiby <hamid.nassiby@nokia.com>
> ---
> 
> Notes:
>     The analysis, the QEMU/KASAN reproducer and this changelog were
>     prepared with AI assistance. The arm64 crash was hit on our own
>     hardware; I reviewed the analysis and confirmed the fix there, with
>     repeated partial and full reads of show_stacks on the reverted kernel.
>     
>     The same backport is in 6.18.y as 05a8edf607be; a separate
>     [PATCH 6.18.y] revert is sent alongside this one.
> 
>  mm/page_owner.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index 5d1c946c0..d2783b7c0 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -937,7 +937,7 @@ static const struct file_operations page_owner_stack_operations = {
>  	.open		= page_owner_stack_open,
>  	.read		= seq_read,
>  	.llseek		= seq_lseek,
> -	.release	= seq_release_private,
> +	.release	= seq_release,
>  };
>  
>  static int page_owner_threshold_get(void *data, u64 *val)
> 
> base-commit: 5c40a1750f44dd6c7292d8c8d0b4ffff1734576e

-- 
Mauricio
