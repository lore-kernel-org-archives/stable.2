Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478C23911AB
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 23:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787874068; cv=none; b=HuO9qH7he/gBdzGKudwhQoGRh+lOnx+CYfu9k1Xw1hYHc2wMQuZDsod7ioHmdHHm8Qh5EBIyPTYBv3r0PtdBe+648rUfXRbMIHl8eMxkMYPL9ukkaF5I3lkW7ObyeVlcYrnK+ooqrnwpDWRFgDgn0odSxboClR8vVZ27mBUZLaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787874068; c=relaxed/simple;
	bh=VhXID8Q2Dlk7SGe+8uD8VtqeZ11RIRSkFnVIvMqoK1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M14q84aEIEXqc7KG4/Nc+fZ3teRFsRp+F9LFv4FLG557MRqNeTDeX5wQz6NmVCzOdVuoxpiF11ifHPcDa8JUzr9iTw+7SlVoeNmRvBCaSUU3uc8oLT3SG/1SkNr2fghHSk1imX0ypv4tFzn1QNBwvw1L4QpRz2nqmSom4rNjJYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Wj4kbHJr; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Wj4kbHJr"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso602149a91.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 16:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1787874066; x=1788478866; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gAjqfC0SW4nxG2w1tJx7WfUnmE/BSNkbt+YGxZxti/o=;
        b=Wj4kbHJraKww5MW0qB++UX3yBLjeqjvLWC5TVjCxGn8HsiYdf4mXM9gII73C9GbAER
         So4Pm+xsD4RXICdYcvRJ/WXMpDNISuAfJ4K6uz/cYlEjg7nR6zQKjfSqOVc07Kv4eQeD
         dFbXQfRggl8iWyexbPVw3y0dQsY/uLA9k+XNrS3VDeWWKvbsbIIuXcCkfnA3/PO37+IQ
         bMeFhCk6K2LY8bY+rRIsmD/sYipNHj28/hsR4edJrHeyn4ECBgPoN6wpLc1xW8Z2+dGo
         LnbEmmfrfrbRN1VvlM9av03JAx6YCJX0os+4A66yIDXfkLLZ1NdlaQNJJuuCpUukCpfu
         64NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787874066; x=1788478866;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gAjqfC0SW4nxG2w1tJx7WfUnmE/BSNkbt+YGxZxti/o=;
        b=RCuO1ckSHtCU0SyAW2JQnDlp/MD2K+bOY9m37ldTm7g9uRzUgJ0E4ewftDQJNbyrwy
         gQT2KPu1AZ4RnyS/59rw3apTAIu0+2hX/TOH9o42VmKBTd4RkDaWSBj0ZRIFUEHiYR4s
         g6OZ7Z8wgh7Yei/ERecL342K28jdpyZw+DieH4fHZrb/zP2DDEhNenlHFn4m06tS5V1V
         zdIleLWySq09kwdAzd480muRueIBRz62/QIfjGy9a7oOEIM4sLn9x6+3kHIRLlsO1USo
         C/v7jwkBNUsYFdzmPebFPVlzKYDYZNQfMup5IUVlQ4SXkH5V+aE2H7ntnbWsTV5akbpm
         tQNA==
X-Forwarded-Encrypted: i=1; AHgh+RoaRDY9xC6otfW88pbiKe6UVExSTLMtirV/z5LSyX9hzY8eqLC1GYSSLT6Rj/apTTk/NMd6Aao=@vger.kernel.org
X-Gm-Message-State: AFuF++mMFY/+AvNyD0VC6z7i8BOyK3H5JYdtTsmH5Pr8PXtnhnUwbbWA
	KCJtRcFceluHxkH42Pe8DO+c9q7o53ADPRV3umWu+68XpDGs0+/gAm0cK5K4Rw3mqMI=
X-Gm-Gg: AR+sD11rGwwkEjdO8hRpOh9CDb+ZJo36Tr/Ic61qdFD6MIu1vXl68/iVjLAKjmm8mWP
	d5l5B99xLb6qm5qyZRdTl6Xu0rf591hCw2jOM6saE3j3Bn8T5Cllp4jYiKqzMsS0pRPiPbwSkO5
	RSFl762cIMH1o/PWV6JGCyevW5Ku2b1LjgzUGg/kw3lQAqXL7ZMbrZN+XZhJxnwTXfGMKZ4KPNh
	8GRyyjg89GFENc26A6KrIAU6Nrj8cVWmXQi+PP22bXGQJM2wuqqcRzde90DaOub0gi+BaYa1XQ7
	jCrJ2QZxWXsXgudtKGPOsp6Z/RlBuRNxlLRfmbjOPOSxijjoDOTKldjDRn1lbhVYay3X1RLu+8y
	SZRqeQoIFbvkvySwGd/KHiyNQanBL5WERB7lqvivpWi5uB4/2MVYDK8Vc2YKOecF3hNWe1kMAnL
	y1hxLknKFXcvJCTvOSpFB92g+XvFlXf3wVZSS5wsYLmQ==
X-Received: by 2002:a17:90b:51d2:b0:38f:26c7:165e with SMTP id 98e67ed59e1d1-396d0f8ffdamr5528045a91.9.1787874066635;
        Thu, 27 Aug 2026 16:41:06 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b1992e05sm4677116a91.15.2026.08.27.16.41.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 16:41:05 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:41:05 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Colin Winegarden <colin.winegarden@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org, raphaelcf@meta.com,
	stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH net v3] bnxt_en: Bound SW TPA IDs to prevent crashes
Message-ID: <apDLEbEu1PLTGU+f@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Colin Winegarden <colin.winegarden@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org, raphaelcf@meta.com,
	stable@vger.kernel.org, llvm@lists.linux.dev
References: <20260827185700.2157164-1-joe@dama.to>
 <CACKFLikJiCdjej4ezF=U16Leef3oAjSZGQAyetRnF=nLRvUfZA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLikJiCdjej4ezF=U16Leef3oAjSZGQAyetRnF=nLRvUfZA@mail.gmail.com>

On Thu, Aug 27, 2026 at 04:07:16PM -0700, Michael Chan wrote:
> On Thu, Aug 27, 2026 at 11:57 AM Joe Damato <joe@dama.to> wrote:
> 
> > @@ -3831,6 +3834,7 @@ static int bnxt_alloc_tpa_info(struct bnxt *bp)
> >         int i, rc;
> >
> >         bp->max_tpa = MAX_TPA;
> > +       bp->max_tpa_roundup_size = MAX_TPA;
> 
> This is strictly not needed.  If we return early below, it means the
> chip does not support TPA at all.  We skip allocating the TPA array
> for every ring, so it really makes no difference.
> 
> BNXT_SUPPORTS_TPA() will be false if we return early.  LRO and HW_GRO
> will not be supported.  So I would say it's a false positive from
> Sashiko.  Thanks.

Sorry, I should have been more explicit in my last message: is it worth a
respin to remove this? Unless I am misunderstanding something, it's harmless
and while not necessary, might be more clear for a human reader?

LMK what you think.
