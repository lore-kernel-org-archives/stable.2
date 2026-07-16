Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC7D43C4576
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 21:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784237871; cv=none; b=DMDom+Px7qDwtS0365R+SFx9qX+Haw+uzW+O6MVgJyDYlfxvzeW5p5zRiZOdHnhAT1JkuAeoOw5DlibWm1UaEQJ9gzB1EyjlD/NiIdT1SsJIL1nP4sOiBYWlj2zGzETQmbY5971NRSU0MagNfS/XO2YnGF/PjWiEo1QIy+erm2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784237871; c=relaxed/simple;
	bh=nSzrgPqrcdBjasDxqZgItYcu3ie0Uv7mJpoRj+pMwLM=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=rM48z9U3xKBav3AEK4cxcx+zFZI9/48L+zZtrNyGFOLJJMR4xaD5MACEQ1ZaKWl5O8U6fVYh6FUbpKmsmFS/3tOywDif/EXstTyxvK5TmlOKNj3m4HN/GW9OA3AiUVnVDqQjXovHkUfH6S3288KW2RfX/IvtweuM3AT4xIUOfrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UQcUpjkn; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=FfsDJa9m; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=qgPZ7osj; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=TQDP4Gw+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UQcUpjkn";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FfsDJa9m";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qgPZ7osj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TQDP4Gw+"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B3E643D9B;
	Thu, 16 Jul 2026 21:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784237866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymydv+125jMCTJ+buoLgXz2orzzJfKyNSNW/Q/VNSYg=;
	b=UQcUpjknZiQS2tZvDmUggGwoiONS7fAGss+kW+yYo9YKJnJk6g4NfKSH+2ZxcqEEbqGXbG
	7kaXu56Sj0QyK8/5rbdvxuyETuUmFLlLW02aM1l2LLSbsCzy4DZlUc0cPysK6Nnw3JDP+e
	7EQ/yPXcgVRS7ssn+4HrmApjzAs428E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784237866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymydv+125jMCTJ+buoLgXz2orzzJfKyNSNW/Q/VNSYg=;
	b=FfsDJa9m/nn1drSVmbMg/gZvRWDWbAZK4ydMMvcAl17QNq1VnSgCe9AlVXgX9unlsyBxae
	A6L1Zd63wdpdUGBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784237865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymydv+125jMCTJ+buoLgXz2orzzJfKyNSNW/Q/VNSYg=;
	b=qgPZ7osjAPDreQxhYZt2Rg6c77LtvNaXLPT5v+aaI8nndY5Zp9IIIXboNPx4wCJOYqYuZC
	4mEW9WlFPw/SPxkOZFX6UAiHZ0bbIfsaIUS1ydafRd9M0r+d3+7XXC2cWmWdAoYbz5KmlH
	1rSf+tXfLubV55cCQ286NxYBFAswfjY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784237865;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ymydv+125jMCTJ+buoLgXz2orzzJfKyNSNW/Q/VNSYg=;
	b=TQDP4Gw+yzMHnGjiQw7SQGI8WPnlctWgFjx+dVkSF8mRfqxLO2UTb6AjaDDZFIn573Grur
	EKBpIkQIa9DjBOCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3505779AD;
	Thu, 16 Jul 2026 21:37:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6dfmMyhPWWqsXAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 16 Jul 2026 21:37:44 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net v2 1/2] vxlan: require CAP_NET_ADMIN in the device
 netns for changelink
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 pabeni@redhat.com, andrew+netdev@lunn.ch, fmancera@suse.de, 
 sd@queasysnail.net, linville@tuxdriver.com, mschiffer@universe-factory.net, 
 maoyixie.tju@gmail.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260716203500.70573-2-doruk@0sec.ai>
References: <20260716203500.70573-1-doruk@0sec.ai>
 <20260716203500.70573-2-doruk@0sec.ai>
Date: Thu, 16 Jul 2026 23:37:31 +0200
Message-Id: <178423785144.235120.18069503062016147688.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,suse.de,queasysnail.net,tuxdriver.com,universe-factory.net,gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,0sec.ai:email,0sec.ai:url]
X-Spam-Level: 
X-Spam-Score: -2.30

On Thu, 16 Jul 2026 22:34:59 +0200, Doruk Tan Ozturk <doruk@0sec.ai> wrote:
> A tunnel changelink() operates on at most two netns, dev_net(dev) and
> the sticky underlay netns vxlan->net. They differ once the device is
> created in or moved to a netns other than the one the request runs in.
> The rtnl changelink path checks CAP_NET_ADMIN only against dev_net(dev),
> so a caller privileged there but not in vxlan->net can rewrite a vxlan
> device whose underlay lives in vxlan->net.
> 
> vxlan_changelink() validates and applies the new configuration against
> vxlan->net (vxlan_config_validate(vxlan->net, ...)) and can reopen the
> underlay socket in that netns, so the same reasoning as the tunnel
> changelink series applies here.
> 
> Gate vxlan_changelink() with rtnl_dev_link_net_capable(), at the top of
> the op before any attribute is parsed, matching ipgre_changelink() and
> the rest of the "require CAP_NET_ADMIN in the device netns for
> changelink" series.
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> Fixes: 8bcdc4f3a20b ("vxlan: add changelink support")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!
