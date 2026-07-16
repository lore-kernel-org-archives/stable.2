Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0C82045AD
	for <stable@vger.kernel.org>; Thu, 16 Jul 2026 21:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784237877; cv=none; b=qlV6z03Vu/3pUB54KJ1C+1Ft5yK2zgDCZFBW/GI0qBuLOHI5oB49vpliWOU4ZcYm8Ydh1p13Ym2TAU+FFVBoCsj35YQVT6w/zVK2SE3vT/6mLbFuexab8VaA9XHp2VUY3U1RZOkTx6T4BLhcUB6l3GTaK5KKyDSXLZvZfbZwcRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784237877; c=relaxed/simple;
	bh=mCDPCJAotZrB1Cv5XTQKUnAyuHiGHB/+UMEviEZlbzE=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=LOfIX7xUop1NWIBRWB0Wn+ajV/t6Un+yChytLdh+yWXUS//C3lMhxLexELSV8trZQYiw+BqgueFXhbGNiVJJpDssyiydw8syhpHK0Dobb6doQF0WIJatccW36RgWK++LDpdwG7q1srnveUNnbGJhXImzw0jfVOKElTbmmUuNvnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fOsd6C2D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y7yI/eAn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=fOsd6C2D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=y7yI/eAn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fOsd6C2D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y7yI/eAn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fOsd6C2D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="y7yI/eAn"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 933663E2F;
	Thu, 16 Jul 2026 21:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784237866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnebozS6QJhS2X7twaFcusa88EZNqoa76Ua28sbuN04=;
	b=fOsd6C2DJW8eyzDpkfa42H5S8p7d2GlxeQz5ws2CbUg6E4KvoGmcL5GkIV9//U4CPL2LDP
	xo3JvyI50hvuB+wR9ao0I4itr3Tx//pw3Om7L0YuYHPVK7+c1zm9AN/94vROVVfXsDz6Rk
	T2R4AlbauSEwJDzzqNdfy+e+qkm0ADY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784237866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnebozS6QJhS2X7twaFcusa88EZNqoa76Ua28sbuN04=;
	b=y7yI/eAndJZ3tKIc0kmrR0qfGE5FbztmrS0ot3prziBiRMdP3ufRro+svLxaSVJ3W7Xe2w
	qqhB7xjHtV7/u7AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fOsd6C2D;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="y7yI/eAn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784237866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnebozS6QJhS2X7twaFcusa88EZNqoa76Ua28sbuN04=;
	b=fOsd6C2DJW8eyzDpkfa42H5S8p7d2GlxeQz5ws2CbUg6E4KvoGmcL5GkIV9//U4CPL2LDP
	xo3JvyI50hvuB+wR9ao0I4itr3Tx//pw3Om7L0YuYHPVK7+c1zm9AN/94vROVVfXsDz6Rk
	T2R4AlbauSEwJDzzqNdfy+e+qkm0ADY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784237866;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnebozS6QJhS2X7twaFcusa88EZNqoa76Ua28sbuN04=;
	b=y7yI/eAndJZ3tKIc0kmrR0qfGE5FbztmrS0ot3prziBiRMdP3ufRro+svLxaSVJ3W7Xe2w
	qqhB7xjHtV7/u7AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C3069779AE;
	Thu, 16 Jul 2026 21:37:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cFCkLClPWWqsXAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 16 Jul 2026 21:37:45 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net v2 2/2] geneve: require CAP_NET_ADMIN in the device
 netns for changelink
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 pabeni@redhat.com, andrew+netdev@lunn.ch, fmancera@suse.de, 
 sd@queasysnail.net, linville@tuxdriver.com, mschiffer@universe-factory.net, 
 maoyixie.tju@gmail.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260716203500.70573-3-doruk@0sec.ai>
References: <20260716203500.70573-1-doruk@0sec.ai>
 <20260716203500.70573-3-doruk@0sec.ai>
Date: Thu, 16 Jul 2026 23:37:31 +0200
Message-Id: <178423785144.235120.6881009495052625519.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 933663E2F
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,suse.de,queasysnail.net,tuxdriver.com,universe-factory.net,gmail.com,vger.kernel.org];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[0sec.ai:email,0sec.ai:url,suse.de:email,suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

On Thu, 16 Jul 2026 22:35:00 +0200, Doruk Tan Ozturk <doruk@0sec.ai> wrote:
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
> Fixes: 5b861f6baa3a ("geneve: add rtnl changelink support")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
>

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks!
