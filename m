Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793786995;
	b=W6xEJ1XO1H404EhUUVIo3SWnisV/IaFxMHaV9odmxXdxUbFkCmeu5roPrh35nG0H+bNf
	 UiBVG+n+JFMcj6LgGMdKJOdLoVjJ6IMmPqTr6srK99RQAZyVOi+/oagq/t+xWDvybzKTa
	 Cw+Nk2EJFPKiK7FOFfF8I+Gcar2pVvITjPqzWsNMyEwS9N7S6iEIt2KgqPkUk5yI2ZqCU
	 D2oTIpHMDq0cZFIOCB81R//XmYyRA7J2AuZh6X56jP0rwyreN7v+1L6o94WxNTH65NsJ8
	 cE+0liyCosE4uQr+qzQmt+8ni3zFVr3ada3G7021JYeUbJacu4GFGuE0uRTQ3BkAJUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786995;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=qIMpR+0/hdmd8jinaUXUOgaSrCAhJGIMFs5i4DB1BC0=;
	b=lt08DoblzFYYZ08AlD2FL3acppWBnxb31HiTntKVWSH3nn/88U8pQMTR2uiwnyAqo+I0
	 OaA03yuiPawSURAv8vIsOAk7bbUGNOodDatFDXNR526f81GVnxfp0/ImnKOyXhHZQpjtE
	 RnYtttFDPM7ieHY8OOfqHZAObxlqxwBITJG67UpN1kemdKCGlncS4sA+xIZVqDqhA8WMu
	 6NPNrVHpJ0ld28xNUY/eH8CbwPASRGtbZVI0a0uUC101IE/b1gSO8WL9Zny84hyYs09DM
	 n2DQQZDQSEkakEppFm8ext4xVXb5Ey/6COZmH/ARiH0012t4TItEXPiaao59g0BxbMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Qf5SVuE5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HOncpjtD;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Qf5SVuE5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HOncpjtD;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78503606A31B;
	Wed,  4 Nov 2026 10:09:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78503606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Qf5SVuE5;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HOncpjtD;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=Qf5SVuE5;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=HOncpjtD
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A5F891F7BE;
	Wed,  4 Nov 2026 10:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793786992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qIMpR+0/hdmd8jinaUXUOgaSrCAhJGIMFs5i4DB1BC0=;
	b=Qf5SVuE5r5sMGvj7IuH5vo0P85ZM9kxaqzSqW1XbVBFfT+FApLpNv8ubyfpPHxwO81EgOp
	/GsS9ojUyK02u6bvpBfC/X+rf8YlrPL5JVqvtaHrEBkeV1CeFQo+CBlE5NrIecInviDZ2k
	ZH8qcIx/ouPU+YGux8L/i+IdzgzEIfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793786992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qIMpR+0/hdmd8jinaUXUOgaSrCAhJGIMFs5i4DB1BC0=;
	b=HOncpjtDOpzbthgdoYNKyHQC7pAcFwn9ve/w08zlusNUzXH25eB2xRmoT5SIPHVYDm9fzj
	yRMNnN4pOg2TGHAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793786992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qIMpR+0/hdmd8jinaUXUOgaSrCAhJGIMFs5i4DB1BC0=;
	b=Qf5SVuE5r5sMGvj7IuH5vo0P85ZM9kxaqzSqW1XbVBFfT+FApLpNv8ubyfpPHxwO81EgOp
	/GsS9ojUyK02u6bvpBfC/X+rf8YlrPL5JVqvtaHrEBkeV1CeFQo+CBlE5NrIecInviDZ2k
	ZH8qcIx/ouPU+YGux8L/i+IdzgzEIfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793786992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qIMpR+0/hdmd8jinaUXUOgaSrCAhJGIMFs5i4DB1BC0=;
	b=HOncpjtDOpzbthgdoYNKyHQC7pAcFwn9ve/w08zlusNUzXH25eB2xRmoT5SIPHVYDm9fzj
	yRMNnN4pOg2TGHAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 020C6134F0;
	Wed,  4 Nov 2026 10:09:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id /kgrMm8E62pxXwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 04 Nov 2026 10:09:51 +0000
Date: Wed, 04 Nov 2026 11:09:51 +0100
Message-ID: <878q38vrf4.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: songxiebing <songxiebing@kylinos.cn>
Cc: tiwai@suse.com,
	perex@perex.cz,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hdsp: Fix divide-by-zero in DDS offset control
In-Reply-To: <20261104083045.1939479-1-songxiebing@kylinos.cn>
References: <20261104083045.1939479-1-songxiebing@kylinos.cn>
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
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -12.30
X-Spam-Level: 
X-Spam-Flag: NO

On Wed, 04 Nov 2026 09:30:45 +0100,
songxiebing wrote:
> 
> From: Bob Song <songxiebing@kylinos.cn>
> 
> hdsp_set_dds_offset() computes the target rate as
> system_sample_rate + offset_hz without validating the result.  A user
> can set the DDS offset to -system_sample_rate through the control API,
> making rate zero and causing div_u64() in hdsp_set_dds_value() to
> divide by zero.
> 
> Reject non-positive rates before programming the DDS value.
> 
> Fixes: e4b6088c8cf1 ("[ALSA] hdsp - Add support for fine tuning of sample rate support to HDSP 9632")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Bob Song <songxiebing@kylinos.cn>
> ---
>  sound/pci/rme9652/hdsp.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/sound/pci/rme9652/hdsp.c b/sound/pci/rme9652/hdsp.c
> index 7dce548b9f36..694816f966d2 100644
> --- a/sound/pci/rme9652/hdsp.c
> +++ b/sound/pci/rme9652/hdsp.c
> @@ -2802,6 +2802,9 @@ static int hdsp_dds_offset(struct hdsp *hdsp)
>  static int hdsp_set_dds_offset(struct hdsp *hdsp, int offset_hz)
>  {
>  	int rate = hdsp->system_sample_rate + offset_hz;
> +
> +	if (rate <= 0)
> +		return -EINVAL;
>  	hdsp_set_dds_value(hdsp, rate);
>  	return 0;
>  }

The caller doesn't check the error case properly.
Please fix the caller side, too.


thanks,

Takashi
