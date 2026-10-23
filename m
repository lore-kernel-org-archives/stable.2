Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785790;
	b=g3MvV9e0VfGGERD1fAt/Edd/oypUQO3vLd6GaU3NiBySpw4nYhUxCMfOyBPFGPiXEcOb
	 5IikReZgbtKEsMu8lV7cVDWJFX4LrB+XtyGc6e/lnp/TEHXIlqgsx4usIWJSzXcbNkD+P
	 TTn2BCBVQ9y3g7C6hYhTXmCdhfSiD5viDihO5W+sP9UWxGLsP6Q9DFb3IV9xm7nyGcq6O
	 4bOPlwIKehdaiTAsiRAgb/pcialiikdWoIZmHULACvFKpCiUIt8f9nDfE55j8tHfuVeht
	 tSCARNB0ZJM4759Mnx+Enle5thLTZTrcwWtFie/VoSZ4WSt7j+mj70E+fodcvgjhAsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785790;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=73AIKSbXnm7iEYTouzViIQzL+RlppRhBp/kP6VeGFkw=;
	b=U304RHjfRXQwabaJyfKV3Ve6t4QabLCqi/tk6YFOsnF53cEkES+Mhk6UEiNz3ewu+CaF
	 DDQhMDWOo6mprzla85o7pwfM/Fn5/YuRvt9/61j9wzlTXQsnRy3azRXNzHYNgauprYr4/
	 8p/Pvd/82QqMNMtUjSRTzxrA9ZGYAFfJeqlMCXC6cb9AMMnYJHwbE+2XI+V4oBOmwiXRW
	 /FG6MBl3RyCIJj/Zgwsp6IxkogliNKodx4KeVFvsD161rA3WeZfH0pS+UXLaiutQ4azl1
	 5jncrb5r7vlprZdKKblSMllsiTHkOJfo63bXFom1nuaEhCXnp6Occc/We5UQzkEIn6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oESDUsak;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82C1606A326;
	Fri, 23 Oct 2026 20:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oESDUsak
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0381D1F01828;
	Fri, 23 Oct 2026 20:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785789;
	bh=73AIKSbXnm7iEYTouzViIQzL+RlppRhBp/kP6VeGFkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oESDUsakss0mrofMZOFxZbw4ICto+6WAZh/A4KTfqvWKeeo6GoIH35y8OSWaaQfAo
	 9fcNdhd4+WC0Dh32yR0DvXGtZdN6vChjrCvfqSFEQ6l1bI6BiG4SjErB24/0qj79+5
	 n38ovGqG0ItDpQelkDYtZJWKq50kiKD+8CHi48DXr8iun8w69Y3c2dQrRjh/xU4Z9I
	 RVhFjtLrjvkU4fmurcrvhoWexkyxiblZXBu54XeH/IQSQkYY71mgeR7fQJIAVgY2MW
	 uo2RQjdKEk1zWKshNXghg3HDgd9kRE3lBWnDC5Ogxxg21FD2w+I7eLCovGO1KyvB6u
	 ridSoZJrOrmPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	maz@kernel.org,
	oupton@kernel.org,
	joey.gouly@arm.com,
	seiden@linux.ibm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	fuad.tabba@linux.dev,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Aaron Ahmed <aarnahmd@amazon.com>
Subject: Re: [PATCH 5.15.y] KVM: arm64: vgic-its: Don't dereference a NULL collection on ITT save
Date: Fri, 23 Oct 2026 16:02:48 -0400
Message-ID: <2026-10-23-1-daily-reply-0012-vgic-its-null-collection-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022174537.2767-2-aarnahmd@amazon.com>
References: <20261022174537.2767-2-aarnahmd@amazon.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> MAPC with V=0 drops ite->collection but leaves the ITE on the device's
> ITT list, and vgic_its_save_ite() dereferences it unconditionally. A
> guest that issues MAPD, MAPTI and then MAPC(V=0) therefore oopses the
> host when the VMM issues KVM_DEV_ARM_ITS_SAVE_TABLES to migrate it.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha
