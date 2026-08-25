Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F71E3E5588;
	Tue, 25 Aug 2026 08:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787647246; cv=none; b=ZSHUSSIkp3UaKSFD5QA/oNtPYy9EsANNHW8avWQyNUSJ1DXPDb4W2GjSFj03P303YXJJc1V5hqZxyRYEB36Xk9WE6gzOsU+cr2chhJ2E/cca0Up6ObvZobEGtPNJxSmaWOxsvW6OfrFZm0kYAA6vQDf46JPjgbuJngjOgwMJCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787647246; c=relaxed/simple;
	bh=zEI6B5W1ZBsfPG7yJLa65KStnlogwSjapD8ZpZXa8lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I/kQxkhcSR6KFXR6K4FZjnhesjKvXiMkNbv5A37sIxeu8aeup99g3dHBSzfKRha/phyxdDdqxpzXNHCPmgzO2jUTC6Qvm2XFF42c9UwIwEAPv7ZUxf6b0Esa6v4IGd8Dlx1JpOSAfs5oDVHSryOHA5MSAmey3ehfgGHLodUKmqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=EYYdCdiw; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=NrOw/zmj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=TWQ+t5aK; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QURYyCTb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="EYYdCdiw";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="NrOw/zmj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="TWQ+t5aK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QURYyCTb"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C6AAF1F7B3;
	Tue, 25 Aug 2026 08:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787647238; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9RmSEUx5DQwDo4gSgt9njDplt37d7EmELQcf1wHlvzo=;
	b=EYYdCdiwzbwm2XbfG83NClbayGhlooeQcFhtxQcX9FcoG1+uMXYn5D3DXjew/zIoUultCR
	eAynFepWrPCEbqphcLWFYiyeOjrwCsKCsXVLgCSTmQ5SfvfP5m0+fm8bpd33+jiCkH2tLZ
	W+zyc71UHL58aXzrbNcFAYtVGjBi3i4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787647238;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9RmSEUx5DQwDo4gSgt9njDplt37d7EmELQcf1wHlvzo=;
	b=NrOw/zmjxnCIxFsAAl1No4JLgnuZdNaMWHaSYWKkkyx4bvHA5ZQxjObwJEdcnvJkhjHX0B
	WnBQ4PKtbOZJkhBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TWQ+t5aK;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QURYyCTb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1787647234; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9RmSEUx5DQwDo4gSgt9njDplt37d7EmELQcf1wHlvzo=;
	b=TWQ+t5aKUEmQsPj+oJQDdPn156f/KLn7ugDyjYRMmKArrkz9MqNanDp8iFxMMcKubkKu2k
	dOw2gHmq6x4ZJFAq27uRKR4H+hKBIZThthSsXBFvZ/hVxSYFtApjQItHn/8HpLV05Us8KP
	w45GT0qF/B98rot5Vfm6u73WnCW7tHs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1787647234;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9RmSEUx5DQwDo4gSgt9njDplt37d7EmELQcf1wHlvzo=;
	b=QURYyCTbBcyztX2JZcsKq9ZlNCoNCRQcvlMIls4cebfLJMoFKYXKA5E/SA4WaUsU8dofPO
	HBPr3OR+R8N3vADw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4860313331;
	Tue, 25 Aug 2026 08:40:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5bBvDgFVjWo2GgAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 25 Aug 2026 08:40:33 +0000
Date: Tue, 25 Aug 2026 09:40:31 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "David Hildenbrand (Arm)" <david@kernel.org>, 
	Christoph Hellwig <hch@infradead.org>
Cc: Kiryl Shutsemau <kas@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	usama.arif@linux.dev, hughd@google.com, akpm@linux-foundation.org, baohua@kernel.org, 
	baolin.wang@linux.alibaba.com, dev.jain@arm.com, liam@infradead.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, ljs@kernel.org, nico.pache@linux.dev, 
	ryan.roberts@arm.com, ziy@nvidia.com, nphamcs@gmail.com, hannes@cmpxchg.org, 
	riel@surriel.com, shakeel.butt@linux.dev, kernel-team@meta.com, 
	stable@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH] mm/huge_memory: transfer the pmd dirty bit to the folio
 on zap
Message-ID: <ao1R1Dh-42ALMq7o@pedro-suse>
References: <aoXYh9EPF6QnlvIK@pedro-suse.lan>
 <20260820061337.24669-1-lance.yang@linux.dev>
 <aobp2CtWZBlw4w7E@pedro-suse.lan>
 <aob9PF_H6CCJMdkk@thinkstation>
 <aocFPRgqieScf_yo@pedro-suse.lan>
 <ao0vSde26_Qar0IZ@infradead.org>
 <2614286d-19ed-4848-8ce6-59ebecf19d1d@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2614286d-19ed-4848-8ce6-59ebecf19d1d@kernel.org>
X-Spam-Score: -4.01
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C6AAF1F7B3
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,google.com,linux-foundation.org,linux.alibaba.com,arm.com,infradead.org,vger.kernel.org,kvack.org,nvidia.com,gmail.com,cmpxchg.org,surriel.com,meta.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Tue, Aug 25, 2026 at 10:04:31AM +0200, David Hildenbrand (Arm) wrote:
> On 8/25/26 07:59, Christoph Hellwig wrote:
> > On Thu, Aug 20, 2026 at 03:10:11PM +0100, Pedro Falcato wrote:
> >>> Why? Write batching from large folios is a win.
> >>
> >> For some context: we were discussing (off-list) the recent report that
> >> systemd-journald had horrible write amplification, worsed quite a bit
> >> by large folios. At the moment, there is quite a lot of write amplification,
> >> but _only_ on mmap writes (if you look at the write(2) paths, you'll see
> >> write_begin and write_end which tactically only dirty what you actually wrote
> >> to, block-wise in the BHs or iomap IFS). This doesn't need to be true.
> > 
> > So don't use mmap to write to storage.  That is always a bad idea for
> > many, many reasons.  We should not work around broken applications that
> > do this, but change them.  It only took about 10 years of bad reputation
> > for MongoDB to finally fix their act, so it should be possible for
> > systemd as well.

That is true. However, I don't think that should stop us from providing
reasonable semantics for those that use mmap.

Fundamentally:
 - For the common, PTE-level case: we get the granularity for free, the
filesystem only needs to be notified accordingly.
 - For the less common, PMD-level case: we already aggressively break these
down on mkwrite faults; I think doing this is the right tradeoff. Screw the TLB
in that case :)

And, frankly, half of the problem (and related to the GUP thread) is that
page_mkwrite is a crap interface... Something like ->write_begin() being
generalised to more than read(2)/write(2) could possibly solve most of these
issues (or a ranged dirty_folio).

> 
> I was in contact with systemd folks (and pulled in Willy and Jan) regarding
> that, and nothing should really block that.

Awesome!

-- 
Pedro
