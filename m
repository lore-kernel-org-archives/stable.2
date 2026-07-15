Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DBF43B3CB
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 12:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784118996; cv=none; b=oxC9FFvA8NxadHIdZpJfW8k8UjGMfDJ/z+OaVw+aVF5ECT7KB7Q7y/vNxga1CLLGPMjL4+P8X4zB9XJ8cu7SQbaXntsafMQCjGyAjJit6ABKB2x4N0RhtYjLx8NXseL7tJ6exmZPXJPFp2zDdi+kdr7QODsLDjKSfaHNReLJImo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784118996; c=relaxed/simple;
	bh=IatuHyfwLQQvbWzQIAxho2BwnzbGtZaHleZ1LF5eeqY=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=hq+Rd0rfvuoasjtuKJagEBD6uVxvfEYESLliqkfUMEdxfdMrGgsnGTslVDnmgdo1Q6HC+pEfTXX14RxJfHvqHAMuHXa5e0TRsU24eEj9+SDnzQPtbSgk4RGzoaT02OZcLr4Sj09cK3wDHquYuSyZdcvDBoZ9kbCS0yWuZPQ3BG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W7vlsnwQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mmDU5Eji; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=W7vlsnwQ; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=mmDU5Eji; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W7vlsnwQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mmDU5Eji";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="W7vlsnwQ";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="mmDU5Eji"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A9573783BB;
	Wed, 15 Jul 2026 12:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784118992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMEvKsLBP+9lioNe5wVxGNYQ1H3Bizh6VOqrMBcaSRI=;
	b=W7vlsnwQ4M1/XG775I0yFjZ6do7H8/tbb4XozlmyBhVSoN5pmF3GBZrZE8vQv06j8jZxU2
	EDFl9UT9+8gxPUEmjcbIELuHn5TWxMFz0p4eb+JVja0NK2VPD0Vc0QRKOjpf070fBWGFTl
	0/+4f3HkMQblpFytlPFD7qx/tBteeEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784118992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMEvKsLBP+9lioNe5wVxGNYQ1H3Bizh6VOqrMBcaSRI=;
	b=mmDU5Eji+xFyckmyXc3gKaF6iEnSnJGM4LbzM3reWV4ZZr05nrRFyLX/cTksaT4oc9krpK
	EhyxhWNtXtndU2Cg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=W7vlsnwQ;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=mmDU5Eji
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1784118992; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMEvKsLBP+9lioNe5wVxGNYQ1H3Bizh6VOqrMBcaSRI=;
	b=W7vlsnwQ4M1/XG775I0yFjZ6do7H8/tbb4XozlmyBhVSoN5pmF3GBZrZE8vQv06j8jZxU2
	EDFl9UT9+8gxPUEmjcbIELuHn5TWxMFz0p4eb+JVja0NK2VPD0Vc0QRKOjpf070fBWGFTl
	0/+4f3HkMQblpFytlPFD7qx/tBteeEE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1784118992;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMEvKsLBP+9lioNe5wVxGNYQ1H3Bizh6VOqrMBcaSRI=;
	b=mmDU5Eji+xFyckmyXc3gKaF6iEnSnJGM4LbzM3reWV4ZZr05nrRFyLX/cTksaT4oc9krpK
	EhyxhWNtXtndU2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECAC4779AD;
	Wed, 15 Jul 2026 12:36:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4XmpNs9+V2o6XAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 15 Jul 2026 12:36:31 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH net 1/2] vxlan: require CAP_NET_ADMIN in the device
 netns for changelink
From: Fernando Fernandez Mancera <fmancera@suse.de>
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
 pabeni@redhat.com, andrew+netdev@lunn.ch, sd@queasysnail.net, 
 linville@tuxdriver.com, mschiffer@universe-factory.net, 
 maoyixie.tju@gmail.com, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20260715055648.33060-2-doruk@0sec.ai>
References: <20260715055648.33060-1-doruk@0sec.ai>
 <20260715055648.33060-2-doruk@0sec.ai>
Date: Wed, 15 Jul 2026 14:36:23 +0200
Message-Id: <178411898386.23973.9996844791788311105.b4-review@b4>
X-Mailer: b4 0.16-dev
X-Spam-Flag: NO
X-Rspamd-Action: no action
X-Spam-Level: 
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,queasysnail.net,tuxdriver.com,universe-factory.net,gmail.com,vger.kernel.org];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TAGGED_RCPT(0.00)[netdev];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A9573783BB
X-Spam-Score: -2.51

On Wed, 15 Jul 2026 07:56:47 +0200, Doruk Tan Ozturk <doruk@0sec.ai> wrote:
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
> Fixes: 889ce937c98f ("vxlan: correctly set vxlan->net when creating the device in a netns")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>
>

The patch makes sense to me but I believe the right fixes tag would be:

Fixes: 8bcdc4f3a20b ("vxlan: add changelink support")

Thanks,
Fernando.
