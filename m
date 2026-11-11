Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434109;
	b=dTQPxLy568OEFq/A+k6y59G7+adMI9lkQWLHHyW84iMHc9snosLSmSGi+u9aF+B/Sth0
	 dckHatxR4uZs4ZGp9WOvWRrDPDSqaa9yZ+57ctkYOlwAGT15LTZ37cNWb87jIoRxFX43u
	 fsy0lNi25RIPNiLeuRgz4BfDE0lWcWGIx6+GgYBoNDE1bR0PD/5u6yga+veyZUaRKsdVu
	 GGJ7EUzUxMsdkJYbbbiUihHY9ybK8yO0mg58r9vQI+ih1SpgH1GlSFPNhfE7RHwesIKCQ
	 4r/dEcB5raNyqKsYInDlk+/nS33wOHmfCijyZCCNrB4XXTn6QT2LT7jEzdzr5LVKjvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434109;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nn/g6eYAfGonJynUJCpMPyjbs0MGgpAivO7pFDq+lAA=;
	b=u4KMzoTCEALbdQCYJ8VeP+PotGCwuAAfc7KlLY6AAYP4vwssl/JnK51xg5K3urfFjJZb
	 sDwT5D05rRBQzGu367hf+UOkLmPlDSAkLT5JY3TESrWiyj+PVcVB7+sqRDjFTNJoNycxS
	 XyAPCEuyUmDiNTix6sHvQpV4R3hcKDD7yOTVPl4RWMpXCuVHf7zvgdf8f9DQeN5MWG0D8
	 55ZCX5tXDBKqI//rI/+1ANZ5V7JgFHRzPDU2iTVGsEQoBruj9kjch6XZslctaRPGSjGgL
	 gc/UfCB1es61UuUpgqnGmvNV7uYCSrTbkei+jHVCk31Va35J5paVldE4ikSzCW+0MXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhFXIG6a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710B260A5BEB
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jhFXIG6a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C41D21F00A0B;
	Wed, 11 Nov 2026 21:55:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434109;
	bh=nn/g6eYAfGonJynUJCpMPyjbs0MGgpAivO7pFDq+lAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jhFXIG6aXl7rF1BsZNvPNNrMT7/GIJWysvF2m7ltsSha4HxZ3MegvxHSEQfpdYLEp
	 3c4T2D97YWANJO/JHEMGyrR550UtNCG6ruGMIK1mI/TC4UPVbL0yZ18oUfy+GTrlFc
	 DtTuL2WbRtprNAnjlggxDoFg6vbx4kNyLySFvAp801AmonvjZQPcqUHdEAKxsZFDVJ
	 AXByxvtscDip3CBeo+6L7WQ3mORW/T0MtQpAl6TXVGcu778+3ziLjKSYK3q/Z7FFhF
	 l9vAgcArmr0EhJW8n0/srsw29kx7dXFYFHoTXvVsvJori6Z1cTlkrNGPZ8Hlorz8Gl
	 2sZC/8PXqGjIQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH 6.12.y] batman-adv: tt: don't drop local events queued during TVLV update
Date: Wed, 11 Nov 2026 16:54:43 -0500
Message-ID: <2026-11-11-1-daily-reply-0010-547290b5280ea36edf3d@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110190544.117420-1-sven@narfation.org>
References: <20261110190544.117420-1-sven@narfation.org>
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

> [PATCH 6.12.y] batman-adv: tt: don't drop local events queued during TVLV update
Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
