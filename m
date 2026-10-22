Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792670179;
	b=fK6X3FRqGxcJdWbLe0syZhJNS33te9b0byD6GhUXgsIUHUdDIBA7Gk3xXnjedtrwODJO
	 AC5WlvfDvL60qCiHlW2Utaxs4CDci/F9yLMtU4ipoxAx/4RiWwArIS1UAmQz888GxbxJU
	 j1gzXW5tT0ssPktTwgPvsxkzf+RqHOHO3txJj1GcRRttZoM4uOKi0oLmkqw61YUuFaHux
	 lg5Bh5HjGGhs2yBVcRfjcZWE4Jm+IQiOxfd3awmMZX8SRH8kM2KPytQkLKhr/z0vXgsiv
	 laZ4OlDC0RHxqoQ17clNELpy55zkK3wPrgEga6PWjWtyfHonkHXVC+xVD31HMTGsOFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792670179;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=S+B17Je2iIRLL5QkRDlohmfcbpEYpdpIbxDvnVBORQw=;
	b=S1+R/lUf8eyK2GLbtDeVmodFVkea+zORy5U/zLlBMjGmQjyjncc860odeZRJ1gBMwibd
	 3OAkEUUylQw1G/4HFVZW/95l2ABFgtLByUi80PNW8vv6Ofsp/aovG/J//ddCZu9UwwKiT
	 vRC4mU3Km3vcmZMSbEfdyRa+anqedEQDK3g7KtR3T4OrlcAzzdU4BIjRlH6gB4TRmFHCA
	 tiRm+1RVXVBBeqfrs7t9FyPP+cQ7EksU6JUNyOKI4SkYxVTf9c9eFWU1F7eW0iNF1Izqt
	 0GXdVSvKceEGbhNvQbzcjn8jSIJMnVquzNLUaQsIBqZLNarY7a8QcXXjHEbvXcGgzOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTTT2ZrR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51829606A328
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTTT2ZrR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E153A1F000CC
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 11:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792670177;
	bh=S+B17Je2iIRLL5QkRDlohmfcbpEYpdpIbxDvnVBORQw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iTTT2ZrRyBxaomVfsOhg3aw6okWcBOZltSfMtpdB3JJTr3XmwiJPeoHqLj8YuEjJg
	 58g1UkqobFnZqKpr04WlUoEIjfswXBnGkHZOEO0hiC3HO7l1cFPm3pt1C4zShsGfQh
	 JFTIL2HuUba3x9uQyx8XHmpjYjGSAXJRR5LqEVtNYqIGLXeQARiPJOCrSMGt11xQg4
	 WVa4q4C2tX+ne3bT1j0D2n1LXWsfvXmRk/6iwiISyPna5TKznJknKBV0gX9x7dfe/d
	 0+cMu7WOf5NkBj1nySJ27VzpG6YNk7TH3olzq4l3615wy+cgosQ1egUbkKQmCwxXkP
	 Ctiq2C4f0tyNw==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c315869241fso219542466b.0
        for <stable@vger.kernel.org>; Thu, 22 Oct 2026 04:56:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBydiv0xP5+antLF68IgbljB4QAkmf4HV/Ehlungi4smU0+pSDzedgVN4LrdRVqkOqVdXinrNlg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9e9MPQYK3JNjdKloVs53vzKrnK+uUvDDhl/ygDxRxtMaZBw6T
	KomcGCO9Y0AxFyRGUPbDPcPknfGNvUNFi5ES7w0/GKI7nKGLynafV3/4nDISlg4GmWJC4OeYCGm
	0Fp12dxVM0WHm0hVfpQpQmIfOBuG2kPw=
X-Received: by 2002:a17:907:9446:b0:c46:6a50:40b7 with SMTP id
 a640c23a62f3a-c4679664c41mr504983166b.10.1792670176553; Thu, 22 Oct 2026
 04:56:16 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021141757.3917073-2-bestswngs@gmail.com>
In-Reply-To: <20261021141757.3917073-2-bestswngs@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 22 Oct 2026 20:56:04 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_CXXskyPYL8Re2sJEqS4Y4a2ebkviNb4CJjVTMP+Drmw@mail.gmail.com>
X-Gm-Features: AclHuK9_taj3IZHzEBaVJhyb1o6zxRe_HHkP2mFX2aJBAj-ZQdE-hUJbgXMTqiI
Message-ID: <CAKYAXd_CXXskyPYL8Re2sJEqS4Y4a2ebkviNb4CJjVTMP+Drmw@mail.gmail.com>
Subject: Re: [PATCH v2] smb/server: prevent file publication after tree disconnect
To: Weiming Shi <bestswngs@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Ronnie Sahlberg <lsahlber@redhat.com>, Hyunchul Lee <hyc.lee@gmail.com>, 
	Steve French <stfrench@microsoft.com>, co+d531129f2f9fbf88@bugs.sh, 
	Xiang Mei <xmei5@asu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:27=E2=80=AFPM Weiming Shi <bestswngs@gmail.com> =
wrote:
>
> TREE_DISCONNECT closes the tree's published file handles before marking a=
nd
> removing the tree connection. A concurrent CREATE that already holds a tr=
ee
> reference can therefore publish its file after the close pass. When CREAT=
E
> drops its reference, the tree can be freed while the published file still
> points to it.
>
> Mark and remove the tree connection before closing its files, and seriali=
ze
> both new-open and durable-reconnect volatile ID publication with that sta=
te
> transition. An opener is then either published in time for the close pass
> or rejected after disconnect with STATUS_NETWORK_NAME_DELETED.
>
> Keep a tree reference while a file carries its tree pointer. This protect=
s
> asynchronous users that can defer the file's final destruction past tree
> disconnect.
>
> The close pass can race the successful FP_NEW to FP_INITED transition.
> Take the opening request's file reference atomically with that transition=
.
> This keeps the file alive until request completion even if teardown remov=
es
> the ID immediately.
>
>   BUG: KASAN: slab-use-after-free in proc_show_files (fs/smb/server/vfs_c=
ache.c:126)
>   Read of size 4 at addr ff11000101540f80 by task poc/153
>
>   Call Trace:
>     proc_show_files (fs/smb/server/vfs_cache.c:126)
>     seq_read_iter (fs/seq_file.c:231)
>     proc_reg_read_iter (fs/proc/inode.c:299)
>     vfs_read (fs/read_write.c:574)
>     ksys_read (fs/read_write.c:716)
>     do_syscall_64 (arch/x86/entry/syscall_64.c:84)
>     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>
>   Allocated by:
>     ksmbd_tree_conn_connect (fs/smb/server/mgmt/tree_connect.c:35)
>     smb2_tree_connect (fs/smb/server/smb2pdu.c:2819)
>     handle_ksmbd_work (fs/smb/server/server.c:368)
>
>   Freed by:
>     kfree (mm/slub.c:6801)
>     handle_ksmbd_work (fs/smb/server/server.c:332)
>
> Fixes: f44158485826 ("cifsd: add file operations")
> Cc: stable@vger.kernel.org
> Reported-by: <co+d531129f2f9fbf88@bugs.sh>
> Assisted-by: LLM
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
Applied it to #ksmbd-for-next.
Thanks!
