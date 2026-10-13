Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E5C04EB857
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 11:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791890326; cv=pass; b=DX7xRB4d13wL3X5zF5SJcUHQxP9rNJt1eher6FNcvtHvdFeah8dm+AFn3r9XM2RhUPk5r8JlHW//LxO3tAQGUU8sq+BDgIhDRP3k0Y2Au5giK9lUAT4QzFa2meSvd63GdFelk25LbPGuKsq0t3phN0AE67w3cH9jJ20nHo+gHis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791890326; c=relaxed/simple;
	bh=Q63BcNZyGyVpop4uzp221nM7vw8JR/lEp1p43PpSduQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Oq1QvH5O/eKZYBmx5v/QEXKxRmNRAGF8KqxFNAiwB3tTcIR2yC2pEPjVGD0o67mcrtqywG78wT8qXRC0mCUaluWj+sR+seFRFUlw4rlzbor8GuC6bHszswhf4ZodNIoaR8VsU2bxGFoXrAaIHiuQvwNWUB/Iw33s0quBhR7Qjlc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HkZpI+el; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HkZpI+el"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5337c7b9937so706231cf.0
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 04:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791890323; cv=none;
        d=google.com; s=arc-20260327;
        b=O03U09WuXTs9iI3OoixY+J7Ur3AdRR/M76yoXN0d2eh9wlZwOmB6Wo776mWhmOKPL3
         4O/ZOE2n9tpUVXPWmiQlrDzWINsPguNv79s+UuZaTyvafR33UgRI0CXFeZIdl7ngN4Tn
         vO/vu0Sqh7I+LAbJyyyCkH9Qgxrw1dwWyocWHkRvFKJciGLs10Se9lyRj7CVCh5a3cR0
         6mWnvHJxOEVx/Bv5ERcW0V9IFgqYknmJkb4VOORlRs73TjCIPYl+CbepHhxpU7Z+gaH5
         Xp3FKg+6eh2s8g+YKkcGL0NUaWHXeldzSvdkSWZtVJ7xosHwgbwJ6LbwC84npr5zlGAP
         RRwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=02lGd8mbATmejUO3KQVY/K9npSJMZS97UeoTBHaxfAg=;
        fh=R2u+LZKaqcaSU/yr218naIoZPLTmwoPodFMTL4fpEyY=;
        b=ZfekqddovUlQQt45MFIFwKxmhyz0L9GbbvpRouo5jGOgRN+4P6ZSgV+ckOpOGDBXgQ
         yr5olDX0a3AeRWd8wZAboppeh78S1nUn7PQGrAx2ZttH+kKMd5dtptyzWj9uZ4hlrpiE
         nVU5CMn3X5c3ZzT1tGk+M7AaKsNWRghNwHvNGBrIUkPOIxHFZVZl5+6lj5EMNrxpbs2o
         2jDcfmZby4mBXSWGa5moZEkRS+yAMGGcR4qGQBfDXSTl2DUrzw7aXwwFoixkiCbFZ6Ys
         cJN1JG7wr2iPnPBBZ7ZlvywnrcaqILi1cvk2fjtPMkYKstV8/+qYKF613vo332Oy8OZF
         zBFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791890323; x=1792495123; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=02lGd8mbATmejUO3KQVY/K9npSJMZS97UeoTBHaxfAg=;
        b=HkZpI+elt5tGTiVYG2jz4qK9ByUe1O8zK7ppp0VkxSuHFSxtda6G22rxjgtnpUtofZ
         3BjfQYYJYXq6lWdLghkm6ekOZdY+sJXsahpLTMeikazO55wvSfT7DnwZ607qaGXOyj/Y
         uqq1cM3/iyVleESX8sUqH1b3Eqw703vmXQihYLcvPvWuYcDtc3m8WYTY3OhDXkaHvvlN
         RQ3BQVrU180Ha/QmHx7XnTZQMINZcEbqygbG9yYBNViHfruuxFPqAz6yTMKIpQn4QEL1
         OQ/M8McYuxkG1S3ugmaNu2N8bu9S0eRr3VDQ9MnN8DgEd8cuwkZ+9Nq7dXPagzP6206P
         0JzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791890323; x=1792495123;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=02lGd8mbATmejUO3KQVY/K9npSJMZS97UeoTBHaxfAg=;
        b=kwUMj+a9zrQmiEty4gNQ9jG9UQDdfmcC7bt+tYcNfqrakFKEFDkAW89MxISHgpQjGG
         1zJr1hXw61Rt476wc0eNyUV91VDo7/hdVW1myirLIjFedbXGbVgJz6RhtghV2mMx2FbR
         ih3FT77rES995OBhmg9P+wPaEVP9bURn45iL1+PyhuLo1a/2Btqjd6im9d/wZ3L86s+j
         p7uj92+TEv2rzkLIE1CupDMTjI2s+Fp46olRZZWP7eugnyWSGCB9ffo5+EYmGZzjwQHq
         UZ0qfvO1kVUQO8ek1PbT5Zm3veO2XmdJOFymuRTp3vqdijzmczIN/I0JONNcO3Fj1+Ii
         XrAg==
X-Forwarded-Encrypted: i=1; AKwUvBw2S0Y+XYuQSdKUBsCUKLLg5Y7mccuAuOQXSlW3at8p/awIJWLCp2dolwMcMBozHZIVq3NI/I4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJvGfg24Ai1urb+KYAz/aD1s7smFPGtEyDsF5DUtFvIKfFI5mep
	hmXP3IwKnBVGlVrS5iES7/G/TavrCD26b/HMqg3bGIVVOG5z3AdZBTmX6EBpoTUFWXW5rE4pw/6
	QOWtPzdMPODJ68/wb+39OBqoPZlP5fkQJtwkHjENY
X-Gm-Gg: AYBFou08VRuUfZnr8QL+RNW+WcmXlzcsY+2YV8BXRt6RUJXqMmSj2Zven+z8RC1YDPw
	cAGdgFCrsTe8VQf20UWNXeYgMWl5UTOrRshjlHnzyynK8XqSC3u1Ytu+noPX0WNwRa3NRzP3xcD
	bEmFgDZkP0Hbun7H48Ay6d8qsuiacBeTsrg57pNUEIMoPNdqdYhkIFjn3UYBtogk9reCPBYtZ+N
	BkQaC57ufse1Lfg5ZfUxOVy5eRt9c7a43F0bRbCzbZlcrCK+XIrIJDXtxRDf5EWVdMACFoM5Xmk
	ZvicJVu5acTLT4+5Ur6hjgvOQzoGHmB3Kh3DB11nZZY0/d6aChqfCSY5
X-Received: by 2002:a05:622a:4cc:b0:52f:8389:29e0 with SMTP id
 d75a77b69052e-535b2910266mr48102151cf.0.1791890322506; Tue, 13 Oct 2026
 04:18:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009063619.112313-1-hao.ge@linux.dev> <20261009063619.112313-2-hao.ge@linux.dev>
In-Reply-To: <20261009063619.112313-2-hao.ge@linux.dev>
From: Suren Baghdasaryan <surenb@google.com>
Date: Tue, 13 Oct 2026 15:18:29 +0400
X-Gm-Features: AclHuK-qvcUVrSOqAHUBuFhMyipfniAtX1mtGlvajg8JTqSPRj6kAwYVpLqLul8
Message-ID: <CAJuCfpG4Zq6zRyvXkf40XcsiMSvS78Za28zY2xcaAh=kXpuD8Q@mail.gmail.com>
Subject: Re: [RFC PATCH 1/4] mm/kmsan: undo the shadow mapping when the origin
 mapping fails
To: Hao Ge <hao.ge@linux.dev>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, 
	Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Christoph Lameter <cl@gentwo.org>, Uladzislau Rezki <urezki@gmail.com>, linuxppc-dev@lists.ozlabs.org, 
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 9, 2026 at 10:35=E2=80=AFAM Hao Ge <hao.ge@linux.dev> wrote:
>
> kmsan_vmap_pages_range_noflush() first maps the shadow pages and then
> the origin pages. If the second mapping fails, the first one is left
> mapped, and the callers do not roll it back. The next vmap of the
> same metadata range hits the stale PTEs again and BUG()s on the huge
> mapping path, or gets -EBUSY with a WARN_ON() on the small page one.
>
> Undo the shadow mapping on that error path, the same way
> kmsan_ioremap_page_range() cleans up after a partial failure.
> __vunmap_range_noflush() only clears the PTEs; nothing has touched
> the shadow mapping, so no TLB flush is needed.
>
> Fixes: 47ebd0310e89 ("mm: kmsan: handle alloc failures in kmsan_vmap_page=
s_range_noflush()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hao Ge <hao.ge@linux.dev>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>


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
> +               kmsan_leave_runtime();
>                 err =3D mapped;
>                 goto ret;
>         }
> --
> 2.25.1
>
