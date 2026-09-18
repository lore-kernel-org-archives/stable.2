Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E241E3546F5
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 01:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789693950; cv=pass; b=GGT6X3Q1wUTwxzHzYf1aBMIkHSa5W9dSKPaxexELuXDllFicmFE7TZom9HK1lmdCeqHNB8zeEHQ23E8U+CeWjQAAtC8Wu2+SSLCN0WZgjKw4sZ7m7Igiqb7Yllo+JEYr+us48tqNlK4NE20puWCtda1N+qtsL9SxKDm20Sg/2Co=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789693950; c=relaxed/simple;
	bh=59DjG7Ba/Synu3HWYr+dx4VKBXTxHzy5pOOnrA3rtp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KOLdmKbZrWkCfhaBflsqdLGowu/JRYog9iC6dsxm1N85fruLununa1vJ3O3doOxd46A+fXz2DFDisVSRxPZt+tE9KRr01Ni9HSPfgUqv9UlF+jiVaEPVcm6WR1N7/KEYfTU2UJQUhBEEnL2pFv/XbobidBeeJZUUaArWRdsPhwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lVLqegIL; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lVLqegIL"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53113d72966so106321cf.1
        for <stable@vger.kernel.org>; Thu, 17 Sep 2026 18:12:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789693945; cv=none;
        d=google.com; s=arc-20260327;
        b=Ko82QvWqE7PjSBfW0//3avFTDxNONUMCPukPHNzlGZ/BWG73ytnDRSNeDosHu4QxOo
         7JABuNDurltocNyHaiii5KgbgJkdwtHqJsSilrRMRjBPZMfHtmIz5RuCDICT1ExWyyur
         d4rIleNn5PwK3zzXikojLGmI8qIyqltIbgR2BLjD8BSQ2xmhOpOpDO6LW/FMK90cTUC9
         4TZbLJt0DMG29bzpAMOkFo2YCH80pGK+HT8Fq6z3oEs08DVwrbQfQlzT0cn9iFA2ajVO
         +cxlkrLA56S5FdJDx+M1psQROLy0l6PlmA/acvsR274IuXFmfDFu/P/6McG5WQJ8grVc
         yd8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8CaD0rfqQizy2B+GSoa1ONFRM1MKoZPF6ZVzgGYvBiY=;
        fh=6rjIKCxUXHn0kKvt0d9+F0mhxpPZ9hMR7e4Ilq9n7AY=;
        b=Zu3dubcPiIWYj1IhlTyXK2NXRfq4i1GhfOcjMyfkcp6iutJ8XDP5IGVDhSLXX/YPXR
         26q6TKrACPq6e07O4GzS5mRrmcQZ/ZZCrSSQ9AN6Ph0mbfee0Oq3kPih+t/qlr3poNMH
         Q7J6bzDHdNzKXKLqWzRdxmPBbJ/1rVrlU/SPTTxiR6VTRH253pw3vxrod7hZcIVqBRnw
         5BWaR4umnTdlfW146wKiESkUx6E8QEvN3eJZjY8EIIfCyMdcG05T6XlTfmVJ4awYWUQl
         tLsYWmfVZL/ThZ3jUm5QD24X2Z5Urm5z03ZqMiI2ASQa+cfGcC3smd7FCxztcxkjvyLv
         VlgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789693945; x=1790298745; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8CaD0rfqQizy2B+GSoa1ONFRM1MKoZPF6ZVzgGYvBiY=;
        b=lVLqegILju+hw11l+C/Iw5Shf5jMp6jDg9awwycuxGQggFRdas3PfE/HHiMtyJRFZP
         CCw/Vli1C25Cj/djNEE7RfDNgwLXwhZjSuoFbRW5Jldnv2CoZKrBA29+rh/IdUv94fRK
         OTDKrshjc+i9JXO9cgMtvPcrr/oMg1xmaXweAskfNMT6fsoeLk07WDPpPD/FvjQ/BUux
         Sr8Lm6TLwEcpEv5RQyXUOJdQ4NcofgxIivd5jwSMrhryxIBK7pmTG5vZnSsP9yrHoxNI
         w57pckW4imUEaif/rmWTYQHx2D8fy/pZrQvm69cWtJw5y8+tZo+dz/3OSGVYDwxidf6+
         f72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789693945; x=1790298745;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8CaD0rfqQizy2B+GSoa1ONFRM1MKoZPF6ZVzgGYvBiY=;
        b=YJoQ3gyceMAyQxAdtzEgDsTbJFqxTtyzM4yzOwedWhykuaUcawt4j029MPsD67Qqga
         0o6zT+yv6gjh6ZTzMZV7sz7Wfza3OIGjQMc3ycgJESX/LSVk8pvAtNE4T/lZGMTQcc16
         4io5RcXEVcnHKv4XrJ4Aku/0qHsYsy6kViW6XwYw8kfurpRu1N/eCwbEr/BMxzslvA/2
         IkO+Z290O0dVBI9AFmjnE4vo6qoWo2qjsGssEp05U4L0C2KtdWmsDNMISomJNfggAF9B
         R3FXb4fPVVFPxBYnlrGgbCvFUIeIk7T22jc/KSq70vJb+yCbDSDccaQIRMwwbX1epJsN
         hzAw==
X-Forwarded-Encrypted: i=1; AKwUvBwZEDHP2OAKcK5ReJ98OOAl5qxko4Pb6UBgftYYv/w+AOJb+QpMZU/gtfMwKSSsugT0X3/Cqog=@vger.kernel.org
X-Gm-Message-State: AFuF++nrsHtDFx5yWA6Z9Jf26JsYQQR1+9Oe+tT9FjqRweQrXkXMW4G2
	uW8+Sn4rlHBcJHzQfjszdSFblxQMbSy2/koVD8JXRPx4yvMSOBvHyOaIRE7YpRRtiwrpIfna4Kl
	pO9QMXbSid2kG88Hn+YVBoAKSH63ngLfMfEEWewgl33GMG1uCLWF2SKeY
X-Gm-Gg: AYBFou3yJnOGunI9yWjEoSjpHRITJbeM9giKRMdBuG1rQh9ZKbBWHQNgesZ3do8wrLL
	Z8fuiedFQpOm0BfhZ9qieaccGzsx70HCQx1dCEhGv3xyORLQdAKtLQMq6WCCodJJJBjhsOSj3Dp
	teUZG6VypihkgorUe/sXlQEWmGy7I+lThd+ko+eCZGM5WCc/JMxKj70JGFvgJBXxRB7kAzv2+qA
	4neWFo+QrWSRwgYCPPB9/d3q3VKo3G/KkolrBPjh60/nFF7BRjsvoKzHOYmWfKv3djX1hWXnV7T
	8z9TOXri4hXempuRZkFcT1wqO05WTub6UTzif27hzOGBAOyeWowyBQ==
X-Received: by 2002:a05:622a:649:b0:52f:9ed4:8d74 with SMTP id
 d75a77b69052e-5329d7ebce3mr7824921cf.14.1789693944193; Thu, 17 Sep 2026
 18:12:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916075557.121316-1-hao.ge@linux.dev>
In-Reply-To: <20260916075557.121316-1-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 17 Sep 2026 18:12:12 -0700
X-Gm-Features: AcwNN1XNY6AqvHO92sUp1uSClBs9D9k4LNE8UFQHN5IMJcofHqzZ4rP2n34CQxs
Message-ID: <CAJuCfpFSP1oq_ANWqVbhS_3kzdLkK76aGUf6S73_rC++NTL-CQ@mail.gmail.com>
Subject: Re: [PATCH] mm/alloc_tag: account for reserved tag ids in the kernel
 tag check
To: Hao Ge <hao.ge@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 12:55=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> The tag ids stored in the page flags include two reserved markers.
> Id 0 means the page has no tag and id 1 means the tag was cleared,
> so real tags start at CODETAG_ID_FIRST. The kernel-side check in
> alloc_tag_sec_init() compared kernel_tags.count alone against the
> addressable limit, so with the count at or just under the limit
> the last tag ids wrapped into those markers. Pages allocated
> through them then look the same as untagged pages on free, nothing
> is ever subtracted from the real tag and /proc/allocinfo shows
> that memory as still allocated.
>
> Add the missing CODETAG_ID_FIRST, same as tags_addressable().
>
> Fixes: 4835f747d3ed ("alloc_tag: support for page allocation tag compress=
ion")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Nice catch!

Acked-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/alloc_tag.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/alloc_tag.c b/mm/alloc_tag.c
> index cfa0fc84b68f..cf100e7a852f 100644
> --- a/mm/alloc_tag.c
> +++ b/mm/alloc_tag.c
> @@ -629,7 +629,7 @@ void __init alloc_tag_sec_init(void)
>         kernel_tags.count =3D last_codetag - kernel_tags.first_tag;
>
>         /* Check if kernel tags fit into page flags */
> -       if (kernel_tags.count > (1UL << NR_UNUSED_PAGEFLAG_BITS)) {
> +       if (CODETAG_ID_FIRST + kernel_tags.count > (1UL << NR_UNUSED_PAGE=
FLAG_BITS)) {
>                 shutdown_mem_profiling(false); /* allocinfo file does not=
 exist yet */
>                 pr_err("%lu allocation tags cannot be references using %d=
 available page flag bits. Memory allocation profiling is disabled!\n",
>                         kernel_tags.count, NR_UNUSED_PAGEFLAG_BITS);
> --
> 2.25.1
>
