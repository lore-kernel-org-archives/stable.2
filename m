Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793088690;
	b=jwCyFCi7JHrjTdZJ2Ccac1y/ZJjHjm5aMoAGE/NkJIVN1gAaZ+39BhizC8MxN/d7Yy6O
	 VqMNOtTPODkCzL9aQSHpp5rGAf1krv52SvKfbRyx7Yecu841EarIwCorlvqjer0z4JlSk
	 JGXsk1d6Vng6szM3pWbgWT9i9RifyUO0TuBhh3ureYW+94GQsIOH33QO6t8CoaxK874k4
	 fqOVSHfCEoXmz7FngmgFu9eDFSJ0UKeJrctPR3ITLydpwziGzUAA2ILehzqmHpqXmdmG1
	 yN6yET3Zdv5sYCf6etWrFRPxnzd4BXjHGiCxsGw/9omCL5uSHjer4wZPiZHBHb4RqNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793088690;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=Lxvntovk5dlj6AgEzcsIdi8T2gotaOnQMxjnJpk9hYI=;
	b=zsAIX+NLmrphfwLxkZAAQt+n4qtQBYjX9I9nsdaEA+bgEJThaanY8Yss9xOUv6GqoXdD
	 WcpwlseLtWfS1vg3jZoWINIyiXX5ipUFqtHX5HPZ+phsKfoc8ihLdvNgQ+QjVPx+VbV/i
	 w6bO4wnudkxDpzfMSACvOfVNUR0muDRF+/OnqBlabOHgm0w/WzJZ9Bn795UpXrYlO/+Ff
	 5jLfcBaLd7BAtwfM2zyqiauSH7eEbbubHp73QcAxsbIhfVGH6aD/6865FhdS0LuNIAauw
	 8m/EMZISslzI4rx6NfSJBaCJzKxEM93ficykY6Y7+FDZoqhH7dEy6Test20zRcfSmsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SPl5VY2C;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8NQitjt2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SPl5VY2C;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8NQitjt2;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F196606A31D;
	Tue, 27 Oct 2026 08:11:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F196606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SPl5VY2C;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8NQitjt2;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SPl5VY2C;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8NQitjt2
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2898021C06;
	Tue, 27 Oct 2026 08:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793088688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lxvntovk5dlj6AgEzcsIdi8T2gotaOnQMxjnJpk9hYI=;
	b=SPl5VY2ClTJXlr+NkvVGGoG7sk8ygAv3dhrjmvpdPI81Yk6RyxeEb2Iq29EfKfs5P0Mu/s
	lzPbMdNFqamPenWv7sW7qaK0urReyoJu9NdeTgGwXP2cX2HGRJs7SyShEDaPPSx8Y/TIBN
	+vVZObvrb1XQWjnxLs5aG5RFzaNnwBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793088688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lxvntovk5dlj6AgEzcsIdi8T2gotaOnQMxjnJpk9hYI=;
	b=8NQitjt2crOExI2ih/q1om2rA3RxSSfJmAFjqKRtjNfkJIOmp4MpzCcMOKrg6BkwnfKLfZ
	UjPRiOxk+zRGIiDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793088688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lxvntovk5dlj6AgEzcsIdi8T2gotaOnQMxjnJpk9hYI=;
	b=SPl5VY2ClTJXlr+NkvVGGoG7sk8ygAv3dhrjmvpdPI81Yk6RyxeEb2Iq29EfKfs5P0Mu/s
	lzPbMdNFqamPenWv7sW7qaK0urReyoJu9NdeTgGwXP2cX2HGRJs7SyShEDaPPSx8Y/TIBN
	+vVZObvrb1XQWjnxLs5aG5RFzaNnwBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793088688;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Lxvntovk5dlj6AgEzcsIdi8T2gotaOnQMxjnJpk9hYI=;
	b=8NQitjt2crOExI2ih/q1om2rA3RxSSfJmAFjqKRtjNfkJIOmp4MpzCcMOKrg6BkwnfKLfZ
	UjPRiOxk+zRGIiDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B25591321C;
	Tue, 27 Oct 2026 08:11:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id xM2OIa9c4GpsfwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 27 Oct 2026 08:11:27 +0000
Date: Tue, 27 Oct 2026 09:11:27 +0100
Message-ID: <87h5i736mo.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	pierre-louis.bossart@linux.dev,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org,
	cezary.rojewski@intel.com,
	kai.vehmanen@linux.intel.com
Subject: Re: [PATCH] ALSA: hda: Reject codec reset on ASoC (ext_ops) buses
In-Reply-To: <20261027072835.4796-1-peter.ujfalusi@linux.intel.com>
References: <20261027072835.4796-1-peter.ujfalusi@linux.intel.com>
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
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30
X-Spam-Level: 
X-Spam-Flag: NO

On Tue, 27 Oct 2026 08:28:35 +0100,
Peter Ujfalusi wrote:
> 
> Writing to the reconfig or clear sysfs nodes of a codec handled by ASoC
> (SOF via hdac_hda, AVS via codecs/hda) hangs the writer.
> 
> snd_hda_codec_reset() sets card->shutdown and calls
> device_release_driver(). With ext_ops the driver unbind unregisters the
> ASoC component, which unbinds and frees the whole ASoC card:
> - snd_card_disconnect() returns early as card->shutdown is already set,
>   so the card's child devices are not removed and snd_card_free() waits
>   for the card release forever.
> - Even without that, freeing the card removes the codec's hwdep device,
>   which owns the sysfs node the reset was issued from, deadlocking in
>   kernfs while waiting for the active write to finish.
> 
> The legacy HDA driver keeps the card across a driver rebind, ASoC does
> not, so the reset cannot be supported there. Return -EOPNOTSUPP and skip
> the misleading "codec is being used" messages in the callers.
> 
> Fixes: 6bae5ea94989 ("ASoC: hdac_hda: add asoc extension for legacy HDA codec drivers")
> Cc: stable@vger.kernel.org
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222182
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Applied now.  Thanks.


Takashi
