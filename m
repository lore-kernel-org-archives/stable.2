Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795209271;
	b=aGesscgaESfj3Nk0X0vcsoJXDH70yasfTXimhoAfCK3NEyKhpVOCx1HaygMG75DiT0TJ
	 ILAokSnzewdHzLs5umZ9IR7B0v3MBYceMO7tOI7zsrppqmpPmbWL/trOgRXWk3a9cfnaB
	 WsQhpwDrwBAi0gediMkSVxOR7oSYhD+O075+Bm/XTyuUaoSSc5brM35O9zhyQ4pVz39Um
	 PcyxhIxZxTQsk0pNd42/EvvHfKErCShdv9GEE5ngogeDNs/b6V2iL2TlyZvxbcvSN8I3Y
	 E62c47sp6miXNWTftUmHzTm4ibVXtYPBH6VVH0iJfjKtpn9Hy412C10KBmGY4wiDEIg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795209271;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=G105/EwTftSMSsJfJTgrHQWjcbh39Voo9ViZSiMzFbs=;
	b=tYt2VeMlU4rcilXsrclx935g796s8MA867z3aH9Hu9fvXFmvAde8cfE1v/qRsbRmLkKd
	 ZbrLm4C8T72oerrW7xMU+p3iTcLcckpxbPVgTaNWqAihHY7av6kuLs2i6+Lr2Kiv8GePv
	 QCkYFobiEWclZihtC4KX62m05xL0Ae7U7OJSVM4vCtP1ymwA0k4jy/Tb/GxHzdohOyOP7
	 cGHTte9t9n/alCsWaxNXxipInkFsZGA+HfbEB7JixkHvGUpb0dTMm53c+a5jIbrNxlUt1
	 a+GTlZSrfuCuWjP99AbSwb4TAaKdv8JDGaHkDKAGs7QiQ3nkWAZGZEiAu8auuZnTFdA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P6SKJzZA;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CCC606A691
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 21:14:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5CCC606A691
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=P6SKJzZA
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-54492d8a988so75621cf.0
        for <stable@vger.kernel.org>; Fri, 20 Nov 2026 13:14:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795209270; cv=none;
        d=google.com; s=arc-20260327;
        b=kJYgsVR5WUwSfI7SK6YtlSXSkJSAiUoNJC1XNiaXuirmvJ4EhrArgUW8klbILdfrL5
         7EAoQJSdcAG1K5+tKkNNBzpxzmacIOqbmyCFXs3zGz/+ifku/dKTbFfLSqIjQ3g2M+pn
         QbArBGUorJZ1S0/G056EWQdo+8i8TMrwtH5MQRhGmua+Xo+8T/EMwvwbD3eghAR1SJ/8
         59C3kvPwvy9FeN3mDze6n8nkUj07QlVpoKzBMkwHbmyowBkUN/pCpfVbUmSroMxY4yM+
         yK3VKSxW/V89iDWaqmCXjItQXhQQ6G9HEwekKmCXLvryTJjfLmXlSKGTctpm9sgAzcxw
         AzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G105/EwTftSMSsJfJTgrHQWjcbh39Voo9ViZSiMzFbs=;
        fh=bR1xtrza8Q/i5HKPEw3CVVG5kk/Tyicy/8c19KlOt+I=;
        b=MnerlqD6DRlv1v+cG8uUlh7q1ZFN0HdIncKBuW7uKOOUr1W5QNrAI+TG65lrLsdKkA
         BEs/UlDFYoMGcstPIx6HAhGMiHRceFINvduQog/ysBy3HmKnhiOrTzv/4nT61OirNb87
         58ehDcyEoacKQqROKrVB7EzZgGJbxMCQrBYnHsndh3Kge0oax7X/UNRsk/cbJ6zsr532
         0cbhvlOZg1q9PIsf59nxwvqJCwJ1hGQlN4gW3qzOgzJsdogEpBIcBBINx2JgCP8XICbo
         D9Jb0vxz8l64xR5doIroX8IODx1uhsWRYTQnRDSIx7Y1OhUUMhAeRLWkpF09S0RCY3q8
         dUPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795209270; x=1795814070; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G105/EwTftSMSsJfJTgrHQWjcbh39Voo9ViZSiMzFbs=;
        b=P6SKJzZAPmQIDqfA23YKnCW3h1m/JA2LEUr2DKycJlveNQ8OEkefFfSMr4vaSYnite
         uAlEaZhzdM4p/FfEKCK0IkANOklC2UzWzm2sNuoL76R6CFUrG43lxIZ6LOXOtXbB2Kt2
         0haAi4Qboao0aYxLBXlmsjo0dixbdoBUG8STLXtaYIlA32VqwXsE0xyA1PtNzq50dUm5
         6wIvFcOAvVmNWbuVFT6OojJdYXscs2kLoDPvxTi9FE0DQSz7JF0OMuDhZzJMLU4vzFYH
         DZGUhhKmdSVuGp1PfdjFNg1yX+d3Wugrxv3qiSwmqbzOAv2henW6R4ryCm+742GoKN0r
         MIcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795209270; x=1795814070;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G105/EwTftSMSsJfJTgrHQWjcbh39Voo9ViZSiMzFbs=;
        b=s/CvTR4lZqjWBi9o2/78KBQcL+zc0112bQf4ES1rQo0xl5eZ3VvFamE+66WPx2UWNP
         I2OOyVhgdtZdrktw49CFM2Sj/n2zhgWX/D8lDKvdJpPDoe4Q8We6xksp0HUV2tE4XRuM
         8+dlv+DF7MfAgjkmBuz99KzpJ2JcEuaXHk7ynyQAARMPT3rl/Ww5iCq2sIJFDhd9YA7d
         Iude3ExYWNLk9msQnrwV37llvgCf1qBRm7XwX+mxc2dezVKvpykzjrvhMnPPeVcZVkmS
         oGBzWH2rGZlCOLvyBNX6zP0RTexfnRBItVPvFl5IM/b5LhSj72nCx/W7ekNc5aVXia15
         afMw==
X-Forwarded-Encrypted: i=1; AL+hErGlQnImj/pLrqOHhs4uWHtpstjyi2cOLwhi4S/Xg5WKMJbhFi9HgqJHCxeQfHKARHDfTcfwdps=@vger.kernel.org
X-Gm-Message-State: APuU4Z+OIS1nCmasXgqCSXKezTMBWBjjujYKxtApWxlIXgu6ZUrhyqyI
	BrfaWmYwtrYnmh4/RpCJLn0JTk4od9ehA1dVkeRA47DdwGSLScoiySdYDjzj8OG6DwvxUH6o+mK
	zybPUAuEXK0n7O/73GnYjfYHsXtFyJgx4AOfTKAtQ
X-Gm-Gg: AYBFou0KTxcwe7KsVw0IibYGEuieNYa1XRDUbgmzGdxodQAmjStdvheGGJquA0GSUET
	3DCvpzNnWGv4YfmouUUix8W84rw3esPYrncCDOGRd0JiLrJeYwA+0gnUar7EQjSGLrOBAJc3eIS
	qtyvXDldHGo7On6gzEdZGpha184ORCao+fhcKejok1G7RGiNiVZaZ1teoAglkGPOZwGwlLBTwHf
	9LTHHd4weDSUL0U3crin0wt/bMbWGkbI1xN/wkbm5Eycdt/x4kVsqQ1/GvISepWfDAQjuGlOaNU
	Lq9vgUhyvKn8zTC0Oaeik37uvUS98syG48qeTumqTBmK1tglzvM499MLaayO8r0JUw5h5heBerl
	b9KEQw/jN/QraHMFeilPP8UYvUrBPuav5E4EwW31NHGDEY3kEuWqSzuGAbB6KyrPAAvOLbEniDp
	EOsPCsEtGGsHD2tOUBrlB/za2y
X-Received: by 2002:a05:622a:c15:b0:530:e335:4ef with SMTP id
 d75a77b69052e-55d88014944mr3792091cf.2.1795209269050; Fri, 20 Nov 2026
 13:14:29 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261116071325.263682-1-hao.ge@linux.dev> <20261116071325.263682-3-hao.ge@linux.dev>
In-Reply-To: <20261116071325.263682-3-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Fri, 20 Nov 2026 21:14:16 +0000
X-Gm-Features: Aa3M54plrOc1jkMpHJwvUpjhSrspGdyrmpubZwGwGNbiFNMddwdSWFYtVtM3KLk
Message-ID: <CAJuCfpHOZS6mp_no3wKmU3-S4HKspnbriUw8Mwtxf3nmw0-pfw@mail.gmail.com>
Subject: Re: [PATCH v5 02/11] mm/kmsan: undo the shadow mapping when the
 origin mapping fails
To: Hao Ge <hao.ge@linux.dev>
Cc: Uladzislau Rezki <urezki@gmail.com>, Dev Jain <dev.jain@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Alexander Potapenko <glider@google.com>, 
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, Dennis Zhou <dennis@kernel.org>, 
	Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 7:13=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
> the origin pages. If the second mapping fails, the first one is left
> mapped, and the callers do not roll it back. The next vmap of the
> same metadata range hits the stale PTEs again and fails with a
> WARN_ON() and -EBUSY in vmap_pages_pte_range().
>
> Undo the shadow mapping on that error path, the same way
> kmsan_ioremap_page_range() cleans up after a partial failure.
> __vunmap_range_noflush() only clears the PTEs; nothing has touched
> the shadow mapping, so no TLB flush is needed.
>
> Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_page=
s_range_noflush()")
> Cc: stable@vger.kernel.org
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/kmsan/shadow.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> index 0c88d89bf0d6..212449db34a1 100644
> --- a/mm/kmsan/shadow.c
> +++ b/mm/kmsan/shadow.c
> @@ -258,6 +258,11 @@ int kmsan_vmap_pages_range_noflush(unsigned long sta=
rt, unsigned long end,
>                                             o_pages, page_shift);
>         kmsan_leave_runtime();
>         if (mapped) {
> +               /* Undo the shadow mapping set up above. */
> +               kmsan_enter_runtime();
> +               __vunmap_range_noflush(shadow_start, shadow_end,
> +                                      gfpflags_allow_blocking(gfp_mask))=
;
> +               kmsan_leave_runtime();
>                 err =3D mapped;
>                 goto ret;
>         }
> --
> 2.25.1
>
