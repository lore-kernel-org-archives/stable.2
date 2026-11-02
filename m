Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609462;
	b=bx+4DjZZ36B/UNa3Pa83Q3ojnTF3Ps4A6ul58RrwfWoJrTBDwt3/DJEe+5WnYi/xG37Q
	 9J/NIei8UTCXyUCMV+cEZAH95acnK7+60q4JhQPwsiYZzMsP9e6MCwUu6ZW4LlFgf0SPE
	 5doNhlXxCBaeHSKf/GIRNKKDH0CLK6K8Yr0RK+aw7yGTtPgmCd/Ka2OBfoFoisjPGuKWi
	 xwTDM2kyeBkI19dK07vAYAW9XvPML9JwbWnAiOeXfkltNG1Zmy0Gt2CM96Xbg6TjHQ0yX
	 3FHn4vsMrfqfwvpGAxyxGHZ72OI7kV/q3PgpgEYNcqgaDPxjdqxqFTTDkHPuSiaoyBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609462;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=FybLTP04cq4U6sgKHlnCBy/A2QdmmVaR5IkgA24/DMI=;
	b=4klaB/aJhgh0WblPnbagWdee96vnPACrsnQOie3ZPbz/qhdQGEZPhWNA7QZuQ57N57l7
	 20O4G9gkI7ocSRi9Y5XDjOcphpHPUk59ayRItahMIkLLpOzZfibqsx97Euft/oGWeLmlA
	 5eEWT9R7N4SoRfvkKVDpfLyqlc226HnG0a5OxIUVj9tRlqbddrfLxFAhoG+Osd4neZ5Wm
	 v3aAFiy7bt3JvsFMa/By7LmqP4WbL8raJ1X4lY/mm2HPiDE7uHiZovCFR+PJLwuCkP7Fn
	 bWRoSRJgQ+xntFrPUDlJra7C9VLjVh15WyAXnioRxfA3DQanblEeuhAcrolIEto+YNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nqB8Rzrl;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hNP06WHq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nqB8Rzrl;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hNP06WHq;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95777606A33E;
	Mon,  2 Nov 2026 08:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95777606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nqB8Rzrl;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hNP06WHq;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=nqB8Rzrl;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=hNP06WHq
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 287481F83D;
	Mon,  2 Nov 2026 08:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793609453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FybLTP04cq4U6sgKHlnCBy/A2QdmmVaR5IkgA24/DMI=;
	b=nqB8RzrlI+Vl/lNRLw0fz5B+58DCQukMreggpg7UQ6pZ4PcBWwrgZ676VcCUaRwfpHPRpH
	TunEkIdulqWE1dimHBhA4+PuQmw317lfCYVm9bsZansNZqPB+owy78snm9cRNg+A1E9x13
	6d4v15AqotWCpfAGDMxHij5SroBdbR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793609453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FybLTP04cq4U6sgKHlnCBy/A2QdmmVaR5IkgA24/DMI=;
	b=hNP06WHqmof17lIyKvpH3jD7cgelHi+ZKe3AZA25U/VlSrOYqbDOpmEtCJ/H2GK94Ezt+C
	72g2jVZg76ppMxAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793609453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FybLTP04cq4U6sgKHlnCBy/A2QdmmVaR5IkgA24/DMI=;
	b=nqB8RzrlI+Vl/lNRLw0fz5B+58DCQukMreggpg7UQ6pZ4PcBWwrgZ676VcCUaRwfpHPRpH
	TunEkIdulqWE1dimHBhA4+PuQmw317lfCYVm9bsZansNZqPB+owy78snm9cRNg+A1E9x13
	6d4v15AqotWCpfAGDMxHij5SroBdbR4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793609453;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FybLTP04cq4U6sgKHlnCBy/A2QdmmVaR5IkgA24/DMI=;
	b=hNP06WHqmof17lIyKvpH3jD7cgelHi+ZKe3AZA25U/VlSrOYqbDOpmEtCJ/H2GK94Ezt+C
	72g2jVZg76ppMxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C2CA9134B8;
	Mon,  2 Nov 2026 08:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id A43gJOxO6GouSQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Mon, 02 Nov 2026 08:50:52 +0000
Date: Mon, 02 Nov 2026 09:50:52 +0100
Message-ID: <87ld7b4nwz.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Yuqiang Sun <izaiahsun@gmail.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	wesley.cheng@oss.qualcomm.com,
	raoxu@uniontech.com,
	linux-sound@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: usb-audio: qcom: Check the return value of qmi_handle_init()
In-Reply-To: <20261102035237.56253-1-izaiahsun@gmail.com>
References: <20261102035237.56253-1-izaiahsun@gmail.com>
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
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-12.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30

On Mon, 02 Nov 2026 04:52:37 +0100,
Yuqiang Sun wrote:
> 
> qc_usb_audio_probe() overwrites the return value of qmi_handle_init()
> with that of qmi_add_server() without checking it. When
> qmi_handle_init() fails, it has already freed the receive buffer and
> destroyed the workqueue, and qmi->sock may hold an error pointer. If
> QRTR is not available, qmi_handle_init() returns -EPROBE_DEFER and
> qmi->sock is ERR_PTR(-EAFNOSUPPORT), so qmi_add_server() passes it to
> kernel_sendmsg():
> 
>   BUG: unable to handle page fault for address: ffffffffffffffb7
>   RIP: 0010:selinux_socket_sendmsg+0xa0/0x590
>   Call Trace:
>    security_socket_sendmsg+0x29/0x50
>    __sock_sendmsg+0x43/0x150
>    kernel_sendmsg+0xd6/0x180
>    qmi_send_new_server+0x1b8/0x2b0
>    qmi_add_server+0x165/0x200
>    qc_usb_audio_probe+0xf4/0x2e0
>    really_probe+0x2b4/0x850
> 
> Had the probe gone on, the error and remove paths would call
> qmi_handle_release() on the half-initialized handle, which destroys the
> workqueue and frees the receive buffer a second time.
> 
> Return the error from qmi_handle_init(), so that -EPROBE_DEFER defers
> the probe, and check qmi_add_server() as well.
> 
> The bug was found with kbound, a static analysis prototype for
> ownership mismatches at kernel interfaces, on v7.2.12; it is present in
> mainline.
> 
> Build-tested with x86_64 and arm64 allmodconfig (W=1, sparse): no new
> warnings. Run-tested on QEMU (x86_64, KVM) with KASAN and kmemleak, with
> the driver built in and a test module that registers the
> q6usb.qc-usb-audio-offload auxiliary device. Without QRTR, the probe
> crashes as above without this patch; with it the device is deferred and
> removing it again reports nothing. With QRTR the probe succeeds, and
> removal reports nothing either.
> 
> Fixes: 326bbc348298 ("ALSA: usb-audio: qcom: Introduce QC USB SND offloading support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yuqiang Sun <izaiahsun@gmail.com>

Applied now.  Thanks.


Takashi
