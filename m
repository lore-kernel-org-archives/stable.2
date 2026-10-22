Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792665698;
	b=Kop08zzyklDpl3zVpPYCH0V/3m3iCJ7LfIeyESVx6BE1l/5XBTbSt1uQzyFOXQeQoeCS
	 CjU7vmlbneWAng54/Tw7q8CY3Uz1B3R+XzdTUB6KGc1gCF1vX7TrOFEneT4Smk8y7GgWE
	 dkGuBfJXR6nD2+MtzpD7Pk81H3kxsZwag4vcEB+fs2t+b/02DC3D++TLVCq+xnxaeFm4M
	 WLTbOQsl+vcCP/06JH3ZLtK8VvR0LdzZOAZE4LdY2QKFCqETt3NzOq6iW7+bEWfYWCQFM
	 /5l/1FZFzU67wF5osUm5RJTeeOrmv+QwmnELrNrSdlrvoyZToOsYJQ5qWgRRdCIAdAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792665698;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=0BBSJq2bncADkRtb7hx5gATlQxkx+9xJoVkEfuHB1FE=;
	b=BZAZ6JHLwdaoAPFfrgUff3BCLkADWbem43oRiHkGzcxQQTK4WOKJc+1TuQzo0JuwrrPf
	 pwZYK3twa0mlVInLtXZ67QxDYt6o/CB5MyXKKHPzT9bT8pnZ7tzxCOfpKP7K6aqsZ3MCo
	 2esj5IjQf9UBwPxzFTXUrKk1I4zeVWWUIULJZU/g1k3CARDSsA9mp9j7kpxjRR4148pOY
	 IvWAPDLNg5d5596bvjiftw7ZNB4M96zd9dk1h6Fg4bxoe5cJ967iifZKgZ28D90OaItg1
	 IFFoZ9gQ+j22GUIHx6FtkklVgv5QQwXaKBKpYdaaUEd0YeHHtUvX5BhP7NxtNpEOGyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=i4IZd4Lv;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3tMRewIy;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=i4IZd4Lv;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3tMRewIy;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2638E606A319;
	Thu, 22 Oct 2026 10:41:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2638E606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=i4IZd4Lv;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3tMRewIy;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=i4IZd4Lv;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=3tMRewIy
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 72D1D1FB8B;
	Thu, 22 Oct 2026 10:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792665696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BBSJq2bncADkRtb7hx5gATlQxkx+9xJoVkEfuHB1FE=;
	b=i4IZd4LvMRfkX2VLa50rp0LhxWEHHMmk3RAHDxg1S/Ttq4NKpZJqJ5i0axW5bA6JVuJX4+
	Ug3m74KPUnTDUajtS130AZWYfxJxFpiz3zLLSIwiqpS1R13VluFFrd6HqbLrPuFzhfo1Dj
	hSZyc3D7tQBVFfV14rwgA62qsBqeoEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792665696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BBSJq2bncADkRtb7hx5gATlQxkx+9xJoVkEfuHB1FE=;
	b=3tMRewIyAUtgD2xGLmRVC+VpkspMOMiVx62GeAKHHe41OO/rsH0BZdmJDFW0hsaQ9/yeUf
	+OoZcoF0kyUupYBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792665696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BBSJq2bncADkRtb7hx5gATlQxkx+9xJoVkEfuHB1FE=;
	b=i4IZd4LvMRfkX2VLa50rp0LhxWEHHMmk3RAHDxg1S/Ttq4NKpZJqJ5i0axW5bA6JVuJX4+
	Ug3m74KPUnTDUajtS130AZWYfxJxFpiz3zLLSIwiqpS1R13VluFFrd6HqbLrPuFzhfo1Dj
	hSZyc3D7tQBVFfV14rwgA62qsBqeoEs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792665696;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0BBSJq2bncADkRtb7hx5gATlQxkx+9xJoVkEfuHB1FE=;
	b=3tMRewIyAUtgD2xGLmRVC+VpkspMOMiVx62GeAKHHe41OO/rsH0BZdmJDFW0hsaQ9/yeUf
	+OoZcoF0kyUupYBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B4BE134E6;
	Thu, 22 Oct 2026 10:41:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yLLuCWDo2WrbNwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 22 Oct 2026 10:41:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E4C61A1417; Thu, 22 Oct 2026 12:41:35 +0200 (CEST)
Date: Thu, 22 Oct 2026 12:41:35 +0200
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 14/15] fs: reset the flag mask in vfs_clean_context()
Message-ID: <5yepcwmwjcmahw6ayr5xbojmnwhm7rptk5uppsqyidh4ppsxu4@siegumbvc6hn>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
 <20261011-work-super-fixes-core-v1-14-c727176c5b53@kernel.org>
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
In-Reply-To: <20261011-work-super-fixes-core-v1-14-c727176c5b53@kernel.org>
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:email]
X-Spam-Score: -12.80

On Sun 11-10-26 17:56:14, Christian Brauner wrote:
> vfs_clean_context() prepares a context for the next reconfiguration
> after fsmount() and after every successful FSCONFIG_CMD_RECONFIGURE. It
> resets fc->sb_flags but leaves fc->sb_flags_mask alone. So the next
> FSCONFIG_CMD_RECONFIGURE on that file descriptor applies the old mask
> to empty flags.
> 
> That makes a read-only superblock read-write without anyone asking for
> it:
> 
>   fsfd = fsopen("ext4", 0);
>   fsconfig(fsfd, FSCONFIG_SET_STRING, "source", "/dev/vda", 0);
>   fsconfig(fsfd, FSCONFIG_SET_FLAG, "ro", NULL, 0);
>   fsconfig(fsfd, FSCONFIG_CMD_CREATE, NULL, NULL, 0);
>   mntfd = fsmount(fsfd, 0, 0);
>   move_mount(mntfd, "", AT_FDCWD, "/mnt", MOVE_MOUNT_F_EMPTY_PATH);
>   fsconfig(fsfd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0);
> 
>   EXT4-fs (vda): re-mounted 68db7463-95cb-47f9-ab87-d1fd35252958 r/w.
> 
> The same happens for a second FSCONFIG_CMD_RECONFIGURE on a context
> from fspick() after the first one set "ro". The stale mask also drops
> SB_SYNCHRONOUS, SB_LAZYTIME and SB_MANDLOCK set in an earlier round.
> And btrfs_reconfigure() adds SB_POSIXACL to the mask when "acl" or
> "noacl" changes the ACL state so every later reconfiguration on that
> file descriptor fails with -EINVAL as reconfigure_super() refuses
> anything outside of MS_RMT_MASK.
> 
> Reset the mask as well so a cleaned context looks like a new one from
> fspick() just as the comment in sys_fsmount() promises.
> 
> Fixes: ecdab150fddb ("vfs: syscall: Add fsconfig() for configuring and managing a context")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Good catch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/fs_context.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/fs/fs_context.c b/fs/fs_context.c
> index a50584df97be..ba99e673458a 100644
> --- a/fs/fs_context.c
> +++ b/fs/fs_context.c
> @@ -544,6 +544,7 @@ void vfs_clean_context(struct fs_context *fc)
>  	fc->fs_private = NULL;
>  	fc->s_fs_info = NULL;
>  	fc->sb_flags = 0;
> +	fc->sb_flags_mask = 0;
>  	security_free_mnt_opts(&fc->security);
>  	kfree(fc->source);
>  	fc->source = NULL;
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
