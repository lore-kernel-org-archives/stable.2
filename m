Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BE14DBD95;
	Thu, 17 Sep 2026 12:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789648596; cv=none; b=dE+2m8JiKVcTX2ajSxAkG0qLyD/CvuxTtLvBWzfJ1lE2T9Q7K7SrIBMfCP/0t33OdqDeo/DTysdfxyjE1smx9NFGlwWErLCl6fxdS3yRUHaRIFWZEttFOtCDKNlZyn7MR2WEFJD2c2L266SkCvLKHCf5S2ZzrnWD9M998Fb73DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789648596; c=relaxed/simple;
	bh=Q3Z2K172DMZAAp1WS3laXPCxAxtRcPkP2yc392Vnka0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mzXf00uVVH6K6gHtyfhgXG28eDMwOPf9PBckrR4KYyrLDehAK/llLupMVDZzJblsM2xnd1Y5INU3aGpc5Xeo6dIv9ls5oxctDOoQ5mVkmgmVTDEW+ko5917EsLZz7kBHt2uhMlT1E8q1hF0dNZ1/+S+PciVFxtkEySm6dG82oSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=iiEqKOLU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=g84VQkKN; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MnxOhCI0; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=h6ADm2Cp; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iiEqKOLU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="g84VQkKN";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MnxOhCI0";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="h6ADm2Cp"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B56321FF8E;
	Thu, 17 Sep 2026 12:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789648580; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnMwI5gZvhpSHs9sQbW0pRtRH6P+qd+p3Hx80B1hG2w=;
	b=iiEqKOLUvy+TzTxUhms0Si5+1Xq13BEir0fhJgioQILQObnVNNgPTq7ey1KBxBplq7qerw
	OX3q8DKSMxbnewDR1IONIP0GF6V1nzDpaUtKIEv4B/l/zBgZZoVSJYnnOjNhO5tuJ3lk0h
	Lqk6buJap8Qnv40LxPKjRQu8cI8QTKA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789648580;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnMwI5gZvhpSHs9sQbW0pRtRH6P+qd+p3Hx80B1hG2w=;
	b=g84VQkKNBmj+ShSi+fCaNRvipGS4mTY0hnO1jl69u3eimpPJaHk/0V7uuGZQz5G6eofuzr
	Ux17KdjBQIlhnCDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789648576; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnMwI5gZvhpSHs9sQbW0pRtRH6P+qd+p3Hx80B1hG2w=;
	b=MnxOhCI0ebBfIc0IQesHQf43VKxIFkmJ0y5wnxcK1I0emhhzsON1nc6hyjl3wHegiWfdLj
	85Wyx54wSoRTJjGOgLgAcTsHJoiyNSbBG+w4qFs2/dVo9PU+nyIvn2B+pwDqe6G5u67xkW
	J7AvkHk3oqngPmlcKx+ykmxwgBIvxZc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789648576;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mnMwI5gZvhpSHs9sQbW0pRtRH6P+qd+p3Hx80B1hG2w=;
	b=h6ADm2Cp3d5le6Eue2sJjKJ9vOL+pMscWmuYX0aitEFuVmm4YALg5U1MDPJWgMoy7q6gkp
	nQ5r4RWD816PMSCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 53CD3134B3;
	Thu, 17 Sep 2026 12:36:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Z6bTCcDeq2prBwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 17 Sep 2026 12:36:16 +0000
Date: Thu, 17 Sep 2026 14:36:15 +0200
Message-ID: <87pkycgim8.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Bruno Produit <bruno.produit@trailofbits.com>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kyle Zeng <kylebot@openai.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Dominik Czarnota <dominik.czarnota@trailofbits.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: seq: Serialize compat port-info ioctls
In-Reply-To: <20260917105643.90102-1-bruno.produit@trailofbits.com>
References: <20260917105643.90102-1-bruno.produit@trailofbits.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO

On Thu, 17 Sep 2026 12:56:43 +0200,
Bruno Produit wrote:
> 
> From: Kyle Zeng <kylebot@openai.com>
> 
> The native sequencer ioctl path serializes handler calls with
> client->ioctl_mutex, but the translated port-info compat path invokes the
> same handlers through snd_seq_kernel_client_ctl() without taking that
> mutex.
> 
> This lets concurrent compat CREATE_PORT requests pass the port-count
> check before any request reaches the serialized insertion. The computed
> integer port index can then exceed the address field range and wrap to an
> existing index. Subsequent subscriber teardown can resolve the duplicate
> address to the wrong port and access a freed subscriber.
> 
> Take ioctl_mutex while dispatching converted port-info requests, matching
> the native ioctl path. All translated port-info commands share this
> helper, so their accesses to the client port state are serialized as
> well.
> 
> Fixes: b3defb791b26 ("ALSA: seq: Make ioctls race-free")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:gpt-5.6-sol gpt-6-astra
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> Signed-off-by: Bruno Produit <bruno.produit@trailofbits.com>
> ---
> 
> Trail of Bits has a reproducer for this bug that triggers a
> KASAN use-after-free and can it share if needed

The bug looks obvious, a long-standing oversight.
Applied now.


thanks,

Takashi
