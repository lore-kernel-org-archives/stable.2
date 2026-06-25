Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27FA3DE44C
	for <stable@vger.kernel.org>; Thu, 25 Jun 2026 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782389494; cv=pass; b=hBcjBEXvp5oLdmeTtpljrTRJCxjwhBxX9l8cZyRYG6eXcEn7uriv056CmeXy9hZEC51xugEEOt1KfwsYqeu3vizx68qqWqnY86VGSSP2Cj5rl9EpF7Q1u80bS40sOfDvolKnmIgb235+3YIJEm60UtHOSH0uKl1kk9R7RDMTrCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782389494; c=relaxed/simple;
	bh=dvfHNjej7ZjvsdyQwyTkaRWLoQAqdpodctTv/A1RL0w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovu5cGzbXb2/+R7+DyNpZevOS4il1IA1G4Ed3+UEo8mX0GTzVYBJsGWYpOfNisQj3ROuovvbWLs7S4AHjsxo4SXFqUdVFF+XJKDYvLlALUehPSydtgxe+pzQWRvT9V3B9nB0b+3zndP2kDFfRm+B6F2Rirl606ZfPbbPNHhL6rQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO/k9oYi; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO/k9oYi"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bec423a5265so461567566b.1
        for <stable@vger.kernel.org>; Thu, 25 Jun 2026 05:11:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782389491; cv=none;
        d=google.com; s=arc-20260327;
        b=OBztqe87u118NufjW4iJ4swPkJqW58l2gxX7ZuQhvqNdowMxzbgE3Rv6o4ckGKhsww
         o+VTbJ3fBblc/QczaqknD05rmlHF5iXcgsB7PyqJFA9vbSfuzOUjvWYz1GufNA5++LKp
         D+PZvVKICnGfkncZtyIQasFKrB7eF23xv3RVskh9+cnLa9FdzFHR3/sp4TfZ9f+x1adk
         i39S1vt/la6npZwI1i6SL0KWVhwB67y6rCq0XmQiha8KZl/x4bA2dJok3PdUfV4hRLMe
         NSVGlKDHQe7mtq6yRQ/EzbaWFpCzL0pKnKw57Q0UesChJ0URiB6Me79yxkW1nx/6VBZp
         k1Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sy1SYav9SVzosd+VjXbgDMHc4Gpj5+JzoNxVbAKdb/Q=;
        fh=2mP+pJggPNCdSHANLJ91cUFqhCjso7LAPKRkrBNbUSI=;
        b=VwjTINiQMyHZh/3eD3ywRX+qnBOPwE4jM7bGyhrCk8oxZ1MkUPGptnekIgPQZHbRSR
         Nn2Uucu9LBS21yDhCUDVOBi9ro22Ph6ShK3hFeNXRZcWVgdMZWbpvVhSEvO1aasC6LGy
         5i+CtJvDvgL0YITFCuClCyT4fO6TKvWRZI3S22nP5wnHROwAiiD282wll09vs7tbLGos
         azdApA0I5G9lY8hT+Ll0kISVwkv35qOd/YAXNxVJcOeAEfWECkTrXt7sutkFmeqkkwgI
         Cz/y2VBVbUfPlUR7B6XRk2K4lcmX1OrRjXpewCQAh2lGqwMb+gHOdcby7itXX/alCONm
         6uog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782389491; x=1782994291; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sy1SYav9SVzosd+VjXbgDMHc4Gpj5+JzoNxVbAKdb/Q=;
        b=HO/k9oYi/arDGukAtXYxzH4hjgQ1CsdM8UXJxl1/ornl2dAw3TyjRt2Gg+0XHthThK
         cRQG2uLNv112Akm/24/JgE4jJ4LKNs+pbvL7De1Z1yolm66vHNd2sKMKZ+t8rQTi6ZWW
         CgDoFOlpAICJV3tQ0YjFLuQB/QCeZBOzfO+fgVSTLY7BCrQ6h3ZgzFZaGRCXISxC3RlZ
         OB0Mu89SsxH9bE9igUv2d+NNXcjuD8IhL2FQ+IwIRkytBpkBZovYcn4fKSF1qDmW+Hdd
         zlVug21UanpFPk1ilii46nuw013LFI2fvItiDLS6ESTbE0gOJtquxODzyRXTILs09uxc
         d1Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782389491; x=1782994291;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sy1SYav9SVzosd+VjXbgDMHc4Gpj5+JzoNxVbAKdb/Q=;
        b=FJxlBUkNDOGrVcmc+Pub8XLMOuPUzNhEZ2TfpEUUhu/WFmyMz6ECEC+uapq5RWbnaa
         H2S7n7UujcK6hg2dp7PfK94efyUzpa7bGBS95cDuZc7f1GsNlkLKVyNPaJElCZCZOcDF
         q2aXIOcoTphs31wDbWyDKpmfiSApV9pkhx13kCz3X8CuB9/1lYNqBCCHeskdhQ1tHiLT
         aut3nYtNNBLDDFAeOp6o91rQXeuBv3asJsPVUwq0rQw84i/tIFRJ9RuEjfa9RFtrrDQm
         hjhsXQlVfwAVTotULTT2/Be2HBuR0VSgtSTeC2HwzQoxBzHxq3oTpmrnf2agkpS7nA48
         f6hQ==
X-Gm-Message-State: AOJu0YzOiPyc2fUQ9tDiyfByzWe75N8gqTITMIsHvsn/75JzEZ7+65VQ
	yStAXTPTA2ASpieEbGmMlAm6TkRES1s4su4m+kFDFmxXbty9STv47jetUhHBS3mR55nt1ddo7LX
	64IKaVTiAKgambMVYvI7amjgslX5SlHSzgSWSjyI=
X-Gm-Gg: AfdE7cm2Zrh15c21rjtra7kHuRG1OU0fBSIu4Ctyi1mGyPCQ6vAn3vlvHog31wmNoW/
	ZHDp+oEbNQlXu6MiXzDZqEzbVRnQsLODOOT/m5vAjWDYR9MEo6QzGa6dJOvKe1PaJlbl7WAxIux
	IKcTyY5WOcevhivpEUfvdIq6uZRKsAueX40jcrM9duko0N9kc2IRRWAO0KOUUMivY6qOOaxio7d
	n4MXHu3WHqMxye5IgtMLspNY1iZTQ11sBBV4VCZrXo+sgW8GAEmdQ37TIip4MBUHppkyuQ=
X-Received: by 2002:a17:907:944b:b0:bfe:ed35:e857 with SMTP id
 a640c23a62f3a-c1205f24d70mr145337666b.51.1782389491028; Thu, 25 Jun 2026
 05:11:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG9krM_RbUhPgkcP6DFJM=jgDxMCNu8032=pM5OS2Agcxm-UKQ@mail.gmail.com>
 <2026062331-bruising-wimp-74a7@gregkh> <2026062320-backtrack-unusable-96e1@gregkh>
 <CAG9krM9398KH27SngNaujagzMz6DYfcSBFYzFaxj8aZMRh7_iQ@mail.gmail.com> <2026062536-pleat-unpiloted-9a6c@gregkh>
In-Reply-To: <2026062536-pleat-unpiloted-9a6c@gregkh>
From: Faicker Mo <faicker.mo@gmail.com>
Date: Thu, 25 Jun 2026 20:11:18 +0800
X-Gm-Features: AVVi8CcdYKMebHFtXnJXcdA6tNW1dm_JE3nKeL3dD5Qmfal9vO2EPEiGe2hn16o
Message-ID: <CAG9krM-Ny2dL28umOotOGg8YtXkcReb11_QtyFMg8eJ=kNeiEg@mail.gmail.com>
Subject: Re: need the upstream commit to be merged to stable kernel
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 25, 2026 at 3:32=E2=80=AFPM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Jun 25, 2026 at 11:42:31AM +0800, Faicker Mo wrote:
> > On Tue, Jun 23, 2026 at 3:06=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Tue, Jun 23, 2026 at 09:03:42AM +0200, Greg KH wrote:
> > > > On Tue, Jun 23, 2026 at 02:35:18PM +0800, Faicker Mo wrote:
> > > > > Subject: net: net_failover: Fix the deadlock in slave register
> > > > > Commit: b84c563
> > > > > Reason: wish the upstream commit to be merged to 7.0, because Ubu=
ntu
> > > > > 26.04 (LTS) uses this kernel. Thanks.
> > > > >
> > > >
> > > > Sure, but note that 7.0.y will go end-of-life in a matter of days :=
)
> > > >
> > > > Also applied to 6.18.y which will not go end-of-life.
> > >
> > > Nope, breaks the build :(
> > Hi, I tested it with make defconfig(CONFIG_NET_FAILOVER=3Dy), make
> > vmlinux, no errors.
> > Both 7.0.y and 6.18.y branches were tested.
>
> Here's what I get:
>
> $ make -j100
>   DESCEND objtool
>   CALL    scripts/checksyscalls.sh
>   INSTALL libsubcmd_headers
>   CC [M]  net/core/failover.o
>   CC [M]  drivers/net/net_failover.o
>   MODPOST Module.symvers
> ERROR: modpost: "netif_open" [drivers/net/net_failover.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> make[1]: *** [/home/gregkh/linux/stable/linux-7.0.y/Makefile:2061: modpos=
t] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
Got this.
Need commit 3fdd33697c2b(net: export netif_open for self_test usage)
Thanks.
