Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121BA488763
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 17:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285557; cv=none; b=PMDRuH+TLvqVGCpQWXHEsZ0ym8wmTbfA+MQ5Hn1Y6/2rE7hj+apauJbOdGjF875TStbHL6psxsbBMPhDaRqitKH2W4ifJ5nrnAvst8XplwuRSZOF+dRw24sw6AsztqDyD+zaTp4Hu6YQCvD8d9UDuL3AEXxnD6ii0pEnu7aCfKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285557; c=relaxed/simple;
	bh=upOZfp7nr+JUKjA+9XgwYeougAECpv2MBCBLML5bTbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvI5efRbnmsCPHxjIAJU00fcBJXyH21UkIUa4RSmG9skTpY8knrz1KhKYkncbzOJlEKMQC3U/+pynvFhCuek/RV9Py5fprkltJHD9Kpygp6RP3BLcXocZWzQG3y4+qyJIlORe8La7s+tvAP6gCYTMprNYQSkA3XBt8ur/UJSVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=megAzG5+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="megAzG5+"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d72ae08fa1so560155ad.2
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 10:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788285555; x=1788890355; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iQGQ/jT41D7XhkwOcvrUM6Q+rqlIuyJ98icVtqutpDY=;
        b=megAzG5+XJ3TWhRtqpQVVLrsWuMF6Hgo6qrrNkCiZzt5Z3dI40Cds0QAMZtoE9SKTM
         JKtu5rsBifMmMvWFB5CkGbO6vcf4cb6Lu5aKpQQzm/iobNI3rN/EVfMNQVhVtTL4TfNw
         pDr7ICtcdlzQrjNfXa/qMu+jS0F+VyxoeEpoqIs85SmaBAwEHiHv5zKbEiBl/PH1lhFW
         /DHkOwiu2065z4fH7nnYYgQKAlnZMsGFKfobpKS3gYeu5xSVLfiWkW33KcQUKE6jwscV
         GfkNZHBvcUwmg4UQzCXsJli5AY4FnqBmtkbVsQGd6E/02xbQCGnVrSBfr+Zka8ssTpag
         AXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788285555; x=1788890355;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:mail-followup-to:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iQGQ/jT41D7XhkwOcvrUM6Q+rqlIuyJ98icVtqutpDY=;
        b=efrqRAzyRqeeReL2GM0O1C2uQGRIv7I6+okn4G1kIMCLv+tiCT0Dssi9WaRRwCnwjM
         /6rQ4KWmFluogEm1IgX4HCaIkistUxozdTympoPKOSHiAIwB5ZZl9xrUDbhaG7yn9AKz
         xmMaXtXxgosw/Wn23KyuAgCE9hwvubpSIzR5A+vbAZ1/WMcuQdIGfrllSkzj01XbSN1g
         NsManMroYRsZDM4ojAp2IzmEQke6j172NPzvHScXb6TgsWuCmjJUNGLVcQGoBpWIgpsP
         GiEzWHI3+oGHXlIrQWwCYsW6h5C34jE6o/SOFrckb+wcl/pGeDKw+rgHGJ3LrSpbFdQU
         Ys8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzHfwAstRrdLNZeAAWdsNQLBapVD6pQHBtjTIGHBJoaqr61ZudRwH4SD4RiwYux343ACEEzjAk=@vger.kernel.org
X-Gm-Message-State: AFuF++lfQZf2hQtSavQqk+Lc95TUBU5jTtoykm0akqyyGR3u1Y1O0BeQ
	R3HBPSGPSnUw+8YoZ2CyahKiTfYhf0mI6Nt6oM+I9b0dpDziswh89RZiyI2U/a5U0zI=
X-Gm-Gg: AYBFou1dxDa9+uZRjaBrLfVNuZxDPQ6bkEWff3VgDpseojvo3nq+yToHpnKXFfuWQCD
	6SZKj5rnl+XW11EMeGMFFBtBaI/n4pVkvUiZT1T6dhgBGABlVD7/KqLcFw0XCZpQXd3yEbpNL4P
	nMVlVMLeLedorwBcvIAwyR9Szu+2nOO+TNQGHanlPPSztKMG2Qijbn3ATmXj3dPbSHNGLTIn5XC
	vR30XGsrQydEHrUnUHPQ9UHhnUtQWVlRG+Rs+ytCzbS7i21MwlC879F2LdZnEaBRMdh6Y/U5YC3
	mTe5uQULi7Vzf14E9P/hExOqMzF0ezN8iC5dJyxZe3QPjyjS47F37w2+8192P13PUOawKHz7+J+
	uAgadzgQWKiMQGkyCSkkJvR7QBopWC+JAhDWBatE+Ed3o+lxeU93rZZE4bCYJiqzFeN650K25qF
	zsBBd9pNo3Ph86EZE/P08bo6kWxznI06x52ChiCzmLSg==
X-Received: by 2002:a17:90b:39a3:b0:38e:bbf1:de3f with SMTP id 98e67ed59e1d1-39907d659e6mr14262544a91.12.1788285555109;
        Tue, 01 Sep 2026 10:59:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae3c1d85bsm768983a91.13.2026.09.01.10.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 10:59:14 -0700 (PDT)
Date: Tue, 1 Sep 2026 10:59:13 -0700
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
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>, horms@kernel.org,
	colin.winegarden@broadcom.com, linux-kernel@vger.kernel.org,
	raphaelcf@meta.com, stable@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH net v4] bnxt_en: Bound SW TPA IDs to prevent crashes
Message-ID: <apcSccBgd3nwrjvt@devvm20253.cco0.facebook.com>
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
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Rukhsana Ansari <rukhsana.ansari@broadcom.com>, horms@kernel.org,
	colin.winegarden@broadcom.com, linux-kernel@vger.kernel.org,
	raphaelcf@meta.com, stable@vger.kernel.org, llvm@lists.linux.dev
References: <20260828190900.1767611-1-joe@dama.to>
 <CACKFLiks4ueY4faqOiu9-Zk6odEdNL1Abyhg+giOE72iMe0Z7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLiks4ueY4faqOiu9-Zk6odEdNL1Abyhg+giOE72iMe0Z7g@mail.gmail.com>

On Sat, Aug 29, 2026 at 12:20:26AM -0700, Michael Chan wrote:
> On Fri, Aug 28, 2026 at 12:09 PM Joe Damato <joe@dama.to> wrote:
> > v4:
> >   - Moved bp->max_tpa_roundup_size init out of the early return path and
> >     documented that TPA is unsupported there, as suggested by Michael.
> >
> Thanks.
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>

idk what you wanna do modulo paolo's comment on this thread.

i have a v5 locally that expands this to 5 patches which should address most
of what sashiko is upset about:

  bnxt_en: Bound SW TPA IDs to prevent crashes
  bnxt_en: Handle buffer allocation failure in bnxt_rx_ring_reset()
  bnxt_en: Propagate TPA buffer allocation failures in bnxt_queue_mem_alloc()
  bnxt_en: Don't free the live ring's TPA state on queue restart failure
  bnxt_en: Only restore LRO if the device supports TPA

but ofc, who knows what other stuff sashiko is gonna find if i submit this and
how much furhter we'll push out fixing the original crash.

lmk if you wanna stick with the v4 you reviewed as-is (and i'll send the other
4 patches as a series) or if you'd rather i submit the above 5 as the v5 and
get them all in at once ?
