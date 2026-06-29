Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818BE4048BB
	for <stable@vger.kernel.org>; Mon, 29 Jun 2026 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782739211; cv=pass; b=INebM1r/7DudbF659+koX32pW7ATVgmbdpBi4BIsTsOGqL4BAnY9JH0HJmvd0Iu1cKdPBLoFIm8KnvfAuMTxA6nf43C8i1cDX9zeH76tGgrqFnbLxP996CDmkbplvJD+txDSufU/DmSGiHsMTYK37zOmOV/p/NnWGEaC+ixqPRk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782739211; c=relaxed/simple;
	bh=+A+RUJTLJrGbg9VAv0ThV60lYJTd/ycmh9oKZScdsCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EaAMffMAZSUOZgXNbJQWVj2MQT31vf+K+hNqQaeCy/L9tTolqBBEtj1YUHYZ3aP805b96gkq5AclTvSZ9OwgMkFVKmnm3TWMsNsMRZHRh0ebdlZmxa/gTdjI9SHl/FM64slErhLMmdKhTknSXikHMOBS3eKAlFGKQyubENKpnLM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OtDRmQFK; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=SOo45Wbl; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OtDRmQFK";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="SOo45Wbl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782739209;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+A+RUJTLJrGbg9VAv0ThV60lYJTd/ycmh9oKZScdsCM=;
	b=OtDRmQFKZA2q6ygtKSUlgzHK9spa2LQQRT31F3Gj6cYGD5ynZZRzbThUO+Wv2RJ+XDhKSq
	lAJzzYWbdTjGtPr6iUw+L9nase0py5r7B3Gkb4vqHnh9N5aBRuD47OtLV5Zi9g+BjRzYKJ
	HVrqniCIiSmLzP7x54jCzB60TeVJFYc=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-lppY9MCsOiu6NFflJhmGmw-1; Mon, 29 Jun 2026 09:20:07 -0400
X-MC-Unique: lppY9MCsOiu6NFflJhmGmw-1
X-Mimecast-MFC-AGG-ID: lppY9MCsOiu6NFflJhmGmw_1782739207
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4909b046dabso6517576b6e.0
        for <stable@vger.kernel.org>; Mon, 29 Jun 2026 06:20:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782739207; cv=none;
        d=google.com; s=arc-20260327;
        b=kXxCozWgsXhQXKoWf95WKBrUn2woZw1BBoYpDBcUPrGbiaozSseLJgXYfsiZLjr8iM
         b/BpdiNmj572/6mT6aG9VLo8aaX5GjAs4UEHCrx4gwuwoHmQ7g3WjGxtJhAdqiPgR7xf
         jUfjS1+Mg913wf3jovoP4k91TjisAsFbmZZlWt2i0ByhOgcUaSPk209ESteZdi/dt5ut
         n39SCiaLoBVW7QGIvwCzEK6DBbdOpqWNZberQeIJxmlDUeoRRip54tHL49MdfrGyN3LO
         nimcgUrJZbBs8Pi/HckJyMasaSeWRowrur93Ol1S5aQlNBV3BXLycaQVXGp1v4kXCZTB
         cd8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+A+RUJTLJrGbg9VAv0ThV60lYJTd/ycmh9oKZScdsCM=;
        fh=T5mO7V/lEHwqSJ45UQ7cJyC3FmB/RFt2JD8kO98XIUc=;
        b=W3DN6ppmosyKX23629hRf4ttaQ6sL9NSYW3rUE8jC8zXWWDfYld11oUcT7UUfgm0i2
         dd+J4DqdI1O8tXRoH0xbEyWud8jk/1N+suQpkUALrk31tIyBUM1SEHf3N/ERAN7zWkoO
         UXAqZmd3tWp0aWr5mebDSjMNUo0IPNbKx3BEGLiLRcNGQox57skcnU6uK9udyMARfv40
         LoWzHsji/eFNm6tG0HBhQmBfA8TZi3STH/eR+P9NG/xOZRVaG5yLP3DIaoMM28T814Gz
         7EcLGcqNKYnxrWKSAErJTHecvL9Dce9C5z3ZMBV0QfxGte9lHIuG3gt4lXQO39jBJsYR
         PSvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782739207; x=1783344007; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+A+RUJTLJrGbg9VAv0ThV60lYJTd/ycmh9oKZScdsCM=;
        b=SOo45WblozuOj5/C4Csm55jUwDH208E5PeEzqBtsAJ5kZGAvuo+RutnVtJcmhH9Kyh
         m5wtENHJWnOpu1bmK4Ox+puUJiVjCjUQ5hCZDPEwTaW1koStfrQwPcAIfy6npXYUBNgx
         KJn1VMalvfqyh5KGFldZkYwt7ceaZQ248xSp5SX25gRVD95aJccHQiPt3dnRalN5gRwA
         QnU/5vhoqC9bPMR9h7NCGlmWRQysjE2Oa9Fk37auLgzEPdLcbV7KzNZ7gc6hr0DfPi2h
         u2tiei7erfPwzDVVmRHkgAsobqjBVp1EP2EacNLGGJlLYu+Tc2qzFtad/OHkO+vBBAPT
         tahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782739207; x=1783344007;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+A+RUJTLJrGbg9VAv0ThV60lYJTd/ycmh9oKZScdsCM=;
        b=bgIsOhn+2Jw5ngJ3QXtwTOl5ozfLpnXX1Xktd9tJQJWxZPJhVITLm83q9OqzwnS9vo
         jr2zak6OYjc7f2h9s6xc5vOt7IxQ0ZGmsU4FNy5+iiMxtQ8SsihZVArpaUOuX4nbkSy+
         Qo2sZwwKIeZN80PkVNGnujDBz41gOhVMS/u7v53wC38i0X+/4cPcNXlJDohCoODgMFiW
         g2+s+8Ph+P4i8XjEDBZrNoCbZQVEHy/9cqucGUv+tQsSktLD0hSwZG99QLEyMXulqogw
         8cYqheEX7N/6XThlH5+k9UKEhmC/bmxZ3/kRdbFBefXPQ+pgpfERlghXXkP1ryVYupbN
         qECw==
X-Forwarded-Encrypted: i=1; AFNElJ8/0tHiRL674w9K5vy1QdU03JiurZA+n95SIq9evwC09wqukhEOPMMq+KEyNd6InufFS4rv1UU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1fq+IJmI+lTMgy/0hMP0OQqc5NmztFAUEhyKTAP5zeD6hbtkF
	v1VvVO8p94/WdFh4ts2zZ3Te+JDq7xa9JCuN8BOuu7ORx+dfY+19j3kPPFKDGzJdsSH8bXoedVn
	GrA+xFZ9mvTFPshbSG5NMML/jmesHEVVYFSwC7FOO0PgjFuu913ZVNzfb7BQ/4aBPp58BO6k4f0
	GXC8Jnt9DDSncDFtYIPSA6pXLwUTDEO0X4
X-Gm-Gg: AfdE7ckB7Jwsee6xfTsjgu6kI2x06Qabb0FzIV6KOM5eqHLEH0jCI5aI1NFuPFETzTz
	8T2ITadwm6Br13+8dEzvGZ9eX3BG/gg6Pv9hpggKz76ZRe/ebBKVSnaTEOJfPM0ia2aVBKID1lL
	3Bj2KsZdwLlakwNnGkQIJCmzmkXWKBtidrfsqe8SkNmUZbq1Mfu3+zdeIEXY4spv2a/A+GBRoZk
	brAfy2CdvE2KjXn04SA7SYwmnhF
X-Received: by 2002:a05:6808:c229:b0:492:285c:4dbc with SMTP id 5614622812f47-4943dfd8b2emr7701006b6e.30.1782739206973;
        Mon, 29 Jun 2026 06:20:06 -0700 (PDT)
X-Received: by 2002:a05:6808:c229:b0:492:285c:4dbc with SMTP id
 5614622812f47-4943dfd8b2emr7700980b6e.30.1782739206188; Mon, 29 Jun 2026
 06:20:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260622133540.48591-1-desnesn@redhat.com> <CACaw+ewAhmPYxnQgpzh-zL823YEuyZGDukwAzeDUOvRU9RrWcA@mail.gmail.com>
 <be228d1b-f4f8-4cc8-ab35-717571d0db36@linux.intel.com>
In-Reply-To: <be228d1b-f4f8-4cc8-ab35-717571d0db36@linux.intel.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Mon, 29 Jun 2026 10:19:53 -0300
X-Gm-Features: AVVi8CdsM8o1m1mnm4XRVJ9a4Hx4twvCmdvxj6ov7z9dn3EC7SvcKrUgKnuqktI
Message-ID: <CACaw+ewcs2Swx1EErF9JB3a8Da6WPhXwsSeqbA7F+ZpcFXAuAA@mail.gmail.com>
Subject: Re: [PATCH] iommu/vt-d: Fix UCTP context table slot when copying root entries
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	stable@vger.kernel.org, dwmw2@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Samiullah and Lu,

On Mon, Jun 22, 2026 at 10:46=E2=80=AFPM Samiullah Khawaja <skhawaja@google=
.com> wrote:
> Reviewed-by: Samiullah Khawaja <skhawaja@google.com>

Thanks for the review Samiullah

On Sat, Jun 27, 2026 at 3:46=E2=80=AFAM Baolu Lu <baolu.lu@linux.intel.com>=
 wrote:
> So this not only addresses a DMA fault message, but also resolves a
> real-world kdump reboot issue. When you send the next version, could you
> please include this and the below stack trace in the commit message?

Exactly!

> The change itself looks good to me. Thank you!

Outstanding - will send a v2 with the stack trace in the patch log.

Best Regards,

