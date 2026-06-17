Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2812F6920
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 18:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781721662; cv=none; b=an8KD1wiyDb4ICo12kqdrXmvUodWDTYtoVbq/klXclQYP4xxkYT3X0++P4ZBYCfDwz+qVCSIhQxA0TpuHo46h4VYz0OTdGE0+kbGdpjm48/lrM97yOehCmlI23GiqwsE2ck5T8BwRfFkeDhus+lTokaSApmpQRdpdL4s0bCOXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781721662; c=relaxed/simple;
	bh=sHFBc5RzYGiZ/Y9cGYkZBnDpqDecWaZRKLQm93DNmF8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GTVeVXcRu04wmCZeCh/nHYBFgIq8W2tbsQylNb9WNMrPxzDvMJeWpu5ouVh6iAVkPE71HBm2r5pSxs0rF/WmmVydMYXT5wjaCj210h7lzRCLy5LrkSy3yseD+7c+Oj8/5jfpybspCGf3mbuaUyNLmV7hxoJ8wbhI+ZGZIoP1gGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cLmMSbjr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hQFvr5xF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cLmMSbjr; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=hQFvr5xF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cLmMSbjr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hQFvr5xF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cLmMSbjr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="hQFvr5xF"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 52BF875E83;
	Wed, 17 Jun 2026 18:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781721658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EZbq6J0hSGr8udLOZpoMOaG0budeZVJWDyq3+j2KID0=;
	b=cLmMSbjr6y5+Osu23p3SM3Jy9GoYUH0DIhVs6FH0vRxGmfKNOXe+JkE5AsP1Y3UQgW5i8E
	FP9ztmDQ9AesZlzhz4zDK1sZPUvt9X0wlFfdIk6UBVyZjeEVbq4ZSatZC9hgCijhscgUbc
	y8oU6hRgELa71fJOsLDzLiOue55HZvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781721658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EZbq6J0hSGr8udLOZpoMOaG0budeZVJWDyq3+j2KID0=;
	b=hQFvr5xFOFqH/WFTX45SGMrIBW8CRm+529NubsHnOPzRsgMLmIzLSmGOnO5SEPJZDPTBQW
	gkISzLpTab85aBCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1781721658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EZbq6J0hSGr8udLOZpoMOaG0budeZVJWDyq3+j2KID0=;
	b=cLmMSbjr6y5+Osu23p3SM3Jy9GoYUH0DIhVs6FH0vRxGmfKNOXe+JkE5AsP1Y3UQgW5i8E
	FP9ztmDQ9AesZlzhz4zDK1sZPUvt9X0wlFfdIk6UBVyZjeEVbq4ZSatZC9hgCijhscgUbc
	y8oU6hRgELa71fJOsLDzLiOue55HZvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1781721658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EZbq6J0hSGr8udLOZpoMOaG0budeZVJWDyq3+j2KID0=;
	b=hQFvr5xFOFqH/WFTX45SGMrIBW8CRm+529NubsHnOPzRsgMLmIzLSmGOnO5SEPJZDPTBQW
	gkISzLpTab85aBCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 155A2779A8;
	Wed, 17 Jun 2026 18:40:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id P76GNTnqMmpuGwAAD6G6ig
	(envelope-from <krisman@suse.de>); Wed, 17 Jun 2026 18:40:57 +0000
From: Gabriel Krisman Bertazi <krisman@suse.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, io-uring@vger.kernel.org, Jens Axboe
 <axboe@kernel.dk>
Subject: Re: [PATCH stable-6.18.y] io_uring/net: Avoid msghdr on
 op_connect/op_bind async data
In-Reply-To: <2026061727-thirsty-sculptor-1e6f@gregkh>
References: <20260617175102.2976716-1-krisman@suse.de>
 <2026061727-thirsty-sculptor-1e6f@gregkh>
Date: Wed, 17 Jun 2026 14:40:56 -0400
Message-ID: <87zf0tdn7r.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,linuxfoundation.org:email]
X-Spam-Level: 
X-Spam-Score: -4.30

Greg KH <gregkh@linuxfoundation.org> writes:

> On Wed, Jun 17, 2026 at 01:51:02PM -0400, Gabriel Krisman Bertazi wrote:
>> [ Upstream commit 3979840cd858f30f43ea9f4e7f7f1f56de82d698 ]
>> This fixes a memory leak due to the lack of the cleanup hook for the
>> iovec.  The stable backport differs from upstream by dropping the
>> io_connect_bpf_populate hunk, which didn't exist at the time and by
>> fixing the merge conflict due to the introduction of
>> io_bind_file_create.
>> 
>> Both IORING_OP_CONNECT and IORING_OP_BIND reuse the msghdr object just
>> to store the sockaddr. Beyond allocating a much larger object than
>> needed, msghdr can also wrap an iovec, which will be recycled
>> unnecessarily. This uses the sockaddr directly.
>> 
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
>> Link: https://patch.msgid.link/20260602215327.1885109-2-krisman@suse.de
>> Signed-off-by: Jens Axboe <axboe@kernel.dk>
>> Signed-off-by: Gabriel Krisman Bertazi <krisman@suse.de>
>> ---
>>  io_uring/net.c   | 36 ++++++++++++++++++------------------
>>  io_uring/opdef.c |  4 ++--
>>  2 files changed, 20 insertions(+), 20 deletions(-)
>
> This isn't in any release yet?

It is queued in Linus tree during the current merge window for 7.2

>  why just 6.18?

The backports are slightly different, so they were sent separately. The bug
exists since 6.12.

> And why wan't it
> originally tagged for stable?

Because it was originally a clean up that we later realized fixes a bug
and should go to stable.

> thanks,
>
> greg k-h

-- 
Gabriel Krisman Bertazi
