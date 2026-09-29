Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12C05208C0;
	Tue, 29 Sep 2026 14:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692152; cv=none; b=m4N9XEeMLOPpYZaXJPGR7snpVs4XYpX/S83ugKW5/2H7aWdhIe1LmuKLd3oNoEw6+bZr3up0YTBaOnuD8GazI7ccGyAl13dnyqP2iGMot1T1W3RgX6btyTAlCsyN8g3xFFoYMi860kfsKajMs4NQOy65YRb+P0G6+XGCDoV9DQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692152; c=relaxed/simple;
	bh=w/e1Rdf2eLmsU/4J7HPOCD4qHcG5zrAaGrBj5/cCQso=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyIwhWONmBYrv4iRS5AupSBvpnZEwnd5ctLXByXWGQYhcCCZt2oT5ntKtm40WukSTCAlA5C6O2CPLMKddt0bUbSvoEb2UvUWN8xwWiZAPHTnt55IVKd+csxq/6ydA9hGwuGGilmJFk6vD9TVilOwcKGbXWNcj2sItBNZ0ChAQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SliyYRpl; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=lCUCy6zY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Iz0JO63w; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=p/l6HzuH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SliyYRpl";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="lCUCy6zY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Iz0JO63w";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p/l6HzuH"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 65DEA1F78B;
	Tue, 29 Sep 2026 14:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790692144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RDlHHRObssJxjZmy38EgCxxabAZhGE0B2TgLbzxnrgw=;
	b=SliyYRpl2rP+x2WYh6C8d60++pwKxMJNO7bnBaf8gCznuMq60OWKcfJz7ODUAUDZFdMTJI
	5x0GPLKjbmO93etXkFvSFVE/KjbC3yvngBgQye9VjbbOK1rg52egyqoqcLYmvQaXGQuNG9
	P1g8bqFAXSXsRKi6U5wujbYjHqdNXr4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790692144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RDlHHRObssJxjZmy38EgCxxabAZhGE0B2TgLbzxnrgw=;
	b=lCUCy6zYuFUfanUOJ8o3jbQwCV5xsKGS6uUhWYA9+yaoHRK/jgo1ZssXqR40+0khk0vFgA
	l8MIBpW0lg9oiWAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Iz0JO63w;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="p/l6HzuH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790692140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RDlHHRObssJxjZmy38EgCxxabAZhGE0B2TgLbzxnrgw=;
	b=Iz0JO63wiFuiSc75MLFHd9DwrSokXrcqQtFNwbl8k5hZi9r9uGAoynKmIePCh0T29gm9+n
	aLSx2ojtxI0eexb9YMD/VMrYa0RAM8T6+A824WEs9eXgk7+XHZWBTwQO62L5xthDL4DvFB
	N9qjafAioUjC923f7DbHUfukw8XN2bY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790692140;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RDlHHRObssJxjZmy38EgCxxabAZhGE0B2TgLbzxnrgw=;
	b=p/l6HzuHA09onQJZ1qxChk1jNRmenq5h4RH8f+4rmMe13pXjSrpHgOaBYkwn49fPzZR6xQ
	LtHvYi6X158ZnEBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0CAE0133F1;
	Tue, 29 Sep 2026 14:29:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rlF5NSvLu2o8XwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Sep 2026 14:29:00 +0000
Date: Tue, 29 Sep 2026 16:28:59 +0200
Message-ID: <87wls4yvv8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Faaris Ansari <faaris.ansari@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,	Faaris Ansari
 <faarisansari@googlemail.com>,	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,	regressions@lists.linux.dev,
	linux-sound@vger.kernel.org,	=?ISO-8859-1?Q?C=E1ssio?= Gabriel
 <cassiogabrielcontato@gmail.com>,	Takashi Iwai <tiwai@suse.com>,	Jaroslav
 Kysela <perex@perex.cz>
Subject: Re: [REGRESSION] Audient EVO4 hardware volume control now requires quirk
In-Reply-To: <0e1a1284-7069-4c46-9f35-57c10c129883@gmail.com>
References: <CANBVYRCL=8QdLxGg4S6qrahrFtwJxhv-aSGpW7-1S=+iOe4ZGA@mail.gmail.com>
	<2026-09-27-daily-reply-0001-re-audient-evo4-mixer-put-errors@kernel.org>
	<CANBVYRAr_ShKGmrt2NoqsDsDEbTXa5DWJbq2oP6wKLWJQpLRWw@mail.gmail.com>
	<2026-09-28-daily-reply-0001-re-audient-evo4-upstream-decision@kernel.org>
	<ee6e9e8f-e174-4872-baee-114d848e8137@gmail.com>
	<2026-09-28-2-daily-reply-0001-re-audient-evo4-channel-3-set-cur@kernel.org>
	<87tsn838gk.wl-tiwai@suse.de>
	<87mrt01bdg.wl-tiwai@suse.de>
	<87ecec19pa.wl-tiwai@suse.de>
	<0e1a1284-7069-4c46-9f35-57c10c129883@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,googlemail.com,kernel.org,vger.kernel.org,lists.linux.dev,gmail.com,suse.com,perex.cz];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Spam-Score: -2.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 65DEA1F78B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Tue, 29 Sep 2026 16:24:24 +0200,
Faaris Ansari wrote:
> 
> Thanks Takashi and Sasha,
> 
> 
> > Faaris, please let us know if this (or previous) one actually works
> > for you.  Once after confirmation, I'll submit the proper patch for
> > upstream.
> 
> I tested your latest patch where you removed the quirk for the iD14
> alone, and instead set it for all Audient devices.
> 
> I can confirm that this has indeed fixed the problem, and I can now
> correctly control my hardware volume without problems, thank you!
> 
> 
> > ... or if you have a chance to test Christian's patch set and verify
> > whether the problem is fixed there, we can avoid other changes:
> >    https://lore.kernel.org/20260919151840.24371-1-arc@gmx.li
> I tested Christian's patch alone, without any other changes. The
> problem still occurred with those patches.
> 
> This was also noted by Christian:
> 
> > As a matter of fact, I made a similar
> > observation to yours when testing the patch set on the 'sound' kernel tree
> > and the (very sporadic) issue did not disappear after applying the
> > patches.
> And further discussion below:
> 
> https://lore.kernel.org/all/CANBVYRAr8iFGFDgdTcDXuQyXt5M4TddZetsG9o1wbFao03R0yw@mail.gmail.com/
> 
> 
> However, using both patches together (as well as a small patch for
> alsa-ucm-conf) has made my interface work very well - I'm very happy
> with these changes :)
> 
> 
> Thank you for your work, Sasha, Takashi, and Christian,
> 
> Faaris

Thanks for clarification.  Then we need a fix like mine in anyway.
I'm going to submit the proper patch.


Takashi
