Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586873;
	b=ubS7YEd/H9vKLVlliC3q/O2zQIxPou5ZTfVEnvXBz3h5JYDxHamRBgviXUexLh8zICZ4
	 CkptcRuET5VsnpGgPNSDEpl2AVkr0d6uVylfd/cULWN9nsYjXWfWO3sSf6X1FIJvhxj64
	 +BZY+jjEdh0ZMUukm8L3dTOwh8hDyAzzpq4sPb284oIVl9DBO4u4+xyEC2DjAmvQ2OqXk
	 xA5RISA9/KTdshPyDh/HqgDSk+r7adrIEP3Bws1Lzh3h6+APEIzwmeSZwUpgIygSzw+R7
	 8f7HXw5IANUTn+ONZEC5SJiGvSWZDP0tRji7wLcUQ186KnheDEv/R2OTtM369MQ17Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586873;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:
	 MIME-Version:Content-Transfer-Encoding:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References;
	bh=AdBj9zEM6Av+iCclu0f96jPwuGOe0IQoHkv65WEskAM=;
	b=Xa8pcoOaHJ1ICsUi8QGifUoOQjw8aTDbmgyhEBzbwRPgubYvk8zWLVHs3ugossPqjpqZ
	 PkSdipluqQO/uPcuaJqMb/zQFMjqOj+xF6WQ93mWuWQQ3dGKxjc3VTaUyLcSZvr+asrLc
	 PWrOdnZ/5NiyotNY165mVjVA8dL964a2WoIQZI5FF3rJmm9ohqYtYrcC+/XRgH+NQpEqj
	 ZBUqus4bzLmfkn1Ogll+SDq6t8cE8QyF132EUupbmBOMkz87slia6fnOd4aBdjpxmJo3D
	 pE1AQEV57WLOKx7GD5j+8V6tOPueLZCM1wcOTxqJ74CgXQCmXNhzSZqH/LihRSsVmNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oN3V9edY;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EEB606A31D
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 12:47:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31EEB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=oN3V9edY
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1f403aca0so4750125e9.3
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 05:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792586871; x=1793191671; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=AdBj9zEM6Av+iCclu0f96jPwuGOe0IQoHkv65WEskAM=;
        b=oN3V9edYrln4bZFvmFjmTd8c2CtRSC4rflpVfuhf1GalA6C3e8m9qRLdcm/ASeGRd/
         okd2rza3WamBYsywJ5fRkq6WVFLwLBDMHqLbO6HUQaH04LJ2kTmKOcgSgdEw2CFB+/no
         AVuFQGgUOYvu35L/grpO+hrvznhjZDBABpJx75zXGeZFyLtTC+QNyiiVQqCrcQeJI/sd
         2H2NqCy743iZQxVy6HogkjgQG5FEMC2/Z4zBR9aKWxLsmzcWiOAYsroK2u3pPetd+mEx
         opRWu2K+VpRU2Ktb9KhEnJUwspjSIITOdhjMLeqdl3J8C5mgdHar49pGc03271OzBeXy
         740g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792586871; x=1793191671;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :content-transfer-encoding:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AdBj9zEM6Av+iCclu0f96jPwuGOe0IQoHkv65WEskAM=;
        b=fc8lxUcavA3aAtRduEhZ60XwHQt5D36fjNqDjfxpu8kd+2a8jMiysFnaY8dgjVJPbY
         GIGYsWCjpKxCf+DVLUzfREWv89+fEDGX4rEgwtTbDTV6ykw0bxE+ZENr37JPnhfM0OEH
         ycY2db9Nkok8KXkGT+WAs+sNngL8uT34VXbtgTXnv9Jf9lZdqpgaa0wVixfMopKfU6Ty
         LD9i2adCFN78xhRemkA2njpEsR32NxqQXlqlLOSW7SqhhYeVPI+RAOHbGhaNg6jPkBrH
         ciNgtoEELj4y/T+Km8L116smpRj3Ajd98XJRFUjemlDMZolyokaEIyB7tvFNUJuaQwx7
         07Ow==
X-Gm-Message-State: AFq9FYKkzCB5BFmAAfNOfNUf1PN4tBaF8/Z8RGmc6c0BwyuXenTlkzuZ
	lWUEvFmBv9OyLuRWoKnl+kpriC4g0eYegn7sLSfe3SMGkm/MHqI/PP/O
X-Gm-Gg: AYBFou0Kwbz7ozY9Gt5D2yl+3XV8hIq7svtawV4lD64ufnYuEhvSd+lyL79WC67Clej
	g7hERIPKqVbhQdYCxL61ZbqsoVOlYV3vmgYtq8O+gXxEWrq2mgSW4P5wjiQ22SngTyD4c7/+Sz2
	CtyJxBUYWScWk+/zlBKiKqJeXMIgapfPKDSCh8sEW55NftD7UNGwzOl+XfhOdL3bsRt7azTvcD9
	RvyUemsTAkY+Tss4I5Nybhj5f5fAJpplA21tRADSqijpZ2zi8PsidcvxMGBg6zjt/eLZy3u+72+
	XD9PNdSEcr0UGOS3D/B42shBQk64ItRMfyt5Hgw3sLdUHT8jqJjERSIVxTNWwtnaIIWKb9zMqNv
	ucI5HjNNmaWA45mZAuQCitnlSEa9BDEjkdIc2VUhtHCwzPBrk4PPsYEyP/7u8MkQ7bVuyUCcHui
	eEUR5Ck9R/YKzDf9JubTtO9+jpSaVK65EHkXfF1+PrBb4fs4aoWX7MppLICXmNznE1nTB9Xbksi
	q5kL8K4bsiZBj3fsbaUhDdxyZREkbhI0iNzyVtayAj9B7na1rf2VAMBCT7RfTHxasOT7gupbcnR
	iC9mdFPh+MKTnNGVORbmUFm45zXtvqQ=
X-Received: by 2002:a05:600d:4:b0:4a1:825a:56fd with SMTP id 5b1f17b1804b1-4a1fdd39eddmr32568535e9.32.1792586871462;
        Wed, 21 Oct 2026 05:47:51 -0700 (PDT)
Received: from SurHub.localdomain ([196.188.114.38])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e2583f25asm5072644f8f.45.2026.10.21.05.47.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 05:47:51 -0700 (PDT)
Content-Type: text/plain; charset="us-ascii"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
From: Abdifatah Suruur <suruurism@gmail.com>
To: sashal@kernel.org
Cc: stable@vger.kernel.org, fw@strlen.de, pablo@netfilter.org, security@kernel.org, w@1wt.eu, gregkh@linuxfoundation.org
Subject: Re: [SECURITY] netfilter: nft_byteorder leaks uninitialised kernel stack on 6.12.y with CONFIG_INIT_STACK_NONE (CWE-457)
Date: Wed, 21 Oct 2026 15:47:48 +0300
Message-ID: <179258686838.28311.7213193111571639541@gmail.com>
In-Reply-To: <2026-10-19-1-daily-reply-0008-nft-byteorder-security-declined@kernel.org>
References: <179239012164.14465.16534329674629579851@gmail.com> <2026-10-19-1-daily-reply-0008-nft-byteorder-security-declined@kernel.org>

Hi Sasha,

Yes. The stable+noautosel tag was about the risk of breaking rule load
with pre-1.1.0 nftables, not a judgement that the change should never
reach stable. Greg asked for the full backport for long-term maintenance
and proper tracking, Florian has explained the risk is limited to old
userspace and is fine with it, and the 6.12.y backport is the
[PATCH 6.12.y] message I sent in this thread at 10:08 +0300.

The security gap is stable-only: 6.12.y still has the multi-register
path and with CONFIG_INIT_STACK_NONE a later load can read the
uninitialised destination word. 6.6.y zeroes the register file, so I did
not find another affected stable branch.

If the automation declined the patch because of the noautosel tag,
please let me know whether you want it resent with this rationale or
under a different subject. The memset patch was only the alternative;
please disregard it in favour of the full backport.

Thanks,
Abdifatah Suruur
