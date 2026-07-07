Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9F4252A2
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434904; cv=none; b=qHJN+jgbIKg8Z9pnM8ShpPkx1ESgqSYrhR/MwdQtO+XfiTrEGsgJs/oTqAVGDI5JIc10+MsIPTn+AkHQmkEUVfuGtJECD7Z5EqCUjxzsOGFnXjRGZ8bZ0MP3+xV2ibJk6668GIFLx/pMb6BToG3Gtpat8WIhH5ng4gUHXoSm/Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434904; c=relaxed/simple;
	bh=nyF2vOsXxB4vbdjfJf9HiOfpFFrAc5XBX8bxWrx+bGc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhCQHJyR6HaTLGObdB9d3bmSaFyNnTkThdW1vEsBrIHSmxuELv1FSezhlQZcwvVXkKF/fthYZQeMAwpNvz4j2WVYeGuFa22G/prnUi/P1TU4sCHfmyeiQMfV1er2sCRo93l8fCcnAwreDRoJnjuToIJIKMjFPCRCSbziJWtjMSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=0sJYxCis; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0YMMt6+q; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pFiHrJS3; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rjWJtHFj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0sJYxCis";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0YMMt6+q";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pFiHrJS3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rjWJtHFj"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E880B75A1D;
	Tue,  7 Jul 2026 14:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783434901; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NSW0XXzcO8qWdFbKcYxKPrsCCSuZezRHN2R8pHXp+Hc=;
	b=0sJYxCisd+QGzcmbynYzVIH9QDSypDTlczoLv8e6HfkvUhPjhwxcE0giV6WHAgD/01PWcE
	mG1aot+mOL0ltPu3i79cA0SeG5QJZH9YEe86gAyojQtAcqdWm3OTLcIEAP2GnpTKN9l4Kj
	1v8aexAM8mqhgpBd5XWV1dcst9TNTFA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783434901;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NSW0XXzcO8qWdFbKcYxKPrsCCSuZezRHN2R8pHXp+Hc=;
	b=0YMMt6+q0roI62YaJkFhIKcd/5sR1lB4f63W4LkxB1l4C4GWAr4avfeGhBdUDrzEMkPHTP
	QBy+CvWj/ZIoPdBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783434900; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NSW0XXzcO8qWdFbKcYxKPrsCCSuZezRHN2R8pHXp+Hc=;
	b=pFiHrJS3/x1MiogWNjVG/0lpNaodhqfYBQ8yTddlr7y46Wy6oLAyjxBD9eZl6O407byz60
	P4uLRUrYmXy6/VDrL17/3ue2Xap2UJvnrq1xyeeyC9ecgd0eryMecO7HynErViW0xSP44s
	BzYV99g+Cb1TsXSAUsCfv9aivphujt4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783434900;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NSW0XXzcO8qWdFbKcYxKPrsCCSuZezRHN2R8pHXp+Hc=;
	b=rjWJtHFjiNbTlUVGQRVIlnI+Vm3O6GfV/iBXzoEl8CCu2gv8rSpE8ET8sN5JnCs8XrsIXZ
	A8RXHcxxuWIVqiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C4426779AE;
	Tue,  7 Jul 2026 14:35:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id okBDL5QOTWpVcAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 07 Jul 2026 14:35:00 +0000
Date: Tue, 07 Jul 2026 16:35:00 +0200
Message-ID: <87y0fm6f6z.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Evgenii Burenchev <evg28bur@yandex.ru>
Cc: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	perex@perex.cz,
	tiwai@suse.com,
	u.kleine-koenig@baylibre.com,
	kees@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH] ALSA: via82xx: Remove unreachable branch in  snd_via686_pcm_pointer()
In-Reply-To: <20260706131638.15311-1-evg28bur@yandex.ru>
References: <20260706131638.15311-1-evg28bur@yandex.ru>
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
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[yandex.ru];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[yandex.ru];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxtesting.org:url,suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Mon, 06 Jul 2026 15:16:34 +0200,
Evgenii Burenchev wrote:
> 
> The condition
> 
> 	if (count && size < count)
> 
> can never evaluate to true.
> 
> The VIA DMA count register is masked with 0x00ffffff before use, while
> the DMA buffer size is limited to 0x00fffffe bytes. As a result, 'count'
> can never exceed 'size', making the condition permanently false.
> 
> This branch has therefore been unreachable since the driver was
> introduced. Remove the unreachable branch without changing runtime
> behavior.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Evgenii Burenchev <evg28bur@yandex.ru>

Applied now.  Thanks.


Takashi
