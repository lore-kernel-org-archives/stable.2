Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268042E8FF
	for <stable@vger.kernel.org>; Tue,  7 Jul 2026 14:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783435368; cv=none; b=fKkEVrmr64sCeVlLZEAalAusSRpqvyVGMneasGIeBwrtbXw+WFLFBMFvLy4oMDYJiVlkGrQA9uCkEsWvutvXTSsivC6X55X+bG57pEpGpBzrLBKLF5WVpIgtk1/0XQXEz9NrYZFvXaU25y7114TnlYFB/DNnzjeHPh4DwI5hfsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783435368; c=relaxed/simple;
	bh=qxKjtUfW8NOSvv2m10O+eJjG7XFG1vglPscpEmtMO9E=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MjcSjpx1O0YJ58t5GqvBKq+n+Tj/XQ4TbfpRv0byTDeGMYxhbWs9GVZ8NTbObT/N45fRryJxPGnQIAkP5MyDLCn3nwba104y5Js1QoSVmWuGFe+ufCB4U7ikLtXZ38e+41vWoD60WlGS3xDe+X2w6MuEqB6LEr2NvodmfmV/cwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=uk9F13CF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=YVlgUmPf; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vRPrvb+W; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CXJCPy2P; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="uk9F13CF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="YVlgUmPf";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vRPrvb+W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CXJCPy2P"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 39C7B75C39;
	Tue,  7 Jul 2026 14:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783435365; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09JmpQEzp3z04t7IKwLys5vOGRyn8tpxUWQDLTzUOqg=;
	b=uk9F13CFiMS0INsIWY3ywOP8EFNBWEINEyycr2j4B2CFSt5Y4Zce+bnIT+WhpLgKTE794i
	h9m0QCBLNn8MnjG39+KvxNahGGgD+KZI6BfbYqtXUHGRE2tgcczYAjPh7gdUOY6D00bp4G
	8TKpYAZkf1H7iOrbTe8Nyl2mEvOsWt0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783435365;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09JmpQEzp3z04t7IKwLys5vOGRyn8tpxUWQDLTzUOqg=;
	b=YVlgUmPftbi0BiMJWlBoEnCqW2UHiLum994Nwdx57+ngWqZqU8JTfydVnZ+8XdagKarCPw
	Cc/eEIQU0AXrLWCA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vRPrvb+W;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CXJCPy2P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1783435363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09JmpQEzp3z04t7IKwLys5vOGRyn8tpxUWQDLTzUOqg=;
	b=vRPrvb+W1MrFDPKLyGMGghwxLRgHDiZiLtPn4vyiI03DuxNhN5B3ND+6382dlh+AeBV+8F
	AfyaJRLvSS4gvfTbyoPfDAWkDlAv9p+KnFlo4Z2aDWd54chjgg80iIZQ9/DUfAythMIQGa
	8phxRtR3OckSDZOeYupxsMA523w3CfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1783435363;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=09JmpQEzp3z04t7IKwLys5vOGRyn8tpxUWQDLTzUOqg=;
	b=CXJCPy2PIPyxp80uyWIm4WHIUzt2Jn2Ux/Z9Ne5Gk7ZXvKZr6r/hjPcQajJ1IBLxsjqC7p
	PcQvFAXS+hqzt8BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 231A2779AE;
	Tue,  7 Jul 2026 14:42:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id AzH/B2MQTWpDeAAAD6G6ig
	(envelope-from <tiwai@suse.de>); Tue, 07 Jul 2026 14:42:43 +0000
Date: Tue, 07 Jul 2026 16:42:42 +0200
Message-ID: <87v7aq6eu5.wl-tiwai@suse.de>
From: Takashi Iwai <tiwai@suse.de>
To: raoxu <raoxu@uniontech.com>
Cc: perex@perex.cz,
	tiwai@suse.com,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda: Fix cached processing coefficient verbs
In-Reply-To: <DB9023BF2920BA99+20260707132419.1731342-1-raoxu@uniontech.com>
References: <DB9023BF2920BA99+20260707132419.1731342-1-raoxu@uniontech.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) Emacs/30.2 Mule/6.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-3.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,uniontech.com:email,suse.de:mid,suse.de:dkim];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,uniontech.com:email];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 39C7B75C39
X-Spam-Score: -3.51

On Tue, 07 Jul 2026 15:24:19 +0200,
raoxu wrote:
> 
> From: Xu Rao <raoxu@uniontech.com>
> 
> Intel HD Audio defines Coefficient Index and Processing Coefficient as
> separate audio widget controls in the Audio Widget Verb Definitions:
> Coefficient Index selects the coefficient slot, while Processing
> Coefficient accesses the value at the selected slot.
> 
> hda_reg_read_coef() selects the slot with AC_VERB_SET_COEF_INDEX, but
> then uses AC_VERB_GET_COEF_INDEX for the value read.  That reads back the
> selected index instead of the coefficient value.  hda_reg_write_coef()
> has the same issue and builds the value write from AC_VERB_GET_COEF_INDEX
> instead of AC_VERB_SET_PROC_COEF.
> 
> This only affects the regmap coefficient cache path used by codecs that
> set codec->cache_coef.  Direct coefficient helpers already use the normal
> SET_COEF_INDEX followed by GET_PROC_COEF or SET_PROC_COEF sequence, which
> is likely why this has not been noticed widely.
> 
> Use AC_VERB_GET_PROC_COEF for cached coefficient reads and
> AC_VERB_SET_PROC_COEF for cached coefficient writes.
> 
> Fixes: 40ba66a702b8 ("ALSA: hda - Add cache support for COEF read/write")
> Cc: stable@vger.kernel.org
> Signed-off-by: Xu Rao <raoxu@uniontech.com>

Ouch, this is a brown-paper-bag bug.
Applied now.  Thanks!


Takashi
