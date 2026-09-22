Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D194E4C4D
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790071136; cv=none; b=oCfrHRG0x1ViBB2vGHGyDL1emmUzF1/Rib1Agul8Ufwurwhs5+x+UCK3xYlnBEQOwlcP6yf6aJWMkBlgZ5bXhbkPtNchbPH1UtUPiwuBxHHF/jMz/MQu0+3Axn6O43Mw47tCufgVsTG/Ym1RsHMcikRRji2w1yWZc74rUJ9ON/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790071136; c=relaxed/simple;
	bh=RwCFSgGwANKGfvDoF5VZzkTz9TJE6jsyfOd5Cbm/aqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IalLdavJ9/Q6SonVh8nGL82KJCWXtHYFMLrWS2niYrSEAJACFHweP50xeSNpGwzys5u8yZW+TnTrSblx0yPoelA2tqM0Hn3a+RVOHahM6QKKoOFQXV9PWfiSwpQfsq1IcHSoNyBGUq+Tewa3O1uVCk4m99Q7Z0oEOBZ+2Ht2tQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=K8+fofch; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y0r44oIp; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wfyLr/Mm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=E+BXUt+D; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="K8+fofch";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y0r44oIp";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wfyLr/Mm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="E+BXUt+D"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CA9B6219DF;
	Tue, 22 Sep 2026 09:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790071119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dyXC0qvUVpIhSk2IhvGo0kA+uk0SK/Z5hz/KOeDBmU4=;
	b=K8+fofchFWOwYOyx3KzDPQyIGOilZq0/PYZy3IZ9fvpbZO8Zj8iPBCv0dcLp83HG71O22e
	u+bOSYXynzFbquKGLjrC1A2zRPKOg/34zzH14RR++kGTWi9a2vtMJfUvKuRYCxMkbTllF4
	vsKgZxhZWkcPS6H9ZqrcpDjHSXxYJ70=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790071119;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dyXC0qvUVpIhSk2IhvGo0kA+uk0SK/Z5hz/KOeDBmU4=;
	b=Y0r44oIpALfJ3Ep7Dz2t1mxdkwT4kOgUluMgJzY+qII5PjcblOVx3A6TZpRc3ifrGtMlN/
	t2fP0FDi8/pNSUDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="wfyLr/Mm";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=E+BXUt+D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1790071115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dyXC0qvUVpIhSk2IhvGo0kA+uk0SK/Z5hz/KOeDBmU4=;
	b=wfyLr/MmYA1O18+FzeiMqsWb2OSwEVAUSESatbDaRWn3B/lxdVjsvcWzPAmOWWXCi2bwj8
	esIP9p3xCKJld/Kb5FFoOaIhG3D0+PgoPPfjknu8I/IR5xlyiNSUmg+UqPfrC96AMn9c2h
	q4T6a4z8Ng6MImZQSd1TBP/KP5jHNrk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1790071115;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dyXC0qvUVpIhSk2IhvGo0kA+uk0SK/Z5hz/KOeDBmU4=;
	b=E+BXUt+DrdqHUFIaRLqtXHI+knoiaEqEhy19xRFrG3mPyK1UWUqmP5/agsK56M6a8FanrT
	7g8gUJDLoxm03ICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9C402139EE;
	Tue, 22 Sep 2026 09:58:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ONGaH0tRsmrpBwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 22 Sep 2026 09:58:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 14746A13D4; Tue, 22 Sep 2026 11:58:35 +0200 (CEST)
Date: Tue, 22 Sep 2026 11:58:35 +0200
From: Jan Kara <jack@suse.cz>
To: Palla Raghunath <raghunathpalla.0209@gmail.com>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>, 
	Brigham Campbell <me@brighamcampbell.com>, linux-kernel-mentees@lists.linux.dev, 
	syzbot+e8ebfecec06a009dd2d3@syzkaller.appspotmail.com, stable@vger.kernel.org, 
	=?utf-8?B?7J207IOB7Zi4?= <kudo3228@gmail.com>, Mateusz Guzik <mjguzik@gmail.com>, Jan Kara <jack@suse.cz>, 
	Deepanshu Kartikey <kartikey406@gmail.com>, David Howells <dhowells@redhat.com>
Subject: Re: [PATCH RESEND] romfs: reject directory entry chains that do not
 move forward
Message-ID: <34t4huzelgho3zelar7vp332rwerth7nso6e76jrfced4chtrt@7q2cjbeymwov>
References: <20260918164645.9230-1-raghunathpalla.0209@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918164645.9230-1-raghunathpalla.0209@gmail.com>
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: CA9B6219DF
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TAGGED_RCPT(0.00)[e8ebfecec06a009dd2d3];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,brighamcampbell.com,lists.linux.dev,syzkaller.appspotmail.com,gmail.com,suse.cz,redhat.com];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,appspotmail.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,syzkaller.appspot.com:url]
X-Spam-Flag: NO
X-Spam-Score: -2.51

Adding Dave Howells since he put himself into the headers of this
filesystem :)

On Fri 18-09-26 17:46:41, Palla Raghunath wrote:
> romfs_lookup() and romfs_readdir() walk a directory's entry chain by
> following ri.next, and stop only once the offset is zero or past the end
> of the image. Nothing stops an entry from pointing at itself, so on a
> crafted image a lookup of a name that is not present spins forever.
> 
> That loop has no cond_resched() and no signal check, so the task cannot
> be killed, and it spins with i_rwsem held and the dentry left in the
> in-lookup state. A second lookup of the same name then waits forever in
> d_alloc_parallel(), and it is that waiter the hung task watchdog
> reports, which makes this look like a dcache problem:
> 
>   INFO: task syz-executor239:5636 blocked for more than 143 seconds.
>    d_alloc_parallel+0xd13/0x16c0 fs/dcache.c:2839
>    __lookup_slow+0x82/0x2f0 fs/namei.c:1904
> 
> Require the chain to move forward and return -EIO if it does not. File
> headers are laid out in increasing order and both loops already treat
> the chain as a bounded forward-only walk, so this only enforces what
> they assume. In romfs_readdir() a cycle never advances ctx->pos and has
> getdents() repeat entries forever, so check there too.
> 
> The hard link chain bounded by commit d30b5a954e0a ("romfs: detect hard
> link cycles") is a separate one. Sangho Lee posted a fix for this chain
> in July 2026 that validates it at inode instantiation; it has had no
> replies.
> 
> Reported-by: syzbot+e8ebfecec06a009dd2d3@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e8ebfecec06a009dd2d3
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org

I doubt these bugs have any practical relevance so I wouldn't CC stable.
But I guess that's for Christian.

> Signed-off-by: Palla Raghunath <raghunathpalla.0209@gmail.com>

The patch looks good, I'm just not sure we are guaranteed ROMFS directories
are indeed following monotonically increasing disk offset (although that's
the most logical thing to do) - added Dave to CC for that. Otherwise feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/romfs/super.c | 26 +++++++++++++++++++++-----
>  1 file changed, 21 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/romfs/super.c b/fs/romfs/super.c
> index 7f783d6173e8..846b57f265ef 100644
> --- a/fs/romfs/super.c
> +++ b/fs/romfs/super.c
> @@ -143,7 +143,7 @@ static int romfs_readdir(struct file *file, struct dir_context *ctx)
>  {
>  	struct inode *i = file_inode(file);
>  	struct romfs_inode ri;
> -	unsigned long offset, maxoff;
> +	unsigned long offset, maxoff, next;
>  	int j, ino, nextfh;
>  	char fsname[ROMFS_MAXFN];	/* XXX dynamic? */
>  	int ret;
> @@ -191,7 +191,16 @@ static int romfs_readdir(struct file *file, struct dir_context *ctx)
>  			    romfs_dtype_table[nextfh & ROMFH_TYPE]))
>  			goto out;
>  
> -		offset = nextfh & ROMFH_MASK;
> +		/* likewise, a chain that does not move forward would have
> +		 * getdents() repeat entries forever
> +		 */
> +		next = nextfh & ROMFH_MASK;
> +		if (next && next <= offset) {
> +			offset = maxoff;
> +			ctx->pos = offset;
> +			goto out;
> +		}
> +		offset = next;
>  	}
>  out:
>  	return 0;
> @@ -203,7 +212,7 @@ static int romfs_readdir(struct file *file, struct dir_context *ctx)
>  static struct dentry *romfs_lookup(struct inode *dir, struct dentry *dentry,
>  				   unsigned int flags)
>  {
> -	unsigned long offset, maxoff;
> +	unsigned long offset, maxoff, next;
>  	struct inode *inode = NULL;
>  	struct romfs_inode ri;
>  	const char *name;		/* got from dentry */
> @@ -245,8 +254,15 @@ static struct dentry *romfs_lookup(struct inode *dir, struct dentry *dentry,
>  			break;
>  		}
>  
> -		/* next entry */
> -		offset = be32_to_cpu(ri.next) & ROMFH_MASK;
> +		/* next entry; the chain must move forward, or a corrupt image
> +		 * will keep us here forever
> +		 */
> +		next = be32_to_cpu(ri.next) & ROMFH_MASK;
> +		if (next && next <= offset) {
> +			ret = -EIO;
> +			goto error;
> +		}
> +		offset = next;
>  	}
>  
>  	return d_splice_alias(inode, dentry);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
