Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794396405;
	b=zCErnLe37tyNsvBspj1lf2MJVnFYCpxgeE4XcuHtwiar3pQKxBAAo6V3Be2/bDt+1IfQ
	 rgJolzWaMjN8qRCYSDB7//KgfCXUq8+Eb0SYN5t75ntjGDCykA7Ak8zm3LY8pGOrzBrDo
	 gZI1ZSTjmH9LIO7fFR4iBXfSaz7qChs+IXKHUsoQVjlum6i5Gi29OoRR/6I1pZtc+j+WS
	 IKFS/2W3ct2LwXbkRYSVqm2IyK+gWWKrEGMRlBh1+eXsvU1wPbSmHNs/FZmjC/iuyWLRW
	 x1VazVZTCdnJrQ/4rYSGeJbIoi42ypNAS6zVAdGQLTNU85NWKh8t150zzJdGhnS2QlQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794396405;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=lPuIhmSrl9cFTbYvAZEEYsYaxcd/tmKwtfJ+lX0zRCM=;
	b=EyyQtG+OV8fChHs1hJiSO0S1P7hErQWoShaIyA7jDvUAOtqHIyA01IPNRoe17ZXeeAOB
	 qLuqKa5AfE6aSbNpIiKBdXfXbllvyTo9R+ZSrUWShqphvOWBwoTrHZVx7uCvQBg2PJvgM
	 6RkurZvSxEujmaO9IY34BMud90+2sH8L0/70OIIGJwOqABplqhie5PmIXw7UjurO66PFj
	 GDxs/EywOf893QvV8Z0DA0ptJrMfy7jTHLEwBYO9wLUQmMAbJ6tO7BNRDLIfxbhQ335NN
	 tXMxjupIKGzoXzVETDBim9JiG2Tw3BYtOA+mwGEBEunig3aZ4zA7TmlgMMtTlVWWF7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=X0Xx3Ph1;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=K+gARkJe;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=prrQhKF2;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KXIiKUuO;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FCE606A32D;
	Wed, 11 Nov 2026 11:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11FCE606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=X0Xx3Ph1;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=K+gARkJe;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=prrQhKF2;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KXIiKUuO
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 450F121EC5;
	Wed, 11 Nov 2026 11:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794396402; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPuIhmSrl9cFTbYvAZEEYsYaxcd/tmKwtfJ+lX0zRCM=;
	b=X0Xx3Ph1RL7yyl0bgh0EdfJINhKDovUuXMNiX29nsK0p5xRu11jf6bb2llA6tzVx2hc6/M
	FYQwSPnfmSpQH54eO7qysTmf39coBAtVCtD6Y6PC9LLycAyAy3ZEWkeCkK/XL3Obxovnp0
	U8vQulyIW0AyixFiAtQ+DAedlgEEfYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794396402;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPuIhmSrl9cFTbYvAZEEYsYaxcd/tmKwtfJ+lX0zRCM=;
	b=K+gARkJedN0/FIRhvLBihuHJNoaHg1UnjNf/8krjU/EP429f2VFsUMAzw2sqyYCElxRBzJ
	GIiPF8IaIYOs2GDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=prrQhKF2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KXIiKUuO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1794396401; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPuIhmSrl9cFTbYvAZEEYsYaxcd/tmKwtfJ+lX0zRCM=;
	b=prrQhKF2uOCkJhuxk4eJLGyooI2S+ud/bJjnY1+5AdlLJN1kJBfQdUC8Jo6dhEZTdMgP99
	+t8HuUnycJXzAYPWRzWxNwIH6a815OI0Emc5kAGWfAbBXGrAXnhyOSq/wihfF0CeLNRLJX
	Pwq32YEB6Lza2XuMVPzj5eSrqxZjoNQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1794396401;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lPuIhmSrl9cFTbYvAZEEYsYaxcd/tmKwtfJ+lX0zRCM=;
	b=KXIiKUuO4YFM5mPzQqVcbfRcSNJwc+LCV0VgwpukObrKfqM/NKcmGPb+OpZgyr2q0msrQq
	3kYxpJBqdwGaJZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0FCC81339F;
	Wed, 11 Nov 2026 11:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id X99DMvBQ9GpEUAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 11 Nov 2026 11:26:41 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 7C9FA225E2; Wed, 11 Nov 2026 12:26:40 +0100 (CET)
Date: Wed, 11 Nov 2026 12:26:40 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
	Andreas Gruenbacher <agruenba@redhat.com>, gfs2@lists.linux.dev
Subject: Re: [PATCH 09/15] fs: don't keep a device frozen when its freeze is
 already gone
Message-ID: <ykvx5guei6k257e5vguypioskss5i33x4oetgvil2kp2uslgjn@6ur5fqi36psh>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
 <20261011-work-super-fixes-core-v1-9-c727176c5b53@kernel.org>
 <yl2umpbk6fnz2soh7fi5xellmovarx6ouxrvf4ki5xxledmihx@gjldiqbxpufn>
 <20261110-innenansicht-lohnen-rupfen-dec970baed12@brauner>
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
In-Reply-To: <20261110-innenansicht-lohnen-rupfen-dec970baed12@brauner>
X-Rspamd-Queue-Id: 450F121EC5
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
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -13.01

On Tue 10-11-26 16:43:57, Christian Brauner wrote:
> On Thu, Oct 22, 2026 at 12:33:29PM +0200, Jan Kara wrote:
> > I'd just note that interpretting EINVAL from ->thaw_super is a bit of
> > an adventure but so far only gfs2 implements that and that looks safe.
> > Using some less abused error code to mean "already thawed" would be
> > probably more robust in the long run...
> 
> Something like the below?
> 
> From: Christian Brauner <brauner@kernel.org>
> Date: Tue, 10 Nov 2026 16:39:31 +0100
> Subject: [PATCH] super: return -EALREADY for a thaw that finds nothing to drop
> 
> thaw_super_locked() returns -EINVAL when the superblock isn't frozen and
> also when it is frozen but not by the holder that asks to thaw it. gfs2's
> ->thaw_super() returns -EINVAL as well when this node never initiated the
> freeze. So when fs_super_thaw() thaws the superblocks of a block device
> whose freeze is gone already -EINVAL from ->thaw_super() is all it has
> to go on and it has to guess that this is what happened.
> 
> Use -EALREADY for a thaw that has nothing to drop. Nothing in the freeze
> and thaw code returns it so far and it clearly communicates what
> happened. A freeze that is held by someone else keeps returning -EINVAL.
> 
> FITHAW has always reported an unfrozen filesystem as -EINVAL and
> fsfreeze and qemu-guest-agent rely on that, so ioctl_fsthaw()
> translates. The other in-kernel callers thaw their own kernel freezes
> and pass the error on without looking at it.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/r/yl2umpbk6fnz2soh7fi5xellmovarx6ouxrvf4ki5xxledmihx@gjldiqbxpufn
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Yep. Thanks! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  Documentation/filesystems/vfs.rst |  4 +++-
>  fs/gfs2/super.c                   |  2 +-
>  fs/ioctl.c                        | 10 ++++++++--
>  fs/super.c                        | 11 ++++++++---
>  4 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> index 1824462a43711..e6d332fa17be9 100644
> --- a/Documentation/filesystems/vfs.rst
> +++ b/Documentation/filesystems/vfs.rst
> @@ -294,7 +294,9 @@ or bottom half).
>  
>  ``thaw_super``
>  	called when VFS is unlocking a filesystem and making it writable
> -	again after ->freeze_super. Optional.
> +	again after ->freeze_super. Optional. Return -EALREADY if there is
> +	no freeze to drop. The VFS relies on that when it thaws the
> +	filesystems of a block device.
>  
>  ``unfreeze_fs``
>  	called when VFS is unlocking a filesystem and making it writable
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index 04bb4cf787d4d..ce0eb4d1a7031 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -806,7 +806,7 @@ static int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who,
>  		return -EBUSY;
>  	if (!test_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags)) {
>  		mutex_unlock(&sdp->sd_freeze_mutex);
> -		return -EINVAL;
> +		return -EALREADY;
>  	}
>  
>  	atomic_inc(&sb->s_active);
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 1c152c2b1b67d..56acaa122ec4d 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -402,14 +402,20 @@ static int ioctl_fsfreeze(struct file *filp)
>  static int ioctl_fsthaw(struct file *filp)
>  {
>  	struct super_block *sb = file_inode(filp)->i_sb;
> +	int error;
>  
>  	if (!ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
>  		return -EPERM;
>  
>  	/* Thaw */
>  	if (sb->s_op->thaw_super)
> -		return sb->s_op->thaw_super(sb, FREEZE_HOLDER_USERSPACE, NULL);
> -	return thaw_super(sb, FREEZE_HOLDER_USERSPACE, NULL);
> +		error = sb->s_op->thaw_super(sb, FREEZE_HOLDER_USERSPACE, NULL);
> +	else
> +		error = thaw_super(sb, FREEZE_HOLDER_USERSPACE, NULL);
> +	/* FITHAW has always reported an unfrozen filesystem as -EINVAL. */
> +	if (error == -EALREADY)
> +		error = -EINVAL;
> +	return error;
>  }
>  
>  static int ioctl_file_dedupe_range(struct file *file,
> diff --git a/fs/super.c b/fs/super.c
> index cd6f57ababe08..72ffa5527dda2 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -1640,8 +1640,8 @@ static int fs_super_thaw(struct super_block *sb)
>  	if (sb->s_op->thaw_super) {
>  		error = sb->s_op->thaw_super(sb,
>  				FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE, NULL);
> -		/* -EINVAL means the freeze is gone already. */
> -		if (error == -EINVAL)
> +		/* The freeze is gone already. */
> +		if (error == -EALREADY)
>  			return 0;
>  		return error;
>  	}
> @@ -2587,8 +2587,11 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
>  {
>  	int error = -EINVAL;
>  
> -	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE)
> +	/* There's no freeze to drop. */
> +	if (sb->s_writers.frozen != SB_FREEZE_COMPLETE) {
> +		error = -EALREADY;
>  		goto out_unlock;
> +	}
>  
>  	if (!may_unfreeze(sb, who, freeze_owner))
>  		goto out_unlock;
> @@ -2652,6 +2655,8 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
>   * A filesystem may hold multiple devices and thus a filesystems may
>   * have been frozen through the block layer via multiple block devices.
>   * The filesystem remains frozen until all block devices are unfrozen.
> + *
> + * Returns -EALREADY if the filesystem isn't frozen.
>   */
>  int thaw_super(struct super_block *sb, enum freeze_holder who,
>  	       const void *freeze_owner)
> -- 
> 2.53.0
> 
> 
> -- 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
