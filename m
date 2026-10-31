Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793461255;
	b=RRYM2iXoRyig4a8vmRlJvOGLZSLz/WoH3mWAmLKJZJloe0uKyL13oyK/tdnEhXg0E1xh
	 1C52cXDGxcbTc3p3F/cXGH3WRA8slfsA/u9mqPRr9N7UXX64MVztg9YXsEY/3Tv/pDzfR
	 /NwZQcbYW3XwpySYyWoI0z9lKChEOMpDbBs5KHquesQwj0XhaNtSElZYpHPN6siwJcrEb
	 +3rY8S0ZlmbwdlJT9zQup6PdfD1XfsKTYcbylnsrx4Y+7U0QKnbsI4Y28PHcpen4O6r/8
	 pm82MZ6okcnaF2nPJBmxGEbyEXjtNCKBjUxjoCYVAr4U6wdxQZmiQi7UrWFuYfHTONw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793461255;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spam-Flag:X-Spam-Level:X-Spamd-Result:X-Spam-Score;
	bh=CsK5bbyfWnRdHAqi1RutUHwbjlRIkNgypFmmy6Jqm1E=;
	b=XjtTh5sfztwrSNl7sW8b5kSUZvjoj3QvjJEMLIxAk3kbJx09qPtLmpMUzC6xYJVXBWel
	 Zky1AI4BCiT+fADIGxwLOegvaqpiEuogZF1UqZjUncrTZTbMQupbhVFVNeWNA+1bq3NWw
	 91xAhcJ3farcJA94GFo2N0VhQwu38uZQcAcKtpL+EpKC/JRXBLz/seqANh8utTvRfe7zT
	 jZAightftqdZWJJAhunwZXBZXXY1YvwMj+Ehm39T2LN0LjuOuTPjL0u5ameeht663Hk5/
	 jFjxJ94yBKNPQ1dsTLLKhz5XuaZ7SGpQGo3fEoVfgOc0T1w6omLcJZnYdoKXUxArC2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Nq0Xq55M;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pcsBDwKZ;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Nq0Xq55M;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pcsBDwKZ;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D6D606A31A;
	Sat, 31 Oct 2026 15:40:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41D6D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Nq0Xq55M;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pcsBDwKZ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Nq0Xq55M;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=pcsBDwKZ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5B91F22214;
	Sat, 31 Oct 2026 15:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793461247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsK5bbyfWnRdHAqi1RutUHwbjlRIkNgypFmmy6Jqm1E=;
	b=Nq0Xq55MfTAEo5NTNbSxegrrO75dEkL2MUjPci6/dHvJ2V13WZT/jsPibBBBdQY6ZX3yNR
	Yv8D0GpNyG++kidS18E6b/VEI1alXpPAkB4UhfH9csU+AK4oFjOsjNIndm4ZnWboLL9QXQ
	DmP93lPG+uNQwGBbwPpcZuo5E7kISz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793461247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsK5bbyfWnRdHAqi1RutUHwbjlRIkNgypFmmy6Jqm1E=;
	b=pcsBDwKZoqxmN16o70v7zrQ2JRUpSwDozh2TB4DEKbfXPE5ddHacoL86XhX8R1s4u9KNEc
	C6KYE98vx4DG6rAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793461247; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsK5bbyfWnRdHAqi1RutUHwbjlRIkNgypFmmy6Jqm1E=;
	b=Nq0Xq55MfTAEo5NTNbSxegrrO75dEkL2MUjPci6/dHvJ2V13WZT/jsPibBBBdQY6ZX3yNR
	Yv8D0GpNyG++kidS18E6b/VEI1alXpPAkB4UhfH9csU+AK4oFjOsjNIndm4ZnWboLL9QXQ
	DmP93lPG+uNQwGBbwPpcZuo5E7kISz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793461247;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CsK5bbyfWnRdHAqi1RutUHwbjlRIkNgypFmmy6Jqm1E=;
	b=pcsBDwKZoqxmN16o70v7zrQ2JRUpSwDozh2TB4DEKbfXPE5ddHacoL86XhX8R1s4u9KNEc
	C6KYE98vx4DG6rAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 01BEE13432;
	Sat, 31 Oct 2026 15:40:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /tfYMv4L5monGgAAD6G6ig
	(envelope-from <tiwai@suse.de>); Sat, 31 Oct 2026 15:40:46 +0000
Date: Sat, 31 Oct 2026 16:40:46 +0100
Message-ID: <87bj89swsh.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: YuanZhe Liu <25031212351@stu.xidian.edu.cn>
Cc: Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Bin Yu <byu@xidian.edu.cn>,
	Cheng Wen <wencheng@xidian.edu.cn>
Subject: Re: [PATCH] ALSA: us122l: Add missing NULL check in usb_stream_hwdep_mmap()
In-Reply-To: <20261028042525.8737-1-25031212351@stu.xidian.edu.cn>
References: <20261028042525.8737-1-25031212351@stu.xidian.edu.cn>
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30

On Wed, 28 Oct 2026 05:25:25 +0100,
YuanZhe Liu wrote:
> 
> usb_stream_hwdep_mmap() reads us122l->sk.s and dereferences it without
> checking for NULL.  The stream object is released by usb_stream_free(),
> which is reached through us122l_stop() both when the device is
> disconnected and when us122l_start() fails, and it leaves us122l->sk.s
> set to NULL.  The hwdep file stays usable after that, so a later mmap()
> 
> 	KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
> 	RIP: 0010:usb_stream_hwdep_mmap+0x107/0x890 sound/usb/usx2y/us122l.c:182
> 
> crashes while reading s->read_size, which sits at offset 0x10.
> 
> That NULL is an expected state for this field: usb_stream_hwdep_vm_fault(),
> usb_stream_hwdep_poll(), usb_stream_hwdep_ioctl(), usb_stream_stop() and
> usb_stream_free() all test it before use.  Only the mmap callback misses
> the check, so let it return -ENODEV, matching what the other hwdep mapping
> in usx2yhwdeppcm.c does when its shared buffer has not been allocated.
> 
> Fixes: 030a07e441296c372f946cd4065b5d831d8dc40c ("ALSA: Add USB US122L driver")
> Cc: stable@vger.kernel.org
> Co-developed-by: Bin Yu <byu@xidian.edu.cn>
> Signed-off-by: Bin Yu <byu@xidian.edu.cn>
> Co-developed-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: Cheng Wen <wencheng@xidian.edu.cn>
> Signed-off-by: YuanZhe Liu <25031212351@stu.xidian.edu.cn>

Applied now.  Thanks.

(I've been traveling in the last few days, sorry for the delay.)


Takashi
