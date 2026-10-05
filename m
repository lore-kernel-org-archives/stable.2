Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216494D796C;
	Mon,  5 Oct 2026 15:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791215013; cv=none; b=M8sf8glynagrimT6pY77bJhE50+k7wJM7b/LPyfbPwH3ie0LUdd/pM8dHKbltGNfZnhsMgWDOnDXgDL+NdYk8LQGb8ae4RD3ZlTaLJg3F/uYhm57pYsgK3urvA89ULIOTARgMMLnTKuc650O77z+a5+4VdFxLzDPozH2i6WX10s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791215013; c=relaxed/simple;
	bh=MGtCI72p328j03OTkEC7xfAJkAt4172XIwEPAbwPTRg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=IvawWL4KI50oxHYq/yBkFyIWkgouW/qKHty+3x8DjFN5hR7aGdOkIG8x/9CyzdyLyWcdNU2Tr12qdXYA4+SGt/0ElNDvnsy9yEX5Oxab6FE+7R0MWwCXpBk7v0q8n7f0CbfmGBfp0RUOsqhkNbEhrmK1Ap9X9Z6KiT9A4pi8dUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUaACKvr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUaACKvr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364C91F000FF;
	Mon,  5 Oct 2026 15:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791215011;
	bh=2mhnBnDa3icGYBlrsRq1w0WPoVIqoiIvOyy81bKb3so=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=XUaACKvrL85sLcsCKGppctEwswqkz0y46759GPzWH6IWfvv15rfvUqguVEdufq0L8
	 wG9NUWLDmTDqtUE//pKuwtEdNRxBevJVNvQ4KUXfLG+uaGeN9sPcYqSukrNokLbo2y
	 y8jd0F7MvAXHcKYDfHRF/d9rtZG75SStAqJS3rm3Jq9Coz3MQCBZCKvg/SObgNa5r2
	 Q6QHUPPsjh/Gig15vUCQVaNI2N0NVFonMGjru5LL/eplXE/6GfCVxET067IEBDExNN
	 OVk3Ve43ThwdlEPqT73A4oY7TVGCaACaAmiyBIuiJ5+A4l75DgiLCdYnZ4pZC4UFuG
	 eT00+8fBj2Nqg==
From: Vinod Koul <vkoul@kernel.org>
To: Frank.Li@kernel.org, biju.das.jz@bp.renesas.com, 
 geert+renesas@glider.be, Claudiu Beznea <claudiu.beznea@kernel.org>
Cc: claudiu.beznea@tuxon.dev, dmaengine@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>, stable@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
In-Reply-To: <20260922092037.224884-1-claudiu.beznea@kernel.org>
References: <20260922092037.224884-1-claudiu.beznea@kernel.org>
Subject: Re: [PATCH] dmaengine: sh: rz-dmac: Fix off-by-one in residue
 lmdesc lookup
Message-Id: <179121500885.358863.14766200941521520131.b4-ty@kernel.org>
Date: Mon, 05 Oct 2026 17:43:28 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Tue, 22 Sep 2026 12:20:37 +0300, Claudiu Beznea wrote:
> lmdesc->nxla is the address of the next descriptor, so comparing it
> against CRLA, which is the address of the current descriptor,
> finds the descriptor before the active one, not the active one.
> The residue loops below then summed one lmdesc too many on top of
> that.
> 
> Compare each descriptor's own address to CRLA instead, and add tb
> after advancing to the next lmdesc.
> 
> [...]

Applied, thanks!

[1/1] dmaengine: sh: rz-dmac: Fix off-by-one in residue lmdesc lookup
      commit: 9db8e502b34bc1df8078abd0169a4fa0624de3bb

Best regards,
-- 
~Vinod


