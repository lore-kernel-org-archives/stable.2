Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D877A509F0E
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783732; cv=none; b=tj1oTh8j3BREpdi0VTX8Mnk/zQn6M4hOsvBv2GNlnDh/H+QCPhCWnZMI2eAZD/9i9lGImAYcuvkFJkaAsZtyOfWmIWYDfvUQhZLcSI4vb/sTG4Y+rL+3J1j/Pm6kbt2aXFs9Rl/A0HH75az9YovMYJxmz1CgFH1+IVOGU/h9c4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783732; c=relaxed/simple;
	bh=rOmg/zuZJLziALrOxUDMmPUvxWPLLGbfLfH+4a06eks=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OWNvntL3Td2YRR020zPuo6swNPJihDf/u6OP9FHKUqMeiDTpM+hRuP6ZX2EM7CAE3g6wG97ARuZZHXchCApyYNc7HcEk4jZBosOzKTrCmWFakasvuteRnSF+7rhYSKn8AqkTJmFlamTDHXyv6owPGoX5gdaFLN/6UMywXAVnFRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1EPT5ymw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FH6Hbv49; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xXEjFxHj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=z3YfDuTf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1EPT5ymw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FH6Hbv49";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xXEjFxHj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="z3YfDuTf"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE11721C4D;
	Wed, 30 Sep 2026 15:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790783707; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37nsKjN389F86zefc+/8/JYTfxzCQ5MZ9OZrsTbxoik=;
	b=1EPT5ymwPRccGZhLQcIc71EBsDCjlI0XdzrBtC32PyPm4tUEnGgHJVmxXdQSjPZ5a9P8Kv
	18G/Yp/7xJ8k1qNCgR55+MNjunPwWu6jQ5FUgRDQ878JnRqP1/UKQC6eEPqBb6pnZf0yj3
	bcuziKh4i7MLyY7inDJ+CuOMs5sk1QA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790783707;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37nsKjN389F86zefc+/8/JYTfxzCQ5MZ9OZrsTbxoik=;
	b=FH6Hbv49bi1W2dOTP5hKldK+TjNumazaRh6tpWr6zZQnGMxyolItXJVhregzvXkXJmepxL
	A10hQ2JKpQGq4HAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xXEjFxHj;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=z3YfDuTf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790783703; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37nsKjN389F86zefc+/8/JYTfxzCQ5MZ9OZrsTbxoik=;
	b=xXEjFxHjJiY3jxBMFUCYBSUosU0veaDAJuuUiwJFE/aWlHkesJd78AbalLTAR6/2SNbC5W
	8ATRqFCgfRznOhi/RAB9Ud2Icdp7sO5lOfio+wk1hLVhNzt7mADyYpSvrSDL91JA5Ad9lb
	Kpw0te6NlDI4VHCGYWDAVBJ0wCEyvGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790783703;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=37nsKjN389F86zefc+/8/JYTfxzCQ5MZ9OZrsTbxoik=;
	b=z3YfDuTfa5dPfQ8JlMbnzJPKYF23+lpWUQG3zlXb/qBa95SjlCwvt7TVjG5IQIj5HNpCm3
	JmZ5+XSqXjbyr0Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6247013722;
	Wed, 30 Sep 2026 15:55:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wa1oDtcwvWoNVgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 30 Sep 2026 15:55:03 +0000
Date: Wed, 30 Sep 2026 17:55:02 +0200
Message-ID: <87bj9e4tux.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Jakub Gawlik <jakubgawlik13@gmail.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Add micmute LED quirk for Acer Swift SFG16-72
In-Reply-To: <20260930145839.374762-1-jakubgawlik13@gmail.com>
References: <20260930145839.374762-1-jakubgawlik13@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: AE11721C4D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Wed, 30 Sep 2026 16:58:39 +0200,
Jakub Gawlik wrote:
> 
> The Acer Swift SFG16-72 (1025:173b) uses the ALC245 codec, but its
> mic-mute LED is not enabled by default. Apply the existing
> ALC245_FIXUP_ACER_MICMUTE_LED quirk to enable the mic-mute LED.
> 
> Assisted-by: LLM
> Cc: stable@vger.kernel.org
> Signed-off-by: Jakub Gawlik <jakubgawlik13@gmail.com>

Applied now.  Thanks.


Takashi
