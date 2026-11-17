Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912494;
	b=K+cBim/zy6D8QhsblU7IZ3RKibCPNQ3RLW3mhzstfkv8dmRi0LDo+O09aoOMS7mbigJE
	 2L3TBe1lTgOg620RKn6H2mk8wjRAXKJOlPmX+2xcaN+xMxzHIkBZjLcceJYOPA6Ouzuip
	 28ko9spmhBim+aPctr6+S1NjURp8YUPF0X+Yz/c+/oSZjF4kBBPnH8Dlez/NEaHJzL/WB
	 IPDJTpMqhvYDt4DYsy2KI+Ag/jO8Cc4jhORTMY5uPcS2UkhjQ56/AXY+YiCTjr15wr1+r
	 UGaJsIzFaPwQpUqQL/z98KU6qLccbwHIehRDabNzviFhyDnf0rlW06zsiDFBkF54+1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912494;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Qi0cmP3wtav6zq7PK8NCDq+4NI8sNadGZ5OQyAp5dLs=;
	b=aNH5n+jpO7uxqnp+6MQjhwmdgrHr4Td4k8worAKwqH35p4cGSTorLdxbyxIeWhD1jhGy
	 RoXdeCXJsECAUocod7vju9y4I9hX05fHbSlm+lVUI9rovXPupqY3JfpgL6kkbEIcm6Nvi
	 YMECynTScdPXvdIl5x0Yjv/dlW8tOqGwB2TQlN6oPLPthUgDWzHfBb90AWX1PcQaZC1MR
	 iLkXdRoijQUBstZwNWu8xvtcbJ68bgG5Yg5Jfeogt96CZvp70RxJelcb/cXf0JlpJBnVf
	 h77RiWgKSECXBa44COUHjHC1000lzsczKq4eBBFjXoH5n54FBv50by1y+ckF4HnuwHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=bmqO0pha;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0A7606A331;
	Tue, 17 Nov 2026 10:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB0A7606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=bmqO0pha
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794912492;
	bh=8CGyToB07yLLfMT3JnBSGWMLvxSQdNUV5kLaFWsKIy8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bmqO0pha49cenR3EsbWuy+N5ejWY7Lh5F1CwHCmevZiVHXzaeiffbRpHvAoifWHOb
	 1wKG701dCca4cwucRrQuFCbVR+ssf7OYRcgLB3J6duOKUu67sudvPaquCTNIoy8LUw
	 Ney1K1+YSz9F26wAaRbQ6jHL5pPs0fLApb/ASfR3aiR4Y50UDKHlXjJcAFOe8KWmBT
	 xeZpL1Yzvp0D6mHz9C3YXbnFKgcGK8DfPAlLrIOpEd0vyHzP8+mseZii0IZda3cEpf
	 0X2S2Af9UkQjOl+bnDRQcaD2Z7kxnvmnug2ZfE2QMGE0fRcObWF/ByjS7cNMahgQ/T
	 bty2+oZHFHEUw==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id CF14017E05D6;
	Tue, 17 Nov 2026 11:48:11 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	Coia Prant <coiaprant@gmail.com>,
	Myeonghun Pak <mhun512@gmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Lu <roger.lu@mediatek.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] soc: mediatek: mtk-devapc: release IRQ before unmapping registers
Date: Tue, 17 Nov 2026 11:48:07 +0100
Message-ID: <179491248222.154190.5453810565368208975.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002202028.420575-1-mhun512@gmail.com>
References: <20261002202028.420575-1-mhun512@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Fri, 02 Oct 2026 16:20:28 -0400, Myeonghun Pak wrote:
> The managed IRQ remains registered until devres cleanup after remove
> returns, but remove explicitly unmaps the registers used by its handler.
> 
> An interrupt handler already in flight when stop_devapc() is called can
> continue accessing ctx->infra_base after iounmap().
> 
> Release and synchronize the IRQ before unmapping the register region.
> 
> [...]

Applied to v7.4-next/soc, thanks!

[1/1] soc: mediatek: mtk-devapc: release IRQ before unmapping registers
      commit: bf97386b6ba804df2e3a42933a4c955659a4263b

Cheers,
Angelo

