Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF373CB2FD;
	Sun, 13 Sep 2026 10:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789296258; cv=none; b=CmeJOXEVnG1EO88eqzYLo02P4SvNd2qGFsF6jREMmKMnreogEIAB0lnqMEXpYPwu+fpxr6GdiaEOEr6g2SGPHhdFXXioOc2dJMLJRHBZ/tfXqi0PZk6sMy9Vovlwcc2bgHBFwZPfUMU0lwq2f4/v2K+05zcoqxviDBLtQSUgfYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789296258; c=relaxed/simple;
	bh=R4zv/+qgaxKYYjj4ptEKF3BHXO7w7M4iLZZ2AlXw7R8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tXyc+Fjdkv/5xW6NRBPGSYYsZP1D2Kpq5j0e8DC+Y1Wfonx+HHUwy9UoUyBOlZbwB2diNSXAgXbw1PmJvMgpnR83vXv/aGaRBqHNFaz5/JuJT5xSrKXzD3Dtin+PWd81anZDZb696n5afKsq4SgsA3wLP+OZMDc+Va5S/vORgbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=djcJx+Tl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="djcJx+Tl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76EFF1F000FF;
	Sun, 13 Sep 2026 10:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789296257;
	bh=cS1Ju2GfKqEA/FP9zJHnQJwF6JmphHpLlloN1nGWOQo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=djcJx+TlSn6dwlhznxWXYMpg0j3ZzKupXcM4XcdsbX954BAsSfnM7DO6mf+ug5sbE
	 3pk9f3ZGOCsDG/tBpL2eqrSq0iAisZnZidiB3WIMYvz6d6q4rnetQd2wjIYBnlkp4P
	 Rjwt+KFcl0wrv/VtEgBYuz1yDLTWj2KVre2rO7wVU8VFzSl+cLLaZ4rNfqcsEdrFNa
	 vNt9x7a0ROJK4rdc/hHg2eKENGsFtdf02yeWmRRbmsNhmgTjvnJYTQGsQlkSlTmpcA
	 hx8oQsSyVpLbRyA4TTDQWnHeIghwSXZMGgrQR3H/oIvYeobJ30ikpMQmzCMr5oDocw
	 wRXutpvjPQrug==
From: Vinod Koul <vkoul@kernel.org>
To: yoshihiro.shimoda.uh@renesas.com, neil.armstrong@linaro.org, 
 geert+renesas@glider.be, magnus.damm@gmail.com, 
 prabhakar.mahadev-lad.rj@bp.renesas.com, 
 Claudiu Beznea <claudiu.beznea+renesas@tuxon.dev>
Cc: claudiu.beznea@tuxon.dev, linux-renesas-soc@vger.kernel.org, 
 linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, stable@vger.kernel.org, 
 Pavel Machek <pavel@nabladev.com>, Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
In-Reply-To: <20260716183246.3183877-1-claudiu.beznea+renesas@tuxon.dev>
References: <20260716183246.3183877-1-claudiu.beznea+renesas@tuxon.dev>
Subject: Re: [PATCH v5] phy: renesas: rcar-gen3-usb2: Avoid long delay in
 atomic context
Message-Id: <178929625199.194170.14605036307704113858.b4-ty@kernel.org>
Date: Sun, 13 Sep 2026 16:14:11 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Thu, 16 Jul 2026 21:32:46 +0300, Claudiu Beznea wrote:
> The OTG PHY initialization sequence needs to wait for 20 ms at a specific
> step, as described in commit 72c0339c115b ("phy: renesas:
> rcar-gen3-usb2: follow the hardware manual procedure").
> 
> Commit 55a387ebb921 ("phy: renesas: rcar-gen3-usb2: Lock around hardware
> registers and driver data") tried to address various problems in the
> rcar-gen3-usb2 driver and converted the mutex protecting HW register
> accesses to a spin lock, leaving, however, a long delay in the critical
> section protected by the spin lock. This may become a problem,
> especially on RT kernels.
> 
> [...]

Applied, thanks!

[1/1] phy: renesas: rcar-gen3-usb2: Avoid long delay in atomic context
      commit: 48e97c59a49c9e90270f5e3d221db253b76de5da

Best regards,
-- 
~Vinod


