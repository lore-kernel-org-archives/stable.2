Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B513D1AB7
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250811; cv=none; b=UZvxpCD/+TWLBLtPoyhRXcvpMBEQMMQsZkONfOy2AjaTdhwN8nBrNiAGqXSchfnmgpq0iAQqByKJ1TFyRmnJPnIymWXNCCkObyeZlTzaF6vWhKnkBdwD0NQX8jmWM+BODykS2+R2aLWHnNx7PiPV8xk2yVjts9md1ohTHolv2xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250811; c=relaxed/simple;
	bh=RgmrGkntq3tc8bk5cbEi2dvBK+qiA7b1mod7DP0Dlkc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jIcUwdJP0kArN0PnDXv464hiEDQzopr+2iknCqBB7RfyHMKrzqzJCdH4EBFKFgDTl1ZSuc1jkuXBw1TzJTPIFY/2+Y9/OtKdk9as15AKYXv7/6fCkoTdnldV24E+0wwJfoneqypb6z95sEPEe+y/b/lMyT0Uo07twEjWezCqgTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ihjRCR7h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7TGofvaK; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ihjRCR7h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=7TGofvaK; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ihjRCR7h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7TGofvaK";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ihjRCR7h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="7TGofvaK"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4BA1575C2A;
	Fri, 12 Jun 2026 07:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781250803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KT9QNd5js3x5JI/IG3pj1OAG4bVWN2GVWEIZCojdHnk=;
	b=ihjRCR7h0XgYsoaJt0Aoli/KjiYPhTYwQlx++hw94NlRvTcE+SF+9YvpmrdiEPMJuDfvOn
	7gFNMzVJ/l/SYXEOmNgCCQXGcP5h2apGBN0BG/CyJAIZKh5ypVmhNnao901Qk6gLzFBM6y
	N1R0ZchrErp/T0GGxAFZUu5aQv+8Jls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781250803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KT9QNd5js3x5JI/IG3pj1OAG4bVWN2GVWEIZCojdHnk=;
	b=7TGofvaKbYdP5iq5zdK50e5JWXzloxQ5KqxRlT90/9VL3PGSj2Uk+i24XVMtIDbvpDazly
	EYWVHTEVnoluliAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=ihjRCR7h;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7TGofvaK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781250803; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KT9QNd5js3x5JI/IG3pj1OAG4bVWN2GVWEIZCojdHnk=;
	b=ihjRCR7h0XgYsoaJt0Aoli/KjiYPhTYwQlx++hw94NlRvTcE+SF+9YvpmrdiEPMJuDfvOn
	7gFNMzVJ/l/SYXEOmNgCCQXGcP5h2apGBN0BG/CyJAIZKh5ypVmhNnao901Qk6gLzFBM6y
	N1R0ZchrErp/T0GGxAFZUu5aQv+8Jls=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781250803;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KT9QNd5js3x5JI/IG3pj1OAG4bVWN2GVWEIZCojdHnk=;
	b=7TGofvaKbYdP5iq5zdK50e5JWXzloxQ5KqxRlT90/9VL3PGSj2Uk+i24XVMtIDbvpDazly
	EYWVHTEVnoluliAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2F60779A7;
	Fri, 12 Jun 2026 07:53:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +sQPOvK6K2qrIwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 12 Jun 2026 07:53:22 +0000
Date: Fri, 12 Jun 2026 09:53:22 +0200
Message-ID: <87y0gki499.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: WenTao Liang <vulab@iscas.ac.cn>
Cc: perex@perex.cz,
	tiwai@suse.com,
	chenziqing@xiaomi.com,
	broonie@kernel.org,
	cezary.rojewski@intel.com,
	kees@kernel.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] sound/core: fix refcount leak in snd_ctl_elem_info_user()
In-Reply-To: <20260612022121.14329-1-vulab@iscas.ac.cn>
References: <20260612022121.14329-1-vulab@iscas.ac.cn>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4BA1575C2A
X-Spam-Score: -3.51

On Fri, 12 Jun 2026 04:21:21 +0200,
WenTao Liang wrote:
> 
> snd_ctl_elem_info_user() calls snd_power_ref_and_wait() to obtain
> a power reference for the sound card.  If that function returns an
> error (e.g. -ENODEV when the card is shutting down), the reference
> is still held because snd_power_ref_and_wait() always acquires it
> unconditionally.  However, the error path in snd_ctl_elem_info_user()
> directly returns the error without releasing the reference, causing
> a refcount leak.
> 
> Fix it by calling snd_power_unref() before returning the error,
> matching the successful path that already does the paired unref.
> 
> Cc: stable@vger.kernel.org
> Fixes: fcc62b19104a ("ALSA: control: Take power_ref lock primarily")
> Signed-off-by: WenTao Liang <vulab@iscas.ac.cn>

Judging from the current code patterns, it's better to fix the
function behavior itself -- unreference in snd_power_ref_and_wait()
itself when returning an error; otherwise there are way too many
callers to fix up, and the current behavior is rather confusing.

Could you try the patch below instead?


thanks,

Takashi

-- 8< --
--- a/sound/core/init.c
+++ b/sound/core/init.c
@@ -1139,7 +1139,7 @@ EXPORT_SYMBOL(snd_card_file_remove);
  * typically around calling control ops.
  *
  * The caller needs to pull down the refcount via snd_power_unref() later
- * no matter whether the error is returned from this function or not.
+ * when this function returns 0.
  *
  * Return: Zero if successful, or a negative error code.
  */
@@ -1152,7 +1152,11 @@ int snd_power_ref_and_wait(struct snd_card *card)
 		       card->shutdown ||
 		       snd_power_get_state(card) == SNDRV_CTL_POWER_D0,
 		       snd_power_unref(card), snd_power_ref(card));
-	return card->shutdown ? -ENODEV : 0;
+	if (card->shutdown) {
+		snd_power_unref(card);
+		return  -ENODEV;
+	}
+	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_power_ref_and_wait);
 
@@ -1169,7 +1173,8 @@ int snd_power_wait(struct snd_card *card)
 	int ret;
 
 	ret = snd_power_ref_and_wait(card);
-	snd_power_unref(card);
+	if (!ret)
+		snd_power_unref(card);
 	return ret;
 }
 EXPORT_SYMBOL(snd_power_wait);
