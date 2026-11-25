Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795623753;
	b=vikA4kotKPqqgn5wj+sL0WOSNIfMjgPsvjdgG3Ta2S5Q2nQZbUR6SuxG5l8ZZ/i8kjEG
	 wa4Fc+ggl/1PVND0fY1hKrGSPTSQha2uRG7/BIXdQ+FNNIieQxPb8/Z1gF/SVT4j0NmXs
	 BzwHwzNu/VTCTBsZWlCZmjXPF6Z0107/eSZs4MyezMAy2fE6zd9l5RKHcqT45/+mqNruk
	 iziDVAHWU/1OSARR5Y1Ks4+vyCj6+kp5jyknNruAdIr3AeDyQIGuaAEdAjWePsEkCxG9b
	 7S+uM6rUtpHqNjRYYU2qoF4sPXSiuUctHfL7xU8w8s/KARBx2IwZAXdxLmXbNO9bHrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795623753;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=zO3jrdhEnmUIwCLxdDgA0M0mbsXtRg5HEy71KWF/dKo=;
	b=MfCqn6tSRuAGnBX3e0RfWj3rVCpTUiLZOS4bztF0Uzve0YTTWyrAEwCJ4sd2ugq4l5JM
	 1T7ZcPBuoUjqJfZOO1MPOh9DsnCJdEiZyYCsv0Q1oX4Gr46ezuX4JvmbNPIo65QNbcULG
	 kxvUzwLVpixZQzsH73PBsbcD59GXaU7j0MpUJuc9BMtlwwA/fo5DiPqAruHBtXJ2lov71
	 XCQmaZUIfY4/W9GWI0LtrVQmanQdz62mtT3eTab3FYBO3+nDGJwH0QMjtnKre0CprUGyR
	 hSgs98BYQNxBE08ESxcuGjUkzbfPF36vRdt967jJeJzGzb6JUpF9FyaHSg+HHNKLbkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=kPJTuCFA;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cCtEgoHt;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=P6m5Oicl;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WFbgdzp1;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9665606A31E;
	Wed, 25 Nov 2026 16:22:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9665606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=kPJTuCFA;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=cCtEgoHt;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=P6m5Oicl;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=WFbgdzp1
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E777222193;
	Wed, 25 Nov 2026 16:22:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795623750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zO3jrdhEnmUIwCLxdDgA0M0mbsXtRg5HEy71KWF/dKo=;
	b=kPJTuCFAMzVt/e5q1xwNrz9gl80d1Jt4Hrzsfg1o0t7diPubvcehoZZKCOTUAiXyB74xSp
	wANwtJMw26a2NsiYJZJe5J/dlVe7yAYvBYRb9KykFHsK1W94GpIGM4gbEVT5z4nLV4o8UE
	9AzdhORJAx1DY7kHW7XwaQcsNfUo38I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795623750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zO3jrdhEnmUIwCLxdDgA0M0mbsXtRg5HEy71KWF/dKo=;
	b=cCtEgoHtZrwTAFhmVwP8ROKhKJvDsmX0aVhPFIFanpseAQ7dJIbbh2Zdhd4Yy8OIgDLPrP
	n/tqyk+UbHEmKnBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1795623748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zO3jrdhEnmUIwCLxdDgA0M0mbsXtRg5HEy71KWF/dKo=;
	b=P6m5OiclXJsYUEF9sWPyt8NhNRZQBG07gWLfI5y2gQeh/Ekt3suqaPOOgjdoqK9VqzKBD7
	CLcAUp1u3aSQjC4CT8NN4voYNIUHSu6MxyLH0jUMjK4TMezlO8nEtrHFj/Yuwxgi1DYK+q
	iUkX2tF7Wvpl3h9aEYvZlJbcs2fAAJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1795623748;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zO3jrdhEnmUIwCLxdDgA0M0mbsXtRg5HEy71KWF/dKo=;
	b=WFbgdzp1HwA539nqqiTRkQ0+AyjPPR8bDP7R4dPmbXDtkwVYu2trC2ki8eIZDqZnW1LlIr
	zRViLsJMFkifAzCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C6E80134CA;
	Wed, 25 Nov 2026 16:22:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 50wyKkQLB2uNXQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 25 Nov 2026 16:22:28 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 6288B27CBB; Wed, 25 Nov 2026 17:22:20 +0100 (CET)
Date: Wed, 25 Nov 2026 17:22:20 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>, 
	Josef Bacik <josef@toxicpanda.com>, linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] libfs: don't copy the child's ctime to the parent
 directory
Message-ID: <p6qdkphjcljduzvkw6ljnrmwqfefo7vmo3i6doyzc2ejcmgfuw@2yzyh4ububgq>
References: <20261125-work-libfs-mgtime-v1-0-8022a81d0b9e@kernel.org>
 <20261125-work-libfs-mgtime-v1-1-8022a81d0b9e@kernel.org>
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
In-Reply-To: <20261125-work-libfs-mgtime-v1-1-8022a81d0b9e@kernel.org>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	URIBL_BLOCKED(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Wed 25-11-26 13:04:27, Christian Brauner wrote:
> simple_link() and __simple_unlink() copy the child's new ctime into the
> parent directory. With multigrain timestamps that ctime is only
> fine-grained if the child was queried and copying it drops the parent's
> I_CTIME_QUERIED flag. So a queried tmpfs directory keeps its ctime and
> mtime across link(), unlink() and rmdir() as long as the coarse clock
> hasn't ticked. shmem_rename2() unlinks the victim of a rename the same
> way, so a rename over an entry from another directory changes nothing
> at all that userspace could see, size and link count included.
> 
> Give the directory its own inode_set_ctime_current() call.
> 
> Fixes: 234d8895e3ad ("tmpfs: add support for multigrain timestamps")
> Cc: stable@vger.kernel.org # v6.13+
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Good catch! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/libfs.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 96a6e9b1535fb..07331e829c133 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -754,8 +754,8 @@ int simple_link(struct dentry *old_dentry, struct inode *dir, struct dentry *den
>  {
>  	struct inode *inode = d_inode(old_dentry);
>  
> -	inode_set_mtime_to_ts(dir,
> -			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
> +	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
> +	inode_set_ctime_current(inode);
>  	inc_nlink(inode);
>  	ihold(inode);
>  	d_make_persistent(dentry, inode);
> @@ -788,8 +788,8 @@ void __simple_unlink(struct inode *dir, struct dentry *dentry)
>  {
>  	struct inode *inode = d_inode(dentry);
>  
> -	inode_set_mtime_to_ts(dir,
> -			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
> +	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
> +	inode_set_ctime_current(inode);
>  	drop_nlink(inode);
>  }
>  EXPORT_SYMBOL(__simple_unlink);
> 
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
