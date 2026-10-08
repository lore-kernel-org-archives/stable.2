Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC14B3C552B;
	Thu,  8 Oct 2026 07:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791443739; cv=none; b=YoKVaVkY4sQosah+P/4b9TYRdGaJB+U7dlZcgzDHo+JUyyJd5TTAXQBkmpbAh7WpPcFbGXx/9mfg7p13p+AkoHK9S7Lvs8McBWS9MYbksXYAm1fPbS+9Xn4H7KVfJ0+NF/etL/2cDI6ZocaJPBdMaJtvMOfLLaMiKhCd7uXWa+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791443739; c=relaxed/simple;
	bh=GtUajjQMVI6Gzh52cxiKjtvaqDkTFUAMGAXKnWZCC+Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TgMWbKOpVOsD1lSrMB+a+DSexI4N7ANUcFS9dVBRNa/fmIZp3RaTQo+JoS0P02S6fbGWRsc3cjzXqmYqMR/X2laeRhK6qHIQHmWO9MtIn2nsvYERld/uEHzLxED0/9I91zDSAeAniiqxqq2rasjAU5LV+iiwBspgfxBeyTuxb3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=kYsvjPcR; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QVhIVzsJ; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Cj6QWk3h; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=+GnklNsL; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kYsvjPcR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QVhIVzsJ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Cj6QWk3h";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+GnklNsL"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 806D821B0C;
	Thu,  8 Oct 2026 07:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791443735; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bz3qd4Jtwp/O2TtPdUCiXZoBrV0u85ch9xOglmgN+68=;
	b=kYsvjPcRAOlv05hdLVp5Amlj1uqH6532fs9l9nYkLVyEOprolcDxLik8DydgGm/9IqGl+d
	8F0Y0CL87++hhC4AZX6rPIWDB+wH2xWjlDkPeYbVDKOcvMjp7n4Ly0tiBmkeYy7OnRlyql
	faBEkRTDlSXP6ItxPdQPG+coonWUHHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791443735;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bz3qd4Jtwp/O2TtPdUCiXZoBrV0u85ch9xOglmgN+68=;
	b=QVhIVzsJIzmJPbL8Ugk77i7IkxENG1qEEGYif6HDpgiwOJrBQNOqdqNi5WkkHNxmnmFyFK
	x+ko7kdfxz52prAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791443734; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bz3qd4Jtwp/O2TtPdUCiXZoBrV0u85ch9xOglmgN+68=;
	b=Cj6QWk3h/Tf6MiIVeLWUxnhBIs+f/cpyCb0ATSRntVULxTMbB3wFphS2nIc3/E6vCDiJJ8
	OgKI+Skag5LGp2nvyFwWCMcnGROQEH0GmkowlUAz0Qcs9XyX7PkvmKpaXcBT2Uy6KUcWFK
	E9Gr1j0lrwOp5iledB5QbtjRxpK9Im8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791443734;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bz3qd4Jtwp/O2TtPdUCiXZoBrV0u85ch9xOglmgN+68=;
	b=+GnklNsL6JtrMbBzDESVn+L46EZYHPPDSy/vumlpBsRxgIcEfjK0itYXZjnx3e5szmHtTh
	TYszlMRkCsqLEhAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3CABB13354;
	Thu,  8 Oct 2026 07:15:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ozNKABZDx2oebQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 08 Oct 2026 07:15:34 +0000
Message-ID: <44b45eb2-6fe9-44e8-bae0-e3df753b10c6@suse.de>
Date: Thu, 8 Oct 2026 09:15:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nvme-auth: fail when the controller does not authenticate
 itself
To: Yehyeong Lee <yhlee@isslab.korea.ac.kr>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
References: <20261006134807.518056-1-yhlee@isslab.korea.ac.kr>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20261006134807.518056-1-yhlee@isslab.korea.ac.kr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -4.26
X-Spam-Level: 
X-Spamd-Result: default: False [-4.26 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-0.998];
	NEURAL_HAM_SHORT(-0.17)[-0.837];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo,korea.ac.kr:email]

On 10/6/26 3:48 PM, Yehyeong Lee wrote:
> nvme_auth_process_dhchap_success1() returns success as soon as the
> controller clears the rvalid flag in its DH-HMAC-CHAP success1 message,
> without looking at whether the host had asked the controller to
> authenticate.  A host configured with a controller secret sends a
> challenge in its reply, computes the expected controller response, and
> sets chap->bi_directional; if the controller then answers with
> rvalid = 0 the response is never compared, the host still sends
> success2, and the queue is marked as authenticated.
> 
> A malicious or man-in-the-middle controller therefore only has to clear
> one flag to turn the configured bidirectional authentication into a
> one-way one, without holding any secret of its own.  The target side
> already treats the mirror image of this as fatal: when the host supplied
> a challenge but no controller key is configured, nvmet_auth_success1()
> fails the authentication rather than answering with rvalid = 0.
> 
> Refuse the connection if the controller returns no response although
> bidirectional authentication was requested.  chap->bi_directional is the
> right condition rather than ctrl->ctrl_key, because secure concatenation
> sends a challenge only to derive the PSK and deliberately clears
> bi_directional; a one-way setup without a controller secret keeps
> returning success as before.
> 
> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
> Cc: stable@vger.kernel.org
> Signed-off-by: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
> ---
> Reproduced over an nvmet loop target modified to omit rvalid in its
> SUCCESS1 (standing in for a controller that does not authenticate itself),
> with the host configured for bidirectional authentication.  There is no
> oops; this is an authentication-logic flaw, so the evidence is the host's
> dmesg.
> 
> Unpatched, the host accepts the connection and never validates a controller
> response (note the absence of any "controller authenticated" line):
> 
>    nvme nvme0: qid 0: authenticated with hash hmac(sha256) dhgroup null
>    nvme nvme0: qid 0: authenticated
>    nvme nvme0: new ctrl: "nqn.2026-10.test:authsubsys"
> 
> With the patch the same controller is refused:
> 
>    nvme nvme0: qid 0: controller did not authenticate
>    nvme nvme0: qid 0: authentication failed, error -129
> 
>   drivers/nvme/host/auth.c | 15 ++++++++++++++-
>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
> index e55920642f2c1..cbb38935fa227 100644
> --- a/drivers/nvme/host/auth.c
> +++ b/drivers/nvme/host/auth.c
> @@ -358,8 +358,21 @@ static int nvme_auth_process_dhchap_success1(struct nvme_ctrl *ctrl,
>   			 nvme_auth_hmac_name(chap->hash_id),
>   			 nvme_auth_dhgroup_name(chap->dhgroup_id));
>   
> -	if (!data->rvalid)
> +	if (!data->rvalid) {
> +		/*
> +		 * The controller did not return a response.  If we asked it to
> +		 * authenticate itself the session must not be used, otherwise
> +		 * mutual authentication would silently degrade to one-way.
> +		 */
> +		if (chap->bi_directional) {
> +			dev_warn(ctrl->device,
> +				 "qid %d: controller did not authenticate\n",
> +				 chap->qid);
> +			chap->status = NVME_AUTH_DHCHAP_FAILURE_FAILED;
> +			return -ECONNREFUSED;
> +		}
>   		return 0;
> +	}
>   
>   	/* Validate controller response */
>   	if (crypto_memneq(chap->response, data->rval, data->hl)) {

Correct.

Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
