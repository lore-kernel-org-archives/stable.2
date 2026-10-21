Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792595560;
	b=gKx7f9CtzjS2L4T7TZq0UflkH+aeNvD2vUxCbN+Bn8H0J00DF5YkDyAnpZURe3F95Ye5
	 rrZQWbcD3HUygMBlYRto29io5cazJLmpmFeDbCgI1uIck6rn1kLFRkb4K6wZHADcLp/0O
	 ib3Uey5mCbeyfKs8S7e/4Dpeo1N1ItIHexPJVHjBFD6IuPIw0CekRwfl4rgxZU2haGwdi
	 C6THJa8bF/TEtRffOxYlCS6EuZZpkA00R84drp6ZW6ZxU2m/NJEEZUq++vofw+S/kSkEa
	 VaTPlOjK5nQGcCYeVcfMvwWi8P8u9RuukbUgclOn7uoAjnE8FILThXlz5f+8f9+9aXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792595560;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=JLZamb2QjKCTzcKQQ3RteLsTsOXTxF3zEYzjuWfe96k=;
	b=gr4fzTqgysoa/0Bv42wwYzAp7cHPajiZeqgOLvStYoR+O/BrcKD+Nnye1Jny3DPGMGSD
	 wTDEIF7ZQqbT2YLEF8zIVShTG3mR6sIEk1mfHYkAXUgNVG3XfFp4sYCDLhjXgwz07Ab35
	 8hs4qRcPqA26/465wLj7PilP7L15EIHlSk3GETSRL321SkPoPY1i85Bt76sGrUoZNAIel
	 4gp3QhpAbVyEPOMvjHGC9/8Fm7LrOvz2vQhwooMeEZILxQ1Qp5uvDIiaBn+I9/fYhEq+Y
	 O81lpcMlR/IFnchuZbxcqAb8eNafDqwMdpmGL8eBFFHh0miQSQwo4RX3/U1eGu3DITg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=NCajc3Td;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9EWMINU2;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=NCajc3Td;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9EWMINU2;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71E2606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 15:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C71E2606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=NCajc3Td;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9EWMINU2;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=NCajc3Td;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=9EWMINU2
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 140C521F9C;
	Wed, 21 Oct 2026 15:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792595551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLZamb2QjKCTzcKQQ3RteLsTsOXTxF3zEYzjuWfe96k=;
	b=NCajc3TdrPnCrX9e3Rfrc407Fo5pwsRwu9CbCU8cWkCp5fWQfeG+Ak2pvYYhGdQwsdxEto
	psLUsZ5JJa3fGx2bPNdNtEw/WdA9XjBtA15h1hX5WW23tVx74ckJ+VH8KfPNcf0+5krTLM
	+W+TVaWBP/mD374Jkq6OdYUe6TcTtog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792595551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLZamb2QjKCTzcKQQ3RteLsTsOXTxF3zEYzjuWfe96k=;
	b=9EWMINU2cYkDwbqYEketlORbh1dsfgaaJMqavOafUaFA/x6uAy8Ej+diYXe52DWddRkcM1
	mLSl+OI5dmbws2Aw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792595551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLZamb2QjKCTzcKQQ3RteLsTsOXTxF3zEYzjuWfe96k=;
	b=NCajc3TdrPnCrX9e3Rfrc407Fo5pwsRwu9CbCU8cWkCp5fWQfeG+Ak2pvYYhGdQwsdxEto
	psLUsZ5JJa3fGx2bPNdNtEw/WdA9XjBtA15h1hX5WW23tVx74ckJ+VH8KfPNcf0+5krTLM
	+W+TVaWBP/mD374Jkq6OdYUe6TcTtog=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792595551;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JLZamb2QjKCTzcKQQ3RteLsTsOXTxF3zEYzjuWfe96k=;
	b=9EWMINU2cYkDwbqYEketlORbh1dsfgaaJMqavOafUaFA/x6uAy8Ej+diYXe52DWddRkcM1
	mLSl+OI5dmbws2Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E241D134A5;
	Wed, 21 Oct 2026 15:12:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mSRoMF7W2GpFAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 21 Oct 2026 15:12:30 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 73A8AA13C6; Wed, 21 Oct 2026 17:12:26 +0200 (CEST)
Date: Wed, 21 Oct 2026 17:12:26 +0200
From: Jan Kara <jack@suse.cz>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: jack@suse.cz, linux-ext4@vger.kernel.org, tytso@mit.edu, 
	adilger.kernel@dilger.ca, libaokun@linux.alibaba.com, linux-kernel@vger.kernel.org, 
	ojaswin@linux.ibm.com, ritesh.list@gmail.com, stable@vger.kernel.org, 
	yi.zhang@huawei.com
Subject: Re: [PATCH v2] ext4: clear in-inode xattr space before adding the
 first xattr
Message-ID: <6pxvr4arcsittsvr22z453es734tmw3th5adedekcmeyrzs5r6@bgd7kpmspm75>
References: <20261021085635.3633692-1-r772577952@gmail.com>
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
In-Reply-To: <20261021085635.3633692-1-r772577952@gmail.com>
X-Spamd-Result: default: False [-11.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_RCPT(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.com:email];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.cz,vger.kernel.org,mit.edu,dilger.ca,linux.alibaba.com,linux.ibm.com,gmail.com,huawei.com];
	RCPT_COUNT_SEVEN(0.00)[11];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.30
X-Spam-Level: 
X-Spam-Flag: NO

On Wed 21-10-26 16:56:35, Jiaming Zhang wrote:
> An inode can hold extended attributes in the space that follows its extra
> fields, whose size is given by i_extra_isize.  When ext4 loads an inode,
> ext4_iget_extra_inode() validates that space only if it starts with the
> xattr magic, and only then sets EXT4_STATE_XATTR.  Without the magic, the
> space is treated as empty and is not checked.
> 
> ext4_xattr_ibody_set() passes the space to ext4_xattr_set_entry() whether
> or not EXT4_STATE_XATTR is set.  ext4_xattr_set_entry() walks the entries
> there to find min_offs, the lowest value offset.  That offset decides
> whether the new value fits and where the value is copied:
> 
> 	free = min_offs - ((void *)last - s->base) - sizeof(__u32);
> 	...
> 	void *val = s->base + min_offs - new_size;
> 
> A crafted image can leave non-zero bytes in that space without the magic
> where ext4 looks for it, for example by shrinking i_extra_isize.  Those
> bytes are parsed as entries, and an entry that claims an in-inode value at
> offset 0 sets min_offs to 0.  Because free is a size_t, the subtraction
> then wraps around to a huge value, and the free space check passes although
> the value does not fit.  The value is copied new_size bytes before the
> start of the space, over the inode's own fields and, for a large value, the
> memory in front of the inode.
> 
> On a kernel without KASAN, the copy corrupts memory: it overwrites the
> inode's own fields and, for a large value, also the memory in front of the
> inode.  The bytes and their length are decided by the setxattr() caller.
> Nothing is freed and reused here, so the use-after-free in the report only
> reflects where the write happened to land.
> 
> Triggering this issue requires mounting a crafted image, which needs
> CAP_SYS_ADMIN or automounting of removable media; after that, any
> setxattr() on the file reaches this path.  The issue was found by fuzzing
> and has not been seen in production; a reproducer is available in the
> linked report.
> 
> When EXT4_STATE_XATTR is not set, zero the first 32 bits of the space in
> ext4_xattr_ibody_set() before calling ext4_xattr_set_entry().  These are
> the bits IS_LAST_ENTRY() reads, so the space is treated as empty and the
> walk stops before reading any stale entry.
> 
> Fixes: ac27a0ec112a ("[PATCH] ext4: initial copy of files from ext3")
> Closes: https://lore.kernel.org/lkml/CANypQFZzxTAH=4QRRDoqH6VAw1daAq88NDWiQKoM7QTOnP40sg@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude Code:claude-opus-5-5
> Signed-off-by: Jiaming Zhang <r772577952@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Changes in v2:
> - Zero only the first 32 bits space instead of the whole space.
> - Add a comment above the check.
> - v1: https://lore.kernel.org/lkml/20260916084723.877552-1-r772577952@gmail.com/
> 
>  fs/ext4/xattr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 5c310747b965..8e1fd26329d3 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -2274,6 +2274,14 @@ int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
>  		if (IS_ERR(ea_inode))
>  			return PTR_ERR(ea_inode);
>  	}
> +
> +	/*
> +	 * Make sure xattr space is properly initialized so that
> +	 * IS_LAST_ENTRY() returns true for its first entry
> +	 */
> +	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR))
> +		*(__u32 *)s->first = 0;
> +
>  	error = ext4_xattr_set_entry(i, s, handle, inode, ea_inode,
>  				     false /* is_block */);
>  	if (error) {
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
