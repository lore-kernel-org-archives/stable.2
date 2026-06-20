Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCD940D57A
	for <stable@vger.kernel.org>; Sat, 20 Jun 2026 05:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781934038; cv=pass; b=kBnyporyPio3Jw9379IDuaXqkB7A/wwXS9gy/Z1BURlcYwOAc8BYLVLDzpvZ3W5OQAibcqyn5pu6ECL3TQ63pllZkPr248DamsNgkpHO52hm5SQszRLGqWDz1bq6sgp0uYdiwKjwzWHagQxv9cTceGNICMJYE/nXGkyGra5eXho=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781934038; c=relaxed/simple;
	bh=XVIrocMTbotto2Yn9Y6S6ITRcTskf67l19nQM1UMx8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UEGn41ykHS0b0+vmAohCRhSObdoBpTT3BDfJr6YrsAcFvl7bPTNE5+xdZBo2fX5ziGoqF2gDW0BsZsXPKqWSXCHjaOlY62ztgOF+3j3vxXfFCEze0prPdxS/31P8SGLRuPqXg3Hp6Ag6N3sgCX6lMRFMTyDHxqM21pNmZtxtni0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7qJw/bT; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gBs4L9WA; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7qJw/bT";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gBs4L9WA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781934034;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XVIrocMTbotto2Yn9Y6S6ITRcTskf67l19nQM1UMx8g=;
	b=f7qJw/bTJIxabBZZI28uR8FlUiRzZ+JBWlOPB+DkbQLQsOD8mwBTeIhrYPRG+6iz5DnIwB
	ViRT12kRbUHM7dQTz41ugMjDp9ZMmeoO5DVwzv+9xtRjW2mBUsZUQHAqFmyOeLMYbjiLV2
	fStHAjV/HT0J3XUD2BlIzxm9073TeHY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-r5lOtexKPgafmMm4pI8iWA-1; Sat, 20 Jun 2026 01:40:33 -0400
X-MC-Unique: r5lOtexKPgafmMm4pI8iWA-1
X-Mimecast-MFC-AGG-ID: r5lOtexKPgafmMm4pI8iWA_1781934032
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4924314568cso11494835e9.3
        for <stable@vger.kernel.org>; Fri, 19 Jun 2026 22:40:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781934032; cv=none;
        d=google.com; s=arc-20240605;
        b=WGWuzLvnLbSEuXipIGzCY2BxPI9HcDIZag8JubqcOhBJCCARgMPylgh/XTUldK0ve9
         w9ijqhgc9jXzBXOszn4Ajyroin7Lfhks8HG/XVymmieIDyvK1EOt8rGoGsRHTxOh86eC
         9VFvRkjW8GeqxOReOx4n9gSQzssiywVcm6h6ZVFvPfHLj/mn7gqxl2jWhdICSNqy53Hy
         f3n+BcpNQQt76DvZiNYO9/J6JRC1OeG47UJIkjGSH9Wpf6rmnwGniCyTJVrWKd+JjH4i
         cR0T5ZUudlZYFZ0UkprcQsbT/qnscw9hBwnQGTZ8t7S90RVENKVcSQ0fOX1rwOONWv2F
         /TOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XVIrocMTbotto2Yn9Y6S6ITRcTskf67l19nQM1UMx8g=;
        fh=SvJjNpwVD9hp4p/JYmn3bH5u0MKdwNDlz9PRQZN7TgE=;
        b=J4dAJK6SQ+V2VTY8c3GCq1iw+WBest55LrB2EVCVUncLYGqIzDwW+XtcoOcfWCJYN8
         SQOrzbMH1euHfDWna1/4eCwaaumojtyoGJi6oMJIG+NhOHcHC2HzODhtqKoRNVDePRdd
         oTuyhn4GoXTxUnpjgJz7zoJNQ/G40B/KS5YuSoUwF32bxwkiiUss9aLl+zDYF4ueddyO
         FdnVHAlLgDfN1T6GMvB4jjk/xGlVwFB+/ZhVAfxFP5+FPnbmW51IBi4BRZktMEwyFHLm
         kqOQuZH6zHfJMNIK+EmNxHc10ZodYb9omzWHekPe1LXHt2EmefSUYInqfXaVcL11b/Rl
         6PBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781934032; x=1782538832; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVIrocMTbotto2Yn9Y6S6ITRcTskf67l19nQM1UMx8g=;
        b=gBs4L9WAjY67fM9XLZT2WkkwmBtCXEmznn7Y2DUPlbjOUsspqFuiUEfxS+occMv/8h
         kciRl78Uy9i1rCugWq65m3sv1Y7mwNzZNVIG/MS5AYRoiNEfMLEx+zTVauTaWS/SYMaz
         DOcvUsLWMvC2BNKTs6SkNsXQTu1ugBWGiDyueFziEb8e4pfhJS5sG0XV1MiNqg2gkLk3
         A7i8LedrvZk6ELL62INYp0Qa9berGsLXUvxpdZkCGN9zv05bwFtuKVKp5iuux8cecYog
         INO59fxzjMw1PtcBYNlNVkwuFrjmauetQExL6DIEjmL9hTdy+nrcI4ncpr99D+kiTHTV
         DTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781934032; x=1782538832;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XVIrocMTbotto2Yn9Y6S6ITRcTskf67l19nQM1UMx8g=;
        b=KFyjSucXTglggQmQPi/6/2k9b/ebMqARUdKuxgE1VTe+opcwvAsNccumbPRCqbPmHx
         TdxBTFWmHZ4Rljk1J8183GMDlQ7EMR5q1zS8qzT/mqBHimMg4WbnwUp2qECKvkMnWLXI
         8gHb/wHZKxAzqrfM/YqUHFp0tY6szafxn3MLOvDRoAi5zXoWOvgiHWEUgj9u3PbR14J3
         8pxsuUEnAHnKDdXIwsO4X+p7yAIOnbUePFNgcqhVOAn1hruku1ZDOAifq0F1dpIyCArk
         YCSXlBv6M0oSrRTZoS9okSN8X/MG0SEAQErihvTGhf53MtoWNMwa+v2rdYDycQNi5xNr
         hodg==
X-Forwarded-Encrypted: i=1; AFNElJ9WtC++nLM7gHMaVW3iJ8Fg87YK8BZM9Ecix2fYq7PXTqbxewj01cwF7155t2KPw2RX982bPtI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4diwwDn828vSrFknYdTwawW23F770Fvz/6hLOhC8ezM8wh/9e
	wn+KNtB69cIhbFyn7VEmka+mkZNeUpRCAHhDpnq2ubnYmkPC0STyICh7dMxPwYZ9ctL4e4ccyD1
	YocWvZoKDT9BQhW0wxLM4YYhg5Ekse6j7hT7aCkEKd0xJV23ZF4cZdgbAe/BOtVyczJy/xpKKn0
	G/cijmbrQqSaqQV8DWuLLfOY2gRb5oyJte
X-Gm-Gg: AfdE7clmAK6GVO+dpkVp7tzHmz9RamGFZJzZYIHQGhytBlr4OQgZFNMYiAjt4vd/3d+
	grPiJ6dqdmTwLNu6NEvfaYv1E5rnG4Nk7cQlMQ8NYus45+0SFkofOZsaCfz8EdHoyL9m9/SY6/A
	ENquVu+caoRQlUp4AVfpaBtUuMzj9SmIfAlse+J0AtGN0BaVwKTDuwQqfrPyi4cX04WNKmRMZsg
	YFe3oGTtZhT/T7alWpKfvB+KO4CQr7NaqEfqkHgpB+25AOY/OBY2lWx4FUAiIRLZjQiLdts
X-Received: by 2002:a05:600c:5020:b0:490:d946:47cf with SMTP id 5b1f17b1804b1-4923ef47d08mr108763455e9.4.1781934032080;
        Fri, 19 Jun 2026 22:40:32 -0700 (PDT)
X-Received: by 2002:a05:600c:5020:b0:490:d946:47cf with SMTP id
 5b1f17b1804b1-4923ef47d08mr108763315e9.4.1781934031793; Fri, 19 Jun 2026
 22:40:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503201029.106481-1-pbonzini@redhat.com> <62bedd23-a9d8-4c05-bf39-662c2d37b793@redhat.com>
 <ahlQQlD1ygfiQ3bG@dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com>
In-Reply-To: <ahlQQlD1ygfiQ3bG@dev-dsk-doebel-1a-7b355d76.us-east-1.amazon.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 20 Jun 2026 07:40:18 +0200
X-Gm-Features: AVVi8Cc9pgh_rugpxF92QHP0_KXWWdqXna6GpieKRqAEmkG8WgK-gTKAo9E9NdU
Message-ID: <CABgObfawkiKRDz0to=oCjo1vygVAkHyZXAzpsLWT2GXwkszV_A@mail.gmail.com>
Subject: Re: stable backports for "KVM: x86: Fix shadow paging use-after-free
 due to unexpected GFN"
To: Bjoern Doebel <doebel@amazon.de>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Sean Christopherson <seanjc@google.com>, Alexander Bulekov <bkov@amazon.com>, 
	Fred Griffoul <fgriffo@amazon.co.uk>, stable@vger.kernel.org, zcgao@amazon.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 10:39=E2=80=AFAM Bjoern Doebel <doebel@amazon.de> w=
rote:
>
> Hi Paolo,
>
> On Tue, May 05, 2026 at 12:13:34PM +0200, Paolo Bonzini wrote:
> > I'll get to testing and sending them out, but it will take a while; if
> > anybody wants to help testing, I can provide my tentative patches.
>
> took us a while, but if you are still looking for help, my friend Nathan
> and I would volunteer to test these in the context of Amazon Linux.

Thanks,

I placed everything in the linux-5.10.y and linux-5.15.y branches of
https://git.kernel.org/pub/scm/virt/kvm/kvm.git, adding also a couple
more issues that were fixed in the last merge window.

Paolo

