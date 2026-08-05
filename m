Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1715D3DCDBD
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785966000; cv=none; b=P77KaNMR9iOMEbXFL+EZRX/QRj+Pl1RoVfSfkQ4oEiGuRymd9dMmlj46L1yS02Y1Xdun5RHQXNcn2SkiEFCabrU7EYi25RYUf3JL40Hx7ofo/YRp7uZrV4aR29LJWheVuvoAGeWFU1QedCO6mgPgp/JAt1yZqwmO9RuE966pOPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785966000; c=relaxed/simple;
	bh=QQbWVF9MkffKPNOm3Xp+x/HSUJzikj0qawl/MCEpm2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T6YLx5nFQiisJFhMUIQfDE/xYioEnCRo5x6ifR/EiGa5Hx9H6GOH79JFJMgXZpdro4ihOBJsc6EnRWh3bxbEiV6lBEfVe1FWu7JDSmoBrgFTrHz1WJ63xiIJloNoAmGq5G+ms69hI5yk1GSGsB53eNmTPhtWEPkGgh3sWHTKCBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Au2bMN2u; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Au2bMN2u"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47fecbbafdaso466821f8f.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 14:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785965997; x=1786570797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yOlBr2Z6ScmE+dhp5/f+kPQyir1jOxNY4C+TyOhoSGw=;
        b=Au2bMN2uoUkHYwmq/WxeRaJhqK4q8xu4PbrbhAE60y479awZ62HlRWD+3F+hGYl/1W
         PQ93cJ7i51EQXmWG6d/L7nJQjKqAEwyW5HAxvO20W+tZdgEL3q+OrLmM6HNtxn5a+xAm
         aa9IZCo23ajyFf2c3S/gz6VysyQME3PZ/0trIZvKA9cwOfCBSFyfGjV+pEEzGD5at99p
         DdA1DAjS9jYDtjk0wJb7/pfsI5p9akyrVP0fKypReX5Ba8nulMzx0PwAob0B2rneqTlM
         H3AeuIahxxxpcsRuvap2Swoxcp9H2sMQGGCrjyHY+lzfi796KjbtJOEpQA95XXNeFv3e
         CPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785965997; x=1786570797;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yOlBr2Z6ScmE+dhp5/f+kPQyir1jOxNY4C+TyOhoSGw=;
        b=qgiPMwkUhlT1z63Imzk51fPbj0XHFZ7mtvcjF1pfYK8Tlb81kYV87DV8d5nnuYRiK3
         3kxbz9vvP1hecUcUPWx9e6YnePEuD7US2pPTHXr1nhwJGbcKMLENvoUa44KEo3pKwdLD
         EYjsYpRcNl5nEeSraYaV0XV273GS5vD6QwRpdqLGwCbPzu/6Z3vsC33s8mZr9OEXz63a
         +kFi+cNPAWrj0yxoybnHVBNsQF15ziAba4x31wET8o1aWluXzW/rz3HBCoz9h52Sab1p
         LdFYezzNk2T2dvQrlF6C0QFrAwGQmoEzWGEW0KSZUk0THV4Tc48CjrU1oh8Q7sOHozOK
         Ym0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoE+nsJu63PjXLbzzsoz2b8rycad2znAQI7BvcQlG06nTggMBmInQ8MrMMuGgc1bkZcmvxP2dk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBffG+djc8IYLTLNBrcaSTqiH0mAqblPSZIVymRPzqcrAGaBlR
	kc7RTkwbUEiOqmUSUBZN4gx8qy5zYSWNSZpFuiP7EgTEKLwPfd6Ui1LG
X-Gm-Gg: AR+sD13E82UXaF+N+SoWQkUYmYaPPX4EF8J+ia5kI2014cLOui2yS8x2ZZkiuPzTqtm
	muqKi+GU+Pfm8BBirSLifcLBISRYC85S7agSJmz82t1dU90cYEN1jYiA2CSmFhrx1ZBQ1xUitAS
	I+34Njvy8/x8UE+2gU6SKHoZh3bH9YivFnVx7ojfeFaZjY+1GE+DRpksL8MUTOVTiXOXXbEBZSW
	ZpWA8H/rKhWD28tJ4/iUSMxOOmlYIx/4CgF5OHpVaTpmkzKxMw7YREMmFwKBBGXWtWcb9DJWQvI
	+Ikrv0nK597OtxaUbV4Db64ueDzkvr+QhaBLQvzZrdVSUzzK/lO/oyBqPk1LKnzKWTsFlOooduq
	8cWPMSUeT1SBhCRg3ZbOtiKq6fvh2PEw56hPuvJMCpG8kpC3hPdcYXkY0Z2a7KTIQ4GVLxMhRPc
	HUsa9roTABb051k8tT0qh5GWg1hEtXUoeTlf0BJfuRQvxEM/mWyvB+AH7zdQLvieaGLNZCSs1cH
	JjnKbdfk4cwwJHUhXCGTOte1FafZ9U+BNqQTrlD7o+/wE/2sdffVmND8LZLKD9mBKu0EGssHy7y
	AWs0VNLMsvv+Ny0twPwxvhapI8NoIypzd9zP7+lL
X-Received: by 2002:a05:6000:1863:b0:47f:5371:1b15 with SMTP id ffacd0b85a97d-47fec63491cmr14018614f8f.26.1785965997040;
        Wed, 05 Aug 2026 14:39:57 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-095-114-073-248.95.114.pool.telefonica.de. [95.114.73.248])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47ff79b32cbsm568073f8f.10.2026.08.05.14.39.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 14:39:56 -0700 (PDT)
Date: Wed, 5 Aug 2026 23:39:54 +0200
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
Message-ID: <anOok9XvLMNX_Aqu@gmail.com>
References: <20260803224405.41468-1-kmehltretter@gmail.com>
 <86mrv2arf2.wl-maz@kernel.org>
 <86jyq6aq8g.wl-maz@kernel.org>
 <anJcUNlnNmP-mKWH@gmail.com>
 <86ecgdaupe.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86ecgdaupe.wl-maz@kernel.org>

On Wed, Aug 05, 2026 at 08:32:29AM +0100, Marc Zyngier wrote:
> I'd rather keep it on the VM creation path. This is VM-wide data, by
> definition, and given that its size doesn't depend on the number of
> vcpus anymore (we allocate the maximum once and for all), it is right
> where it belongs. See the untested hack below for the freeing on error.

I'll send a v2 with this soon.

> 
> > There's another issue in the current code: the ptdump debugfs file
> > keeps the raw mmu pointer as its private data. I would add that to the
> > commit message.
> 
> Why is that a problem? With this approach, the mmu pointers are always
> expected to be valid, irrespective of the allocation pattern, and we
> only publish pointers to the dumper when the S2_mmu is actively being
> used.
> 

Sorry I was talking about the old implementation. Array reallocation
leaves ptdump i_private pointers dangling.

I'm dropping the selftest for v2. It was a useful KASAN trigger, but is 
not a good fit for the current suite.

Thanks,
Karl
