Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C71321F2D
	for <stable@vger.kernel.org>; Sun, 26 Jul 2026 07:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785049578; cv=none; b=SYGy1TBZLAFRfuAGWgguqSuUtWuRbfjOcBnUXhlgc97lWNBUm1PyQCiHaqg8urht9oiQjk6BkLykKa4ZkJKMAzBCxNQTiRrLOtQGdhH69vOw3LK4jo9eOZ9t0dubAQiZKuohctT+r9xWtdO/v44kvWRKqdOWxYyBXm9iJplNOSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785049578; c=relaxed/simple;
	bh=WXN1Ot3ReDVdrF2qj5vCKhMERtDBCSyBNWZ1M2+KyEA=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhSr8Il8PvI5pkSErxiLdDjoKCCjjT590cL6T+l6YhLDdxOJIRH1geupPozy+tfOiN6/QdKaBGKd/js9yCV6+5/ZFm4vZHAiZOh+TxUILgx5Ws4oX8+H086qGT/ouA7uNkZ5GBmXT+X1p4cZfrI0iBD2mzgNRzQ6D5+aC+eFMlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kzd7/hWN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=idSfu8vc; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Kzd7/hWN; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=idSfu8vc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kzd7/hWN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="idSfu8vc";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Kzd7/hWN";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="idSfu8vc"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B33307D473;
	Sun, 26 Jul 2026 07:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785049575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BQnAqtOTrZXH/7IOpdC5OV9/H4V2Z1K4ZhRr3v94vkg=;
	b=Kzd7/hWNJh6NKgHyW3htcN5oJWpiQXsYqW075oN34lCc4jPbxNV2WtoQhev1VAB428cibx
	lrkRnrYY170G8MPiT2o4mhnbVEepM5192OjeHhLWEab47mihf85mn2ksE/kWMw6jKgohTT
	fl7BiSqsVRSIbCW+PGn9CkrDdYxSsdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785049575;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BQnAqtOTrZXH/7IOpdC5OV9/H4V2Z1K4ZhRr3v94vkg=;
	b=idSfu8vc8EYxd9O6Pis4fK2SEbWmrzcN8hNXVO3InqFks7zSP+mQahVQrPx2+Z1XngNO4q
	kY1yEbt6bXHRENAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785049575; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BQnAqtOTrZXH/7IOpdC5OV9/H4V2Z1K4ZhRr3v94vkg=;
	b=Kzd7/hWNJh6NKgHyW3htcN5oJWpiQXsYqW075oN34lCc4jPbxNV2WtoQhev1VAB428cibx
	lrkRnrYY170G8MPiT2o4mhnbVEepM5192OjeHhLWEab47mihf85mn2ksE/kWMw6jKgohTT
	fl7BiSqsVRSIbCW+PGn9CkrDdYxSsdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785049575;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BQnAqtOTrZXH/7IOpdC5OV9/H4V2Z1K4ZhRr3v94vkg=;
	b=idSfu8vc8EYxd9O6Pis4fK2SEbWmrzcN8hNXVO3InqFks7zSP+mQahVQrPx2+Z1XngNO4q
	kY1yEbt6bXHRENAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E411779B9;
	Sun, 26 Jul 2026 07:06:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Ivb0GOexZWqPAgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 26 Jul 2026 07:06:15 +0000
Date: Sun, 26 Jul 2026 09:06:15 +0200
Message-ID: <878q6yb57c.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Baul Lee <baul.lee@xbow.com>
Cc: linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	lina+kernel@asahilina.net,
	federico.kirschbaum@xbow.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: fix stack info leak in RME Digiface status
In-Reply-To: <20260726065020.46070-1-baul.lee@xbow.com>
References: <20260726065020.46070-1-baul.lee@xbow.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -1.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[kernel];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[xbow.com:email,suse.de:mid]

On Sun, 26 Jul 2026 08:50:20 +0200,
Baul Lee wrote:
> 
> snd_rme_digiface_read_status() reads a four-word status block from the
> device into an uninitialised on-stack __le32 buf[4] and, whenever the
> vendor control-IN transfer does not return a negative error, copies all
> four words into the caller's status[].
> 
> snd_usb_ctl_msg() copies the full requested size back into the caller's
> buffer regardless of how many bytes the data stage actually delivered:
> 
> 	buf = kmemdup(data, size, GFP_KERNEL);
> 	err = usb_control_msg(dev, pipe, request, requesttype,
> 			      value, index, buf, size, timeout);
> 	memcpy(data, buf, size);
> 
> usb_control_msg() returns the transferred length on a short control-IN,
> which is a non-negative value, and writes only that many bytes.  The
> remainder of the copy back is the kmemdup()ed image of the caller's
> buffer, so a device answering with a short data stage leaves the
> trailing words of buf[] holding leftover kernel stack.  The only guard
> in the caller is err < 0, so those words are stored into status[].
> 
> They then reach user space: snd_rme_digiface_get_status_val() selects a
> 16-bit halfword of status[] per the control's reg/mask, and the eight
> Digiface status controls together expose the whole 16-byte frame to an
> unprivileged reader of /dev/snd/controlC*.
> 
> Zero-initialise the buffer so a short read yields zeros instead of stack
> residue.  This mirrors snd_rme_get_status1(), which already clears its
> output word before the same kind of vendor read.
> 
> Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>
> 
> Fixes: 611a96f6acf2 ("ALSA: usb-audio: Add mixer quirk for RME Digiface USB")
> Reported-by: Federico Kirschbaum <federico.kirschbaum@xbow.com>
> Reported-by: Baul Lee <baul.lee@xbow.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Baul Lee <baul.lee@xbow.com>

Applied now.  Thanks.


Takashi
