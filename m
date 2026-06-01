Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC4D3043C9
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 07:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780297568; cv=none; b=CBjjV/SQXiSshnSx7bk2uFpjHnPvpq31bFshrFMHrmXWSmoiwCj+3vlFkZIprRDBAICV9HBkj0Ag79cQ8NC5qhWVbQIyuH2w19qHx5TPOUYRL83glpuvCmVcj6Sg0gvKP7LzRy6UBvcotfyYy3aH8YoVIp+7LbxP3cMG5vd9t/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780297568; c=relaxed/simple;
	bh=/KXv5NUj94usQ0ZgycG2iLencI22+GtcIGoB/xGqHWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qb/EHCzJRrNeycfb/pN+ZN8leqsHyk4+xoa4S2BsZz6JN9PdYp+BqmLK1o2qKL500pnRF4JTcmCrXGsfMGHe2C8yjuSZnIkrH0KPLtGFG3qiQynnCxGCvcBbb6nV+kIMpZkVhQ3xzC4zhbnd1x0T2aoAQcrYHv49407oItuA3o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LQOa8Rbz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wyqd/6lW; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LQOa8Rbz; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Wyqd/6lW; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LQOa8Rbz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wyqd/6lW";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LQOa8Rbz";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Wyqd/6lW"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4ACB5680E7;
	Mon,  1 Jun 2026 07:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780297565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLr13s06hU3qP4KBbqLKv5ZBYcMx0rBcU2SLhQd5AS8=;
	b=LQOa8RbzikrUArXOBNmvQepTY8wJAFYirLAjL0USvvHt7mRXnbAk+Y0mOlIF252CtX+G1w
	CbZqNQvJe9PGdjyRU6CHZZ9FVetskHJxHlEopHLOh1YrDtr4w8gaOaIS6jNzfCb4mnLrUl
	d+QzfuoQ9+7Ual5gP4E0nBIF2KG02es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780297565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLr13s06hU3qP4KBbqLKv5ZBYcMx0rBcU2SLhQd5AS8=;
	b=Wyqd/6lWiDN6IRH/SOjJV838JvCTndplCc880iAs3InuDLdN1dEaRLCCC1WjcTcmM785Ht
	d3PlTtJ6rpaVFeDg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LQOa8Rbz;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Wyqd/6lW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1780297565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLr13s06hU3qP4KBbqLKv5ZBYcMx0rBcU2SLhQd5AS8=;
	b=LQOa8RbzikrUArXOBNmvQepTY8wJAFYirLAjL0USvvHt7mRXnbAk+Y0mOlIF252CtX+G1w
	CbZqNQvJe9PGdjyRU6CHZZ9FVetskHJxHlEopHLOh1YrDtr4w8gaOaIS6jNzfCb4mnLrUl
	d+QzfuoQ9+7Ual5gP4E0nBIF2KG02es=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1780297565;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BLr13s06hU3qP4KBbqLKv5ZBYcMx0rBcU2SLhQd5AS8=;
	b=Wyqd/6lWiDN6IRH/SOjJV838JvCTndplCc880iAs3InuDLdN1dEaRLCCC1WjcTcmM785Ht
	d3PlTtJ6rpaVFeDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F027A779A7;
	Mon,  1 Jun 2026 07:06:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cXqkOFwvHWqGPgAAD6G6ig
	(envelope-from <hare@suse.de>); Mon, 01 Jun 2026 07:06:04 +0000
Message-ID: <b83d888f-f905-4744-bf40-f4b8879f5cdb@suse.de>
Date: Mon, 1 Jun 2026 09:06:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] nvme-multipath: set BIO_REMAPPED on bios remapped to
 per-path namespace disks
To: "Achkinazi, Igor" <Igor.Achkinazi@dell.com>,
 "kbusch@kernel.org" <kbusch@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "sagi@grimberg.me" <sagi@grimberg.me>, "axboe@kernel.dk" <axboe@kernel.dk>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <MW5PR19MB548483D1FAE4F322E4C97352FD032@MW5PR19MB5484.namprd19.prod.outlook.com>
 <DS0PR19MB76963295FC34844B413479F9FD092@DS0PR19MB7696.namprd19.prod.outlook.com>
 <b8d1fda2-a2da-4b35-9bd5-941834f26c32@suse.de>
 <DS0PR19MB7696FD43E37F19A597121212FD172@DS0PR19MB7696.namprd19.prod.outlook.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <DS0PR19MB7696FD43E37F19A597121212FD172@DS0PR19MB7696.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4ACB5680E7
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -4.51

On 5/30/26 16:34, Achkinazi, Igor wrote:
> Hannes Reinecke wrote:
>> ... or you could introduce __bio_set_dev():
>>
>> diff --git a/include/linux/bio.h b/include/linux/bio.h
>> index 97d747320b35..5a2709adeea7 100644
>> --- a/include/linux/bio.h
>> +++ b/include/linux/bio.h
>> @@ -518,15 +518,20 @@ static inline void blkcg_punt_bio_submit(struct
>> bio *bio)
>>    }
>>    #endif /* CONFIG_BLK_CGROUP */
>>
>> -static inline void bio_set_dev(struct bio *bio, struct block_device *bdev)
>> +static inline void __bio_set_dev(struct bio *bio, struct block_device
>> *bdev)
>>    {
>> -       bio_clear_flag(bio, BIO_REMAPPED);
>>           if (bio->bi_bdev != bdev)
>>                   bio_clear_flag(bio, BIO_BPS_THROTTLED);
>>           bio->bi_bdev = bdev;
>>           bio_associate_blkg(bio);
>>    }
>>
>> +static inline void bio_set_dev(struct bio *bio, struct block_device *bdev)
>> +{
>> +       bio_clear_flag(bio, BIO_REMAPPED);
>> +       __bio_set_dev(bio, bdev);
>> +}
>> +
>>    /*
>>     * BIO list management for use by remapping drivers (e.g. DM or MD)
>> and loop.
>>     *
>>
>> to avoid all this clear-and-set-flag dance.
> 
> 
> Thanks Hannes. It is a cleaner approach and avoids the clear-and-set
> dance. However it touches the block layer (bio.h) and would need
> wider review and testing across all bio_set_dev callers.
> 
> I'd prefer to keep this patch as a minimal, nvme multipath fix that
> Is easy to backport to stable kernels where this race is hitting us
> today. The __bio_set_dev() approach (or Keith's patch that is
> removing set_capacity(0) entirely) could follow as the proper
> long-term solution.
> 
Errm. So you are saying: the real solution is too cumbersome,
let someone else do it?

I'll happily give you my reviewed by for the proper solution, and help
you to move the real solution forward.
But pushing the can down the road ... no.

Cheers

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
