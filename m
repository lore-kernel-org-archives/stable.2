Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299424;
	b=xKDDFpA0dNpRS8ZN3k2zkFKMgkVwaxpNDYPFyqgWCx1awINlyHDSp+GTatsMFovHUT5d
	 wIP8iLW+MB/Uc9zEu6PH5fzbI459xwCRKd6GCvo2Z0D17XthURctFBCRBC2KJXJ+e+JEW
	 JD5cLpJ4YJmR+bNzgz2geNdSqE4ejr5GrPGP18SL3kOQOwMUBrz9lNY1U1BU4eSlJpS1y
	 cYOsNnDTZVpEX8xopka5WGeLhCUTXD81FHtcLNV7pu92fh0pyebulePbo3XyTZR+Eb/P0
	 LRc69Z27kC5Y039OBiseRPCvV7aBSAMZTUx0d10TX5gUQhiRT20cfljpiFyttWkyd3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299424;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uLzVJR5PrBW5MdCzTrQMsebCxLgQeSL1BGznK1Dto88=;
	b=lwoadBEvMrLvyhKQ230NR2ZtEihkQaMROPbEFqICUCM27PdTJToyJuof926aq8M9OIZr
	 4DDkz/Yw3823vqvbcYHl+3k1kd09S6LlJ3SYSKUuyQ94XhcMvEIfi+hKeBAhrdZyLm6Nb
	 JY1eetnToSGTyll4t7OqlUhNInSTzslucc9ZQ1/Cx9fbcvjgzJqnNba3WDvbhc4+QfWx3
	 qsbG9PJ7ozoH7DAHNO4ZHjLtXtL/ETEX6UVV+1IlRoNOTiRsavVftp4/AnWids7IKuNCl
	 yQ1CuldKJBJvJs9MPLxHn3ru+/EUdrKe6zjp+nujRMKE0WW8xHgtxmHyl5uyyHRWvAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0XFcrXl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE7D606A31A
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 18:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V0XFcrXl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FD01F01829;
	Thu, 29 Oct 2026 18:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299423;
	bh=uLzVJR5PrBW5MdCzTrQMsebCxLgQeSL1BGznK1Dto88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V0XFcrXlhdYX8OEiVLZ4HN8qKP5TYiBN8S4KbkEyhnjh3lrV/6VsQQcSu8S4l17or
	 KbdvyPhhUHvR7ntEusY9ztvmw4jpPO8w21D1X28Fg3QyxplZZle/5LOVuRmyo7qd8+
	 7EU4gkhjEXmH03TDcXooBvlSI0vk0n2h3+0QRntTJ16C4AVLuHB2sBWSwobnp4PoyX
	 d4Hk6ujULN+gKgMG57pcTCJ5u/XAS57ANkvX7/XIABBBxvTS5cS1lpX0hMxH2MAOXf
	 vtkbSKv1yGaD6VwmYdYpma3E/O7J9zUWLeHiMdLV202F0+G2I8dmJ8hdbiOplUeA4b
	 DqrmfjDB0GlOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Hiroyuki Katsura <hk590@cam.ac.uk>,
	Vincent Donnefort <vdonnefort@google.com>,
	Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oupton@kernel.org>,
	Mark Bundschuh <mkbund@amazon.com>
Subject: Re: [PATCH 6.1.y] KVM: arm64: Transfer the hyp stack pages out of the host stage-2
Date: Thu, 29 Oct 2026 14:43:16 -0400
Message-ID: <2026-10-29-1-daily-reply-0009-kvm-arm64-hyp-stack-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029022610.2637061-1-mkbund@amazon.com>
References: <20261029022610.2637061-1-mkbund@amazon.com>
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

> [ 38f9e4b905a0 ("arm64: kvm: Introduce nvhe stack size constants") is
>   not backported because it converts nvhe stack code in eight files to
>   NVHE_STACK_SIZE, and the hyp stack here is one page, so PAGE_SIZE
>   replaces it. ]

Queued for 6.1, thanks.

-- 
Thanks,
Sasha
