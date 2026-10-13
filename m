Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C575747D95E;
	Tue, 13 Oct 2026 11:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791892708; cv=none; b=sIyG09DMYtgi4Y/OHOOAjTg2XL1z6RHHokhfm9/jXb6Ve144cxfHAhUw/GbOY89t/ilcUcAk5QuBcQCEISO4PDWPvxnoswHamgY5VdxHdtdT6ZHwQViRDWotIt2fSR8M2vQVylnzBcBAkQF7Dp/chc/s25HIt7xR73/2/ft98Bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791892708; c=relaxed/simple;
	bh=5SUGE6t/EDybasNFbzsdtYZPHMEn4batY8borPqdOsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tetEHiZ3Ksrh0YX1UQvUD7RPXO1BKnt6Pj1V2g22lDJhII6c+6OT20BzguQG16HYbRPMf5TNHDVX87UKtk1KamyXHl2gyKCl3DhcYllj/kq9A+2UpXlm/lbfr5Mm6ObwOVS9TdDTk7wyp8ynajvebubtjYgMVDv5p8m+euqObS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=coIeN+ZV; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="coIeN+ZV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Transfer-Encoding:Content-Type:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To;
	bh=RXZipy+fUyJE4tmfdVmFNE5i0PV1F24TRbxaj2s7BWs=; b=coIeN+ZVk9rzeh4fwrzxdIUGxg
	NsXihkcvVcMD90BovGsabSbtQ6Zx79cu+qsGLfFDGHQZl5g9O5/ElmF45eSBRLjJizpP/refSAJea
	lB1UdHq9PSwif4+moDtCLzO8Yna8fiOGxAg/ENjFir7l6C9IZYd1Kqn4rI5sJPZqdMkYqwwWd7ikq
	QttHtScVhiw6qO2v6qLtCXrW5DboVG12t0ECHezfeSBtSIgX18B8oXPduTjEOYSpUv/23VszGaT72
	Z2Tv9KavsAhmY6LWPGN+GHJJ0qNRJKeszbn1CjJB5ivaOTVtJ6LAMx4jB7PVGop0o220+wUpeyHUt
	DWTbACxA==;
From: Heiko Stuebner <heiko@sntech.de>
To: Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Oded Gabbay <ogabbay@kernel.org>,
	Igor Paunovic <royalnet026@gmail.com>
Cc: Heiko Stuebner <heiko@sntech.de>,
	Sidong Yang <sidong.yang@furiosa.ai>,
	Jiaxing Hu <gahing@gahingwoo.com>,
	dri-devel@lists.freedesktop.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] accel/rocket: search every core slot when looking up a scheduler
Date: Tue, 13 Oct 2026 13:58:09 +0200
Message-ID: <179189268364.3989522.6809230134424233060.b4-ty@b4>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260905150432.7477-1-royalnet026@gmail.com>
References: <20260905150432.7477-1-royalnet026@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 05 Sep 2026 17:04:32 +0200, Igor Paunovic wrote:
> sched_to_core() walks rdev->cores[] up to rdev->num_cores, and
> rocket_remove() decrements num_cores for every core it removes. Unbind a
> core that is not the last one and the cores behind it fall outside the
> search, so sched_to_core() returns NULL for a core that is still bound and
> still running jobs. Neither caller checks the result:
> 
>   rocket_job_run():      rocket_fence_create(core), core->dev
>   rocket_job_timedout(): dev_err(core->dev, "NPU job timed out")
> 
> [...]

Applied, thanks!

[1/1] accel/rocket: search every core slot when looking up a scheduler
      commit: 89c2c777df17eb0201c8e22afabbf3691f2a28fe

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>
