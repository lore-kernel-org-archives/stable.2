Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128CA3AF647
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 05:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788155715; cv=pass; b=MS4LYXsXiegTLp3u8se4F3JRpja2+udHK5f363FhYyxQua7YbKGDDPfiXO1rnBO6MEnbM1jWcxoFnLbDoxNXnT5hIcvCzrQ6taIzCVyT/H+ETDGw1uNTYiqspqe4dSpRoalGpLbAKbAguZAscC22+esflWDaKKsviL4TZYdGsLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788155715; c=relaxed/simple;
	bh=avFXt2NwZSaJmZTlq/99ONsB7S23gzDNnpMAoXMT6+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KM87kWsKlcw9PcqKh1hcVLq1tWFtp7xApaYQbzqJCjVaZ0PxQBBImPn5akmtrwje2eUdhuOHyMIMMGnwuuWel3nTHHqpxMc0aNOz6dntFyPDIOg/1UcpipjFBDXy6EUMdAsaXEz46tczhSkMWWOXs/npdXugV5S37lhMDBIoFhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H55fAUK5; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H55fAUK5"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3a20367cf82so25632671fa.1
        for <stable@vger.kernel.org>; Sun, 30 Aug 2026 22:55:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788155710; cv=none;
        d=google.com; s=arc-20260327;
        b=FbBe+/rEL5CtwOUSxBkvJqugARSdUJZbWwFxVFa/FD40wgbmLsACBLiycGHvMnaTWL
         hLmRDqjHoWzQHghPoNYL1J2yTrQWPuzhlxm2Z98ycL9UlVPG1IjyWTolAXIRZYjPz+YE
         pZIwn0Pgv6b+fHyHXKkelJL5hFsAdZTvGG4fKEMI6zcbAvZL5YpkutdJYqQsuqSd8p3G
         e4OplEmt136tLFKg8TK+4jyb/vxXi/6nZWZUnSyX/nc8B2D4Qq7KYL3ahSttzZD6jiBF
         67r/4kPbG9DBbKkVTW+okxHJRzmsk4XiMmMKlnwhLqd73zfQtZJXou0LxoDcaEmYZ8sK
         FtKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7sLw2AeV2P6KNEKrsx6930m88AgTvdoPZQBUw+YeVAs=;
        fh=gJkafAC6EThQi45mQqtbdUwdV8VRD9R3hcnDG/z2cBQ=;
        b=rtI/WfjhuKQYxzDKBaiuB37/l3pADoOJurFA4DhYvmEo452llfksb9kwGkYry3a96w
         ZWbelL67T3kq1cCIN/BfaRmVM/4synaewx5fSmb1E4JxEK+aaynM83WXOigrGEn1v2pS
         iNujYkD0mzkfDHpFvgaaCzVxDPslFkWWK9TyA1RtA+MH4ahkSJCJ1nnQcd0HXSZX08fB
         8jZSmB5l2hE6fQQnVAoMd6AtilrHo/nUM4iuJtqHi7sVEK9u44EoL/VnKRaQVF9tPbh4
         rLTCfV004VNqv/RfKtXjAbm7idW6lhTkXBz9NPhsnzee0w2hnNzqXZP4/j2BTiAH73Lw
         60eA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788155710; x=1788760510; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7sLw2AeV2P6KNEKrsx6930m88AgTvdoPZQBUw+YeVAs=;
        b=H55fAUK5hkK6c9NN+g31qhVSnq5HfyGnNKZgu5I8gEBjXDsUDhiru9/OqBdTZWeG/W
         +dGcqAIMYJ+gDxV1KdkoISP4Q6zuzMicaKL4FOBEKTvyXQpT4NsVnWLOaVeAsblBBhTE
         28SrqwqLUyoAgQKF/DlwosFzYr6yyDAUs+ucjM2gXKTPeINtaAvfEkKWJw/P2N8E/7sw
         c/ay4Tkbcc5wb0ewEuhVO4OY5ntmMXiF4QytF68wbxeu342HDuV4OiM7FYrn616XeKtb
         yJEFG2nfIUSiwcNBOgqB3zHol0Gh/VdaJ69vK0v3YIzSqe1x9LROuNlaE4sTdzbBBLb9
         DVzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788155710; x=1788760510;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7sLw2AeV2P6KNEKrsx6930m88AgTvdoPZQBUw+YeVAs=;
        b=CgkJvtbxmaaRCNfeXw/n6DOIE6XM2K2CwsYURsc2/Pm7LAhoBTWP/oqQx3nY735vwj
         Ub7DHUNR4FBZ5aFa1Hk3xOZaB4IaToD7/A9+mM3rYuuKGfmkxRR6I4pbhjDJNQOpsd1Z
         wytUpeb0vZYX2ZAJn91iJbJm2IkSK8qN5dxj/RRIVBbscDbB1L98a3NPF9BnP0cvQNpA
         DJO6osL+KGJgaW1E97pNmlHPjc9HsbKzF2d9xGD7oJNMsCMqc8P3FE234yIGIf1JwI2j
         OgvXPfZlj3C1zonW4nhx3a0r5DKu7HXIh62ZJ2hMLsn59Vfq4+uoomgbNOZEW19irR4K
         JKOg==
X-Forwarded-Encrypted: i=1; AKwUvBxnNiInrbGt5E/s6Gtl8rIrZ7kiv3PG9iMVIxcumwIYFimLtce8J858Nr3jSUFhOo71uM0zTXA=@vger.kernel.org
X-Gm-Message-State: AFuF++m9IJ8Sxr5WiRrZso/7sc8ymMK4T6DGhpDdYVFJ9pckf10N2VID
	njcgPcRE3q8C+M8fvkM9hKqwLOEktelVFhgucunott/P9cGp6MC+tM+f+bXJdABIJUyWBXq17Te
	qGsorDyLdnWDoBY/r6HlO7kal6jzmQdU=
X-Gm-Gg: AYBFou2GJ2qnbvE+dvQOK14LzClpbGfEI7pVNl3WvSdPX+X3AusM9bwj+pWuiwUwqrq
	c/ncOn8JDuTN8UKAPgSmYsl0HHcM6Yqyzmwn7TteXTVKMdn2NLOJ3kHnKaMwbu+zK7h9f9zA59+
	jtpqzV1IBRdXwtPR5KV/ULprPBTxhQXkWbC08KWXL0AdK0Igj0IeZsQIER/A/qLIvqfWCcIsLW1
	j0OPvrfSmJdwW//TYZaIal2Oe3VYTVBLjx3KUnMDtC4vUK2XcFRmgAErJwlHPQJCsj5AbTV9LPZ
	mblkHteE+PUGUBNWJBM/97Kvj3OhUQ/6WyU9WPKhhNWK
X-Received: by 2002:a05:651c:1117:20b0:3a2:522:c75 with SMTP id
 38308e7fff4ca-3a301acf03bmr40336271fa.4.1788155709731; Sun, 30 Aug 2026
 22:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828061607.240845-1-zenghongling@kylinos.cn>
In-Reply-To: <20260828061607.240845-1-zenghongling@kylinos.cn>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 31 Aug 2026 14:54:57 +0900
X-Gm-Features: AcwNN1Vq8QdxtrNHIaWYU8Wnk45GDQtB2EcUMzJdPzNM04Z_J89xYwtm8Deytzk
Message-ID: <CANFS6bbkTT1eXQ0DC5Xi1NW8LFv91Dv78ebg-nXecAZ-v1OLWQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ntfs: take invalidate_lock in ntfs_setattr_size()
To: Hongling Zeng <zenghongling@kylinos.cn>
Cc: linkinjeon@kernel.org, ntfs@lists.linux.dev, linux-kernel@vger.kernel.org, 
	zhongling0719@126.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 8=EC=9B=94 28=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 3:16, H=
ongling Zeng <zenghongling@kylinos.cn>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> ntfs_setattr_size() updates i_size and resizes the on-disk attribute
> without holding mapping->invalidate_lock.  Page faults take the lock
> shared, so a fault racing the resize can resolve a VCN against the
> transient runlist state of ntfs_non_resident_attr_expand() and fail
> with a spurious SIGBUS, and can interleave with the size-change
> epilogue (truncate_pagecache(), i_size_write(),
> pagecache_isize_extended()).
>
> Take invalidate_lock exclusively around the whole resize after
> inode_dio_wait(), matching the fallocate path and other filesystems
> such as xfs, which wraps truncate in its mmaplock (=3D invalidate_lock).
>
> Fixes: 9c87959601e8 ("ntfs: update file operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hongling Zeng <zenghongling@kylinos.cn>

Looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

--=20
Thanks,
Hyunchul
