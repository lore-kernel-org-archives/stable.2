Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817126;
	b=hNJ0nig1yNAiw8KPWr/7re6fLkuBO+37zPbNqiVg3JHGwM+kmE1SIU5msugOgT7jyA/6
	 M90E1KD8XRvTSYYwZa+UUaUAquSLgw75XtATFWG4FWONJEgkMjO6q+mAemD24iyzx5nJA
	 HTaIZ2MKBtgpHW8R5J8FwmJk/p4vG2UMApmICL1s6XNr1NjpSAIs0Cc96k6C2h2gKav6p
	 ZUdBzpLH2hmo0Vei7lxDPBX3a4AUvwzJOiuvenkwUgDV+K3NyBTFyuYdLRWMHwCfGsobM
	 nSI2jblye+0YoJoKuSoKBPQ0yB1b3TZHdFbEQU6DJmRRViCHbs8KVXL5dh+HP/L+syw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817126;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Rspamd-Server:X-Rspamd-Action:X-Spam-Flag:
	 X-Spam-Score:X-Spam-Level:X-Rspamd-Queue-Id;
	bh=cS1qBES1VuLe2M/hg/1JmxoAVCdTAa567ydVE58sAFc=;
	b=Od2Md8M5YME2POfPc+V0uB0i/3EFhMWjnUHUnzxeHATqGot7uMfAI9K2EW1h7nU6jIWE
	 pC8kNP5tPNchScxAIv3oDniw50nHuzYS4w76yXxjeHfRST4dS2HcBHOO+oKvQl9JBXCC3
	 VWIKq4U2NM7w1N+pYM7K7cs5C3zFUF0ui3LEou4p98ftqAMFf82yYQzvFBQcHmq6hiTo+
	 +8pb6FUG2Wm2pbfTaR5yrqvjWw9Jm9F+XcDXrEfNa8LMWLit6ld6BmeVDCU5TtZl0Q8Fj
	 x/UUJ+S1vHSeC/DJ5OS+E52yCcFVMIJ3OqZjUnWSo93AdDNMOxMw5qB4aYgCNT88GXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FbTcjs8L;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZzPHVtN3;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FbTcjs8L;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZzPHVtN3;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B481606A334;
	Fri, 27 Nov 2026 22:05:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B481606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FbTcjs8L;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZzPHVtN3;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=FbTcjs8L;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=ZzPHVtN3
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 874DE22A2C;
	Fri, 27 Nov 2026 22:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795817123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cS1qBES1VuLe2M/hg/1JmxoAVCdTAa567ydVE58sAFc=;
	b=FbTcjs8LvvXAB9Ongw+Qi71nreN/kKlpgxFckFaDvMRrl/OI/DU5AOoGOPVO66uEPe0hp8
	bZpdpNWlffmfCNUUC4NCa/1zwSXjdkXmke61tw70dToD/tkD4SqwpPBd3MqWsistyTh2Pe
	Up2ZmS484gQ/GTcNpv155H3u3Lqi5+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795817123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cS1qBES1VuLe2M/hg/1JmxoAVCdTAa567ydVE58sAFc=;
	b=ZzPHVtN3zcptr6CJ2gr/McwDyEAZP73QxOp9iWITyPWJ6/PJ5zYUcbgcLr0AAZ85uIxnMs
	8nuElFGm/PiJKzBw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=FbTcjs8L;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ZzPHVtN3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795817123; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cS1qBES1VuLe2M/hg/1JmxoAVCdTAa567ydVE58sAFc=;
	b=FbTcjs8LvvXAB9Ongw+Qi71nreN/kKlpgxFckFaDvMRrl/OI/DU5AOoGOPVO66uEPe0hp8
	bZpdpNWlffmfCNUUC4NCa/1zwSXjdkXmke61tw70dToD/tkD4SqwpPBd3MqWsistyTh2Pe
	Up2ZmS484gQ/GTcNpv155H3u3Lqi5+o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795817123;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cS1qBES1VuLe2M/hg/1JmxoAVCdTAa567ydVE58sAFc=;
	b=ZzPHVtN3zcptr6CJ2gr/McwDyEAZP73QxOp9iWITyPWJ6/PJ5zYUcbgcLr0AAZ85uIxnMs
	8nuElFGm/PiJKzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D93D134E8;
	Fri, 27 Nov 2026 22:05:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id yNJJE6H+CWvTIAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 27 Nov 2026 22:05:21 +0000
Date: Fri, 27 Nov 2026 22:05:19 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, 
	Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, David Rheinsberg <david@readahead.eu>, 
	Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Jann Horn <jannh@google.com>, Alex Shi <alexs@kernel.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, David Rientjes <rientjes@google.com>, 
	Rik van Riel <riel@redhat.com>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	=?utf-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>, Arnd Bergmann <arnd@arndb.de>, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	codalist@coda.cs.cmu.edu, linux-mm@kvack.org, Andrei Vagin <avagin@gmail.com>, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] coda: never point a file's f_mapping at a
 container's mapping
Message-ID: <awn9xtkK5k_dB2r_@pedro-suse.tail5790ac.ts.net>
References: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
 <20261127-mlock-madvise-mprotect-ai-fixes-v1-1-e46b2b1eb435@kernel.org>
 <20261127124428.f1f66c6244d3e5c2811f56de@linux-foundation.org>
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
In-Reply-To: <20261127124428.f1f66c6244d3e5c2811f56de@linux-foundation.org>
X-Spamd-Result: default: False [-13.51 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
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
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,cs.cmu.edu,readahead.eu,google.com,infradead.org,cmpxchg.org,redhat.com,suse.com,lwn.net,linuxfoundation.org,rere.qmqm.pl,arndb.de,canb.auug.org.au,arm.com,coda.cs.cmu.edu,kvack.org,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[suse.de:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	R_RATELIMIT(0.00)[to_ip_from(RLrsmib7z51yjcgqxjkjha4j4m)];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -13.51
X-Spam-Level: 
X-Rspamd-Queue-Id: 874DE22A2C

On Fri, Nov 27, 2026 at 12:44:28PM -0800, Andrew Morton wrote:
> On Fri, 27 Nov 2026 19:45:40 +0000 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
> 
> > Coda file systems stack differently from other stacked file systems.
> > 
> > On mmap(), coda_file_mmap() switches both the Coda inode's i_mapping and
> > the Coda file's f_mapping for the mapping of the container file. This
> > causes two problems.
> > 
> > Firstly, the container file may not remain pinned, at which point this may
> > result in a dangling reference in coda_file->f_mapping, and so a
> > use-after-free in mmap() or lseek().
> > 
> > This can happen when you open the same inode across two files, mmap()'ing
> > in one, which assigns the i_mapping, and open()'ing another, which assigns
> > that i_mapping to the file's f_mapping, if the cache manager gave the two
> > files different containers. Each file pins only its own container.
> 
> Yeah, I hit this while getting
> tools/testing/selftests/mm/memory-failure.c to work on all Linux
> filesystems.
> 
> > --- a/fs/coda/file.c
> > +++ b/fs/coda/file.c
> > @@ -182,7 +182,6 @@ coda_file_mmap(struct file *coda_file, struct vm_area_struct *vma)
> >  
> >  	cii = ITOC(coda_inode);
> >  	spin_lock(&cii->c_lock);
> > -	coda_file->f_mapping = host_file->f_mapping;
> >  	if (coda_inode->i_mapping == &coda_inode->i_data)
> >  		coda_inode->i_mapping = host_inode->i_mapping;
> >  
> 
> I had this change.
> 
> > @@ -248,6 +247,19 @@ int coda_open(struct inode *coda_inode, struct file *coda_file)
> >  
> >  	host_file->f_flags |= coda_file->f_flags & (O_APPEND | O_SYNC);
> >  
> > +	/*
> > +	 * On mmap coda_inode->i_mapping is updated to point at the mapping of
> > +	 * the mmap()'d file's container, and do_dentry_open() propagates that
> > +	 * to coda_file->f_mapping.
> > +	 *
> > +	 * However coda_file's container may differ, in which case the lifetime
> > +	 * of that mapping may not match that of coda_file.
> > +	 *
> > +	 * To avoid a dangling pointer, reassign the mapping to the canonical
> > +	 * one.
> > +	 */
> > +	coda_file->f_mapping = &coda_inode->i_data;
> > +
> >  	cfi->cfi_magic = CODA_MAGIC;
> >  	cfi->cfi_mapcount = 0;
> >  	cfi->cfi_container = host_file;
> 
> But not this one.
> 
> Is it truly needed, or is it a future-safe defensive thing?
> 
> If the latter, Tested-by-me:.  If the former, Mostly-tested-by:me. 
> Either way, Acked-by:me.
> 
> 
> It's always seemed a big wart that file->f_mapping even exists.  We
> should get that via file->f_inode->i_mapping!  But you-know-what tells
> me that "/dev/mem sets the opened file's f_mapping to the shared
> I/O-memory mapping; /proc/bus/pci does the same.  Their f_inode still
> identifies the device or proc entry" so sigh.

FWIW, I think it's a rather nice part of the Linux VFS design: "file" and
"inode" are separated well enough to allow for these kinds of shenanigans
without awful hacks (and, yes, this is also present for something standard
like a block device on /dev; /dev is a tmpfs mount, so the inode is tmpfs, but
the mapping and fops cleanly point to block).

But stacked filesystems, admittedly, do give me motion sickness.

-- 
Pedro
