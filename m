Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FA337269A;
	Thu, 23 Jul 2026 04:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784780057; cv=none; b=bxX+CDSztEtEn1JSLESn6gnKcBnCrTi3KRAElpcj5KSSh9gWlQ8g3kif3x/PFVDrE8qr1A1JY3JKu9d23ho3ndQ02iIJ4T6EkjvKphHJLtALAnIutwgpZAvwQtdTO1ZqDCKlhmowT2BoA+I2a7reKkX9w3kCOoOYxlSgro+jtvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784780057; c=relaxed/simple;
	bh=B1LYR0yzyrpHIYSD48toXkgI/HdrW8FvJacO1T+G4Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D1KKv9L4q9Rar1dZEHx+0SdljFo33ukpzfyfE5ylAtq+6DYKeTAiqMnI05aQhV/O2b4gkIcKi+QyBaraj/rEyDAnGjPj+5Ci47GMUdlCWzGf43qKSaCHUKeJ+ZjvhXbHq/ykBWKQFwT9Ydt/XoIijhWyd2ojGXLbWg7R6Kf7sk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhZSE7yH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhZSE7yH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D20801F00A3A;
	Thu, 23 Jul 2026 04:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784780035;
	bh=55r2jdYA/SkKLM/8vqOGXlubvKDhhxQcpWdG8gkoyKk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BhZSE7yHUgDomiz+2djVk4t5uNNsaCugIoUpoce9e9H8F6//1g/jLEnqX8j1Gsq/u
	 OxDz7p3JmYGF330nkzQpFP0oTqkefx2WBNIb6/3LHwvhyGG4HaCUUq6u1+TEgGm0r3
	 OZ7xHz8OrFWyC6t4dJ2NgazgQVfCvfQihdn7O3WzBjEQfPTJw6TuiTlvjw4FwK9EU4
	 jRugM9iw8m292gycZGlixtzxnqiXQ8ytxLH3GHtH90kL9IxguXbi2COuJrm3YmQ0nK
	 s9ume+GNfTh9v2PgyzINhjxuC0ycvXiDJDOWQM3T/E4JZ2FofYoyh1y2OjbJa69DlE
	 gBv6NdK/lhIPA==
Date: Wed, 22 Jul 2026 21:13:53 -0700
From: Kees Cook <kees@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org,
	Farid Zakaria <farid.m.zakaria@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
	bpf@vger.kernel.org, jannh@google.com, mail@johnericson.me,
	stable@vger.kernel.org
Subject: Re: [PATCH] binfmt_elf_fdpic: only honour the first PT_INTERP
Message-ID: <202607222110.D5AB43796@keescook>
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

binfmt_elf ignores all the other PT_INTERPs, which is what you've done
here too, but I wonder if it might be reasonable to refuse to load such
a binary?

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

-- 
Kees Cook
