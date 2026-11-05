Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793913921;
	b=aYywWjPmGogl+l6rPlbZ9piM6hy5tuS1NSa44oP8W5SNPiQOQcrEyB4EQ8mlZTthg9Ne
	 MkLhBCmzP098drfFdJB2E7vM2Wpu1RjhQgrailMs4rQHHwExmAq3rTfJkhVo7GWZweRZB
	 xki+JTS1DFVNw93GLLFMlTR0aqVbCqS0ib5jXAPoOpcuVAk/nm7WSPHtlhjh9dXmmI/bs
	 t0SBVzyFbCE0ldasgSJ5zVeIcfqoIzUiDlwRCiT5wEnhJ87v0VetPf97ixgGIu9qBU2AC
	 i7gLR02ZBPAhKT4zKjC8uX2yShRB8KnIcRxah6qmYojieAj+5InVO3005lbtP8iRvpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793913921;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7IgY4oSwJmunrObC+s4jlkajaBgT8VZrvasnO3k+eC0=;
	b=elD76otgmoOB1asn2bV8/VFsUvIlOJUBWsrdTldt+REg3DyoaKarpztwbg+hoV9ItAXy
	 n/W6kOA/NT2MtMNopg6p5ymNjdLWUwxyP2yqvgWSoEjXmRhqJU8gLWFRoXVyf9A2MsYuG
	 Fv4cOdDCenfS/p8/+6fGTTZDD1UTs1W5RUQ1Fl6Smd03raRyWKLlUyeJmY4W9QpnH4W2l
	 UY9fIH/gpgXau5aCaXw0E9CqdxGI3MjWOZH1WiQkKz/k9NextJz3mFP5oqkT/CiDCgimN
	 Ew4CONoEimAKfP0wbXRXedjONyTHL57zS3az8jt8hd1lSCxFLci2cP8a601yjVmwSpQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WGLIoJXh;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.177
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818F606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 21:25:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8818F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WGLIoJXh
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-533202fe429so86131cf.0
        for <stable@vger.kernel.org>; Thu, 05 Nov 2026 13:25:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793913920; cv=none;
        d=google.com; s=arc-20260327;
        b=IT5EGB/Muk/G+h3zvieAvZeSxMGgcAfIZpk//o99FaMEPJ5BzcUzD8lzdamNAFodoM
         RlTT0q2DGw3s8hQRxmWYjrLTek12Ycq86rl45FezeHxjH4EQhZWXj2Sbh1NUh8CKOwdf
         TNPuuAJm3sfq3bK3RHnf1gFSr0mzP4o64RsfIVH5QQawhrU144NbCgF+KVweGYt1ssKp
         /uhVkwfEHHsV3JzHS4PGBmI0RSfF9VIW1LyIMZxF237oCY7NH2sdQ7IkYT3dH36GL0zf
         hs3FfkjwKzTQfPAVtyawxazr9T10m3HjIFmoyajf5wipLACDaqd8vyz3L6SJm6Yai3Fd
         M8cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7IgY4oSwJmunrObC+s4jlkajaBgT8VZrvasnO3k+eC0=;
        fh=o/TNB3Ny1pKzHd2nvVm87C061gRz0+U+6FUv7RsB4jg=;
        b=d3SUFr83gF5zrdTWRxgyASAH/FhWrczFY6qX7mS8H/EXXb6JJJTt+nY193TCUILh9T
         1yT8A5WlVaaahkgwmiGMdccZKb8lweypoHYZAKVdgKtINPQmaE54c67qveCo06Yl4MTi
         gbcsBn1l//Yddp4w3Zf0aK8LJJfzAgBau6rB6ZjhrzWXnk5wieqETf4egeyHr21zYTU9
         w8l6i1YlJJupat/pGXzEKnKGVjQgHlAyjiRdiXxBuFX0APnyUV1ZD6RymW2PvQo3qX5t
         lZeWwcwxMjPZa8R5Tgf4hQ2QTQ9tYgfvrzIh031EBxJAGP7TbsXMdxbq5llpI9zXxnaM
         wypA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793913920; x=1794518720; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7IgY4oSwJmunrObC+s4jlkajaBgT8VZrvasnO3k+eC0=;
        b=WGLIoJXhRcmdGEb0n3pms2EfI2CQ8It7v7QuZGcE+MZKrW3D+lGvxsvxvhkSHP/mbo
         bk6/AlouKi4J0jyyhi404w3EBpkEBI5LS8cpBgAwiGgGzIbrFdjTCqeHQxEY+hjXfCJS
         H5/2JtTpRC3KdZ4bSc1LjlagJ4tdfVk7GzXeZAVnuYXHovSBJ0SWAgz8WUZEZ0q4QeYP
         0RhLlfU9PoAGlZPJ1B4d0e7EG+vokwVzYffDLVbl1dva39eXcC8d0JMgldFCP+sWIBfl
         NotKlyKVj4jdcQZsPcjO97JAgOxpjGJLQX05nKgzg+riL050Vf92EK83U7lJYfAwjlN7
         JYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793913920; x=1794518720;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7IgY4oSwJmunrObC+s4jlkajaBgT8VZrvasnO3k+eC0=;
        b=p8H1Ak9OMj0C1oihv5LyXlbDmSn+85vfbLtYn6sdOErT7som0AcOCaJ7QbQxJpqCMJ
         TZKmRX1kmxo56mDPShdwCddzn0CC+V6P+M9530M8R3qH1nsWdsORU3EOEl2h4eXuGGuk
         DTUOQvp/qJffn+4ljOMV0P0NaW6V6ZM21N9ECbJJW7OPnI4bfQ5isGnDS96bNtFHF01m
         p0jyPYsyJWyWlxgwVKYoUjX/C2FKn8ku+jX/nUCrO3eRanSk4MoF8EZDhInHJ8VmWQva
         7aWM4JAi1t26yxzpcbkzsda6UMVkGhuAEI/DIDA7y5wtJGWEYdjWHeCfM6ClK+iNoKal
         F4rg==
X-Forwarded-Encrypted: i=1; AKwUvByXmgSZvUfmkeWVosCBdnC/AxMKFUi0qZEVafApZ8q5bVGqgMPV3Ydx5ClyT2krZXmIPIwHoSk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/P+gQOZmxLEzDQVwUWjk2LksKj/xfa8W5oX3V30krF316l95sm
	hPjgM3pVx51ZsFPXa9s+tBRFR0OUzjwc8F9DflNUgkQZ2KRWdotMZJptORPMPySy6Jy7hCCU4AH
	7UZp3iOPHJt6dK9l0CeoL57k6GnEv30IB79dmnTT2
X-Gm-Gg: AYBFou2J7spi0D1l52/DVD+Cw2Bb3EvyjJr1yfb0xUFUO1OfUgVQwFB4ShXHBV1j1w2
	Qp9sgvIas179udj1G6c+x+6XxVVM+JfB/GGeeo10akEmVIgiZ7Gktr6/K6QnyudcbjoT/Ts8xXA
	Uco7szz7nGfnneKiiBcKgxkRBn5s59dNekv/yGLdfN9bOYeIVZnBS+jcUz9cKhcI8DO+YNFBhkY
	AHbikJR50asSrbxEVkNYb0OM4TulGa89YJpOJfbZ+YO0fJsl2fl8oqu0n3P2wu/SWR9QcVcM10l
	XI5KbKj06uFHoKEdDDR7y6ZRetuvUVxl6Gr1AWPYPwrKVpAGFQWatxYxg6g/xUub8c7mJ8ACOpr
	CV4/43QelPOqH+0kmj2l0oXh4FP/SEdsvTmLaqw==
X-Received: by 2002:a05:622a:4118:b0:536:934f:7da2 with SMTP id
 d75a77b69052e-54e18ff2e12mr4497211cf.2.1793913919805; Thu, 05 Nov 2026
 13:25:19 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-set_huge_pmd_uptodate-v1-1-a78d8a1b7117@kernel.org> <DMNJSQDUACRI.HXKF5B6GSQOX@nvidia.com>
In-Reply-To: <DMNJSQDUACRI.HXKF5B6GSQOX@nvidia.com>
From: "Zach O'Keefe" <zokeefe@google.com>
Date: Thu, 5 Nov 2026 13:24:42 -0800
X-Gm-Features: AclHuK_cW9BDiSPs8h6BDqPFpxUXOylylNhDy7qGq0VHRrxqPWf2FvEDLTBnfxI
Message-ID: <CAAa6QmSF0bkATC6kNO0B1ydFtDi=OEYJJ5eH4zEakxjJ9z7ZqA@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: don't map folios that are not uptodate in MADV_COLLAPSE
To: Zi Yan <ziy@nvidia.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Chris Mason <mason@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 12:09=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>
> On Thu Nov 5, 2026 at 1:16 PM EST, David Hildenbrand (Arm) wrote:
> > madvise(MADV_COLLAPSE) can map PMD-sized pagecache folios that are not
> > uptodate. For example, shmem fallocate() can put such folios into the
> > page cache.
> >
> > collapse_file() already refuses to proceed with folios that are not
> > uptodate. Let's just do the same in try_collapse_pte_mapped_thp() and s=
kip
> > such folios, leaving handling to the page faults.
> >
> > Note that collapse_file() effectively clears shmem folios through
> > shmem_get_folio(); let's keep this fix simple and simply let the page
> > fault path deal with that.
> >
> > Fixes: 34488399fa08 ("mm/madvise: add file and shmem support to MADV_CO=
LLAPSE")
> > Reported-by: Chris Mason <mason@kernel.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> > ---
> > Once reviewed, I will pick this up in a timely manner.
> > ---
> >  mm/khugepaged.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> Makes sense.
>
> Acked-by: Zi Yan <ziy@nvidia.com>

Ah, good catch..

Agree with Hugh that the "pte_mapped" naming is a bit of a misnomer,
though it was how I was thinking of things at the time.

Thanks David / Chris.

Reviewed-by: Zach O'Keefe <zokeefe@google.com>


> --
> Best Regards,
> Yan, Zi
>
