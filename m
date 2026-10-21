Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573183;
	b=TyHFWaTMWTy0CmTXBIkpUHsmI1/e8NBUpYyEAu/sjXDT5TL2JbmowMJqxVkW49LD3vJg
	 bfXyHyVpqiwu98P6Jv7cVAARhj8yaCKbUCa3DL+ya4eNs5x0aFMrzUI+OmjzKNu/h/D+c
	 DWsepZ7JHGQFdWRflw0GUEqJyr/RyaqRgp5EMOstl4zz+nsoRKR/oKdVXOx0FKpxyN+HC
	 0lqoam/bNUO4aPL1I0YfbbKNc4ypzvRtz2A1MkWEqS+zHQMy0ZsETxaQFz6Vv6pMp6a2p
	 OSt3JYqJ7AjsI/PSMkhzT45/l2jMbPepiWgTj9XJ4uCnFXC7SA9eTIk/5mBi74Bta+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573183;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Rspamd-Action:X-Spam-Score:X-Spam-Flag:X-Spamd-Result:X-Spam-Level:
	 X-Rspamd-Queue-Id:X-Rspamd-Server;
	bh=cyNTbNEiAoIwsJLTz99M7oLLSoGo+m07kKcOdYkr6Ls=;
	b=xcWqWh4tlKybSt2It1VndsN6NO/CJ/piKvu5fvrg30x5gYJ2CQbNMYnYprqWl2PUY/lh
	 pc2hIEhvHMnkOZ0QUPzEi/nr0T5J2w2pyxY/qpxVjS3rZWLuOQQmBpsqw4qNG0zRsh1M0
	 pWOGHuHGCsIgIdBdeYib6xmuDaKOHZ1PNwXF8wnKaa+NwbZSGcV91PpHYD+WMgs73shk3
	 sUWkn9Elsv1rQ6vl2HIPaj5JLvFBp83gabs3ufRxppiAAaHGLqV2SuObulZDXzZeJHtfE
	 qJ/GS9CEquBy/wGevuCjda3YaYz4YOYEFdVJN4it7vmeTkBiHrlKvqmR5Qst4WAQkKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pnavB1YQ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FvXr7lmg;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=UoEaZvBI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=727llxKI;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC760606A31B;
	Wed, 21 Oct 2026 08:59:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC760606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=pnavB1YQ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=FvXr7lmg;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=UoEaZvBI;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=727llxKI
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C1FC51F7C4;
	Wed, 21 Oct 2026 08:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792573181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cyNTbNEiAoIwsJLTz99M7oLLSoGo+m07kKcOdYkr6Ls=;
	b=pnavB1YQO92YCXlsmfLgPQlFLOchvVuqwTo2ajJLqepdfRUOBFx5ITgy9XePlpZzpJde5x
	fVBWqLzNiiY3q5gLrkzDwoMHlXZ/vzvqU06/hGlf0jIeX9vy2Z+KOe7lOiG91DXcqOnRG2
	UGt17PnI5H0NliV7W5mrIazW8CsU0Kc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792573181;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cyNTbNEiAoIwsJLTz99M7oLLSoGo+m07kKcOdYkr6Ls=;
	b=FvXr7lmgduEM4f1zUlczE8sZehIlX7cFxP9SH6s6t/M9J/jAU2y9ZFoArxQ4niIJZdmaUk
	g4Kfe2q0lh7qGgCg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UoEaZvBI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=727llxKI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792573180; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cyNTbNEiAoIwsJLTz99M7oLLSoGo+m07kKcOdYkr6Ls=;
	b=UoEaZvBIYvNjeyOVnoDwBMxQOPbsHfhnGvhB00+vUP8fKbq3HAsu0hAelcUrCH8SmuXUXm
	1LPS+5Q95gPwvLqZXm0bWGfjKJbMoFGAy4uw/Ih94bydbmBPMtc7QOF1r1kSeQ6CTn7X3v
	ufhEyuYqHIs27JM4g+IUSjHYc2m59v8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792573180;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cyNTbNEiAoIwsJLTz99M7oLLSoGo+m07kKcOdYkr6Ls=;
	b=727llxKInczBYWntWyAIXyZoudCLsm0TQzPi38ueWwpbBENZvC51lILZrrqXE3cv6Or2Cl
	CfxIgoVnxNjHlgCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 87022134A5;
	Wed, 21 Oct 2026 08:59:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id U8xSGPx+2GoXdAAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 21 Oct 2026 08:59:40 +0000
Date: Wed, 21 Oct 2026 10:59:39 +0200
From: Daniel Wagner <dwagner@suse.de>
To: Aaron Tomlin <atomlin@atomlin.com>
Cc: axboe@kernel.dk, tom.leiming@gmail.com, hare@suse.de, 
	frederic@kernel.org, tj@kernel.org, sean@ashe.io, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] blk-mq: dispatch kworker to housekeeping CPU when
 hctx cpumask is empty
Message-ID: <63c7810b-b893-43be-b108-4fcc05773492@flourine.local>
References: <20261016052203.489760-1-atomlin@atomlin.com>
 <a6b3d7c6-64fd-4b92-8428-964a863ea9e8@flourine.local>
 <zpheefzacmmkz362qm342gfxhluovh4d35numrweqn2ajnxhog@ucus4k2prn6o>
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
In-Reply-To: <zpheefzacmmkz362qm342gfxhluovh4d35numrweqn2ajnxhog@ucus4k2prn6o>
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.dk,gmail.com,suse.de,kernel.org,ashe.io,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Level: 
X-Rspamd-Queue-Id: C1FC51F7C4
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

> While your nvme/070 test targets NVMe fabrics connect and passthrough
> request allocation, this fix is in core blk-mq (blk_mq_hctx_next_cpu) and
> affects deferred workqueue execution across all block devices. Using a new
> test based on null_blk would allow us to:
> 
>     1.  Target infrastructure for generic blk-mq workqueue placement testing
> 
>     2.  Easily configure a shallow queue depth or inject tag
>         exhaustion/busy conditions to reliably trigger asynchronous queue
>         dispatch (&hctx->run_work)
> 
>     3.  Trace workqueue:workqueue_execute_start to assert that no kblockd
>         worker executes on the isolated core
> 
> I'll put together a test case for tests/block/.

Sounds good to me! Thanks.
