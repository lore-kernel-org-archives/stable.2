Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE1C39D6FF
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 06:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785740322; cv=none; b=tzUxEo3Y+JUh0AkfQSwFKTQi4/GT1zRK1wTaoBBX/VvS3Odrne+f94QHGz/r75NlkqiQVK+kGRa29sVMLC3g9eolOCNlKyTzjQxFHDCsgLiweIwNUVk7dqlyf4f7InwPe6jrppxQPJZliHaMRnRQWOeWkSK/0JU+s+U8ld/DRB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785740322; c=relaxed/simple;
	bh=FmuYgpUHjR5irBx7lvLoSEIBbYigD2GUGCm3Pmqb2Jc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZVaNAGsupGbF7qJC8l0xHMUPr/Uj/uDu4ADr5zx/pdMHgVXZVbJgMABckrEPIZWPjuFbgrdX1yodmZCCnvIndoCN/eqJynfvOpim2hDBu/RorAy6KI7Wv+J9qMqM9K31rtX2cqlUEGaM6HHKlGSPQpbq2wjaG9p65ItUpc/oocQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Epg9K6Mo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CLVJyiet; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jOwF848T; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Z5hEolp+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Epg9K6Mo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CLVJyiet";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jOwF848T";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Z5hEolp+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 21F2A47D7;
	Mon,  3 Aug 2026 06:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785740310; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cqSz+iSuHk3vkr/tKzEMa5d9u/Xhur0gutsu/w80qYE=;
	b=Epg9K6MoZKP/HsmrNAC+CYPC0WmClOH2aIhz3gw35T+UPPZ5EfeEqQlNRDgI81HstntKSN
	O9naPC2UaNWni94Cm1ejalPa1axvhwJIMkt6yy7Wjdj2XJCBCTNwyU4pWxXKuNYTAtEptB
	Rk3wUSqMfTdI8kjtimt8C3RBdLccbxs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785740310;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cqSz+iSuHk3vkr/tKzEMa5d9u/Xhur0gutsu/w80qYE=;
	b=CLVJyietXaEtqHJkvQ0V6fnzvG8SYEp/gaU41qiW29o8CcWYUGimRvcm86kZNx1L+6kzhm
	bpuiq/GYKYvTw9BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1785740306; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cqSz+iSuHk3vkr/tKzEMa5d9u/Xhur0gutsu/w80qYE=;
	b=jOwF848TVzVT06cLNyiEpo/3DaSY4t1EsIwDjKzFgSlM5hILwv/OJI5PRhGbD1e6rgj+XF
	GQdQm3i809QT2wV9knnHvlmxQOQIVpJMQVVYT3cq8dKG3x3XKHFWRgIC2zhkA/KA/ZNMsU
	IzTUReMegik1t74OwqH4OgujUmdpSd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1785740306;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cqSz+iSuHk3vkr/tKzEMa5d9u/Xhur0gutsu/w80qYE=;
	b=Z5hEolp+GfLmcX/CJB0cvwDS9CXjxXYf/WtJ/ffdgxvcSceILlk9j1Lft78RhMc6VW9e++
	vl8GDXNryjnhtFAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D12F9779A1;
	Mon,  3 Aug 2026 06:58:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id y1i3MRE8cGrCBgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 03 Aug 2026 06:58:25 +0000
Date: Mon, 03 Aug 2026 08:58:25 +0200
Message-ID: <87cxvzbsha.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: raoxu <raoxu@uniontech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	shenghao-ding@ti.com,
	baojun.xu@ti.com,
	dakr@kernel.org,
	u.kleine-koenig@baylibre.com,
	cassiogabrielcontato@gmail.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/tas2781: fix ACPI reference handling
In-Reply-To: <97EA8F29DA0D9AF7+20260731033554.949564-1-raoxu@uniontech.com>
References: <97EA8F29DA0D9AF7+20260731033554.949564-1-raoxu@uniontech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	URIBL_BLOCKED(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo,uniontech.com:email];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[perex.cz,suse.com,ti.com,kernel.org,baylibre.com,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uniontech.com:email,imap1.dmz-prg2.suse.org:helo,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Fri, 31 Jul 2026 05:35:54 +0200,
raoxu wrote:
> 
> From: Xu Rao <raoxu@uniontech.com>
> 
> tas2781_read_acpi() gets a reference to the matching ACPI device and then
> looks up its first physical device node. After taking a reference to the
> physical device, it immediately drops the ACPI device reference.
> 
> However, every later failure jumps to an error path that drops the ACPI
> device reference a second time. This unbalances the reference count and
> may prematurely release the ACPI device.
> 
> In addition, acpi_get_first_physical_node() may return NULL. Without a
> check, the driver passes the NULL physical device to the property helper
> calls and may dereference it.
> 
> Return -ENODEV when no physical device is associated with the ACPI node,
> and remove the duplicate acpi_dev_put() from the common error path.
> 
> Fixes: bb5f86ea50ff ("ALSA: hda/tas2781: Add tas2781 hda SPI driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Applied now.  Thanks.


Takashi
