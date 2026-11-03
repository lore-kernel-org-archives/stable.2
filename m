Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793704023;
	b=LWJQ8xO0gmtYSD3JZZg+tIZ06vHavbzrxAHhlXuiUwclkmCelPTZGyFbhqFLsvVKFit0
	 IepuCCiOkJXmggwvO86YeyZz7kIfo+Vvc6eBatKXzSbmfhmzjC6VWDNt4f2sI9//yKF5+
	 xCCFjK19SpnlzstV+t8KZR/MwmHVtP3eChxUTEpTPT7EAqPgAuLVJYMsX6tiCnxKEcSuk
	 TlIbVIAkl7cahTMs4ydCMLZiWOSlk2pdUW73RaUmuXsfIUmKvfuz/Y1CZY34sLfGrR7Mn
	 aRDMAvqlQ2RKTdBVfsVQ3sMyvDUhyaz/FFDuig73gqm6PKcwrYnaWKGv1EJwdMeYlJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793704023;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=P+w0TJcctZwPlp6HzYj1zMH3kJnTkveWU9RaR7BZfcQ=;
	b=VUEMf0FuwOQiub8V8VMtzYs6sy1B29dp0nuDhFzPOEuvWEXoH3keT89B1+1Q8AesbsuK
	 r0gjXN2tYQsX0Ws6gQW4f/Y1WaRS9DdUUkimm+293gsQiKBj2WvgyB9NUygjSUbHkfjCx
	 OID6HEUEJIQCzs5yrpb9OWr6z7v65tKX+WBThGEphvLY/54pMokfRbwBe6LMPt5TuJH4y
	 ImPQMEL7i8sPMkQfn7cP4JepQwD8AQjpfIRf317rGhGB0LwyhVGL9rV/wiat/mZCmWPjA
	 ohdW6YSBJNAi5sQ+3025zoJWsliz/vqHvmDUC+jSvn4l0Of/iu6Un8IwHESpThgSBwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cbZHUvf+;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bUyio6qm;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cbZHUvf+;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bUyio6qm;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB86082BC5
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DAB86082BC5
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cbZHUvf+;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bUyio6qm;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=cbZHUvf+;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bUyio6qm
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8585B1FF23;
	Tue,  3 Nov 2026 11:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793704013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+w0TJcctZwPlp6HzYj1zMH3kJnTkveWU9RaR7BZfcQ=;
	b=cbZHUvf+xE0V+BIxCBRhVmKhW7LM0e51Fes7twmZZx19cG5OUWR2YPDRx7MDyC8N/bqzI1
	rzB0ECMxaEYoyYyKayjKpGRuzpK/JE20dqHWUn02CeeZ9hcs6zRQ4hzDCTVr+UFz5OV1F+
	tLXqN4eZg5kSEQwz+NNfpXRaO7ftjRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793704013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+w0TJcctZwPlp6HzYj1zMH3kJnTkveWU9RaR7BZfcQ=;
	b=bUyio6qmvUttdnMniugJvZ64P2w7XOfwnSZ+WWxXgg10tdd6bX3RLtSVVDoadupmwdfyAM
	1wFYed7Gfx978RBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793704013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+w0TJcctZwPlp6HzYj1zMH3kJnTkveWU9RaR7BZfcQ=;
	b=cbZHUvf+xE0V+BIxCBRhVmKhW7LM0e51Fes7twmZZx19cG5OUWR2YPDRx7MDyC8N/bqzI1
	rzB0ECMxaEYoyYyKayjKpGRuzpK/JE20dqHWUn02CeeZ9hcs6zRQ4hzDCTVr+UFz5OV1F+
	tLXqN4eZg5kSEQwz+NNfpXRaO7ftjRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793704013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P+w0TJcctZwPlp6HzYj1zMH3kJnTkveWU9RaR7BZfcQ=;
	b=bUyio6qmvUttdnMniugJvZ64P2w7XOfwnSZ+WWxXgg10tdd6bX3RLtSVVDoadupmwdfyAM
	1wFYed7Gfx978RBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 66A5C1350A;
	Tue,  3 Nov 2026 11:06:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UnHwEk3A6WoRLQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Nov 2026 11:06:53 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id EB96DB21D; Tue, 03 Nov 2026 12:06:52 +0100 (CET)
Date: Tue, 3 Nov 2026 12:06:52 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Hungyu Lin <dennylin0707@gmail.com>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] inotify: do not coalesce events with different rename
 cookies
Message-ID: <oq2wdodspuqn5ncmy4cggiwetm6tedeppamnosj2vldy3iix3b@brk3zr5ngwvc>
References: <20261025232251.58252-1-dennylin0707@gmail.com>
 <CAOQ4uxifE0G4r=cpevTB4mzq+HhGdVsNhddzFNuH=BN9YrD6Ag@mail.gmail.com>
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
In-Reply-To: <CAOQ4uxifE0G4r=cpevTB4mzq+HhGdVsNhddzFNuH=BN9YrD6Ag@mail.gmail.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Mon 26-10-26 11:32:10, Amir Goldstein wrote:
> On Mon, Oct 26, 2026 at 1:23 AM Hungyu Lin <dennylin0707@gmail.com> wrote:
> >
> > inotify compares the mask, watch descriptor and name when coalescing
> > adjacent unread events, but ignores their rename cookies. Distinct
> > renames can therefore lose an event even with IN_ALL_EVENTS.
> 
> oops. Somehow I remembered that we never merge MOVE events.
> Maybe that's even a simpler check. IDK.
> 
> > For example, prepare two files in an unwatched staging directory and
> > rename each onto the same pathname in a watched destination directory
> > before reading the events. Only the first IN_MOVED_TO event is retained,
> > although the two renames have different cookies.
> 
> Thing is, the "wrong" rename TO cookie is meaningless without the FROM pair.
> If the second source has a FROM, then the two TO won't merge.
> Could you really reproduce this case?

So I don't think this is something that practically matters (you have to
really try to screw up youself to trigger this). Anyway, I think comparing
the cookie is a sensible thing to do so I'm inclined to merge this. Any
objections Amir?

								Honza

> 
> > Similarly, coalescing
> > distinct IN_MOVED_FROM events can discard the cookie needed to match a
> > subsequent IN_MOVED_TO event.
> 
> THIS looks like a case that can be reproduced.
> Can you provide an inotify LTP test for this case please.
> 
> >
> > The original inotify implementation compared cookies before coalescing.
> > The fsnotify conversion lost this comparison. Compare sync_cookie as well
> > to preserve distinct rename events, while retaining coalescing for
> > ordinary events with zero cookies.
> >
> > Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> > ---
> >  fs/notify/inotify/inotify_fsnotify.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/inotify_fsnotify.c
> > index 7c326ec2e8a8..6456d9c0e408 100644
> > --- a/fs/notify/inotify/inotify_fsnotify.c
> > +++ b/fs/notify/inotify/inotify_fsnotify.c
> > @@ -40,6 +40,7 @@ static bool event_compare(struct fsnotify_event *old_fsn,
> >                 return false;
> >         if ((old->mask == new->mask) &&
> >             (old->wd == new->wd) &&
> > +           (old->sync_cookie == new->sync_cookie) &&
> >             (old->name_len == new->name_len) &&
> >             (!old->name_len || !strcmp(old->name, new->name)))
> >                 return true;
> > --
> > 2.43.0
> >
> 
> Practically, this means that MOVED events can never be merged,
> so a slightly cheaper and simpler test would be
> if ((old->mask == new->mask) && (old->mask & INOTIFY_MERGEABLE_EVENTS) && ...
> 
> Thanks,
> Amir.
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
