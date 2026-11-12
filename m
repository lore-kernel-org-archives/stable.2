Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794474345;
	b=swhh689P9nLFitx+WJJ2U0evguNkVzP+VfbBlyilYnKlzTFvVd5rPUSYa+HLquaDO4DS
	 UhOD6MFNfIGYYZV5f+T7AWVK8udkhvmJC2RXhHcSaJ6K5Q6K7tBBpJl7yVmZrS7vYzE5r
	 /xNbQrLT5w91FwXAHQZVuP3tANL4IboekTDTs6Pf7y0SB9Vnu3N7rehzcMlYdnyU6rVOe
	 cqYxLzBYCrfsfaOzTI0hfs2m/CtU0HNX1MVSXSLpTA9VsKGClDYmC99Ax0R6WuzVl0JPu
	 ts8Y1nCZVMQowfeLZkadMR8iSng/HgF+C/s+d2XmSa0NW7CmpuAzUzdlJvEtS3wAhxg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794474345;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=2YDeOkcw8pKng7xa6MjUhg5yuzbiBU7gfsp8ZW6aPdk=;
	b=kbXLUpsuoXgKO4ZFGbhMgC9JBhU9+cw7VpQp2HakkqKG+83iRkPYpw5jHpW8sZlkU+oE
	 tCMvuNOQQ4EJUysP9/6G5cFev0GF4/HSiDryIeNtaTrhrTCNzHJP5QMzH9EMNB814aWSX
	 sZByvxYHjWjDVIohD1IJMjE6WGxynAk9/JWEFxOUFRnREvaeKP86ncI9wBEMkUVncl0SZ
	 lZg/gedux0cWYHvcFOz28Yf66Z8WZarQliv5sQPbN/1zpB1xTWFl0qrn7aFfZxTAbkTgN
	 bDeis93ID69G2wojTIF9YiO5HvBkC/IKUz5oBLgQnVADSWQVGXD0D/d+aiSSYVS4yJA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0A8PUOsi;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.45
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FEC3606A8B7
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 09:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7FEC3606A8B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0A8PUOsi
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b570ff3dfdso4367147a12.3
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 01:05:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794474344; cv=none;
        d=google.com; s=arc-20260327;
        b=XC7rOCilcuN4Xpd54Uz3q4EDX/VD/fZIoKpqoa6Ctauf60tm4pk27Xx37bs7WBStkx
         OSIEUDx5r4iLbrBmHgiS5ROplJg2UgswltAlUQ/MLuaUCDBYDI4eiueJZP2UNS1aeJzL
         /o96m1o2iX20aE8+xqy1KNcV042PVm+vy3nRn6DlqcWaX6YcZlHDv5zBM5RJKUjnJI0/
         XpDb3vudgNj2WlGDB6O1wf5NFqDG1CkCdEPK4V3AzKwjDOeNkckpwyELWN55ol7XbNEG
         pFhy8YM7mIddQf8oELPzHrahqDLspvNVUOGDK82Vxd+6tsMoBf/7ubKsXOUfojw3YcJy
         nwlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2YDeOkcw8pKng7xa6MjUhg5yuzbiBU7gfsp8ZW6aPdk=;
        fh=XrQ4OYuoFbiJbtT4kVUo8hxDR+IJoeJRKj+YHCJeJEo=;
        b=AckoKhzAh8WHl3Ws+xXe2/urEx/SPPwRHi4hHZVQxH9YNJawshD+LnQ5SL9TSmpJi/
         tXo+eE7Bx40lDp699ZeR2elt2Mi/scVWp5o4+lGyGIN4D9oBivGmkAJpHXjXdXdi8McO
         6V8Q6sH7NEqkGUwXlH5pNdDmLLh+nsj+OuJN5EUeAMMPl0rEytxKa0dAnfETVzNKFxKo
         j/ey3LlfM69TdfE/GmGJB3CR3wfLeNuAN1grSYHkGmvx7mKqhohnASJan5kAdx2i9sQx
         g3COK+5QXAGa4lPBcxHC/QCET082vxiMBqL4A+lDpOcmp9zzMs2975aGZRYbxRoKglqQ
         I3pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794474344; x=1795079144; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2YDeOkcw8pKng7xa6MjUhg5yuzbiBU7gfsp8ZW6aPdk=;
        b=0A8PUOsigbnLKRA0cQE1ScA0Z4kie2drL6OqbTIiTpSmsDynYJ3/g6Yzh3R2e5iQ4l
         s6BJPtRsDUJyhy4hl8t8nlCIeKCVbjJvekYd+YDQgqd07nDfxVvyPiB53KgLPJoh0sYm
         GcEpysYVSRzXizT92eBxHkyzleFhKjB8b1S1ORi8UNEw6ssWowPlIj7GCom+Y18vkpBo
         lus2F7U99h4sH7yVa44fd29K7f/td26XZS/EHMa9TsqJhYSR35mWovAHXewrZzXaPcgT
         zDVAX6uSOAKWnPclwRPdwun603B5Kw1ZDVzUI6S6340nyyrIhBalsVm7+g11uLnvknlu
         4jlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794474344; x=1795079144;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2YDeOkcw8pKng7xa6MjUhg5yuzbiBU7gfsp8ZW6aPdk=;
        b=AmT3RY1+BO9NtCuCGK36C6YpQBE3NrbfpmAAScwsNpWd6E69e1A7IEbS7wBNaorUmV
         7itCe1ipjBZ/R/3+cF7YSX/Qzxi8twLhcjUdJ03m1/AoTqDm2zfQqlrqYttShopwzDHk
         32IJI3LPku9RTpM+NtsmAjxPJUcCjV53Xj54nCsnzUhb+5kCAC90tdgiayI5swuBdhlw
         YupCAXplezLamwShHjQyR4fsDAJ1p7Jhl4QWe4FnyAVnrXcyAjbSA/N/KzA/2Iy+PEHf
         UaGCHv2kW/P7sxUfMqH5z9iaQ558KN4rwl29aCamyEwptRl0UdbUjWqxLbk0qjYoCapw
         yBTw==
X-Gm-Message-State: APuU4Z+TP/nBjoHHdHCIv1DHhIEr4Z5T7k9wwWrulEdkI4xcrafVufmR
	ZDpf4fx0X90tk+UlDzA/T6C3jt8etvdt3+ZyeO6W+0SyFP0HPNHcZ/f63Hj9iHH8zHfBSsplalk
	mVJ7/R56qxQj4kMZUQ0X30msa+E0M9Q0=
X-Gm-Gg: AYBFou0FzT5Mglaq0Lwf1y1e3BCqQWJy1YBplGNN+GCOxpf/oqZW+vjDI+7zfXsQxo1
	dK6vtXWNlvKfozR6/9rE29+SuoT8WpIJfq8dek1DSHJ+eETXo2wCxJJ/lf30k5ZTUc0EFCbH6VB
	rg5kIU9fuOrlJHRVY1PCY+E+jLwnF+4ECGK6atrOyzdnrMyL7Y/BqNhbzbtrdM5VZdF+MZqq7+i
	Yn4yzC4SnOwUaU0ObRJ42gks5i8OJJjyQPXlB/uiKRBl9Vw9+mNV8HdnJZndu/tzTd9yRqmrnoe
	gzk3J2vHjYh6dp4jZIx+AQUDpa3sWlACzmC73OALpemsuVZlMOL3oZyoNg183CjFYDg+5ZCQJvX
	8myz4raYnPPHVkSqfIdUUxF6f0lUX5JLq7HL7TCrBxW0fuglkv9PAr+WCEf1zKmEYDZlyJA==
X-Received: by 2002:a05:6402:2395:b0:6b4:bf13:b4a3 with SMTP id
 4fb4d7f45d1cf-6b777836258mr2557897a12.43.1794474343584; Thu, 12 Nov 2026
 01:05:43 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261109200525-failed-6.18-c782fc8ada81@kernel.org> <20261112084347.6208-1-dennylin0707@gmail.com>
In-Reply-To: <20261112084347.6208-1-dennylin0707@gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 12 Nov 2026 10:05:32 +0100
X-Gm-Features: AclHuK8O1jq3G51hczk116qUQ7sCnWGjJBjRMAZZpZxJRO38CDO42E1yJfBhtHk
Message-ID: <CAOQ4uxirbtnBbeyHbq=gm+ttA=0nusQjsCoK0FsajZfqL1ZEMA@mail.gmail.com>
Subject: Re: [PATCH 6.18.y] ovl: fail the mount if the casefold flag has changed
To: Hungyu Lin <dennylin0707@gmail.com>
Cc: stable@vger.kernel.org, sashal@kernel.org, Chris Mason <mason@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 9:43=E2=80=AFAM Hungyu Lin <dennylin0707@gmail.com>=
 wrote:
>
> From: Chris Mason <mason@kernel.org>
>
> [ Upstream commit c782fc8ada811569811c0fdea5c3412511be95d0 ]
>
> The casefold flag of the overlay root must match the flag recorded when
> validating the layer roots. If these values disagree when creating the
> root inode, fail the mount with -EINVAL instead of warning and allowing
> the mount to continue.
>

What happened to the original commit message?

> In 6.18, ovl_fill_super() still owns the credentials and error cleanup.
> Drop the local root dentry before publishing it and use out_err to
> revert credentials and release the overlay state. The root inode
> already owns the overlay entry, so bypass out_free_oe.

This is better placed just before your signed-off line
inside [backport: ...] or [hungyu: ...] comment

to preserve the context of the original commit message
and to make it clearer what changed in stable and who signed off on what

Thanks,
Amir.

>
> Fixes: f9377faaeae0 ("ovl: Add S_CASEFOLD as part of the inode flag to be=
 copied")
> Cc: stable@vger.kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> Tested-by: Hungyu Lin <dennylin0707@gmail.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
> ---
>  fs/overlayfs/super.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
> index 8d4ef5b..52d6f32 100644
> --- a/fs/overlayfs/super.c
> +++ b/fs/overlayfs/super.c
> @@ -1370,7 +1370,6 @@ static struct dentry *ovl_get_root(struct super_blo=
ck *sb,
>         ovl_dentry_set_flag(OVL_E_CONNECTED, root);
>         ovl_set_upperdata(d_inode(root));
>         ovl_inode_init(d_inode(root), &oip, ino, fsid);
> -       WARN_ON(!!IS_CASEFOLDED(d_inode(root)) !=3D ofs->casefold);
>         ovl_dentry_init_flags(root, upperdentry, oe, DCACHE_OP_WEAK_REVAL=
IDATE);
>         /* root keeps a reference of upperdentry */
>         dget(upperdentry);
> @@ -1576,6 +1575,17 @@ int ovl_fill_super(struct super_block *sb, struct =
fs_context *fc)
>         if (!root_dentry)
>                 goto out_free_oe;
>
> +       /*
> +        * The casefold flag of an empty layer root may have changed sinc=
e the
> +        * mount options were parsed. The root inode owns oe by now.
> +        */
> +       if (!!IS_CASEFOLDED(d_inode(root_dentry)) !=3D ofs->casefold) {
> +               pr_err("casefold flag of the root directory has changed\n=
");
> +               dput(root_dentry);
> +               err =3D -EINVAL;
> +               goto out_err;
> +       }
> +
>         sb->s_root =3D root_dentry;
>
>         ovl_revert_creds(old_cred);
> --
> 2.50.1 (Apple Git-155)
>
