Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793711183;
	b=hvrj68pBClhOMo+LgPtnGyMX+DPEDrU8jkkRudgIX4ZU0XIru7ldC4IXAxhAwAjbDfF3
	 1Fge9tB4+F9KLiMBlT8h26+QozA386ugvhEJ47YVDd0A+JUQxWX1eqiAYNNw0USGznCd9
	 ON8lvq/Ein9iswCmD5MzrURzv6Gr+LBRCwwdFwCCdxodpifTEnFzVr1+N0QAKJbsCSNYZ
	 bG079N0ShFiYo1nFSzJ8oC6+Ii66zLj41SxNHm2i8YSKpqbP3DHiU9m1O99ynN6kt4ORo
	 zjDTnxjFG78ErJTZ2+nlEjm5RYfOBdLN6kiFSRJ0n0pJX9ktaDM3mJ0eR6TkvSVFQ4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793711183;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Rspamd-Queue-Id:X-Spam-Level:
	 X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:X-Spamd-Result:
	 X-Spam-Score;
	bh=tnuSaPNozja1a/+023AZ6wWIK0uTSszN2HCVpuU4g+w=;
	b=SsmSYQ8PNODCnmaQHP5L1/2hDXhhXvPeCT64td2j7xyJMpotptOm1JMexbEt2jYGLjpy
	 hf+V2KIiyklPClpu637hgdg0Nj6/vUxInAQ6w2UlK3vqZdlADlXiamH7Ex1Q7LEFExyX8
	 c1wD6fkXy2ll8euxYjmQ93zlJOupm/9Vj2s8AOuJ5jpExllCi+01lYJIpeFZQFDUFfPjL
	 qu0nMUVyIkHEwYtoxHnOG9UfkDS0yNminMGRdoaqgmYCYO9F98713QfF+r1w60nAk4jcJ
	 2c6ZRs9Ky0i4Wrh4fTHQdV3rWfarP0KbuC92X3Z0ZO5jHbr//u4h9apN+sDJRMbm9zA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=2tQkpWXm;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=feTszLZj;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=F1vN2Ba8;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4DuoV8qh;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2D606A335
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 13:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90E2D606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=2tQkpWXm;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=feTszLZj;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=F1vN2Ba8;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=4DuoV8qh
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AEA221E12;
	Tue,  3 Nov 2026 13:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793711167; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnuSaPNozja1a/+023AZ6wWIK0uTSszN2HCVpuU4g+w=;
	b=2tQkpWXmBFwgVgWUVhk8w+6SshzRPXNOd8jVerTNnTgN9MDpyv9rckjdGEkinp0h5Ftu6O
	FlldqZs3Jd7lklz//MtwdonrNRuhPucmHtF7mQOGhwMBbWMmG+zlIxjoipE0H2yeUiIxDs
	/vTxrJRRrraWlIBzQaMfYLoOS3Pu2vo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793711167;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnuSaPNozja1a/+023AZ6wWIK0uTSszN2HCVpuU4g+w=;
	b=feTszLZjpWuDcwcDCZkRAdJNux1Pc5y81uBnXIl+8Ys/1J9PGvy0r1Bwr8cK5N8ySHx2Za
	+7dnSjnW4eTd21AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=F1vN2Ba8;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4DuoV8qh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793711166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnuSaPNozja1a/+023AZ6wWIK0uTSszN2HCVpuU4g+w=;
	b=F1vN2Ba8pxyrHaVpu7ur7ZlD+ZmaoYWdmZMsNz9QXXPn2jFytmXZ1C3OmXqEnmEQawCyib
	eRQIvczwy1JKFnEqNzRJBoko5cXzNsyT+WKL9JRI5RoJ+CHHIRIEf94RJUuH7GE1/fIH9K
	WFKietRmY0Uxjl+IousD5oKgfIbAj+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793711166;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tnuSaPNozja1a/+023AZ6wWIK0uTSszN2HCVpuU4g+w=;
	b=4DuoV8qhMxfGisUtwt8/9u45LuAhh3boOkN/WCjdPOsp4VwU242shGqg4iIVcr35feNYQi
	HvcQoXjcmjw7cuBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1B8DE1350A;
	Tue,  3 Nov 2026 13:06:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VknWNz3c6WqIKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Nov 2026 13:06:06 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id AD344B269; Tue, 03 Nov 2026 14:06:05 +0100 (CET)
Date: Tue, 3 Nov 2026 14:06:05 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Hungyu Lin <dennylin0707@gmail.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] inotify: do not coalesce rename events
Message-ID: <u6fltejwlekpknwpxzy6pefif7ld3dhwvzqqalbzmtwtzjjaj2@hsulwhevxfds>
References: <20261027192027.8617-1-dennylin0707@gmail.com>
 <CAOQ4uxj3et_cyzD1iWHr3_z1dH1R3WQMCOm+kO2Q90TXjaV9pQ@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj3et_cyzD1iWHr3_z1dH1R3WQMCOm+kO2Q90TXjaV9pQ@mail.gmail.com>
X-Rspamd-Queue-Id: 4AEA221E12
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-13.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.01

On Wed 28-10-26 05:07:21, Amir Goldstein wrote:
> On Tue, Oct 27, 2026 at 9:20 PM Hungyu Lin <dennylin0707@gmail.com> wrote:
> >
> > inotify compares the mask, watch descriptor and name when coalescing
> > adjacent unread events, but ignores their rename cookies. Distinct
> > IN_MOVED_FROM events can therefore be coalesced, losing the cookie needed
> > to match a later IN_MOVED_TO event.
> >
> > For example, watch two directories with IN_MOVE. Move an entry from the
> > first directory into an unwatched directory, recreate it under the same
> > name, then move it from the first directory into the second watched
> > directory before reading the events. The second IN_MOVED_FROM is merged
> > with the first, while the IN_MOVED_TO retains the second rename's cookie.
> > Userspace can no longer pair the second rename's events.
> >
> > The original inotify implementation compared cookies before coalescing.
> > The fsnotify conversion lost this comparison. Do not coalesce
> > IN_MOVED_FROM or IN_MOVED_TO events, which carry the identity of their
> > respective renames. Leave coalescing of other event types unchanged.
> >
> > Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
> > Cc: stable@vger.kernel.org
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>

Thanks Amir and ignore my comment on v1. I've added this to my tree.

								Honza

> 
> > ---
> >  fs/notify/inotify/inotify_fsnotify.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> > index 7c326ec2e8a8..6e3af6452dcc 100644
> > --- a/fs/notify/inotify/inotify_fsnotify.c
> > +++ b/fs/notify/inotify/inotify_fsnotify.c
> > @@ -36,7 +36,7 @@ static bool event_compare(struct fsnotify_event *old_fsn,
> >
> >         old = INOTIFY_E(old_fsn);
> >         new = INOTIFY_E(new_fsn);
> > -       if (old->mask & FS_IN_IGNORED)
> > +       if (old->mask & (FS_IN_IGNORED | FS_MOVE))
> >                 return false;
> >         if ((old->mask == new->mask) &&
> >             (old->wd == new->wd) &&
> > --
> > 2.43.0
> >
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
