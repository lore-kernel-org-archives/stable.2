Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976695;
	b=tYtNOO/6zymomT9YHAsBlLi5tYs7zpI9R7IOGeo9jN8rckR5k2oLjMKBm/NZfpS74cQd
	 t1Q5CD07fAArKY207KqgopAFOPVNFt/TH8duVYkWhG3NdFBVdBRX2Xi8iOxkMzqeCJHDa
	 /XqGOTiDzqh4e3QNcQtnaQxIEN3OnQdhoXREyPz+5IHYF/Fdnt2FF5f0vaLN630e5Aa+H
	 4UK4TdKdXCM0cVMTrYs2AHYY+T/QHE9GSX8AL7zv0udGPfylT7NEG5870Er2WD9Q5Mb6Q
	 7OgJ0rnpIe4lItI0+unpAOVk8fgV/0yK4GAQY780l+xCuwRb9G1Wy/nV1gSPp/CU2pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976695;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=4/Drp7ifQeUDYwHgL1y7yzB8cVXQQt4dJhK1PJvWBeQ=;
	b=5rJ55steepiaORQqbpO9ShMDwVRkSpDzOKSpQ0y12b9Y8rn/GYH9SrgsvokmgO7HGCAI
	 IbCnEk5/NPXbX11qKJCyqezRfGSyn4hyAYRR0YlACtppBMFxHXFX7yPHh/vgS2gjppZzY
	 mtvOpcsLXC3FZGF6hTM6HW/fm9pCeRRWP4MjTV7VRyvS61uwRe/fdDT7dYmD5iA2aCIm7
	 lIzO4zMsB3uIbJculNiSNCQFwy/1s2AuPptgi760LoYuc112hfVS1tx1UyEeZMtOkEEiv
	 mvAEKA3bjXfxhjB9QjIPKSzVS9N1aH7juQ/IWlX9SbbSG5xvzmHr8mYiMW9w1/J3VHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JnXTZjNW;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vu+SOg9R;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xaftLuhN;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BaTthie3;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80057606A32C;
	Fri,  6 Nov 2026 14:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80057606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=JnXTZjNW;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=vu+SOg9R;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=xaftLuhN;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BaTthie3
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9050F1F452;
	Fri,  6 Nov 2026 14:51:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793976692; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/Drp7ifQeUDYwHgL1y7yzB8cVXQQt4dJhK1PJvWBeQ=;
	b=JnXTZjNWKaYglOEMRDSghM1mCC8CNtPojWVDsn5B13eHKgmQOu3cdekZBeNj+00J7iQ3LI
	UV5d4kkPrTH06M2o7FGxphCpaBfr2wN+9n8CAw0gwtLhigQG1cjEgACINTpI9LhqUTGl9p
	/ZvgV3B60NlCepfGQLtjfH5sRUnkvuw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793976692;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/Drp7ifQeUDYwHgL1y7yzB8cVXQQt4dJhK1PJvWBeQ=;
	b=vu+SOg9RfkkDnYPxjvQXAyw7j8Wrlj0Vh5LJPvpl4cQVWL8z6J/t/foUpDm8d3gLugJwuB
	KMSFez8osLFwxaCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793976691; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/Drp7ifQeUDYwHgL1y7yzB8cVXQQt4dJhK1PJvWBeQ=;
	b=xaftLuhNsHCJTSkN5c8rVdB9MVTN8fHJ8mnsW+M9up9jf1l/5IB73gkO15bYG0ZfA6Zu4B
	T5swbGc4Z3/V887/5tD9HefzA2SvrMOZlpnNXBvHDdkQt1rwlGVAoIP9UODYwBckO1mz+J
	GUWmg0Q3GLuEcssGb0u6JIIdS5XCa3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793976691;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4/Drp7ifQeUDYwHgL1y7yzB8cVXQQt4dJhK1PJvWBeQ=;
	b=BaTthie3RK/0Nw8QZfZHg0G/Q9yNycBg8SyGWFn5lAf7LAB+y3C1SXcSiRHteLRheifI/H
	QtHlG/YJDKaluPCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A02E132C9;
	Fri,  6 Nov 2026 14:51:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P5/ZEXPp7WoZDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 06 Nov 2026 14:51:31 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id E957121B9C; Fri, 06 Nov 2026 15:51:26 +0100 (CET)
Date: Fri, 6 Nov 2026 15:51:26 +0100
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, stable@vger.kernel.org
Subject: Re: [PATCH] fs: fix the SEEK_CUR f_lock condition
Message-ID: <7vzn53nez54u2ps3z7eb2v7vqca3sitzhhu7epk2lrrkt6l32o@hxboo6t23vow>
References: <20261106-work-file-seek_f_lock-v1-1-5b9a6c2928d4@kernel.org>
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
In-Reply-To: <20261106-work-file-seek_f_lock-v1-1-5b9a6c2928d4@kernel.org>
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
	RCPT_COUNT_FIVE(0.00)[5];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,suse.com:email]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Fri 06-11-26 14:14:35, Christian Brauner wrote:
> Commit da06e3c51794 ("fs: don't needlessly acquire f_lock") wanted to
> skip f_lock for SEEK_CUR on files that already serialize f_pos through
> f_pos_lock, i.e. FMODE_ATOMIC_POS files and directories, and keep it
> for everything else. The condition it added does the opposite:
> file_seek_cur_needs_f_lock() returns false exactly for the files that
> never take f_pos_lock and true for the ones that do.
> 
> So since v6.15 a SEEK_CUR on a shared block device or on a character
> device that uses fixed_size_llseek() updates f_pos without any lock and
> two concurrent calls can lose an update, while regular files and
> directories pay for a spinlock they don't need.
> 
> Invert the condition.
> 
> Fixes: da06e3c51794 ("fs: don't needlessly acquire f_lock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
> Commit da06e3c51794 got the condition in file_seek_cur_needs_f_lock()
> backwards. Regular files and directories still take f_lock on SEEK_CUR
> while block devices and fixed_size_llseek() character devices, which
> never take f_pos_lock, update f_pos unlocked since v6.15 and can lose
> an update. It's a one-liner.
> ---
>  fs/file.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/file.c b/fs/file.c
> index 4cd40dfa6129..fd08d34874ac 100644
> --- a/fs/file.c
> +++ b/fs/file.c
> @@ -1387,14 +1387,18 @@ static inline bool file_needs_f_pos_lock(struct file *file)
>  
>  bool file_seek_cur_needs_f_lock(struct file *file)
>  {
> -	if (!(file->f_mode & FMODE_ATOMIC_POS) && !file->f_op->iterate_shared)
> -		return false;
> -
>  	/*
> +	 * Files that go through f_pos_lock when they are shared, i.e.
> +	 * FMODE_ATOMIC_POS files and directories, don't need f_lock for a
> +	 * SEEK_CUR. Everything else does, since nothing else serializes
> +	 * the f_pos update.
> +	 *
>  	 * Note that we are not guaranteed to be called after fdget_pos() on
>  	 * this file obj, in which case the caller is expected to provide the
>  	 * appropriate locking.
>  	 */
> +	if ((file->f_mode & FMODE_ATOMIC_POS) || file->f_op->iterate_shared)

Isn't the iterate_shared check moot now? Because all directories will have
FMODE_ATOMIC_POS set AFAICS do_dentry_open(). But regardless feel free to
add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> +		return false;
>  
>  	return true;
>  }
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261106-work-file-seek_f_lock-c3fb94613214
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
