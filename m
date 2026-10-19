Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E173E49AA21
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 08:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399189; cv=none; b=VPBEjzbUjygLqLwiot86XGajUgGkA2+ELwjQ3Fdu+M4Ht0qY+rTUdDv71GolUwoswVI6XkK+xCOMri54whygqLTNHF4wLWoRmx/zU3dkCXsorgsbOhyPxFN13wrlidE1Ul8P8tAhed2oPMRpDUixfx1DYBJQoE2AKIq1h+f56jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399189; c=relaxed/simple;
	bh=gHHoNZ+y2xTApiIcRTd+qtHEEyy0hqz5DzGbZvMIZC4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SK0dbiUQzT6VFOmYCMkzJsfA1NuvLSyMPVxy9yKIXItpwU2citm8hBSOWY8DLmZMXIulIftGBPSdofGopXw1zONnZ51zzfJZEP66zXAGcs1ze5CUTYgUfMB1kweQcn/BgQj7gmTe4wdH2OC+XWi/UiV9JCTsoBFxPpalyhiqUUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R7zq3Jms; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wydFCCaW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R7zq3Jms; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wydFCCaW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R7zq3Jms";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wydFCCaW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R7zq3Jms";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wydFCCaW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7C4311F797;
	Mon, 19 Oct 2026 08:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792399165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFMxILZ8z4IFfdYoYqefPVjYbOhYnGimGBBhxic87Mg=;
	b=R7zq3Jms2oIBdlpNd9T7jlWyRDaKVbi78S7FHi77LdBi/nZyRBxS7F5xk/GSdJD+HTyqV6
	suAzC+S56EPZ0P0vwIaZfFlP0TUD6yPPWHuFA/zMJdU4p0gJIw+1lDWPPYBSG6JTShqqJm
	ALaSyzxcjGcfmlB806UefyC50AXia44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792399165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFMxILZ8z4IFfdYoYqefPVjYbOhYnGimGBBhxic87Mg=;
	b=wydFCCaWOlQYGQ2YR8CdcZWT6r6YCkQmOdycMC8MvT2pYZM4w98Qxp4Nffw8M0Zsfzfe1M
	5Hp/4LnGxvmWhhBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=R7zq3Jms;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wydFCCaW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792399165; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFMxILZ8z4IFfdYoYqefPVjYbOhYnGimGBBhxic87Mg=;
	b=R7zq3Jms2oIBdlpNd9T7jlWyRDaKVbi78S7FHi77LdBi/nZyRBxS7F5xk/GSdJD+HTyqV6
	suAzC+S56EPZ0P0vwIaZfFlP0TUD6yPPWHuFA/zMJdU4p0gJIw+1lDWPPYBSG6JTShqqJm
	ALaSyzxcjGcfmlB806UefyC50AXia44=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792399165;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UFMxILZ8z4IFfdYoYqefPVjYbOhYnGimGBBhxic87Mg=;
	b=wydFCCaWOlQYGQ2YR8CdcZWT6r6YCkQmOdycMC8MvT2pYZM4w98Qxp4Nffw8M0Zsfzfe1M
	5Hp/4LnGxvmWhhBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3204B136CC;
	Mon, 19 Oct 2026 08:39:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eaWWAj3X1WrjbAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Oct 2026 08:39:25 +0000
Date: Mon, 19 Oct 2026 10:39:24 +0200
Message-ID: <87jyneaxtv.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: gxristidis@gmail.com
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix headset mic on ASUS Zenbook 14 UX3402VA
In-Reply-To: <20261018-for-linus-v1-1-4d8e9ff27d89@gmail.com>
References: <20261018-for-linus-v1-1-4d8e9ff27d89@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spam-Score: -3.51
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Level: 
X-Rspamd-Queue-Id: 7C4311F797
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Sun, 18 Oct 2026 18:56:31 +0200,
George Christidis via B4 Relay wrote:
> 
> From: George Christidis <gxristidis@gmail.com>
> 
> The UX3402VA (1043:16a3) BIOS leaves pin 0x19 unconfigured, so the
> headset mic does not work. Use ALC294_FIXUP_ASUS_SPI_HEADSET_MIC like
> the UX3405MA, it sets up the mic and keeps the CS35L41 speaker fixup.
> 
> Tested on a UX3402VA: headset mic, internal mic and speakers work.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: George Christidis <gxristidis@gmail.com>

Applied now (with Fixes tag).


thanks,

Takashi
