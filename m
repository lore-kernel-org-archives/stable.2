Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09F13D524C
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250927; cv=none; b=FJ2XXd8k5A8VgYjXOD77hReCZEaPHu1vhvERdHcdnko7Z7+p7htXVUv+YGEd4XHtOcexU16F+PxuDqUIr0/AcdNvWncfFI4U+Wyc6VadBeEWYCofg4Tviycq6oyIYEZyj88caZd6V1/pYoLr+vhYfHmeCycojaME2lt1jH4eljA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250927; c=relaxed/simple;
	bh=inujiCA5hvuaz3CgdB2gtr+lHjATxCGlyFZzEYPmi7w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rfNwZ+hlduEClcHo5WcYRUCYSs7wE7oAYbrbY/uBccsp33k2rcBs2Q54UKk2detiN60mJQr8Xc4yhDEKuC8Kd1sqecg53wnEhGrMnxOe/cICgWiE9dlYSXvW/R4NlDm4SkTuhUBmv4NQjv5mFtyDD7WsBBXCdhRnEA0tfPWC1MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yT3burFH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YKjLqlgu; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yT3burFH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YKjLqlgu; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yT3burFH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YKjLqlgu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yT3burFH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YKjLqlgu"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B265875B21;
	Fri, 12 Jun 2026 07:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781250921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qba5IcKrzlixBbsatu0TxnPcO9fOzTi1MgdskkLYKTQ=;
	b=yT3burFHSworYcZeRKQHynFhTvSYTrb9IW/EhhyhJ/og3rsABM5Pa3Hl6Bno0Zekq7Rcxw
	0ozLH6KGQsD6OE7o9SKDy0sleGrgjhkQWG0eSbYDUVKUXVf3juBEbTI6Rh1xD/hwvOJoaH
	NEeU5rfW12J51c07YkBeCenKiMnB1t8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781250921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qba5IcKrzlixBbsatu0TxnPcO9fOzTi1MgdskkLYKTQ=;
	b=YKjLqlgunLiz2GebZaBUC4uat91vLpsszJqk8BLlSPmtR0/E1KCUsyjA7l5+oZbBj6hbVp
	WitLDFlPG4kPzaDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781250921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qba5IcKrzlixBbsatu0TxnPcO9fOzTi1MgdskkLYKTQ=;
	b=yT3burFHSworYcZeRKQHynFhTvSYTrb9IW/EhhyhJ/og3rsABM5Pa3Hl6Bno0Zekq7Rcxw
	0ozLH6KGQsD6OE7o9SKDy0sleGrgjhkQWG0eSbYDUVKUXVf3juBEbTI6Rh1xD/hwvOJoaH
	NEeU5rfW12J51c07YkBeCenKiMnB1t8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781250921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Qba5IcKrzlixBbsatu0TxnPcO9fOzTi1MgdskkLYKTQ=;
	b=YKjLqlgunLiz2GebZaBUC4uat91vLpsszJqk8BLlSPmtR0/E1KCUsyjA7l5+oZbBj6hbVp
	WitLDFlPG4kPzaDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 692F6779A7;
	Fri, 12 Jun 2026 07:55:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1dBgGGm7K2qmJQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 12 Jun 2026 07:55:21 +0000
Date: Fri, 12 Jun 2026 09:55:21 +0200
Message-ID: <87wlw4i45y.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	chenziqing@xiaomi.com,
	broonie@kernel.org,
	cezary.rojewski@intel.com,
	kees@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: control: Fix power refcount leak in snd_ctl_elem_read_user
In-Reply-To: <20260612022702.15371-1-vulab@iscas.ac.cn>
References: <20260612022702.15371-1-vulab@iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo,iscas.ac.cn:email]
X-Spam-Level: 
X-Spam-Score: -3.30

On Fri, 12 Jun 2026 04:27:02 +0200,
WenTao Liang wrote:
> 
> snd_power_ref_and_wait() increments the power refcount before waiting.
> When it returns an error (e.g., -ENODEV due to card shutdown), the
> refcount is still held, as documented in its comment:
> 
>   "The caller needs to pull down the refcount via snd_power_unref()
>    later no matter whether the error is returned from this function
>    or not."
> 
> snd_ctl_elem_read_user() fails to release this refcount on the error
> path, leaking a reference. This can impede proper card resource
> cleanup during shutdown sequences.
> 
> Fix by calling snd_power_unref() before returning the error.
> 
> Cc: stable@vger.kernel.org
> Fixes: fcc62b19104a ("ALSA: control: Take power_ref lock primarily")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Your all other patches for sound/core/* look like similar fixes, and
should be better put in a single fix patch.  If need to split to
multiple patches, though, please send a series of patches in a thread,
instead, at the next time.


thanks,

Takashi
