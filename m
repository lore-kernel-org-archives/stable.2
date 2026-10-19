Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465AF48E0D4;
	Mon, 19 Oct 2026 11:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408152; cv=none; b=G2eHVzGUzahhN1p53on9a2GpbkzcAqMSL4QgrMHa8TkiaIh875HePAygSfixsSj19fBVRfeiIvs7WB5lq3i1fzWS5GQuEGxOv52yB1/Xhg7Ed6eSOyYIIV4+uyi7rww0IwzyU9sKpRJQeVVnhHmlg0YEX7U+uTSDnS2Hiq3fy4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408152; c=relaxed/simple;
	bh=YKS1uBvejftmHFx6jUhtuLNG/o/oax5eGbeAyHS/iF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cRuv8tN1/OGGOcX6iM1R2WvXhv4/rVme0eluz0vKpsKfNpMxECtPog3gORyyZPzAlYtFu2ZN4hIGb6bpLA0rmEp8EGEoFCQoDPiXh4GmEQgJQme5YjbMg9z2J4+u3PGJMgXRR4zfEFKjAZ7EJTgh7bocoVN3wA/aW2TL1E3HNIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uBSHOhtp; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kCVNaaB7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CXRSV57l; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=68FWpfje; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uBSHOhtp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kCVNaaB7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CXRSV57l";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="68FWpfje"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 28DDA21C92;
	Mon, 19 Oct 2026 11:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792408149; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11z2qWpi42Rwu8TO6o4vcVqXgXps69LtjAEf/dfd4gs=;
	b=uBSHOhtp3N7zzu3OgYJq++zleXKxOfWKjoAcx+1adMUV32u8cf/syk7A1pQTgWe/RqbXJw
	OsY5yJUHMKn3ovxDw2CQ8zSCZahYL3r3P6P1uOVxmFT179ii8QAbJsj7bolDLMjSNbfKnd
	7p5Nnx6jV2pBSCAk0gSg289OTex6NTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792408149;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11z2qWpi42Rwu8TO6o4vcVqXgXps69LtjAEf/dfd4gs=;
	b=kCVNaaB7xxJF1vWsrl2M4Xd5XpSBb6HmwIA34PJkN7xKQLC0udKbkUcAsIMQ2Ss9y7deQu
	AAo70dVcO77nlQCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CXRSV57l;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=68FWpfje
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1792408148; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11z2qWpi42Rwu8TO6o4vcVqXgXps69LtjAEf/dfd4gs=;
	b=CXRSV57lKvfRhATV4ut3Akmw4hB9UONE1lZXC5L9sfHFMzUY0V6Ii7C/var7jbJhNeV6QI
	3a1v7F5tuBMRw78zrxJFdWJklOTDZa2gL/exbjmNLfYO+KJxfOKSMszq5gDD3JwBkoH0H8
	x8YJemM+a+0RM7ofEavbbSLJMMFlBNE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1792408148;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=11z2qWpi42Rwu8TO6o4vcVqXgXps69LtjAEf/dfd4gs=;
	b=68FWpfjeq6UcQMaP3zVS3ajhrCp2oNgj+QGpTbM8zPio3CAqV0Fyr+x5Q33EL1eLvxbRfz
	PsvkCEiXB086MSBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F1E7F134B3;
	Mon, 19 Oct 2026 11:09:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id O4YyM1P61WrlFAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 19 Oct 2026 11:09:07 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8311CA1413; Mon, 19 Oct 2026 13:09:03 +0200 (CEST)
Date: Mon, 19 Oct 2026 13:09:03 +0200
From: Jan Kara <jack@suse.cz>
To: Nikolaos Karaolidis <nick@karaolidis.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Zhihao Cheng <chengzhihao1@huawei.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs: rotate inodes whose page cache could not be dropped
Message-ID: <n6urwkuqd2vr6ednnp64y2a7tbgobbdwmog5i3plxtidb2goq3@ph52n25jnu7y>
References: <20261016102515.111285-1-nick@karaolidis.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261016102515.111285-1-nick@karaolidis.com>
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,zeniv.linux.org.uk,suse.cz,huawei.com,gmail.com,vger.kernel.org,kvack.org];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,karaolidis.com:email,suse.cz:email,suse.cz:dkim,suse.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Rspamd-Queue-Id: 28DDA21C92
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Fri 16-10-26 10:25:15, Nikolaos Karaolidis wrote:
> When inode_lru_isolate() drops the page cache of an unused inode, it
> has to unlock the list, so it returns LRU_RETRY and the walk restarts
> at the head of the list, where the inode still is. If
> invalidate_mapping_pages() could not empty the mapping, the restarted
> walk strips the same inode again, and so on until nr_to_walk runs out.
> Every walk of that list then ends on this inode, and nothing behind it
> is reclaimed for as long as its cache stays.
> 
> Before commit 2a0629834cd8 ("vfs: Don't evict inode under the inode lru
> traversing context") the walker pinned the inode with a reference, and
> dropping it in iput_final() set I_REFERENCED, so the restarted walk
> rotated the inode to the tail. Set I_REFERENCED again when the mapping
> is still populated after the invalidation, in the same i_lock section
> that clears I_LRU_ISOLATING. inode_unpin_lru_isolating() now expects
> i_lock to be held, like inode_pin_lru_isolating().
> 
> On CONFIG_HIGHMEM kernels this can happen to any unused inode: a folio
> is left behind if it is locked, under writeback, spliced into a pipe,
> or still in another CPU's LRU-add batch after being read. Without
> HIGHMEM it happens to DAX inodes whose only entry is at index 0, which
> mapping_shrinkable() lets onto the LRU and invalidate_mapping_pages()
> never removes.
> 
> Fixes: 2a0629834cd8 ("vfs: Don't evict inode under the inode lru traversing context")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Nikolaos Karaolidis <nick@karaolidis.com>

Looks sensible. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza


> diff --git a/fs/inode.c b/fs/inode.c
> index a9d37be390a1..1614a97ce953 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -593,12 +593,11 @@ static void inode_pin_lru_isolating(struct inode *inode)
>  
>  static void inode_unpin_lru_isolating(struct inode *inode)
>  {
> -	spin_lock(&inode->i_lock);
> +	lockdep_assert_held(&inode->i_lock);
>  	WARN_ON(!(inode_state_read(inode) & I_LRU_ISOLATING));
>  	inode_state_clear(inode, I_LRU_ISOLATING);
>  	/* Called with inode->i_lock which ensures memory ordering. */
>  	inode_wake_up_bit(inode, __I_LRU_ISOLATING);
> -	spin_unlock(&inode->i_lock);
>  }
>  
>  static void inode_wait_for_lru_isolating(struct inode *inode)
> @@ -981,7 +980,13 @@ static enum lru_status inode_lru_isolate(struct list_head *item,
>  		else
>  			__count_vm_events(PGINODESTEAL, reap);
>  		mm_account_reclaimed_pages(reap);
> +
> +		spin_lock(&inode->i_lock);
> +		/* The walk restarts here: don't retry leftovers right away */
> +		if (!mapping_empty(&inode->i_data))
> +			inode_state_set(inode, I_REFERENCED);
>  		inode_unpin_lru_isolating(inode);
> +		spin_unlock(&inode->i_lock);
>  		return LRU_RETRY;
>  	}
>  
> 
> base-commit: af32da41b0327b9c6a37856ba82b6760d6c8d10e
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
