Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7FC23BD05
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 21:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785880475; cv=none; b=Eix1FEz8Zi3Y5kSL0r3DFthxxA4f+wzmURb4+WhtVjxR0/h6prDPK7bhBjiN+j6ylpKa58m4f7Vpwghxd1wuJN+S5ZmFHKHNGEWMFHW/KbUVGtlhKIDurlPFbQY/17IQQ+kXX1juwyK4vdR6kkOVwid9J3a70XCh6LOZLTLyN8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785880475; c=relaxed/simple;
	bh=IuHu+i8ykBGDsG06yppIdROtaxj37qLU5bgE3hYFvEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gy2L9Mg6SEIZRhYqI3qv1RrLx1z/cFWHpavjmXBbrjzVxIYyBgMF55U8gDZXH7oEPfjRxVM97bK2gbaf/DT7BwQHsoyrMymHzWMPpK98vk/Cr7C0h5USTrDX6YWOyULesDbF06qucS28yfaeIfxkVfKILvDpoXZq6XIJjMLEqLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MA8HX4+k; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MA8HX4+k"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so2526695e9.2
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785880472; x=1786485272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9zdxL7pbRtsTEV8EC4r/5IgaNc8hBDEJjb1U6nqESgU=;
        b=MA8HX4+kHKsiGKD7eO0zjOVoFwCulkDrKhsm6y+p6MbxId9Ud8I0QCjHKAZrY/bnQg
         LQlnJhh7PZTgK/Nn3snKMFHXn6l9+Lkv1OgGUpICs2v1A6EE2CXvpI/PvCkYJWwcCB9U
         PXYeffyYqWXIQxToIedSsX86oFVJV3s3mSm+7FsK1R6ADzqGqCKM5pOkHiHcsCV9zCv/
         hW7AN8zEabgPy4gnUTMf2Wg2+9TyckfrXMMAf9nwkWZwpi4dSR9/BbcnF3yBPnx1RHzF
         v+LX2TGQ9DPtM1zvQiMcIeoSQY0WZiG3Nsi6Tnt3ABDoNE9WJQdV6qNK7Gnh/uOFbFhl
         JX0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785880472; x=1786485272;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9zdxL7pbRtsTEV8EC4r/5IgaNc8hBDEJjb1U6nqESgU=;
        b=NPL4JXJAnkgkrrb+RcQChnGKZi689CutM96n1YwS2d4Ual8VS0d1WYh+30kNbEDZMi
         /5b1RJ5xqDvYKG4fupl3iJMzxi+hyqltabBy4rW3IhIdQ59u60pXlEMZ1TKCZ7omT/9L
         K6B5oub83gqjAAICGL2187RU2oMW2AekuyHB4dWfhVyuEpPiov557wMduhOhRq8TH05i
         H3JIREpW0otP/omnuTre0wU18YHQW24xGndHhzTfoacGV4pdJEi2dPijhSu+yFMSlUzC
         m54UGn+ZPUmk3FQVXNLZLlHVuSQYRsGam6VNJeOXeFDKMYZYToROWPcnSkqeZ1Ns+AwK
         Ruxg==
X-Forwarded-Encrypted: i=1; AHgh+RpjNlhP+grs8BD0VnfaDS0HAnWPwWFcTBS7GWtuqATa72sV4HQdt7OpmpndMxuyupCT6Y020sA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCIM5sJnk3Lk4wv+a3MuEudxS06W2myGbol9DxGCxryObKM1Ci
	QgVHB4hn8GHr3Zcn6MKRhuOesvc9s7bst9WxIUMQJol+B3mR1GrmzwOK
X-Gm-Gg: AR+sD10gmLuL5mL6Z30hL+pVdk/GpIkxwVgGtc9FnEd1IOMU/MAhq+QaNfYP+vHiIHQ
	REi6BS+5z/SFuc0atVBxoFxp855CuAHj6VXV6aLIMj2SVu++HxhJY9oCDPKksjW+yFeO1qdR3h3
	/rL1k12m952MoxHrTOIKexdbu7J7pdy3MOyLcQntHMxctwErh1EvTGcjQM3y9t2hyg4p/U8pv8S
	TfXBIZWQvhmsJ0seVCKnbwrhClxFXtbxaLJNP/0AzOkRT06hgROTgnKpdEJTwJKevzZMeksiNX9
	TG95LCr3PkujIMZaZ1JLUM4Qq05k//XmSv6iWHol6/WEvtFcz2acQRl3zmWH794XB7X4/xLxGYX
	+KM/F0UZTgwvw8fkGLw/j9JKcxyGU3R4BvYiwbwFqPGD9Kfs/VTTM9EYcHhEDrg+z6eFc24N/8u
	S+qmqZ/FUBUweOWfGnVMo8zk8iXoHC4TOY7WaiHxKHfhtzv37NSvBuAgSOKXO7pdzMlRLfPcYtT
	2Y19rn2js79Fy231vSW0/F7PRaAN8cX1InZ3ZIjhGxwkyt61c/AhV4rMIux59T6PJBeBF3AKmxy
	CcfDWOolrKgktlaC79LsykqH+mgwm6s8ZNiCbRWceBk+ZazsJMOyViOLZhjBOk03yWaX1Ww3PWu
	zBq6KbQ==
X-Received: by 2002:a05:600c:3589:b0:493:c845:bc20 with SMTP id 5b1f17b1804b1-4994e79ab0emr15048195e9.4.1785880471944;
        Tue, 04 Aug 2026 14:54:31 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-a48b-1c01-1c76-d8bb-0f26-1c8f.310.pool.telefonica.de. [2a02:3100:a48b:1c01:1c76:d8bb:f26:1c8f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4994e980559sm10979265e9.2.2026.08.04.14.54.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 14:54:31 -0700 (PDT)
Date: Tue, 4 Aug 2026 23:54:30 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Marc Zyngier <maz@kernel.org>
Cc: Oliver Upton <oupton@kernel.org>, Fuad Tabba <tabba@google.com>, 
	Joey Gouly <joey.gouly@arm.com>, Steffen Eiden <seiden@linux.ibm.com>, 
	Suzuki K Poulose <suzuki.poulose@arm.com>, Zenghui Yu <yuzenghui@huawei.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, grayhat@foxmail.com
Subject: Re: [PATCH 1/2] KVM: arm64: nv: Allocate the shadow S2 MMUs
 individually
Message-ID: <anJcUNlnNmP-mKWH@gmail.com>
References: <20260803224405.41468-1-kmehltretter@gmail.com>
 <86mrv2arf2.wl-maz@kernel.org>
 <86jyq6aq8g.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86jyq6aq8g.wl-maz@kernel.org>

On Tue, Aug 04, 2026 at 03:56:47PM +0100, Marc Zyngier wrote:
> > The other thing is that reallocating the pointer array isn't great. It
> > adds complexity, and makes everything more fragile than it should be.
> > 
> > See the hack below that seems to work OK.
> > 

Your draft is indeed a bit simpler.

Should I send a cleaned-up version as v2?

I would allocate the table on the first call to kvm_vcpu_init_nested()
and not in kvm_init_nested(), so it cannot leak if VM creation
fails. 

There's another issue in the current code: the ptdump debugfs file
keeps the raw mmu pointer as its private data. I would add that to the
commit message.

Thanks,
Karl
