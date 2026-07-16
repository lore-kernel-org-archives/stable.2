Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064922D3733
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 06:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784183595; cv=none; b=i/dAX2jHw2hEmsGhKyts44jyHKnx/T6PNdIxx9YB3xIS0p96gfDvhShNjlN+LsHXZP3miFXGYXMwfYh9CzW+OBThq+Kb3kJK/aX2mbq4JfZRgocEe9z+kCbQ4EReEqThbKs0DtE8lRnNw2HHoL0J7Qc74BKM5i2BtX67H60Z+io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784183595; c=relaxed/simple;
	bh=AoCWTc3MW+swaTwkGBDulXLPXnVD3jFwnKFJQNtXxlo=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UpE407apeMxRbWctVg6m5kDfk0/1Tbpeknzs+jPPatb3Yef/7D9O09YDQyfFmz6VxU9xnak1pWBdpo5GkuD5EfO7fPlY+oOUQ/HQKLrYez/oS327dE1Tt7WStiCv02mXdm9k1Lml1z35gpyG9iVXK4P/bt1yiheJMoTBw5r7CLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SCN1W5Iu; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XhghWAN9; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=tAoPtUKD; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Lz3vlmNb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SCN1W5Iu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XhghWAN9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="tAoPtUKD";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Lz3vlmNb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id EA7A83E2F;
	Thu, 16 Jul 2026 06:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784183591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vpEbQYgMhJXLSFQOLQNHx5VArl8HE6uzLTJ6pKi36MM=;
	b=SCN1W5IudHYqoJGPDcpbnWB5TSpDzvaF840eG+PBwQyzezbxYCh9Qdy3iAhloC9Y32DJhs
	JmPsyJNYtykCrKC56XSSzi9/n030mxlhXP33+qHb5WbSG8pb3mi6yD3+bcczAkJ402pdke
	+5OPs1rVo8HhUK2cacM0YKmIr//vvWA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784183591;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vpEbQYgMhJXLSFQOLQNHx5VArl8HE6uzLTJ6pKi36MM=;
	b=XhghWAN9ICo8V7LFemQLudCZI1Vc5tURpPupl0gvpHOullpfSbGlvAEx8Aim4O3TgsZvBx
	9E6/en0G32UwIPCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784183590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vpEbQYgMhJXLSFQOLQNHx5VArl8HE6uzLTJ6pKi36MM=;
	b=tAoPtUKDD6tb8CzfEvQtuiFpj3Nz4FvSpphoDT3Pzfu+VOS9W1haJHfpHcox+eclJLGiT/
	miO+BiiC93JjObtxXnU/Ed3cffYNnCvaFhduOpauv8uZWymS0qpu/EWReX2h09gREcMtMr
	Z/U67Uye3heCrnP5fqQVegw+THAdVY0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784183590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vpEbQYgMhJXLSFQOLQNHx5VArl8HE6uzLTJ6pKi36MM=;
	b=Lz3vlmNbXbwnDtyotqLiL+isPAyoQNOPRO/RLpH6x1Ms7jXasWjRIITVMpIe/MIH5M4KTP
	lvjQqf7HW3YyWuBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A4FC6779AD;
	Thu, 16 Jul 2026 06:33:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OrlvJiZ7WGqmYwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 16 Jul 2026 06:33:10 +0000
Date: Thu, 16 Jul 2026 08:33:10 +0200
Message-ID: <874ihzwijd.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Kai Vehmanen <kai.vehmanen@linux.intel.com>
Cc: linux-sound@vger.kernel.org,
	tiwai@suse.de,
	peter.ujfalusi@linux.intel.com,
	Uma Shankar <uma.shankar@intel.com>,
	Alexander Kaplan <alexander.kaplan@sms-medipool.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: codecs: hdmi: disable keep-alive before audio format change
In-Reply-To: <20260715180610.1371243-1-kai.vehmanen@linux.intel.com>
References: <20260715180610.1371243-1-kai.vehmanen@linux.intel.com>
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
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Level: 

On Wed, 15 Jul 2026 20:06:10 +0200,
Kai Vehmanen wrote:
> 
> When a keep-alive (KAE) silent stream is active on an Intel HDMI/DP
> codec, opening a real PCM stream reprograms the converter format and the
> audio infoframe in snd_hda_hdmi_generic_pcm_prepare(). Part of that
> reprogramming - the converter channel count and the channel mapping in
> snd_hda_hdmi_setup_audio_infoframe() - is not safe to do while a
> keep-alive stream is active. This is most visible when switching to a
> multichannel PCM configuration, where the active channel count actually
> changes. In that case the newly opened PCM stream plays no sound.
> 
> Add an optional hdmi_ops .prepare hook, called at the start of the
> PCM prepare sequence (before the format and infoframe are touched), and
> implement it for HSW+ to release keep-alive. Keep-alive is then
> re-enabled as before once the new stream has been set up, in the
> setup_stream op.
> 
> Fixes: 15175a4f2bbb ("ALSA: hda/hdmi: add keep-alive support for ADL-P and DG2")
> Reported-by: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
> Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8412
> Tested-by: Alexander Kaplan <alexander.kaplan@sms-medipool.de>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Kai Vehmanen <kai.vehmanen@linux.intel.com>

Applied now.  Thanks.


Takashi
