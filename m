Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0B4360ED1
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 03:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784257392; cv=pass; b=bzfbBCwS5wXI1c59+D63zhrbZ/uzSsQCccXZWptwvN6Yv5UqJUMPPMCfQsmGjJo03hS9dl9cRYJdnIWMHgwyjJYeIr16IP3vcTbduUdiLgwSlBG1fJWP5flM/wVK+MGDd3EwCDsyV4ECgKMWnQRHOwYXOHs9sKfIXNZFlsrd2fQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784257392; c=relaxed/simple;
	bh=WAbBvTLsXgnlOQja7as0tCtAkZ5zkXcTjFdj96YQCh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pXixBAQX4tZ+wCt/uy5f1CDUvd2Tgqpz3Nq4Zazv16mZ1wi57Cet0vndDSrgppnrtptx/4UZtseL4/eT++VCgcdGXrOGBM1IsxyWWoEGVBvywZn6aq5RD1BWrMBickls86zo6cf7sJyBOebyK0Ws2Zvzdy1tsAULKXwSNBe0/+U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YUUsThyT; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YUUsThyT"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-51c01c79467so189791cf.0
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 20:03:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784257390; cv=none;
        d=google.com; s=arc-20260327;
        b=P0ilpgCIA2TV2e36+1R41pqneOSXX4PwGnt2cV4XgixpT9wfQzHWEaFcgWQFX/hh5t
         cyOypHvZZ0KPxR8SG6SVvMzjuyqNcYS7ZfONG/GtuUuedgSdFoytiZGBuky0cRixBg+f
         4YxwpL5bOnYRLnT7zGn2gOhfyd0B9uUGoc60ItXLtLbo7de9uiTnncDRx5Dy8mgsdeQq
         OW1UH9wIFBo5OyZouR23Q3tuwXE+jFvhTHdf85Padxoh9xbTsrT+lTTO2/gG1kg7iWGq
         N2c7yqLX335eyloFsD9fMajObSdsOTOx+b5KhsinTgS49NtunRQ1j14uBVP/O/QZ/lSr
         TEQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oikrldI+OBOTPyHwwL9NWbSdthSThDKPFciiKUoHmng=;
        fh=gKvwRiQcgHfVAezSI0jctYqppGUeSvPenccJOI+HRPw=;
        b=F/NuLEb1iS624Y+JG2xQwz02jungnRyo1KQ1uj5TS1ZqwCR4usIemlgg1Aa4A8tWwA
         /qWql7Xlbl3g2dsoG944xHWa1xnRYpkMusN/ze5/FfM3Jm70x6Cbxk8Tx3lkJqwGRiMO
         sSLLxWO1/bLezNcdDFWKBqcoVOloMMUubvBqIklEf6cLIKiFLonWwiCTdugRV4fvLp2+
         qDRAGGiJJURiwXejUWvFZ3HcbbHIkKxUSttblN6ouR7oyRvjTvTVx0yPmMxrj4QcxVM0
         jmI0kNw1qdDdimisYFadv4DIxVwZ/WbLw0s1eHCQ/K4ux+LJhNnuRu8S2mNDMZqutDnv
         akLw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784257390; x=1784862190; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oikrldI+OBOTPyHwwL9NWbSdthSThDKPFciiKUoHmng=;
        b=YUUsThyTa9LniEnB6yPaN96w7fmIp8Rgd6DHRgodMDnUzoaWUfTpqwGvWBrZGo0epR
         IoLM2QUvqNaHQKg3TDbnVFcUwCSJzBIaVioIO6kF4JYglQKcw3cuYYhKupJ8yHXe7svH
         /NEgWTNmeBTIIiGa5d599DlaW7FZjBI39WUk+hN07AqcsGtQZr2eITmxxVUTFnwuXxeW
         6ajS0aQ91eUTaUtd313Zcp2/+QiWLw6GyX5OjZ+uXoMxxFKz+dQb9/bdCVYQeiHNsOdS
         uXF83XLcaC01FLhNcTTySfcStfBDyF41RZlJwXKyoMtmsDLwjv7nu/q8jec+Sf6TIsjJ
         Jb8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784257390; x=1784862190;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oikrldI+OBOTPyHwwL9NWbSdthSThDKPFciiKUoHmng=;
        b=QbLvyVOhKDcSN+iIJksJmNyIO5p/yD4L+lw14qlAhfrdvK9RVJ4muIaCcxQ4vKXnMl
         MFI4Q7wWMA1P9Jb+4SM0SNVXY/BQFu9Mw2nGm9VsGMJRbkGa44HclA2RZSk9Uv/s5Fnq
         /fmiIs681Dt6K6fUuuX6FzkAN+WQkegx2cdCUXAEMuBJDKEfAyqQ6AI5arY93PdikfZ/
         YdhRphn0gR3NAq6YwOPyKq3k0um8TDoQNMmQAKMjUioayG3MXbePunwvxkQKkNpwm5l/
         k2eJLt/b64QK+FIFdPsNmzivPF+l7zqxspSQtDGPsaYPFxM2OdRDqZfRFh5YlAPpohoN
         w3dg==
X-Forwarded-Encrypted: i=1; AHgh+RqfDQ27xetGOtmX2KIUQxc42uFXY1uxpZ8x9EwYoc7JmroLL3AgqldmBAoviV/WXwrmVtn+pB4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz26bctm1/lYrWZ+dhmhF77pXAx9r3XU2vTi8XOkxyiWgk9u23Y
	/7ut0Tzrfo0TuW80wpbApK36cv1gnt4ZZ8JPryqIXSUh/Npsc1ClNYkZW9o1HSyXg+fEhJj54GT
	fpqcBz6TyUvPH/w8Sbmv1NlwVzW1f1DkTQSGFBJWm
X-Gm-Gg: AfdE7cmEbdQchZdfDozlonDXwebJeIEa5DdTJvKPUheKAkMWGqLGniDH3yKMp2h+rmy
	nmv6hWXMPXpMu1DzqfhZJYJwrgyQNDczqFSMDD+bh7X+dOj79dGup2h3bojdpBumQzDbrwRfmHK
	ZO58fMjY8WBIzZq3eojPKMDMpZ2mmCZZiztYcbdwcWwMpUf81vxK9yn+xQ7R3akAERl8YHsYm1W
	9iWyzN4KtLYzhgnn51Lz7p0um9lmCGO8Dy04enikTjfXsOENwb8Mx8cbXZNsyJ/DFe5m3Qp8EW2
	d+yF6YWAGzULC63T
X-Received: by 2002:a05:622a:3d2:b0:517:38aa:c2b3 with SMTP id
 d75a77b69052e-520d52524e6mr5272751cf.14.1784257389146; Thu, 16 Jul 2026
 20:03:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709224330.946683-1-linkl@google.com> <8d316b6c-41fb-4ae3-8923-3b649b92b33d@kernel.org>
 <20260714092146-mutt-send-email-mst@kernel.org> <CALUx4KSxjpHhgkHZ5p1khLSe7+-cDHd+ZtBEJS1HytWSo5WbHQ@mail.gmail.com>
In-Reply-To: <CALUx4KSxjpHhgkHZ5p1khLSe7+-cDHd+ZtBEJS1HytWSo5WbHQ@mail.gmail.com>
From: Link Lin <linkl@google.com>
Date: Thu, 16 Jul 2026 20:02:58 -0700
X-Gm-Features: AUfX_mxvju2ajwqaWLph45EfnN052a5lxttcd4lHH1YraUcmngeJ8Hc_Z-8C0HE
Message-ID: <CALUx4KRiyxDfoA9D48zz0fChrsc_NUFk3gDacZrMjsntj1m=dw@mail.gmail.com>
Subject: Re: [RFC] virtio_balloon: fix Use-After-Free in page reporting during
 PM freeze
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@kernel.org>, virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, Jul 14, 2026 at 11:05 AM Link Lin <linkl@google.com> wrote:
>
> Per the earlier feedback to keep these fixes independent, I'll format
> v2 as a 3-part patch series:
>   [PATCH v2 1/3] mm/page_reporting: use system_freezable_wq
>   [PATCH v2 2/3] virtio_balloon: fix shrinker UAF during PM freeze
>   [PATCH v2 3/3] virtio_balloon: fix OOM notifier UAF during PM freeze
>
> I'll send that out shortly.

Hi everyone,

I have just sent out the v2 patch series in a new thread:
https://lore.kernel.org/all/20260717002311.681748-1-linkl@google.com/

Just a quick update: I previously mentioned I would include a fix for
the OOM notifier as part 3. However, upon further audit, the PM core
explicitly disables the OOM killer (via oom_killer_disable()) during
freeze_processes() before device drivers are frozen.

Therefore, the virtio_balloon_oom_notify callback cannot trigger while
the virtqueues are deleted. Since it is already safe, I dropped it
from the series.

v2 now consists solely of the page reporting workqueue migration and
the shrinker TOCTOU fix. Thanks again for the reviews!

Best,
Link
