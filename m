Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795800996;
	b=FXEaOUELY3WERRUPa3BAtdM4vfzuuFh0uI8EPjRw4VOd9C60l5Lkn/8LD68K4ytoAS0j
	 EzGY7a814kVJIPBYiWmQiSLBKvNOiF7KTxPZSxoNC8Coxh9PjuBoNCg/msoI3gzzQ5AbD
	 gDFgfvV5e9kVZ/8CIWPe74llBIO6Vpt9pRjvKyNsN/wVr/dLmF+gUr8BLvFZC8kJbFgLx
	 KtMjdbOVYkcWgEKjxNSqPAc/9ue5rz+qdK/BZ7vEVSNIyAyM6iV+PeaVl06pmca26xvJA
	 MbGO9j07k+uNzefl3xUK8Sr1LCICPom4/b6twsv7uHeSLaq/LoIQcby9OyFOijxMtxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795800996;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=fHiM3zVHAe++cXO6bb2Ybft72sA2VeiwEznSHkx5iqo=;
	b=cbzLPzsvGHyq5KkhBAeX9EnSpw7XdGR26akkEsUOo9Igl2giuSssjfy4/TDxfhhOuYGT
	 KWHyOyKezqvf6rUDsbOJ3Ppq4UXlAgck04nM8Gx5pSW/DffoKfMCXS18yt2Pw6y05DZxH
	 HuibA/e9WkqUIJAmU01dwwxASgNGuXQ0gx0LZFRZ6XTRfUzQS67gCsllz+eNPr8ojdQlo
	 6Fdy96bs347qXKtOko2xOd/RXt9Hw5Iz6oUR4QG4qCOVwrTB3gMnV+kxJDWgqC98EO1hH
	 czw9RPV9esDDm6lmLU5Wk9hoM8M6z85U6pCMAZqT9KIyV5ymAQ6kRaNArAW1K7GtukA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=j3sKz0ou;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=amOoe+FB;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=iHww++HO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EC6WdMl2;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A30606A324;
	Fri, 27 Nov 2026 17:36:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35A30606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=j3sKz0ou;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=amOoe+FB;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=iHww++HO;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=EC6WdMl2
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 237FC1F7F2;
	Fri, 27 Nov 2026 17:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795800993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHiM3zVHAe++cXO6bb2Ybft72sA2VeiwEznSHkx5iqo=;
	b=j3sKz0oud/CrD1mnrNGYvuilSyUXSmYzNdQY2I77/OnZk8npKeSsui98eg4Lv36MAegJE+
	yonA/frN2d+0B0lUUNngIrDK0+ptWZvb03JP2sfvCTg6KiOw1IF95TaBuIawE4BKjYzVlE
	k+xc55iERJA2k06uXj+3syu81gaWfdk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795800993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHiM3zVHAe++cXO6bb2Ybft72sA2VeiwEznSHkx5iqo=;
	b=amOoe+FBrN5vFg57KX3YDO81j29ECLESd4Kg6lrktlPo/LbDCDtDwDyBagcDyJwRjibeyJ
	pdrwpes4fvuE66Dg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iHww++HO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EC6WdMl2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795800992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHiM3zVHAe++cXO6bb2Ybft72sA2VeiwEznSHkx5iqo=;
	b=iHww++HO9ugseibTePjnWeYQRRDI+3j/8vsVrnyTfIt3qErxmHOOGR0nA1tXc91eEyYlMg
	J9QfqtbececEcEBiLeSjzlqZOO/7rzONpTkzRAmYOM+gfrwXb6ZIpGDhbrpNKLUowd14bg
	yanKdZRrOoHnR/y48kpDB09tjVGF+Vw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795800992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=fHiM3zVHAe++cXO6bb2Ybft72sA2VeiwEznSHkx5iqo=;
	b=EC6WdMl2cVMPQ8qsJWBE3luLboRq84vPW8b1qU6qjWOrqQ4J+5MTVC8ktJdB6JS6KKBKdZ
	/IwccqsgXN9z4LCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BB85A134E8;
	Fri, 27 Nov 2026 17:36:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id iDoHJJ+/CWvxFAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Fri, 27 Nov 2026 17:36:31 +0000
Date: Fri, 27 Nov 2026 18:36:31 +0100
Message-ID: <87a4mumb1c.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Masanori Suto <suto@geek-masa.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>,
	"londongrad@gmail.com" <londongrad@gmail.com>,
	"xmei5@asu.edu" <xmei5@asu.edu>,
	"clemens@ladisch.de" <clemens@ladisch.de>,
	"perex@perex.cz" <perex@perex.cz>,
	"linux-sound@vger.kernel.org" <linux-sound@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: Re: [PATCH] ALSA: ua101: clamp playback packet sizes instead of rejecting UA-1000
In-Reply-To: <010101a21bc150d7-627da1ea-4ebf-499d-9ae0-edf88db3e063-000000@us-west-2.amazonses.com>
References: <CANd6TdKdRftWyo5Cg_85-fBVGW3oHAntEY-DdCpQCDSyRpOprw@mail.gmail.com>
	<20261127064615.40817-1-suto@geek-masa.com>
	<010101a21bc150d7-627da1ea-4ebf-499d-9ae0-edf88db3e063-000000@us-west-2.amazonses.com>
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
X-Rspamd-Queue-Id: 237FC1F7F2
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
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.de,gmail.com,asu.edu,ladisch.de,perex.cz,vger.kernel.org,lists.linux.dev];
	DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,linuxmusicians.com:url,geek-masa.com:email]
X-Spam-Score: -12.51

On Fri, 27 Nov 2026 07:46:23 +0100,
Masanori Suto wrote:
> 
> Commit 86f86e6fdedc ("ALSA: ua101: reject mismatched capture/playback
> packet sizes") rejects a device at probe time when a capture packet of
> wMaxPacketSize bytes would carry more frames than fit into a playback
> packet.  It assumed that genuine hardware declares proportional packet
> sizes, but the UA-1000 does not:
> 
>   capture  EP 0x81: 12 ch x 4 bytes, wMaxPacketSize 720 -> 15 frames
>   playback EP 0x02: 10 ch x 4 bytes, wMaxPacketSize 560 -> 14 frames
> 
> so the UA-1000 now fails to probe with
> 
>   playback packet size 560 too small for 15 capture frames
> 
> In practice the device sends about rate/8000 frames per packet at high
> speed (6 at 48 kHz, 12 at 96 kHz), which always fits the playback
> packet.
> 
> The out-of-bounds write has a single source: capture_urb_complete()
> stores the received frame count in rate_feedback[], and both
> start_usb_playback() and playback_work() take their packet sizes only
> from that FIFO.  Clamp the value there to what fits into one playback
> packet, so the playback URB buffer cannot be overrun whatever the
> descriptors say, and relax the probe check to require only that one
> packet at the nominal rate fits.
> 
> Tested on a UA-1000 (0582:0044): the device probes again, and playback
> and capture both work.
> 
> Fixes: 86f86e6fdedc ("ALSA: ua101: reject mismatched capture/playback packet sizes")
> Cc: stable@vger.kernel.org
> Reported-by: London grad <londongrad@gmail.com>
> Closes: https://lore.kernel.org/all/CANd6Td+b6ituLFzkhvX09vricCY541fQapNOk3rTa=74zWA5LA@mail.gmail.com/
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=222261
> Signed-off-by: Suto, Masanori <suto@geek-masa.com>
> ---
> Hi Takashi,
> 
> To answer your question earlier in this thread: on my UA-1000
> (0582:0044, bcdDevice 1.07), reverting 86f86e6fdedc alone makes the
> device work again. It is registered in /proc/asound/cards, and playback
> and capture both work. Without the revert it fails to probe with
> "playback packet size 560 too small for 15 capture frames", as in the
> earlier report. So the commit is confirmed as the cause.
> 
> A plain revert would reopen CVE-2026-98741, so this patch keeps the
> protection by clamping the packet size where it is produced instead of
> rejecting the device. With this patch applied, playback and capture also
> both work. Tested on linux-zen 7.3.6-zen1; sound/usb/misc/ua101.c there
> is identical to mainline.
> 
> To check that the 15-frame worst case does not happen on real hardware,
> I captured the isochronous traffic with usbmon: 60 s of simultaneous
> playback and capture at each rate the UA-1000 supports, about 480000
> packets each. Frames per packet, from the actual capture length
> (EP 0x81) and the submitted playback length (EP 0x02):
> 
>   rate       capture frames per packet           max
>   44.1 kHz    5: 48.76%   6: 51.24%                6
>   48 kHz      5:  1.14%   6: 97.74%   7: 1.12%     7
>   88.2 kHz   10:  1.04%  11: 95.45%  12: 3.52%    12
>   96 kHz     11:  0.08%  12: 99.86%  13: 0.06%    13
> 
> Playback used exactly the same distribution at every rate. The maximum
> is 13 frames at 96 kHz, which fits the 14-frame playback packet. The
> 15 frames assumed from wMaxPacketSize never occur: the device stays
> within one frame of rate/8000. The clamp warning added by this patch
> never appeared in the kernel log during these runs.
> 
> The same breakage was also reported on LinuxMusicians:
> https://linuxmusicians.com/viewtopic.php?p=189180
> 
> #regzbot ^introduced: 86f86e6fdedc

Applied now.  Thanks.


Takashi
