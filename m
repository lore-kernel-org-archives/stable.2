Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795011533;
	b=cV5GpjJBsmMUb/F9t2d/Pbyp9M8ib95P4Pp7Jvmi8en8L1k0+uiHiywvZLMxp1FwAitU
	 M3U/vPqyVcjNlBhcjmHxk7HgoNJl8pAyRBCoSxw59NDqqno12p3OI5SuM69CDZUh2Y5xa
	 lM5RxGSusNN8uNgLv4wCVnXH8RIZk3gORyLFq5ttbEwXdfpAb+uH8M7i5hFDT+evzFsbs
	 uU9cXOX6jPa0hKPTmC7ee8dT03iYHJrVoTX1CjKunxMYEUf2OGy22B3up8D21rHRXnmlj
	 fBpE8W7wvyWpFxEOvbvcB3XCrCBo1UbVk57eJsuYuZ+ko1GTYJKQvETWYIXW0uvERGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011533;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=QROhWMzlykaiuQCCkL24rkKkdLiuZjzK5ETs2yxqYKU=;
	b=BJhX7ajEp6scYiRMdvs7oqFiINJ58aV9FwbOaiR90aRBK8jj4918Yq/dhWTvEGQhhI76
	 C2BC/rqQ7wmNtgYTCxu2mmzaQfD4SOAWEbR/ewz2o3OYc+P4ykDzqWO0Nd/Drn+7xnn4J
	 ZukQgfgNwTXEyiVN4WHhwpeUmxUvxdq5xHKN3X66QugwzCJmB8mQ2l4U6talq7n+8x3l6
	 Ydqm6ag+17yvhLMUedCWgoEqdFIN2xvhPBuzKE1yAVq7a3D0tD7ZtpGjmD1PhcAebDPsy
	 ZoiKYdGFBF4Bch+CgZYjNKhNxnrlHJTfHIGmqrGqafxW9EooXYLjkhqBfmRZzeUgsbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zg13HXJ7;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="Fpa0wb/f";
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zg13HXJ7;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b="Fpa0wb/f";
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6724D60A2600
	for <stable@vger.kernel.org>; Wed, 18 Nov 2026 14:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6724D60A2600
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zg13HXJ7;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Fpa0wb/f;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=zg13HXJ7;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=Fpa0wb/f
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 205E21F84D;
	Wed, 18 Nov 2026 14:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795011520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QROhWMzlykaiuQCCkL24rkKkdLiuZjzK5ETs2yxqYKU=;
	b=zg13HXJ7jADMk9z96y3DFcZUTy4nGww5LqNwNIiCSt3PTrE0N6Acu3cfLQC8/NzMM9igWG
	8v5Lduem7Cs/h39vCCC1VIECisZ0C+yvn7GYjxMtJA/Hl+pyZYj8XPsiCQesDaEzw06Bdo
	CIVE5yjbTHe74Cy6n7w6PfDLTt9WZIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795011520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QROhWMzlykaiuQCCkL24rkKkdLiuZjzK5ETs2yxqYKU=;
	b=Fpa0wb/fgifXMmUiAWnLIzlXbBJ4JiQt8gNzvUjX8JRk6HzkegUUz9XBVMS2oHDD4iOOSk
	G2E6P6+1/1ozyBDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795011520; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QROhWMzlykaiuQCCkL24rkKkdLiuZjzK5ETs2yxqYKU=;
	b=zg13HXJ7jADMk9z96y3DFcZUTy4nGww5LqNwNIiCSt3PTrE0N6Acu3cfLQC8/NzMM9igWG
	8v5Lduem7Cs/h39vCCC1VIECisZ0C+yvn7GYjxMtJA/Hl+pyZYj8XPsiCQesDaEzw06Bdo
	CIVE5yjbTHe74Cy6n7w6PfDLTt9WZIk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795011520;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QROhWMzlykaiuQCCkL24rkKkdLiuZjzK5ETs2yxqYKU=;
	b=Fpa0wb/fgifXMmUiAWnLIzlXbBJ4JiQt8gNzvUjX8JRk6HzkegUUz9XBVMS2oHDD4iOOSk
	G2E6P6+1/1ozyBDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB619134E9;
	Wed, 18 Nov 2026 14:18:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fsyLMb+z/Wq5MwAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 18 Nov 2026 14:18:39 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 6F82F25077; Wed, 18 Nov 2026 15:18:35 +0100 (CET)
Date: Wed, 18 Nov 2026 15:18:35 +0100
From: Jan Kara <jack@suse.cz>
To: Ding Feng <dingf3ng@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, dlemoal@kernel.org, 
	naohiro.aota@wdc.com, jth@kernel.org, Jun-ichi Takimoto <takimoto-j@kba.biglobe.ne.jp>, 
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: ignore RLIMIT_FSIZE above LLONG_MAX in
 generic_write_check_limits()
Message-ID: <hwwtflqzbga65oxvo7bw44xuhpbqseyfww62kyzko5az4gdnxy@4wxsl465nvp5>
References: <20261117173129.61028-1-dingf3ng@gmail.com>
 <20261117173129.61028-2-dingf3ng@gmail.com>
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
In-Reply-To: <20261117173129.61028-2-dingf3ng@gmail.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Wed 18-11-26 01:31:28, Ding Feng wrote:
> generic_write_check_limits() stores rlimit(RLIMIT_FSIZE), an unsigned
> long, in a loff_t. A soft limit between 2^63 and RLIM_INFINITY becomes
> negative there, so "pos >= limit" holds for every position: each write
> through generic_write_checks() or copy_file_range() fails with -EFBIG
> and raises SIGXFSZ, although no file position can reach such a limit.
> 
> Reproducer (bash counts ulimit -f in 1024-byte blocks, so 2^53 blocks
> is 2^63 bytes):
> 
>   $ bash -c 'ulimit -f 9007199254740991; echo hi > /tmp/f'; echo $?
>   0
>   $ bash -c 'ulimit -f 9007199254740992; echo hi > /tmp/f'; echo $?
>   File size limit exceeded
>   153
> 
> Before commit 9fd91a90cb98 ("vfs: strengthen checking of file range
> inputs to generic_remap_checks") the limit was an unsigned long in
> generic_write_checks(), and such limits had no effect.
> 
> Keep the limit unsigned and apply it only when it is at most LLONG_MAX.
> Smaller limits keep the existing loff_t arithmetic, so their behaviour,
> including for negative positions, is unchanged.
> 
> Fixes: 9fd91a90cb98 ("vfs: strengthen checking of file range inputs to generic_remap_checks")
> Reported-by: Jun-ichi Takimoto <takimoto-j@kba.biglobe.ne.jp>
> Closes: https://lore.kernel.org/linux-fsdevel/8F9EB913-3AC3-4D89-9DA3-427029F6D211@kba.biglobe.ne.jp/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5 Frama-C
> Signed-off-by: Ding Feng <dingf3ng@gmail.com>

Looks sane. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Notes:
>     Tested on v6.12 (arm64 tinyconfig, QEMU virt, initramfs on ramfs) with
>     a static test program that sets the soft RLIMIT_FSIZE, writes 2 bytes
>     and copies 10 bytes with copy_file_range():
>     
>       soft limit            unpatched           patched
>       1024, 2^63-1          ok                  ok
>       2^63, 2^63+4096,
>       2^64-2                EFBIG (both)        ok (both)
>       1                     short write, then EFBIG (both kernels)
>     
>     Also reproduced on 6.10.14 (arm64) with write(), pwrite() and
>     copy_file_range() on tmpfs and overlayfs. Compile-tested for x86_64
>     defconfig with clang; not run on x86_64.
> 
>  fs/read_write.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index b15522c..18a217d 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1693,14 +1693,15 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
>  {
>  	struct inode *inode = file->f_mapping->host;
>  	loff_t max_size = inode->i_sb->s_maxbytes;
> -	loff_t limit = rlimit(RLIMIT_FSIZE);
> +	unsigned long limit = rlimit(RLIMIT_FSIZE);
>  
> -	if (limit != RLIM_INFINITY) {
> -		if (pos >= limit) {
> +	/* No file position reaches a limit above LLONG_MAX. */
> +	if (limit != RLIM_INFINITY && limit <= LLONG_MAX) {
> +		if (pos >= (loff_t)limit) {
>  			send_sig(SIGXFSZ, current, 0);
>  			return -EFBIG;
>  		}
> -		*count = min(*count, limit - pos);
> +		*count = min(*count, (loff_t)limit - pos);
>  	}
>  
>  	if (!(file->f_flags & O_LARGEFILE))
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
