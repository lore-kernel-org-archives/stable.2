Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795816899;
	b=LNtqe0yhBSKSmRHz22eeZYuRq3oT2ZCcNQ+kLZe9GrfU7Kqd/VByftfIL7yH2/OsMoij
	 yQ4cPjlJVp/+CCu6wr/ygMHWISGP8VkdesAUaWYci71GKrIPQLxw3O96xbHJuLJGuul9l
	 5iAWRUUR3vh/6PBh4AlxteNct1Qit3H5fc5punqAYD6vwPsBj1EPg/ZtYP5IcHy8Htj/A
	 AmLfUna7D/ddptE63aTAPzpawkEXflmrkAhukv5ZgxyzRopeRlRAYoNq3V0fpajFj2NKK
	 inVuXN0Q+mUefqfoRGfzFDKdwue2SckeWjavkvxwifFh7IHAbwTl0ohh6UQzJUwfaoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795816899;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Spamd-Result:X-Spam-Score:X-Spam-Level:X-Spam-Flag;
	bh=ywO5RVgPZTKCg8MxNheY4qxRslQKFNNSPc5yDKjlZEc=;
	b=ta3X6jovfn2nLXCIFeMZN8CMe0LraDGFddjEpJUOrgi90aPwGKowFhqNbgEUiWbrXXrQ
	 Y4gj/WIFiQhhHOsoFBOz3JLaJXT4v1pHMkBJh2gxfnlYN2NPoWE+Kz7femzCwNI812y+X
	 DrEtZe0p9fZIEvGoyzf2mXc81bnscusQHKu36PcZWClryg58VA/2cOVz21uLnwOnjJ7aG
	 W1+JNVI5C+K+pS/XaizdsPpmeJtNdpD/n2R5K64nyiBAb+TD+tvMfEAN73gMJHmM7s/OH
	 tTsfRGub9ro7gRSKFlqUsOhh2khBgMiCVkw8gTNN1yUiD9GRfgi9AP9Ou7SPVohs31Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MDBEVCRi;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TTcGdVGc;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MDBEVCRi;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TTcGdVGc;
	arc=none smtp.remote-ip=195.135.223.131
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFA9606A323;
	Fri, 27 Nov 2026 22:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6BFA9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MDBEVCRi;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TTcGdVGc;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=MDBEVCRi;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=TTcGdVGc
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 519F91FDB7;
	Fri, 27 Nov 2026 22:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795816896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ywO5RVgPZTKCg8MxNheY4qxRslQKFNNSPc5yDKjlZEc=;
	b=MDBEVCRiaSp9fHhRM9woN31PQjdSz4IfTk3y5gnbL/9MOPuroXczvBHTYHWq/0USYGM6UC
	W9bLwbPhnxR1i+H9rP+0BBLXmrILGrQsZviUtmfOZsMuxRd2VDMPIfWAy3MaQkhh6lZSt+
	WfgYps87OSn5UVbTFhdyVnfN1moj3+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795816896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ywO5RVgPZTKCg8MxNheY4qxRslQKFNNSPc5yDKjlZEc=;
	b=TTcGdVGc0NMbDymzyNA9s368M9S2y/3YJUjrxNI501rHoUp+bKGNDCnfRrEAQt6h0SbcQy
	VUXM1+dHeNlYRyDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1795816896; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ywO5RVgPZTKCg8MxNheY4qxRslQKFNNSPc5yDKjlZEc=;
	b=MDBEVCRiaSp9fHhRM9woN31PQjdSz4IfTk3y5gnbL/9MOPuroXczvBHTYHWq/0USYGM6UC
	W9bLwbPhnxR1i+H9rP+0BBLXmrILGrQsZviUtmfOZsMuxRd2VDMPIfWAy3MaQkhh6lZSt+
	WfgYps87OSn5UVbTFhdyVnfN1moj3+k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1795816896;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ywO5RVgPZTKCg8MxNheY4qxRslQKFNNSPc5yDKjlZEc=;
	b=TTcGdVGc0NMbDymzyNA9s368M9S2y/3YJUjrxNI501rHoUp+bKGNDCnfRrEAQt6h0SbcQy
	VUXM1+dHeNlYRyDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4836C134E8;
	Fri, 27 Nov 2026 22:01:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qN40Br79CWtAHQAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Fri, 27 Nov 2026 22:01:34 +0000
Date: Fri, 27 Nov 2026 22:01:32 +0000
From: Pedro Falcato <pfalcato@suse.de>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, 
	Andrew Morton <akpm@linux-foundation.org>, David Rheinsberg <david@readahead.eu>, 
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
Message-ID: <awn9Qfo5LfDb5aN7@pedro-suse.tail5790ac.ts.net>
References: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
 <20261127-mlock-madvise-mprotect-ai-fixes-v1-1-e46b2b1eb435@kernel.org>
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
In-Reply-To: <20261127-mlock-madvise-mprotect-ai-fixes-v1-1-e46b2b1eb435@kernel.org>
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	FREEMAIL_CC(0.00)[cs.cmu.edu,linux-foundation.org,readahead.eu,google.com,kernel.org,infradead.org,cmpxchg.org,redhat.com,suse.com,lwn.net,linuxfoundation.org,rere.qmqm.pl,arndb.de,canb.auug.org.au,arm.com,coda.cs.cmu.edu,kvack.org,gmail.com,vger.kernel.org];
	R_RATELIMIT(0.00)[to_ip_from(RL45qnsmh45s86h1s1babgqt3g)];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Score: -13.30
X-Spam-Level: 
X-Spam-Flag: NO

On Fri, Nov 27, 2026 at 07:45:40PM +0000, Lorenzo Stoakes (ARM) wrote:
> Coda file systems stack differently from other stacked file systems.
> 
> On mmap(), coda_file_mmap() switches both the Coda inode's i_mapping and
> the Coda file's f_mapping for the mapping of the container file. This
> causes two problems.
> 
> Firstly, the container file may not remain pinned, at which point this may
> result in a dangling reference in coda_file->f_mapping, and so a
> use-after-free in mmap() or lseek().
> 
> This can happen when you open the same inode across two files, mmap()'ing
> in one, which assigns the i_mapping, and open()'ing another, which assigns
> that i_mapping to the file's f_mapping, if the cache manager gave the two
> files different containers. Each file pins only its own container.
> 
> Consider (A, B = separate open files of the same inode):
> 
>     A, with container C1            B, with container C2
>     ====================            ====================
>     mmap()
>       coda_file_mmap()
>         i_mapping = C1's mapping
>                                     open()
>                                       do_dentry_open()
>                                         f_mapping = i_mapping
>                                         coda_open()
>                                           cfi_container = C2
>     munmap()
>     close()
>       coda_release()
>         i_mapping = &i_data
>         fput(C1), the last one
>                                     mmap()
>                                       mmap_region()
>                                         mapping_map_writable(f_mapping)
> 
> Secondly, mmap_region() takes a temporary i_mmap_writable count on
> file->f_mapping ahead of the mmap hook, and drops it on file->f_mapping
> afterwards. As the hook changes f_mapping in between, the count is dropped
> on the container's mapping rather than on the mapping it was taken on:
> 
>     i_mmap_writable of                          Coda  container
>     mmap_region()
>       mapping_map_writable(file->f_mapping)       1       0
>       __mmap_region()
>         coda_file_mmap()
>           coda_file->f_mapping = host_file->f_mapping
>           vma->vm_file = get_file(host_file)
>         vma_link_file()
>           mapping_allow_writable()                1       1
>       mapping_unmap_writable(file->f_mapping)     1       0
>     munmap()
>       mapping_unmap_writable()                    1      -1
> 
> The container's count is negative after munmap(), so the next shared
> mapping of that Coda file, if it is open for writing, fails with -EPERM.
> 
> Fix both issues by no longer updating coda_file->f_mapping in
> coda_file_mmap(), and by having coda_open() always assign the canonical
> mapping of the inode, as do_dentry_open() may have propagated an i_mapping
> which coda_file_mmap() redirected.

This might be the most confusing thing I've read this year?

Anyway, in the sense that filesystems definitely shouldn't be poking f_mapping
after open:

Acked-by: Pedro Falcato <pfalcato@suse.de>
 

-- 
Pedro
