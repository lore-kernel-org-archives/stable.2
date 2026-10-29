Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299436;
	b=VG9xRh/iWNoRWwpCmSliRydmsHK3Sw6DpeHj/Q+tkeWQIgh8oUncB8vla81ZFttHxPIA
	 nUXv3+r/hv4+qhhfJUltuviXF5fNyUiX9AUQZHmkJQ8G+BaIn11ggN+zjb9jQUV3Oryg7
	 4QVVxZLdKVoV04w238y+L9Ey92HkvXWdloIecUGII7fbYlCqaLmN7j3S09troH8IF4s+H
	 L6oviwPVXNr1cChejBc/Kxhbo4exnwLCKJCzNMoL6D+9hRnK5huyzWKDjoduKaW8BkEkN
	 hGQPT3abmSK9g881LblL734IAdyozgjEnnNBISIm8rodPX/wCg3lD4If+i7MpkMt2lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299436;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0xZacld6o8nANioJ66Bx+wCl/dCdVGQB0X9AYNsF9fI=;
	b=bOntLTuvUBHacQsCkGhcfFds6E6i7GDpnPL2jnUMkYaWYTZAfWGFKTmkYZ0A6SO0LAsh
	 saExfpqBB6DsqfMCw779jxu9MfyFwbgdiBdtlj4qex+YoPqYKn/W8F/00g7HuD77PiUXR
	 CEI2uPznUOrrS74dngZ0FBwdpsXUeidGXRRhmILW6u9y0Tc3Tv8YxV3hGJEaIiehtoNhD
	 c8WCxCgbTZZhzDHcEyAhnXakarMKgOYku1gh3mW0gVaiOpNl6k4PCtK9KY/5U65UDC/O6
	 etpH0chIj4CKmT4O7vVvLE0fht5jqK4TcHaTyBbWHN2SXJuSNFmdSyYpssh9obj/xxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SmN3vSC9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE352606A334;
	Thu, 29 Oct 2026 18:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SmN3vSC9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C17591F01285;
	Thu, 29 Oct 2026 18:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793299435;
	bh=0xZacld6o8nANioJ66Bx+wCl/dCdVGQB0X9AYNsF9fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SmN3vSC98k64fsfz4aHjrn4Y0iMOvJgctjRiEpXgTeKYgNGlG8wALHejij6yTr0eR
	 NytKJ5XsMFE2xwIIqr6Vwj9mOh0UGROt57/tRg5evoi3+gEdOGK/m5SW0H+cf1kFx0
	 ejou/RrooIXOI4RS1f2537V3wVHh4FAIiC7zlc3bxoHglktYCwvab6E3Y5AoUIvbiw
	 dE92HOz3F2QijtMD9PMFifm/lihOR+C5s3LBVUul/xwcJ3RB12KQbxkw3Sz8uAipMw
	 VGtEnLAHV9mUJlrtmFEGu0lk1BH/cO+HMgqsX/tjtdQdWnSRYOQL++obUhKNQbXtaa
	 h/bX7KvYe+Haw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	"John W. Linville" <linville@tuxdriver.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhao Li <enderaoelyther@gmail.com>
Subject: Re: [PATCH 5.10.y] wifi: mac80211: shut down RX BA session timer on teardown
Date: Thu, 29 Oct 2026 14:43:25 -0400
Message-ID: <2026-10-29-1-daily-reply-0018-mac80211-rx-ba-timer-5-10@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261028142349.19894-1-enderaoelyther@gmail.com>
References: <20261028142349.19894-1-enderaoelyther@gmail.com>
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

> This differs from the upstream commit, which uses timer_shutdown_sync()
> instead. Linux 5.10 does not provide that helper.

Queued for 5.10, thanks.

-- 
Thanks,
Sasha
