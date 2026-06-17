Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B2C3806AF
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781687069; cv=none; b=YqpkW1YlWAWGWFUZxjwRe/O+zZ71gOKhac1hG88yh7PctalmV5VhO55SYSsHF3kO8/A3TVGVnglLq7DZV65bX48xqI0DspekRo+VoDkvy9/dfvIdtRZEwVHU+OBZ1wlTYZhGMr2pobxlBjpxuBkbIcIxOgyGWK/mOuJ6g6tE9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781687069; c=relaxed/simple;
	bh=ItUbzzt+2J6sk7nN6qCs300NOEW3cp2msdiIHZajPf8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JIWIMcnZpU5wpEubbksW2sbNXXuAoDNiL6NEwXOuQbI2nJXKM8UrE+3q2VKjpgYymv0mOe1XKND4hpwgR4QJvs09ayKOimXDbqct08WpNygTM1usab5QzKzr6/sJq+u4rCwsB63/WcIF1UQ+54OV2XmZ7Meu1UoyVE/wSiIao7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jGHWygLh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IkqGSofQ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jGHWygLh; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=IkqGSofQ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jGHWygLh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IkqGSofQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jGHWygLh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="IkqGSofQ"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 71C7A6BB25;
	Wed, 17 Jun 2026 09:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781687066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7Y+nENY+4YWMxfbaD1QaIXybWiY4op0OJ3ee54iRWg=;
	b=jGHWygLhQE+Jpr+wrHHrTiY5QkX1L/MprWgGZvJ/+jSOEbisdAqYw7maE9yE/WMMF8lkjn
	81h5fhv+VK+QkaOq11CeY25TxM8VHyIcGrwhNzvj1rfBtbrgwNzVUWnx3eyB0Ohync3EQK
	7XI29u4oAJDAln8ODBQS5NJ0UEB/VtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781687066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7Y+nENY+4YWMxfbaD1QaIXybWiY4op0OJ3ee54iRWg=;
	b=IkqGSofQJ1VusheD8Re0e81YF3E7wiDTqTm1C1wkwLW3kE8Eg4iGHAC6tHPGEYPpra65sq
	YXCBKRN2TusXiqCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781687066; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7Y+nENY+4YWMxfbaD1QaIXybWiY4op0OJ3ee54iRWg=;
	b=jGHWygLhQE+Jpr+wrHHrTiY5QkX1L/MprWgGZvJ/+jSOEbisdAqYw7maE9yE/WMMF8lkjn
	81h5fhv+VK+QkaOq11CeY25TxM8VHyIcGrwhNzvj1rfBtbrgwNzVUWnx3eyB0Ohync3EQK
	7XI29u4oAJDAln8ODBQS5NJ0UEB/VtU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781687066;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7Y+nENY+4YWMxfbaD1QaIXybWiY4op0OJ3ee54iRWg=;
	b=IkqGSofQJ1VusheD8Re0e81YF3E7wiDTqTm1C1wkwLW3kE8Eg4iGHAC6tHPGEYPpra65sq
	YXCBKRN2TusXiqCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 301B4779A8;
	Wed, 17 Jun 2026 09:04:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ehZsChpjMmoIUQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 17 Jun 2026 09:04:26 +0000
Date: Wed, 17 Jun 2026 11:04:25 +0200
Message-ID: <87se6lpmg6.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: =?ISO-8859-1?Q?C=E1ssio?= Gabriel <cassiogabrielcontato@gmail.com>
Cc: Vinod Koul <vkoul@kernel.org>,	Takashi Iwai <tiwai@suse.com>,	Jaroslav
 Kysela <perex@perex.cz>,	Amadeusz =?ISO-8859-2?Q?S=B3awi=F1ski?=
 <amadeuszx.slawinski@linux.intel.com>,	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,	notify@kernel.org,	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: compress: Fix task creation error unwind
In-Reply-To: <20260615-alsa-compress-task-unwind-v1-1-39e8ad3ddb27@gmail.com>
References: <20260615-alsa-compress-task-unwind-v1-1-39e8ad3ddb27@gmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.998];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Score: -3.30

On Mon, 15 Jun 2026 15:37:26 +0200,
Cássio Gabriel wrote:
> 
> snd_compr_task_new() allocates the driver task before validating the
> returned DMA buffers and reserving file descriptors. When either of
> those later steps fails, the core frees its task wrapper and DMA-buffer
> references without calling the driver's task_free() callback. Any
> driver resources allocated by task_create() are therefore leaked.
> 
> The dual-fd allocation path also jumps to cleanup without storing the
> negative get_unused_fd_flags() result in retval. Since retval still
> contains the successful task_create() return value, TASK_CREATE can
> incorrectly report success although the task was discarded.
> 
> Preserve the fd allocation errors and call task_free() when failure
> occurs after a successful task_create() callback.
> 
> Fixes: 04177158cf98 ("ALSA: compress_offload: introduce accel operation mode")
> Fixes: 3d3f43fab4cf ("ALSA: compress_offload: improve file descriptors installation for dma-buf")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cássio Gabriel <cassiogabrielcontato@gmail.com>

Applied now.  Thanks.


Takashi
