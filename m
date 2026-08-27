Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B183A3812C7
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 23:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787872370; cv=none; b=kMWWx3psMi0T9a9s5Na2Vv6pZHFoKMreIhpm4a/aAh5WOko59FjQFYYgUMXR1vMMc/WFM5rwEfH6NH1P5WRaORu+Uc5IbkMI9JYC2CyilW5k7hqvGCVca1sTLFknQbAboIIU6cnLrYgjHJsyYak3Grocs0OnEhcRwsDqumjVraw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787872370; c=relaxed/simple;
	bh=W/VboFtsniwlT13CzTXqyyKAo6bLiMCk0pQp6dNAoJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UY+NfZp9kWGsgs2pAGffSG9VuH4kyb/k+sf73Mbb9orFWxR0LheMaPl3hSWwUBobRK7VY1CVjQ7Xnh6f/XjKW7rX+Y1FcdT/On1+wspn4Se00INYxTPZkchZ41w1WbtzX/EF9nlZioMQzGO+//oAvomhkZy/K0yRcVYZg/ZXs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=buVTuGqq; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="buVTuGqq"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cc1d57602e8so224440a12.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 16:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1787872369; x=1788477169; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=owiJggVEjqcjWE0DQ/s7zqsjd4JZVI2c130pUmNZmGw=;
        b=buVTuGqqD47M3f4PAj6OgpHPxdbihT5s/5hK1VWsyxLTmynWwOzbsNBTFhFF/2qytx
         +e1pZxOkuKAPI32nBX5rlyFQf1jRTdQ1LWz1tWJMNC9bVML4yg4a7HdndvDimhmhgAN7
         aASBsn69NJiuJu87GwKQpc1PR1TE/LH9DtvePRC3Wpz7rPB85HCQpAb3gzMAwvtoqlwb
         2g6QrdCmkv7F0DUWwFR6C4hiGRTYFeeNKPJtbz39jwKtno5Pd3207JdvRmtP0jxYVjoL
         BeOKNjOOsFzmOe2zicucdxR5wphaV/hzb2wNoVJZRsOQxxfBMM5c4Is6hPrPXh2ajMWd
         FCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787872369; x=1788477169;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=owiJggVEjqcjWE0DQ/s7zqsjd4JZVI2c130pUmNZmGw=;
        b=QA8rlzPVP90DSxxkhvmu+rqi24Azq0cbgcWregjrCh3xJXfiEv8o/9mCe552B1B0MX
         kUk2vcAdEkjjDRHBg6PgcC25lRRCifNwixE2vjap5LyhyoZwIsu5t1VwLntyIf3KKc13
         7aOcjomVLisrO5IKrqwBU+w2I76v32xKGluD0Sw4pzRI4+jzmMSKXocQSKNLnwLK+9sN
         muo2h0PCBCA41DxAXaKQcIGbODRoIoYX0loZd9WBub7AozDLXb2A7+St7U4NOF3ZO5XC
         EZQ5gI/UYrdUXJzQVm5jMZa5dx/+k45tAh5p3+KW6o2ilBmx++x4dCjMEI6Z9qDcSifa
         2QcQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr14/ZPmAYbagaAMLRyeb7v1LfGWp4W1BakDuQo7POvck1v+HGceLefXDWWBxAAEEeY2DkRdSY=@vger.kernel.org
X-Gm-Message-State: AFuF++kujRWH5DyU34iZjiBbPog+hUhRqOLt+cB82HsjuItNkk94/7f9
	lOB+mrmogMpUYIYvvCeK7bj8fbyTzWFwxUvGI8gEus3gxrZinK24VYjdBDuC7pDHcSA=
X-Gm-Gg: AR+sD13zo+n4w6hEIxgvzTfAUbdgMsuX1HCRTjBejXDNaQ0TCrMxa9kMN2scrDH17jh
	f8mQClIg7pie+2z1yoRAepjEwVduowMzotXrzF6DtbjP0UOJaMvs+8GEBGKEBG/XfzwjsBKPCRr
	L3zjmV5eGO/P0CE963Wq/GFc4sGUiRBRA66pVR4aRPJKVxXxNnGhm0B3PMQHVGZB/OOJmfoPVYb
	elMo7zxVox+5N6eBsCSO3Q3d+4AVtZl8anLSWSmb9QSqAc5IIh2I0+orTIS464lT0IlPKi5wT47
	k/56dgCAv908RnnU3rEMuOLz4SQhQaibmub/ReNc8G4Bb8vcTgR5GEiJPUuAJDWZHHWbgaDLBYH
	jmRSLGweeV8ZxCP6MsXfYvEpl11v0HF52keLD/7pMy1rOB3b8Cwy2n+nuadmeRsHF/gJ7O6Bf4e
	T+/scSBLXUt/OaqrsqJbrDdoK4XPhKSmqJox6eDQPs3QI=
X-Received: by 2002:a17:90b:380a:b0:38f:de97:b06 with SMTP id 98e67ed59e1d1-396d0daf810mr4835678a91.5.1787872368810;
        Thu, 27 Aug 2026 16:12:48 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0d3c9e4sm4598254a91.2.2026.08.27.16.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 16:12:48 -0700 (PDT)
Date: Thu, 27 Aug 2026 16:12:47 -0700
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
Message-ID: <apDEb/LIqcrI9LoV@devvm20253.cco0.facebook.com>
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

I see, OK.

I suppose that means I'll have to resubmit the v2 over again in 24hr?
