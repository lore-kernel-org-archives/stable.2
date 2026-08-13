Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F9B47604A;
	Thu, 13 Aug 2026 15:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786634612; cv=none; b=n4kFSINFzS3L+TSLDer/5XeeghuPTx8KWI+vFr9OrAYCMNfM/cjWA+RBq9pX3mLv0io0z1RVgFrsH15f4wiBThikM1dvb81qVTraAauYAVbatQdz+Ph9x/p4hxm8qI6Pv0hbyNOvBn6o1IsVNbAYR8RbwsN367bwbPZSCfPE/no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786634612; c=relaxed/simple;
	bh=2B0CPWEWEG8m++OZ6EwFBRoNbGzJ//pmCUiFvHsbWu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CsQifmi85fLdVIEJ086cXq6OGSQ13PW3ja4xVsuMOZonS2ji9olxFusSL5rBn9kQ+/yrGD3vxLUxXXIq52g0qgBxKEZZTJ4i2Sa749pYj9U2Ct3DiGuzNHLCs98CEv6PZtEQFVQ8gDjWpYIt5wudmK3NqjNfSherjqNSBWiPTPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=omROdkW8; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xWXTOLPv; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=UpzBWAkT; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vhUsTNwU; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="omROdkW8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xWXTOLPv";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="UpzBWAkT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vhUsTNwU"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 91C01829B6;
	Thu, 13 Aug 2026 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786634601; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9c0W7+Qi65NnGMLOX7a+AOvxMLs7RmJF4HQmM9BUTA=;
	b=omROdkW8VWOd/OPZEdiY6fNZwnrNb7QI47DuWZtZp/dpYvPfv4tWH7HtljbpyUhiT8gECf
	8hD1RCEhCs8ZqYmL3UWDvjA5xKl6IYcOcgumdoFTkka17Y8neDwEWcI1hzEKzYegv/DqSx
	Bc9DwoleVqbAk0EIi+P3kpfLE9MeJds=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786634601;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9c0W7+Qi65NnGMLOX7a+AOvxMLs7RmJF4HQmM9BUTA=;
	b=xWXTOLPvet21H9ghPgTyel1CNUXlll+R7v++s/fG7T/32gSSTfXaXoQW1sUuUuUOC/oXik
	wBo8SE/t3u0MNnDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=UpzBWAkT;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=vhUsTNwU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1786634597; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9c0W7+Qi65NnGMLOX7a+AOvxMLs7RmJF4HQmM9BUTA=;
	b=UpzBWAkTSakchOv1HBSKgOzMO4KuuUnuQ2MWxcIRgI6gWJDI3MViSiGXChMJX9nfgbo5//
	HWZ5JEK/ZOZQaiMZlPo8BjieQ3HqtUFgSaq918OZNR8nRMFhq7MkMZzOogKw2E0274ndF6
	PoOmqltFaNvZvWY/eOuNjJK6sY2qUk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1786634597;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r9c0W7+Qi65NnGMLOX7a+AOvxMLs7RmJF4HQmM9BUTA=;
	b=vhUsTNwUNneYjNPb7CuW23z17Eitwo3XIY8V40j7NH8ES7XdjYKGnQ3K4sla8K5tfCe34j
	qoWZNuRO1J9dlbCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9006277EAD;
	Thu, 13 Aug 2026 15:23:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bbjcH2PhfWoOeAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Thu, 13 Aug 2026 15:23:15 +0000
Date: Thu, 13 Aug 2026 16:23:13 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Nikunj A. Dadhania" <nikunj@amd.com>, Mike Rapoport <rppt@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	David CARLIER <devnexen@gmail.com>, David Hildenbrand <david@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Jiri Slaby <jirislaby@kernel.org>, Juergen Gross <jgross@suse.com>, 
	Kevin Tian <kevin.tian@intel.com>, Kiryl Shutsemau <kas@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Steffen Dirkwinkel <lists@steffen.cc>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Toshi Kani <toshi.kani@hpe.com>, Vishal Moola <vishal.moola@gmail.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Will Deacon <will@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, stable@vger.kernel.org, 
	syzbot@syzkaller.appspotmail.com, x86@kernel.org
Subject: Re: [PATCH v2 0/5] x86/mm/pat: CPA fixes
Message-ID: <an3hHhEgV2K8bVEE@pedro-suse>
References: <20260813-cpa-fixes-v2-0-39b4ff90f91d@kernel.org>
 <9cfaa5d1-83b4-4b88-bf3a-05d2e074cadf@amd.com>
 <an3dkOKWdajK09KN@lucifer>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an3dkOKWdajK09KN@lucifer>
X-Spam-Score: -2.51
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 91C01829B6
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCPT_COUNT_TWELVE(0.00)[33];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[amd.com,kernel.org,linux.intel.com,linux-foundation.org,alien8.de,gmail.com,redhat.com,ziepe.ca,suse.com,intel.com,infradead.org,zytor.com,linux.dev,steffen.cc,google.com,hpe.com,lists.linux.dev,vger.kernel.org,kvack.org,syzkaller.appspotmail.com];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLziudqfrzo6b7hzgpxksh1d9i)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

On Thu, Aug 13, 2026 at 04:07:38PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Thu, Aug 13, 2026 at 08:35:21PM +0530, Nikunj A. Dadhania wrote:
> >
> > Tested v2 on a 512-guest concurrent boot harness across 200 iterations
> > with no splats. Both crash signatures reported in [1] are no longer seen.
> >
> > Tested-by: Nikunj A Dadhania <nikunj@amd.com>

Nice!

> 
> Thanks so much for the testing!
> 
> And all credit to Pedro for reporting and contributing the key commit that
> resolves this issue :)

And all credit to you for starting this flurry of fixes and patches that
solve Critical Kernel Issues(tm)! My fix would be nothing without yours!

-- 
Pedro
