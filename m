Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795426349;
	b=en4sfx5VMjD86faPPb1Njy2PTebGotVY2/Ip7wh32417GoWmRCUYS6tVRkPY5bkKY9lp
	 usArC/dxXaG6O+xRvAmj6ZeZH/8SeAyy59VlLHd6kF/ft/0ocNcwLnQnqeNsUduLCvVVZ
	 THAo0pVqd44IKghAk958B27fLJxidcmNOBflnKX3msWVQubzGS6lXo9HnFUoD+3J7oBD5
	 alOdm+V1x6yyc/jL3ZxZu+ro7T3944L9hGuiW9CJVaCztcfKRNYbMhSow2SVubVdWXsCk
	 VmlQF8kgPOnlIwBXhJgVWjasAbIKmmvBUU6Hu6CSNDJjpV5F3ncIu4Z7jP3ubG4Xmvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795426349;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=HENCv2ieEzXZok7KFVbIdnLvR/2pBLxGqmsDYmJcTLg=;
	b=KAeZjX5erKgsWfMzwXfw62eUj/2HrGBfOJ3n/JxWmMdU0zmdbV+IhOsvmU+ynwBmMVTp
	 6fnrhqcuHHe473EaIJGZj3lTJFvJVXAIOFqYlRfDpq9M54yxXts/jXHR8ysNqXWtRWmqJ
	 Vp1/zIVuBT1W+OfTD8wE94Zx70f28Z68sjtha5qVG7aebWoT1aojQisBQMy19BdZtymrG
	 uRhJp/WjmPLH2l842YNHBsm7Yg4R2w3L4XsCfyVN7ph7PyLmLLFSjrwQE18CuYyeNptxj
	 Y+K5DBFi+yS3JbE1NCHwldBOesAR23K3FxNBecs33XzWv46FffR0fYHXNmdjIOGQytA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=R2MI97kV;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ddgAvCDh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NkOveBO5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YHxH7fMz;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7296606A32C;
	Mon, 23 Nov 2026 09:32:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E7296606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=R2MI97kV;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ddgAvCDh;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=NkOveBO5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=YHxH7fMz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id DA2071F7E2;
	Mon, 23 Nov 2026 09:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795426347; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HENCv2ieEzXZok7KFVbIdnLvR/2pBLxGqmsDYmJcTLg=;
	b=R2MI97kVvdXL/ZqV6R8nhIKO61gY5xmUr3sUng6A+IodkR48mStUGxcRHEv59MqjRyWCd6
	djyPRcJWc1qeIMkUaZ0pzBybqvOdvEBiCsoA8esmBSieltAQmoJWqWJ0igrG9NggMl355D
	3RyPRp7hH9cHXYUDsP9NdpqtqAoVS1Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795426347;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HENCv2ieEzXZok7KFVbIdnLvR/2pBLxGqmsDYmJcTLg=;
	b=ddgAvCDh46aA+RmgXGKTi4x8dEGCwsKQZ3us4tdjY4ppT6pWa5Ws0bZFve/v/MR/Vf2C3q
	/oR80W00V+mWOACQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=NkOveBO5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=YHxH7fMz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795426346; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HENCv2ieEzXZok7KFVbIdnLvR/2pBLxGqmsDYmJcTLg=;
	b=NkOveBO5NMFqrdWyNd1W6PkLGKdLVsVaQ0bPJ1G0h2Ku2fJ6D0iHrVk45odpQRKRI4M2hx
	cH8QrvEwo/N/nK0MdKxIsjl+VW/EZ/rL1uw3XMSFDaO4J4vyZcfXdiH5kQjsfpVxhCeEIN
	vGTXHOlAN5g14ARsJ1dizvmzrRa5zKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795426346;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HENCv2ieEzXZok7KFVbIdnLvR/2pBLxGqmsDYmJcTLg=;
	b=YHxH7fMzj2LlNhVkNyxuFU484CBngGmZdoP8xF0r8sEzJrkVux86+wemp/WTje/CeGKa0g
	42nPKLuf71CKNPBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82C171352B;
	Mon, 23 Nov 2026 09:32:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vl8PFioIBGvNJgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 23 Nov 2026 09:32:26 +0000
Date: Mon, 23 Nov 2026 10:32:26 +0100
Message-ID: <87ld6jdhat.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Yu-Hsiang Tseng <asas1asas200@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>,
	Cristian-Marian Fotache <cristianmarianfotache@gmail.com>,
	Takashi Iwai <tiwai@suse.com>,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [REGRESSION] ALSA: hda/realtek: Higole F9B fixup breaks speakers on unrelated Apollo Lake laptop (10ec:111e)
In-Reply-To: <179542261324.542908.13953751300676446171@gmail.com>
References: <CACGjpbf73XdwrG34ffjmYU3ZYuStPpFNXf9w+AGYcTmLyHCN_w@mail.gmail.com>
	<87cxrx70qe.wl-tiwai@suse.de>
	<87pkvx5625.wl-tiwai@suse.de>
	<179542261324.542908.13953751300676446171@gmail.com>
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
X-Rspamd-Queue-Id: DA2071F7E2
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_TO(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[suse.de,gmail.com,suse.com,perex.cz,vger.kernel.org,lists.linux.dev];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Spam-Score: -12.51

On Mon, 23 Nov 2026 09:30:13 +0100,
Yu-Hsiang Tseng wrote:
> 
> On Sun, 22 Nov 2026 14:50:10 +0100, Takashi Iwai wrote:
> > > Yu-Hsiang, could you check whether the quirk can be replaced with
> > > HDA_QUIRK_ENTRY() with the codec ID instead?
> >
> > Correction: here I meant "codec SSID", of course.
> 
> Sorry for the breakage. The codec SSID doesn't help, unfortunately:
> it is 0x10ec111e on both machines. Cristian's codec dumps show
> "Subsystem Id: 0x10ec111e", the same as on the F9B, so an
> HDA_CODEC_QUIRK() entry would still match his laptop.
> 
> Please go ahead with the revert.
> 
> The commit is in 7.3 and was backported to 6.1.y, 6.6.y, 6.12.y,
> 6.18.y and 7.2.y, so the revert will need Cc: stable.
> 
> For the record, this is how the fixup silences his speakers. His BIOS
> declares two internal speaker pins, 0x1a and 0x14, besides the
> headphone on 0x15. Without the fixup, the headphone gets DAC 0x02 and
> both speaker pins get DAC 0x03. With it, 0x14 can only use mixer 0x0c,
> so it shares DAC 0x02 with the headphone. That DAC holds "Headphone
> Playback Volume", and PipeWire turns it all the way down while the
> speaker is the active output.
> 
> Also, pin 0x14 on his laptop follows its connection select, which is
> not what I saw on the F9B. I'll re-check the F9B before proposing a
> narrower match, and I'll Cc Cristian so he can test it.
> 
> Cristian, thanks for the report and the dumps.

Thanks for the confirmation.  Then I'll revert the commit for now.

For Higole F9B, until we find some better way, please use
model=mono-speakers option as a temporary workaround.


Takashi
