Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793106311;
	b=Oee85BwdQ5R2uvWS/+O84gq4Ii+hipuld0F+GetUi5ayaUAL7LEtaHK4ry6GdQ6G1XZM
	 nDPPtUaesxu1FexlyQyFtgpdwCWWwX9WTp56sExIhXRe9GmmqL4b/MeW38I6hSMvE8OWr
	 qyFbFpczqe/0l5+W3JwPCghShWtgGeeDe8KuH9n0ZENqSZniBQN7eOP1VAzonreOPPBnd
	 X9yUrFP4orw9MpEAGR93yL/6twe8JbAMAQSvv/x7j72B5I1bfNdsrRzQEDtjPpHPDTvgr
	 73WovbIduvWth8DzSFWcFn3M9NaYsxv3QoMIn2hirqG5WZOjMK4OOug8hGg/wUMhu0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106311;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=vxlXm+JcRuAJZIHAVM0FX8ZHdQ6f/pCfzF5ht6AP94U=;
	b=dqniVAQsyNs4AsMED3KwuAyq8jKYFDcYNsTybEok4Ccr8tWH9v2LRose890Dfu4lM7we
	 YSllVUxSpzGO6RKI6ZeYBVMgR5GGXjsR+BK69TggMM1J9xRKm58P8LTElx2p13X2XWk3N
	 vZgIh8G+wUrU5bUGGXIyX7o1op1X2vzqrVYSj/hp+T+66R5v6ZyPNTKs5pkRFTqYSJ0IE
	 5p+9PcnRirEGfgKsb0Q9hXW8DH/bnw1v0LgMepCIKU5YZ1ftkCwgABn2aaM1mNcEYEzm8
	 xNzknqE22P8WK/RtxhlF9Jw1TrMHQpRk6Azyvi08d3kRNcCr50SeBDZzhpN9UfE1mBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2TIJK6kS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mNR5ZW0F;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OxTEdmT4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oSENy4AI;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5405D606A32F;
	Tue, 27 Oct 2026 13:05:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5405D606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=2TIJK6kS;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=mNR5ZW0F;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=OxTEdmT4;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oSENy4AI
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1506D21F1B;
	Tue, 27 Oct 2026 13:05:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793106308; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vxlXm+JcRuAJZIHAVM0FX8ZHdQ6f/pCfzF5ht6AP94U=;
	b=2TIJK6kSYwtJxtHRZ39rZVVNY0AR31nfI1PuejIxbZeiZiqFy+GRSKfHWknogiqkslYvcu
	nwjCSAKVQcOn/7DX1/dxfBbtKy9vQnW/YzoXcofN0xgCHg/yDNad/G/G0U4jOy8mjcgntl
	xbeHVhv1LjkWY428Umn/cCGhSRR56Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793106308;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vxlXm+JcRuAJZIHAVM0FX8ZHdQ6f/pCfzF5ht6AP94U=;
	b=mNR5ZW0FeJZXkqsRpkN0o/2uKcITi/xifXB3YJyDN4d/WNvxHj/bsNGHDAc3RbUNTyrpFL
	KGoUlPgd2434IcBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=OxTEdmT4;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oSENy4AI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1793106307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vxlXm+JcRuAJZIHAVM0FX8ZHdQ6f/pCfzF5ht6AP94U=;
	b=OxTEdmT4nSTnt7CdzJcgf3rZM4SwpU44Udr1Rq3aynEJaCDdIxhebT3D7yyqOpiuzV6Voz
	zHgvtKJiGBt+7yUibaJ9BivFj7e+fiSnIxxdGgCiLS0G7w1rS664T6d0U1VBCCg7htIe4q
	EFITZastB4c8RFfbOQk5RcBRaBrnIWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1793106307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vxlXm+JcRuAJZIHAVM0FX8ZHdQ6f/pCfzF5ht6AP94U=;
	b=oSENy4AIIUzpSEatcjRKcZCBduwcXroNH+DqUF1imGtnVA5oX9JDQtd4g2pXvs/DlHuWfp
	Ity9Qu5b+pbCG0Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D13C13319;
	Tue, 27 Oct 2026 13:05:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gzdcGYGh4GpsMgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 27 Oct 2026 13:05:05 +0000
Date: Tue, 27 Oct 2026 13:05:03 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org, 
	ziy@nvidia.com, baolin.wang@linux.alibaba.com, liam@infradead.org, 
	nico.pache@linux.dev, ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org, 
	usama.arif@linux.dev, kas@kernel.org, jack@suse.cz, djwong@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, hch@lst.de, 
	ngocthang2710.1999@gmail.com, syzbot+16bf7cd0ebeb1de93aa5@syzkaller.appspotmail.com, 
	stable@vger.kernel.org
Subject: Re: [PATCH v4] khugepaged: fix readahead lock inversion in
 collapse_file()
Message-ID: <auCg6dXegweUB5m0@pedro-suse.tail5790ac.ts.net>
References: <20261026152013.10511-1-lance.yang@linux.dev>
 <321017a4-58cb-4178-8ff2-055a9bbb28b6@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <321017a4-58cb-4178-8ff2-055a9bbb28b6@kernel.org>
X-Spamd-Result: default: False [-12.01 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[20];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,linux-foundation.org,nvidia.com,linux.alibaba.com,infradead.org,arm.com,kernel.org,suse.cz,kvack.org,vger.kernel.org,lst.de,gmail.com,syzkaller.appspotmail.com];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TAGGED_RCPT(0.00)[16bf7cd0ebeb1de93aa5];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -12.01
X-Spam-Level: 
X-Rspamd-Queue-Id: 1506D21F1B

On Tue, Oct 27, 2026 at 12:06:05PM +0100, David Hildenbrand (Arm) wrote:
> On 10/26/26 16:20, Lance Yang wrote:
> > collapse_file() can call page_cache_sync_readahead() while still holding
> > source folios locked. If truncate holds mapping->invalidate_lock
> > exclusively and waits for one of those folios, readahead waits for
> > invalidate_lock and neither side can make progress.
> > 
> > We need to release those folio locks before starting readahead. On a page
> > cache miss, roll back first, populate the collapse range, and retry once.
> > Doing readahead after rollback avoids an extra pass when all folios are
> > already present. If another miss occurs on retry, give up rather than keep
> > retrying while truncate or reclaim removes folios.
> 
> Makes sense. So we simply try readahead on all folios.
> 
> Any reason we don't simply add a second loop after the first loop where we don't
> take the folio locks and do the swapin/readahead dance, then a second loop where
> we do all the other stuff?

I'm not sure I understand. You want to nest two loops? Or do you want a loop
upfront? I don't think we want a loop upfont. That's slow and involves
starting/waiting for IO. Fallback logic makes more sense IMO.

FWIW, I plan on rebasing my refactoring patches for 7.5, and hopefully knock
some sense into this code. That will hopefully make this cleaner.

-- 
Pedro
