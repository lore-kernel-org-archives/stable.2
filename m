Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794825152;
	b=sfYIbv8CIpne04ILlouUXWGqo5+D0PeVryoCnptklj2Ttnti6Y42MQ11SJQ/42KRMU9B
	 Nosc0wKOx2XozWarJpZhI/5g6+xdgC+t/mIgERrh3vhX6FYvc50M3U6MxhuFb9LFzX4dJ
	 2NRCJXpKBVWrNImJfnec+rKIaf5iMb7g2QLSb+sp0uj+N/rh2OrYG+CQD8nxxEkj5Qr1v
	 XQ1YgcM5ZL1LRh03iJkzsG2FWvXmDauy2MpBDwTwP/n+kyN6PbBaYK735wOtM+e89RnZj
	 HaonuaPvFAFzsCdFP7oeb5N57zkLnbyQ5aoSC+DGCVgYIOPu48LmeLwR/Ug3BVHzdRQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794825152;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=0YW8PA+wzviZIV7gLvSi7w98vAeEHHR/1zk731Y72iw=;
	b=jUjkPrys04AsnDnkc8Nap3jd/rZ18aJzO9Zj9DtHHjU9Z3wXu+kBcLYw5h28rbEgqNFo
	 T2fLgTS9bosdhaeEuar14XsuqToezpLKZn2h5hvDgM9YHB9tR7aFoIK7yDwFp5wfFYCMK
	 CjEG8r+yYBZi5vLHK6wcP07ZA+/oKuqJ73HNeoKtJnBc7THddDp9as2jgfpLuNOwwFDDi
	 vgqZNdDqFgdgFMIrP73lbpejWjC6dqSGkzti6raPdzl/NKtzJXs/Q4svhhLrSW0y8PcqX
	 ysgVo8vgmhwVetNl9P9JaR5+hiWuxI5yBCfvef9/Bc97UZFlE7cnDH+irXVpSuyY0ew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vx02WRbu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F4E606A31C
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 10:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57F4E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vx02WRbu
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b65d69f5c2so4609405a12.3
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 02:32:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794825150; cv=none;
        d=google.com; s=arc-20260327;
        b=syTn1dUw5HLqxRvYOsS0V6fw5Z1vPxiKKIrV2Q8vsMhtpGi4oMPgakdGQK11E38vkO
         dRB+swfDphJPXRdYted5jGkAL+d31cppPAW2ZjnyErmQAwvw+w22OPzyH1uSGOCrYfN7
         Zz7XLbinkPOAQC1p2D6YSOElstferUfZsp2iopM5pnKUxjrabA6k9moYOVeUILGankpp
         54vRLNdiLAtvjyHyldySodHb2f0D1fA1YjoZt0bu0jJPRwTlKhPlhyWhnVH4m07jpYQi
         BqDebRKACeekd3Han3gogTBqM4VsIcm/vaj5gekwcMSLGht/3VAsOgJswA5zvO3EHUbM
         ersA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0YW8PA+wzviZIV7gLvSi7w98vAeEHHR/1zk731Y72iw=;
        fh=JdA7TE0yF5Cv8rwyhdcqBblVY/p/0eofdcd1HruNhGM=;
        b=rD4sJ2bCQ0p9ZkThuoJu5Tk68b3S0zVIG5WaBLbkAoO8rKCc9tXCSEXs7CRycOeKgB
         +UKCt8ABaEytdcTIUzvLNSd6HJbVYba6yNORBgkoClKFy9ivK6eOY/ZUA0q4C8Mq0Ykc
         Fv7xWKl4zgjLI6exPxTVghtrIhJtwEkmkOcPhSiUsBFwdK8+vMzqVyEpSQ365/05vD/l
         M7eDF9fa6/2tT2h8F8MF0aGl5j8ynbLLMfYpHiusYvrnBMKzfIv6JN9ZFggK8IfCQIrx
         VLorkxT4b6i8Gv/SyfAz09L4PyPyYI3/E0xnLog9JIlsSQvGOssf7QJ4QhSw5/vBk7zc
         BkOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794825150; x=1795429950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0YW8PA+wzviZIV7gLvSi7w98vAeEHHR/1zk731Y72iw=;
        b=vx02WRbuy3m6IuoTmZLjbXEH1SVf/+s2e5NYMP8zLIkFB7TDuM6FN77vlgdxymLlm7
         7GxcqalTg78KplnStO5kUr72C32hXL+t09BYxJ8ovOh5oqhyNx4iSVbeNwcBqRTR9yS5
         cBqGMAsFjR3s+grQoLxemWsbgtL2IkczGUUizL9DjmxiUAGGEWoZgF4vC4xcKDDWry10
         Em0NZ93TUoj4HGlvAS+ffvhR4v9we+WvcUTf9usRaSJNiE2Qk+VB4XlDBb5gX62pUHEj
         vtUOTc/E1vyTbCYb2PH0vA6MlhPqaCmjuVELDgD5prTge3q2muHag2AnKU0420jXFrPG
         MniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794825150; x=1795429950;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0YW8PA+wzviZIV7gLvSi7w98vAeEHHR/1zk731Y72iw=;
        b=CM0ZOlqPeMRhTvo7iXrGygN/OKVOePBjuIgEuNecjgg+Z5tDEOHbPSP9vjig1Jpufy
         Hbog2OQDCSXC44lEirK8pY35RL588YVpKsqd63yjtnAzWNA8WLX8I/fmBDYOcsZGOCKj
         mDKZPhzrAZukJgn0k45AWItFRWVSCwcMVsPG7ui+E99+4rf7qda7eNAJF6Q17N/TnEaE
         XcVEpcOE3vSwabeQ/l1urP5FedgK96Z5RkH5Ow6ck769FX5xNLajdBZ63QJ7QMO3As0E
         KzLdkTFXTJWvX+eoOweyjN0dGYIB84VFDsjp1mpcdNOTklIN4//2+1BVMHlEgbbfpMiw
         I/0g==
X-Forwarded-Encrypted: i=1; AL+hErH6jnULspxzplmqGfHP1EUOjXgpkmSueT9CgKp62xRsKMcgrfF+56rBsqKeZT8a27rP9ZgvHns=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NQMUy0++npPiYcbPdAItTwR+YGLUiH83PFX2OTiz1P0RexiqB
	2HeNq3D+gQaaXi3zn8ajgj4QeUIvRfgzfUFP45JEIqwX9ZtsRjqn7Uesm00QXTc/S0PYh8SCytz
	fXJAfVcAt5fqHc0NTPk7GMfeW6n0i9uo=
X-Gm-Gg: AYBFou2Emtn+Ul9sxt6LRudZaE5GSg00Rf/I63qbbZFb8PCnshfvI9YURtoayXagTOT
	FPo2DyfpAoiyC7T7YQDRJloEJ0QNb42I2UzAlPoT1idMmd/O/nRFhLY9Q8pg027Em5rg2bVewXI
	yP7+b+HMMnNjMkBnVgfx2jC3DBRoQUe7CiOl5wDUnAuNG9ByJyFgPltk171js2SvV7PmQFStiBS
	xcL2JN+rqCcB6Pm5/xqGmc6ZX7RXmkXTStT7Fp/MgaFuFW2FcN+Xr8mE0Tt1Id3VVGvE+1Bp/Ky
	INMFFpKjX9b0eZl/xBvmMPMs1NMHyshx+k3t8YHBULpXUJ+AlabHUDkucs74flswdO+dx4GEZNO
	b32gQtpQoBj62CSxCBHPiKM0eO69gXAPSIZTKfDpqaZTcgS/qTm9LTRVrxDZwvitF7LF3Mg==
X-Received: by 2002:a05:6402:a514:10b0:6ac:9a44:d3ed with SMTP id
 4fb4d7f45d1cf-6b7c08954bbmr4966094a12.5.1794825149341; Mon, 16 Nov 2026
 02:32:29 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261115210952.2140036-1-graypanda.inzag@gmail.com> <20261115210952.2140036-3-graypanda.inzag@gmail.com>
In-Reply-To: <20261115210952.2140036-3-graypanda.inzag@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 16 Nov 2026 11:32:17 +0100
X-Gm-Features: AclHuK8XXyhaCAgxTbITMp8zV3Fd6NqncgeiQCT2joxj7Z8uLLH7t09QB68vJSg
Message-ID: <CAOQ4uxhR=ERNBYsxQ06-sKGrTXvePpzv-xi+62oceNff6Mzzbw@mail.gmail.com>
Subject: Re: [PATCH 2/3] inotify: zero-pad event names after an embedded NUL
To: Junyoung Jang <graypanda.inzag@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, Matt Bobrowski <matt@bobrowski.net>, 
	Gwanhyun Lee <gwanhyunlee@gmail.com>, fuse-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 15, 2026 at 10:10=E2=80=AFPM Junyoung Jang
<graypanda.inzag@gmail.com> wrote:
>
> inotify_handle_inode_event() allocates the variable-length event with
> kmalloc() without zeroing the name buffer, sets event->name_len to
> name->len, and copies name->name with strscpy().
>
> If a dentry qstr contains an embedded NUL byte (for example, via a
> crafted FUSE READDIRPLUS entry aliasing an open directory), strscpy()
> stops at the first NUL while event->name_len still covers the trailing
> bytes. copy_event_to_user() then copies event->name_len bytes to
> userspace, leaking uninitialized slab memory from the tail of the
> event allocation.
>
> This mismatch dates back to
> commit ce163918cd33 ("inotify_handle_event(): don't bother with strlen()"=
),
> which replaced strlen(file_name->name) with file_name->len, and remained
> in commit b8f2688258f8 ("inotify: Use strscpy() for event->name copies").
>
> Switch to strscpy_pad() so any trailing bytes up to event->name_len + 1
> are zeroed.
>
> Fixes: ce163918cd33 ("inotify_handle_event(): don't bother with strlen()"=
)
> Cc: stable@vger.kernel.org
> Co-developed-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Gwanhyun Lee <gwanhyunlee@gmail.com>
> Signed-off-by: Junyoung Jang <graypanda.inzag@gmail.com>
> ---
>  fs/notify/inotify/inotify_fsnotify.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/notify/inotify/inotify_fsnotify.c b/fs/notify/inotify/ino=
tify_fsnotify.c
> index 6e3af6452dcc..78eb1e92a14c 100644
> --- a/fs/notify/inotify/inotify_fsnotify.c
> +++ b/fs/notify/inotify/inotify_fsnotify.c
> @@ -121,7 +121,7 @@ int inotify_handle_inode_event(struct fsnotify_mark *=
inode_mark, u32 mask,
>         event->sync_cookie =3D cookie;
>         event->name_len =3D len;
>         if (len)
> -               strscpy(event->name, name->name, event->name_len + 1);
> +               strscpy_pad(event->name, name->name, event->name_len + 1)=
;
>

I am not sure it is inotify/fanotify responsibility to hide awkward names
which filesystem emits.

First of all, I think the solution should be consistent with d_path(), so m=
emcpy
instead of strcpy here may be enough to avoid leaking uninit memory.

If we want to be nicer to userspace, then we could for example pad the
garbage bytes with "???" for here and for d_path(), but I don't think
this is worth the effort and also don't think that hiding the fs flaky name
with strscpy_pad() is the best way to go.

Thanks,
Amir.
