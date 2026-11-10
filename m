Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794318809;
	b=tvUCfD0+pYtoAVuS8Uup4VLR4s1hmg5iy39napLexnVjenuBXl16uJLZkWc/ymFenq6v
	 cMsjLMCpThxKjnv+mBVaCXf1ujp8Qyt2mF7wWT150rYbUXXSrYy9lNauy0DCJpH3oIr3G
	 hykMVvb91GRAXzVU7di1OnnjdJMEwwRDu8rCujsCYigRyBkqcDwR3OvqUe5Q+ZuPqh+3b
	 yGr6qLtq4vjP30ClGVk3Mpy+XCQM5XyqQjS01X+MxU+Stw59uM3Lhfilw7bq2hjzsx74u
	 Srvm9xvpXEKix2vmnlkPrXAnQkaXG+F6vt002qZK9/WK4PvKjpLNSHPouIrczp7Ig+Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794318809;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=jcmj2mRiryRprIj9Gr9aUDtuxY0NQ+ycYiPJC0rulso=;
	b=YPqzbMAkKBC+//xO3kQjPv2RGapfdJkVxHjMbjcto4JNgtRV0XOOQFJ7PsuPJ5FjzQBT
	 fF+m3utXyAlGnx6uKWyspBbg5fqQqbZh83a0cJIMb1PnKSxcjG32M2B2jZU2uR+gYYkUe
	 8svFtnrm0dIZ5NAFNESKbwqrEK3aZW9dYT/XFY1tCp0vg6pnXMC8VO60fqO+iC4eoZngl
	 S49Bm9ABJd/goOZZJYKpWaQ67Y+4cDComuSMN292u0C6rF6l7tfgaH+ph1w0kGxEv5rmj
	 xJt9ZiLffSdD2BW8dVsYkULETYwotGYHuIFps9KoPm1I2IsgPEGB3fx+YaSZmXBmDPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=QgUUViqV;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DTFvvSvR;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=swYBA4Ja;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ujMwJ2Ho;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF91606A336
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FF91606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=QgUUViqV;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=DTFvvSvR;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=swYBA4Ja;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ujMwJ2Ho
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C461021E68;
	Tue, 10 Nov 2026 13:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794318799; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jcmj2mRiryRprIj9Gr9aUDtuxY0NQ+ycYiPJC0rulso=;
	b=QgUUViqViWCMY15ugNChFv3abQjhR0uVHD/mNm2xAI6hXizLOON7KbCxBRMn+Q7qx1Zd/+
	3qxHP6EzoKtTueeVE9Z+gQRnx96xpDn8BlwYqAfVSUVpXc54rN+klU8AqSHZo+OnsWxvLa
	R6W4nNqX/hdq9yBvnn5xvzixKZK6QVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794318799;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jcmj2mRiryRprIj9Gr9aUDtuxY0NQ+ycYiPJC0rulso=;
	b=DTFvvSvRIVl0YFEtqQr5KB4edvgx8y6PdCUR48rHCmH2cDjd82wBkfA7lpwefWONspUH4N
	JjMCaDYCoX/xCrCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794318798; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jcmj2mRiryRprIj9Gr9aUDtuxY0NQ+ycYiPJC0rulso=;
	b=swYBA4JaEWYZe6/pZZCl2ZydZAx+XJLdjEntlW7iIabs9RFjPiEcIup8fyTHn71UupdCxf
	AxUIfuYOX3Q3MPmzP2tAirCTHRiPS++/CKbUkf3LPJQcmKL1/7kcUUd+vG0W/bEDBh60Bv
	SeQXZBeVzjMSLyPtYg0APXwT/UW/npg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794318798;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jcmj2mRiryRprIj9Gr9aUDtuxY0NQ+ycYiPJC0rulso=;
	b=ujMwJ2HoR7JnVj9DpENaei73/ZLgzQaEOocb2UseRJBKNMbQEP5DWJzT2SBTtRDVGi8sYH
	cIp78rA38DQHsrCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A68713479;
	Tue, 10 Nov 2026 13:53:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LOSuGc4h82oXfgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 10 Nov 2026 13:53:18 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 1ED802251E; Tue, 10 Nov 2026 14:53:14 +0100 (CET)
Date: Tue, 10 Nov 2026 14:53:14 +0100
From: Jan Kara <jack@suse.cz>
To: Gopal Malaviya <gopalmalaviya53@gmail.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, jack@suse.cz, 
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev, fujunjie1@qq.com, vishal.moola@gmail.com, 
	roman.gushchin@linux.dev, Trace <tracekotae@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: restart mmap readahead on sequential faults
 after many misses
Message-ID: <jwg2p4bjzkacnx6fkifkb5jbe7ah6btuecpcpulbkym6e23v6x@mh35p6yafmqi>
References: <20261105192517.228523-1-tracekotae@gmail.com>
 <20261109091444.128521-1-gopalmalaviya53@gmail.com>
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
In-Reply-To: <20261109091444.128521-1-gopalmalaviya53@gmail.com>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-11.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,qq.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,infradead.org,suse.cz,kvack.org,vger.kernel.org,lists.linux.dev,qq.com,gmail.com,linux.dev];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -11.30

On Mon 09-11-26 09:14:44, Gopal Malaviya wrote:
> Since commit 9b0fcac3cfe7 ("mm/filemap: do not count FAULT_FLAG_TRIED
> retries as mmap hits"), about a hundred sparse mmap faults push
> mmap_miss over MMAP_LOTSAMISS and turn off mmap read-around, as
> intended. But mmap_miss only comes down on hits on pages that
> read-around brought in, and with read-around off there are none. A file
> that is then read sequentially gets a synchronous single-page read for
> every page until it is opened again.
> 
> When a miss above the limit is on the page right after the previous
> miss, start readahead the way a sequential read() miss does, with
> page_cache_sync_ra(), and keep mmap_miss at its cap so that hits on
> that small first window do not bring back full read-around for random
> access.
> 
> Tested in a KVM guest (x86_64, 2 vCPUs, 3 GiB) with ext4 on virtio-blk.
> "base" is mm-hotfixes-unstable. "95b8e" is commit 95b8e432265f ("mm: use
> zone lock guard in __offline_isolated_pages()"), the last one before the
> series of 9b0fcac3cfe7. Commit 0b9c0aeba938 ("mm/filemap: count only the
> faulting address as a mmap hit"), the first of that series, gives the
> same results as 95b8e for the reproducer.
> 
> Reproducer from the report, read_ahead_kb 128, major faults:
> 
>                                          95b8e    base  patched
>   sequential only                            1       1        1
>   sparse pass, then sequential               1   16384        2
>   sparse, MADV_SEQUENTIAL, sequential      512     512      512
>   sparse, close and reopen, sequential       1       1        1
> 
> Touching 1% of the pages of a cold 20 GiB file, larger than memory,
> MiB read from disk:
> 
>                        read_ahead_kb 128        read_ahead_kb 8192
>                       95b8e  base patched     95b8e   base patched
>   random               5656   215     215    344731   1032    1032
>   stride 2053 pages    6545   216     216    419003    992     992
>   random 2-page runs   2992   215     528    173093   1099    2248
>   random 4-page runs   1570   216     594     86797   1266    2301
> 
> After the sparse pass, reading 32 regions of 2 MiB in turn takes 512
> major faults per region on base and 2 with this patch.
> 
> Not tested: NFS, the GPU workload from the report, and other
> architectures and page sizes.
> 
> An AI assistant (Claude) helped with the analysis and the approach, and
> wrote the test programs and drafts of the comment and this changelog.
> I reviewed, implemented, built and tested the change.
> 
> Fixes: 9b0fcac3cfe7 ("mm/filemap: do not count FAULT_FLAG_TRIED retries as mmap hits")
> Reported-by: Trace <tracekotae@gmail.com>
> Closes: https://lore.kernel.org/all/20261105192517.228523-1-tracekotae@gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Gopal Malaviya <gopalmalaviya53@gmail.com>

I think this [1] looks like a nicer solution to your problem.

[1] https://lore.kernel.org/all/20261109-mmap-miss-v1-1-8b44b33f3358@it.uu.se/

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
