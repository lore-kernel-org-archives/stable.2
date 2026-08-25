Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93DFF351C02;
	Wed, 26 Aug 2026 07:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787730615; cv=none; b=irzu6gkpGuqkdUy6MYzo4fhuCJtCTZTUuK6C/jU2skRFnMzVqTeakPskjBtvmdM9U1RHc7rMNMf2KHlrjVexOSs0wUbiwirx0GR9wQ5cS449+Nah7ITsW3MenKvrauMP/s4ZN6hiiIpyXbyjVAQdOjVZoqWKYtmbsqu9vevkCnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787730615; c=relaxed/simple;
	bh=aCjJjG2Nw3cPfyAT5z4SuQfzlRJA8clTcgN99zBnPIE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ua4zFajM7p3LdyMbjr7I377AYXzXzDEm0Sf/6c2pP2dLZHTnXQOJkevjFudrkFSepnEkW9B5DFtbWj//74TndV9I7mG6nwq9gJ/drYlpMIufjY37/+5koccYAcn7kCSfg8P7PLbks4YUu7deDGNb04Gc9hpN7SPIrJrBY6c8bzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Tuf8Zu4E; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oTwZ5Guy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ff3Cc7VU; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sLVbV5ya; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Tuf8Zu4E";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oTwZ5Guy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ff3Cc7VU";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sLVbV5ya"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 76E3E872B2;
	Wed, 26 Aug 2026 07:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787730607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/j78b41kQyLqwxObwd/PJ2I/iGywaOMruyWQoKE3HbE=;
	b=Tuf8Zu4Ebi77WoIO4EUIU87JNNUiB1J7hYEx6rSkZALXTpF0Xjy6thjpV7wU/XJr61Ca9i
	3f/7EN/krg8CMJvhR2fXTM1PDpE+FODRfHeHMwWy53Xe1Hnwu57x06lqh27FxIvrIDwcH8
	e/XuHCZJlH52N6LPnqxHREkaTlQQoyY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787730607;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/j78b41kQyLqwxObwd/PJ2I/iGywaOMruyWQoKE3HbE=;
	b=oTwZ5Guydt2UslFqLcJMzoNBM95y2y8Stw6z3DChhmdeRXIAuQjjzD9jjAhj0kcKg62zr1
	Eg6cG5u8efw+QKAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ff3Cc7VU;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sLVbV5ya
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1787730603; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/j78b41kQyLqwxObwd/PJ2I/iGywaOMruyWQoKE3HbE=;
	b=ff3Cc7VUUnrgurxIvbJpk2eL+TmY6IFOZaMou04qyyiAPpXedri3kYOAALtbiWLXeg+86K
	kntdXniYP6ihElWhivPRySaGOwwr5UHCnlq8a3mScLQr4rSQzwV/ust6cCVIRXOC7o/fwj
	e95IZn+fZTtrq7PxHGK0mD43H2LE+Cc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1787730603;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/j78b41kQyLqwxObwd/PJ2I/iGywaOMruyWQoKE3HbE=;
	b=sLVbV5yaBZJBXoR7uc7F2YS8eVweG28D1f8ORpp9uZ0RbKi7URyuuFMqgml7Ih4W1Izwse
	Xrvvdab65yZzwiCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 93A8213688;
	Wed, 26 Aug 2026 07:49:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CS4GJKOajmoJDAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 26 Aug 2026 07:49:55 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 47961A13C4; Tue, 25 Aug 2026 19:35:09 +0200 (CEST)
Date: Tue, 25 Aug 2026 19:35:09 +0200
From: Jan Kara <jack@suse.cz>
To: Moritz Tanner <moritz.tanner@linbit.com>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs: don't return -EINVAL for successful nested thaw
Message-ID: <3udtnc2d6pu7et4wlvjume37nrnuvpxal3au4z2oynk3dh3ij5@dingvsd4x7rr>
References: <20260821085451.65206-1-moritz.tanner@linbit.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821085451.65206-1-moritz.tanner@linbit.com>
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 76E3E872B2
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action

On Fri 21-08-26 10:54:51, Moritz Tanner wrote:
> Commit 7366f8b6fc6a ("fs: handle freezing from multiple devices")
> replaced the freeze_holders bitmask with per-holder counters to allow
> nested freezes. In the bitmask version, a thaw that released a shared
> hold while another holder remained returned 0. Since the rework,
> thaw_super_locked() drops the freeze reference via freeze_dec() but
> then returns -EINVAL when other freezers remain, misinforming the
> caller: the thaw did succeed, the superblock just stays frozen for the
> remaining holders.
> 
> This breaks bdev-initiated freezing. When a filesystem is frozen with
> FIFREEZE and additionally frozen via bdev_freeze() -- which nests by
> design, see fs_bdev_freeze() -- the subsequent bdev_thaw() receives
> -EINVAL from the holder op although its freeze reference was dropped,
> and therefore keeps bd_fsfreeze_count elevated. Then device-mapper's
> unlock_fs() ignores bdev_thaw()'s return value, so nothing rebalances
> the count. After the user's FITHAW and umount, the block device can
> never be mounted again:
> 
>     dm-1: Can't mount, blockdev is frozen
> 
> There is no way for userspace to drop the leaked count; only
> destroying the block device (or a reboot) recovers the device.
> 
> Reproducer (any kernel since v6.8):
> 
>     dmsetup create dut --table "0 $(blockdev --getsz "$DEV") linear $DEV 0"
>     mkfs.ext4 /dev/mapper/dut
>     mount /dev/mapper/dut /mnt
>     fsfreeze --freeze /mnt      # freeze_ucount == 1
>     dmsetup suspend dut         # bd_fsfreeze_count == 1, ucount == 2
>     dmsetup resume dut          # ucount 2 -> 1, but thaw_super()
>                                 # returns -EINVAL, so bdev_thaw()
>                                 # keeps bd_fsfreeze_count at 1
>     fsfreeze --unfreeze /mnt    # filesystem thaws fine
>     umount /mnt
>     mount /dev/mapper/dut /mnt  # EBUSY, forever
> 
> The same happens with fsfreeze held across an LVM snapshot of the
> origin volume.
> 
> fs_bdev_thaw()'s documentation already describes the intended
> semantics: "If this function returns zero it doesn't mean that the
> filesystem is unfrozen as it may have been frozen multiple times".
> Restore them by returning 0 when a nested thaw drops its hold while
> other freezers remain. Thawing without holding a freeze still fails
> with -EINVAL as may_unfreeze() rejects that case before the reference
> count is touched.
> 
> Fixes: 7366f8b6fc6a ("fs: handle freezing from multiple devices")
> Cc: <stable@vger.kernel.org> # needs adjustments for < 6.17 (no may_unfreeze())
> Signed-off-by: Moritz Tanner <moritz.tanner@linbit.com>

Ouch. Good catch. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/super.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/super.c b/fs/super.c
> index 05e443173038..01db6124e409 100644
> --- a/fs/super.c
> +++ b/fs/super.c
> @@ -2369,11 +2369,14 @@ static int thaw_super_locked(struct super_block *sb, enum freeze_holder who,
>  		goto out_unlock;
>  
>  	/*
> -	 * All freezers share a single active reference.
> -	 * So just unlock in case there are any left.
> +	 * All freezers share a single active reference. If other freezers
> +	 * remain, drop our hold and report success; the superblock stays
> +	 * frozen until the last holder thaws it.
>  	 */
> -	if (freeze_dec(sb, who))
> +	if (freeze_dec(sb, who)) {
> +		error = 0;
>  		goto out_unlock;
> +	}
>  
>  	if (sb_rdonly(sb)) {
>  		sb->s_writers.frozen = SB_UNFROZEN;
> -- 
> 2.55.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
