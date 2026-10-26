Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793029192;
	b=Sad0/LbswVoa48V90cDTXsvJGuWxEnv4rD09z5u0ZCouLjzS5xah5oMoTHUnWEvMAhWZ
	 eWboC/LwqaMgBqCDcH9YU9Hq8W2axps/MdKyj17WFd7wvgM6FvWBIGX4FWYDfWD87TXuM
	 PSsgLu9LxxgMtL7D7/0eYJfEvkKYT07dyiU0uDLWQdTaa1p/t5vktPOmRF/Tjsg2iCVIW
	 JXe6etdAzMKSNFHNrb75oax8HWEaS95LT0/dp+kFC2WSBeO3rkYOMCGZRhefWHO81ZIJW
	 MPt8yPozAUKr1r72oSgOGA/cE0erkB+c5YX+5jCM7xm2rl4zWWjxbIPHgMQ8xytSDjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793029192;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=D05ewPEuAJZzEFDiKa2w3FtXGZkgmoPcWa67JO5EvJ0=;
	b=E4rQ1tmZ2OTxgDXvtfqa+TW0/lPdUCY3OuOq5nYOEc4QoxbVwOppiSQFXQYVbEqTJCXd
	 cMeS92ixo0k0SBagM1OdNJswL4osDbZRDiNRZzf6EmTsBX1u62Bb17JpROjGlbVbxoaNJ
	 XlkCHxT2jCVUrXgUOIeHUZMr/SvPr8x74NUpIcnoMkxMjzZhBuNlxlG7QDOIOgawiRRUY
	 mkubb97sEqMS7rAmxkwMiCy2Lk95WiKyU/GgCFAcrXq3hAwdGQWZYp6JSEoVzyb6VBiaf
	 IAqsM42FQlJ2tgSoFA/wQIt2W98vwJ4c5DUt0gmaYza51VVHKUSkkKEiBNsIXTUSHxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=HnEVeoAb;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PDoVoGk1;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=HnEVeoAb;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PDoVoGk1;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9DF606A320
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:39:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD9DF606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=HnEVeoAb;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PDoVoGk1;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=HnEVeoAb;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=PDoVoGk1
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0D98F21FEA;
	Mon, 26 Oct 2026 15:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793029183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D05ewPEuAJZzEFDiKa2w3FtXGZkgmoPcWa67JO5EvJ0=;
	b=HnEVeoAbWTDhutgYy79N1iz1CKHRSTQ3U5LK2i6Y20S5DdKCAC2bscupYcqD7fPdM+OW2T
	h89vV4z1NQt2gQvMgLPjRRAGOR/NWVIEnhuKgJmtvVjd9yYJ+3naafmyfnXf3dffEg8Ctv
	emqeCNJs4wiYbqNLNWmRx9+OHgsCENQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793029183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D05ewPEuAJZzEFDiKa2w3FtXGZkgmoPcWa67JO5EvJ0=;
	b=PDoVoGk1X9qDtU+NargLh4ZpL//Na8zTy7o4AyxW2RMmMV8rROf54NeI4Oz5JnPQvkVk+b
	C2S38ewYTlE2rgCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793029183; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D05ewPEuAJZzEFDiKa2w3FtXGZkgmoPcWa67JO5EvJ0=;
	b=HnEVeoAbWTDhutgYy79N1iz1CKHRSTQ3U5LK2i6Y20S5DdKCAC2bscupYcqD7fPdM+OW2T
	h89vV4z1NQt2gQvMgLPjRRAGOR/NWVIEnhuKgJmtvVjd9yYJ+3naafmyfnXf3dffEg8Ctv
	emqeCNJs4wiYbqNLNWmRx9+OHgsCENQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793029183;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D05ewPEuAJZzEFDiKa2w3FtXGZkgmoPcWa67JO5EvJ0=;
	b=PDoVoGk1X9qDtU+NargLh4ZpL//Na8zTy7o4AyxW2RMmMV8rROf54NeI4Oz5JnPQvkVk+b
	C2S38ewYTlE2rgCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF43C13408;
	Mon, 26 Oct 2026 15:39:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id otRjMD5032oUAwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 26 Oct 2026 15:39:42 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3C5ECA1419; Mon, 26 Oct 2026 16:39:38 +0100 (CET)
Date: Mon, 26 Oct 2026 16:39:38 +0100
From: Jan Kara <jack@suse.cz>
To: Hongyu Jin <hongyu.jin.cn@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Subject: Re: [RESEND PATCH] writeback: don't requeue inode already on b_dirty
Message-ID: <xbfjoavzv74apeefktnyeapj6rnhkxxpcb47f4ffezq2bx2qzd@enb63e3ypf7u>
References: <20261023023707.263101-1-hongyu.jin@unisoc.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rzkagmlapmodioo3"
Content-Disposition: inline
In-Reply-To: <20261023023707.263101-1-hongyu.jin@unisoc.com>
X-Spamd-Result: default: False [-11.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,unisoc.com:email];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	HAS_ATTACHMENT(0.00)[]
X-Spam-Score: -11.30
X-Spam-Level: 
X-Spam-Flag: NO


--rzkagmlapmodioo3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri 23-10-26 10:37:07, Hongyu Jin wrote:
> Since commit 846a3351ddfe ("writeback: Avoid skipping inode writeback"),
> writeback_single_inode() calls redirty_tail_locked() for any inode left
> dirty. When that inode is already on b_dirty and older than the newest
> inode there, redirty_tail_locked() moves it to the head and stamps
> dirtied_when with jiffies.
> 
> Append to an f2fs file so the i_size update puts it on DIRTY_META, and
> dirty a newer inode before each checkpoint. Every 17s the checkpoint
> syncs that file and redirty_tail_locked() stamps a new dirtied_when.
> 17s is shorter than the default 30s dirty_expire_interval, so kupdate
> never expires it. Dirty pages pile up until writeback or fsync().
> 
> An inode that was I_DIRTY on entry is already on b_dirty, so only
> redirty it if it was not. The b_dirty_time case fixed by commit
> 846a3351ddfe ("writeback: Avoid skipping inode writeback") enters without
> I_DIRTY and is still handled.
> 
> Fixes: 846a3351ddfe ("writeback: Avoid skipping inode writeback")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongyu Jin <hongyu.jin@unisoc.com>

I was mulling over this for quite some time (which is why I didn't reply to
your patch earlier - plus the fact that currently there a *lot* of things
going on). I agree the current behavior is problematic - in particular that
if sync_inode_metadata() is called frequently enough, we never get to
kupdate style data writeback.

But I wasn't quite sure your fix is correct. In the end I've convinced
myself it is fine but we can actually go even further and remove the
redirty_tail() logic altogether. So I'm now testing the attached patch.
If my testing passes, I'll send it for inclusion.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--rzkagmlapmodioo3
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-writeback-Avoid-postponing-periodic-data-writeback-i.patch"

From 4261c07e3cb809f9bfac3b1da529b21bcd9da42d Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Mon, 26 Oct 2026 16:16:15 +0100
Subject: [PATCH] writeback: Avoid postponing periodic data writeback
 indefinitely

Hongyu Jin has reported that f2fs periodically calls
sync_inode_metadata() for some inodes. The logic in
writeback_single_inode() thus periodically calls to redirty_tail() and
the inode's dirtied_when timestamp never gets old enough for the inode
to be eligible for periodic data writeback. Thus dirty data from it is
only ever written on explicit request (fsync(2), sync(2), unmount) or
on dirty limit pressure.

The redirty_tail() logic in writeback_single_inode() actually should not
be necessary. Since this function is used only for once-off writeback,
there's no need for any livelock protection among inodes and
writeback_single_inode() is only responsible for demoting inode to "less
dirty" list based on dirty bits cleared as a result of writeback. So
remove the redirty_tail() logic and add a comment explaining the rules.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/fs-writeback.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/fs/fs-writeback.c b/fs/fs-writeback.c
index 58a6403780aa..de86c9055ffb 100644
--- a/fs/fs-writeback.c
+++ b/fs/fs-writeback.c
@@ -1946,22 +1946,31 @@ static int writeback_single_inode(struct inode *inode,
 	 * as it can be finally deleted at this moment.
 	 */
 	if (!(inode_state_read(inode) & I_FREEING)) {
+		enum inode_state_flags_enum istate = inode_state_read(inode);
+
 		/*
-		 * If the inode is now fully clean, then it can be safely
-		 * removed from its writeback list (if any). Otherwise the
-		 * flusher threads are responsible for the writeback lists.
+		 * __mark_inode_dirty() is responsible for promoting inode to
+		 * the proper list (b_attached -> b_dirty_time -> b_dirty).
+		 * Here we are responsible for demoting inode after some dirty
+		 * bits were cleared.
+		 * 
+		 * If the inode is now fully clean, then it can be safely moved
+		 * to b_attached list. If the inode is dirty, we don't want to
+		 * touch it - it should be already put to the dirty list by
+		 * __mark_inode_dirty() and we'd just unnecessarily clobber the
+		 * dirtied_when stamp (which is particularly problematic when
+		 * we were called from sync_inode_metadata()). We also cannot
+		 * touch the dirty list association when I_SYNC_QUEUED is set
+		 * and flush worker is responsible for it. Otherwise move the
+		 * inode to b_dirty_time list as that's the only remaining
+		 * possibility.
 		 */
-		if (!(inode_state_read(inode) & I_DIRTY_ALL))
+		if (!(istate & I_DIRTY_ALL))
 			inode_cgwb_move_to_attached(inode, wb);
-		else if (!(inode_state_read(inode) & I_SYNC_QUEUED)) {
-			if ((inode_state_read(inode) & I_DIRTY))
-				redirty_tail_locked(inode, wb);
-			else if (inode_state_read(inode) & I_DIRTY_TIME) {
-				inode->dirtied_when = jiffies;
-				inode_io_list_move_locked(inode,
-							  wb,
-							  &wb->b_dirty_time);
-			}
+		else if (!(istate & I_SYNC_QUEUED) && !(istate & I_DIRTY)) {
+			WARN_ON_ONCE(!(istate & I_DIRTY_TIME));
+			inode->dirtied_when = jiffies;
+			inode_io_list_move_locked(inode, wb, &wb->b_dirty_time);
 		}
 	}
 
-- 
2.51.0


--rzkagmlapmodioo3--
