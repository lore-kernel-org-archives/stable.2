Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A5A30568B;
	Tue, 22 Sep 2026 05:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790056149; cv=none; b=kVTt81hvdbHBlmZ3focQPL3MfIaWfLBBxou9KLy+dgSarL1Ft2KXySjSf5o2w7l4o+cHZUXlQXlpddfRkjN/A38DE0ySEQKEMGW8M4OsFoCFOaY6dDQm8TxO85Y/q23f/z0bDnAVr3/Z8GPFU0HnXcVdPNWB6o0JJ13EtipiTzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790056149; c=relaxed/simple;
	bh=rsi1UYhlwL0IRMGewvmaBWPdRFDdAAGxobftKp9hJb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=co8VeDVSP8YPwfM0ruxs0AzuDS74ZwUG7H1owYp+ngbxp8eKDhcehnzvckYHbHwNrCeR+h4txmrGGqyLkSyBW9kvzg+UcWtjSyzklsc5Uc0cB1riYFnWJHh+dosUOylwawAbTCBVoTNnWhzU9dzRTfi4qAMKF2E342B6hJuK2qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cYJAACZ4; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=iUt/cfEs; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=1sK17876; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=gI0/JnvD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cYJAACZ4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iUt/cfEs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1sK17876";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gI0/JnvD"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3B01321B01;
	Tue, 22 Sep 2026 05:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790056137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rpjf0C6MDmDa1rDAe8T9fb2JVI5664QOqqPh8p264Ac=;
	b=cYJAACZ4mfkerIAzlp0Z0/uqPaIsj9SSezU22kMWTDKev0vXDN5SJg25NOOcWIhx8RVkLP
	YygCl9AECnK+1N7M19NjJFueYEwuIK6C4up+mi88hEB9v7HE56sIdXqIZl3/LT6rTeLmWK
	pJL0xe7TOGfotIBDsWC9cgmd9Uou4Jw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790056137;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rpjf0C6MDmDa1rDAe8T9fb2JVI5664QOqqPh8p264Ac=;
	b=iUt/cfEsPOtxeABp2BolOdKl16fgeAOaH02gFM3HUW3tRmBqujIiBx9+AnMy00vSeloXIT
	PS69C6Qt4XfUrGDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1sK17876;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="gI0/JnvD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790056133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rpjf0C6MDmDa1rDAe8T9fb2JVI5664QOqqPh8p264Ac=;
	b=1sK17876ngU9s05FR7T1z0nCo7g/2r/whD5g9BQXH8gZcPLJB096xCPF3p0F9xH4AD7NoR
	c2kpM/1fqBPjivi1NHKPRbHYQCfXnpFOuVz1YCzNiu7/s1x/lMHx/4T2N8Eq06PW2v1E0U
	Fbk0It5vzjZ31aAyulPkHM1EsxFxw8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790056133;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rpjf0C6MDmDa1rDAe8T9fb2JVI5664QOqqPh8p264Ac=;
	b=gI0/JnvD0j/4j7x5exB9zg7SsCGE1F1hwIrN8aummr00DIDbxhfmsjzTuty7C0ORY9e3U/
	5mbXRZpabDViMtCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C38BA136D9;
	Tue, 22 Sep 2026 05:48:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Wq4/H8QWsmoUdAAAD6G6ig
	(envelope-from <hare@suse.de>); Tue, 22 Sep 2026 05:48:52 +0000
Message-ID: <d415d07b-023c-4dcb-92f3-2eb2f7159341@suse.de>
Date: Tue, 22 Sep 2026 07:48:52 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] blk-mq: set RQF_USE_SCHED when the operation is known
To: Keith Busch <kbusch@meta.com>, axboe@kernel.dk,
 linux-block@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>, stable@vger.kernel.org,
 Henry Hu <huhai@kylinos.cn>
References: <20260921212624.1942234-1-kbusch@meta.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260921212624.1942234-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 3B01321B01
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+]
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 9/21/26 11:26 PM, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> The cached requests are allocated for one operation but can be handed
> out for another. A passthrough command has RQF_USE_SCHED cleared, so
> using those flags for a subsequent read/write bio will insert it into
> the scheduler without ->prepare_request() and frees it without
> ->finish_request(). For kyber, this leaks the domain token acquired at
> dispatch and stalls the queue.
> 
> Don't set RQF_USE_SCHED based on the first operation the batch happened
> to be allocated for. Instead, set it after the request is claimed by an
> operation.
> 
> Fixes: 4b6a5d9cea91 ("block: enable batched allocation for blk_mq_alloc_request()")
> Cc: stable@vger.kernel.org
> Reported-by: Henry Hu <huhai@kylinos.cn>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>   block/blk-mq.c | 51 +++++++++++++++++++++++++++++---------------------
>   1 file changed, 30 insertions(+), 21 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
