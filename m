Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794434105;
	b=r9W03BNTTTwiofJAWE0ucsii+dcLeymFVxRXzmqEuqn9VOoTOtURldwsUHnsDJT2quA/
	 1U05mx310JLtAjyvoxsqnyHMs0AuVIkorkUWde6sRw7JK5HbULDhnID5FDB4q/gLpgpwE
	 X/cmK7K8LKJpUUxeG6fwSL27nrCIPhjQsuPl/+kI96ChTsqRlONJ01RrnKhiwc44e4HR7
	 l6VcpDxpca2HLO/OJqE/lT5EpXzI26y8lToNezyqMrA8/qrFmmim88kb9tmyYFt3dMSzD
	 r8rMG8pvogCdIZVtFdNK+vCN8kxFkBjaRFOFEb2maYboPrlMBtppHYuBxq1q9XeNzLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794434105;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=sw5O80fr6uDMXYtyasxZA5bt9Uk7BIT5HA3pGW50YUI=;
	b=PRLvBWEpz/bIqLvR/BRRYiWzxlXo+NWvt7cbczxyIn5K2zg3IuUsLalr5agBOEWYRuKg
	 K1XY+aXZR/MsLTe8oizDYtAShvDYLne7GTpRTvdUhl4RopGYY/bxU1crMHVVNiOsfkxyo
	 66js3HxETPB0LAWcvJdQQkbGZYOZmfodaETsFp0VWljAmR3Az/Mqzwu+/njWDJF9tsLwx
	 pkdAAc6ZuBy4cC3YYGbBLCYeTsyvtI/1fwFfyLonuO43awcVtMtX99m4H6EO04DR8B/mj
	 OT0BE4h8P07NFE46rGxVCVouBL9+ztGWV4ZpdsHbXrtoRad3x2YEYavWTHoiInRmPmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PgKiIwrd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C9060A2609
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 21:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PgKiIwrd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3E21F00A0E;
	Wed, 11 Nov 2026 21:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794434105;
	bh=sw5O80fr6uDMXYtyasxZA5bt9Uk7BIT5HA3pGW50YUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PgKiIwrd/V7GsmBnUvxCmhAdj1xiJaoMf9F33/ZgVwopbe7BgX2KdZzg+PU3AWubN
	 AJOA7kNDMHJ0G7EZrsQFIZxeRkPPkQS6dshCGHyCSZvy6yLRwpm6nd1cWjW1OardX0
	 cfDo/585EA5VQqlnMk29qWwd4S64fN6s5UBKxdXWVmZ2KqrJ76SOXG1AEXGyCenh84
	 9F+//kSF+rXhL0xBwUTd4NmDkhEdzvMtuGiOIfyHHcoGb1ikdSWNDP9F5XHA2yrEiS
	 em8DQesjMW0TnQaTk/29o4UEhCF11IREfRE4bPh05nlEkEeycci0nnchq1QZjl7g09
	 69esv03mI8Xbw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 6.12.y] batman-adv: tt: only transmit local ROAM flag together with DEL
Date: Wed, 11 Nov 2026 16:54:37 -0500
Message-ID: <2026-11-11-1-daily-reply-0004-7df746515a66bde1d3e9@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110190218.109666-1-sven@narfation.org>
References: <20261110190218.109666-1-sven@narfation.org>
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

> [PATCH 6.12.y] batman-adv: tt: only transmit local ROAM flag together with DEL
Queued for 6.12, 6.6, 6.1, 5.15 and 5.10, thanks.

-- 
Thanks,
Sasha
