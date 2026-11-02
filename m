Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793637775;
	b=qICWNLUzIB5K6nxXCNqowNTRuYwz26dbcf/J+MTd5Y8MdfjWCRghGiGJUbhdeMRVk4rE
	 1s5CitxEJEdhkLyLG5vm3kQa4BL+31WO1sUVmPJyb+2OozS45Jb5eay6tyxwCprb3w9QN
	 ZgjhoVarP32UEXvMhMSv30PmuFxvM4bpTOr5GWMY24X8CSrOONL4zf7ywu2KHlvkl8ZzT
	 44ZGdsfafG9p1ouTSdR3D27s/40GZ4gLN/BR2wJwlzSod43sX1ZUBqeuradwx1Qlz9Cjg
	 6x4s7BLgd21uUsuE71NW+IdqIB7tDFgshU4Qm1bgDtT5g8Yvut5n3EToXpKjaWsd/uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793637775;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=/lr0BMP7asm8lPzTS0i2/1MVYdtwdCx6avO+q5t7f6k=;
	b=hnB+1DoS8vawxy5pc0+LlvtKIRC76BEKhpLobGoYj3hrtsIhTSxpzXD9W1c1nqvwJ/W7
	 z6MAsK5e2xESZcb/DdC53CLqXjTfiJ5FGq71Ac10geMcBgVioBJ0eShm9ZSfNI5rJ40dD
	 uK9rRHuTG4A9SVI1tAR53EtqbNSLFwwlKLanB7r9nWvbBKNSIZCIPzCXzmOEuQXerJPUf
	 nr7GdWDC6kudP7WoTYlS76un97cA4rnKUt+45VpomZZbYSLM4vpuhAnt76/M+XyhhJ36E
	 ri7lI0PGdteinZ6lRLKkO+/mODfcMJbfXEBuhCmnDGl8rGcwhJJ/7+lvmM+K1+9CZTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQa30JGC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A233360A3833;
	Mon,  2 Nov 2026 16:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bQa30JGC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51431F00A17;
	Mon,  2 Nov 2026 16:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793637774;
	bh=/lr0BMP7asm8lPzTS0i2/1MVYdtwdCx6avO+q5t7f6k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bQa30JGCbgufdumrmaB5sthqhQ7NtR0T0d6XsL/AcDlXXP9So7l9P4GHIayYuKRYn
	 W9sWsuDrqEXIcuspeWf3ZmSuFwHfu6R1uDmRtzJWmqS7uDQaux+cQ6t15c0GqbXVjl
	 8jgoeNUj16YHf5cD0d71bBeYrW0+d0dJ/++fCHXCUja4eb2TzqSvRK5vtjeBiEvDz4
	 idFRU5LXmC8BHxpC5pCRFuqnZCC6oTHlLuOLRAgKEK9gs576P4EjgKnbf4x3+BxJu/
	 mpWhOOjNZgC47oD+aRvxF1dbEwz+DCNSAsqR4mUEpTWzK2JdMm508xiJrejLZHXtzJ
	 heoGsOlgK3Ayg==
Date: Mon, 2 Nov 2026 16:42:52 +0000
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Cc: Zhan Xusheng <zhanxusheng1024@gmail.com>, lihongbo22@huawei.com,
	sandeen@redhat.com, linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, zhanxusheng@xiaomi.com,
	syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 2/2] f2fs: free the quota file name that remount drops
Message-ID: <aui9jHfAfNBMbyvo@google.com>
References: <20261030072423.197883-1-zhanxusheng1024@gmail.com>
 <20261030072423.197883-2-zhanxusheng1024@gmail.com>
 <a096053d-3f01-42aa-a933-50145abb874d@kernel.org>
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
In-Reply-To: <a096053d-3f01-42aa-a933-50145abb874d@kernel.org>

On 11/02, Chao Yu wrote:
> On 10/30/26 15:24, Zhan Xusheng wrote:
> > From: Zhan Xusheng <zhanxusheng@xiaomi.com>
> > 
> > Remounting with an empty journalled quota option such as "usrjquota="
> > clears the name, but f2fs_apply_quota_options() overwrites the old
> > string without freeing it, so every such remount leaks it.
> > 
> > Free it after a grace period, as f2fs_show_options() may still be
> > reading it.
> > 
> > Fixes: d18535132523 ("f2fs: separate the options parsing and options checking")
> 
> BTW, shouldn't it be:
> 
> Fixes: ff11d8701b77 ("f2fs: fix to allow removing qf_name")

It seems this one is correct. Applied.

> 
> Thanks,
> 
> > Reported-by: syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=6c000dea1a93b4f5905c
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
> > ---
> > Tested in QEMU with KASAN and kmemleak, remounting with "usrjquota="
> > and "usrjquota=f2fs" in a loop while reading /proc/mounts: nothing is
> > reported.  A plain kfree() here trips KASAN in f2fs_show_options().
> > 
> >   fs/f2fs/super.c | 7 +++++--
> >   1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 510df7998c18..d86ab25fbcc5 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -1646,7 +1646,7 @@ static void f2fs_apply_quota_options(struct fs_context *fc,
> >   	struct f2fs_fs_context *ctx = fc->fs_private;
> >   	struct f2fs_sb_info *sbi = F2FS_SB(sb);
> >   	bool quota_feature = f2fs_sb_has_quota_ino(sbi);
> > -	char *qname;
> > +	char *qname, *old;
> >   	int i;
> >   	if (quota_feature)
> > @@ -1662,7 +1662,10 @@ static void f2fs_apply_quota_options(struct fs_context *fc,
> >   					GFP_KERNEL | __GFP_NOFAIL);
> >   			set_opt(sbi, QUOTA);
> >   		}
> > -		F2FS_OPTION(sbi).s_qf_names[i] = qname;
> > +		old = F2FS_OPTION(sbi).s_qf_names[i];
> > +		/* Pairs with READ_ONCE() in f2fs_show_quota_options() */
> > +		smp_store_release(&F2FS_OPTION(sbi).s_qf_names[i], qname);
> > +		kfree_rcu_mightsleep(old);
> >   	}
> >   	if (ctx->spec_mask & F2FS_SPEC_jqfmt)
> 
