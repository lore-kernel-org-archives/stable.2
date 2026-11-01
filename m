Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793547221;
	b=pMjSmwtboPdfC3VRLClt+OIs8eXTJsKZGLaxTyvXSbag2uO4lGqRyXcRuksnp6ygr0Sz
	 73Jr/AsQEI/mOVWBp7qkfeyVcDD8KqLcZRhZ1IjT8AjRdjdW8FvZSCDt2D1bMvCgFhpHD
	 /sAjlsfVnB7NSlwNtMeqwYtfSi9M/SqhRBxw00IIDCL8VmizXvDJK4O+eTBGqJyt3mq2r
	 SQnXHRKNz+gThr4DSD8XzPiFNKc+N6SCLHN0ssiYodVit0Te0oEKxKnTvI+oXys99LW+7
	 Z9qvk11rcOU89MYz3JL39Psu3OHDcfEbz2NZBeFd/c2mTiaadqG70IKmfw83t3/ljxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793547221;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=khvlFXDXEPKyNmWKWr4Cc1LfrGFPycib7q/Gip07g2c=;
	b=Uqo1a5Zg4ddGIdHmOtZDLk4WAS6GFsUxwaraj41wRKCtkMcIaijdWTs+fne7g7/p7bGD
	 A7Ou89EGj/OsrTqnMz8NChYAtzjWcv/wiftK1bE4FdHT29oj5R4iDSJhyFTUbG/cQT4DY
	 RGmuZEf4ePSTHTF7yJk1tpXr5EbwNBprh8txC2ALdPO+5RQC1x9dMIFhmcSt7V6hf9Dxh
	 8OveP5CyY/58rnEcvS0cFCrcRZ/tVgCHgMLnm2n/jTBNNhiykFn5sMhX89yKNZfeFxgBG
	 SQdhtV9kDQVLzGqlUkC8nAMd2s6dFZNpGSszMmsv4z9HDEyRyh8dTP24zCW2p6ALbZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=BNoiAM0H;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L0pAThuI;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=BNoiAM0H;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L0pAThuI;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7579D606A324;
	Sun,  1 Nov 2026 15:33:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7579D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=BNoiAM0H;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L0pAThuI;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=BNoiAM0H;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L0pAThuI
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 619471F79D;
	Sun,  1 Nov 2026 15:33:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793547218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khvlFXDXEPKyNmWKWr4Cc1LfrGFPycib7q/Gip07g2c=;
	b=BNoiAM0HMgmcQc86mXT1cxieOHWjB5EhYd2Xtpz6lpS8LzbytAo+If/wP6fKE85V7M4aUQ
	roeMP5F54NxeNnyHGWdPqfxRABtirlIICH5yIoi4nRwQO5YDWx/jSF0luU1Okd6AX6IEaN
	CEEchcxjzAw2rLeT16yeYIyqtpeWpyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793547218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khvlFXDXEPKyNmWKWr4Cc1LfrGFPycib7q/Gip07g2c=;
	b=L0pAThuIyuhjceieWYBGv3WjULDTJsS9mz9OEyGMSfxreJA9Q+tGmg8JygIzLnVGyUtpyD
	ji8GTA/feVymnPDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=BNoiAM0H;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=L0pAThuI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793547218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khvlFXDXEPKyNmWKWr4Cc1LfrGFPycib7q/Gip07g2c=;
	b=BNoiAM0HMgmcQc86mXT1cxieOHWjB5EhYd2Xtpz6lpS8LzbytAo+If/wP6fKE85V7M4aUQ
	roeMP5F54NxeNnyHGWdPqfxRABtirlIICH5yIoi4nRwQO5YDWx/jSF0luU1Okd6AX6IEaN
	CEEchcxjzAw2rLeT16yeYIyqtpeWpyw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793547218;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=khvlFXDXEPKyNmWKWr4Cc1LfrGFPycib7q/Gip07g2c=;
	b=L0pAThuIyuhjceieWYBGv3WjULDTJsS9mz9OEyGMSfxreJA9Q+tGmg8JygIzLnVGyUtpyD
	ji8GTA/feVymnPDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E5EB134B3;
	Sun,  1 Nov 2026 15:33:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ZfYgNtFb52q/LwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 01 Nov 2026 15:33:38 +0000
Date: Sun, 01 Nov 2026 16:33:37 +0100
Message-ID: <87jymwpnvy.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.de>,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v4] ALSA: usx2y: Refuse a retried DSP load after a failure
In-Reply-To: <20261031191557.8460-1-25031212351@stu.xidian.edu.cn>
References: <871p95svvd.wl-tiwai@suse.de>
	<20261031191557.8460-1-25031212351@stu.xidian.edu.cn>
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
X-Rspamd-Queue-Id: 619471F79D
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-12.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Score: -12.51

On Sat, 31 Oct 2026 20:15:57 +0100,
YuanZhe Liu wrote:
> 
> snd_usx2y_hwdep_dsp_load() sets up the asynchronous sequence URBs and
> the interrupt URB when the FPGA firmware image with index 1 is loaded,
> and then creates the ALSA devices.  If usx2y_in04_init() or
> usx2y_create_alsa_devices() fails, the URBs that were already set up
> are left in place.
> 
> The core keeps the index unloaded when the callback fails, so user
> space may issue the same request again.  The second attempt then enters
> usx2y_async_seq04_init() or usx2y_in04_init() with the URBs still
> allocated and trips WARN_ON(usx2y->as04.buffer) or
> WARN_ON(usx2y->in04_urb).
> 
> The URBs cannot be released at this point: the card may already have
> registered PCM devices that user space can still open, and the
> disconnect handler accesses the URBs without holding the DSP lock.
> Mark the chip as hung instead, so that a retried request is refused
> with -ENODEV and the assertions keep their meaning.  The URBs are
> released by snd_usx2y_card_private_free() when the card is freed.
> 
> A failing usx2y_async_seq04_init() still releases its own URBs, so that
> path remains retryable.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

Applied now.  Thanks.


Takashi
