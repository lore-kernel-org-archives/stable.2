Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C085F476696
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 16:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785859579; cv=none; b=TMuanR32wJHLL5S0Jd4nv1TYxAi4QAZuH5hD5VuzxMSqC5jwBplEyoUEUlsVv6H+zPUjD4IlEy0OXVs7kTNwD77SGH6veQgv4QwJT6YNT8YBynydOlapXYiNnyADymhCf4G4kVhCgMUbnN2++BkW+UX52itoyF5JRsozEN+ZbYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785859579; c=relaxed/simple;
	bh=NmqKaSCLNrrSr5Medjkh6eyTJ7zSLem+HseJFBvyT9M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKr7Vg+DDAPzRUo4PHcZI2sIvIrHCyAW1tlNii9CJIxzktsFLGfBqzuHYWV72f0RZPT7kZvIXcTuisIxFim6qoeugonikXEk+VShy55fz4V+oAdfwwbsK3YT2939ch14NHACzHqM2pgFqf6K+U8vQltiGVjOaSP2ky5htqdJj7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=b7AU9fUe; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=44OhwmTZ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=PiNDmRrQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=8qCGg2Pw; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="b7AU9fUe";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="44OhwmTZ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="PiNDmRrQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="8qCGg2Pw"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AF8217F8A6;
	Tue,  4 Aug 2026 16:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785859571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WrKlqfzYyjUKTNp/EILvRTuQebBEyWgZDL/MeJvXwpw=;
	b=b7AU9fUeHr7FbBszniGo0oNslSitPQ7O1jcw5UVlSGklVk8L3jgbXYJZZ0ARu+6tPXLart
	rlXehdUjSioFUwdNSB97pMIaE0aMKXAilcFIlKXZcvOxqZnYJeHrGYMhU0+3XK6Fqi9UgP
	MaMw2/UX/Eu/2pycR5y+l7NBPCRAy6I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785859571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WrKlqfzYyjUKTNp/EILvRTuQebBEyWgZDL/MeJvXwpw=;
	b=44OhwmTZFXQW40FJwfUKpAykhW1F/PFcy8/slLqbIIHVaQw6vG+jYVBS5HSpiWWksGwDn0
	0Kuir/w1SooqL7DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785859567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WrKlqfzYyjUKTNp/EILvRTuQebBEyWgZDL/MeJvXwpw=;
	b=PiNDmRrQGD2w9fnnOX5usH5v1ZtG8+9j3jEBYMlDsyOhq8FEJNFzPDNQ8U7eXgBb5NjCMJ
	wap0nw9SlKmQNAi9L5cYiuh3jQ6mbT+tnH9B/flLgE4RuMrG5KGCBZjRlqp9YSUPWt68UG
	Kbcv5wMVR2TYZYJm0luScRE1s6mCNwY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785859567;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=WrKlqfzYyjUKTNp/EILvRTuQebBEyWgZDL/MeJvXwpw=;
	b=8qCGg2PwyeZsBj/1fzcdvrTGByZ1TardU8XR8mWbY9sBvI2aqXC5Zu8fCKd3fIvy4YzsmG
	LNd9THFIqH+Q32Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73970779BE;
	Tue,  4 Aug 2026 16:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id s44SGu8NcmqWKAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 04 Aug 2026 16:06:07 +0000
Date: Tue, 04 Aug 2026 18:06:07 +0200
Message-ID: <875x1pj2fk.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baul Lee <baul.lee@xbow.com>
Cc: g@b4.vu,
	perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: FCP: fix OOB write in fcp_meter_ctl_get()
In-Reply-To: <20260804123611.91715-1-baul.lee@xbow.com>
References: <20260804123611.91715-1-baul.lee@xbow.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.28 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.18)[-0.918];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo,xbow.com:email]
X-Spam-Flag: NO
X-Spam-Score: -3.28
X-Spam-Level: 

On Tue, 04 Aug 2026 14:36:11 +0200,
Baul Lee wrote:
> 
> fcp_ioctl_set_meter_map() bounds the user-supplied Level Meter map size
> by the driver's own limit of 255
> 
> 	if (map.map_size < 1 || map.map_size > 255 ||
> 	    map.meter_slots < 1 || map.meter_slots > 255)
> 		return -EINVAL;
> 
> and passes it to fcp_add_new_ctl() as the control's channel count, where
> it is stored as elem->channels.
> 
> Every control read writes into struct snd_ctl_elem_value, whose integer
> array is declared long value[128], so the limit is 128, not 255.
> fcp_meter_ctl_get() stores one 64-bit word per channel into that array
> with no bound of its own:
> 
> 	for (i = 0; i < elem->channels; i++) {
> 		int idx = private->meter_level_map[i];
> 		int value = idx < 0 ? 0 : le32_to_cpu(resp[idx]);
> 
> 		ucontrol->value.integer.value[i] = value;
> 	}
> 
> snd_ctl_elem_read_user() serves that object from
> memdup_user(_control, sizeof(*control)), 1224 bytes on LP64 out of
> kmalloc-2048.  offsetof(struct snd_ctl_elem_value, value) is 72, so
> element i is written at byte 72 + 8 * i and element 144 already lands
> past the allocation.  At map_size 255 the last store ends at byte 2112,
> 888 bytes past the object and 64 bytes into the adjacent slab object.
> The stored words come from the device and meter_level_map[] selects
> which word lands in which slot, so extent and contents are both
> controlled.
> 
> The core does not catch this.  snd_ctl_check_elem_info() is reached only
> from __snd_ctl_elem_info(), which snd_ctl_elem_read() calls under
> CONFIG_SND_CTL_DEBUG; without that option snd_ctl_skip_validation() is a
> compile-time true.  __snd_ctl_add_replace() validates kcontrol->count and
> never inspects elem->channels.
> 
> Installing an oversized map needs CAP_SYS_RAWIO, but the control outlives
> the hwdep descriptor that created it, so the out-of-bounds stores are
> issued by any process able to read controls on /dev/snd/controlC0.
> 
> KASAN on 7.2.0-rc5 (arm64), triggered by an unprivileged control read:
> 
>   BUG: KASAN: slab-out-of-bounds in fcp_meter_ctl_get
>   Write of size 8 at addr ffff000017af04c8 by task fcp_trigger/185
>    __asan_store8
>    fcp_meter_ctl_get
>    snd_ctl_elem_read
>    snd_ctl_ioctl
>   Allocated by task 185:
>    memdup_user
>    snd_ctl_ioctl
>   The buggy address is located 0 bytes to the right of
>    allocated 1224-byte region [ffff000017af0000, ffff000017af04c8)
> 
> Bound the map size by the ABI limit rather than by 255, and bound the
> store loop at the sink so it cannot run past the value array whatever
> elem->channels holds.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: 46757a3e7d50 ("ALSA: FCP: Add Focusrite Control Protocol driver")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Applied now.  Thanks.


Takashi
