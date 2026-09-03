Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 199103A4267
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428873; cv=none; b=MYZTa0pgmeFaDDHfIhlqDyP+7lvOaZ2QfCb8FTezI4DA/Jud2REC0bBFSq39vbwQix9iUYQjmA9dEJ7n6CknXm5kA5KQ5RCGDr2cpS9V8dh1PuaWf/gEveacmxiCXfoRnr5ca+1BYdz6Z3wgKKFo7hG20o6AkKyQQXS9L/fYL7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428873; c=relaxed/simple;
	bh=bt4aZiSOgpfLqi/7NsUYlGh1dU1+hGM0UnSikuH0Wzg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dq3vg84DR/n1mSsskWVWF5HiyIw+4d5Y5xXM5D+k7CVbuZ2DY+5jZgulXjR5GlCGoc0lCIc9jcG2YGPwx8i5Qiq8YCBFIZ+SIFjnB+vdyT27rNsS9i9VghVaLp/O8t0jwOzncV0Mh2qplC1LDWzJE3AJTxyRJPe+/jc5nT7gEvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hMO0AuIm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uZe32N5A; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ziPQ+YxP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=L1bVU+QU; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hMO0AuIm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uZe32N5A";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ziPQ+YxP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="L1bVU+QU"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E7AE21F7EE;
	Thu,  3 Sep 2026 09:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788428858; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t8USff4bKcpLn8d3s9T1L6SRyU92pAeHZ36VKLj5ios=;
	b=hMO0AuImsFoJAjTEaauuXoSDkyodqE+9EFx+U/dosnPnwpO0Yl5YbEqBOJTR1gZXxsr41i
	NqEIC/ViameS1UMz7YqLY7chBlW+XQsW4toSLSqYQMUpnxCewfAL+MCJEQ/k3tra6G87XT
	V8Bdh88Bez3fhwd4KtH2dhXGuz/tfjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788428858;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t8USff4bKcpLn8d3s9T1L6SRyU92pAeHZ36VKLj5ios=;
	b=uZe32N5AJgMdSqaQckGBNq5/zPpE443K/UJ3oKUYm28GtqHe209A2dSLjnJKnIEeqdStNf
	nHsX84KKkysnSuCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1788428853; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t8USff4bKcpLn8d3s9T1L6SRyU92pAeHZ36VKLj5ios=;
	b=ziPQ+YxPyaKQFDJf1cfE1UKin8KNI6dV2BcnPZ+nqu77IY2ucdKl3ArqFl5V6iP/7acXZ0
	d+TpzyUOO+p1HQXUd2TVcxMdIqUgzm0HIIpxxv2lsUb3A78FsCgG2I/AmLRBkmA9ALbQ4t
	YI4VMjN4ET0fqyoAHyncrhhAgBCGjVA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1788428853;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=t8USff4bKcpLn8d3s9T1L6SRyU92pAeHZ36VKLj5ios=;
	b=L1bVU+QUlw9qV2EUl05byb2we0PXEk6BPQlzgAFnYCOLoZ5z9GzES6+86LNh5RuU002MIm
	KkFnwQniP+5BKfBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C90BA136D9;
	Thu,  3 Sep 2026 09:47:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5JYMMTVCmWpOdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 03 Sep 2026 09:47:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5EED3A13AC; Thu, 03 Sep 2026 11:47:29 +0200 (CEST)
Date: Thu, 3 Sep 2026 11:47:29 +0200
From: Jan Kara <jack@suse.cz>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] fs_pin: publish pins with RCU list helpers
Message-ID: <okwtct7jxzddg7tnj6srpbxtkhu7axog73tmectdlyx67ujh6q@kiaqkyuqiwcv>
References: <20260903002100.34822-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260903002100.34822-1-kmehltretter@gmail.com>
X-Spam-Score: -3.80
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO

On Thu 03-09-26 02:21:00, Karl Mehltretter wrote:
> pin_insert() initializes a pin before adding it under pin_lock.  The kill
> paths read the list heads under RCU without taking that lock.  Plain hlist
> insertion does not publish the earlier initialization to those readers.
> 
> KCSAN weak-memory checking reported acct_on() callback initialization
> racing with pin_kill() after the superblock-list publication.  The
> corresponding LKMM model permits the stale read with plain publication;
> the RCU release/acquire pair forbids it.
> 
> Use the RCU hlist add and dereference helpers for both pin lists.
> 
> Fixes: 2798d4ce6160 ("acct: get rid of acct_lock for acct->count")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Yes, it looks like the memory ordering is indeed insufficient here. Feel
free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> Reviewer notes:
> 
> Tested on arm64 (Raspberry Pi 400, Cortex-A72) at cf72cbb39da8 with clang,
> strict KCSAN, and weak-memory modeling.  Concurrent acct(path) and
> read-only remounts produced one __arm64_sys_acct()/pin_kill() report in
> the baseline.  Disassembly identified both accesses as pin->kill and the
> write as modeled past pin_insert().
> 
> With this patch, the report was absent at five times the baseline
> exposure, while unrelated control races continued to fire.  The LKMM
> plain-publication test is "Sometimes"; its RCU counterpart is "Never".
> 
> This demonstrates modeled reordering, not an observed crash.  Plain KCSAN
> also found no report in about 400,000 acct() cycles.
> 
>  fs/fs_pin.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> --- a/fs/fs_pin.c
> +++ b/fs/fs_pin.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  #include <linux/fs.h>
> +#include <linux/rculist.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
>  #include "internal.h"
> @@ -22,8 +23,8 @@
>  void pin_insert(struct fs_pin *pin, struct vfsmount *m)
>  {
>  	spin_lock(&pin_lock);
> -	hlist_add_head(&pin->s_list, &m->mnt_sb->s_pins);
> -	hlist_add_head(&pin->m_list, &real_mount(m)->mnt_pins);
> +	hlist_add_head_rcu(&pin->s_list, &m->mnt_sb->s_pins);
> +	hlist_add_head_rcu(&pin->m_list, &real_mount(m)->mnt_pins);
>  	spin_unlock(&pin_lock);
>  }
> 
> @@ -73,7 +74,7 @@
>  	while (1) {
>  		struct hlist_node *p;
>  		rcu_read_lock();
> -		p = READ_ONCE(m->mnt_pins.first);
> +		p = rcu_dereference(hlist_first_rcu(&m->mnt_pins));
>  		if (!p) {
>  			rcu_read_unlock();
>  			break;
> @@ -87,7 +88,7 @@
>  	while (1) {
>  		struct hlist_node *q;
>  		rcu_read_lock();
> -		q = READ_ONCE(p->first);
> +		q = rcu_dereference(hlist_first_rcu(p));
>  		if (!q) {
>  			rcu_read_unlock();
>  			break;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
