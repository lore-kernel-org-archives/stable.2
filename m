Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794859646;
	b=be7fmtInZA/hYbbwkizHlv0meXqELcRL4f7rc28bpc72stljZ5Tg1gZsTiCAQrk0es+O
	 vvysH2e/PNFdfcdKzjRYy3xWqCpIH9nikxawzGFtJD/wIDchb+1ihppXXYxizJbfnEO2E
	 6RCjXbuubXHmMmGzLJwyfLkXYEdGoySV0tr9akNL5uLApUtUBFpyUg7N9uhuQwKnZNHbX
	 sLAHHEFb/2afC1Kpf/DCGCy/WY3DBOHhPMn4p4GdZNDhwDILrx/B0SQal+756VLoNbicI
	 q65L4ddj88dkfX+vcadzA1eqAa2I7qCXSXli6l4FshaYlvf5Vj1Y1M+d2OV7/+GA0kg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794859646;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
	b=CHJjEzQy1N6KczKyPwRMq9T8GEj+B4L/7uBBU5qBVSzjfc361RT1JAjXRdAzI/tr76qi
	 a+KqwRSRR3TapAiuX2bM66juUxF9hr63UoCluX4nVL2l4kmgSpUAC8ADX3AQ1QazB1zbY
	 pzmP8y/PBhLdwJ9uFGZDvvxnAu+yYfH3pflAioYxbFp6vPivThVBRDTVQG3M8irhGQLBO
	 idvN3q2lEpnMltUYBP6VjrqrMVAixPzlSwC+gES5diFg4ZovuCdM8/edAJd2BMAli5Gge
	 LF7dZrl47f110UD7cL0MaMPLy2sYFVNOFLJ8vFHlaZ4griIaTgqZzu6sSPsKnRte7mA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XFDBy0c2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208C2606A33F
	for <stable@vger.kernel.org>; Mon, 16 Nov 2026 20:07:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 208C2606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XFDBy0c2
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso32098795e9.1
        for <stable@vger.kernel.org>; Mon, 16 Nov 2026 12:07:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794859644; cv=none;
        d=google.com; s=arc-20260327;
        b=EpiSDO1Ob4PANyzLDVJLJ/MGN+HVIzJV55u7GZYT6ALr76zrjBZhfImiViEJJQXSlD
         9FQkMAeyH9pHHufmGc4a78Tiec+//v6hpO9uwm1riVFSi4pBxyrLc9Dve0lN+1fG234e
         xTpwME8fhKC7KBDRMOSZ4CPquRWawI5ANUEvKDz2S9pTRud2fhKy/ARlx/c/JE2dJ5By
         glsL2/IwANGeKoraqHWmoSBH+2NHPP2Q8KlzRLTqLl/kx6fE3ZZD3XZDoSyKQOBLbnEq
         FDvby8pdqI2/3uvEHm0xUGCMQmvc93BxfyvDQXrPwkVEpMf8g7+FYRJIHpVIm4aTzVCU
         mUTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
        fh=eAKSI0q0N3SwZ8/heij7YcCVvhwzU9OVqVKtshFlgY4=;
        b=f4rtEyg1I5VhFBnBDVNC71GVa2tnSkbM92Hj2vi1BDLvWA1tWx+qgQr8Jk6xT+WGmO
         2xeExsmMTR7vy9PCO6cc9zxYs5ecagxxOJqFRxxe6I3M3Ea4gEXeYE4rLRRBSIn8zfou
         TQGwlt6lmKVyhFdf/ZwbPVcILctxb9kPd7u2Wo1OAykmIkyxrQkv0hp2bUbfSsBgp61h
         3MGa2//xcXiGvVGI2uNZ7Ih1zGimWNflkWPVXUuIrrJ7v02+6sCXAv6Vp+JE69b46ffS
         K0H4DCKT8XYJkca85GBbZ9Ke4xLNr9euFYxl5oNRR+z8C9xDh9hma3CGAaAZ/5yYRnJp
         /+LQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794859644; x=1795464444; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
        b=XFDBy0c2q6nTYiJ4dwLENH1mguXX/IcFF58gOeYQArjps79P1XpkrhGZpUclTyZwpS
         r/ZYwRoOG8WhRg+8JvLZN08T5FQLHs7jA/CzeQCQsJeulI93s02F+iYtli/pBjYHG+CR
         W2MoU0n/+grSPpLZW83MAsn9WQiLh5CCwtBf/0GxLqRHC416IFZ4i13TeIFhLxmbz0il
         NPxDzLDOL7N17VVYsTOL0jDLDvB5woBcjlvcU+oGB0Wrnz6q9rCc3VHuwmdjl71ac6+n
         fuvYHmykPJU4vuSvTSKMetyKY9BqLddb2of0qXOJ87q21uNxSrudqkhk+T/+cyqihyd7
         2YNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794859644; x=1795464444;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EZDAQV8yhgMyPQgwR3U/5djFDS4+SZxlS+9+Esw/bYc=;
        b=0axSYJB5OPYBgNqH3tSjNz9UYM2w5jF005LeaWQbFGye68jL429dsYvXAA4lI53sZK
         bqInU72Q30k4nO0DlCE0DMUEVHmrYa3bozSsJL1biVZlwJEQZNpeA9YrhLhJp+4qrZfP
         2H8/wvlxAMOA1LzRLhoYe9aV3ggwIPc+KQ0jHc/GNTRLZH3Jck4Ehn/qUngLDRAjV1ML
         Q2Er6EkVkvND2CClYUi3/S2qFG3+k/2FFhKAMsMBU4XBUhM+TP91ekflcKQj0jHIYoe5
         1t1aS86Ud+4h25CwT/soA0ol443zXdfly26HFAXQLgBL1ZDLBSIF/8q3FTgn5xgcuIcU
         ug9g==
X-Forwarded-Encrypted: i=1; AL+hErHRKQWkZfrP6X+itCOfJBGNubiBV+O/4OKzNDfe5WCf3kVYCtoTne6Z5bIc0s7FgJg9LtPSDo8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8uO59kG54b1Fr39qVrBjnw++f9ZLVC9sHFzfND4/bPL3amQIOM
	Mw9hLJD6qsRaHaOBr/Pl1dz6gI6eNcyIzl9sTl8ZdtjIl/o1WGbixsSUoBlD0psdNQGDo3JiXci
	Qk9d/pOmUGpcNL+p3TqjhhnihrIT5u98=
X-Gm-Gg: AYBFou3EKupVHvPxoY8SZXRP0ciLVKcKQs/rNxEKV5zXK6EVk9WNda33w53FqedWX1z
	sral0YwJHH9BWXLsOXxcUVF/8O3M7b5XhIRt5ScFa+Gzi+bOO8O1lsMxmvh80i+Hc/XsPeLG+ZW
	mo/JD6Je8Rlv1NGnVTKVeXKJAukoynypP5XApbJvlqnw1tJw7qkCakiK8xd0p9J6sqRbentviPe
	WXhD1wX5tvheP8tdqHtR3OVVN4ozsN6G1ADAqGjd01Z2zU8zOl1QUqIHPkOI2mzNfRfxP+oIcF+
	rj4zOq6TP28T/HQoluuuwf/uK7h0CcRB5E7djAgFnnTo8yQRXCCyVOw1tVHh+le3vIms8RRJsdx
	jlsx4aCSn1V0f2Sc4iK1EYmJtSohSSptzvhbf+tonAD/SIF7cXTw9yUSIZv3mQiuvGYLReVle/n
	M/lHV1kd6IoBGi2nSi5A==
X-Received: by 2002:a05:600c:506:b0:4a1:f377:5c6c with SMTP id
 5b1f17b1804b1-4bb55a5d6bbmr165067875e9.10.1794859644313; Mon, 16 Nov 2026
 12:07:24 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116-work-fs-frozen_writes-v2-0-ecc4a2aac40e@kernel.org> <20261116-work-fs-frozen_writes-v2-13-ecc4a2aac40e@kernel.org>
In-Reply-To: <20261116-work-fs-frozen_writes-v2-13-ecc4a2aac40e@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 16 Nov 2026 12:07:13 -0800
X-Gm-Features: Aa3M54rpWiCplKeR8o5TX-NbYGDID_36BWk-3VAyUzdEoXSYZ7J-t8pfWvm9Fcc
Message-ID: <CAEf4BzYANM9vtQ8L9-rJPQC-tTcw3YUGsw=qnCaoym3+EU=DBg@mail.gmail.com>
Subject: Re: [PATCH v2 13/17] bpf: fs/xattr: take freeze protection in the
 xattr kfuncs
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, io-uring@vger.kernel.org, 
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, bpf@vger.kernel.org, linux-nfs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 3:13=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> bpf_set_dentry_xattr() and bpf_remove_dentry_xattr() go through
> __vfs_setxattr() and __vfs_removexattr() which leave freeze protection
> to the caller. BPF LSM programs call them from sleepable hooks such as
> file_open where nobody holds it. So a program can modify a frozen
> filesystem.
>
> The hook may already hold freeze protection or locks a frozen
> filesystem would make us wait under. So don't wait for a thaw. Fail
> with -EBUSY if the filesystem is frozen.
>
> The _locked variants are only used from hooks that run inside setattr,
> setxattr, removexattr, unlink and rmdir. Their callers hold freeze
> protection already.
>
> Fixes: 56467292794b ("bpf: fs/xattr: Add BPF kfuncs to set and remove xat=
trs")
> Cc: stable@vger.kernel.org
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  fs/bpf_fs_kfuncs.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
> index 35ccd98a4de64..7f61e2efa08ba 100644
> --- a/fs/bpf_fs_kfuncs.c
> +++ b/fs/bpf_fs_kfuncs.c
> @@ -295,9 +295,13 @@ __bpf_kfunc int bpf_set_dentry_xattr(struct dentry *=
dentry, const char *name__st
>         if (!inode)
>                 return -EINVAL;
>
> +       /* The hook may hold locks or freeze protection already. */
> +       if (!sb_start_write_trylock(inode->i_sb))
> +               return -EBUSY;
>         inode_lock(inode);
>         ret =3D bpf_set_dentry_xattr_locked(dentry, name__str, value_p, f=
lags);
>         inode_unlock(inode);
> +       sb_end_write(inode->i_sb);
>         return ret;
>  }
>
> @@ -323,9 +327,13 @@ __bpf_kfunc int bpf_remove_dentry_xattr(struct dentr=
y *dentry, const char *name_
>         if (!inode)
>                 return -EINVAL;
>
> +       /* The hook may hold locks or freeze protection already. */
> +       if (!sb_start_write_trylock(inode->i_sb))
> +               return -EBUSY;
>         inode_lock(inode);
>         ret =3D bpf_remove_dentry_xattr_locked(dentry, name__str);
>         inode_unlock(inode);
> +       sb_end_write(inode->i_sb);
>         return ret;
>  }
>
>
> --
> 2.53.0
>
>
