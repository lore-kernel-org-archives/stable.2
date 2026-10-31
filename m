Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793463040;
	b=tRh3dyH/WOEj58SpZwyNYojTGhOZeUoZ9Jm7M2qvQR59kmSkEKsBfPCd3Nhtmo8Q95kl
	 iObtAOkV6MB42HaTXMCOLyUTG6kk31xz9GWpMx+81ZEc64cHBHxXjypaA/rVsPNzQWZOn
	 RkMiQh0HnKe8zWjDWgFLRmBBnE52m2nt0ktjH44QKOnFzBmuv0s356BenhMM5yIm/BFv5
	 f/2HcHuvqgh8a8csGH/JqEZhaHOU15iCfgHL5fxbtt3j/3zdE6WB4esQ7z537bFmFQO8r
	 ra6k9mTG1l/N/oWQHqyr45euMfJxX+KwTmwRuJSd0834obyLzBzPyyLyv8mZpT5DBLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793463040;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=gsabXBdvNmlT29U5627RHQL/AD4UhekVuA2wIXV9kEg=;
	b=ZClbBX9RV0nBspFWYOAOKOVTHT8BXeHnW/NwG5VwGOuzI3Z2Tkz3/HuL4QI74SV7VZax
	 QMAXW8m5KqUH18xRJ8oTnZwMVsqNrX9o0/6zzAkzpLS7sC+meVYoNiv/fyMua9iR66fb2
	 YaDD5avhctckm11T9Ljs99LgtrryL7QCDN3l0O7goEkHGgapMnCtgWCpCc51vXgzYMmht
	 cfyxzmsuk64uXijRS0Zx0weOIDQRaik1mhnqVP/oZE7yXoigXRTloMu40Vsg8GpN7Tliq
	 ERGA1eXN+yJdtwIg7g0co5Ss6HMMsMeo22c05RdjEJdGUQixlprPTNpEG46gFY+aAKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ti9JMSzt;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VbOOBCmF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Oo28GfAx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c0FrquIl;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEED0606A31A;
	Sat, 31 Oct 2026 16:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEED0606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Ti9JMSzt;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VbOOBCmF;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Oo28GfAx;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=c0FrquIl
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 070021F798;
	Sat, 31 Oct 2026 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793463038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gsabXBdvNmlT29U5627RHQL/AD4UhekVuA2wIXV9kEg=;
	b=Ti9JMSzt3BG/ZplrSX2TlBfuCODaeynWRNi+dmqhjqtXpjCCQc7Suc9UlEL+kD+Sx8Jnlv
	A0JrM+qc/03rybetmKckH19l7B55dMtz4sripVVNh7P7xDQrrN5VwdcYUrf+2nMD9D8d0F
	MkdkMHp0yJ9QB7SOpqXSbHkbB6RvCM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793463038;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gsabXBdvNmlT29U5627RHQL/AD4UhekVuA2wIXV9kEg=;
	b=VbOOBCmFz00hnU/JOCHxzaJbRPIRf1inaF+mCuiR65wzvcw9gMp/Nr81FVeu4wiiBHeIW4
	6TI+GGbOLXa++uCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793463037; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gsabXBdvNmlT29U5627RHQL/AD4UhekVuA2wIXV9kEg=;
	b=Oo28GfAxQtHEWqubOyfgm+s8esLXqrifr2cmPCAm/805ZDqKzTgqbjsLFTValyYnBkSoOk
	dSzXHkbcjbQFACSN+zC1IAqdPRcFcnOSdZdxVCQ067WWvSFT3ZvB9kQwKA5JtEfR74PPtq
	JkXetDxY+cUBkGornEO4wiL90YVfNXM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793463037;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gsabXBdvNmlT29U5627RHQL/AD4UhekVuA2wIXV9kEg=;
	b=c0FrquIlN453OlRqwIIu75+Rj782jQq4qMPk7U0fmFWGUozz1fMJXGYTx2lSy77DQaz81e
	REEUoB1T1/Oc3xAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A021F132D3;
	Sat, 31 Oct 2026 16:10:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BnRbHfwS5mo1NwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 31 Oct 2026 16:10:36 +0000
Date: Sat, 31 Oct 2026 17:10:36 +0100
Message-ID: <87o6c9rgub.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Alex Kazinsky <a.kazinsky@ideco.ru>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Denis Arefev <arefev@swemel.ru>,
	Hemanth Selam <hemanth.selam@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: cs46xx: Handle SCB creation failures before dereferencing
In-Reply-To: <20261030142529.415697-1-a.kazinsky@ideco.ru>
References: <20261030142529.415697-1-a.kazinsky@ideco.ru>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-10.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,swemel.ru,gmail.com,vger.kernel.org,linuxtesting.org];
	RCPT_COUNT_SEVEN(0.00)[9];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,imap1.dmz-prg2.suse.org:helo,ideco.ru:email]
X-Spam-Score: -10.80
X-Spam-Level: 
X-Spam-Flag: NO

On Fri, 30 Oct 2026 15:25:27 +0100,
Alex Kazinsky wrote:
> 
> With CONFIG_PM_SLEEP enabled, cs46xx_dsp_create_scb() can return NULL
> if kmemdup() fails to allocate the SCB data saved for resume.
> cs46xx_dsp_scb_and_task_init() and _dsp_create_generic_scb() dereference
> the returned pointer without checking it, causing a NULL pointer
> dereference on allocation failure.
> 
> Check both return values before accessing the SCB descriptors.
> Return -ENOMEM when creating the null SCB fails and propagate NULL
> from _dsp_create_generic_scb().
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE
> static analysis tool.
> 
> Fixes: 41116e926cb9 ("ALSA: cs46xx - Fix suspend/resume with new DSP")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Kazinsky <a.kazinsky@ideco.ru>

Applied now.  Thanks.


Takashi
