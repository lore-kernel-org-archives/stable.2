Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F2442393;
	Mon,  7 Sep 2026 09:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774331; cv=none; b=ojGUA+cd/5ObmrZWztVXYG1Ddf0GxzFUD092zH0Jnp9gvzzSbp6P907UBwh4BgjyFgUj7YFqA9fsK0Fukn1EhmS+zLPJ5mUTghHu03mMtpm7fDMLloIK43XujpVqBMHCbvXEY72Gho7nxPfkgD9o151MwQIf8oa6kUKyx/hjrW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774331; c=relaxed/simple;
	bh=aFMxlYIEr10mLBc7x0/wwlHNnkqEkXrtV230o1PAo5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gXMWbD4oDT3O9+RErIzzYkvEbwGOMCn/nAA/1i19FUDgIDtStfNaNDsJlZ3f4EvnNi3en62eUHKQRDKUgYLGhiZJGkBSD8aBA59vtQM3V6x4+GJIdq95Kr2c386tu5FyiSFJ/yXT4gZl3GutvQzR2nxwJ3px4iKPCs8JV9+9GQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wBQtCOO8; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=o4lmmul7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=nI5wW2TB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=QhPIsXQU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wBQtCOO8";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="o4lmmul7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="nI5wW2TB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="QhPIsXQU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DD55D1F387;
	Mon,  7 Sep 2026 09:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788774324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TK18g6cC4GqXBbeIEtDDxGQ3nIY8al02NrXM6/w1y30=;
	b=wBQtCOO8jv8Sup2KrEujrraHWxWIeH8yNfYNnnOvGS6o4yDUYc3qWX+8+0WC2rdraoevyt
	E/1+/DdkM1RQk3nYxX6SCiEr7FJlY7DckMVr76SKCQSfvxdxLqWqSyifj3L43AaY6hdVU9
	PfDIVM1Te0HNhblztCriN6U0drZt6iI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788774324;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TK18g6cC4GqXBbeIEtDDxGQ3nIY8al02NrXM6/w1y30=;
	b=o4lmmul7lMOPbPvq4TA4XZjEpxtxN8/V0TgY14kY57Ogxd2vak4LRaQhL9iRlbxA2SNh7w
	RNG/U4ahJ/ZfG1DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788774319; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TK18g6cC4GqXBbeIEtDDxGQ3nIY8al02NrXM6/w1y30=;
	b=nI5wW2TBXKEDbCy48a44C3k37yi6Ese8kG/pJC3073WmzGkU8tkxu5wdKUebb6PRJrpQIg
	qsr1//KSTjSDF5pxWUABOai0ajQTHIB/OwpezF4qDsFTRAoG6c3jTse5PkWIY7yKizxMdJ
	XeJd52reJ6nUHQGeCoLYf0xfWKAmeWc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788774319;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TK18g6cC4GqXBbeIEtDDxGQ3nIY8al02NrXM6/w1y30=;
	b=QhPIsXQU28dWqTbr1U2rjs5DSZUYwXQyjN2F4PmMmMydex7UH0YLD9I3X7/OdLlz8qpjeq
	oR+hqy8OnyMIskDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD37313432;
	Mon,  7 Sep 2026 09:45:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id kSUsLq+HnmpZDQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 07 Sep 2026 09:45:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 57EDBA13B2; Mon, 07 Sep 2026 11:45:19 +0200 (CEST)
Date: Mon, 7 Sep 2026 11:45:19 +0200
From: Jan Kara <jack@suse.cz>
To: Tao Cui <cui.tao@linux.dev>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, andrii.nakryiko@gmail.com, 
	linux-kernel@vger.kernel.org, Tao Cui <cuitao@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH] fs: reject U64_MAX as last_mnt_id in listmount()
Message-ID: <vwmaviizpdpjwi5rf4gj65wmge5xj4rivhsissnxf7qytztzxr@qsphr7wj4h76>
References: <20260907065724.1355551-1-cui.tao@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907065724.1355551-1-cui.tao@linux.dev>
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,zeniv.linux.org.uk,kernel.org,suse.cz,gmail.com,kylinos.cn];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,kylinos.cn:email]

On Mon 07-09-26 14:57:23, Tao Cui wrote:
> From: Tao Cui <cuitao@kylinos.cn>
> 
> listmount() uses mnt_id_req::param as a pagination cursor: on forward
> iteration do_listmount() starts from the first mount with an id strictly
> greater than last_mnt_id.  The sanity check in prepare_klistmount() only
> rejects ids in the range [1, MNT_UNIQUE_ID_OFFSET]; U64_MAX passes the
> check, and incrementing it wraps back to 0, so mnt_find_id_at() restarts
> from the leftmost mount in the namespace every time.
> 
> A caller paging with last_mnt_id set to U64_MAX therefore always gets
> the same first batch of ids returned and can never advance to the end of
> the list:
> 
>   # base: every call returns the same first batch
>   listmount(param=U64_MAX) = 8 ids: 2147483886 2147483888 ...
>   # patched:
>   listmount(param=U64_MAX) = -1 EINVAL
> 
> Reject U64_MAX up front together with the other invalid ids.
> 
> Fixes: b4c2bea8ceaa ("add listmount(2) syscall")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tao Cui <cuitao@kylinos.cn>

This looks OK, but I think we should reject U64_MAX only if
LISTMOUNT_REVERSE flag is not set? With this flag specifying U64_MAX
actually makes sense and it is likely used by people?

								Honza

> ---
>  fs/namespace.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index 8d4009cfbf5b..cb95b855f78b 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -6108,6 +6108,9 @@ static inline int prepare_klistmount(struct klistmount *kls, struct mnt_id_req *
>  	/* The first valid unique mount id is MNT_UNIQUE_ID_OFFSET + 1. */
>  	if (last_mnt_id != 0 && last_mnt_id <= MNT_UNIQUE_ID_OFFSET)
>  		return -EINVAL;
> +	/* U64_MAX would wrap to 0 and restart the iteration. */
> +	if (last_mnt_id == U64_MAX)
> +		return -EINVAL;
>  
>  	kls->last_mnt_id = last_mnt_id;
>  
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
