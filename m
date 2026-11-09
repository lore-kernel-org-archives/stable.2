Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794239629;
	b=3sDvvkKklVvnxHmG15bJNeKC/DTiT0D1Gdiofr0K3CIPKorIarbZPX3Zi1fq0IJVuG6R
	 ZzbSukppDCu8MAyH47WmG7fOIm4YiP/AR9O+mW+A0PkiDRx3KHekK2g/LsG8MlK0APa/5
	 PN6qPE6ZX9Lr8FqldnRxoH5zPPbD2t1f1ZCiHJYFCQkeE0I9hKpNEjTUSucGUMTUb+aQP
	 9/Q7ZNuEnroFvl7suujNYcw5UInZcJam9II29EBpiLRP/Oub/byZJYSb+g+N5Har+vdwj
	 3NUFTXsszbGuocJ6/vP00n8Ulpx3DqBSodqTbHhBOJGPxiv/wrSbJewL5ebHzanBdSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794239629;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ubaejvMNzxeXOKQctCV1WJ+pFXKVNwkfRgbh1f+pnoE=;
	b=CNc3flzOL8XA51bgGRjIpoO9wbOrfMFGPdgYILG411hNIR4Mb2N34oS4fUkOWoYCS6L5
	 F661P5zAcIZ35DI7192DgcDKhcidhrBfX93Fb3SSjvFRpAPkDXl8YPDhhWjX1AvKUAoL3
	 WbqBvKxPsaMdI3ODBsURkH0Yz0XeumOfCwdtXIr48qzPypReWBLO2esodSj0BxgKRilcR
	 zkZ2n61bwKPGENTc/SrYgHDUcA91fpFrfYvhti0o6dapWyIpg58GpNZre7g4tt8o1TlIb
	 oCe1/k/HbTwMa2JV77XLmi+RKfRC5zAzDEGH8VgQ1ADcPjAIA7AoLyeI8socIpk9vEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDJhrtQQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC039606EE91
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 15:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NDJhrtQQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CAE61F008A4;
	Mon,  9 Nov 2026 15:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794239629;
	bh=ubaejvMNzxeXOKQctCV1WJ+pFXKVNwkfRgbh1f+pnoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NDJhrtQQysBEq03V7F8iesGkri8O0LgRCHOhDxPx2uuyRFwFDDOfXJQYCBrpDdVkg
	 LYXgaCuTNk/nJ5/SC0Lrqgf85X8wv1zhTD8bvhP4JtRxhIlLqmZVvE4iNjf1Pvv0JX
	 j/AoNsClicufVAUNpGzAd9x8W6RQ/vbPILFkU/iY2wBud7chPjxe7AUYNdVkJCNhWO
	 xQoXc640EDzdEQ3AMNGkyRu4892Gn/deLTnlaKlpcLjrxHrEWXaFHiNzyk2iEwLCyl
	 G8g8vI/HB3sFm66kwQXAKc0Z+QEEJblblL9KtrzTKKGW7Ocz8+pQkitl2HzWxAbRo7
	 FnxGggZtKf/kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Stanislaw Gruszka <stf_xl@wp.pl>,
	Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 6.18.y] wifi: mac80211: queue frames while off-channel
Date: Mon,  9 Nov 2026 10:53:05 -0500
Message-ID: <2026-11-09-1-daily-reply-0023-mac80211-offchannel-6.18@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109084016.5722-1-stf_xl@wp.pl>
References: <20261109084016.5722-1-stf_xl@wp.pl>
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

> wifi: mac80211: queue frames while off-channel

Queued for 6.18, thanks.

-- 
Thanks,
Sasha
