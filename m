Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0C320E030;
	Mon, 31 Aug 2026 08:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788163672; cv=none; b=IKI34recWynTIGHoWokHZsT6oXnequ6na0UPKlFOBQCBuqo+pVI6AB1KYkR/PZK8G94kMJjaB+uM8jia4GbkIXHGRzzJNuS85slrvSOyMPJUSeyiH7SMTfBVB4UELlHuEt7ATDn/qRVpqwf8+FW3e8xfWEvKyPn1no0prleoWlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788163672; c=relaxed/simple;
	bh=6/cLM5g/WJtoVYtFL4iQi5aHQ/XQuWJSmCt3KKsQUq0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tHD8U5QnFJ+4uJEk5tSQJn43qsihIM1Y8AiGBGVzdAa94AI1a3dutGRSiLNJV5KkAvQBqGFtrO0Y+L3Axsq3hVSb1EBSfXsjGjw0vVkH51NHifZv8yZmeupPnkDcQS9lBBlAwruJGhizzLLsxn+4TYDBnjVJlXImJ/NN2MpCvoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=VluFJj+f; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=UdxE+aJk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=wTCdp06O; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=roSde+xp; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="VluFJj+f";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UdxE+aJk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wTCdp06O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="roSde+xp"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8C46521B98;
	Mon, 31 Aug 2026 08:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788163664; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bh1K3xCV332i7tHch/0JGEeOZf6yxFo27FgjHyV/hZ0=;
	b=VluFJj+fAcN3mXs5NEh52I5dWSF0oNQvNqDqNV79b8Tr92a91RklZpyHa+MSHNXctpmcEK
	Ts6wOBGW5gSLvjll3ZP63UCX3F0T5dyAopsDDIKJBkF8Vw1BCUKF/xr0f5LxG/ruAd8wI4
	ytQFUhxlqb4CFBo5zz14scAsqTNUJ3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788163664;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bh1K3xCV332i7tHch/0JGEeOZf6yxFo27FgjHyV/hZ0=;
	b=UdxE+aJkc30cYDxPwquM5B24X/iZrtVTE4UBdh7eDpKju8cUkkEz4p0S7RoeBisuqKnQhI
	h0z+e2RDW3M6pNCw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=wTCdp06O;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=roSde+xp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1788163660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bh1K3xCV332i7tHch/0JGEeOZf6yxFo27FgjHyV/hZ0=;
	b=wTCdp06Ov80WEksnOri+bmCyUKoZxspEObMWnSHKhIHMdi/qlly3/EJxhuE2zAnRcL4WAd
	5xb1Of7RJ7/xGrr8e8RiC6rPwKabqpuE8k5vGX81PWBvmBqRRIngnE/i33d01Nu+u5mOuB
	GI5IUyJJtOixaDgBeK7ZtvefDHPCBhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1788163660;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bh1K3xCV332i7tHch/0JGEeOZf6yxFo27FgjHyV/hZ0=;
	b=roSde+xpPOWHfVfLbnKq29zVCK4YK3m3fsDpL36JgjmePXY1QbilzoW+zff6diBO+TdJJv
	DvB7AkZfnJsc/qAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 441A613515;
	Mon, 31 Aug 2026 08:07:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fDpDD0w2lWo+fQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 31 Aug 2026 08:07:40 +0000
Date: Mon, 31 Aug 2026 10:07:39 +0200
Message-ID: <87bjaisofo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: tiwai@suse.de,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	jianhao.xu@seu.edu.cn
Subject: Re: [PATCH] ALSA: harmony: initialize locks before requesting IRQ
In-Reply-To: <20260830063411.2215691-1-runyu.xiao@seu.edu.cn>
References: <20260830063411.2215691-1-runyu.xiao@seu.edu.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.51
X-Rspamd-Queue-Id: 8C46521B98
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

On Sun, 30 Aug 2026 08:34:11 +0200,
Runyu Xiao wrote:
> 
> snd_harmony_create() registers the IRQ before initializing h->lock and
> h->mixer_lock. A pending interrupt can invoke the handler while these
> locks are uninitialized.
> 
> Initialize both locks before requesting the IRQ so the handler always
> sees valid lock state.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: Codex:GPT-5
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied now.  Thanks.


Takashi
