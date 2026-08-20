Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C803B42E7
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787255134; cv=none; b=RxITATW48Fi1o/S/sfK/PrR2BGNNTMQ+lO/IknwWSAI63+Mg2HRYbtF4KKVIuIKS8g4uBZjDmuc5Tx39dKvPx4aNjll9Ua33xAiJQFocXR03nnG8A4QX3j3B/vm56cNiQp+ES13sUpF6rUhBhPYsFomxyau5xvqddZ7aeWDlgMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787255134; c=relaxed/simple;
	bh=OC516aLBGgP7OfSMr8hlKfRcSB86Rj37vkXzqqMuCP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bsfb4O4xTaj1Q9T2ZtF+rtr8wjEC6Nzr4qg/RWTfshLLPoM49+u+O3mOUH20zQ01RRbDKFIy1nf9aQ8Vk6Qgdcs+eM2ggorYewXrpX6bLz9WLMPuZtmupFpZHJ2rwjdAYuLb92M2WhI9MaVe45VV7dR31APitkB50cNR366pA+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=EF6/dsnA; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="EF6/dsnA"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-45ef699308eso93725fac.2
        for <stable@vger.kernel.org>; Thu, 20 Aug 2026 12:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1787255131; x=1787859931; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BxQ9hW+X3+brrrwHxhFqtuGXtqhzMYPhRXGIT5cef34=;
        b=EF6/dsnA1aLL0PNFTtD7Rwv1p/f+Y+L2rSVmcrmlD1jGW59eLV4FWUuCnyWgH+/b/Q
         PCfc9ZDSWz6Zw1o5BwAd8l+uh9Z9Z27CyY6On0sxu9ZLdPWBVclglFkDyyOKFHagut5s
         1WG1W5oPZO09iaaFI8R+SoLK4cd57yD0AB9Po=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787255131; x=1787859931;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BxQ9hW+X3+brrrwHxhFqtuGXtqhzMYPhRXGIT5cef34=;
        b=NvMPr/dcdn3uLmas7SOPjk/AdieOI4tpAc2iZfr8rnuunnlErVoUFVbQzy3hjDIWFP
         zf6EQPAc6aSEfKMTQPLq83VrUwFE1l2l2uzbgPlid5wekwySdYYzO6kE5LKvxitfo4oE
         +QVqm55sELjMR70g95TxV4dhsRkyMA3ISkXebz0NyqCr1SxP3ItwdM3OF1IuH/jRQ/Uv
         Ws5DpDaB4aff18FIDNexJg9/FcGiVK9AtCFQG9bNz3gEOa/5gViuHOARlV1CjIJo+9Kg
         151KwIZ1/0KkI+qvHYlqycw8HZy637OyiCCmb69NixaSCzLCuM8BCPDTggy0bQgnfZ2N
         CDHQ==
X-Forwarded-Encrypted: i=1; AHgh+RoYP9PoT9Roc1UvkjKPVkw6x6HUADJoh3Cba9KqKIvRDhbpRaYJQE8Zt0qX+Jvvqa5l49TIlYM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUC4aJGI2OPUgqkWqDOnxM2YQB9/v1TSfjd+Ti/RJcYZ5Rhgkx
	irkB1UckmMw3nlfEmZDfDsp85iEI8eYOhwlglM3FwVbnHkkfYRfHLzj/ydLiNoASh+o=
X-Gm-Gg: AR+sD12eZDtot2ubnNGdd2CqJj08d0uRq8rPsNVN3bkZ3H/LLofXIQzEs/GS2kY6KK4
	JHwchV28nhdj7Z+PgabsdP9+FDYrQz5DoN4jB+A8VjezH56WjhBuvi3lliT1hFqQtTzFrkWDHYq
	mpqQJH0Ro+/YQu/sI4l7pwYfhuhu0PCeXD/36TQ4fy4K2MW384mWn6YelfwiBqQ5XllaabIfhGK
	n9J9TY4EzfsDZqwi+6FfHLHizijFh+ujjP4YOrA6sStXXAunvog63Y5Q/6Upyd4/c5/yjfHpsLO
	nhjQN+31rdNtWFsrxoVS04/6JFmOA+W5GOnxZY/vuiZBRpTRtb9Zsz3e0lvS3wVLfYtacAzfcxn
	yPSPGg+y+DueW3XcnS2FSccV0sbWnYdPvOUlC0chxaqsp+DKIqVBoos70mdBcc/9Wh/lpL19ge+
	IHOAqoIKiiiOrv8EcSzo76yzePEq1ooqa/SDRpVPuSeEf9PEeVdXjRvRlaq200EL9V1BmgJXXxL
	uM1x6C91XrnuQhrCnJqS79gCBgBCq47ekrajRbolK0=
X-Received: by 2002:a05:6808:13c2:b0:4b2:6ca6:9cd8 with SMTP id 5614622812f47-4b2ef25db7bmr543975b6e.1.1787255130643;
        Thu, 20 Aug 2026 12:45:30 -0700 (PDT)
Received: from com-75606 ([199.47.143.7])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4b2d6ce0c3dsm2392184b6e.11.2026.08.20.12.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 12:45:30 -0700 (PDT)
Date: Thu, 20 Aug 2026 12:45:26 -0700
From: Kyle Zeng <kylebot@openai.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Muhammad_Hazley_SAMSUDIN_from.TP@tech.gov.sg,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net/packet: defer vmalloc TX_RING free until skbs
 finish
Message-ID: <aodZVp2PqHnEiLV8@com-75606>
References: <20260816235646.76500-1-kylebot@openai.com>
 <20260820124253.1fd25425@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260820124253.1fd25425@kernel.org>

On Thu, Aug 20, 2026 at 12:42:53PM -0700, Jakub Kicinski wrote:
> On Sun, 16 Aug 2026 16:56:46 -0700 Kyle Zeng wrote:
> > Fixes: b013840810c2 ("packet: use percpu mmap tx frame pending refcount")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/netdev/20260721015824.45829-1-kylebot@openai.com/
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Assisted-by: Codex:gpt-5.6-sol
> 
> Kyle, we're missing your sign-off tag here.

Apologies, here is the tag:

Signed-off-by: Kyle Zeng <kylebot@openai.com>
