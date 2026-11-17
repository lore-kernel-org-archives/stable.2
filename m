Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912495;
	b=OQquILuH0Gbs3Aio+95gCM7Q/6/0JwIDCXIVrPQ6RfzX7MszjXFnEUJKFlyCIew7kW36
	 I4a+ieDu/AGXLyq6jJqr2/LelRP4evme0zh1Xm5qHvRq8SvlbdTjIBepbBYiJxSraOcR4
	 QWDcKwtzIDLOync4hzyGcTBwpYO40h/snJ9RU7TWj7KLyz3ku2mXoJxnSUN4l0OVEMUkD
	 FF/gxlqcAo5ot4intykpgq9mXEFfbHJgcHZy5HJ3fQtr474kiE5K9QF7TSTtaYg6FuzPc
	 1PV2fQzyWhytDIfWfmX6ccVUPUlKGH5j5CWZYC84uMOPu/TqSSbpN/jHtPflMqUrCjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912495;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RUN7O4VqPfmqBa2m1SYf0FMJzaRQzyuKWgap+ftrtUI=;
	b=gegy+mbvNtnfliUby8oZpPynGBd4ARupCKiTf1fyyUnUlQAzQ2sLRX8wiMzT2DBub1HX
	 3+62zen4tNPoHLX65pDyxf45n3UB2wk9/niyhIjb9Lfq1EWRsVA9x8qt1L1XR6gGYwGlp
	 OsQOBb9JeCYlUjipZFZpQWjs+dyhNYPROavl3NJBuRYNGpWwWdbOevRpNIQk4h36nx9TC
	 3Yy2qj+srjiIQc/Dk/Vx9G8fQmOBrgzJkkEad9o7ijr7OUkA8OlGMqwVnfJSjnXeneoII
	 NL0yKEv3G1I+gA6D/R0yx4jQJZ1zoK6wRrRRbDN8J4LFWftRUw6uBiOZgkcoBZiMayw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=KKdqhzGl;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AE9606A881;
	Tue, 17 Nov 2026 10:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2AE9606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=KKdqhzGl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794912493;
	bh=orTpcthCg6xt0FFxOp+32oPMMXPRwoSXOB9hmuEtzZM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KKdqhzGl7ss26Gd1p9ybq1A4+RX5yccpkO75+8WDjf3yEi5JN2L1tN4bAtNssE8Zc
	 QQ49jh2I6rcszoPQ9PvZsjc3Akc6imyLZapzk5yyCudW8QVzjGeT9qnJBvx0I8DbCQ
	 WICUb/UBzPC50deyPUdS7Od1pRf8f8uQRsaCZGd8NBsjxoVEVx+Hyg+XB64FCZ2dW7
	 NHwsuKWtnuPZXQeOjcrNEswtLzGIKzWEMjhO7hziXiZhKNxUFy6eYfkbqAYO2DT9FW
	 KMeoNfSbg8f+1VcTZpDC+JYH05raDhMnsbnwUYEpM3U0jNbPR4K7nESzN3kCMCqeJl
	 KrL74qhD6UvDA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 71A3517E0BCC;
	Tue, 17 Nov 2026 11:48:12 +0100 (CET)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Matthias Brugger <matthias.bgg@gmail.com>,
	Coia Prant <coiaprant@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Flora Fu <flora.fu@mediatek.com>,
	Alexandre Mergnat <amergnat@baylibre.com>,
	soc@kernel.org,
	Roman Vivchar <rva333@protonmail.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Kevin Hilman <khilman@baylibre.com>,
	Roger Lu <roger.lu@mediatek.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	stable@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/3] soc: mediatek: pwrap: mt6572 support + log level fixes
Date: Tue, 17 Nov 2026 11:48:08 +0100
Message-ID: <179491248220.154190.177723023436695190.b4-ty@b4>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028-6572-pwrap-v4-0-1780c58d2097@protonmail.com>
References: <20261028-6572-pwrap-v4-0-1780c58d2097@protonmail.com>
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

On Wed, 28 Oct 2026 12:37:49 +0200, Roman Vivchar wrote:
> This patch series adds support for the mt6572 pwrap.
> 
> All known mt6572 devices use mt6323 PMIC, which is already supported
> by the upstream drivers. mt6572 also shares SoC-specific init with
> mt2701.
> 
> Patch 1 adds dt-bindings compatible.
> Patch 2 fixes improper log levels in the driver, improving UX when
> debugging.
> Patch 3 adds mt6572 support.
> 
> [...]

Applied to v7.4-next/soc, thanks!

[1/3] dt-bindings: soc: mediatek: pwrap: add mt6572
      commit: 44584adbef2d5786ff4e4bedef48f476a700248f
[2/3] soc: mediatek: pwrap: use correct log level
      commit: b5c4ee18cc154623cbc04dc41e3642df3b045ce5
[3/3] soc: mediatek: pwrap: add mt6572 support
      commit: 0e19a950e5c1863b3805ba3969ec661396bf1db5

Cheers,
Angelo

