Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794307621;
	b=F1c7uANFpR+38uhZBbEeskPmN7d/9MciWPnEVzEWTWyqjZQp0i2nZk52A9a62mzM5hUT
	 YfiZHt2yl0raYlgxcRDLDTk6cBbd5FSlXjR5biE62lDcnCqPKYEgJYM4DKWAXCnSfG0No
	 NGi2d4+PU/YAqw6F/2XIwg76BARARv5TnV+GCwpLWgFSx/gsp7Y3kz3C6x5+8eYmv11b+
	 an5gdBsdcxea3R81+3QUngvcx7Q00QJWU7P8+AWabXAEtfkfMJW5rVa39uBkzxuO4S1LB
	 UKxNZurtKNMUq+yCC/1lNl9oFTOEw8JyFH9ihLNaL7BhtPTdZFPJiJbaISgb1AAD9/g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794307621;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=MSPjE4oJK7jPMBxZ/pc6sqhbNdIZ/+v3ZdJ+xAaTcgU=;
	b=ownIE3885Xsjqbrlb4w8en7giwXmVxrHWRmyxh9+Tt7SeoO54Q7n1KvB9683SfiPlo1O
	 OZHGjhrZbV3iDs1lgbC+c7cB9Ae7P6+wcCJoR1vx2OcYJaNxczcp259pkCmDyA27hEDcB
	 SRS0mtPqJobyOJCZSl9qHhTjjVZgS/W6WOJHN6PIZ/C+bmtghJPMhikAqWCrNBNc+zbaG
	 Ya/ou4O+0WM67gTMNiwTVfA13YiUQ7y52ZtfSDfiawz3QLI61FQqr3xq0CMG2iT06V5QA
	 uOgrSP7d4J2AePzOQmUEIHkpVbTNLTOyo+9+VZ13c3dh9Am3GzgDFx48H8y6V+MVvmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="X0ij2Qw/";
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=r9BL9VuQ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b="X0ij2Qw/";
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=r9BL9VuQ;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB37606A321;
	Tue, 10 Nov 2026 10:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CB37606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=X0ij2Qw/;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=r9BL9VuQ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=X0ij2Qw/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=r9BL9VuQ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 644F91F7A9;
	Tue, 10 Nov 2026 10:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794307618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MSPjE4oJK7jPMBxZ/pc6sqhbNdIZ/+v3ZdJ+xAaTcgU=;
	b=X0ij2Qw/m7qqpGFRb2tzzgBHloTktQIyNBhdcRaYCYj4+lkFU9l6xdWvY4hGZz1A1NxhVP
	h54VjR3/7L0jqARwwblFJJWYaYcKSXzeEoxmqK0U5XJSeWB0gYWGgrF7yqunK8T5XLIkB6
	2dHaSQG3l/EG0YUkZMcED0ogT6Xfciw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794307618;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MSPjE4oJK7jPMBxZ/pc6sqhbNdIZ/+v3ZdJ+xAaTcgU=;
	b=r9BL9VuQfAoGsZqwWR79hWnP2fi/roaEnIKltaPd1glLQDac+IpjIR/Bchsma/LIKFrpJs
	yTxR80wIfMEBc2Dw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794307618; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MSPjE4oJK7jPMBxZ/pc6sqhbNdIZ/+v3ZdJ+xAaTcgU=;
	b=X0ij2Qw/m7qqpGFRb2tzzgBHloTktQIyNBhdcRaYCYj4+lkFU9l6xdWvY4hGZz1A1NxhVP
	h54VjR3/7L0jqARwwblFJJWYaYcKSXzeEoxmqK0U5XJSeWB0gYWGgrF7yqunK8T5XLIkB6
	2dHaSQG3l/EG0YUkZMcED0ogT6Xfciw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794307618;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MSPjE4oJK7jPMBxZ/pc6sqhbNdIZ/+v3ZdJ+xAaTcgU=;
	b=r9BL9VuQfAoGsZqwWR79hWnP2fi/roaEnIKltaPd1glLQDac+IpjIR/Bchsma/LIKFrpJs
	yTxR80wIfMEBc2Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 26CB21339F;
	Tue, 10 Nov 2026 10:46:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id eJSwACL28mpTPgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 10 Nov 2026 10:46:58 +0000
Date: Tue, 10 Nov 2026 11:46:53 +0100
Message-ID: <87se19ufoi.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Gichoon Han <gichoon.han@samsung.com>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Sinan Turunc <enscrpt@pm.me>,
	Edward Adam Davis <eadavis@qq.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: Drop capture packets with bogus actual_length
In-Reply-To: <20261110060021.2146383-1-gichoon.han@samsung.com>
References: <CGME20261110060032epcas1p1a4de057d86d384387d0b8004d63ef331@epcas1p1.samsung.com>
	<20261110060021.2146383-1-gichoon.han@samsung.com>
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
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[qq.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,perex.cz,pm.me,qq.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samsung.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30
X-Spam-Level: 
X-Spam-Flag: NO

On Tue, 10 Nov 2026 07:00:21 +0100,
Gichoon Han wrote:
> 
> retire_capture_urb() copies urb->iso_frame_desc[i].actual_length bytes
> out of urb->transfer_buffer at the packet's offset, but never checks
> that value against the requested packet length.  A host controller
> reporting more data than requested makes memcpy() read past the end
> of the URB transfer buffer.
> 
> Commit 06be918062ad ("ALSA: usb-audio: Bound packet copies by the PCM
> buffer size") clamps the count to the PCM ring buffer size, which
> protects the destination.  The source slot is only ep->curpacksize
> bytes per packet, though, so the over-read remains.
> 
> This was hit on an ARM32 system (vendor 5.4 kernel; the code path is
> unchanged in mainline) with a full-speed UAC1 microphone behind a
> high-speed hub, i.e. the EHCI siTD path.  sitd_complete() computes
> actual_length as desc->length - SITD_LENGTH(t); the controller
> reported a remaining length larger than the programmed one, the value
> wrapped to ~4G, and the capture copy faulted on the first unmapped
> page after the URB buffer:
> 
>   Unable to handle kernel paging request at virtual address e8756000
>   Internal error: Oops: 7 [#1] PREEMPT SMP ARM
>   r3 : 00000000  r2 : 0001e700  r1 : e8756000  r0 : e878fc80
>   Code: ba000002 f5d1f03c f5d1f05c f5d1f07c (e8b151f8)
> 
> A packet can never legitimately carry more than its requested length,
> so warn and skip it instead of copying.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gichoon Han <gichoon.han@samsung.com>
> ---
> Compile-tested only on linux-next.  The crash was observed in the
> field on a vendor 5.4-based ARM32 kernel with the same code path;
> I don't have a setup to reproduce the bogus siTD length on mainline.

I think the bug is rather in the USB contorller code, but it's still
safer to have a sanity check.  So I applied now.


thanks,

Takashi
