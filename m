Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DD9352013;
	Wed, 22 Jul 2026 14:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784728960; cv=none; b=M9eGyfVz+zrL/+2Wu2XpfmS/orlp6gCRSt/yb8Te0uUS9sqst/B93dm3E053AnU2an1B9s0UGVmoj2P+Sa66W1rhPhPNr8ShVQRNVoqIV2zZ7fcj0qb8JEQ4CtzGM0knWxMf0td0pERRxRjAUdLvAMddmJGyiLm9wDhHKZFfvMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784728960; c=relaxed/simple;
	bh=xW6HEANIwzaL9qihei/h38a0uLj9ZZuqjYQn7dfmeOk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=KtRARk+Yrakq7FI3KqUhhOPTczcvbODXmiOxGtP+1d90k4DLzKJBNHlFXF1ZFy5+v2tsxzvfhRp3KRJ2Uk/R6nG7LMMYxZqQVfwf6rpfEncVOrj861R1VpIGXxzesQzPujMpKPh4TyI765IlY1Cs5V/bv3C6nj/cnJ2BvGlaxDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bfyt0B3R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bfyt0B3R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5EE91F000E9;
	Wed, 22 Jul 2026 14:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784728958;
	bh=EgzAv324wbWpcz6dBQ14sGLLSXabiEa87HpRWnnfqqU=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Bfyt0B3RXEPX+KCdYlIAAjVVmIoEZZz9zHzxtgrLHfjS3pG+M7QY3KxLGxsg2e8ZZ
	 zSB+0YjDPXhySzgSAlLU/hTmWfrtzz5wQ3N/+Rb21gXYpIVwPN+l30xgnNxEPJ1XtP
	 mem6wGdkgKAfgwySqRYq72mlycMBJEOYoaJ9h7oz/3KViWJsu48iBgaRlsKRnBizgv
	 AgAJBN41hzTjp10GBaaFfNLI7AzzwfSHCMvIeDjQn6H+1esaYAZ7OGm0Wab8+4hmSS
	 uOO0ZW9wTUAXPO7MusbJhxzDm9udgi9ey/MlTlUCde2fojRmx1s9xLcc5eGlLLPnhq
	 KgWzrhuDsa+7g==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] binfmt_elf_fdpic: only honour the first PT_INTERP
From: Christian Brauner <brauner@kernel.org>
To: Jori Koolstra <jkoolstra@xs4all.nl>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
 linux-mm@kvack.org, bpf@vger.kernel.org, jannh@google.com, 
 mail@johnericson.me, stable@vger.kernel.org
In-Reply-To: <al_MqBrjDW1QjRau@daedalus>
References: <20260721-gezittert-medium-kreide-b41fc1f0277e@brauner>
 <al_MqBrjDW1QjRau@daedalus>
Date: Wed, 22 Jul 2026 16:02:33 +0200
Message-Id: <20260722-abgehackt-gedonnert-bekunden-39413664ab17@brauner>
X-Mailer: b4 0.16-dev-2f6f2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2431; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xW6HEANIwzaL9qihei/h38a0uLj9ZZuqjYQn7dfmeOk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlnK0u5JO9/EGm2TVjkoP0wUCeht1eE7KfLfq4r8biw
 KplDk5fO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbycDIjw3uWshOfT5bVmq9a
 FNi6vFP/qZu1yLfcl+yXRF4/XaK2NpiR4SyP0NHv74XE7VnV1pz3kXcL7cvhuTLxRcOuqWY7WHO
 28gIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

On 2026-07-21 22:37 +0200, Jori Koolstra wrote:
> On Tue, Jul 21, 2026 at 01:20:45PM +0200, Christian Brauner wrote:
> > The program header scan handles PT_INTERP from a switch nested in the
> > scan loop, so its break leaves the switch and not the loop. A binary
> > carrying more than one PT_INTERP runs the case again and overwrites both
> > interpreter_name and interpreter. The previous name allocation leaks and
> > so does the previous interpreter reference, along with the write denial
> > open_exec() took on it. The denial is never released, so the file stays
> > unwritable for as long as the system runs.
> > 
> > An unprivileged caller reaches this with a crafted binary and repeats it
> > at will. binfmt_elf stops at the first PT_INTERP. Do the same here.
> > 
> > The flaw dates back to the driver's introduction in the pre-git history
> > tree introduced in v2.6.11 by 91808d6ebe39 ("[PATCH] FRV: Add FDPIC ELF
> > binary format driver").
> > 
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  fs/binfmt_elf_fdpic.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> > index 7e3108489c83..fe0b5c5ed2bc 100644
> > --- a/fs/binfmt_elf_fdpic.c
> > +++ b/fs/binfmt_elf_fdpic.c
> > @@ -231,6 +231,10 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
> >  	for (i = 0; i < exec_params.hdr.e_phnum; i++, phdr++) {
> >  		switch (phdr->p_type) {
> >  		case PT_INTERP:
> > +			/* elf ABI allows only one interpreter */
> > +			if (interpreter_name)
> > +				continue;
> > +
> >  			retval = -ENOMEM;
> >  			if (phdr->p_filesz > PATH_MAX)
> >  				goto error;
> > -- 
> > 2.53.0
> > 
> 
> Good catch.
> 
> Reviewed-by: Jori Koolstra <jkoolstra@xs4all.nl>
> 
> Btw, it seems that elf_fdpic_map_file_constdisp_on_uclinux() has no
> check to verify that phdr->p_memsz >= phdr->p_filesz, despite elf(5)
> saying that
> 
> 	The file size may not be larger than the memory size.
> 
> Afaict, currently read_code() may blow past what vm_mmap() allocated
> there, which may result in memory corruption for a non MMU system. This
> is an LLM assisted find, and it may be that I missed something when
> verifying. If you agree this is wrong, I'll fix it.

Seems like a decent fix to do.

