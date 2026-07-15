Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 320DC478841
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784119002; cv=none; b=Pxbn14KzGc6z+8rl6AhmhROgmvQcMgqZ1qGf3x6if21a0f7SWgLKGOc4dziS4TIKrlN90Ri0KH/r2pMsP0N4nXKaseNbbQxUFM063fCO2t2FhcRQpji9KbM1EoRhDaMZmJZOUSDf0Wjjxp3DADgxZd4bEj8TCMMRA+NkCoyS0nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784119002; c=relaxed/simple;
	bh=BqwoOTXlSzaVxyc8394nWBcxZA0iEShWC3dOodX+E6c=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=IuktZftlqBWHxpcR1iPjXTbjjwh1PEI2nZX0B7fLb/SY7jzisZ88ZPrKr2w1GtyO2kyg6aehdIXflnU1kCGMfpEgo471oIrB0+Ge8AqGoQSeMpSBkLip64oiqlEski1h+B/0Jgyad/+Rm4VaDaarIWKMwfDO/kf7CVKCqBKo//8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WHdPy3yT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x08g8hju; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=WHdPy3yT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=x08g8hju; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WHdPy3yT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x08g8hju";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="WHdPy3yT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="x08g8hju"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 78536778DE;
	Wed, 15 Jul 2026 12:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784118993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oB09iSPtmQ/kRHW8e1Evxy+I2q1EVPr9f5dDcYso2u4=;
	b=WHdPy3yT+8eUjRBMrLqiHZFkNR0E9W3/SkTpjc895kj24xlPBdMFWep0O4ZswaaRcTTYR2
	fS4IH8ByTnfalGtGLMy2+HSuEXfDAMUuo/AOtKO4+pOv6r/9bJonvV5DLwQGZTZP1DJ0XT
	JR1/+IpjeD4ZsuOm7vxa/Fm9lpghZ0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784118993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oB09iSPtmQ/kRHW8e1Evxy+I2q1EVPr9f5dDcYso2u4=;
	b=x08g8hjuA4j1TI4KrASZ53E2mobkaq9FbmU19ntj3U6VSoflTVN34RPr6RF57nRXvjfWQ3
	qCjj1MxZui5U0eDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784118993; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oB09iSPtmQ/kRHW8e1Evxy+I2q1EVPr9f5dDcYso2u4=;
	b=WHdPy3yT+8eUjRBMrLqiHZFkNR0E9W3/SkTpjc895kj24xlPBdMFWep0O4ZswaaRcTTYR2
	fS4IH8ByTnfalGtGLMy2+HSuEXfDAMUuo/AOtKO4+pOv6r/9bJonvV5DLwQGZTZP1DJ0XT
	JR1/+IpjeD4ZsuOm7vxa/Fm9lpghZ0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784118993;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oB09iSPtmQ/kRHW8e1Evxy+I2q1EVPr9f5dDcYso2u4=;
	b=x08g8hjuA4j1TI4KrASZ53E2mobkaq9FbmU19ntj3U6VSoflTVN34RPr6RF57nRXvjfWQ3
	qCjj1MxZui5U0eDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD4DB779AE;
	Wed, 15 Jul 2026 12:36:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0D9CK9B+V2o6XAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 15 Jul 2026 12:36:32 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net 2/2] geneve: require CAP_NET_ADMIN in the device
 netns for changelink
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 pabeni@redhat.com, andrew+netdev@lunn.ch, sd@queasysnail.net, 
 linville@tuxdriver.com, mschiffer@universe-factory.net, 
 maoyixie.tju@gmail.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260715055648.33060-3-doruk@0sec.ai>
References: <20260715055648.33060-1-doruk@0sec.ai>
 <20260715055648.33060-3-doruk@0sec.ai>
Date: Wed, 15 Jul 2026 14:36:23 +0200
Message-Id: <178411898386.23973.7095334918558426655.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Spam-Flag: NO
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,queasysnail.net,tuxdriver.com,universe-factory.net,gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 

On Wed, 15 Jul 2026 07:56:48 +0200, Doruk Tan Ozturk <doruk@0sec.ai> wrote:
> A tunnel changelink() operates on at most two netns, dev_net(dev) and
> the sticky underlay netns geneve->net. They differ once the device is
> created in or moved to a netns other than the one the request runs in.
> The rtnl changelink path checks CAP_NET_ADMIN only against dev_net(dev),
> so a caller privileged there but not in geneve->net can rewrite a geneve
> device whose underlay lives in geneve->net.
> 
> geneve_changelink() applies the new configuration against geneve->net:
> geneve_link_config() and the geneve_quiesce()/geneve_unquiesce() pair
> reopen the underlay sockets in that netns (geneve_sock_add() uses
> geneve->net), so the same reasoning as the tunnel changelink series
> applies here.
> 
> Gate geneve_changelink() with rtnl_dev_link_net_capable(), at the top of
> the op before any attribute is parsed, matching ipgre_changelink() and
> the rest of the "require CAP_NET_ADMIN in the device netns for
> changelink" series.
> 
> Found by 0sec automated security-research tooling (https://0sec.ai).
> 
> Fixes: 2d07dc79fe04 ("geneve: add initial netdev driver for GENEVE tunnels")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
>

The patch makes sense to me but as with the previous one I believe the
fixes tag is wrong. It should be:

Fixes: 5b861f6baa3a ("geneve: add rtnl changelink support")

Thanks,
Fernando.
