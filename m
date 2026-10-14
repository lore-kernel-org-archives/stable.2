Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC94EB84D;
	Wed, 14 Oct 2026 12:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982065; cv=none; b=CcywmluvE5LwiyoptcR7xiz0cMkE/6Q4kJk2gyax6sYx61RWJBV9rZBXz/1C66XYOflO8Ff+8hrdG8jcH4qPQYH6JvtLLVYq706gf2vWL1Qc1c15mibNxvXwp9bNyjB/H5GqGm5URfVlPZRCMgmzjUz3ur1wVRCJDBqsZmnI6D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982065; c=relaxed/simple;
	bh=vJ+y95NY3zFzS7ay4qYhbYAYNljlO01sOEpzfkw68Mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bPOtqGkatoY2COIyM7pdTI3ooOkvktCyseygWAjj67tdyHub9OruEFadpoReUt9WUQEl7t4/8q+leRoLBNS7gm5T12OBCpVZCaIndcQP8x/t8kyKkHDq6ajxY8/1oQJbyubogkMnbwyAXhaBSpd9YUcjjfIA3WZSV7OAZT1dOo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=FCkPvbmx; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=SLFXcVyT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pEPtb0KI; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=Zk6opYEU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="FCkPvbmx";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="SLFXcVyT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pEPtb0KI";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Zk6opYEU"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3A4A22157;
	Wed, 14 Oct 2026 12:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791982031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ5FuPZQSLLcddc8F4+UNpgQoDesEeQ4ARu/7Faqk30=;
	b=FCkPvbmxrnCXVLHKAEe9d0LZkPAk5oh+SYPUSAbIwGlaYSGZ06mz2hC8dKhxX/3xfYTrvi
	NM0BHQNrQ9D8Z3GUE9RK768AphO1Dt2johxqaMZhAA2LWtS3MVYpHAl/HO6Yf1I+ioduUz
	epA9wUUZIYrpr5Bx7v86QUDzJ2DMFBU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791982031;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ5FuPZQSLLcddc8F4+UNpgQoDesEeQ4ARu/7Faqk30=;
	b=SLFXcVyT1/X9fJQiW0xfRSwbsp2SQ4hKzKYmkuBun4OVOIc4yxyPCsUQCNz4KzHZ50rCUd
	AIRjVpSV4/IyvdBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=pEPtb0KI;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Zk6opYEU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791982030; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ5FuPZQSLLcddc8F4+UNpgQoDesEeQ4ARu/7Faqk30=;
	b=pEPtb0KIQ55LFhdLlCWDsXexv44Wn3RwwfbqaLDlFGHI5NpW5GSAuk9Jt3qJjSWBNoZKVs
	c14dR6xJ5M+LnHfyYxLjWWezKxfmsvqOOAfaTTG32MCKxhxMMV3+j7NLR6cPohjcZNKSQD
	lIxgeU8cIVHIEDHMyCa/NMLijiCJp5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791982030;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vJ5FuPZQSLLcddc8F4+UNpgQoDesEeQ4ARu/7Faqk30=;
	b=Zk6opYEUHCAAlEHOM+ihvqNS5ERLsh/ZdZmd6OUgv+XZ4gIIW+mQKObazh0YQVCCSuUHvA
	XYGkKhiL+mYItnAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AC6541368E;
	Wed, 14 Oct 2026 12:47:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id vi5DIc55z2r9DQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 14 Oct 2026 12:47:10 +0000
Date: Wed, 14 Oct 2026 14:47:05 +0200
From: Daniel Wagner <dwagner@suse.de>
To: martin.nvme.dev@gmail.com
Cc: linux-nvme@lists.infradead.org, Keith Busch <kbusch@kernel.org>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Hannes Reinecke <hare@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH v2] nvme: make the DH-HMAC-CHAP secret attributes
 readable by root only
Message-ID: <c26a89df-4d19-43bb-8bb5-631a132ef6e7@flourine.local>
References: <20261014-nvme-dhchap-secret-mode-v2-1-00f153e9d8de@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-nvme-dhchap-secret-mode-v2-1-00f153e9d8de@gmail.com>
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim]
X-Spam-Level: 
X-Rspamd-Queue-Id: E3A4A22157
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

On Wed, Oct 14, 2026 at 08:02:57AM -0400, Martin Belanger via B4 Relay wrote:
> From: Martin Belanger <martin.nvme.dev@gmail.com>
> 
> The dhchap_secret and dhchap_ctrl_secret sysfs attributes have mode
> 0644. Their show functions return the secret, so any local user can
> read the DH-HMAC-CHAP secrets of a connected controller.
> 
> Define them with DEVICE_ATTR_ADMIN_RW(), which sets mode 0600. The
> macro takes the show and store functions from the attribute name, so
> rename them. Writing the attributes was already limited to root and is
> not changed.
> 
> Fixes: f50fff73d620 ("nvme: implement In-Band authentication")
> Cc: stable@vger.kernel.org
> Cc: Daniel Wagner <wagi@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Martin Belanger <martin.nvme.dev@gmail.com>

Reviewed-by: Daniel Wagner <dwagner@suse.de>

