Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D14D48EBCE;
	Mon, 19 Oct 2026 08:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792399241; cv=none; b=ije9LY11PoccUdY0gDm9HGeuMW/XlDZu4254JP7EZLyz3usgozk9GDGzXGdX6qTmK0vWKorLy4tZW2A+T9guyKNNt/hM2i8GNmnb89Asd6pE2rAKMjg2/3KnT3rZ00JCeaR5mGV1L9ZykkGIhP6htRw9ATcOG3tOWyCtVDj+xTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792399241; c=relaxed/simple;
	bh=cvguI0dGhyZ7wZVbcK2YPEB6e6V77xtzhyrcJMBpfpw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jB64l14an2DIPzkVn8BqFDHCoivJmwZo1jr+yXTm6CHxYoJYkm954fH+yT3BpC37XSJx7owOoU3a+hM4cpGOWqIGoUDVVij9ja7ZAYrgrctqtwXLpYHamltrOQvOLttmpPKuqQ4Cs/WRAAfaD6qAlRSgK7Z1+ZQVJNiExzuqR5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ksOtj3UU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wdlUFNqT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ksOtj3UU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wdlUFNqT; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ksOtj3UU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wdlUFNqT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ksOtj3UU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wdlUFNqT"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 408DE1F44E;
	Mon, 19 Oct 2026 08:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792399238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZuiiBpi2VuY9llFBHnZO7t2s4pwHpxK4rEw9KENlAQ=;
	b=ksOtj3UU9mMcEJTY67A567ogZ7fD7vggZWve2yiAZJp2aKwnysLDu5D5gkAKwNE7cdQUDd
	U/EX/3vcECuYuN9zd8hp9mdHJGwSUY1TofKcH+10K5YdDxx90tCkqjPMuKIdPWcKQvEVCk
	eAqm1Dw96e0EqHXOupd4m175Nn+0x3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792399238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZuiiBpi2VuY9llFBHnZO7t2s4pwHpxK4rEw9KENlAQ=;
	b=wdlUFNqTjYwrClEwWOT2ejugsar3C7V26faQjn4vGfqwnDY5qWBzMjiwV3KAOjOAFIgVbh
	fq6vePcPrY+WenDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ksOtj3UU;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wdlUFNqT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1792399238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZuiiBpi2VuY9llFBHnZO7t2s4pwHpxK4rEw9KENlAQ=;
	b=ksOtj3UU9mMcEJTY67A567ogZ7fD7vggZWve2yiAZJp2aKwnysLDu5D5gkAKwNE7cdQUDd
	U/EX/3vcECuYuN9zd8hp9mdHJGwSUY1TofKcH+10K5YdDxx90tCkqjPMuKIdPWcKQvEVCk
	eAqm1Dw96e0EqHXOupd4m175Nn+0x3s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1792399238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZuiiBpi2VuY9llFBHnZO7t2s4pwHpxK4rEw9KENlAQ=;
	b=wdlUFNqTjYwrClEwWOT2ejugsar3C7V26faQjn4vGfqwnDY5qWBzMjiwV3KAOjOAFIgVbh
	fq6vePcPrY+WenDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3CF9136CC;
	Mon, 19 Oct 2026 08:40:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u6JyLoXX1WpWbgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 19 Oct 2026 08:40:37 +0000
Date: Mon, 19 Oct 2026 10:40:37 +0200
Message-ID: <87ik2yaxru.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Thomas Nemer <thomas.nemer@fortytwo.fr>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Abhinav Mahadevan <abhi220204@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Fix missing sample-rate control for PreSonus AudioBox USB
In-Reply-To: <20261018111519.191844-1-thomas.nemer@fortytwo.fr>
References: <20261018111519.191844-1-thomas.nemer@fortytwo.fr>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 408DE1F44E
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -3.51

On Sun, 18 Oct 2026 13:15:19 +0200,
Thomas Nemer wrote:
> 
> The fixed audio formats for the PreSonus AudioBox USB declare
> .attributes = 0, dropping UAC_EP_CS_ATTR_SAMPLE_RATE that the device
> advertises in its class-specific endpoint descriptors (EP_GENERAL
> bmAttributes 0x01 on both EP 0x01 and EP 0x82).
> 
> As a result set_sample_rate_v1() bails out and the kernel never sends
> the UAC1 SET_CUR SAMPLING_FREQ request, leaving the device on its
> power-on default clock. Playback and capture then run distorted
> whenever the stream rate differs from that default. The device keeps
> the last rate set by a host as long as it stays powered, which made the
> regression look intermittent (e.g. it disappears after the device was
> initialized by a host running a kernel without this quirk entry).
> 
> Restore the sample-rate attribute on both streams.
> 
> Fixes: 34fe4a9df247 ("ALSA: usb-audio: Add quirk for PreSonus AudioBox USB")
> Cc: stable@vger.kernel.org
> Signed-off-by: Thomas Nemer <thomas.nemer@fortytwo.fr>

Applied now.  Thanks.


Takashi
