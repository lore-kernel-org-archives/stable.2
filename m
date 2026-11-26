Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795688017;
	b=GI2U2+9D8EYBTsxAefCorXiEmycSQNtUeDqkz+iLYNfeS8HFxP/GwIdrF1l1vkOxZQx1
	 JXwshphEBSQneX/T/Mv7v2JEOJqWLfwD1VQtTdikv5rsfA2aRnHEBYwwUR8AqLIIoljLC
	 S15/Xb9fYakbsYG5maCA3jrGPvY+9FuZfRKLCDN6OthcqhiZAPs280ifR95cTlKiZAIm3
	 kEKoOxcg5vGX+9dlx0rTOGH/MZCVIvfWF+B1AjFJTP7vza4JpT9OaWwiRuEINCP8AdT3W
	 WG2JhoAEfwC+xtANKD5lq4IIo99Gs2ivnjP244oxfRE6dZ5leajbSfAMx2KAS3i6h1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795688017;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=QjmQWDOhXjPduQCPFEYnWWElx9QajV47LMWbsl16/a0=;
	b=EX+zm1Djjn3AzOErvFNmsETBa8Q9rDZFn/yAZM3vUoPnmBL+VZtaXEcd5dG92/bzpGVP
	 wf6d9VPnLdxG9GXZk204vMyOq1J1M/4jDLabE7RJlchLQ3V103QmmTzWeH0gxuQfnMxqi
	 mqVFgZUp6GOc5vykyRRajPCwhUmQbkQgfkFfft5ttVZVyV2Ue/nPuc7GRMyTLS0dled1+
	 0tyWOs011euKRzCawmZsMG87LxvWjXrCeY0EmEBwjWjitUAx0FG+PNDWuxSAajEEq3hQb
	 8EUZFHZh/9pryzs6QNiDl5vdE/pV89dPWnfIfDb43JUvwBrbIGGcFGh1MLpJ5vl5ucg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=o5ytL25S;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NtxCwrv7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IiP1dU5h;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L3wKBgHc;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18121606A330;
	Thu, 26 Nov 2026 10:13:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18121606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=o5ytL25S;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=NtxCwrv7;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=IiP1dU5h;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=L3wKBgHc
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CAF112205E;
	Thu, 26 Nov 2026 10:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795688015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QjmQWDOhXjPduQCPFEYnWWElx9QajV47LMWbsl16/a0=;
	b=o5ytL25S74zKhzoZ+L/MmCeIxYsfUDPsFQP8U264cGDR1xf0onaNgdHG+2VLIlR+ZAwtiA
	bJoqzQ98O8ROY31N3bBORfnSToqhC6V2bp5kETYPtq8UbeWeN/V21Ucplr23W4vTDJTCkh
	JdYg8siazbSwqolJwmEbhaI1wh4gP00=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795688015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QjmQWDOhXjPduQCPFEYnWWElx9QajV47LMWbsl16/a0=;
	b=NtxCwrv7S/7ynap1/6hIKZcPkRolv5tpyFexw5xFuZ7Rz9DIQh+qfhxRxdDXaJ235ZlwtD
	5wVhn/FC2gu7fBAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795688013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QjmQWDOhXjPduQCPFEYnWWElx9QajV47LMWbsl16/a0=;
	b=IiP1dU5hX4g8bwJC6G4XdxRX3Ye4+mP2b2tVxWSeRG7gEegmbobQBdYwmnufQYAltmQnbM
	ByWBF1kisbSYJZmqpzyvuaQ7tWm5jtVnYKhMBeEU8Nt+p1oHPsjqDBCGjbb3DT83Neh35c
	cV2gcZKIYkhf8s4mr141KWy7H7vf0yc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795688013;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QjmQWDOhXjPduQCPFEYnWWElx9QajV47LMWbsl16/a0=;
	b=L3wKBgHcTaNAimRxwcOFSX+v3MGgugkzImqkeNlY9rvttELYhq2/13uEOWDjph+1xfE46W
	YYOFwFka7y5eULAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7AF8D13432;
	Thu, 26 Nov 2026 10:13:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0a8XFU0GCGtcFQAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 26 Nov 2026 10:13:33 +0000
Date: Thu, 26 Nov 2026 11:13:33 +0100
Message-ID: <87ik1j6gtu.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Pavel Hofman <pavel.hofman@ivitera.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: pcm: oss: Refine slave hw_params after setting format
In-Reply-To: <20261125181005.3683575-1-hengyul@cs.unc.edu>
References: <20261125181005.3683575-1-hengyul@cs.unc.edu>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[unc.edu:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, 25 Nov 2026 19:10:05 +0100,
Hengyu Liang wrote:
> 
> Commit 93d7d38fa61d ("ALSA: aloop: add DSD formats") added DSD_U8 to
> the formats of snd-aloop. Before that, its narrowest format had 16 bits.
> 
> However, snd_pcm_oss_change_params_locked() sets the slave format with
> _snd_pcm_hw_param_set(), which does not refine the parameters, while
> the access, rate and channels before it are set with refining helpers.
> snd_pcm_oss_period_size() then reads a buffer size maximum that is
> still computed for the narrowest format, now DSD_U8, so the OSS period
> doubles. With the default U8 client format, the doubled period no
> longer fits in the format plugin, and snd_pcm_plugin_alloc() returns
> -ENOMEM. As of now, an OSS program that asks snd-aloop for 8 channels
> at 192 kHz gets ENOMEM from SNDCTL_DSP_SPEED and from every later
> ioctl on the same file.
> 
> The issue can be reproduced with this program, where card 1 is
> snd-aloop:
> 
>     #include <fcntl.h>
>     #include <stdio.h>
>     #include <sys/ioctl.h>
>     #include <sys/soundcard.h>
> 
>     int main(void)
>     {
>             int fd = open("/dev/dsp1", O_WRONLY | O_NONBLOCK);
>             int ch = 8, rate = 192000, blk = 0;
> 
>             ioctl(fd, SNDCTL_DSP_CHANNELS, &ch);
>             if (ioctl(fd, SNDCTL_DSP_SPEED, &rate) < 0)
>                     perror("SNDCTL_DSP_SPEED");
>             if (ioctl(fd, SNDCTL_DSP_GETBLKSIZE, &blk) < 0)
>                     perror("SNDCTL_DSP_GETBLKSIZE");
>             printf("block size %d\n", blk);
>             return 0;
>     }
> 
> Before that commit, it prints "block size 65536". After that commit,
> the result is:
> 
>     SNDCTL_DSP_SPEED: Cannot allocate memory
>     SNDCTL_DSP_GETBLKSIZE: Cannot allocate memory
>     block size 0
> 
> This patch will set the format with snd_pcm_hw_param_set(), which
> refines the parameters, as is done for the channels just before.
> 
> Fixes: 93d7d38fa61d ("ALSA: aloop: add DSD formats")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Hengyu Liang <hengyul@cs.unc.edu>

Applied now.  Thanks.


Takashi
