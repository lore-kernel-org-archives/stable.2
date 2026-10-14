Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546184D4871;
	Wed, 14 Oct 2026 12:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791981935; cv=none; b=Gf9JZMTbRzA0di/lH0bmzlcQY7GR9R5bO/9SObs7+9RlkWIiS+EGKNPnYBIU1ot5Lx/Wx/oh16KLa0/ref1rxvuJRmsYeRMVd4KTY8Eg60nZVfzmLHodLoDM1/f5F2dnS7ysDkhC78MowmC/6jfZekmg1RUnYnL3syowHSw6mWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791981935; c=relaxed/simple;
	bh=FJymfokqsLfXBMpBqijk9TvKwRPR5GSsc85kv3nm0to=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZ1isXkRB+bkFFKZ4vgjT2XVUBxjiSAHQ98nYOCzlvk1M+eSjw7mRGedxIE9N7zJBd1PPSCD+mHoOV/2lgWA+GoKs7shdzzRu/gb1OFupzvV96NQaPr4zp1iiYbkZmwl8oid/X12dKfeh+LsGUIbaWCXyshcgQFE/WvwBGcOx24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X5Ysn2qB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SLf8xZpc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=X5Ysn2qB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SLf8xZpc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X5Ysn2qB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SLf8xZpc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="X5Ysn2qB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SLf8xZpc"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2296C1FB5D;
	Wed, 14 Oct 2026 12:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791981930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6rZjnu+Fwd6PWdJnu97bNOKUyhRHl0nqWvV0eh825Q=;
	b=X5Ysn2qBsRz6UCvijn93QvY5q/3Tz9P7wOZtrY9WT+L1n+RfhuvekVVJibxREz3oIE0t9p
	YxuwnCTEc+CDz+3cOzHz0gvQ6056bzLE+g6xMXLcsWvDxaJa0DO886bApXLrxBtb8DKiit
	Ivxn+nog2oQiZyJeaLi9Qo+cU/XAzHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791981930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6rZjnu+Fwd6PWdJnu97bNOKUyhRHl0nqWvV0eh825Q=;
	b=SLf8xZpcJ1Er7o3vbI85CTg3LQotMEehV7nDkZiFlcdAFPzDhpPJmz2hCbiZBLUO9IWZzy
	Hq35I13S9FjLXIBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791981930; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6rZjnu+Fwd6PWdJnu97bNOKUyhRHl0nqWvV0eh825Q=;
	b=X5Ysn2qBsRz6UCvijn93QvY5q/3Tz9P7wOZtrY9WT+L1n+RfhuvekVVJibxREz3oIE0t9p
	YxuwnCTEc+CDz+3cOzHz0gvQ6056bzLE+g6xMXLcsWvDxaJa0DO886bApXLrxBtb8DKiit
	Ivxn+nog2oQiZyJeaLi9Qo+cU/XAzHY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791981930;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Z6rZjnu+Fwd6PWdJnu97bNOKUyhRHl0nqWvV0eh825Q=;
	b=SLf8xZpcJ1Er7o3vbI85CTg3LQotMEehV7nDkZiFlcdAFPzDhpPJmz2hCbiZBLUO9IWZzy
	Hq35I13S9FjLXIBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 78E2E1368E;
	Wed, 14 Oct 2026 12:45:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9HLfEmh5z2rQCwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 14 Oct 2026 12:45:28 +0000
Date: Wed, 14 Oct 2026 14:45:27 +0200
Message-ID: <8733u8e9i0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Denis Arefev <arefev@swemel.ru>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Kees Cook <kees@kernel.org>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: cs46xx: fix unit mismatch in DSP code area bounds check
In-Reply-To: <20261014102619.16415-1-arefev@swemel.ru>
References: <20261014102619.16415-1-arefev@swemel.ru>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On Wed, 14 Oct 2026 12:26:18 +0200,
Denis Arefev wrote:
> 
> ins->code.offset and code->size are measured in 32-bit words, while
> DSP_CODE_BYTE_SIZE is the size of the DSP code area in bytes. The
> check ins->code.offset + code->size > DSP_CODE_BYTE_SIZE in
> cs46xx_dsp_load_module() therefore allowed up to four times more code
> than the code area can hold.
> 
> The shadow buffer ins->code.data is allocated with
> kmalloc(DSP_CODE_BYTE_SIZE), i.e. it holds DSP_CODE_BYTE_SIZE/4
> words. A firmware file with a code segment larger than
> DSP_CODE_BYTE_SIZE/4 words (28 KiB) passed the check and caused an
> out-of-bounds write in shadow_and_reallocate_code() and an
> out-of-bounds read in snd_cs46xx_download().
> 
> Compare the sum in words against DSP_CODE_BYTE_SIZE/4 and cast it to
> u64 so that the sum cannot wrap for large code->size values.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Denis Arefev <arefev@swemel.ru>

Applied to for-next branch.  Thanks.


Takashi
