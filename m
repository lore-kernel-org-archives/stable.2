Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF62363C6C
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782975661; cv=none; b=hG8jDl49zjfM4+IVHa/UhXtDKRxtwWUBNarJ5XWTvICTLAFK0UOiEAeqiDIr9/Uokg78PkiKDVwOzyyMTJIWU5p44c/hmT5c/O7lHVMfrxYuKHov1gYVJeFb4Ej8j+YB+Y/tK2IWiPXt9kzPChv0nbcKlAwKhG5jC1OewuRo7pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782975661; c=relaxed/simple;
	bh=gliPlAH+AIf2hW1qRZSTioxYHkCiCGAWZUhTCJdp4+g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CWhRg894ogcJ98lheDBlUhy3/73khieWElX4i1Eia5vd9pAAV7Tn/Y4JjkTWmgiM06ea56MJ3xzAH9Gg+IdiA6pspBvwTJfeuLshft2wGVzoCUsOrM0P6+zD26NEzP7sZWhVrBrxa12LghXV4UEnWqT3jRiAZdKLAA1DPv5ijK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ATacr8si; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mERGJDl6; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=oMx0almF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=5ZQLkFla; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ATacr8si";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mERGJDl6";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oMx0almF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5ZQLkFla"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id A6D4B758E7;
	Thu,  2 Jul 2026 07:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782975658; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5ttcjBhAWRUt2t/Fshbu+d2Zyg/aGEZG45tSzRa6XY=;
	b=ATacr8siaVnBmya8c5W9/ftUUmJ6IGfJmigW345ByqWllK6A36+8k5iAN0v7z14aY0KpNx
	V6hhX+5agTZKeqsLfkjJ71xhMT8JG1EpRtKskG7TdJU7UNtKsUI2nEbIiZaBej3GSSIwc+
	Fn3MhdoVZ1pdWOlTA5RoW6i4Fi4iGXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782975658;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5ttcjBhAWRUt2t/Fshbu+d2Zyg/aGEZG45tSzRa6XY=;
	b=mERGJDl6t7yL5a+53GR2lFrr9vt9WFTe29NttNFrVtjJ0AxX+et9YQ4CmzqUn1cjH5h+hv
	pnkXdXfEb5m/bdAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oMx0almF;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=5ZQLkFla
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1782975657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5ttcjBhAWRUt2t/Fshbu+d2Zyg/aGEZG45tSzRa6XY=;
	b=oMx0almFkxovxkxQIx1SqKgrtUyP2fkSlbhtO/0KZ9RzOUGQf5Pb12OtJ/YQCCxEcHMhbs
	zukSNzsLTnc2lxvFF4Bdgl6qLqR+cnuQybVh9h1dPlJmQ+WvuKyrNKAR3TeQbLYeRLaU+L
	lmYsiXUIamiKx+SIt1TUpAtX14HXJdI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1782975657;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/5ttcjBhAWRUt2t/Fshbu+d2Zyg/aGEZG45tSzRa6XY=;
	b=5ZQLkFla/TE7lI66mIxZo9hZUh+t4NVxipgvoHMeGiXSysIFhV2Ud0o0eLQPQ05eYl/d6E
	oYIat15tUslu+KDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 73F3A779AA;
	Thu,  2 Jul 2026 07:00:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id f16+GqkMRmogZQAAD6G6ig
	(envelope-from <hare@suse.de>); Thu, 02 Jul 2026 07:00:57 +0000
Message-ID: <3c541cc5-b978-40aa-a7da-3fa4f1f461f6@suse.de>
Date: Thu, 2 Jul 2026 09:00:57 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: libata-scsi: fix DSM TRIM for sector sizes
 larger than 2048 bytes
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Shaun Tancheff <shaun@tancheff.com>, Tejun Heo <tj@kernel.org>
Cc: stable@vger.kernel.org, linux-ide@vger.kernel.org
References: <20260701224638.1835123-4-cassel@kernel.org>
 <20260701224638.1835123-5-cassel@kernel.org>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.de>
In-Reply-To: <20260701224638.1835123-5-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A6D4B758E7
X-Spam-Score: -4.51

On 7/2/26 12:46 AM, Niklas Cassel wrote:
> ata_scsi_write_same_xlat() translates a SCSI WRITE SAME command with the
> UNMAP bit set into an ATA DATA SET MANAGEMENT TRIM command.  The TRIM
> descriptor is built by ata_format_dsm_trim_descr() into the 2048-byte
> ata_scsi_rbuf staging buffer, and the number of bytes copied is compared
> against the logical sector size by the caller:
> 
> 	size = ata_format_dsm_trim_descr(scmd, trmax, block, n_block);
> 	if (size != len)		/* len == sdp->sector_size */
> 		goto invalid_param_len;
> 
> ata_format_dsm_trim_descr() clamps the copy length to ATA_SCSI_RBUF_SIZE
> (2048).  On a device whose logical sector size exceeds that (e.g. a 4Kn
> device, where sector_size == 4096) the function can never return more than
> 2048, while the caller expects it to return sector_size.  The comparison
> therefore always fails, so every TRIM is rejected with "Parameter list
> length error" and WARN_ON() splats on each attempt.  TRIM / discard is
> thus completely broken on such devices.
> 
> The descriptor was incorrectly sized from the logical sector size.  A DSM
> TRIM payload is a list of 512-byte pages, each holding up to
> ATA_MAX_TRIM_RNUM (64) LBA Range Entries, and is independent of the logical
> sector size.  The Block Limits VPD page already advertises a single such
> page as the maximum WRITE SAME length (65535 * ATA_MAX_TRIM_RNUM logical
> blocks), so the block layer never sends a request that needs more than one
> page.
> 
> Emit exactly one 512-byte page, independent of the logical sector size,
> and transfer only that page (COUNT == 1).  For a 512-byte-sector device
> this is unchanged; devices with larger logical sectors now work instead of
> failing every TRIM.
> 
> Fixes: ef2d7392c4ec ("libata: SCT Write Same / DSM Trim")
> Cc: stable@vger.kernel.org
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare@kernel.org>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.de                                +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich
