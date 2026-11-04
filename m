Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793776946;
	b=vE0Hb5d/DINd3KXX80HXsJ7buhobNcCTbbIMTWp54t63RJHhjMuokH8MLORdRgUm5+OM
	 Uty2Rpq5e22Hh+WebS6ukCNxif1KHJtGmPT9HelooMDI+tjeC6kSwt8aa5FDX78P7F9Rp
	 RN2VRhhBL7yfEU6So4x6zdCrjJaUstITPdj9llpO9WnftCO+vGfF3d8FaEGhrMCVY416C
	 7wVARQJv6nOkd3cOvTOcaPx/KHCJmt8aRtpL+dJvu7GEftoscLZstADA3Di2EMdQtG3ID
	 lwN/11xunqt/thxMGili2AH1hUKijuFfXdKhP5MQvyOxbhiDlpntLGcg9tb/18dapxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776946;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-Rspamd-Queue-Id:X-Spam-Level:X-Rspamd-Server:X-Rspamd-Action:
	 X-Spam-Flag:X-Spamd-Result:X-Spam-Score;
	bh=+H1Cs3HEyvTi0DffUo23ljDUGdJ2HE+qMvgJ+s00WfY=;
	b=377u1uxX+IwRVG09da2QO+t7PIwK12haJ2/YcS23VDvEUTKL6bha5ConQutDBKFWTWFl
	 AsNdN7lh9oGyVSWQl+TYoBLn+WTRG17/mDFz6rovF1177wSkcct8w3FkM1QRvi1jQCtJd
	 OCs0pVmn7PCQXGyyPHZ0auhIk/mIQct2tTyQd+pnI2lrWpxIrJD9Hrfsxvpg2gOzXC5zT
	 tf4nxOokf5tROqVc+YzoF6R08wqsn83hIPZaRdl2W6KCnUjfll35xquxPEM66Ojvv1OnF
	 W/adylJXxt8L0ADIOLuqtaT/7lGTg6Wwp+Rtc+i4e4aaewtlH1sZzDqJJ+iVLLDtwCQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aVIeYbJr;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RyR2Wjy7;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SCvLAOdw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LXTAZYF8;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9696082BD7
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 07:22:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB9696082BD7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=aVIeYbJr;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RyR2Wjy7;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=SCvLAOdw;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=LXTAZYF8
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B65481F7A7;
	Wed,  4 Nov 2026 07:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793776937; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+H1Cs3HEyvTi0DffUo23ljDUGdJ2HE+qMvgJ+s00WfY=;
	b=aVIeYbJrplvCL5G6I/2q8kHt3LGCWu8wmC+u0EaWRLuOTuk+Hfna/vv2a9h3T4L6Mup8Dg
	+Mm2g8SvyGVcFxB+plgOYZP9btw34qvmj9d+I80h5NmKU+AJ5Un/GOYTDILubpxSXTRM+x
	5sN1jblXblTXl/jyEyYtR0AiDVXKDHo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793776937;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+H1Cs3HEyvTi0DffUo23ljDUGdJ2HE+qMvgJ+s00WfY=;
	b=RyR2Wjy7SWm0bZMtg7L98LfqYJ4PkxNMIFIqktPNjN2N5eVf8Qhs7GEVP1ueK4tA5ze7Z/
	dOCsG4kdCiuHnZAQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SCvLAOdw;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=LXTAZYF8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793776936; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+H1Cs3HEyvTi0DffUo23ljDUGdJ2HE+qMvgJ+s00WfY=;
	b=SCvLAOdwIhb+0Jj74xa6aMeE6P7C9VY9wVcjf2Pai/IvonOVTa/qJrfDKupdy7NEgSN7yJ
	KDCQIiOGdsy2IG49u3k3AXz1ufppdH+eZQ92dx/jzVMsser69IAort/VTXg8P+q14DkYgI
	JBhGk7KEAwzWHCs2TbjRFrMJst9Lpww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793776936;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+H1Cs3HEyvTi0DffUo23ljDUGdJ2HE+qMvgJ+s00WfY=;
	b=LXTAZYF8b+NWDtflu8zU1wbKqEVy7QpLhTCB12urZ7gWrEm7XAVsW5UOQ3RrJpro6ACwJW
	XL0m6n5hJwsDQQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4BC6A134A5;
	Wed,  4 Nov 2026 07:22:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OHNwCSjd6mpeMwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Wed, 04 Nov 2026 07:22:16 +0000
Date: Wed, 04 Nov 2026 08:22:15 +0100
Message-ID: <87pkwlukm0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: med.jebabli@gmail.com
Cc: regressions@lists.linux.dev,
	Cristian Castellano <cristian.castellano@icloud.com>,
	stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.com>,
	Jaroslav Kysela <perex@perex.cz>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Shenghao Ding <shenghao-ding@ti.com>,
	Kevin Lu <kevin-lu@ti.com>,
	Baojun Xu <baojun.xu@ti.com>,
	Sen Wang <sen@ti.com>
Subject: Re: [PATCH] ALSA: hda/tas2781: Only accept CRC-less V1 data if all entries are valid
In-Reply-To: <20261103-tas2781-v1-nocrc-fix-v1-1-a769c27f21ce@gmail.com>
References: <20261103-tas2781-v1-nocrc-fix-v1-1-a769c27f21ce@gmail.com>
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
X-Rspamd-Queue-Id: B65481F7A7
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spamd-Result: default: False [-11.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,icloud.com:email];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,icloud.com];
	FREEMAIL_CC(0.00)[lists.linux.dev,icloud.com,vger.kernel.org,suse.com,perex.cz,leemhuis.info,ti.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]
X-Spam-Score: -11.01

On Tue, 03 Nov 2026 10:27:12 +0100,
Mohamed Yassine Jebabli via B4 Relay wrote:
> 
> From: Mohamed Yassine Jebabli <med.jebabli@gmail.com>
> 
> Commit 408249089c48 ("ALSA: hda/tas2781: Accept V1 calibration data
> without CRC") only checked the first device entry. On machines where
> the BIOS populates fewer entries than p->ndev, the remaining all-zero
> entries are applied and tas2781_cali_preproc() divides by zero on
> playback open.
> 
> Accept CRC-less V1 data only if every expected entry is non-zero and
> self-consistent (R0 * 1/R0 close to 1.0), otherwise reject it as
> before.
> 
> Fixes: 408249089c48 ("ALSA: hda/tas2781: Accept V1 calibration data without CRC")
> Reported-by: Cristian Castellano <cristian.castellano@icloud.com>
> Closes: https://lore.kernel.org/all/4e500063-d985-46b6-a0a1-3feaa77c4b2f@leemhuis.info/
> Cc: stable@vger.kernel.org
> Signed-off-by: Mohamed Yassine Jebabli <med.jebabli@gmail.com>
> ---
> Cristian, could you test this on the Yoga Pro 9 16IRP8? With the fix,
> the driver should log "V1 CRC error" again and fall back to default
> parameters, as it did before 408249089c48. If it still logs
> "accepting", p->ndev is 2 on your machine and the root cause is
> elsewhere, so please send the full "dmesg | grep -i tas2781".
> 
> Takashi's re_cal check in tas2781_cali_preproc() is complementary
> and still worth applying as a safeguard.

As the code looks safe enough, I applied now.
Let me know if the problem still happens.

I'm going to submit my zero-check patch as a further hardening, too.


thanks,

Takashi
