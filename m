Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A1A3B774D
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 20:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784666209; cv=none; b=LtQj+mQ/B8WDgUR2K/ez+XjjrZ6rso5A+jzMH7iIk9CK6AVBVfjKMyTbjCgzSlI1X71ysTG75K34Z10S97oZZsorT886yKi/6AccMdclb3JBgayS8OP9Kb9EKJimsJmt+DShmPwHLovjT/xpD+BqVlXOYJX/JWwNYcVFBCawvQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784666209; c=relaxed/simple;
	bh=eGV+Nr26bbBa30zN2rLCQJpfF2PwF3cVqhJ/YUbZOac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mu5xzg6ogEYh56GKUySAQzEN5tCMmtHumZsSzS2iejtq3vZAyeFaF9lrb33/FQ2mkkn6FNtWwaFfEiaI0TIgXKJw/1v/F0dxVeI+Ebl3F/4o0fY4nUfVNi/4shkPSSaN4J3O0pwjpHpg3iE1VAlkREFsU3cfZbbNEPORYKtlKqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl; spf=pass smtp.mailfrom=xs4all.nl; dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b=fw4JTd/q; arc=none smtp.client-ip=195.121.94.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xs4all.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="fw4JTd/q"
X-KPN-MessageId: de161530-8543-11f1-a5a0-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.8])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id de161530-8543-11f1-a5a0-005056994fde;
	Tue, 21 Jul 2026 22:36:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xs4all.nl; s=xs4all01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=X6JbNQIATPP5lzRYGP9EC0Lk7v2gUEGWN6HyA1XyIBs=;
	b=fw4JTd/qR7ifxH2fj/4bRz3KVC/QD9f8iYNWW5Q3w8YjOYoFoFe4ZdcHOC3XahpY8VjOIfWJHHbix
	 XD5XiYFNABemP+gEJ5gDD10p2GlkGKoFArYnrqnkeFamt6ikv+qf0UJrjZ1x6jlR1RP3irnfPrbkNU
	 7VCacAMAstMXBntGGZaXwYEw20UpvXGZNHFjmZ3snx8i3ixbr6UttKvLC5uFZBXMxEJZQNJX9fiRSD
	 ZI2phKRqAvsixtMKeqePNMSe4LhwKK026NBQ1fJPx4lkArGyL7VKuVz2LzW8VewpT04zM4x/csvEkZ
	 lPkkZKC/9qy4Wn3Bffmic4C4SEkfVSQ==
X-KPN-MID: 33|/FRaVBBNTpX7oZEbL/WUJwV+obe8QveTmU6qomkjd7Zwy0bDuddoRQ6LhmU9/QC
 +7Nh0UkLCbRlhhU1hxRxRyHX5B0cO19/6jnvbrmmuR1g=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|Bt02zkTEX4BovQyofVTpaC6SvmEMyLJr1cMXxpOT5X5aV92dxLfZk6RhnWA+hTi
 9O7uuVJiPiXaYg6l10QxO/g==
Received: from localhost (unknown [178.231.6.225])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id dde1a5a1-8543-11f1-8dd0-00505699d6e5;
	Tue, 21 Jul 2026 22:36:35 +0200 (CEST)
Date: Tue, 21 Jul 2026 22:37:58 +0200
From: Jori Koolstra <jkoolstra@xs4all.nl>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Farid Zakaria <farid.m.zakaria@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Kees Cook <kees@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	linux-mm@kvack.org, bpf@vger.kernel.org, jannh@google.com, mail@johnericson.me, 
	stable@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf_fdpic: only honour the first PT_INTERP
Message-ID: <al_MqBrjDW1QjRau@daedalus>
References: <20260721-gezittert-medium-kreide-b41fc1f0277e@brauner>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721-gezittert-medium-kreide-b41fc1f0277e@brauner>

On Tue, Jul 21, 2026 at 01:20:45PM +0200, Christian Brauner wrote:
> The program header scan handles PT_INTERP from a switch nested in the
> scan loop, so its break leaves the switch and not the loop. A binary
> carrying more than one PT_INTERP runs the case again and overwrites both
> interpreter_name and interpreter. The previous name allocation leaks and
> so does the previous interpreter reference, along with the write denial
> open_exec() took on it. The denial is never released, so the file stays
> unwritable for as long as the system runs.
> 
> An unprivileged caller reaches this with a crafted binary and repeats it
> at will. binfmt_elf stops at the first PT_INTERP. Do the same here.
> 
> The flaw dates back to the driver's introduction in the pre-git history
> tree introduced in v2.6.11 by 91808d6ebe39 ("[PATCH] FRV: Add FDPIC ELF
> binary format driver").
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/binfmt_elf_fdpic.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index 7e3108489c83..fe0b5c5ed2bc 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -231,6 +231,10 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
>  	for (i = 0; i < exec_params.hdr.e_phnum; i++, phdr++) {
>  		switch (phdr->p_type) {
>  		case PT_INTERP:
> +			/* elf ABI allows only one interpreter */
> +			if (interpreter_name)
> +				continue;
> +
>  			retval = -ENOMEM;
>  			if (phdr->p_filesz > PATH_MAX)
>  				goto error;
> -- 
> 2.53.0
> 

Good catch.

Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>

Btw, it seems that elf_fdpic_map_file_constdisp_on_uclinux() has no
check to verify that phdr->p_memsz >= phdr->p_filesz, despite elf(5)
saying that

	The file size may not be larger than the memory size.

Afaict, currently read_code() may blow past what vm_mmap() allocated
there, which may result in memory corruption for a non MMU system. This
is an LLM assisted find, and it may be that I missed something when
verifying. If you agree this is wrong, I'll fix it.

Thanks,
Jori.
