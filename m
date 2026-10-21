Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792587657;
	b=MS9OZs0Og7+VM6tm0RIFGdd5AzbsslHkrH2jlDoB67u5QcCy6EQ2z2oZVewit3cNhs8a
	 UUgDlseIKGfMe6gq4X/lAscyLT/aY9Xh5tV6oXgKxbP76WOEBAMHKU/RFA8xGGG9nYFRM
	 cv9C1+pNBb6csTRX2qK5+nOOLBOauwrfFPFu6DPmhbzJTfdPDPcgn6dfcjr2K2IYWMUNj
	 z9zQWe5RuTb3ZRvlAWLKxvRJFUmMteUGj2BQXd9jfzC61o19Cfus125tUbv/WRDyc/xqv
	 KHMPUHRJVQLUgUrqgXBYo44yJv20c5EGMhq6n3A4JvWUVbObIlctxu/v8WtYvGAX4sg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792587657;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=kXoYys6AGDFdddNSuFyoTToCIugSJAhRAIJkUtxGkCM=;
	b=M8B+s0aonuiwS7BZ5wYcOMd6K/NL/mJEjQ7Kw6aENbcELmgqy58jxt+kR+PU4nyIbJ8i
	 51J71vjiBX4jaFcQV8tBcsi+MK9jq+PS7tFuMuj8oAOjQxDL+cFk/8jkTd6TVbAWnkQiO
	 /b89N/6U8iedS7VzAHJgrGqS5czGdwsDVRm3jAYqFmS8vIfcMyddlyKachkPxwxU2inqD
	 JVErEOSJA9qo2jrABU95JNSFm2wZmJxwU0Eoqgw4g1hpQ+Xoo9k6XUopv3EUN4OYe6Gu8
	 PnRfcxsEOx9Rzg8qxlf7bnxRn7KhniJOAdodPC8vPpLjnAr45TSnRY3tFSWW6G0diPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ATuLUQhC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.43
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11AAD606A31F
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 13:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11AAD606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ATuLUQhC
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so1095477a12.1
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 06:00:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792587655; cv=none;
        d=google.com; s=arc-20260327;
        b=qHLifyAjeZat6cFYDecTw+u9DS218ePiF8ZYkLCBXIfbWJ6ocdNXFCQZraJ2uQ6ZFw
         q2A3fO5elgUgPbwVhL9wGQ2fhEEzp/amQ+m4BUfDxmt8pnz4LwFoZpa36w85xH9rGj9P
         VH6pTokGya0ibyQaKnOJWVEgrO380XkhKAfNcCFoxYcLIEFYnPXXRdzy79kH3trjhzTH
         +xhDectn6h8zDoXg1YQxVee7WD/SDzkclRqUhIL+aNfERD+Tv4IGrurPiv+NdXgHl66p
         vhm+b1HTslDbvuTZgVv8NAYGS8+1aqetJ0KjR0AsJkBSbptyPNWAFQo1hy/KuH6WL4E0
         3PGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kXoYys6AGDFdddNSuFyoTToCIugSJAhRAIJkUtxGkCM=;
        fh=uU8GRPUFMKQRNKpFiMAbBoldlcRhd3Vv4neEcsbLNX8=;
        b=fV5Gn36cgoB9NNwdcM5aTBseCjKp3UXHnR4EVrZIj0t38mLSR9+SPCPi5EdvFGBUwT
         8S2VguUamLU/7Ohgwo7/11cPck5HHvMZg6eBMvd31JrIDVYn8qf4whjxZkm1DHIWbJBj
         zg56xUONTbtAtbHh7eUMIFxzQimd8P8lExeZpk9JhGa1MPzhV2okU3UxRaLPTRWq5JPi
         /hLRU3lB1Uk4qtV4MPDFRSUfN032eEUwDG3hlYyn22jt0BwfujQPtI2I4MyaGVboH/xl
         LaynBmw1j2h7edC2X+BZryXLT0NvWGAnh/8vkMvW1+I/RHpNEktSBmFhcKGmH62b5Lzl
         AAYw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792587655; x=1793192455; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kXoYys6AGDFdddNSuFyoTToCIugSJAhRAIJkUtxGkCM=;
        b=ATuLUQhCm7bNIC7Md6XGQY4GFQFK3oqAfo6awLZkDZVz5OvwY3So3XmmwcXFeZlTQc
         BgK6u3qgRI7hnMYXmWm8GvYPSVi3782HLsc5x9MxY5zGwodRLFAjVgituIjKB7igSnfw
         HkYxVqgGTrc5cbJcX8MLQnQ1MXbYv0Om6QUndvOcu/XjVIRX8hwCj47gXOVGdXEMru0I
         BRPD3BDq0VVn/hf9bKWIHRLb0UsfBQjmTMIVWtBLCJTVvLojZnoSUiWMxnQQj/ldGL7n
         eCXROZHcz0+5Bbj/i4GK+B1jzceI04aRQUhDIepgcD+2NA4Fkf3XPCK+2MPcL5tA5C0j
         MAJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792587655; x=1793192455;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kXoYys6AGDFdddNSuFyoTToCIugSJAhRAIJkUtxGkCM=;
        b=k4yvEVy02X/ul+lPkzDFbVXqsmFM9awLlgtKxfnjukAsAOnjr2TcgWUbIurku1ucbh
         lxmyiZDQAaLXkTDt3rAxvRDX/ODldgKUZAk6PG/4CqbRCgVNejh/99vYEPAz86+tDVS2
         4gagqWcil3nZiWKoZD4pyLVPOpTMCKIpv8JyYR/1zfDY4qyliiQNfFjwGl2zBlaWLHP5
         kNWTr+YjK4/nMNJHvsG1RFaw46nBS4G2yMn4bnhaeQ3ooyB8fONJFmOAEVNZ8CV3gaS2
         niGFsYI0HBGUcG+4q1FdFCUFtAkVXTHoV1mYLTsvwX32+r0Fjhu0uUa6nhgtVTPz9Hz2
         fu2Q==
X-Forwarded-Encrypted: i=1; AKwUvBybqz1NVbQnuKCZHm1riQVchwATwOUHQtCQS1hF5H0JRPy8Ql49ek5lHYaAiXlKTLgFO9vvWss=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyT5oP9Kv3yiGM11JrW0QFLnwSPBVuAQqrxooUu9Rdaim3Pc/z
	k8V+yJThPp2ke7PBePaFut3Qi0SXO72LL2eYrURuwCfsIP3EHjlmsTK4XhuB0yj/1dZYFsfsWH0
	wNmoe+4rcWuc+cBSEhAHEV/M1YAcrldg=
X-Gm-Gg: AYBFou1vOja1fhd8aHmLvu+IamBQ+iaZRzhc6YijeeO1v136emwAMI+8nUvT30yV2dT
	nQS/JI3USo1qCQ0n+Iy4FfbdYinTIgH6R9nh356iOGnl0lS2All+VWXeHwHdo/SokchPDHAilbx
	3DnN7vM+t2fQexJMoMQrR6z1SHmB8K9iMgrfxm/dH9EMtRvDjZUyg2LAtKpdloEcUgCenY+mwSF
	1WoxvXWJS4l21cYqp7et9JyToZoHgP5bzVTpUypf6n0sDNrNjuBf9c9VazQb04iW+j3x3xMruig
	bLNl+7rN3JFGQY4FFcRxY1qjIsRzGqPaqUDX83861J1hD5M+OHVAHG5ZMlaLJbpkYu9qCEoq8ou
	5RBmSu1/CIiMF+0hy0hdkbivFAuiYL4SICrl2
X-Received: by 2002:a05:6402:280f:b0:6b4:16fb:b9ba with SMTP id
 4fb4d7f45d1cf-6b416fbbe8emr581616a12.36.1792587653646; Wed, 21 Oct 2026
 06:00:53 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260924112858.51392-1-disgoel@linux.ibm.com> <20260924112858.51392-2-disgoel@linux.ibm.com>
 <20261021-erbschaft-gefahndet-erklangen-085a518222a3@brauner>
In-Reply-To: <20261021-erbschaft-gefahndet-erklangen-085a518222a3@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 21 Oct 2026 15:00:40 +0200
X-Gm-Features: AclHuK9WcoBrCyRwmmWQl42Ua6CkryoBn_QB6lJW1f-3Kmj5TuvGleJ2mOxIsU0
Message-ID: <CAOQ4uxgO5xW39SfBEfM5yS4uV7M6_zZu7kVP++bNwML2s6ZPsA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ovl: fix wrong layer paths in mountinfo for detached
 mount FDs
To: Christian Brauner <brauner@kernel.org>
Cc: Disha Goel <disgoel@linux.ibm.com>, miklos@szeredi.hu, viro@zeniv.linux.org.uk, 
	jack@suse.cz, shuah@kernel.org, linux-unionfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 1:56=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Thu, Sep 24, 2026 at 04:58:58PM +0530, Disha Goel wrote:
> > When overlayfs layers are passed as detached mount file descriptors
> > (opened with open_tree(OPEN_TREE_CLONE)), ovl_parse_layer() uses d_path=
()
> > to record the layer's path for display in mountinfo.
> >
> > d_path() walks up the mount tree to the process's filesystem root.  For
> > detached mounts this walk stops at the anonymous namespace root instead
> > of the real system root, producing a short incorrect path like "/l1"
> > instead of the full absolute path.
> >
> > Export mnt_is_anon() from fs/namespace.c to detect detached mounts.  In
> > ovl_parse_layer(), use dentry_path_raw() for detached mounts instead of
> > d_path().  dentry_path_raw() walks the dentry chain independent of moun=
t
> > namespace and returns the correct fs-relative path.  The path is
> > display-only; the actual layer_path used for mounting is always correct=
.
>
> I think that's nonsensical you might end up with complete garbage. We
> should think about a custom format so userspace can "label" the file
> descriptors instead? Amir?

I wouldn't bother with that.

I posted a patch (you will see it soon...) to fix the test:
https://lore.kernel.org/linux-fsdevel/20261017165103.2450042-1-amir73il@gma=
il.com/

"/" is an established fdinfo path for a "disconnected path" so I can live
with the existing code as is.

We could also label those paths as empty path "" to make sure that nobody
tries to replay those bogus mount options from mountinfo, but really I am
not sure it is worth the effort, considering that it is very easy to
see mountinfo
with paths that are useless for replay (e.g.
upperdir=3Du,workdir=3Dw,lowerdir=3Dl1:l2)

Thanks,
Amir.
