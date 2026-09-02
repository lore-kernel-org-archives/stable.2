Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E51D38D40B
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788381723; cv=pass; b=fBCpai3mwxPc+vY/pmhReSik9CdS1CQMoXW8v6lmM1IKWIAyXbweFFFNodl/trW7glVTaMXUOIZAtiKxAm0gta96LCqO422ZktsqL5J6oO5MwhdB/AOPHUrnkrig8NDpLrwsKGybjOQKZt6ULL17GF7ju9jXCxr2tutWP00MkC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788381723; c=relaxed/simple;
	bh=LVhIXvpFzVpDu/8jrbjniSLr8dV9PsbTGwAGD6Kvgqc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hFc7OnY3iCRetPEIEfmqW8jQ0ATbAV3v//eKh61KHaOcHm+6KpJmRM712aYNHANAFeSu494k9JCraZT1DZG9ob0NoeKZUnybVWEcMCz1/KYWI5F2t14easHhO6JvDNN5eejVIU/gwM4moiyO699/yfBGEuPU6zpnJ82NORELQK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eISHAEUG; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eISHAEUG"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c25366c9b42so178336266b.2
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 13:42:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788381720; cv=none;
        d=google.com; s=arc-20260327;
        b=D1M9dUTJrvM6MkIZ+KBFv4PSIeMEOmH96zI8Q+ta1vmhH6fFxZG2r1KjijQPBrcC6i
         E2ia19rAruM22IHl/xqRHr0rr9vDyDQFXq9MyHr1NaDC7qL5cGDOYn3XX2A6vuupMCK/
         v4SLOr64IByUspPibrhphYWGoaqslJAkQP59Bjsbxfsna0xXtlbS4igfg1YTTNTcEalm
         ZMV2rH1K9LPmE/TSz/hzvwi48h5m+ySOKhGzLnrbuxSt1Ffs4cESNuHm9yljWQAxLfHG
         TXkR/221telc3A189Fy+nSyeePjpgFFEbXPDm7Dy/vUz4eCLkmjo84gNAceBgd2VLmQq
         lRpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LVhIXvpFzVpDu/8jrbjniSLr8dV9PsbTGwAGD6Kvgqc=;
        fh=phAgQhhD8Ut2X8YeYeV8tC4bxxg/siGPQvT3WwT4Woc=;
        b=TbBiyq4ufOB1jUM7mFhD/PNTPPFjvlwCh4tHp1nXQ4P0jcqMHyW9SPD/Tm/6O9ASFi
         QxezsTon9ugxq3hB3fGcmIXCnOJH1/YBcX5teZs4unFDFx6PZzj6AYLidNtkYUaSxYsM
         LzI0jIyz69rhkmK9gDUi+S+unQdQt0rGwgdFc1LicoRQyFMV0dCUmZs3y8OZDY1MPMEK
         62uaFqkYxJpTQpl24dx8p+Ox7qrBvVF65kpfL3N73CnCqoikNiyDW7ThNjuncPVsdjx7
         uyHxr7fiAkXY7psPDqZKeCaOw6UTXowert74cUh5cCD15DPuQXxX7IBUlNPJqA8eGCjY
         y4hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788381720; x=1788986520; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LVhIXvpFzVpDu/8jrbjniSLr8dV9PsbTGwAGD6Kvgqc=;
        b=eISHAEUGc2SvT3CzeGltwiFcHZnnQ6ea3r4FAD2xyVcfAG/VyOGHwDA9Z3yjFOQJ0w
         kzHEI8gGtapjd3A+ASTnVUWg7KmDvreDcJGHaZXsTAwBeYSsCHt+EP4Pm93zLwJq1HH2
         FmFe25mgsH5saIzWOf6nySwrcKAeb8TtdQb3fw2xJAJezcoblDXU4Ef5E8p86Mzc1OZ3
         sI37kFVbl4XFHf/DjlQbDhgWycRaj8SLL8PTj/qU48GV3ez7SY5rlBBnT+hFp5SoiUwX
         skuLkcfjxRRESvetK+EBwLfmjTJiEGphi/5FgBppHKY2JXtzdsvgFZ9V0fmm32l5h37a
         J29Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788381720; x=1788986520;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LVhIXvpFzVpDu/8jrbjniSLr8dV9PsbTGwAGD6Kvgqc=;
        b=fEaN3iIemFWKIbQmHWm/waVr43y7hrOnvqSwjqOGIknPuRUw/+R1BHDnFXFad0PQRY
         nZLhC7O6RCwxQahbIWEVizLl+EoF3B4fbd3JF7jWuAjqsqpwL89toySlw8Y/kG7sRtKT
         irqYHoO0uUQHooa8C8ZJ8o3ztTy5di+E/pAZGsRdSJbeh1ELArVTKKXJSJ3c81lPg7QT
         VaQVQ1CodjNqY+A4YjOlz5O+xJSOdjsDcHQuN5C+YYX52VQiX9Q6hUUjbBi94cGtFpz3
         bw1IQHWVeXLchHhSdqy9dmmy3TEhX6p9cbbXH1KRUgR6t5ouFq1Rx4KzUKp0P0jBO3F+
         /Wsg==
X-Forwarded-Encrypted: i=1; AKwUvBx2YhUXaVDIwlwmaAE3J2YgW2owikmlhI8iFo5a0D9+c9tE8hwZ6bBbi3xhYiobduO04fy9ICk=@vger.kernel.org
X-Gm-Message-State: AFuF++kuXEfLvQrop6vcz3Ea3FVDw/NmUPCww4DaUBtkGNU0OwrGpLM9
	7+dm+n2J8vBd/LfivOnH+xJZ6ynqtrc4OhmYDGBdmpVf652jrCGNB6VcW4XHv4c59+2XWh4EQ3b
	++np+eQPzo1NXWwyjcYPuLmgG/BI1NP+dmPKuAa+G
X-Gm-Gg: AYBFou0Ftc4jIu4pNlYpJvc+Fgxeomzl1uxWUWqbE9p39mD5nRpjmo9oHmN1l9IGG9I
	pwf3mlgL84pL/qlFCACPU9YIRzMes0HSjJuPPlglTL/ppRe89+zyzgIgid69bSXh+zsYYwlwn72
	WnfjA1LOdsVgtlnyBID7rKSH7dl7PY4233ZVh3hQVwoah0+bgBhk3juwi3C1KH17TAuUzPhRb23
	FQ6DkPO+RRu+wN54OsOo3uel0HNxRYqz9y+BXt42JwlQm2DcX5pWcwW53otwalsB+LKyNVNVrNj
	LabUvmwi6tnpUVwDF4aUAytW0iI7ZNExbO1kfrRxIB708AOPqGrdD4ENo4yuaTwfyYZPw746bsl
	KxcmgzQNhwEvZUago4qB6KLgTkTBkMKtNVcr6Iwn8x5UrlB7iMlrShE2+UNwi1/c682ULgcI5Ng
	qANz4vKqgsa8DJ
X-Received: by 2002:a17:907:c78a:b0:c25:541e:be7d with SMTP id
 a640c23a62f3a-c25d55b8807mr567367566b.18.1788381719836; Wed, 02 Sep 2026
 13:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828094703.11081-1-lance.yang@linux.dev> <20260829052606.49470-1-lance.yang@linux.dev>
 <CADrL8HW3=n8VqW+7YSb2kyhkHidNKGy32+2s7A0OfF+oYoAifg@mail.gmail.com> <apf5xBqj5560JlMD@thinkstation>
In-Reply-To: <apf5xBqj5560JlMD@thinkstation>
From: James Houghton <jthoughton@google.com>
Date: Wed, 2 Sep 2026 13:41:22 -0700
X-Gm-Features: AcwNN1XNWP54Rwi-EWw78kODWTxBfe6WSk0GmMqznEozoElZj8yD1pyZq6NZGNw
Message-ID: <CADrL8HXg-Ybh9Lqgo08VSCtyD=8byMOZZJqEDgdr_+=p_KwYaA@mail.gmail.com>
Subject: Re: [PATCH] mm/khugepaged: Don't collapse uffd-minor-registered VMAs
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Lance Yang <lance.yang@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	ljs@kernel.org, ziy@nvidia.com, baolin.wang@linux.alibaba.com, 
	liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, usama.arif@linux.dev, 
	shy828301@gmail.com, zokeefe@google.com, hughd@google.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 3:27=E2=80=AFAM Kiryl Shutsemau <kas@kernel.org> wro=
te:
> On Mon, Aug 31, 2026 at 09:51:33AM -0700, James Houghton wrote:
> > WRT the semantics of process_madvise(MADV_COLLAPSE) and normal
> > madvise(MADV_COLLAPSE), I think it makes sense to always disallow
> > collapsing of UFFD-minor VMAs, whether MADV_COLLAPSE comes from our
> > own process or another. UFFD-minor faults are intended to be resolved
> > only with UFFDIO_CONTINUE, and until someone asks for it, I don't
> > really see a need to make MADV_COLLAPSE actually work to resolve minor
> > faults. I don't think userspace can *rely* on MADV_COLLAPSE resolving
> > minor faults either.
>
> It is safer to go with stricter policy: reject always. We can always
> relax it later if there is a use-case and reasoning about the interface
> is solid. We don't have it yet.

Thanks, Kiryl. Sounds like there is still value in this patch then.

Unless Lance disagrees, I'm happy to send a v3 with the same diff but
a rewritten changelog (and no cc:stable) reflecting that this isn't
actually currently an issue. And I'll include the uffd selftest change
as a separate patch.
