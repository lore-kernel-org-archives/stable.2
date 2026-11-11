Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794431050;
	b=IoLevMhvXnf8rrO8snlQ4FGE/80Xx0IvSy4HPbJ+iRGrQQywtTuD+n3LFlrusplyqz3k
	 RQlyydKh4M+AvOP9bvvsTLVCPMb/HkaY9VPitwj+3W0XwMb+cBbuZkZurkmXzj867c58v
	 m0s8UwQcx1Bi+xiNWxBhGLoBOlmUxqOyPjFp843vJrVH78aXGAQ9CPbfzT4ry429vwh07
	 OsZU4CaKIYRH5itcdlTD7jBQX+odQNtUT57WsfBq1smZi/pCMY66UpGwnQC8X7RkNomIf
	 Sj7tySoIq5mLeWuYr19+dg/tvmJttm9KQCjRjA9WoaUd0KSIpdcikR8yeZH2eMDhQ0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794431050;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=7jfAi01Q4CRlBo14NA8JUFvh8yBOtjDMjluJPzC/jYk=;
	b=F1kC6ZzTV9+niMlW6dWikWVx26IsPh8xsB0tOzZV4FZMXA8Pfu+AQ2WXhdTWzJXzZuXE
	 vSstYDI9Y6w3ormZ0Z9JYw5mUm4YDlQ3YjaIJsqK4VcQcx4Y6v1I5uCIfpkWIjEW2kTfr
	 U9KauU3AKYuWvyxU6Llx9X7SNW2wq0tVD4Itwafi3UjWVpd2OqfNn+Inh0CAFngbcfo+7
	 LJ+psEUCAYXGv8/1LcK3PcfClraH1HImjHvE6NmKbzlAtoXE0SzzgOtpMkk8ijf15hvVY
	 RozbmvKI/lUSpeooz3A2i1L03oBRjO4nsWb9GC1pgwEmqDwdei8R0wDCU5WUZsZGJsw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bxfIWCdG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923A3606A337
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 923A3606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bxfIWCdG
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-535f598d126so2361cf.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 13:04:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794431049; cv=none;
        d=google.com; s=arc-20260327;
        b=Fxh4+Ab2u1qSDHKPfAKhzKS51t/Zpy9BAWug9GJy1WwAhhSdAh+PEB5MKVMTW7GA2q
         U3cK1sKHNxsH1wJPtvV3swu9C39JIxrxBk0d4hqfNEuufjJ84hbZJ2aJtnpEFIL856U0
         Gs8Z+G8u0jSEJXHVL9YGtjOCSFpSpmtVgnZg+5WT/8t+zsWTltz7AJkCT82+GSsx2ZmP
         ydE/lDR44XPyjEpBCB/Jk9MTjcA4HkwV0MGbR+Q9Mmw/P4nwLLG+LBRXLfIc+iOFaxv8
         mj5u8YN8PX/dsHQ5QiDebZwhZr1dE+xq5AbE6LaOQV568gapUOOgX60T7spGxcVo2C/M
         gHMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7jfAi01Q4CRlBo14NA8JUFvh8yBOtjDMjluJPzC/jYk=;
        fh=cTSiFafLXemDAqW9lB3LLdwIuR4I2EgbFje/YXf85eA=;
        b=OZSGFWpbdn4nHRqed/8cDmYfYjzfqbanDwos7KfYZlNri0cUsqRJNBZZQEr2LjpT35
         KDjVtqZUSRNu4CV3X1G5U6QcLc0d02ElJGCZL2upO/1d032KlDag3aS75RZpfONiOILh
         cZ6fZpBh1SbNPdbj8dBk/QTxjoag3DIf43wP5Sx+qrTGMkm7Ih63/zOwjqL6WCR6/zPR
         BiUDQRSiRkpy1CS9hDpO0i+FoL8iNLeH87OZrZNAOPtndhm8LJqPbKW3BC3jDOZEwfFm
         5BtOshpYLwDHktpSMbCKJmSgFCSDAEssj/CpTExSi/xPW2hDaVPkiz7Emz8sFOytfJpB
         YJ6A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794431049; x=1795035849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7jfAi01Q4CRlBo14NA8JUFvh8yBOtjDMjluJPzC/jYk=;
        b=bxfIWCdGZ1TRSWkwE2pYj2oNlo+FEGTaBSS53QQ6/0PR2yII38XE5x9CTx8at3iA3i
         UXL1OKLn02ig9V2rOwQ8bwXvud1ou0Psm+6bS98vYx7P2cRvd0MP00uoxFo+qbWmPvwZ
         mbposkO092g6230L7HRb2/Wd9xVxU/O7rUGddOYvGbersLBcWUDyJdOf+rjMbeJfzUSt
         4NCidUMO3UWUtW33jqfNMy2swde9zlmhXPkXJ6B0vpj/TbBzBNGUIybmfJP+w0N1HX5i
         a13chlakot7mvhme4LMERCOnOw0rjpTX+QUWAEuTIv5zoTPD4VP/P0SpUA4IqgF/BIeo
         wR2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794431049; x=1795035849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7jfAi01Q4CRlBo14NA8JUFvh8yBOtjDMjluJPzC/jYk=;
        b=bwpw9GhupWQa8VF5yP6L/zOrBgu+Vbz5Pm7to/+4S7iaJaOuXd/8odyaEhlt+SThe2
         Your3+U9yjLhmU1yP4eSmXQAnkUQWVfeBvXTxo1YAqBjwpKnlfRXzKbF8MptKWUORx2z
         g1RclUZ4Huf9+eXa+DzZzSUP0T0MVuhRRqIEsy/RYADdD85jw2BFx7ls1UWZNbnDKobs
         58aGAIYUDf0yYLr5svmkOiVyTUKHeVBrbYgJ+AIzJuopVtwKUQy9QWv5qPNe4xV5IjbY
         spYRCUsfS0PwaoFSeLhX0D1jIgH/rXuMVz2y7O+lBmKGiaGbNPQSuQg5yCQ6rTGI/KhL
         Va5g==
X-Forwarded-Encrypted: i=1; AL+hErH5Fkx3CrFgPFp94PZA7ScZa3Jn052qZHKSUG4P/EenlosX7uM8o12pX/vFrDTj60jF1aK5qS4=@vger.kernel.org
X-Gm-Message-State: APuU4Z+K/y6RNTx5OwN3+p5U05hb/qu5sRwEMXnNqqLGR3zGE8qs974Z
	R4J50jrLBA0lvay0X6/3tJeznRmYgppInTV3xPRTfSEhoX/URZMvk/LDkBbPE//5B0ap30mSZt4
	GNs3zKYomn9AzPJ51dzeA/DEbep3rFiBI8Jb3I8/+
X-Gm-Gg: AYBFou2CEuP7g8v6rGce5qvkUXLhW3eFtEbz04OAHfvFcYU7Lu2CnD4EjFibqdLtBPJ
	6b7c1jYEDW8zqZt9b5P1qiqvySJQBFflPIHvYPWisLDy27T1y1nnZGIeksOpEtMTRsCc5i3KOFF
	MK8Rb/nSZqEcCmkAikuLtOo6/USeL3JYu6Gt4LUYfZeR/RVVqXpkPdZhudePye4bi5294Izxkoq
	jzjaalX3foh7bnaPEJEUm6yw2Wq+Sxl9v5oJPLoMqVWAFQRLgYjXmgfTuE0KhYzYW8h68EvucrJ
	4lckpUCcZ3Xgn9OyFabBbZJu9kX/+TtS/T7aFEFk/kv3yj84Y553SvXXqvLfaM3CbOw68oxcwoB
	+TgBn8J2EXEgjyT+08b3e30yVa+dOb/mUuednA3RH+1BpNfx3KNOM1c7RbCu8OAS37omNh4xjNz
	Sl+Erv+8g7WRteZw1hdbhR6uUD
X-Received: by 2002:a05:622a:2612:b0:530:e00f:7768 with SMTP id
 d75a77b69052e-559670434c8mr4152141cf.0.1794431045881; Wed, 11 Nov 2026
 13:04:05 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110112546.261415-1-hao.ge@linux.dev> <20261110112546.261415-2-hao.ge@linux.dev>
In-Reply-To: <20261110112546.261415-2-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 11 Nov 2026 21:03:53 +0000
X-Gm-Features: AclHuK9dy2sCAhDvi6AKjzXMWgnJES78GwGzZ1LsZZk9UkuHFg5q24wLvar7eig
Message-ID: <CAJuCfpHjSZhPPpRudAdrDPzz8dGK=Mx62CYCNoO4MC9OhnGd=A@mail.gmail.com>
Subject: Re: [PATCH v4 1/9] mm/kmsan: undo the shadow mapping when the origin
 mapping fails
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

On Tue, Nov 10, 2026 at 11:24=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
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
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Reviewed-by: Dev Jain <dev.jain@arm.com>
> Signed-off-by: Hao Ge <hao.ge@linux.dev>
> ---
>  mm/kmsan/shadow.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/mm/kmsan/shadow.c b/mm/kmsan/shadow.c
> index 0c88d89bf0d6..2166086d3dc3 100644
> --- a/mm/kmsan/shadow.c
> +++ b/mm/kmsan/shadow.c
> @@ -258,6 +258,10 @@ int kmsan_vmap_pages_range_noflush(unsigned long sta=
rt, unsigned long end,
>                                             o_pages, page_shift);
>         kmsan_leave_runtime();
>         if (mapped) {
> +               /* Undo the shadow mapping set up above. */
> +               kmsan_enter_runtime();
> +               __vunmap_range_noflush(shadow_start, shadow_end);

Sorry, there is a problem here. You introduce "can_resched" check to
avoid calling cond_resched() later in the series (in patch #7), but at
this point __vunmap_range_noflush() can be called with GFP flags which
do not allow blocking. Before recent Ulad's change called "kmsan:
remove hard-coded GFP_KERNEL flags" this function was called only with
GPF_KERNEL but now that's not the case. I think you can move
introduction of can_resched flag into this patch.

> +               kmsan_leave_runtime();
>                 err =3D mapped;
>                 goto ret;
>         }
> --
> 2.25.1
>
