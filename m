Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705851;
	b=tPWXEaLqDH+m2fHXg3XNr9b/km85IRqwiiUqROVKtXYgZzDOUwyvQnWxzo3Vl308Qafr
	 f1FWcgF7FQrtx8q/iH9RaMZaVefvT5MyH/ssskPJ55r2r10HpRUsrYa5AXYTAAN6/ThXT
	 3haL1ax4c1xEReg4MxKJbDx1SroRq+APaxz2Yr0DDar440sfYWUC9vH1+qYIc91YqogdU
	 pJRzMQrpwc9jizmCjtTp/lyoI2DHQ9IWrLoBwsjVTtKO+5mZnUACZB5xVK6hKOc5Pqm2b
	 rAJdtKEiA1LkcJnkX/cEkS18suSsIc2MnLRkOIXHq8QYyfSn3PZeXvK8Hkbn9kFYF2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705851;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=B8j92hybFHQnaobaSpqwDPNDEjwRDPEUTD3UMs1Ts1w=;
	b=Cp7/SKiOcIflvWjV0ZGapUNLDux9CEJnLBtmpovE7WdovR73v6IN7HcBrUCazapYjO8v
	 BYr4gge5OUyJc3cXD5L71f5FwtkPZuSwqZuesiTRMltOa7/iLmeyeYnSXbBL8/pqWpqnJ
	 b4HTMI4BhOigcF9fyfqbvQjUPtkGXNt00bKwhbOyJvGk7TChPY0iO6AeJIsstg8rHFPpz
	 oq/ozUICjjrg3pDWmfITNgKxJblO8jdnriAMfDSAhZB7wm6aeGv3r077e9zRptUDCLyRv
	 86Lhy0c46UDHgJVfF7pqIxAHnoj74/3AvUM/8mo3M2ssKrAupupjDXLubdPLm8XRTfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=suse.cz;
	spf=pass smtp.mailfrom=suse.cz;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=AdMzsJd7;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qcuNXjir;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GPTxdliW;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BlsmKnRq;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45D460A2604
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 11:37:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B45D460A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=AdMzsJd7;
	dkim=pass header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=qcuNXjir;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=GPTxdliW;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=BlsmKnRq
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A7D3F228C8;
	Tue,  3 Nov 2026 11:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793705841; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B8j92hybFHQnaobaSpqwDPNDEjwRDPEUTD3UMs1Ts1w=;
	b=AdMzsJd7BTY1vMsvqPR1dY9+mcRnzNWajy0kmkYRQEDKHdjhVio/T61M9GlgCzvLc2SjQT
	opQiXlZcjdzrewnfzyNOSmhKe3fEJCNm2CJR2MPJSkbMYy05XreC5GmkxHsSpCfuh4RivM
	ccx5lMgD7hdu+vND+5RtJj0V323s0RI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793705841;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B8j92hybFHQnaobaSpqwDPNDEjwRDPEUTD3UMs1Ts1w=;
	b=qcuNXjirl4sgQyWfrimO9Uiw/TkfsMyjRKQ8ES5My4BDC4QsJuHJn7nVzzgJVgTAXNQtPi
	/4yMJMyp8nzeV5Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1793705840; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B8j92hybFHQnaobaSpqwDPNDEjwRDPEUTD3UMs1Ts1w=;
	b=GPTxdliWplSou1ClLnj2+Kfxwhbs1yPVbkxdcZkH44iyO7j/mdIVSM/Zc6IqLbo3APNR7K
	9kJ0X/A1wcYubFjiTV9pPg//ggQvnKOTKsZMFQV4qg3sF6kFR7gGWaD87mYimrmRWXgnWI
	sZCyM+Kc+Dx1ofGpsb3T+D006P3pHtI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1793705840;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B8j92hybFHQnaobaSpqwDPNDEjwRDPEUTD3UMs1Ts1w=;
	b=BlsmKnRqvkggekSHbDTtA63/yU0kV24/p+9munsk0xIYPcfcDGJeON3oKkbosTyMbug0X3
	/i5mu7+V43IDdNAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72F4C134B8;
	Tue,  3 Nov 2026 11:37:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mg2HE3DH6WqiSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 03 Nov 2026 11:37:20 +0000
Received: by quack.suse.cz (Postfix, from userid 1000)
	id 02D42B231; Tue, 03 Nov 2026 12:37:15 +0100 (CET)
Date: Tue, 3 Nov 2026 12:37:15 +0100
From: Jan Kara <jack@suse.cz>
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: Kiryl Shutsemau <kas@kernel.org>, Jan Kara <jack@suse.cz>, 
	willy@infradead.org, hughd@google.com, baolin.wang@linux.alibaba.com, 
	akpm@linux-foundation.org, dave.hansen@linux.intel.com, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] shmem: do not extend i_size when no data was copied
Message-ID: <rfvf7awrww55bg3hwq4edbz2ioorodlrb3wcmf45wcrof22cda@yduswvswhz2c>
References: <20261025164619.89992-1-dennylin0707@gmail.com>
 <at9xXRhD2xZhszEj@thinkstation>
 <xmp7ni65vbinfj4j2baisrhp6xzro3asbepuq7xp3mvx6maptn@r4dnoj63uw4t>
 <at-XtWBQg3jv3H8Z@thinkstation>
 <CAGEkeHfq1xZf_jMw9a9cz3iunj6O3UZ4-=iW-65aN2Ss0oT3Uw@mail.gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGEkeHfq1xZf_jMw9a9cz3iunj6O3UZ4-=iW-65aN2Ss0oT3Uw@mail.gmail.com>
X-Spamd-Result: default: False [-12.80 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.80
X-Spam-Level: 
X-Spam-Flag: NO

On Tue 03-11-26 02:34:11, Hungyu Lin wrote:
> On Mon, Oct 26, 2026 at 06:18:39PM +0000, Kiryl Shutsemau wrote:
> > The per-filesystem alternative is a 'copied &&' in every ->write_end.
> 
> Would it make sense to keep this fix local to shmem for now?
> I'll check the folio handling before sending v2.

The trouble is that practically any filesystem is going to have these
issues with 0-length writes starting beyond i_size. So if we can fix it in
generic code, it would be certainly easier in the grand scheme of things.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
