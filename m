Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795082490;
	b=kneJJTTE99kEsNcG39NwdJzi/IgVOcJPBDK9GQ+iaZzEzsMXUVIDBD+um1+RyJOV0tpU
	 JvO2GT4iA8GGVZCIbbM23/wq3yYIQimuMwDAsNKAz8lb9OQ7Lwd3h7L8XgSt7IHNdUFT/
	 WxFcsG4kfyaEo9Mu//ODvlV5276NQt1Pdbo68S6BQXtfsZi093iu7FEVa7lrgq5r5resI
	 HReNw2sYkblwQeSG/8idknJ39UxXEfYiZtIEmyB5x/ZXj6S09zZGd8aCy3ZXuEE7s1yRM
	 q1TPoZ5GiTpxEGRrZbu5QiDBW0TZWmU5Y9q8HGstXoOFyDgYyRctmmo8URuoaJfkEHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795082490;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=VM+Fx30jqhOo+2zNrQH2oCEQKEMQjPDt2/UImCBx208=;
	b=rA26qTKDMzVUmk8HXYmxpgTOqh8tYFTSpl+TwMbdaIJZ92pDGXbpNuFC2t0PzlbdNLlT
	 9nHFNELI9/Wcy6xxOq/qjXM00z9gjqFMMb7lYkpYKqwX2Yev2e4Zp3qQ8W3Ah7eV/7OAV
	 /n/xZlIOOvj/2qraKuln7US+xMZLfH+XSsSqljz8dkkgPFoWZeHXn6cTcSFQCsZKVnYXZ
	 nCtYj/DKLzwksRAsyI3wcWD/EdXysRnIVjCLipg7eDD7TB6TIOJbBf+QUOPgmNtPnbSbM
	 s0snUuf66ccfMhETA0ufo0J+TgEHf7DeILlluVLWuwN+Ad2GNI/WfAip15TtBjeo16w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=L4wKL1fv;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=w4OTM7oS;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Yflrvf7G;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gnei12RD;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ACD60A260C
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 10:01:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51ACD60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=L4wKL1fv;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=w4OTM7oS;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=Yflrvf7G;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gnei12RD
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1537822133;
	Thu, 19 Nov 2026 10:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795082473; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VM+Fx30jqhOo+2zNrQH2oCEQKEMQjPDt2/UImCBx208=;
	b=L4wKL1fvdhFWz8gLgXZjPwHZBSiZFKq2jBiKr2n/5m8pKb/ymZ1djOis52J9rVRCcnlDUC
	5k7IfmJ9YTrsdPAY862qX5JtOWaZjkgGXqGWD4wrOK+aKT4CiBDA13rqBMgfnU71gIbDPV
	bF+OZ5By7YJSDWetaka26QWgAd3ApoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795082473;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VM+Fx30jqhOo+2zNrQH2oCEQKEMQjPDt2/UImCBx208=;
	b=w4OTM7oSjR+Fb0XAI09+xYLcou7D45R7HWKYytXNQl4yb1jLE6sfBicBhQ8Hc8DxwU78Du
	S/2bAtj2mownBgDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Yflrvf7G;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gnei12RD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795082472; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VM+Fx30jqhOo+2zNrQH2oCEQKEMQjPDt2/UImCBx208=;
	b=Yflrvf7GiOKe4Rj5iCqeHHxfuNzP73OToMRhprsydvW9pmXOz+qBA+GKKdFYjObeuxZGcc
	ajmTrkrsbWjxebTBLIkpyrMWVukfm0UXBL5k3PLDWSJNen5GPgXq+pTM6Wd+GhA1XJadzv
	zIeDh7NInCOf2xwrZkEtISRm5H9GjiA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795082472;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VM+Fx30jqhOo+2zNrQH2oCEQKEMQjPDt2/UImCBx208=;
	b=gnei12RDK2pS/6Xk0eVJeqXQhc+ZAFGdlztkdUCwMcP+WwVPC752po+gu5CzW2y+aLo/OA
	hCb1yLHkg4MaG8DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E06451334C;
	Thu, 19 Nov 2026 10:01:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UI+cLufI/mqKcgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 19 Nov 2026 10:01:11 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 8712B25190; Thu, 19 Nov 2026 11:01:11 +0100 (CET)
Date: Thu, 19 Nov 2026 11:01:11 +0100
From: Jan Kara <jack@suse.cz>
To: Ding Feng <dingf3ng@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Damien Le Moal <dlemoal@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Jan Kara <jack@suse.cz>, Naohiro Aota <naohiro.aota@wdc.com>, 
	Johannes Thumshirn <jth@kernel.org>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jun-ichi Takimoto <takimoto-j@kba.biglobe.ne.jp>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fs: ignore RLIMIT_FSIZE above LLONG_MAX in
 generic_write_check_limits()
Message-ID: <2rfra7mk7avzcamukmz6fzs523rqbt6fb4wew2tvraa373od3k@ve3zfcfudxpr>
References: <20261119031026.7985-1-dingf3ng@gmail.com>
 <20261119031026.7985-2-dingf3ng@gmail.com>
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
In-Reply-To: <20261119031026.7985-2-dingf3ng@gmail.com>
X-Rspamd-Queue-Id: 1537822133
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[11];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email]
X-Spam-Score: -13.01

On Thu 19-11-26 11:10:25, Ding Feng wrote:
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

Still looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> 
> Notes:
>     v2: hold the limit in a u64. As an unsigned long, "limit <= LLONG_MAX" is
>     always true on 32-bit, and clang W=1 warns (kernel test robot, Damien).
>     v1 was applied to vfs-7.5.misc as bc0dc4379463; this version replaces it.
> 
>  fs/read_write.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/read_write.c b/fs/read_write.c
> index b15522c..9786dfc 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1693,14 +1693,15 @@ int generic_write_check_limits(struct file *file, loff_t pos, loff_t *count)
>  {
>  	struct inode *inode = file->f_mapping->host;
>  	loff_t max_size = inode->i_sb->s_maxbytes;
> -	loff_t limit = rlimit(RLIMIT_FSIZE);
> +	u64 limit = rlimit(RLIMIT_FSIZE);
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
