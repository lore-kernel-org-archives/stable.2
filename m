Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793014754;
	b=Cdmj5JKH/iDN6fwcYdV335LsRzwgYqLeOSSOve2i18ESza5xGVPrHjxBsCZNSnysc5mY
	 nCKTBrBrhtAsMC90oMmtzKbftkvNStHervRNAqjqa7pEtnhymreRu81CBuW8lu5qT7S1E
	 FmwFQJ04RnUJb+TLHN0FVofs0+zRhA5PrTF/MnmgWV7tpTaCZBx3gRkl1z2tldfJVoXDK
	 ZxPMY+SgJ/e/Npf6eZy2VmwWOQR/eISD5Al9XhOfgOMxUME78i/71asm21e1mGjPO9zbI
	 3gu+IxvkBje2vdpPBoNgBrE6xia4f3ZSLScboNmAWqyU2UVCXxjZ3PRRNtBX8Kws4LQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793014754;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:
	 X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=5lzl3a2q3yo0vQ5DNzROwnjbKC32Dj14awVRc53VOJs=;
	b=WPJxKFs0kExPuGcQJwcOuPCNnSVE1xEypcIDv9IqfCPK640v04gZH5KUEZHnPokJFF+e
	 SIWeGdf6V0/QCa8LZxwhAuIYU0sIU8yQNTSzOTJzsaiwdQONkvl/9iTQLpIyV61iT6JWG
	 5KC/PGk9HB8MTmHsjS4hIx/sMLRUy4qrIqLerFJvjkCIdHEHSfh71QQcvGiiLBk926yT5
	 Cd9Nd8uNGhiRdzggWw9gXi9GAcfGMVuy7qP6tnVHCEKHh6v7hrorxtNCNyV83sMVTcKUL
	 MLChujZiec1dY1dYpFb6N85F19JwTKp6VvRyEweOQq5Q9JvCi/WOaRut4uwloJMM5EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=U9XGRtwP;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=q6vSWwaz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LVOAQol7;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TB17vIPY;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45E3606A33A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 11:39:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A45E3606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=U9XGRtwP;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=q6vSWwaz;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=LVOAQol7;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TB17vIPY
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6ED4821EEB;
	Mon, 26 Oct 2026 11:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793014744; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5lzl3a2q3yo0vQ5DNzROwnjbKC32Dj14awVRc53VOJs=;
	b=U9XGRtwPBKjdVclnfqvGZBVo1I2/7m+LRBoJ0Vs1RrWviTHpdVJAvtBiYPBhY31I+ghjbH
	jst0Tm+iEBYcf15MQXUcddhCuBAGLr/mBmIN2jVc7Xg47+TL5+ACR/09IX55cOcmHqRa1L
	CtXFc25nzhbKbE5VAw9GNi1ln/5DRW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793014744;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5lzl3a2q3yo0vQ5DNzROwnjbKC32Dj14awVRc53VOJs=;
	b=q6vSWwazTrBP8f9blH2NO+ztt8WSXQLyBBDDIZOa10bXziJctnQnGcyxXdrH7I5f7f0FF1
	m6Hmgx+4qlLRg5Bg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LVOAQol7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=TB17vIPY
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793014743; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5lzl3a2q3yo0vQ5DNzROwnjbKC32Dj14awVRc53VOJs=;
	b=LVOAQol7xoQrEusYksZpD0Kftmwpy7cbbOlg3s0M6ntEEU6cxSzZg1YeeANFp2aA15muFs
	REmVZ35icO59UPvxUB77Da4p0XSh5M7CAnCo8jyQ1auLgXXqbOAB71QbR5ISYHa6vUzcpP
	WWxMLqXQ8rfGslfGQ/bIVKnXgYaKshQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793014743;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5lzl3a2q3yo0vQ5DNzROwnjbKC32Dj14awVRc53VOJs=;
	b=TB17vIPY3aVaxbIuKRsj8vXl6PcAiJ3hOnJxXLIZhv6lDq62aAmwrvSzCM7FjAPeKaZkBc
	Trd3M0ex9IY8E7Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4426213408;
	Mon, 26 Oct 2026 11:39:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id MCniB9c732pxAgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 11:39:03 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C0FE9A1419; Mon, 26 Oct 2026 12:38:58 +0100 (CET)
Date: Mon, 26 Oct 2026 12:38:58 +0100
From: Jan Kara <jack@suse.cz>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz, 
	akpm@linux-foundation.org, dave.hansen@linux.intel.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] libfs: do not extend i_size when no data was copied
Message-ID: <ak7araqwhxjj67qmxrq4efjuuhnjudrr2bcc75i2ieqsvrqkkm@ryrg2hpu6wdt>
References: <20261025171130.16115-1-dennylin0707@gmail.com>
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
In-Reply-To: <20261025171130.16115-1-dennylin0707@gmail.com>
X-Rspamd-Queue-Id: 6ED4821EEB
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
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -13.01

On Sun 25-10-26 17:11:30, Hungyu Lin wrote:
> simple_write_end() updates i_size to pos + copied even when copied is
> zero. A failed buffered write past EOF can therefore extend a ramfs file
> without writing any data.
> 
> Since prefaulting was moved to the slow write path, this is reproducible
> with a one-byte pwrite() at offset 4096 into an empty ramfs file using an
> unreadable source buffer. The call fails with EFAULT but leaves the file
> size at 4096. generic_perform_write() calls ->write_end() with copied == 0
> before trying to fault in the source buffer.
> 
> Only extend i_size when data was copied. Keep the existing folio handling
> so that zero-progress retries and successful writes retain their current
> behavior.
> 
> Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/libfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/libfs.c b/fs/libfs.c
> index 8e2cc627bc7f..d889a4a14f41 100644
> --- a/fs/libfs.c
> +++ b/fs/libfs.c
> @@ -1007,7 +1007,7 @@ static int simple_write_end(const struct kiocb *iocb,
>  	 * No need to use i_size_read() here, the i_size
>  	 * cannot change under us because we hold the i_rwsem.
>  	 */
> -	if (last_pos > inode->i_size)
> +	if (copied && last_pos > inode->i_size)
>  		i_size_write(inode, last_pos);
>  
>  	folio_mark_dirty(folio);
> -- 
> 2.43.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
