Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548412;
	b=RSIAigD1sTo21ySms+b0DwQ7EWFPQehB44/FWcLh9vh1vEhC0oIxGAKqA9jo7Vk3J9Hq
	 +dbdIPCLcgQcMRbQEdp1RrrRNj4cRSstxUoO1V6X5HDWeOzUZ/Dv6QApUsWqhNTFbTzXs
	 F8R7kzlGhfhkxtvLT7mh2ZYzUuWqmJt1odlsb5HBkfo5/W7Uu3n5Galfbndb3MvpxQzZ/
	 xZUA31xzVbc0HZilbj0OcmVpd/YxfFLzIKXLB+TqqG0XOzzc/z4iMxbgUozhGOxEdi6g7
	 60nPQ5QhfK1eKKtlytFmf5B9wDm38LhKuJKtPMfOSIHTZm0CpS5gP2zrU4KpKyHp7Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548412;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Hx6UElPaQ01AndWg4PbkPo3EgkBjeG9V0ErP0KNlUD8=;
	b=pb/twfjIhHrK8oh8Haw7wR/rKZAWRtu9D2qn7UHsmciU097d4z1pYAkDk5xx4QU9Yq62
	 NEd/672+/iPM8K9fb8HZHRszEcgB2CJ9GA0A2Q8TB351bCT3nopBNyqB5ApUph4aPN5QV
	 GJ+2aM5u7SOLbMExcI++KmaQpClb+9z5UFAq6u7cxxxUSRmwEpxJCP6LZ/y6R4ccoxK8b
	 yuSgXYcoWfd0ZrPnj+rT9SEm+36GyWQoOvQ69Ra8828sCGToZgcgzT8ifqbbaslRbc3ez
	 DYuZU9vf8W1GCw6XwMg3OWC5CtvPoR6CywustxBu/TH7xunavz58mvLLEadq0+KIxJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMTjbLSb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2797E606A31A
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NMTjbLSb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04DC1F000CF
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 02:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792548410;
	bh=Hx6UElPaQ01AndWg4PbkPo3EgkBjeG9V0ErP0KNlUD8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=NMTjbLSb3LXf1iVDfJKjQRMbkHf9mPDJYsyhfKhVT3/rA4BR+rO53Zw5zZ6rzGVTA
	 Y101+129P+/3zbto2OwmXjle7aT3pkWU6+RUiQfi3rNyZINXRaN4df64iXy6cXa28b
	 9FARR/Z7GIEzSU1BDJ4uVIbdDlhtnZv8iiFMsNxIbXtWSh3hz5gjLxap3qA6fD0GEq
	 aAra2PzrCbRtsZI3RInfbSI4xw49jbCOlI+hdmY5ijmuemhBWDn4xemCIVJb8jnhyj
	 kcBZqmNQVJvC7QEKqn6kUthuHwdaqIVwq+v7rXbDPN5KAoXz0uqaxbH3Cmh1oLRMTZ
	 GKrSp5ybVR5sg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c169ae1cb26so214696366b.1
        for <stable@vger.kernel.org>; Tue, 20 Oct 2026 19:06:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByeqi5U//8+zRsWDfIv2RtoesKa22KQBxU7AjbZ9pjIWQRccUcuvVQ59g/orxAbQG9Sdj/zA+k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLHzv71zx0xxStfuz4tLQWum7flAutH2JeJC3WXGD1wmyTk3zhp
	HDPtsetIiHel9+mUhIC0mecCLoKLJg417bNVgkAfyBYGawONfjuLVROUviIscl8dLrr4ML1F0vx
	wyWo1q1o2py4OHqOPxSbFXQo1So812jY=
X-Received: by 2002:a17:907:3e97:b0:c41:d447:8cfd with SMTP id
 a640c23a62f3a-c4603fff7cemr317952266b.14.1792548409239; Tue, 20 Oct 2026
 19:06:49 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020175254.900284-2-bestswngs@gmail.com>
In-Reply-To: <20261020175254.900284-2-bestswngs@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 21 Oct 2026 11:06:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9nwp=X8AfzqTs9231i6SVoX7wuBqVvUfgBP2a8xrt+ow@mail.gmail.com>
X-Gm-Features: AclHuK8zx3LKE8QhYy0wPgoLL5ouP5Fjp4oCR73y7YVcSNDQv3hX7_G5BtFAtuM
Message-ID: <CAKYAXd9nwp=X8AfzqTs9231i6SVoX7wuBqVvUfgBP2a8xrt+ow@mail.gmail.com>
Subject: Re: [PATCH] smb/server: prevent file publication after tree disconnect
To: Weiming Shi <bestswngs@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, 
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Ronnie Sahlberg <lsahlber@redhat.com>, 
	Hyunchul Lee <hyc.lee@gmail.com>, Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org, 
	co+d531129f2f9fbf88@bugs.sh
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 2:53=E2=80=AFAM Weiming Shi <bestswngs@gmail.com> w=
rote:
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
This patch does not apply cleanly to the ksmbd-for-next branch. Could
you please rebase it onto that branch and resend it?
Thanks!
