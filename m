Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800764;
	b=0d30+hNbkVtKnpA5BpL3fQBL0lhsjIvpG2JnfC54CMbWQvZs0tTsAQVgJpzRYgIxKUo+
	 56NEzZH0VQjtPcC+b0bGOTnVYj+FF+xaDqqPX5o0O4ch5VNbBFShsI2Sojcm5tbmugzrR
	 W9yQJwZI0k3f90dTmpFMuht9NP4FqWJ62Ks80QEhf5aU/4l76edWvAaKE7IvccF9HZ7Qb
	 WlWkSDaqlkmGONbt6v5N+HenRWl5UHzcTAIknJVEg1LR1fSWQyuSqs9B78bqvWy9VrK7k
	 Gw2E437tRHz7BfvnuimmT+eegWgJqPJbJ0m4jEcWcA7UFn0Pu+AwDhvL7PmmeDLirQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800764;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=vqQBVV+JWftHY0f3XmU1p1clDKBJI0+9NyfmFolxJq0=;
	b=3zuAdJ6SWwIVyhniuo1lMbhFyiKwlPMT9A/xADoiMSeRzk58Zc75ORi5TfQa+fyIXyRW
	 oSidiwmqBy1fArsAHeoRA3bwfIjW439zkaLGslhhunsuNO7DRX3QYDAxQkIfomHE+92mH
	 1Kkgf8AKihwk0ut6iQ9OjdB2YJkq/bdIz0oSW1/6wPQDBIu0yPs/2JFGlWdY0ie6hU6fj
	 CiwCwzjnYQEKGOA7G4v3+b61skoYsX7ZZxN11m65K/juHbDE/rZs2f/H0mtvRiG4mYSfb
	 Vh1H2FICXWrCcg+3FR/MVR4afCwzW+frwBrqmo23MvNK2jbqNRKCmYS757ort07EjFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qTAfTQhC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OuB48qTL;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qTAfTQhC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OuB48qTL;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F299C606A31C;
	Fri, 27 Nov 2026 17:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F299C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qTAfTQhC;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OuB48qTL;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qTAfTQhC;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=OuB48qTL
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2F8B51F7F2;
	Fri, 27 Nov 2026 17:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795800762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vqQBVV+JWftHY0f3XmU1p1clDKBJI0+9NyfmFolxJq0=;
	b=qTAfTQhCMYlBcr1+N70tWCbDSVuw32Pk9e6L0g8HWwjwjeS5wvWXn6gjKJPvEzmOE7v6K5
	foe+TmHJ5Xc8nd+UO/8wNsQU7hAPGNPvyjntNcj98m6qZgCE7crh6eZSGXP7C23zAALqXw
	7jNjFbQ+6b0X3UfPh410jSKN5FPA+eM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795800762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vqQBVV+JWftHY0f3XmU1p1clDKBJI0+9NyfmFolxJq0=;
	b=OuB48qTLhxn8Q8YnjFbNkMq72DHVXaNqZ80gdfBugRN6bAdFeOfmnH1+SZwZkjdQBAdlRd
	btBBsmgntO7C+gDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795800762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vqQBVV+JWftHY0f3XmU1p1clDKBJI0+9NyfmFolxJq0=;
	b=qTAfTQhCMYlBcr1+N70tWCbDSVuw32Pk9e6L0g8HWwjwjeS5wvWXn6gjKJPvEzmOE7v6K5
	foe+TmHJ5Xc8nd+UO/8wNsQU7hAPGNPvyjntNcj98m6qZgCE7crh6eZSGXP7C23zAALqXw
	7jNjFbQ+6b0X3UfPh410jSKN5FPA+eM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795800762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vqQBVV+JWftHY0f3XmU1p1clDKBJI0+9NyfmFolxJq0=;
	b=OuB48qTLhxn8Q8YnjFbNkMq72DHVXaNqZ80gdfBugRN6bAdFeOfmnH1+SZwZkjdQBAdlRd
	btBBsmgntO7C+gDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CF254134E8;
	Fri, 27 Nov 2026 17:32:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WPgqKbm+CWv6EAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 27 Nov 2026 17:32:41 +0000
Date: Fri, 27 Nov 2026 18:32:41 +0100
Message-ID: <87fqwmmb7q.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Zhang Heng <zhangheng@kylinos.cn>
Cc: tiwai@suse.de,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	helamonster@gmail.com,
	regressions@lists.linux.dev
Subject: Re: [PATCH] ALSA: hda/realtek: Fix mute LEDs on ThinkPad X1 Carbon 6th
In-Reply-To: <20261126100731.903504-1-zhangheng@kylinos.cn>
References: <20261126100731.903504-1-zhangheng@kylinos.cn>
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
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,perex.cz,vger.kernel.org,gmail.com,lists.linux.dev];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30

On Thu, 26 Nov 2026 11:07:31 +0100,
Zhang Heng wrote:
> 
> ALC285_LENOVO_DAC_RENAME is not chained to ALC269_FIXUP_THINKPAD_ACPI,
> so the vendor fallback that registers the mute LEDs is skipped.  Chain
> it to restore the LEDs.
> 
> Fixes: 108704eecab9 ("ALSA: hda/realtek: Rename Line Out control to Headphone on ThinkPad X1 Carbon 6th")
> Cc: <stable@vger.kernel.org>
> Reported-by: Jeremy Bryan Smith <helamonster@gmail.com>
> Closes: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2174970
> Signed-off-by: Zhang Heng <zhangheng@kylinos.cn>

Applied now.  Thanks.


Takashi
