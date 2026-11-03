Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717551;
	b=xQECbMA0HJ8fhc0/G78ZwktypjmkeaZGM5JPUEtrO3i29/mZhazV/YlqaVztQ4AIykd8
	 AqYdM6mCr3EmmuZaOflBG+siCmWdgca5eZ61509s5i7vUruxCx636y2RNuF8GusyhctPs
	 nikJ1iSi8yiPNMyEr162Yb/iNpVkyjLZvM+eukSzhF1qDKLB2MueYdj3pb34rk2aO1uNm
	 sLPopBIfLM2r8vvYX2b7GyIYX24vFb7XsAWADYJerBGuME99hoOn/nWStMPysiW1NV55N
	 pPFAI5It7AsPBLT3Wo0lVujsQjM97Q+g8w23TnN7kp5dA2iUlVfxi5qrXSV/UCBKuzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717551;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fitJmQ61tI5vk6OHJgehDhATcAkh+WuJ8o/guuO2rR0=;
	b=Z93EJgORiBN2t97yDDxlGK8hklCUVCcWoVNHiyFqhk5GncmozuemUvf13q1KVHcGDBBl
	 U7pRqH9UYQ4suZMVt3DIGebAYDAYPaVAGuaiApvBqnPB1B4CnsnNmwWnKG7+p58lmW90S
	 0cPhvRiWoULUX22GQZFXT7xqIOb/inrM5H1vX+9usaULgFgpcIsIwT2pdTTvl8b9EayCf
	 t8Cjs4gbnwCGG2SQ2fxyUYv5AkarTue1u/rvrMv7ddY2OFrGSgIhL1du1/LmptyENJbAf
	 tjlJDePUz/HTXcsfoBOg+RERAR/oEGsYVk+FRp11LKTF9SbeLupU4rHElRAWyd1YTXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZvevExH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808DD6071C3D;
	Tue,  3 Nov 2026 14:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZvevExH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98F61F00A15;
	Tue,  3 Nov 2026 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717551;
	bh=fitJmQ61tI5vk6OHJgehDhATcAkh+WuJ8o/guuO2rR0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HZvevExHdlEq6TEdFLRvlzL+jPTKoLWJ3Bd19W9eJiAIaS1OqT1qW4eWz60M3Q++E
	 KDfbowEYzGEmb10lrHwknckjomXY+oDbIEWqFFY/DfS53kKI2fYtIwzBdjfO3c1rnH
	 xMN83bII3MTCRnx5P5fNxFNDY+ZdqSWFmZa4ysEd0u0DnfqrD/dmRPYX77L2XTYcft
	 GyETtUdClEQD/Knuzxl1sG/SRJAlhPfTSVudTOfvl38dsaJFoLBd3jUamAx40hgq8L
	 1fYX7ymTuLcNK4GvfJM7D3llpw6YA5x29uzQwpo4DblT3VisskWNSzsLsbyWNwVrVZ
	 Ch95nPXPKu2hA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	seanjc@google.com,
	pbonzini@redhat.com,
	kvm@vger.kernel.org,
	Bjoern Doebel <doebel@amazon.de>
Subject: Re: [PATCH 6.12.y 0/3] Backport nested EPT violation GVA bit fix
Date: Tue,  3 Nov 2026 09:52:03 -0500
Message-ID: <2026-11-03-1-daily-reply-0015-re-kvm-nested-ept-gva-6-12@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030103713.573783-1-doebel@amazon.de>
References: <20261030103713.573783-1-doebel@amazon.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> Backport of commit 96b067b59ad9 ("KVM: VMX: Synthesize nested EPT
> violation GVA_IS_VALID/GVA_TRANSLATED bits") to 6.12.y, with its two
> dependencies.

Queued the series for 6.12, thanks.

-- 
Thanks,
Sasha
