Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793778316;
	b=L2JuBztVrW+gdDEojOXuqjxUcQKO1VgwIn+uLeaO5m1qO1NDzfN8sMvQfT9pdCXDGC1/
	 b3LFFDfCRSB2fk2D39auQFovaqVehdaxNuKrTdfuFcimbGMIjk5kWSJnfIg+ux3fi5fx7
	 kJ5fgfYsaAYUSUxBDuRjbXhiPwqmzzlZIYjGDHaR4NvBWuMjvZYWS98J2vDSyBdBULsN1
	 DCDFZy91LLYxE+5vuB31gQIMGVHdQnUiV/I8owAXQ7vtsaMktkH54JVK7fSYL2jj9ddAa
	 wgOidExcc1Q/U218b78MBTfGEjXCW+uK4SIoTZH4NXJ6Bc+nFJwyMwIhQvfffVXZLEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793778316;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Spamd-Result:X-Spam-Score:
	 X-Spam-Level:X-Spam-Flag;
	bh=0uL0NqpeLBt8HnwEpB7IwwADUyks5hUI5W/+fdeoOD8=;
	b=pOU9MaeaGCZ6fsa1BqNu9LNQjYUpxeJ5LY4WWdPXMTveUZxBwf9IinkOgkELFDCtd79u
	 W9YERt5vi3XtYolG3QoTwuZ/ixev/VBKJLl4YeeM2h58FSlveE7L7+W0oFCIG73pPVTZH
	 np9m/0S1NUOfqsbRCOUxFjepFGmUw0OswrYyITQK+Nw1Soa1Qs/SS5ZFRiqVW+tdIaTcM
	 yskxplMU0vS6UQlThAdu+Cp4yKhZbJMw6uHvOmIGenD0XS0mknDWRyR61DdDumYTyoYFQ
	 rJy2udXffohJNTrrcwSISnSLZPqr/lJM7rt+rD5/pmV9v+3B6h+1z1j/KDxx2nNHJ/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wghdtQyh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5e+z+Nsh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ind5LpWH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=f7IiroDZ;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5F8606A335;
	Wed,  4 Nov 2026 07:45:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1B5F8606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=wghdtQyh;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=5e+z+Nsh;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ind5LpWH;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=f7IiroDZ
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25D882205F;
	Wed,  4 Nov 2026 07:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793778314; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uL0NqpeLBt8HnwEpB7IwwADUyks5hUI5W/+fdeoOD8=;
	b=wghdtQyhWEfjtpGbObiLPzLgyFip+CZJswewFMwCM0XMARhG85CBg9faYTlPj4jgvAU7/f
	dUR2iNw2bTpyosHBV4H7mv73WdXbwItdVo6Vn9giOFxPIkT2fcmD/qm2BQmtxCUpCfcc+f
	YxS7KFnIbxOQFrCcEmyxN10N61ccOhg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793778314;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uL0NqpeLBt8HnwEpB7IwwADUyks5hUI5W/+fdeoOD8=;
	b=5e+z+NshI0xnLKXjjQEg4AZOt1Yt+Ps62MKeD2xFknD9HXidtU9ceQsNQg4sxxOhNjO6r3
	FoE6r9cTAcY0xaBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793778313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uL0NqpeLBt8HnwEpB7IwwADUyks5hUI5W/+fdeoOD8=;
	b=ind5LpWHqbJn0QlS3pxCRiSp7gXfjfrg29loUOgSiQCoPL2P9yYDbMNktfRilsgxhmEfte
	bA9OOt3oQpiTXr0RtNIwTAaOyHXUFtoC+g5+60fT6KTfsmv1VK81iz2BCOhf+NCWb+tVwv
	hGcmtk5Y3S91m+UFkTYzEC3jtOfGC24=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793778313;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0uL0NqpeLBt8HnwEpB7IwwADUyks5hUI5W/+fdeoOD8=;
	b=f7IiroDZAc5A1GyVmAqFVJj7z/lajZ4WLhNVJYJTPecQVeLEEyrQ+YA23/iSnJVYrFESs2
	Fya6VK2ty3ck/nAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85CBC134A5;
	Wed,  4 Nov 2026 07:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id V1OCFYji6mqvSgAAD6G6ig
	(envelope-from <hare@suse.de>); Wed, 04 Nov 2026 07:45:12 +0000
Message-ID: <73883d88-b772-4c5a-8f1f-6b12c4501bb5@suse.de>
Date: Wed, 4 Nov 2026 08:45:11 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 02/11] nvme-keyring: Add a missing key_put() call
 to nvme_tls_key_lookup()
To: Jarkko Sakkinen <jarkko@kernel.org>, David Howells <dhowells@redhat.com>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-integrity@vger.kernel.org,
 Mimi Zohar <zohar@linux.ibm.com>, keyrings@vger.kernel.org,
 stable@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 Hannes Reinecke <hare@kernel.org>,
 "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
References: <20261103030226.2685251-1-jarkko@kernel.org>
 <20261103030226.2685251-3-jarkko@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261103030226.2685251-3-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-11.79 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,linux.ibm.com,kernel.dk,lst.de,grimberg.me,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,lists.infradead.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -11.79
X-Spam-Level: 
X-Spam-Flag: NO

On 11/3/26 4:02 AM, Jarkko Sakkinen wrote:
> Call key_put() before returning -EKEYREVOKED, as the reference count gets
> incremented by key_lookup().
> 
> Cc: stable@vger.kernel.org # v6.12+
> Fixes: 5bc46b49c828 ("nvme-tcp: check for invalidated or revoked key")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> ---
>   drivers/nvme/common/keyring.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
> index 32d16c53133b..87cb51e1f5a7 100644
> --- a/drivers/nvme/common/keyring.c
> +++ b/drivers/nvme/common/keyring.c
> @@ -35,6 +35,7 @@ struct key *nvme_tls_key_lookup(key_serial_t key_id)
>   	}
>   	if (nvme_tls_psk_revoked(key)) {
>   		pr_err("key id %08x revoked\n", key_id);
> +		key_put(key);
>   		return ERR_PTR(-EKEYREVOKED);
>   	}
>   	return key;

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
