Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFE93E765A;
	Thu,  8 Oct 2026 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454311; cv=none; b=Dl97erHzOqULnilKuyF8XgSNIg49CPx7GWW70zb88fMBFrQK1PtlxusoFB+elUNBk7NgJLmoGY8VyOriSc+vaBGdusCaBGlJK88Oj/K3yV0IhBwIlJCee4P85DLdCzzpIkQHZZixhkOT4YuJaZ0v2j2wIRJ8WmAIrf09eU+ayqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454311; c=relaxed/simple;
	bh=3lTlAwAe3+aWB2br71hS+34Dz4Y8z2pxSNkDhSK8cjY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWjyF8YCRz1UQyldUmE2b01bO7CfCJ7t4liqyr7LPzyR8DYWQGweW81nltplgX+OgqWJAopL8DKP65iBahdcs883fedQqqhMZwaCLULWZhJ7r4SmgVau+xP6MiTctwqIg0xMPf2j9pbg0VYld3pkU91kGuV4fDnn7rIRn8ue5Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=feyrRj0J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y0geOEBF; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=feyrRj0J; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Y0geOEBF; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="feyrRj0J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y0geOEBF";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="feyrRj0J";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Y0geOEBF"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 23D5921BFB;
	Thu,  8 Oct 2026 10:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791454308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EErSkvl1t7wVbt4j458uwqep+EL5PzKNODNrW7hBKD4=;
	b=feyrRj0JhMP0Bq7erM1hLh1VE9UNyqu3l48zuKSWKRMIBCrO+rLFb0+hB1075EQNNJSKyO
	nzOhBr47ryV1hVxs4pBem0suqpzxg82/Xk9vEEGUB1wCYNHByYFU1knC+MOBoqbZW1IC02
	Xzfbs4FSmJbaub/4iuB7nSdlO9ZwOYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791454308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EErSkvl1t7wVbt4j458uwqep+EL5PzKNODNrW7hBKD4=;
	b=Y0geOEBFDSWoyw4innaotiQlxJaDM+cF4H4x+c/BK3puSfEF38/6Ir5Ul4PdwM+0oeL5sa
	rOsbMhoz52Ps/+Ag==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791454308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EErSkvl1t7wVbt4j458uwqep+EL5PzKNODNrW7hBKD4=;
	b=feyrRj0JhMP0Bq7erM1hLh1VE9UNyqu3l48zuKSWKRMIBCrO+rLFb0+hB1075EQNNJSKyO
	nzOhBr47ryV1hVxs4pBem0suqpzxg82/Xk9vEEGUB1wCYNHByYFU1knC+MOBoqbZW1IC02
	Xzfbs4FSmJbaub/4iuB7nSdlO9ZwOYE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791454308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EErSkvl1t7wVbt4j458uwqep+EL5PzKNODNrW7hBKD4=;
	b=Y0geOEBFDSWoyw4innaotiQlxJaDM+cF4H4x+c/BK3puSfEF38/6Ir5Ul4PdwM+0oeL5sa
	rOsbMhoz52Ps/+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E52FC1339F;
	Thu,  8 Oct 2026 10:11:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BaITL2Nsx2oeLwAAD6G6ig
	(envelope-from <tiwai@suse.de>); Thu, 08 Oct 2026 10:11:47 +0000
Date: Thu, 08 Oct 2026 12:11:43 +0200
Message-ID: <87jyns5wo0.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/hdmi: clamp sad_count in ELD proc write handler
In-Reply-To: <20261008085133.9528-1-peter.ujfalusi@linux.intel.com>
References: <20261008085133.9528-1-peter.ujfalusi@linux.intel.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Spam-Score: -3.30
X-Spam-Level: 
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo]

On Thu, 08 Oct 2026 10:51:33 +0200,
Peter Ujfalusi wrote:
> 
> snd_hdmi_write_eld_info() parses a "sad_count N" line from the
> root-writable ELD proc interface and assigns N directly to
> e->sad_count with no upper bound, unlike the per-index "sadN_*" lines
> a few lines below which are already bounded to ELD_MAX_SAD.
> 
> snd_hdmi_eld_update_pcm_info() later iterates
> "for (i = 0; i < e->sad_count; i++)" over the fixed
> e->sad[ELD_MAX_SAD] array, so an oversized sad_count read from the
> proc file causes it to walk past the array.
> 
> Reject sad_count values above ELD_MAX_SAD, matching the existing
> per-index guard.
> 
> Fixes: acb059938810 ("ALSA: hda - ELD proc interface write updates")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@linux.intel.com>

Applied to for-next branch.  Thanks.


Takashi
