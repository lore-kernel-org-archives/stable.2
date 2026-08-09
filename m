Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB133793AC;
	Sun,  9 Aug 2026 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786271471; cv=none; b=ExuwZn9+BR+VmvTtSueAIfpkFIAiYSJpExTviHNzAwXasa8tyO+ZpQGLJ1lnBX6eZZaTAwSMOOBHr3dTDULq3sy5mvrAcBDjsEew0AG9rgQPmiq9z1bgz7DxuY3HBf46z7L51EeK1GrHnD0iKzbZ5CxjAPP+thlD5u9tq5JynAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786271471; c=relaxed/simple;
	bh=VVzATvCJKYVfUkT1PeCQqkw0oOd6aVbAPq7aVel4aWM=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWnJTosSedHk4tbeg32ePCXSNvFwd2AZOpLa3lL2bDDLfSgGqZTREhMGe6V8QaDsdWa2kXA1o+FvmUoEcYivDruG2dhRvrTyh6XWE6vFEG6i9XsPL/8i5oddNAkwGKIFLP4LC4gmqrll9GVqxEXPnymIy0hsq/Emtooih0qz++Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oY3npLap; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=XkUifjqG; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=f1OOc32x; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=evTs294L; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oY3npLap";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="XkUifjqG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f1OOc32x";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="evTs294L"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 17A5842E3;
	Sun,  9 Aug 2026 10:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786271463; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C4MQmEZ1jVktrdZ/Sdj6XuR/RWJ0jaz/O3XB5SmQt2M=;
	b=oY3npLapq8LVTeLOgpriVG4AilvXnzrKMsqnzTXaL4yIIS8UE4LLnEd2s8mUiYTwfkfoTe
	ZRsgk/E8Nz5gqU4g1P5E/GV5ESUDuCUs+lXxTDFYtuRggh56+oxEPvBwubFoFzhsaCBUvT
	EphRdE5anoYb8DriUaRDGuR/mc5P5Fw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786271463;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C4MQmEZ1jVktrdZ/Sdj6XuR/RWJ0jaz/O3XB5SmQt2M=;
	b=XkUifjqGDCVLQojlUpDrK/MoI8/XAeGdeW/PVAnIeZxQO4MjtWza8oQ33hfzbGy9XVG5Z5
	sZ0RQo2cyn/ruzCw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=f1OOc32x;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=evTs294L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786271459; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C4MQmEZ1jVktrdZ/Sdj6XuR/RWJ0jaz/O3XB5SmQt2M=;
	b=f1OOc32xz4uiJSYcdKkLG+TBmJvS1cXxH0peqwCBprmDPJ1ey8sKil9JpEfsL7BmRkckys
	M6YnA23vn+mkmhXyhc/sGWI5Qa10aZYdJPjm3wfwQJUEDddTK1tOWd+DtMxRWmSGeCIA6q
	g9fYJXVllPq7fWKjiIsdoFzzCL8OQQY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786271459;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C4MQmEZ1jVktrdZ/Sdj6XuR/RWJ0jaz/O3XB5SmQt2M=;
	b=evTs294LT03gtDFq308626TBoEG8HRfqQZqAXvMQa8OrvWCUx+ZngZvgvYLHQFzoOJphKs
	+fzN/eavgwKCKyCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E21C1779B2;
	Sun,  9 Aug 2026 10:30:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sDK/NeJWeGpBXwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sun, 09 Aug 2026 10:30:58 +0000
Date: Sun, 09 Aug 2026 12:30:58 +0200
Message-ID: <87ecg7a8m5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Ajrat Makhmutov <rauty@altlinux.org>
Cc: tiwai@suse.de,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Enable headset mic on F+ FLAPTOP r
In-Reply-To: <20260808185500.2564948-1-rauty@altlinux.org>
References: <20260808185500.2564948-1-rauty@altlinux.org>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Score: -3.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 17A5842E3
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altlinux.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,alsa-project.org:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Sat, 08 Aug 2026 20:55:00 +0200,
Ajrat Makhmutov wrote:
> 
> The BIOS of the F+ FLAPTOP r laptop (Realtek ALC897, SSID 1e63:6d9a)
> declares only pin 0x1b, the headphone output of the 3.5 mm combo jack.
> Every other external pin is left at 0x411111f0, so the headset mic pin
> 0x19 is never parsed and no headset mic input exists. The pin is wired
> on this board - retasking it makes the headset mic record.
> 
> Reuse ALC897_FIXUP_HP_HSMIC_VERB, which already sets the pin config this
> machine needs: 0x19 as a headset mic without its own presence detect.
> Only 0x1b reports jack presence here, so a mic pin with presence detect
> would leave the driver in auto-mic mode waiting for an event that never
> arrives.
> 
> Without the quirk the generic parser retasks the lone headphone pin as
> an input instead. That surfaces as a "Headphone Mic" input which records
> only the internal mic bleed, so the headset mic appears present but dead.
> 
> Tested on ALT Linux, kernel 6.12, by recording a CTIA headset mic on the
> combo jack with the internal mic as a reference.
> 
> ALSA info before the patch:
> https://alsa-project.org/db/?f=18363eddea933baee100c9bf461d0e5cf74c8de2
> 
> ALSA info after the patch:
> https://alsa-project.org/db/?f=48ae2cd7aaf1eb0f24639ce83cd38cfd93b25f76
> 
> Cc: stable@vger.kernel.org # 6.12.x
> Signed-off-by: Ajrat Makhmutov <rauty@altlinux.org>

Applied to for-next branch now.  Thanks.


Takashi
