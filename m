Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795812270;
	b=CieU7NUkTPnGT9rEX3HxuR92trpoOOEDvl4nL6vTt8Ducvmawn0lhPSh8gu8O6ITYV7R
	 4cUHqf60Ax1PlnX1thhJYuYgUFRLr7V6JTUwLUP74l9k8Hr1tDCSH/13R7U7R79+h/6Tb
	 9TrXHOk9UsCkexgBIA7YkJ8PS22k1BG2hjNeI3889ZV6m8dPFAbFzGzqf9ZgGsB1FXCLa
	 99KY1n7pIdAW8yCetL06PRr++0DgF01Q2l+H0a/ltI/tK5Pa/sF9OII3ajpie7bZl48Og
	 cfbBa539V1JEVuIAberEyr0ok8jebxmRcvT40JKj6C/Q8jGHqKAEdLeT0xhqGrUi9gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795812270;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-Id:
	 In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=o/swzqNGNmYuC5KRwnzcnyJMdoU0gvWeuJZ2tEFBhOE=;
	b=aZ67WVVUCqDjBbUarAiJweWVaEBk5Ut8lCei7sY67YFTCbe8VrN7UOwRzt1yMenDCkyJ
	 2UOCgjUnCuBS5MCovC/sxP9YJjdoGgZ9D4kgkPoByg7ppgngWLpQWwDZl8m4MhTudEi8h
	 tTDcrQlSnLWE/MnFpyTSWkzkp4qV09Sr1vIgTPHoTkkuqRFAwRtewTbneNPIIr7EK7r+Q
	 qePRWeKqrT4Sk6WtigHOdPD4Z5lMVL1Q53EtpZnFZSIR0NaColLdlygogrCBVzbteVmj2
	 GIBK52MUYDYfLok8osZ7ndrjjaHtZFKQJj463Jm0q5pxJgCf2ov1jysuOwV0eAdiURg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=eERIy1vE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4E4606A31C;
	Fri, 27 Nov 2026 20:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=eERIy1vE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7726B1F00897;
	Fri, 27 Nov 2026 20:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux-foundation.org; s=korg; t=1795812269;
	bh=o/swzqNGNmYuC5KRwnzcnyJMdoU0gvWeuJZ2tEFBhOE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eERIy1vEAuHl7drCdBRsEp5kZq16eNRHi1Znb68bBftcZHzAw3uhQEIJObhIhPoKg
	 ViohHCGLbOKq8ealKgmimbgzfyTgnn0ujE6pn3m+JFgudk6oiJxdc6iuNzdAUjb1kM
	 VcSsHAxTsSDD/x54/W9vByspOjC8tmnC+uPdrwFc=
Date: Fri, 27 Nov 2026 12:44:28 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu, David Rheinsberg
 <david@readahead.eu>, Hugh Dickins <hughd@google.com>, Vlastimil Babka
 <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, David
 Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, Alex Shi
 <alexs@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, Pedro Falcato
 <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, Rik van Riel
 <riel@redhat.com>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jonathan Corbet
 <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, =?UTF-8?Q?Micha=C5=82_Miros=C5=82aw?=
 <mirq-linux@rere.qmqm.pl>, Arnd Bergmann <arnd@arndb.de>, Stephen Rothwell
 <sfr@canb.auug.org.au>, Muhammad Usama Anjum <usama.anjum@arm.com>,
 codalist@coda.cs.cmu.edu, linux-mm@kvack.org, Andrei Vagin
 <avagin@gmail.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, Chris Mason
 <mason@kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] coda: never point a file's f_mapping at a
 container's mapping
Message-Id: <20261127124428.f1f66c6244d3e5c2811f56de@linux-foundation.org>
In-Reply-To: <20261127-mlock-madvise-mprotect-ai-fixes-v1-1-e46b2b1eb435@kernel.org>
References: <20261127-mlock-madvise-mprotect-ai-fixes-v1-0-e46b2b1eb435@kernel.org>
	<20261127-mlock-madvise-mprotect-ai-fixes-v1-1-e46b2b1eb435@kernel.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Nov 2026 19:45:40 +0000 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:

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

Yeah, I hit this while getting
tools/testing/selftests/mm/memory-failure.c to work on all Linux
filesystems.

> --- a/fs/coda/file.c
> +++ b/fs/coda/file.c
> @@ -182,7 +182,6 @@ coda_file_mmap(struct file *coda_file, struct vm_area_struct *vma)
>  
>  	cii = ITOC(coda_inode);
>  	spin_lock(&cii->c_lock);
> -	coda_file->f_mapping = host_file->f_mapping;
>  	if (coda_inode->i_mapping == &coda_inode->i_data)
>  		coda_inode->i_mapping = host_inode->i_mapping;
>  

I had this change.

> @@ -248,6 +247,19 @@ int coda_open(struct inode *coda_inode, struct file *coda_file)
>  
>  	host_file->f_flags |= coda_file->f_flags & (O_APPEND | O_SYNC);
>  
> +	/*
> +	 * On mmap coda_inode->i_mapping is updated to point at the mapping of
> +	 * the mmap()'d file's container, and do_dentry_open() propagates that
> +	 * to coda_file->f_mapping.
> +	 *
> +	 * However coda_file's container may differ, in which case the lifetime
> +	 * of that mapping may not match that of coda_file.
> +	 *
> +	 * To avoid a dangling pointer, reassign the mapping to the canonical
> +	 * one.
> +	 */
> +	coda_file->f_mapping = &coda_inode->i_data;
> +
>  	cfi->cfi_magic = CODA_MAGIC;
>  	cfi->cfi_mapcount = 0;
>  	cfi->cfi_container = host_file;

But not this one.

Is it truly needed, or is it a future-safe defensive thing?

If the latter, Tested-by-me:.  If the former, Mostly-tested-by:me. 
Either way, Acked-by:me.


It's always seemed a big wart that file->f_mapping even exists.  We
should get that via file->f_inode->i_mapping!  But you-know-what tells
me that "/dev/mem sets the opened file's f_mapping to the shared
I/O-memory mapping; /proc/bus/pci does the same.  Their f_inode still
identifies the device or proc entry" so sigh.

