Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F074AB1A3;
	Thu, 10 Sep 2026 16:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789056510; cv=none; b=IhWmtJodWH8NqjxB/aZPOp5Ix7dYqamS7z9ZXtJv9bi7MUEqERqYGNK/K7snax1a5wFTl75G01+bIN5GEXS3CFgwJgZAgTV1vMCVISqcdB51S+o5ns6LzzTmvl0ZexofHA2w/WJjpHo/Eej9Ojv5K/8ruOYnfkg6a+jSVQ3tB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789056510; c=relaxed/simple;
	bh=zyFacImy6dVsY8eSfeNz3dqxONfRK7TdrWM8Y6tilCA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iARfSEJzw9FxueLZU2lN3saUguYOwY50SS+SILpxbByVWNOllaoYqcVHUn5aoZULdIiRYOfmjhaeT3Q5bGV15k/pi/r70rdcixhfxscB+qcHaSnMMQH6EW6k/UILSGsuuAvoz7u7+8NGat+g8b6YmPU48cJHKXNI2xlIckmAu3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=BUwxsHGo; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=KdFv8eb5; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=O5s54NKK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bJUKOY3t; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="BUwxsHGo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KdFv8eb5";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O5s54NKK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bJUKOY3t"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0997F21DA0;
	Thu, 10 Sep 2026 16:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789056503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0FU/zfc7RTWvPZ5sCPnZppWS8jymqeQRKXPAX0nmCrA=;
	b=BUwxsHGoxkKXQkkm1a06javwncYKKdiJuWhCEJMelXpWe3K9i74t1j3fRkH70lsynfIdaM
	hc6/QxNGowwZA4HPC9iqg/VqkM2EYvYVVQVFdSmjqT0NpTHb2XqWFItsO4dY7T2u+QGJzQ
	DHhwbVi9/rSghaTKj7b7pGY4wHCJjsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789056503;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0FU/zfc7RTWvPZ5sCPnZppWS8jymqeQRKXPAX0nmCrA=;
	b=KdFv8eb5SIhR6BWWzpyU66s0fYLv7+XSdt5sz/71xtNyjMFHqDhLS7VEKxmCi8RyHRKlYl
	WGIZgERN2NzvEhDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=O5s54NKK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=bJUKOY3t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1789056499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0FU/zfc7RTWvPZ5sCPnZppWS8jymqeQRKXPAX0nmCrA=;
	b=O5s54NKKrCRsTS/UylFaE4WtqIlspl0J7U7a0oTnhWUDBC9CrKfn/QM48Mc2ar3R4t0oGO
	Vc3xYKNlyoGmNLC7GusohPysVGv1ZC+RIr2LJstrCHL+u19yYtutwPT8ENm1q3MH01ebpY
	JC0eaWCut2QnxYv712ZQWcQZmIiQQYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1789056499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0FU/zfc7RTWvPZ5sCPnZppWS8jymqeQRKXPAX0nmCrA=;
	b=bJUKOY3t//KxaT5s7v532mwSfyOoMfcqODUIY2Ih+GFFSlvdqnHjKURQdZspGRW8e7gsi5
	Wr5zpIoPS2cogEDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 536311326D;
	Thu, 10 Sep 2026 16:08:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9IGuAvLVomqBOgAAD6G6ig
	(envelope-from <krisman@suse.de>); Thu, 10 Sep 2026 16:08:18 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: io-uring@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] io_uring/net: don't overconsume buffers when using
 MSG_TRUNC
In-Reply-To: <0f5e8693-dcba-4fa8-87d1-570ac08e2d83@kernel.dk>
Organization: SUSE
References: <20260902230041.1320658-1-krisman@suse.de>
 <20260902230041.1320658-3-krisman@suse.de>
 <0f5e8693-dcba-4fa8-87d1-570ac08e2d83@kernel.dk>
Date: Thu, 10 Sep 2026 13:08:15 -0300
Message-ID: <87a4pp2iog.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 0997F21DA0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	HAS_ORG_HEADER(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,mailhost.krisman.be:mid,suse.de:dkim,suse.de:email,kernel.dk:email];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:email,msgid.link:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,kernel.dk:email,mailhost.krisman.be:mid];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO

Jens Axboe <axboe@kernel.dk> writes:

>> When a recv/recvmsg is issued with MSG_TRUNC and the incoming packet is
>> larger than the provided buffer, the net layer returns the full length
>> of the packet rather than the number of bytes actually copied into the
>> buffer.  As a result, io_uring advances more of the provided buffer ring
>> than was actually filled.  Use the actual filled region size to consume
>> the buffer, but still return the full size to preserve MSG_TRUNC
>> semantics.
>>
>> Take care with multishot, because that seems to already truncate the
>> consumption based on the available payload size.
>>
>> This was reported in https://github.com/axboe/liburing/issues/1619.
>>
>> Fixes: ae98dbf43d75 ("io_uring/kbuf: add support for incremental buffer consumption")
>> Cc: stable@vger.kernel.org
>> Link: https://patch.msgid.link/20260728191454.1850326-1-krisman@suse.de
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
>> ---
>>  io_uring/net.c | 38 +++++++++++++++++++++++++++++++-------
>>  1 file changed, 31 insertions(+), 7 deletions(-)
>>
>> diff --git a/io_uring/net.c b/io_uring/net.c
>> index 647156c9331a..f8110dc9f860 100644
>> --- a/io_uring/net.c
>> +++ b/io_uring/net.c
>> @@ -853,7 +853,7 @@ int io_recvmsg_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
>>  static inline bool io_recv_finish(struct io_kiocb *req,
>>                                   struct io_async_msghdr *kmsg,
>>                                   struct io_br_sel *sel, bool mshot_finished,
>> -                                 unsigned issue_flags)
>> +                                 unsigned issue_flags, size_t consumed)
>>  {
>
> Not sure this is correct. If consumed is a size_t, then the comparison
> between ret > len is an unsigned comparison, and every error will then
> get clamped?
>
> Will need something like this folded in.

Indeed. thanks for catching it.

I'm folding your fix up in the v3, modulo a compilation error.  It only
changes the error path, the bug is still fixed on 7.3 with your patch
folded in.  Any suggestions on how to test this error path for liburing?
I got a test for the bug, but testing ret<0 means failing the socket.


-- 
Gabriel Krisman Bertazi
