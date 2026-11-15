Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794735693;
	b=rwM4J1nx+huH4ykd/eHg/EPkMqm7xRsi54CD+Gxhar9mkvyXDc57FXtLejFAtUG9oc6C
	 3xaiCWvoz1m3+YiEuBHmIcV7LRVjrFPAxdxlVsNGwlvfghMEq2LKIunE9HtW57ZjtZZQK
	 pxzweZU4V/xuw0y7/3vem+hiwn5gxJEfQpt/3i+7GmGGFfj3Ps4f0JK3aJ9nlBUZ+VQnr
	 30Bt/x1ZxDQxU8qj44GCX1Z7H6E2PumZqTCr6ZIejRLo6q/jcnbroNjBy3uxk6rAMMFNx
	 ouyfD4RBDjp02wKgf/mPIk92MjJyqrd/C14Wfti1nk1Mo3S4bAN+D222tlfnBbR+Wcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794735693;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=XNnu+4CWKAt1mZbirX7yXEhcAb/VZnf34sFLG6GDqg8=;
	b=SuOXTI7aRmF5VdK6gD0yszQX9tMyep8PxVCMsBU3UsX2tViF1nVtxBJJKFMDkfnjqq8v
	 wRxTcSTPav/TohL/BVPM5LdSfYheb4YwctjgmED2WOC44EjD5QvObhLtXB/xprQ1mx1yH
	 WKzaFEMzoXEDjaa4mJKn/E6CJPnzv22Qrl9r8FHWg3QybKFgM2Xj17jJ3/Sz9oy5Qv8Sr
	 RZNu/cJ2llwd2cE1OR7uywA28lYH610rVegiCGshcbAFevOkelbcqpsw2g6Ripi3yZqIr
	 bGhbhE7/4ACWA7lOFPbQP3zlL36BrKKgcTeV6ez0qE2omEaHI+VqtOwNa8CjTRSGW2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbGZZz3i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB3D606A334;
	Sun, 15 Nov 2026 09:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IbGZZz3i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F39C1F000C4;
	Sun, 15 Nov 2026 09:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794735692;
	bh=XNnu+4CWKAt1mZbirX7yXEhcAb/VZnf34sFLG6GDqg8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=IbGZZz3if4zVOx/vM2ZpfeZ6Uims1Duj+Dn3BW+MRUz4XBu7eQY4RkuKHW22grHWu
	 36SSubkHHe0loMbe0ytt9zFW4mlWBmM9qhL09QN3zr42XQnhEsWtaegErwVVC4Mmc1
	 1d8yl93vPWkS7iXFjFPUab2z/TpNJ6aU/wmdMjf6lvZXl6y3bWGJmBVGvuRLQ2YoEX
	 ftwBL80thNNOllg6F1sSK37BVv+FxDeaNfM6X+6LZoZ/ijF3L8D1NJcOcp8Un0rMnU
	 DILHBTOzbdO4DN6AVc80FjWq/Zivzy4NKU97mvVdtqXmHy862T0xw7RMuPxCNeFGcM
	 85EOI7ran2SOA==
From: Chen-Yu Tsai <wens@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>, 
 Jerome Brunet <jbrunet+clk@baylibre.com>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Arun Iyengar <aiyengar1990@gmail.com>
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
In-Reply-To: <20261110-h616-clk-emac-spdif-v1-0-e5e36e8963e4@gmail.com>
References: <20261110-h616-clk-emac-spdif-v1-0-e5e36e8963e4@gmail.com>
Subject: Re: [PATCH 0/2] clk: sunxi-ng: h616: Fix the EMAC 25 MHz and
 S/PDIF clocks
Message-Id: <179473569042.3056166.1982990416520172498.b4-ty@kernel.org>
Date: Sun, 15 Nov 2026 17:41:30 +0800
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
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2

On Tue, 10 Nov 2026 06:02:59 +0000, Arun Iyengar wrote:
> Two small fixes for the H616 CCU, found while checking the clock tree of
> an Orange Pi Zero2 against the H616 user manual.
> 
> Patch 1 models the EPHY 25 MHz clock as PLL_PERI0 / 24, as the manual
> describes it. Only the parent and the reported rate change; the register
> writes are the same.
> 
> [...]

Applied to sunxi/clk-for-7.5 in sunxi, thanks!

[1/2] clk: sunxi-ng: h616: Fix the EMAC 25 MHz clock parent and divider
      https://git.kernel.org/sunxi/linux/c/93797c1f8455
[2/2] clk: sunxi-ng: h616: Let the S/PDIF clock set the audio PLL rate
      https://git.kernel.org/sunxi/linux/c/d0cd486a2b64

Best regards,
-- 
Chen-Yu Tsai <wens@kernel.org>

