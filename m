Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C693582B95;
	Thu, 15 Oct 2026 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792093001; cv=none; b=mNMhfDT8oQRQm7Okt1+AtAg6NR3YZivHGvmUak5PZmBkMygk5SE/ECsn45Ymwh1P4uO3kH8sCWKGSfNrqutDRJyLVeWtkLKEaBsydNlF5rVltOFzATu0Et/2zyiqbgm1HGa88SKDOV06QjFnV16bzjvmGRfSBzXWBx44svP9Bao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792093001; c=relaxed/simple;
	bh=V5VooUELFw4+Nz5jg5PHx66eSMMDtvtsTtdx5bWiBMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bx6T5Ds43ap9c176FzCaPRXFR9VsncKdoffaXBWcp+FWoKLsPaquxAqFDxEwvYAnR2IxV+jwPG0XgVhEfUDc6FROmXS9rSD7ZK7UY35l4ZpTJsEe8dHs9OTRi+yT5dFfhozLYDeBli5he/+3Q0ZFTotyEQdcUsewdV8dc7lM1yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHeFo1CG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHeFo1CG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375B21F000C5;
	Thu, 15 Oct 2026 19:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792093000;
	bh=CQc0gHwyH3PS2P9Bf2Yv9SSCVmTR2YJ106VzbPgjbvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XHeFo1CGz4vbcuLvjV6eTxlHQFCvtCKD0Wrm3FwcTN8PMMCX7u4PZCIXEh7V7FWEt
	 JvgF2NHMHmcaHi2dfUe9EP8uWXOuwjkeMeXYi7K4PdIaPO4jbz6OPfOXmkq+YAGNvo
	 3kaCwLuNi+6/EkOJlnJpHk4o+paalzLomxSBUfo6yLzG8GzZ8TIDDcGW+kgssl9iMZ
	 X1Zpsykh5L4n08PgAG2j8Pr3+qlLnys8SVFfHReodYfhv9Nca5l46jVhJAdsw2mOQr
	 ytqdWAM97wOKskhJ24xnUUZnVl6LgvP2AqdgF97VSCf/7d6OL4f787SMIcFozlH1ie
	 cvfR5dymRY4rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-sound@vger.kernel.org,
	perex@perex.cz,
	tiwai@suse.com,
	tiwai@suse.de,
	Artem Dinaburg <artem@trailofbits.com>
Subject: Re: [PATCH 6.6.y] ALSA: control: Don't add invalid kcontrols to LED layer
Date: Thu, 15 Oct 2026 15:35:58 -0400
Message-ID: <2026-10-15-1-daily-reply-0015-alsa-control-led-6-6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261014192115.24210-1-artem@trailofbits.com>
References: <20261014192115.24210-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> The kcontrol LED state layer tries to track the all associated
> kcontrol elements with naive assumptions that they are readable.
> But one can create a write-only element that has no get callback (even

Queued for 6.6, thanks.

-- 
Thanks,
Sasha
