Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3CC344052;
	Sun, 13 Sep 2026 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789283072; cv=none; b=KDgGIl5ppZmhvf5h6+2/ZnMVYsf8+WWwjJUYbVhA/UIK3Xjpf+1fuRXtbhWqmyILXsGS/pgp2vitY3rSHlidstT26zcXH/VGQi1WCXQU+Myaa8MpwfJ8nMxH/An8YCv0o8j/eY/ckvplUSRisNQa//M21itooQgDoRqkicPN0a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789283072; c=relaxed/simple;
	bh=I4vV30Zpm7PauTZC5lFaXzIa8btLq4CYX5a2vWjYN20=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UfWc6hc29cEBSvaYzwehinHy3juXAxR+xj/Bod/xiyKTjclsvMWkO6ljk1XKbrJr2NZePl5/KD4frgsaV5yywkVRuPRpUjSzBC3u2IcSFRogkxmIjYS47SwpJXBLN2H3csxbZj01cvmsKP/aL44e12d4W0mabFbgnCFSRhl0Vz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=rvfa8quf; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=1fn6akyY; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TJ+Aff86; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Bbbm2T+t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="rvfa8quf";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1fn6akyY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TJ+Aff86";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Bbbm2T+t"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E5BB421D99;
	Sun, 13 Sep 2026 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789283065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aRiFTAndlUGuh+OTZkbMYfDScOYvMLrE1x0o093ABfo=;
	b=rvfa8qufY42YlK8BQ3h1DVIJRIR0R2eOLSh0MtGwlNIhcmP/wntvTl6LNNrTPZGUyiiYhv
	bX1cpjpcenG0WzO1zANoCXlieg7bMGS50u3arP+O6KvUncej6ibFbACq9ZOVZXz0aB0Hba
	H9fABEt7Ewo6u9K11TAoiQbZFfWnSgM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789283065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aRiFTAndlUGuh+OTZkbMYfDScOYvMLrE1x0o093ABfo=;
	b=1fn6akyYr304hUxkOXUKmDmG66kza6tMa0Mi42wVxrsgleowYMUIKTp7HtkIxiH2HS+B06
	cxXqq+SbA4UFwwBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TJ+Aff86;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Bbbm2T+t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789283060; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aRiFTAndlUGuh+OTZkbMYfDScOYvMLrE1x0o093ABfo=;
	b=TJ+Aff86ykIpc5uE1sj6tjw9ng0BcNbOTuWQ0stgANIBSA4dAmn7n2XpkNMdWTihhKFmWb
	4OZC7MKIjSPeS2vJHLjd4ouhCRpjhlHQv+h6dtN0E/CxHcBJNa+01klSWPeWVhv20RJsgd
	0H3FSJ4IxhW2TKXQCewCLa+ZEZ0uEvA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789283060;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=aRiFTAndlUGuh+OTZkbMYfDScOYvMLrE1x0o093ABfo=;
	b=Bbbm2T+tIKQRbroI/hkI//D9MzuugGiHa5mT3qWu1bR0f8sq1jHQvYhsRUVhxexlN7uSr4
	k0ToZKlQtqSFr5Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 679BF1368C;
	Sun, 13 Sep 2026 07:04:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id g0NsF/RKpmpGNwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 13 Sep 2026 07:04:20 +0000
Date: Sun, 13 Sep 2026 09:04:19 +0200
Message-ID: <87mrtlws24.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Xiang Mei <xmei5@asu.edu>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+8eacd4fa193b1b28@bugs.sh,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Clamp implicit feedback packet count to URB capacity
In-Reply-To: <20260912200530.1955491-1-xmei5@asu.edu>
References: <20260912200530.1955491-1-xmei5@asu.edu>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E5BB421D99
X-Spamd-Result: default: False [-2.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[8eacd4fa193b1b28];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -2.01

On Sat, 12 Sep 2026 22:05:30 +0200,
Xiang Mei wrote:
> 
> data_ep_set_params() allocates each data URB for exactly u->packets
> isochronous frames, so urb->iso_frame_desc[] has u->packets slots and
> ctx->packets is the driver's only record of that limit. For an implicit
> feedback sink, snd_usb_queue_pending_output_urbs() overwrites it with the
> sync source's packet count, which is calculated independently from the
> capture endpoint's parameters. When that count is larger,
> prepare_playback_urb() and prepare_silent_urb() can write
> iso_frame_desc[] past the allocation; their existing bounds limit payload
> bytes, not the descriptor index.
> 
> The reproducer uses a high-speed UAC2 device declaring bInterval 1 for
> implicit feedback capture (8 packets) and bInterval 4 for playback
> (1 packet). On the first capture completion after the stream starts, it
> accesses seven descriptors spanning 112 bytes beyond the one-packet URB:
> 
>   BUG: KASAN: slab-out-of-bounds in prepare_playback_urb (sound/usb/pcm.c:1560)
>   Write of size 4 at addr ffff88801e696ad0 by task vhci_rx/178
>    prepare_playback_urb (sound/usb/pcm.c:1560)
>    prepare_outbound_urb (sound/usb/endpoint.c:340)
>    snd_usb_queue_pending_output_urbs (sound/usb/endpoint.c:501)
>    snd_complete_urb (sound/usb/endpoint.c:1834)
>    __usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1657)
>    usb_hcd_giveback_urb (drivers/usb/core/hcd.c:1741)
>    vhci_rx_loop (drivers/usb/usbip/vhci_rx.c:107)
>    kthread (kernel/kthread.c:436)
>   The buggy address belongs to the object at ffff88801e696a00
>    which belongs to the cache kmalloc-256 of size 256
>   The buggy address is located 0 bytes to the right of
>    allocated 208-byte region [ffff88801e696a00, ffff88801e696ad0)
> 
> Record the allocated packet count per endpoint and clamp both the adopted
> count and the packet-size copy to it. Fold the Format Type II delimiter
> into urb_packs before the allocation loop so the recorded limit matches
> every URB.
> 
> Fixes: cf044e441902 ("ALSA: usb-audio: Update the number of packets properly at receiving")
> Reported-by: co+8eacd4fa193b1b28@bugs.sh
> Closes: https://lore.kernel.org/all/22xPn8drvIUtYgVeQnBiNqXuevOTpBAjepLz%40bugs.sh/
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Xiang Mei <xmei5@asu.edu>

Applied now.  Thanks.


Takashi
