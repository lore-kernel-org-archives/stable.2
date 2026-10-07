Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE39140F754
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 21:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791407044; cv=none; b=Gl59DYYbvCB4J69P6TYAofLNEcixEkl777hpn98QRIGKUevvOxGwffYVf7CKJsiG+uaawq/qSMqolLN7+Xve3kknwCjBtTYug9AyrFc0Zi5GgsPjC6t9rXr1c652TFh/9tiEwPkUkNCtQzO54OWeUSFJDNGpO6VRJgnD+oNAlb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791407044; c=relaxed/simple;
	bh=nWevea0Lq8Gv8Ck1g3QXBhSAbD2yMuCx1pFluBobSLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lREOSJLXIBYExS4mMLOcBiX2c7FoHW0HI4HVbzDwyNLqI/GtJrPPIdWS2d60ASDj+9e1V9kMLWGcISi8CBbWApUKzAEn9FYHSskmCzVjVTJ6CO38jKKsbam+1Wdwm6/zmyUmvOoewS9gUlkp/XZJZAt0GNWCO+xo66BDY51hi0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hg1qV1i6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hg1qV1i6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06351F00898;
	Wed,  7 Oct 2026 21:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791407043;
	bh=Hel/F1mDpekJoWBUlVSo/dAYfkoCKL2QjAPddd+4IN4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hg1qV1i6bXHKaXMsle38iGUWixIosyK09k1kElZcYsuxordgmyJDSwfk2/IRulvPX
	 Hxjydp5YM20nBK8viURlrZhTbqVuSnnKn6HWNRbbqUY4mVR6gZobLcT/aErgazPXHY
	 YPYrkRb7bjbaUglQewoS7eZLjj78H4a8oYQaY5dXSxOPer4j9TxlnOKLGL22u1Oto4
	 PnlgXjlseLTZXO9uXXcLjilJRWRtIBPpIr/8Cth/BE+FqClAcPYAJ/czyf77HfH3qF
	 Z8upYDGr+AkUIzL6eQzUt78/EyR+G1/IMU1pWZzEgOiN7CZRgjD1iGWV9nebvdGEKl
	 a9EVl0kYqBPxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Beata Michalska <beata.michalska@arm.com>
Subject: Re: [PATCH 5.15.y 1/2] arm64: errata: Factor out broken AMU const counter cap
Date: Wed,  7 Oct 2026 17:03:28 -0400
Message-ID: <2026-10-07-1-daily-reply-0011-arm64-a725-erratum-5-15@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006131507.2528032-1-beata.michalska@arm.com>
References: <20261006131507.2528032-1-beata.michalska@arm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Move the workaround from the erratum 2457168-specific cpucap to a generic
> broken AMU constant-counter one.

Queued the series for 5.15, thanks.

-- 
Thanks,
Sasha
