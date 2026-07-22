Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D41313535
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784727598; cv=none; b=mfDLA0hQBK6SuWWb04+k3GjUvlIX/tSX4iLgCDNR+VCH5GyUDnHUH6uwQtaqo5aLqQWYzi9ZRGj1Kxkh/hzU5yrlZHGPqByi9bZgFIcKGBuiVWvg6k+jruRM3xJcxgcY3dotqn9cpMEnh4WhrQm700rT/3TS7UAtHh51kl7EXJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784727598; c=relaxed/simple;
	bh=fHQGw3qwEeLCPiOc2Lhcml3DBX497J9B0JemH97k9dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GgqCkYKrXTwKIsr/9Bxhmk3dWb+CNF/XnKS+BiWWS1xOodgssZNCIF1AhCxr07JKl2xlhR8n22mxErTsmjNprYT7kW7fGJDAH/Xg6HTOT2w+klSizt7vs0fxo//ydrCKSJhyvsV2VnYxScopfxw6p44AWiZN1iyHDEt693IlUL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=hkA9mOAr; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="hkA9mOAr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:From:Reply-To;
	bh=tFP9teOJG3GKeYmxPYNazXzHWh61fp1/54dvrTxEfAY=; b=hkA9mOArXkdg45yE4KjRUeCa6v
	CCNpHleSQiYabFZRoHXkj+5OBxvZkfyX1Hn2sBeB5bo0XHJjeb4mhDkTEFdTCobdB7tQhieMIuQ3t
	YFFJNYX0ul1WM6S1iFvBPKw24YaJ+nRyhkpBB7Ay7vBTgh2ikupaocrjMfuvxkJ0G4vxXcuy9jBUU
	jgnEXVKJUxSiauU8nlljy0LnNSvYQKf4tds4Nl4b0pfCmrTY1xzTh+4+ioxVSLohEPURErZEVID0g
	sHCih5p2nz6jML9rMzodX/P1y8mOL/LFNFbdKlFkYVT2q+2k6DhKjBkOj4V5mKF9MsiKmFqwgYzg3
	KilCyQqg==;
Received: from [187.36.208.132] (helo=prince)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wmXAh-0030yZ-G6; Wed, 22 Jul 2026 15:39:40 +0200
From: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
To: Melissa Wen <mwen@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	=?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>
Cc: kernel-dev@igalia.com,
	dri-devel@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 0/2] drm/v3d: Idle AXI transactions before cutting the clock on suspend
Date: Wed, 22 Jul 2026 10:39:17 -0300
Message-ID: <178472755224.461453.16781147218856784522.b4-ty@igalia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260718-v3d-pm-axi-transactions-v1-0-4ecd7729ed70@igalia.com>
References: <20260718-v3d-pm-axi-transactions-v1-0-4ecd7729ed70@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sat, 18 Jul 2026 10:44:35 -0300, Maíra Canal wrote:
> This series fixes a GPU hang seen on the first job submitted after a
> runtime PM resume [1][2]. v3d_power_suspend() disables the GPU clock
> without first quiescing the memory interface (AXI), so if the core still
> has outstanding transactions in flight the hardware freezes
> mid-transaction. That corrupted state survives the power cycle and surfaces
> on resume as a GPU hang with an L2T "pte invalid" MMU fault.
> 
> [...]

Applied, thanks!

[1/2] drm/v3d: Reach the GMP through the hub registers on V3D 7.x
      commit: f7df2da0d1c375c1c4c70e1e0b569592de0d6b73
[2/2] drm/v3d: Idle AXI transactions before disabling the clock on suspend
      commit: 07e769ba3d82ac614725c81c512a8b54d33f2c9e

Best regards,
- Maíra
