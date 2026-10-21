Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792580318;
	b=29+6mVCKKro7Hi8njs60TeX2JQWHi57Q33J43IDbiJ2pVFB8QHto8Gu3pd5hF9AQcz+x
	 EEBwu9rapJkdLivsNBa3etsVAoxjKefCZx1+eacQEZ0nQHGi6Su1IbU3IJYaR8pShpyFV
	 RxvHnx7zBypXtF1vdsCkLHUDPsxO7iCpy08jdVJoPvFIp+jvn5E1t45ArLpMaTPOYElyE
	 +UuQxt9hrSQjNg44jQuyQw3hob7XA0xFo/e3zYG5R/bqeBdXXQu0/9TNrSounlGt1SwHq
	 og9UQ3qXDZkDEOjY1rJ4ZU84Jza1fgHumtRguil1gjMti9pQbhMMsisUrZbrrpOLYcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792580318;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=t/rAtuw8L0JVO1MzbBUMP/K+LGokTIDtHsowAZbEJHg=;
	b=W6+R8lB7j/yxjdIMYhZL9ClViwO58LEmXlX9oPTAuB/IpsP4344TxLN6okiyy+SMgH8j
	 N8ebcT44qMk310Q1w0BuwVGIQbPi3YHZ/gaqSptqnhFC9gfdMK63nRqBek5W9ZolTv0L0
	 20Y+1yuXt2xKmIcKtwUR7XtRCo+tAmWGlhEbZMHvFPOqeKYdPUckvshOjtRC6CfWz2Zdv
	 9dqUrWUlIu9AiMpSHuEe9ldGBRZmR2tNmxP1e7fcIFECIg1AVFY7PXP/gG7fCZ3BCffEk
	 JnsnSV5bW8P4rNwYnyyEkMxJnfrO1WdWHjySBxUfgAhU6B0Tbl3XOtnngFJ0owfExTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bobrowski.net;
	spf=pass smtp.mailfrom=bobrowski.net;
	dkim=pass header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=HHNDkB5Z;
	arc=none smtp.remote-ip=209.85.210.175
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4941606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 10:58:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4941606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bobrowski.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bobrowski.net header.i=@bobrowski.net header.a=rsa-sha256 header.s=google header.b=HHNDkB5Z
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8a05b210703so243652b3a.0
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 03:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bobrowski.net; s=google; t=1792580317; x=1793185117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t/rAtuw8L0JVO1MzbBUMP/K+LGokTIDtHsowAZbEJHg=;
        b=HHNDkB5ZzLBhcoftqluBfZzfk4FH8wqvFihietVucu3AcUZ2N8eU/TTlxfrIw6DLfj
         1a8W/7mx/j8/kp4xIxcA21hhjb0fB9pr5EZZX7iBMO/KKIP/GGfzgLjAt2gZalRQcKM7
         AnH11A5NWmfD7vXByk1SGh2GmRnXVcG5XI9Rza+srIZzailb/5tz+lK6qrKO+NUYDLT4
         JHFj3HB9npVsefJH3zwmWSvy+HReCVoSn7l9cR04PABVYFzHOxZy5OpxGRdN37QaJ8oD
         N84LLbssL3LEgR7A0kyTlogxWFxWLY4kLkv9wkhzmI1PFjr84+c2+MTuIPc+Rjz9oO/v
         Jc7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792580317; x=1793185117;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t/rAtuw8L0JVO1MzbBUMP/K+LGokTIDtHsowAZbEJHg=;
        b=qPn1jaP4oBr31zGgSm+reGstpd0NhbMXt2cJUKkI+2fyycxN8RITnQCwUyQwP604mf
         KaXxhy4RDh9OurGDWy8pF2rpMoAVpsIEPcCQrVu/6f+RNgAM2ApZkyCWIZSFZ2fGoaEq
         fxXFV3761zEvGL4dPzcKgZXjldQ9CMVGYcq2VxeePvUPF4aaFoMkAMHjlOel9qpIOBhG
         808ynGxAdrkFuNiuH6VXAk0Qfd59gRvWCMIlNf3fb9HFnpPZdaJlvaDfNHZvYTpyykq1
         8wz5724g/BLTQhdjKb3JVs7yrCIy2Eih/96eU0ntH1m1nB3bN/nkJRpltJriqSr+dsJ2
         bmyA==
X-Forwarded-Encrypted: i=1; AKwUvBxVZZxXPoxkNPUMfavVgqwj9vqTNH6kAikq+YUoDcnKTR3DHp7pEai8Aw+xz897rBX7i7W/+fQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBj5FFKKfVS0D9RtohPXgCqqOtowj2mj5mEhGjBzyxvhr6ByTq
	mEcYF2x4mCGcVGVH8Go3vXS46frYFNGHYWARI68R4HejhcHESZid/DXAoiCOhyxWCFWU
X-Gm-Gg: AYBFou3BKWFQ3gmM/TPlBw2DXQppiw8oLyHcQk4li7TUldQzRa6j4VgNFZmPNKiagTx
	0nNzZqDvQuwKaDbsItEfPosyU0eMQVCeyewaouFSwiPyeKprn+yM6nG/XpDePfWKelaxwZArxf/
	cZc98BuNFgqNIrZkkKXrTjkgndzg4Dk+N40r24ixTlHuWo7jMi8eJbZf2Q06pJr9QgghUf4+YWI
	6OBMcxb1TK9qsxYa/mofOC/wjdJQo0xVnzvSh1bQLoP4hkN3OKiemmAuhcwiyMwiOy5Xu5Tasfa
	oMv2N8zgQcmfSyYtWikYXI01PWXOAFArBf8etvYmWYURKwY2c/d8gpa81itUrqAKRxSMAIZfdJV
	Bfm7NFHpRJMWCSq0nwCTQ5CZEx4WJ2CxFz9B6ia4pbOw6AGsFBLQ/auJ2o0EnbmFWkwORv+lcH3
	kIPkU54BwIsIEIrE3mbkSfhclL2zbXXPMEytjzZ+8raMJnFXLX2WylQDv0Fw6vFyoiDRXAJaZrc
	gKdMuYa9XYJKUaIigmRyE9knYm0AfMe6DRvKdUyecgDXwAVqyhfqAIWEAQzZ5S1zusD5zVUm5a8
	j14ZX9/XlDmF2CrWmRj2PcbzRvidQDs=
X-Received: by 2002:a05:6a00:3d11:b0:89e:9c7e:fd51 with SMTP id d2e1a72fcca58-8a089d0783dmr1174185b3a.10.1792580315723;
        Wed, 21 Oct 2026 03:58:35 -0700 (PDT)
Received: from lima-development (163-53-146-70.ip4.superloop.au. [163.53.146.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b49dcsm730783b3a.16.2026.10.21.03.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 03:58:35 -0700 (PDT)
Date: Wed, 21 Oct 2026 21:58:09 +1100
From: Matt Bobrowski <matt@bobrowski.net>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: fix crash in bpf_path_d_path() for
 exiting tasks
Message-ID: <atiawbBo6WRPA6QA@lima-development>
References: <20261020105014.97985-1-matt@bobrowski.net>
 <20261020105014.97985-2-matt@bobrowski.net>
 <DM9VJTFJGVXB.3GH9LO3NGV5PO@gmail.com>
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
In-Reply-To: <DM9VJTFJGVXB.3GH9LO3NGV5PO@gmail.com>

On Tue, Oct 20, 2026 at 06:24:42PM +0000, Alexei Starovoitov wrote:
> On Tue, Oct 20, 2026 at 03:50 AM Matt Bobrowski <matt@bobrowski.net> wrote:
> > Fix this by returning -EINVAL from bpf_path_d_path() when current->fs
> > is NULL. Only the task itself clears its fs, in exit_fs(), so the check
> > cannot race with that.
> 
> The crash is gone, but so is the path. file_release progs will get
> -EINVAL for every file that a task still has open when it exits.
> 
> It also breaks what works today. The d_dname branch in d_path() returns
> before it looks at current->fs, so at task exit a pipe or a socket
> resolves to "pipe:[123]" now and to -EINVAL with this patch.
> 
> And it's not specific to bpf. The comment in fs/cachefiles/namei.c says
> that current->fs == NULL in do_exit() breaks d_path() called from ext4
> open.
> 
> can we fix it in d_path() instead ?
> With an empty root prepend_path() goes up to the global root, the same
> way d_absolute_path() does. Then the check in bpf_path_d_path() is not
> needed and the selftest can expect the path. A chrooted task gets the
> path from the global root, but it doesn't have a root anymore.
> 
> Something like this (compile tested only):

Prior to sending out the fix, I also considered addressing this directly
within d_path(), much like you've proposed here, but decided against
it. d_path()'s contract is to build a pathname relative to the current
root. It does fall back to a root-independent name when the path isn't
reachable from that root, but that fallback still presupposes the caller
has a root to measure against. An exiting task past exit_fs() has no
root, so d_path() has no correct answer to give in that state, and I'm
not convinced we should invent one for it.  That's what
d_absolute_path() is for.

You're right that my patch regresses the d_dname case though, since
pipes and sockets resolve today without ever looking at current->fs.
Rather than replicating the d_dname check in bpf_path_d_path(), which
would mean duplicating VFS logic such as the mounted pseudo-inode
special case, I think the cleaner fix is to move the "no root, no
answer" check into d_path() itself, after the d_dname branch:

	if (unlikely(!current->fs))
		return ERR_PTR(-ENOENT);

That keeps d_path()'s semantics intact, keeps pipe:[N] and socket:[N]
working at exit, and turns the oops into an error for every caller,
including the ext4 open path you mentioned. Nothing that works today
changes behaviour; only calls that currently oops are affected.  Callers
that want a name in that state then have to choose one explicitly, which
I take to be Al's point.

For BPF, that choice could be a new BPF kfunc wrapping
d_absolute_path(), so programs can pick whichever semantics they actually
want, and file_release programs that need a name at exit get one whose
format doesn't depend on how far the task got through do_exit(). I'd
prefer that over silently falling back to d_absolute_path() inside
bpf_path_d_path(), which would return chroot-relative names before
exit_fs() and absolute ones after, and still wouldn't help pipes and
sockets since d_absolute_path() rejects internal mounts.

Al, would a check like the above in d_path() be acceptable to you?

> diff --git a/fs/d_path.c b/fs/d_path.c
> index c253090..ea49d33 100644
> --- a/fs/d_path.c
> +++ b/fs/d_path.c
> @@ -265,7 +265,7 @@ static void get_fs_root_rcu(struct fs_struct *fs, struct path *root)
>  char *d_path(const struct path *path, char *buf, int buflen)
>  {
>  	DECLARE_BUFFER(b, buf, buflen);
> -	struct path root;
> +	struct path root = {};
> 
>  	/*
>  	 * We have various synthetic filesystems that never get mounted.  On
> @@ -284,7 +284,9 @@ char *d_path(const struct path *path, char *buf, int buflen)
>  		return path->dentry->d_op->d_dname(path->dentry, buf, buflen);
> 
>  	rcu_read_lock();
> -	get_fs_root_rcu(current->fs, &root);
> +	/* Past exit_fs() there is no root to stop at, go up to the global one. */
> +	if (current->fs)
> +		get_fs_root_rcu(current->fs, &root);
>  	if (unlikely(d_unlinked(path->dentry)))
>  		prepend(&b, " (deleted)", 11);
>  	else
> 
> pw-bot: cr
