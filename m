Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8235B36F8FF
	for <stable@vger.kernel.org>; Sun,  5 Jul 2026 23:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783295618; cv=pass; b=lMdmxXGVfl9vXGiJDxLPsbnl6Wk9mS/YxH2ZyQYcPFxm+PBXk17KLghza4gUfc3xuxdQQPU3Bo829PfdDhNXXP7HlXFXCis9WC0Y9iPO1lktH/BzjCH8jo6Hhw7CeayvXf815bd3xUL1DfeyaTB1rJb0vNAsjQ4YDbxg1QC272g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783295618; c=relaxed/simple;
	bh=8zqCoHKFeC9uoz6U6aQKSJAwAQgmF7mbenzFeRzat10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JB/EAcG4zGi7oRPrkOl4M3IccGTeqQjPcOVzPFRLrid5qBJDcMksZXjnTVnNgBwk7taHOgxb+3Pbg2OGRDSOLul6UCsvZh0OWiMI66oXvF5hSPMF5JYjbZSp3J4VcF0NQli7QCAfeFPsylB3/g75g3KEHQeBYbtcrARK9ZAIM7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVCwGSMT; arc=pass smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVCwGSMT"
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5aebbeba529so1992165e87.0
        for <stable@vger.kernel.org>; Sun, 05 Jul 2026 16:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783295615; cv=none;
        d=google.com; s=arc-20260327;
        b=j1zWMz4g4xPVT+xCMq9+0RWJCUf21TlXHD63FjVP+p/GcSFldwKxrD6P7qZBM1gPk3
         W9I/Vxjhh10ot1nw1LGh+qGXWf1yhWEjjT+J34RiAkdYzxI6wRLAf2WN4MqPobkPLyRe
         nSAnd2dnk2cIftbLMlNOxBbCd27C9qetQkcs4y76440pZUlrgMlvhVoeeHlKlSSysDAj
         RzQQb4huPd3j9EunzWX6uFQeG3JxqZ4HoDru2uQZ0w5YxfoP1z2WP8Kba3C3mtFlkNU6
         NegRU9I+4demNws8IvsjiT9K7Ti/xkmyoaoPa473qoTmQW7Aw2UL92iQ/C1IUkDSDqx5
         Oc/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TTWw1o0EuThgWnzsFpwy1aimUMVGloN7lcc8yYZAv7Y=;
        fh=e/W5LfIBWUu5j1qaICFRgN62FrqmUfQlSW2fqfToUhU=;
        b=nxEIt8jIxENfK7ymRpxuy8ZjW582ydz9MqRLEh8nuy+yUQlk182C1G+pSfd5msUMVC
         1djqM7tVeaHW1Dazvpccepokbv0MgXIlpJesf6GY5b0aMIYmtL3xnE5POivWYRNjl/DK
         xtWzU0NY+z5Tl4EULeVkQOBUWpyhfzkEj/QbFva2sPPMWJX29f9IV6eeC+1fBPVlc9xo
         hq/1m1clBSEjG1YC2JZEMbBogJHkofk6/kbOh2xu7nCss05lt8vp9QCKf/pb3n4PVOqc
         D8GB066O4eUFA8HqnvqDC4pk3UqjXoYEePf2lA5Q9MaqNQspQ+Owbs6nXFe96ZHHPLMR
         +STw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783295615; x=1783900415; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TTWw1o0EuThgWnzsFpwy1aimUMVGloN7lcc8yYZAv7Y=;
        b=DVCwGSMT/2TeiSgXl2WpnZdhtYIyGKX5lHdylJOWp+bXjdlo0UdMRMn5hKoU3CxGRV
         sSr3yZDdDH4DuwT42oD5NcYuiYr4DxwZrHcTvQJqTw4Q0qL//yhR6bypUhnhIgqi6VMO
         VPrmdZyTmurZGwBIV+jfhUVqwSCnFQVpiUKlRrga8FhZoms+Xgj/fSy8xrXZHfXl69m3
         qnslDeKLE18Kk/su1RLwzNw3pdEl5zmf9WsSleasQUbj4uYCkfpbOaG6JY6J8L6Ufqew
         9oirABhoXjZZNzlnwSL+okPmCSWHYybdYZm048R3VROci0y8F8I6/aRJuXAROgoM/pve
         dzlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783295615; x=1783900415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TTWw1o0EuThgWnzsFpwy1aimUMVGloN7lcc8yYZAv7Y=;
        b=DjIIRs0cocGZ0ZnlLvdKqWNMMY2NLYEPj29hm9KCT9EfwwHTY3eRl5GkgsQK4o8y8B
         MQheX/sPWkEap2Dax0AMv+dhop78x9OgVMjRkLtNu+iOk9vwOqj2kkMfY+h0sH+W8J7A
         lt9bmWvbmU7GRQEHl97p+uv1hE6q2cg/Tom5HxOd4xDrnfZhLNAc0+Rmb0IzyFw3nW0Q
         uygl38xlsXqPL3rP+1Y0qT+Rffo/EnDl2wxh+Ro95op3r50zxOdYMhIi/OfDQAV9PDP+
         keoip6p5izCS/WKsZBH+GRcxI5te4ickNhHeHOo9oKCtKp9ABFc1GrNytiANft0b16H5
         f56g==
X-Forwarded-Encrypted: i=1; AHgh+RqKmxMcrjLPxlynXD88il5CrQo0qhVVtyqB/gRrjZrurMC4o703XmjW+d2LDPtLYLNCvG2jsUg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO0br75Kv76iZLW4h/VwsApjELYRgSXhKc3rcTaUxpoSwCJ5uE
	qRh6LCC1lmSgx/J7uqjnLPQq2nnIIVX0e30U62WaGGXoUsSGDQayHdnC2B0VVga0Wv4/5ivPqWW
	syxN5RKnNOjktOEpQ4mNZ/G8wvTbSCwQ=
X-Gm-Gg: AfdE7cmqtQakgTG8HxNjS6GV4Cr2wweO2O659ptVsN63ob79rPKcqO/D5K4oByKPq8a
	KPHAQwVcLeePYIxokBSzEJu42zckVwwJUopFDdKHJ2laMJfyMiKdX+amq6k0+jxPp8Azoumgm3Y
	3U1eMUcObWwnwjjis9LGTH3XDnvhR7cqvUoTQsSHXn2Ng1uqBo2L+1vSyXVFatvdzLMJrnNEnLQ
	MtnxLSIDh0IU9YkXfmnmoGTMgG5VQsd60pxOi65vDTD6JF3zjrNg4Vy5507WvAGS1YYVwaH
X-Received: by 2002:a05:6512:b84:b0:5ae:a9eb:c5c3 with SMTP id
 2adb3069b0e04-5aed50a6a58mr1605009e87.61.1783295614623; Sun, 05 Jul 2026
 16:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0B853B9F28048C99+20260703054528.2798189-1-peiyang_he@smail.nju.edu.cn>
In-Reply-To: <0B853B9F28048C99+20260703054528.2798189-1-peiyang_he@smail.nju.edu.cn>
From: Hyunchul Lee <hyc.lee@gmail.com>
Date: Mon, 6 Jul 2026 08:53:23 +0900
X-Gm-Features: AVVi8CdhdpUar1OlK7-HXFR-uDvQpqXaVafcsI4eb6LynpHfQxh21iiOmWvg1ao
Message-ID: <CANFS6bbjC2=BrmsAdm4h-KW8DD3ou4+sfS9JmWjx31=56YXq5g@mail.gmail.com>
Subject: Re: [PATCH] ntfs: fail attrlist updates when the superblock is inactive
To: Peiyang He <peiyang_he@smail.nju.edu.cn>
Cc: Namjae Jeon <linkinjeon@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=EB=85=84 7=EC=9B=94 3=EC=9D=BC (=EA=B8=88) =EC=98=A4=ED=9B=84 2:46, Pe=
iyang He <peiyang_he@smail.nju.edu.cn>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
> generic_shutdown_super() clears SB_ACTIVE before evicting cached inodes.
> If eviction selects the fake inode for a base inode's unnamed
> $ATTRIBUTE_LIST attribute, ntfs_evict_big_inode() drops the fake inode's
> reference on the base inode while the fake inode is still hashed and mark=
ed
> I_FREEING.
>
> That iput can synchronously write back the base inode. The writeback path
> may update mapping pairs and call ntfs_attrlist_update(), which
> unconditionally calls ntfs_attr_iget() for the same $ATTRIBUTE_LIST fake
> inode. VFS then finds the I_FREEING inode and waits for eviction to finis=
h,
> but the current task is still inside that eviction path, causing a
> self-deadlock in find_inode().
>
> Fix this by mirroring the teardown guard used by __ntfs_write_inode():
> once SB_ACTIVE has been cleared, do not try to iget the attribute-list fa=
ke inode.
> Return -EIO so teardown aborts the update instead of waiting on the inode=
 it is evicting.
>
> Reported-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
> Closes: https://lore.kernel.org/all/AB8D5E603E6EA856+ae5f622a-dd3a-4e38-b=
dd2-42276ae0e1a8@smail.nju.edu.cn/
> Fixes: 495e90fa3348 ("ntfs: update attrib operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>

Could you add some comments?
Other than that, it looks good to me.

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> Assisted-by: Codex:gpt-5.5
> ---
>  fs/ntfs/attrlist.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/ntfs/attrlist.c b/fs/ntfs/attrlist.c
> index afb13038ba42..1658cbe1fa59 100644
> --- a/fs/ntfs/attrlist.c
> +++ b/fs/ntfs/attrlist.c
> @@ -57,6 +57,9 @@ int ntfs_attrlist_update(struct ntfs_inode *base_ni)
>         struct ntfs_inode *attr_ni;
>         int err;
>
> +       if (!(VFS_I(base_ni)->i_sb->s_flags & SB_ACTIVE))
> +               return -EIO;
> +
>         attr_vi =3D ntfs_attr_iget(VFS_I(base_ni), AT_ATTRIBUTE_LIST, AT_=
UNNAMED, 0);
>         if (IS_ERR(attr_vi)) {
>                 err =3D PTR_ERR(attr_vi);
>
> base-commit: 1a3746ccbb0a97bed3c06ccde6b880013b1dddc1
> --
> 2.43.0
>


--=20
Thanks,
Hyunchul
