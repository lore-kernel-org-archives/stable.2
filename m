Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02DB4F3EB3;
	Tue, 29 Sep 2026 14:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790692047; cv=none; b=Oadp2IS1NqaeYvd4mRW8gQpUB2IQ/GFfI9G4ZtKcSG0U7DH1w40axAjNBWJTCF7iu4uKAk6Ciq653iyLXzVlpIaMCwO8Y5q7diIGnopao4sxNb0UMh3/96G1EJIrcM2S1T9WcfvFEuEydf4ucTyrHty1L/NFpotfWe6geIFJv0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790692047; c=relaxed/simple;
	bh=wKB5lHhMP6f2prvhEqKZQ0TaDC6VPD/89WIk2CTquz4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dPVPsSQOitp5ojadPQX0yTKb475A/ae/2KxPl7cn/IhBGNDFbYov6eVoqaF/d4r6RiHWrIj/JlseqHvJ/HYbsRT2pIYJXOnP+Km0qmQrd53UF3Lz/rfLJ3ObpvcdP0N5T88C0PBBdvZK3e0AhCbFAhFMaQdEFUowZ31KCspklpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=YnPVEWDg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=rSYakkoI; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=R8KSvIji; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Ii5LMGbb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="YnPVEWDg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="rSYakkoI";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="R8KSvIji";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Ii5LMGbb"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2586621BB2;
	Tue, 29 Sep 2026 14:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790692035; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41gpuv06s3lZc8rCBybOHhNIhT0blsjOU72fcvDAqe4=;
	b=YnPVEWDgV8Yf9jWYbGgY3AfE5rsUGxv6kWZUtYKyAD+q3DXKRt4xdPGZVDajYR7C7GeysK
	IeHiVbReStPw6cbkKrzYl3diHA85rliVi17Fdl7LoiTJsCPWZt4jBxsEB2i+hvJTSm9oGv
	jOt0gWkN8gismdT4Q59RV4Dzeyw38vQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790692035;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41gpuv06s3lZc8rCBybOHhNIhT0blsjOU72fcvDAqe4=;
	b=rSYakkoIUyFy91sFfh6x2ykzrShB59daiXy+K3M1ul/TT4wKIph5Ra5DgW6XBNXQ82f3jb
	D5G7fH1RNZ7QyiBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790692031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41gpuv06s3lZc8rCBybOHhNIhT0blsjOU72fcvDAqe4=;
	b=R8KSvIji3LRX69lD9EF3xgBixR1zZvunhQsGZJQ027XZyppfP12u4DtC13u7kP+gG8h1Jc
	7yJeVXFBm5D1M/jC2JkoI2iLZolQ2NYMr5Xu1WBTETYQsFWWZD2jWmbJ+gqDO2mWk0hkrJ
	lFWeimwdTYrHfe+nrPXZE2rKmKGSfQs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790692031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=41gpuv06s3lZc8rCBybOHhNIhT0blsjOU72fcvDAqe4=;
	b=Ii5LMGbbHiekFS+IjVZ4jKceycqMGPIIhxhxfWZLYH4hYirdHNiVvdLjJ1COaoYj8J1nm6
	9355fzZ6OQG3UpCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4185133F1;
	Tue, 29 Sep 2026 14:27:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PxZIKr7Ku2rxXAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 29 Sep 2026 14:27:10 +0000
Date: Tue, 29 Sep 2026 16:27:10 +0200
Message-ID: <87y0ckyvy9.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: Clemens Ladisch <clemens@ladisch.de>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ALSA: usb-audio: Protect Roland control activation
In-Reply-To: <20260929141726.2166899-1-runyu.xiao@seu.edu.cn>
References: <877bk418r3.wl-tiwai@suse.de>
	<20260929141726.2166899-1-runyu.xiao@seu.edu.cn>
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,seu.edu.cn:email,suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 

On Tue, 29 Sep 2026 16:17:26 +0200,
Runyu Xiao wrote:
> 
> The USB MIDI driver changes the Roland MIDI Input Mode control's access
> flags directly from the rawmidi open and close paths.  These changes are
> not protected by the ALSA control core and the corresponding notifications
> can race with control access.
> 
> Use snd_ctl_activate_id() so that the control core updates the access flags
> and sends the notification under its lock.  Release the USB MIDI mutex
> before calling it because the control write path holds controls_rwsem while
> roland_load_put() takes the USB MIDI mutex.
> 
> Keep the state transition and alternate-setting change under the USB MIDI
> mutex; rawmidi's open mutex serializes the enclosing open and close paths.
> 
> Fixes: 96f61d9ade82 ("sound: usb-audio: allow switching altsetting on Roland USB MIDI devices")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>

Applied to for-next branch.  Thanks.


Takashi
