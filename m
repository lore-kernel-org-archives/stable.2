Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.97.179.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794252997;
	b=TvZV6K4ayUXzy1wqznf2Xv6pymIcxnmpo28DBqb6EH/XL4hT4585ECqnHXhis5Ty/nq6
	 oZLYEk8Fg2bly3hnuG82SG916CnQP3fBPhPQGnMZcJ/itLO19/cCTByIkDOP9WkGEZekv
	 y29g8S6gD3SqhG8BERhyErPVQt3ZVQp7QUmhc46yMqKOL6L+7V+kzKtqUqF3SpBarY/Wk
	 1AGgeaVN4QP0lH0ciYhFdTsA2Ztvjjnce/AmJ6Vo+/I/W2pG8NR+dp690YADvnmh06Yu/
	 a6nEHd1mN7NtPEPVrcc+HA+SHJ/RQE3aggINTiBKomkAy/xpE4GugD/BxLe1MracFew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794252997;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Received:MIME-Version:
	 Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:X-Sender:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Report:X-Spam-Score:
	 X-Spam-Bar:X-Rspamd-Score:X-Rspamd-Action:X-Rspamd-Bar;
	bh=Z7b1DQocnv6+T5lOYkcaiSGK/dXpQFZSh9YUyP7VK80=;
	b=sRxWf3KSYUzE5B8xY65mJkVNFBgOSyAXi5oapJUEMipe7ELzP42aaTW8MxplDN5MINa8
	 0eVEFGOXqNqEkp+7t4SvkFk2PQlvdRD3WX9biiDay7i/j+ygeFHHhV1UI6kQ5mDLrMdk3
	 7WkUjHbLtkO8SMKqbLniSvLC6b5As7ASqd7KxZwMp9qTYxlELsmwBjwzfCu58lPCdLm/d
	 UgrOXEfmSoW5RzT2JX05SqwavngrPG3HrT2uhmfc1gxjiVGc2KCCHVdRCS5ArGHiTZxih
	 +915zxrdyzHsa0TIkrogS5fAtOQnGob8U2Nt3KsNIk48f0dgvaoJwYlTbHZU8U78sxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=igalia.com;
	spf=pass smtp.mailfrom=igalia.com;
	dkim=pass header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=q+904WgG;
	arc=none smtp.remote-ip=213.97.179.56
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE60606A333
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 19:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EE60606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=q+904WgG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:Message-ID:Subject:Cc:To
	:From:Date:MIME-Version:From:Reply-To;
	bh=Z7b1DQocnv6+T5lOYkcaiSGK/dXpQFZSh9YUyP7VK80=; t=1794252996; x=2109612996; 
	b=q+904WgG9t70VGeZASr7GUhjP8A1sttHM//LDFDoF+Gq4/XR2luZvt1t4ppshtOW4RPcYjGgw4g
	Z6Aas7yeXqxjTkwhPdjKq1DSPrJc0YAMNnk9BtME+uX6tnSzijO/0TWJmbFBvPv1mZ/6ErNkqAIYj
	/sMZ3ZizV0ZXDKPK7Yr9EwpO+NTHYyjHC4JqjJCyzBVNqAzD8+4nYQv+pp78zg8aUNJ4SdbKkTFeu
	x8FvNGeZya6SiKby76GwoDdKVqWS6jd4OUFPTC5F3B71sMsbw9xyGi9iwLSnZ7PCa7ySGslqt2Np+
	RTrUVKnVO/ee/gyx1PMLg7fJ0tUHdt8Bt7Og==;
Received: from maestria.local.igalia.com ([192.168.10.14] helo=mail.igalia.com)
	by fanzine2.igalia.com with esmtps 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xQVAJ-007cPZ-RP; Mon, 09 Nov 2026 20:36:27 +0100
Received: from webmail.service.igalia.com ([192.168.21.45])
	by mail.igalia.com with esmtp (Exim)
	id 1xQVAI-00000005GaE-3m2c;
	Mon, 09 Nov 2026 20:36:27 +0100
Received: from localhost ([127.0.0.1] helo=webmail.igalia.com)
	by webmail.service.igalia.com with esmtp (Exim 4.98.2)
	(envelope-from <mfo@igalia.com>)
	id 1xQVAI-0000000GRqV-37ef;
	Mon, 09 Nov 2026 20:36:26 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Mon, 09 Nov 2026 16:36:26 -0300
From: Mauricio Faria de Oliveira <mfo@igalia.com>
To: Hamid Nassiby <hamid.nassiby@nokia.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sasha Levin <sashal@kernel.org>, Ran Xiaokai <ran.xiaokai@zte.com.cn>,
 ranxiaokai627@163.com, Andrew Morton <akpm@linux-foundation.org>, Vlastimil
 Babka <vbabka@suse.cz>, Michal Hocko <mhocko@suse.com>, Oscar Salvador
 <osalvador@suse.de>, linux-mm@kvack.org
Subject: Re: [PATCH 6.18.y] Revert "mm/page_owner: fix memory leak in
 page_owner_stack_fops->release()"
In-Reply-To: <20261109141527.2880867-1-hamid.nassiby@nokia.com>
References: <20261109141527.2880867-1-hamid.nassiby@nokia.com>
Message-ID: <267189c6da8e01cdb49415cd97c4edee@igalia.com>
X-Sender: mfo@igalia.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Report: NO, Score=-4.9, Tests=ALL_TRUSTED=-3,BAYES_00=-1.9,KAM_DMARC_STATUS=0.007
X-Spam-Score: -48
X-Spam-Bar: ----
X-Rspamd-Score: -0.9
X-Rspamd-Action: no action
X-Rspamd-Bar: /

On 2026-11-09 11:15, Hamid Nassiby wrote:
> This reverts commit 05a8edf607be826738dfc620a17d9d98e8976762, which is
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
> 6.18 does not have that commit: page_owner_stack_open() passes a size of 0
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
> On v6.18.60 (x86_64 QEMU, KASAN, page_owner=on), a single 4 KiB read()
> and close() followed by a full read gives:
> 
>   BUG: KASAN: slab-use-after-free in stack_print+0x165/0x170
>   Read of size 8 at addr ff110000062adfc0 by task init/1
>   ...
>   Allocated by task 1:
>    __kasan_kmalloc+0x7f/0x90
>    __set_page_owner+0x4a5/0x720
>   ...
>   Freed by task 1:
>    kfree+0xf8/0x460
>    seq_release_private+0x58/0x110
>    full_proxy_release+0xa1/0x130
>    __fput+0x35c/0xac0
>    __x64_sys_close+0x79/0xd0
>   ...
>   The buggy address belongs to the object at ff110000062adfc0
>    which belongs to the cache kmalloc-16 of size 16
> 
> Without KASAN, the same bug panics arm64 hardware running a
> 6.12.108-based kernel ("head -12 show_stacks; cat show_stacks").
> 
> With this revert applied, the QEMU reproducer completes 20
> partial-read/full-read cycles without a KASAN report. mm/page_owner.c is
> unchanged between v6.18.60 and v6.18.62.
> 
> Backporting 156c0c5d1463 instead is not proposed: it prepares for the
> new show_handles and show_stacks_handles debugfs files rather than
> fixing anything, so reverting the backport is the minimal change for
> stable.
> 
> Link: https://lore.kernel.org/stable/20260106170556.173097317@linuxfoundation.org/
> Signed-off-by: Hamid Nassiby <hamid.nassiby@nokia.com>
> ---
> 
> Notes:
>     The analysis, the QEMU/KASAN reproducer and this changelog were
>     prepared with AI assistance. The arm64 crash was hit on our own
>     hardware; I reviewed the analysis and confirmed the fix there, with
>     repeated partial and full reads of show_stacks on the reverted kernel.
>     
>     The same backport is in 6.12.y as 7fbea59f737e; a separate
>     [PATCH 6.12.y] revert is sent alongside this one.
> 
>  mm/page_owner.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_owner.c b/mm/page_owner.c
> index bc2676414..589ec37c9 100644
> --- a/mm/page_owner.c
> +++ b/mm/page_owner.c
> @@ -936,7 +936,7 @@ static const struct file_operations page_owner_stack_operations = {
>  	.open		= page_owner_stack_open,
>  	.read		= seq_read,
>  	.llseek		= seq_lseek,
> -	.release	= seq_release_private,
> +	.release	= seq_release,
>  };
>  
>  static int page_owner_threshold_get(void *data, u64 *val)
> 
> base-commit: c3f63d70f236bb7685e6d11d1d9b5b351552e600

-- 
Mauricio
